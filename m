Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74F8C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 04:24:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4598E20679
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 04:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TseiAhqo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4598E20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1katIn-00057N-9S
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 23:24:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1katHb-0003pD-Kp
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 23:23:27 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:45327)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1katHZ-0007rM-E2
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 23:23:27 -0500
Received: by mail-pl1-x641.google.com with SMTP id z1so65230plo.12
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 20:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=6Vj7rJ1HbGvjo2klZQHezr8aeMv8wuLNCnIvPj2MkoI=;
 b=TseiAhqoKYgO8RR7gIQ3TT92ssxzHbstXjcwYWFHww7aXSjgCECeQGa5L1orO2knHz
 cd21h03gy/Cnm8dkVVHjZEco6lgm2zLIE7ip1yO9BLq7uZthA7/7P8lYjcUEyz2RQ+6G
 Cm7Sw5QzZSlr9pVKG7u77qq/1jYbB5D+qIPp1JbgBOPVygpAqcWTWe4msowrqgEYaecd
 UnGih5Uc9C40nx55Bs4wmIsZ/DCfzgXv794urzVqiEl3/ol9EjPbjpy+Qumu7w48Wb3w
 fMGEd2Kmpe1ZmkwaTmoMRcz+FysvpeHRd3a3wdWmpPUVDl9ix0NKyMWjd0dExMeQ8i2J
 vWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=6Vj7rJ1HbGvjo2klZQHezr8aeMv8wuLNCnIvPj2MkoI=;
 b=YLqQQ5txzOKJbi/QCT6/ZfmGSd4nnQfW4lP+oqT8azQlz2PAgG/8zWM2pdjH04Qa01
 iZ9U5kFLrOf8eTtb7CyZMsENroQ238VMqF3yBGdFel1knsMIRGvBwXF2cPWHVewrLzPD
 w9hnWt92MnUJE04jkMFslVsXUv15hd/zOKg85HtvOzxu4GilpSMWRLmhyvvSOHiN6jO8
 3HvRUZbP+Yq6grPRPveNXtsehMU3o6xIqKWhBcBhO7EnH7JWZiJp/bvwzfEwezNYztUg
 4mMh76p9WbCq077P8b9bfw+lP+cmBbiyp+yanLv0NKsSERPXaejLbTXaM9d4FKHH2grU
 avyQ==
X-Gm-Message-State: AOAM530L8E0pO4ZvKIX0DqO5nxlKpnJ9gLhnIxkY8mIlwgnruzJR4NO4
 0V/+7Mj5vvPIRPf+5CamEMSNdV8GyGU4LA==
X-Google-Smtp-Source: ABdhPJygeNwn/B7P7Pb7mWhLIAe7CDTJZWzYzKfdTAvlnK7tirU2+udfJiHr1FGEbRLuYIFID6wYrw==
X-Received: by 2002:a17:902:7242:b029:d4:c719:79ce with SMTP id
 c2-20020a1709027242b02900d4c71979cemr280832pll.26.1604636602692; 
 Thu, 05 Nov 2020 20:23:22 -0800 (PST)
Received: from software.domain.org (111-252-196-15.dynamic-ip.hinet.net.
 [111.252.196.15])
 by smtp.gmail.com with ESMTPSA id y1sm262235pjl.12.2020.11.05.20.23.19
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 05 Nov 2020 20:23:22 -0800 (PST)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: [PATCH V17 6/6] docs/system: Update MIPS machine documentation
Date: Fri,  6 Nov 2020 12:21:50 +0800
Message-Id: <1604636510-8347-7-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1604636510-8347-1-git-send-email-chenhc@lemote.com>
References: <1604636510-8347-1-git-send-email-chenhc@lemote.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@gmail.com>, qemu-devel@nongnu.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Update MIPS machine documentation to add Loongson-3 based machine description.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 docs/system/target-mips.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/docs/system/target-mips.rst b/docs/system/target-mips.rst
index cd2a931..138441b 100644
--- a/docs/system/target-mips.rst
+++ b/docs/system/target-mips.rst
@@ -84,6 +84,16 @@ The Fuloong 2E emulation supports:
 
 -  RTL8139D as a network card chipset
 
+The Loongson-3 virtual platform emulation supports:
+
+-  Loongson 3A CPU
+
+-  LIOINTC as interrupt controller
+
+-  GPEX and virtio as peripheral devices
+
+-  Both KVM and TCG supported
+
 The mipssim pseudo board emulation provides an environment similar to
 what the proprietary MIPS emulator uses for running Linux. It supports:
 
-- 
2.7.0


