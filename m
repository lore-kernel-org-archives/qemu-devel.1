Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7222DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:23:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B0EB20825
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OX45/wVV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B0EB20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gyt-0003GK-Dy
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHv-000681-5Y
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:39:03 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:46192)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHt-0006M3-5L
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:39:02 -0400
Received: by mail-wr1-x42e.google.com with SMTP id r15so5345115wrp.13
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zCtt3wfDk2U6pD6XbYja2DKFOXpiv+tulHE30GporkU=;
 b=OX45/wVVCBCwZ+CM2yqcqglODCZFViwVW+FrqB8DpFQ5FItklX6/UjPZ7q7dIs57xk
 FVH8eWPeM0JOHeLVm364dwjRFlFSuW02dYpGjyOJUie/hbOv3+QmlOsgBW0BauK03ZJX
 W4VNW1hhNkZD8aMRkazwcx5r/65qgqMzKM+MVoEiYW6Rd+snSSwFKX5EhOIVChb29xyE
 Oup/f/KcFx3Q4JbOZP/PTMyMm+4eTs0LMVybtY/H/fogITEqc+fWLUBaJkfmi0pHQiLD
 KsxhomOuUywhQMTnpPRR/JoQ3L8vYJu1fdRa8YdDgfClGR8DVV6NSVUTmLpL7aKsf3jf
 rS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=zCtt3wfDk2U6pD6XbYja2DKFOXpiv+tulHE30GporkU=;
 b=ZqfWqRri8Kw94FaUerGT71NaZ0W3jGOeViC66YMQOYg2aR6U5fhoMHCfwWgpZ9CybH
 P7gwANUAMz90s9wDYAv21BBKIUj5/xeiK2kMx6rS4uLymnCBhwIEAWyyozWLfBDqp/Qi
 lG3RXR44tZMpVkQvx6biUYkw7npy73IuPAjrloDahKtqQcXxxFTHVBsfJgx8kpkaW7ez
 8y99okEoE7LhbmATb9hr1VZUuycJ4LCz587ObMWhoJz9eeiCT4kbmjWcoxLzdF+z0aa4
 Vn3gJ+T2iRIZsDRqusXqkrlCYfFOTc1LsZHy2LzehA0uO7q4J+qP3qV5gzDW2fo2PEyA
 ttYQ==
X-Gm-Message-State: AOAM532AkY2AqeWU85ib7DPsiKroGYJJIHzozMFGf0w/z8fiHljytvpV
 4x09Z8pNoABq/JSbKVFZL1hoK56DmtA=
X-Google-Smtp-Source: ABdhPJzhe2H+CHWwRPPA4Vj0oV5db7DsfWXq1axgN7whjG29e3cqYTRj3aZmlqE7VA/Hd4DXbgKB4w==
X-Received: by 2002:adf:efd2:: with SMTP id i18mr15259787wrp.32.1597675139496; 
 Mon, 17 Aug 2020 07:38:59 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.38.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:38:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 095/150] meson: convert hw/timer
Date: Mon, 17 Aug 2020 16:36:28 +0200
Message-Id: <20200817143723.343284-96-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x42e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/Makefile.objs       |  1 -
 hw/meson.build         |  1 +
 hw/timer/Makefile.objs | 41 -----------------------------------------
 hw/timer/meson.build   | 37 +++++++++++++++++++++++++++++++++++++
 4 files changed, 38 insertions(+), 42 deletions(-)
 delete mode 100644 hw/timer/Makefile.objs
 create mode 100644 hw/timer/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index f0e5728d13..70ecaa8135 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -28,7 +28,6 @@ devices-dirs-y += rtc/
 devices-dirs-$(CONFIG_SCSI) += scsi/
 devices-dirs-y += sd/
 devices-dirs-y += ssi/
-devices-dirs-y += timer/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/meson.build b/hw/meson.build
index 2ddf6bad33..50b26db852 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -3,6 +3,7 @@ subdir('mem')
 subdir('nubus')
 subdir('semihosting')
 subdir('smbios')
+subdir('timer')
 subdir('tpm')
 subdir('usb')
 subdir('vfio')
diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
deleted file mode 100644
index 1303b13e0d..0000000000
--- a/hw/timer/Makefile.objs
+++ /dev/null
@@ -1,41 +0,0 @@
-common-obj-$(CONFIG_ARM_TIMER) += arm_timer.o
-common-obj-$(CONFIG_ARM_MPTIMER) += arm_mptimer.o
-common-obj-$(CONFIG_ARM_V7M) += armv7m_systick.o
-common-obj-$(CONFIG_A9_GTIMER) += a9gtimer.o
-common-obj-$(CONFIG_CADENCE) += cadence_ttc.o
-common-obj-$(CONFIG_HPET) += hpet.o
-common-obj-$(CONFIG_I8254) += i8254_common.o i8254.o
-common-obj-$(CONFIG_PUV3) += puv3_ost.o
-common-obj-$(CONFIG_XILINX) += xilinx_timer.o
-common-obj-$(CONFIG_SLAVIO) += slavio_timer.o
-common-obj-$(CONFIG_ETRAXFS) += etraxfs_timer.o
-common-obj-$(CONFIG_GRLIB) += grlib_gptimer.o
-common-obj-$(CONFIG_IMX) += imx_epit.o
-common-obj-$(CONFIG_IMX) += imx_gpt.o
-common-obj-$(CONFIG_LM32) += lm32_timer.o
-common-obj-$(CONFIG_MILKYMIST) += milkymist-sysctl.o
-common-obj-$(CONFIG_NRF51_SOC) += nrf51_timer.o
-
-common-obj-$(CONFIG_ALTERA_TIMER) += altera_timer.o
-common-obj-$(CONFIG_EXYNOS4) += exynos4210_mct.o
-common-obj-$(CONFIG_EXYNOS4) += exynos4210_pwm.o
-common-obj-$(CONFIG_OMAP) += omap_gptimer.o
-common-obj-$(CONFIG_OMAP) += omap_synctimer.o
-common-obj-$(CONFIG_PXA2XX) += pxa2xx_timer.o
-common-obj-$(CONFIG_SH4) += sh_timer.o
-common-obj-$(CONFIG_RENESAS_TMR) += renesas_tmr.o
-common-obj-$(CONFIG_RENESAS_CMT) += renesas_cmt.o
-common-obj-$(CONFIG_DIGIC) += digic-timer.o
-common-obj-$(CONFIG_MIPS_CPS) += mips_gictimer.o
-
-common-obj-$(CONFIG_ALLWINNER_A10_PIT) += allwinner-a10-pit.o
-
-common-obj-$(CONFIG_STM32F2XX_TIMER) += stm32f2xx_timer.o
-common-obj-$(CONFIG_ASPEED_SOC) += aspeed_timer.o
-
-common-obj-$(CONFIG_CMSDK_APB_TIMER) += cmsdk-apb-timer.o
-common-obj-$(CONFIG_CMSDK_APB_DUALTIMER) += cmsdk-apb-dualtimer.o
-common-obj-$(CONFIG_MSF2) += mss-timer.o
-common-obj-$(CONFIG_RASPI) += bcm2835_systmr.o
-
-obj-$(CONFIG_AVR_TIMER16) += avr_timer16.o
diff --git a/hw/timer/meson.build b/hw/timer/meson.build
new file mode 100644
index 0000000000..9f0a267c83
--- /dev/null
+++ b/hw/timer/meson.build
@@ -0,0 +1,37 @@
+softmmu_ss.add(when: 'CONFIG_A9_GTIMER', if_true: files('a9gtimer.c'))
+softmmu_ss.add(when: 'CONFIG_ALLWINNER_A10_PIT', if_true: files('allwinner-a10-pit.c'))
+softmmu_ss.add(when: 'CONFIG_ALTERA_TIMER', if_true: files('altera_timer.c'))
+softmmu_ss.add(when: 'CONFIG_ARM_MPTIMER', if_true: files('arm_mptimer.c'))
+softmmu_ss.add(when: 'CONFIG_ARM_TIMER', if_true: files('arm_timer.c'))
+softmmu_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_systick.c'))
+softmmu_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_timer.c'))
+softmmu_ss.add(when: 'CONFIG_CADENCE', if_true: files('cadence_ttc.c'))
+softmmu_ss.add(when: 'CONFIG_CMSDK_APB_DUALTIMER', if_true: files('cmsdk-apb-dualtimer.c'))
+softmmu_ss.add(when: 'CONFIG_CMSDK_APB_TIMER', if_true: files('cmsdk-apb-timer.c'))
+softmmu_ss.add(when: 'CONFIG_RENESAS_TMR', if_true: files('renesas_tmr.c'))
+softmmu_ss.add(when: 'CONFIG_RENESAS_CMT', if_true: files('renesas_cmt.c'))
+softmmu_ss.add(when: 'CONFIG_DIGIC', if_true: files('digic-timer.c'))
+softmmu_ss.add(when: 'CONFIG_ETRAXFS', if_true: files('etraxfs_timer.c'))
+softmmu_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_mct.c'))
+softmmu_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_pwm.c'))
+softmmu_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_gptimer.c'))
+softmmu_ss.add(when: 'CONFIG_HPET', if_true: files('hpet.c'))
+softmmu_ss.add(when: 'CONFIG_I8254', if_true: files('i8254_common.c', 'i8254.c'))
+softmmu_ss.add(when: 'CONFIG_IMX', if_true: files('imx_epit.c'))
+softmmu_ss.add(when: 'CONFIG_IMX', if_true: files('imx_gpt.c'))
+softmmu_ss.add(when: 'CONFIG_LM32', if_true: files('lm32_timer.c'))
+softmmu_ss.add(when: 'CONFIG_MILKYMIST', if_true: files('milkymist-sysctl.c'))
+softmmu_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('mips_gictimer.c'))
+softmmu_ss.add(when: 'CONFIG_MSF2', if_true: files('mss-timer.c'))
+softmmu_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_timer.c'))
+softmmu_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_gptimer.c'))
+softmmu_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_synctimer.c'))
+softmmu_ss.add(when: 'CONFIG_PUV3', if_true: files('puv3_ost.c'))
+softmmu_ss.add(when: 'CONFIG_PXA2XX', if_true: files('pxa2xx_timer.c'))
+softmmu_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_systmr.c'))
+softmmu_ss.add(when: 'CONFIG_SH4', if_true: files('sh_timer.c'))
+softmmu_ss.add(when: 'CONFIG_SLAVIO', if_true: files('slavio_timer.c'))
+softmmu_ss.add(when: 'CONFIG_STM32F2XX_TIMER', if_true: files('stm32f2xx_timer.c'))
+softmmu_ss.add(when: 'CONFIG_XILINX', if_true: files('xilinx_timer.c'))
+
+specific_ss.add(when: 'CONFIG_AVR_TIMER16', if_true: files('avr_timer16.c'))
-- 
2.26.2



