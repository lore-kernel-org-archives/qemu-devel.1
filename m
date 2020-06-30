Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15D4C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:40:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D97D206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/FwrK+1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D97D206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqGVH-0003Bd-Sv
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 09:40:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqGTm-0000x5-KT; Tue, 30 Jun 2020 09:39:18 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:33743)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqGTl-0006HS-06; Tue, 30 Jun 2020 09:39:18 -0400
Received: by mail-ed1-x544.google.com with SMTP id h28so16264095edz.0;
 Tue, 30 Jun 2020 06:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZtgcwLm+oPvDM0rBUBUhyO6syjgVWMHkfRFyMuMRFYE=;
 b=P/FwrK+1UVNGCeVICJu5/7SglWlkTyCCwmetJThr6hOtcxZyCGEaYK+CQ5Nhtt8bt2
 JfOJiJGz/8EnoeDKomGX0OkKPUsIavwI1/78T5SSiudGusdps9FzMdqWvUdV/TA9uzlZ
 eWY0/bbQOBzQOXHM72O/uO3sp9QtOgiAcYxHbcaW+Q6SC+/YmZL8Giwu5k94gBXqSQ3w
 RCWxuSroMGAhq0M1QZomcKPdAFPenVszd7B255tArWRmnfph+It7A0GKUP7COABBhzgk
 s6Wb+aP7iZUDyIAe0tZHKdT2FSsRXSkFYZAraUj9e1GWuKGYMVFUbLfd3tV4F8mylgN2
 PidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ZtgcwLm+oPvDM0rBUBUhyO6syjgVWMHkfRFyMuMRFYE=;
 b=eEnhspZtM7O/57DuipXS0WO1V34PWFyGJKEPdLZ7IB/PpcaTBvAxE8FhAIAyXz92iS
 Ii/jTZWyeSt4UBXw3xnGbejSqx5zn6+gyYYn4QAATzAHfyfpxdyj49ttVUNWumPwijjL
 50gHqfHJMQpnhUOXFUeGkoUOtONWLwrWJMcHpLRL7Vq/OxmBH5Bc1sn2PaNIY958sXWE
 KbUAB5wbVMYBUVhUKnpLsIBV9ACKDPbgj9L2oSSOC0mR8z+0e2glx4rmm6RJum48XK9Y
 zByuOgEckqX/c0UvennsgZXbWjKZnxzn0Kmd7+E0EbEZtRSOpR7WBWmJhXhQaYkCmFOy
 EaGQ==
X-Gm-Message-State: AOAM533eAH6Iv4uKF+644M64fnPmdHnghPbET+NcYgI4NsOIboMkJyrW
 f0yR2dHfdVuYOb8hws7sNJ/nTXswFGg=
X-Google-Smtp-Source: ABdhPJzf7nvWDJABAhKUKdUHA08GVdth66pupbwNLNgVz4Sn2MmDwna31zvsuGBXSjTOaprlKLHRNA==
X-Received: by 2002:a50:d983:: with SMTP id w3mr22391545edj.110.1593524355004; 
 Tue, 30 Jun 2020 06:39:15 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id p18sm2099172ejm.55.2020.06.30.06.39.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 06:39:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 01/17] MAINTAINERS: Cc qemu-block mailing list
Date: Tue, 30 Jun 2020 15:38:55 +0200
Message-Id: <20200630133912.9428-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200630133912.9428-1-f4bug@amsat.org>
References: <20200630133912.9428-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

We forgot to include the qemu-block mailing list while adding
this section in commit 076a0fc32a7. Fix this.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dec252f38b..9ad876c4a7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1628,6 +1628,7 @@ F: hw/ssi/xilinx_*
 
 SD (Secure Card)
 M: Philippe Mathieu-Daudé <f4bug@amsat.org>
+L: qemu-block@nongnu.org
 S: Odd Fixes
 F: include/hw/sd/sd*
 F: hw/sd/core.c
-- 
2.21.3


