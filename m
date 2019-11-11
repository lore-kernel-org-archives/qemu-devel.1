Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854FFC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 13:59:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 517852067B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 13:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V5/q5MqD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 517852067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUAE1-0000v0-CC
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 08:59:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49551)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iUACp-00084w-Ri
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 08:58:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iUACo-0006N7-JU
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 08:58:11 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:54801)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iUACo-0006Mj-CP
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 08:58:10 -0500
Received: by mail-wm1-x335.google.com with SMTP id z26so13411646wmi.4
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2019 05:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=zqttdI7AYiMTfwfogd55wTlfq+dMx85ZrMiofI4wvOY=;
 b=V5/q5MqDtIhQ56BGbul2DWkfEKmAnpB77XmmcGVCoi6qWus2BSKFZSDqDc4NPequLU
 5+UgSRInOolONuJCZhgTHWwFl8gVI1E9YFi8tkcv+kLFv0kGj5aU/UqzrH7ZtO7fzg5e
 hjU3x9tSM936ftznbvXPVvGUXqwjhuALZpoMfnk7NECohGIRDZDYQHivCLzANvDSWmCi
 FZBFaALAM2PBjjrdZjq5/leg4sRxBDuLHFnJysGI39El/awHVurPo8lqc2MPaf7gGu7s
 DTGfd9QKXHvVBImqz0aDw/sXH8coiqgeT6bCwV34OwOOFC7bQuqjXLGrzSIi8B/gtMXj
 u9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zqttdI7AYiMTfwfogd55wTlfq+dMx85ZrMiofI4wvOY=;
 b=S4rYAbLqNRfvArypIDDXx6X/WqkOtjR4e25h2TVxlMNJIrZJ/8Z/kLz7cv6yQ/OxJe
 X6uJ45NoD8WEitadBf+NwQkpUcg7830GJzIwik3LX6AfWDXjqQ27uQhoqXbFWg02KrOc
 rDK4U1dMrKEdOKL2brSQPb5PluT+RDzdGlwbZfTuPWoJWyhyvaKjc+VixkbhdX2XSJhb
 m3S9TO7dDEU46m95rFMbEBlaBFoDq5lWE6JCPTvrdWQO4DQnevG+JFS7UbdQPjvh4OoW
 Lu3/D7szgjmerYJLCyjs3A2r3HdFGJ4oIPE+Gvfra4vZhdxYTRNE15urcjhxzOiccwwX
 pajQ==
X-Gm-Message-State: APjAAAUlbJlmvaoOgp0oNM/b2XEHrtobWpx8cnwZdBDdruHt1AcN+57i
 zmeavSqGTieNVW4GCgyfkQOhdElbGjxS8w==
X-Google-Smtp-Source: APXvYqyxitSiY3LOufKhct/EjWOoajvtMELGfY7apcIS83zNV6WPMGdf8DB75l+Wiytg4qVvH6W49Q==
X-Received: by 2002:a05:600c:c5:: with SMTP id
 u5mr19772610wmm.35.1573480689034; 
 Mon, 11 Nov 2019 05:58:09 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t29sm20544857wrb.53.2019.11.11.05.58.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2019 05:58:08 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 3/3] hw/arm/boot: Set NSACR.{CP11,
 CP10} in dummy SMC setup routine
Date: Mon, 11 Nov 2019 13:58:03 +0000
Message-Id: <20191111135803.14414-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191111135803.14414-1-peter.maydell@linaro.org>
References: <20191111135803.14414-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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

From: Clement Deschamps <clement.deschamps@greensocs.com>

The boot.c code usually puts the CPU into NS mode directly when it is
booting a kernel.  Since fc1120a7f5f2d4b6 this has included a
requirement to set NSACR to give NS state access to the FPU; we fixed
that for the usual code path in ece628fcf6.  However, it is also
possible for a board model to request an alternative mode of booting,
where its 'board_setup' code hook runs in Secure state and is
responsible for doing the S->NS transition after it has done whatever
work it must do in Secure state.  In this situation the board_setup
code now also needs to update NSACR.

This affects all boards which set info->secure_board_setup, which is
currently the 'raspi' and 'highbank' families.  They both use the
common arm_write_secure_board_setup_dummy_smc().

Set the NSACR CP11 and CP10 bits in the code written by that
function, to allow FPU access in Non-Secure state when using dummy
SMC setup routine.  Otherwise an AArch32 kernel booted on the
highbank or raspi boards will UNDEF as soon as it tries to use the
FPU.

Update the comment describing secure_board_setup to note the new
requirements on users of it.

This fixes a kernel panic when booting raspbian on raspi2.

Successfully tested with:
  2017-01-11-raspbian-jessie-lite.img
  2018-11-13-raspbian-stretch-lite.img
  2019-07-10-raspbian-buster-lite.img

Fixes: fc1120a7f5
Signed-off-by: Clement Deschamps <clement.deschamps@greensocs.com>
Tested-by: Laurent Bonnans <laurent.bonnans@here.com>
Message-id: 20191104151137.81931-1-clement.deschamps@greensocs.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: updated comment to boot.h to note new requirement on
 users of secure_board_setup; edited/rewrote commit message]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/boot.h | 7 +++++--
 hw/arm/boot.c         | 3 +++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/hw/arm/boot.h b/include/hw/arm/boot.h
index 7f4d0ca7cdf..ce2b48b88bc 100644
--- a/include/hw/arm/boot.h
+++ b/include/hw/arm/boot.h
@@ -107,9 +107,12 @@ struct arm_boot_info {
     void (*write_board_setup)(ARMCPU *cpu,
                               const struct arm_boot_info *info);
 
-    /* If set, the board specific loader/setup blob will be run from secure
+    /*
+     * If set, the board specific loader/setup blob will be run from secure
      * mode, regardless of secure_boot. The blob becomes responsible for
-     * changing to non-secure state if implementing a non-secure boot
+     * changing to non-secure state if implementing a non-secure boot,
+     * including setting up EL3/Secure registers such as the NSACR as
+     * required by the Linux booting ABI before the switch to non-secure.
      */
     bool secure_board_setup;
 
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index ef6724960c0..8fb4a63606f 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -240,6 +240,9 @@ void arm_write_secure_board_setup_dummy_smc(ARMCPU *cpu,
     };
     uint32_t board_setup_blob[] = {
         /* board setup addr */
+        0xee110f51, /* mrc     p15, 0, r0, c1, c1, 2  ;read NSACR */
+        0xe3800b03, /* orr     r0, #0xc00             ;set CP11, CP10 */
+        0xee010f51, /* mcr     p15, 0, r0, c1, c1, 2  ;write NSACR */
         0xe3a00e00 + (mvbar_addr >> 4), /* mov r0, #mvbar_addr */
         0xee0c0f30, /* mcr     p15, 0, r0, c12, c0, 1 ;set MVBAR */
         0xee110f11, /* mrc     p15, 0, r0, c1 , c1, 0 ;read SCR */
-- 
2.20.1


