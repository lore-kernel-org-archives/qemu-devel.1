Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE29C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 14:37:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 624F9205C9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 14:37:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 624F9205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgrzq-0000tj-LH
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 10:37:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33590)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jdillama@redhat.com>) id 1hgrLP-000324-BF
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 09:55:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jdillama@redhat.com>) id 1hgrLO-0004Nm-Fz
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 09:55:15 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42275)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jdillama@redhat.com>) id 1hgrLO-0004NN-CC
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 09:55:14 -0400
Received: by mail-qk1-f194.google.com with SMTP id b18so4836548qkc.9
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 06:55:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/1Y4fNLaIkF25Y9QPQxd9rwtMpLAq+tObkHK36PZtR4=;
 b=YDUpgJIVObipy7CYgNvIjqqtVX1UKyZ1qyFHp/R5sfUXbOTBR1H+Jq6A1BbQ+k0ZlB
 rEq3DxhgGQ8GNE6z7jOMAPvfflLYgFxDtBrTUTd379V0I8CPCx0tvT+XU1YdYTkeqfRq
 ooCPtOXtU53tcJ9LkgtC5HY6U8MVTD5sU+W4MuuovvQdsqXuCjZa+qkAKnmww26bCmxn
 kRym+xV+87ln7g2lvh0MN6nCvgdRwCVvCpL8Zc9ISq/ZYZi0QRyVoi/0MrSBzOBr5gK+
 N3PBgdiM0m92wg2bUQd//WMvI1FeYCeWv8Vopa6txWjsgle967e/Vo8vEkfg0pdHH8ar
 HQcg==
X-Gm-Message-State: APjAAAVRLzAoxLv7z17oeSTRpxk5pC0sPR9ZxzLgXiR+cCkgg/pDF9IE
 FImTlJfmENDp8wGU8TqsHjQh8g==
X-Google-Smtp-Source: APXvYqx6VYzEzUhR1BCUPs6/dUBysbMDU/owiNPRdzJfbdjCAsibJEnY11XMF8KF5paXartsna/LLQ==
X-Received: by 2002:a37:97c5:: with SMTP id z188mr9144409qkd.5.1561730113643; 
 Fri, 28 Jun 2019 06:55:13 -0700 (PDT)
Received: from cube-1.lan (pool-96-241-25-63.washdc.fios.verizon.net.
 [96.241.25.63])
 by smtp.gmail.com with ESMTPSA id k33sm1014669qte.69.2019.06.28.06.55.12
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 28 Jun 2019 06:55:12 -0700 (PDT)
From: jdillama@redhat.com
X-Google-Original-From: dillaman@redhat.com
To: jdurgin@redhat.com, kwolf@redhat.com, mreitz@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Date: Fri, 28 Jun 2019 09:55:08 -0400
Message-Id: <20190628135508.8013-1-dillaman@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.222.194
X-Mailman-Approved-At: Fri, 28 Jun 2019 10:32:09 -0400
Subject: [Qemu-devel] [PATCH] MAINTAINERS: update RBD block maintainer
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
Cc: Jason Dillaman <dillaman@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jason Dillaman <dillaman@redhat.com>

Remove Josh as per his request since he is no longer the upstream RBD
tech lead. Add myself as the maintainer since I am the current RBD tech
lead.

Signed-off-by: Jason Dillaman <dillaman@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cad58b9487..47694cd02f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2367,7 +2367,7 @@ S: Supported
 F: block/vmdk.c
 
 RBD
-M: Josh Durgin <jdurgin@redhat.com>
+M: Jason Dillaman <dillaman@redhat.com>
 L: qemu-block@nongnu.org
 S: Supported
 F: block/rbd.c
-- 
2.21.0


