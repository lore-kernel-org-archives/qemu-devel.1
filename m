Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6C5C31E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:46:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C25B20833
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OmMLXmPv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C25B20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48140 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcstn-0006NV-Kd
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 10:46:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46586)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hcsiF-0003Rk-Tc
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hcsiE-0007zn-8l
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:23 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:36934)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hcsiE-0007vV-02
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:22 -0400
Received: by mail-wm1-x32c.google.com with SMTP id f17so6863964wme.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 07:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Dm/P19Ro04eg/uCkKl02ziWtle1UzjZ0dZGp6K+sSK8=;
 b=OmMLXmPvqVov92owYtQg8o1k6HaqxWqBZ27CHunn865KOLqtbDz0F13dpliX+jRsiu
 w2NeiuBGuJJCNSOFCa9bN0N1k9sHCEIQGHCpPzyoVNBcQIfWVUvnDsUdixU4iJDTUwmi
 cdk0rNSsuP1UhLwVO6YV+SOYIwEX8b2+5JP/pbyyQr/6FGZi3UKco/jlHXUSqsqRIPgW
 /HwYgZ4L5/5YIZggYCF875+ryR/A7y23oKLKZnMXXy205nQLkCT3RA36/9OI5j8yczzL
 xT1caZqyUgCJ5BgytE5/Ib0WQs0PMIOAxtY/OAxV3vRZwJPr13alpzPBKcZOhMFPcrar
 UF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Dm/P19Ro04eg/uCkKl02ziWtle1UzjZ0dZGp6K+sSK8=;
 b=e+8NOt5Ov7v+pKsFFBQ5NR1d3neZZxi9LjdIK0MgP0MaIgDWFMn0GYKtG4v+3wnVZJ
 tEk8VfUPcKjnMSEVB+2joKfojzFQzV2tm/7z30PikauisVv4+Ea3a02vHORmsMkkKwio
 gxSlfpZs/WMHTUsPLa1zSwX7+0ctOA0qpcwBZvyULjZ0YseZ0R5MVco/qyp2zEhzc4Wo
 VN9XA1Tc9Edsi46TXdjBY6+7Xu6Bekc7x15gVO0DN4rmXc3S+fqF7JgvnTr7P3/7dWtp
 m2d8arygds0NxEdiGagARQpYmFPockx8Kc9Xbzr0RmhGNv5AAik0dG274064DeHsz6i7
 5ESw==
X-Gm-Message-State: APjAAAW1GxcLOER/Qn9jdXcQZ5TWuEA8sX58LlJT1R1Mf1IeuqH9NhXb
 AVhu3YMo34BCzSBYfK6JVFyQ5u58JYKocg==
X-Google-Smtp-Source: APXvYqzCd8uWSQRIXpUMr+u/YfrvPK2jMWuhjMsh97qxhZ0UfCaoqvV1FYMQ0J/92o4sx75IXtYzog==
X-Received: by 2002:a7b:c94a:: with SMTP id i10mr18578060wml.97.1560782054577; 
 Mon, 17 Jun 2019 07:34:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a67sm13819985wmh.40.2019.06.17.07.34.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 07:34:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 15:33:48 +0100
Message-Id: <20190617143412.5734-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
Subject: [Qemu-devel] [PULL 00/24] target-arm queue
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

Latest arm queue, half minor code cleanups and half minor
bug fixes.

-- PMM

The following changes since commit 5d0e5694470d2952b4f257bc985cac8c89b4fd92:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2019-06-17 11:55:14 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20190617

for you to fetch changes up to 1120827fa182f0e76226df7ffe7a86598d1df54f:

  target/arm: Only implement doubles if the FPU supports them (2019-06-17 15:15:06 +0100)

----------------------------------------------------------------
target-arm queue:
 * support large kernel images in bootloader (by avoiding
   putting the initrd over the top of them)
 * correctly disable FPU/DSP in the CPU for the mps2-an521, musca-a boards
 * arm_gicv3: Fix decoding of ID register range
 * arm_gicv3: GICD_TYPER.SecurityExtn is RAZ if GICD_CTLR.DS == 1
 * some code cleanups following on from the VFP decodetree conversion
 * Only implement doubles if the FPU supports them
   (so we now correctly model Cortex-M4, -M33 as single precision only)

----------------------------------------------------------------
Peter Maydell (24):
      hw/arm/boot: Don't assume RAM starts at address zero
      hw/arm/boot: Diagnose layouts that put initrd or DTB off the end of RAM
      hw/arm/boot: Avoid placing the initrd on top of the kernel
      hw/arm/boot: Honour image size field in AArch64 Image format kernels
      target/arm: Allow VFP and Neon to be disabled via a CPU property
      target/arm: Allow M-profile CPUs to disable the DSP extension via CPU property
      hw/arm/armv7m: Forward "vfp" and "dsp" properties to CPU
      hw/arm: Correctly disable FPU/DSP for some ARMSSE-based boards
      hw/intc/arm_gicv3: Fix decoding of ID register range
      hw/intc/arm_gicv3: GICD_TYPER.SecurityExtn is RAZ if GICD_CTLR.DS == 1
      target/arm: Move vfp_expand_imm() to translate.[ch]
      target/arm: Use vfp_expand_imm() for AArch32 VFP VMOV_imm
      target/arm: Stop using cpu_F0s for NEON_2RM_VABS_F
      target/arm: Stop using cpu_F0s for NEON_2RM_VNEG_F
      target/arm: Stop using cpu_F0s for NEON_2RM_VRINT*
      target/arm: Stop using cpu_F0s for NEON_2RM_VCVT[ANPM][US]
      target/arm: Stop using cpu_F0s for NEON_2RM_VRECPE_F and NEON_2RM_VRSQRTE_F
      target/arm: Stop using cpu_F0s for Neon f32/s32 VCVT
      target/arm: Stop using cpu_F0s in Neon VCVT fixed-point ops
      target/arm: stop using deprecated functions in NEON_2RM_VCVT_F16_F32
      target/arm: Stop using deprecated functions in NEON_2RM_VCVT_F32_F16
      target/arm: Remove unused cpu_F0s, cpu_F0d, cpu_F1s, cpu_F1d
      target/arm: Fix typos in trans function prototypes
      target/arm: Only implement doubles if the FPU supports them

 include/hw/arm/armsse.h        |   7 ++
 include/hw/arm/armv7m.h        |   4 +
 target/arm/cpu.h               |  12 +++
 target/arm/translate-a64.h     |   1 -
 target/arm/translate.h         |   7 ++
 hw/arm/armsse.c                |  58 +++++++---
 hw/arm/armv7m.c                |  18 ++++
 hw/arm/boot.c                  |  83 ++++++++++----
 hw/arm/musca.c                 |   8 ++
 hw/intc/arm_gicv3_dist.c       |  12 ++-
 hw/intc/arm_gicv3_redist.c     |   4 +-
 target/arm/cpu.c               | 179 ++++++++++++++++++++++++++++--
 target/arm/translate-a64.c     |  32 ------
 target/arm/translate-vfp.inc.c | 173 ++++++++++++++++++++++-------
 target/arm/translate.c         | 240 ++++++++++++++---------------------------
 target/arm/vfp.decode          |  10 +-
 16 files changed, 572 insertions(+), 276 deletions(-)

