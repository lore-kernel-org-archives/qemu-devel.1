Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4928DC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:50:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16700204FD
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKO2nWzV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16700204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gTC-0002JO-5y
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 10:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGt-00048B-VQ
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:37:59 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33796)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGs-00065m-BX
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:37:59 -0400
Received: by mail-wr1-x444.google.com with SMTP id f7so15275154wrw.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+r6q9fJAOZFBMvVsJ4cL4RUbvyuHLisZKU9ps+vESG8=;
 b=UKO2nWzVjB0n8C9RMWBpI88enFHuLCILQUZh8tPzvLG7AL83DtlEIggXXRKh6J1DC7
 qGnc6iUPLMbHeGZKtQLCIugBrsspkTTzb/5Knn0uSkCAryYSwIZ82u/4rN0eh+yIENEw
 Me674FYP4CuCPooQfNu1veGnf5jWSKslCJoWkU+6Osz0tZPW/UAuWfVDlWz+V9EV9qXd
 TR9IMMzhB4tWoOPG8dlwrNwoqHst1xOCLKgf/UMOTx8vJyO39MOERu3xDWt9czfAetuy
 4xzzjKDEZtuvNdX9xroxeIGbKK+WCw+HeWHvv8crdbD348cW1zHLt8X8YRp0mvr3xCYf
 hvcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=+r6q9fJAOZFBMvVsJ4cL4RUbvyuHLisZKU9ps+vESG8=;
 b=Ji2/DyT26tDgcRb9as98cgR0uK/wWMoUEhsONxgO9i0ZDemtNqlRAzrNoEBThMos2M
 CLj4Z4mK8+B53ffOzFjCUn1sT8/cGCj/QhHsGK8qNp6LJL68Ynx1j7NoILE64NHrUwZb
 iu1vZfC1SltAs5WupPtzqystpocSJ7bD/MeL/ZBEbnAIAyDOdpDF8UNDGBMkHxa6dQ3m
 +xv6RBPJmXpFvOrCIwxqTfvCX7yzpPfv3TpQagwBc39bZBITFFgCx9hXfgu4Ycg4EKoc
 ij7Yya2hqoaJfR0Ck+lUg8JGhZClOEZUVrKn84uToh1zj59NPLeHc4UDuIdx+BBpSnPH
 ieyg==
X-Gm-Message-State: AOAM530V+mBIrAywoFG32nE/PZ2pjkRkdAbcfacOBuzE55nVTUJkbUoX
 mq70XJMtBotfAJ9Lb8K7KgX4YTqmznY=
X-Google-Smtp-Source: ABdhPJzYMGUDwzkzrvi185goth5P2sADxJa3WCsWZAj/SAo2NJgEY0aZCjyI0ufbFWnE1lJ6hp4lQQ==
X-Received: by 2002:adf:fd41:: with SMTP id h1mr16840874wrs.124.1597675076741; 
 Mon, 17 Aug 2020 07:37:56 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.37.55 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:37:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 030/150] vhost-user-scsi: add compatibility for libiscsi 1.9.0
Date: Mon, 17 Aug 2020 16:35:23 +0200
Message-Id: <20200817143723.343284-31-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 contrib/vhost-user-scsi/vhost-user-scsi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-user-scsi/vhost-user-scsi.c
index 7a1db164c8..3c912384e9 100644
--- a/contrib/vhost-user-scsi/vhost-user-scsi.c
+++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
@@ -12,7 +12,9 @@
 
 #include "qemu/osdep.h"
 #include <iscsi/iscsi.h>
+#define inline __attribute__((gnu_inline))  /* required for libiscsi v1.9.0 */
 #include <iscsi/scsi-lowlevel.h>
+#undef inline
 #include "contrib/libvhost-user/libvhost-user-glib.h"
 #include "standard-headers/linux/virtio_scsi.h"
 
-- 
2.26.2



