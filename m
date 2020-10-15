Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70087C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 06:44:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B36BE21D7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 06:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5UXa09N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B36BE21D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSx0R-0001uQ-Dg
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 02:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSwue-0005RQ-J1; Thu, 15 Oct 2020 02:38:58 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54050)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSwuc-0006yM-S7; Thu, 15 Oct 2020 02:38:56 -0400
Received: by mail-wm1-x344.google.com with SMTP id f21so1905702wml.3;
 Wed, 14 Oct 2020 23:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UJjk8ZR/erxbnrLQ53sw18LTpiI4+fnfSdMDknbc4K0=;
 b=O5UXa09NEfYJfcImEuemyGqUnXpyOXPrGZvcGlJbRUsHzHDDuyZ54+7g+4TdMaFBVG
 kKjcT5xlrRvcXqb4v0a6jwmtcEknr1pVQypZ28Nh0rbHe/3N83yrO2SRgFfBrUjRiHHV
 xoKD0Jr0fAAv9+fMqiarjjhocm+F0jAaLWncNhUtwV63WgVTAM7bNuV9dy5I5FpMXBTf
 q8F3I4Xe3WUszN4Z8PXMb0jUNqTKt7xRuj5EG2+ddmq11+Oj7SSmL+FuN68yx6S0+EB9
 mwkWleqb775wsF1ImwoiowrtSFKP8LYmc5qAUiikbfkPYBd9xtDuVRCvR4wY/LdbO4Cy
 dsAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=UJjk8ZR/erxbnrLQ53sw18LTpiI4+fnfSdMDknbc4K0=;
 b=fVafJEtmQzqgvHEaN32krvGgvauIiekDgXt4CCNteAVSkKhzbh1/imcVZyFlsAMgbD
 JGvt15650q0SCV7Ur4TDrdaoGjmibgBTIt98mJgE2XJdQH2QfaRzQ80+MZWrUZ5Ah40b
 eKOXbJ64+cO+JuXIrYUKCWESh8Kp8zEHh4HOYZHMCYZv+dFXBSv/E5aln2po0hhOm9Jv
 cNtNTEjxKgIjxgg/ntEJImh8fJwQqK6XADc/D3PzkqVzztiPdWunSN4CjRpG5m+nkCMf
 gpsg3vyrebLvqBsWeu1GQ0b1VRn3B7FT6XOp+kZqXyNt/rwBfu6097eg2Ev4Jgj3RYPN
 kW1Q==
X-Gm-Message-State: AOAM533lT0FiQnvs3xxch3xK8pz7uHBMEMuN6rxUC/CF7sJNEJPXJydk
 5lxzqmkBmWQCCfjbhUT3AEuarcZnbKI=
X-Google-Smtp-Source: ABdhPJzTLT6eSvDGf74DbI2sZzb3HcpC0qiGelwbiKnDK9Cg0dtKAfBpyuqXNGakY2meFEjW/IJWUQ==
X-Received: by 2002:a1c:20d0:: with SMTP id g199mr2444658wmg.38.1602743929352; 
 Wed, 14 Oct 2020 23:38:49 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id n9sm2923152wrq.72.2020.10.14.23.38.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 23:38:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/6] hw/sd/sdcard: Do not attempt to erase out of range
 addresses
Date: Thu, 15 Oct 2020 08:38:23 +0200
Message-Id: <20201015063824.212980-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201015063824.212980-1-f4bug@amsat.org>
References: <20201015063824.212980-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While the Spec v3 is not very clear, v6 states:

  If the host provides an out of range address as an argument
  to CMD32 or CMD33, the card shall indicate OUT_OF_RANGE error
  in R1 (ERX) for CMD38.

If an address is out of range, do not attempt to erase it:
return R1 with the error bit set.

Buglink: https://bugs.launchpad.net/bugs/1895310
Reported-by: Alexander Bulekov <alxndr@bu.edu>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index ee7b64023aa..4454d168e2f 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -766,6 +766,13 @@ static void sd_erase(SDState *sd)
         erase_end *= 512;
     }
 
+    if (sd->erase_start > sd->size || sd->erase_end > sd->size) {
+        sd->card_status |= OUT_OF_RANGE;
+        sd->erase_start = INVALID_ADDRESS;
+        sd->erase_end = INVALID_ADDRESS;
+        return;
+    }
+
     erase_start = sd_addr_to_wpnum(erase_start);
     erase_end = sd_addr_to_wpnum(erase_end);
     sd->erase_start = INVALID_ADDRESS;
-- 
2.26.2


