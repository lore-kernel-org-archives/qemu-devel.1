Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BC4C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 11:50:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 682E2216C4
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 11:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mQlHJ0ZV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 682E2216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZupv-0004FQ-AF
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 06:50:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZuoW-0002vB-RC
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 06:49:24 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40828)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZuoU-00066g-FJ
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 06:49:24 -0500
Received: by mail-wm1-x342.google.com with SMTP id k18so12467621wmj.5
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 03:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wfH8DgLEFheGCm4+olyiLAtiHOfKuRbs7i/BAfcD97k=;
 b=mQlHJ0ZVCrHI4+FIfMriWgpSqi9oa6av7TdSdACHbdQ9V7wT0rcqU1uC6i46yqW1dE
 jvstVaLblrNgAs8uJvATMo6XWWqPMCyXOOgjY/y/d3zjjlXBLjzy02Cj5Qa99PkXDkSl
 tm2C1YEiHIBqfay0EEHfsOFgviAUkdZsWzYfa9HJNH71qmR+9Mhi2on7vpRCT8Wa2SON
 0bLC9d6pxzV3f9uu9byfDInrWOK9hbGY/cRh6Icyc1UJUaoU8lLAtsBWCxxeHt2MIEAf
 zQZyST9WXFldjHcQJG0kO22O18Z6/krHLDBO9N3f/RwuHoMvT1PKFH4LXPjobtU7XQjE
 CkSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wfH8DgLEFheGCm4+olyiLAtiHOfKuRbs7i/BAfcD97k=;
 b=sGhs+0Toh9ZFJhfMlIc8ryK0z3BET1AxFDuNgGiWkaARkDcCwn2eZaRp+LKZcJvkct
 nKZnonCM/p4DEcRB44zMg1LN/J946lgmRa24PjipFSkLapII7iszm80RyLfob2R46rNM
 JXsG0me7rgguO+ejWLClr8MkmoS9feGOJgwAvlNgM6pfK0OOJDIvVD8VDHd+6iuV/NdG
 KEzQeDyANY/VkggR8Kz/pZeBgVtciEgv4UsHzGz4FSIxcXjirQmUrbIj6oJJo8RbtXKB
 bXTAkdNKu8+6CnioHGZ2bbLGc2/y3YnysAUMk2dNwWugZjHKqqTwPvqGHWzPJOoZjfEx
 p9Yw==
X-Gm-Message-State: AOAM530xv0ajAArg1zS8hp4juz0od5N0kj89WJCAPihEgTBBsUrXFKGn
 RUyivwj3qHcBPeG9+smYfXpyPw==
X-Google-Smtp-Source: ABdhPJz3ZDq5OSsOTEiEjkvjHJKKHoE5PnKWGsNqPRGwbAm9/gTyglWH6IpF0uKaFUaNR/2MbmpNwg==
X-Received: by 2002:a7b:c101:: with SMTP id w1mr3163253wmi.170.1604404160956; 
 Tue, 03 Nov 2020 03:49:20 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id f13sm26434215wrp.12.2020.11.03.03.49.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 03:49:20 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] hw/arm/nseries: Check return value from load_image_targphys()
Date: Tue,  3 Nov 2020 11:49:18 +0000
Message-Id: <20201103114918.11807-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The nseries machines have a codepath that allows them to load a
secondary bootloader.  This code wasn't checking that the
load_image_targphys() succeeded.  Check the return value and report
the error to the user.

While we're in the vicinity, fix the comment style of the
comment documenting what this image load is doing.

Fixes: Coverity CID 1192904
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/nseries.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
index 76fd7fe9854..d49852c60d7 100644
--- a/hw/arm/nseries.c
+++ b/hw/arm/nseries.c
@@ -1380,7 +1380,8 @@ static void n8x0_init(MachineState *machine,
         /* No, wait, better start at the ROM.  */
         s->mpu->cpu->env.regs[15] = OMAP2_Q2_BASE + 0x400000;
 
-        /* This is intended for loading the `secondary.bin' program from
+        /*
+         * This is intended for loading the `secondary.bin' program from
          * Nokia images (the NOLO bootloader).  The entry point seems
          * to be at OMAP2_Q2_BASE + 0x400000.
          *
@@ -1388,9 +1389,15 @@ static void n8x0_init(MachineState *machine,
          * for them the entry point needs to be set to OMAP2_SRAM_BASE.
          *
          * The code above is for loading the `zImage' file from Nokia
-         * images.  */
-        load_image_targphys(option_rom[0].name, OMAP2_Q2_BASE + 0x400000,
-                            machine->ram_size - 0x400000);
+         * images.
+         */
+        if (load_image_targphys(option_rom[0].name,
+                                OMAP2_Q2_BASE + 0x400000,
+                                machine->ram_size - 0x400000) < 0) {
+            error_report("Failed to load secondary bootloader %s",
+                         option_rom[0].name);
+            exit(EXIT_FAILURE);
+        }
 
         n800_setup_nolo_tags(nolo_tags);
         cpu_physical_memory_write(OMAP2_SRAM_BASE, nolo_tags, 0x10000);
-- 
2.20.1


