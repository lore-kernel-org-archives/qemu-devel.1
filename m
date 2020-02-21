Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EAEC35656
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 16:20:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2B0E2073A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 16:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XnoaEnRC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2B0E2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5B2d-0001if-SS
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 11:20:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45853)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j5B0d-0000Qb-VR
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:18:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j5B0c-00021H-7Y
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:18:35 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:56226)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j5B0b-00020x-VP
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:18:34 -0500
Received: by mail-wm1-x331.google.com with SMTP id q9so2357538wmj.5
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 08:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=o12rlLRzlZZ6514VAo2M2WqeUWmqDbsn0zieNMqS1p4=;
 b=XnoaEnRCQp3wzeNTbpx2ladLXcWt8k6SAwwB43zI9u3bqy+rVHhZcZ7kcFISFPkyjA
 m6htQjQHpoomdJIlNVmSr6BoH54G9Ix3QqY45LL+GS6Uw1tmUP4d/TTGwk9RSrTnWfup
 yciQ2MX+K0caWutWBU+8k+mvJGs+6Ev90U7YqR0dfzH59g8VihSi78AIiq7b1mIbAkAs
 BKzwa0nMCRz8Eu431bSXxGQf6ffM/iHGDIK3DUKIxX1cTuvzneUjkUQ9YeCHP4KYispj
 sB6oU7lcIYA5w6cQB//vRRIndKJG9gsyWIbeCvOCoEc9nzP+KJRgaRFPipTCxT/58Z4o
 tZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=o12rlLRzlZZ6514VAo2M2WqeUWmqDbsn0zieNMqS1p4=;
 b=O5AYNsHOuYR99mPLutOKhQ3TxgdYyFnRxI5BGRISwsDZUMkoU6iWvSLlCmKpuxIaky
 0zHZKS/PblA3xz9gRt2qQO0rGK5yaNsOh0P1C+Hy1ayN6mIDTNoU061YWK/zQBpIe6t6
 fIsb+Wz2CBf19JH6SzA+67onkKodrEv/f1FqCufZKWJU9RfhHMpEk5UFsnYCY0WPll0d
 o1EJHJmHBmOBl2TgxtOtBPy5S1tZf1DO/AzFOhrkPQ2iMBZ6A8Zx2rnNaUKnKNM57wfA
 oYfMvA1leQ44dx2HlopTg3iAPSvUfDF+AmRAuDWDYoiB4wsluuE0Dp3BRbDKg3ZJbPxl
 Kw5w==
X-Gm-Message-State: APjAAAXK8qkpyXbMgwFVMBv+dsc3iIxEDDqV8mOXg2K2qmkDyIJSwvMx
 OcPSGiCVdXf3SWmcJX7rBA6rt1GWDXeHgg==
X-Google-Smtp-Source: APXvYqzCF93OL7gbK9+yDEu+KzJw2nnJj/WkA5nDfSdpF81QcLwVCog3FYBGVwP9jQz4v2Ghf6WWGg==
X-Received: by 2002:a1c:4d03:: with SMTP id o3mr4514252wmh.164.1582301912299; 
 Fri, 21 Feb 2020 08:18:32 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id g17sm4849616wru.13.2020.02.21.08.18.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 08:18:31 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/46] target-arm queue
Date: Fri, 21 Feb 2020 16:18:29 +0000
Message-Id: <20200221161829.17142-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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

v1->v2 changes: dropped the last 6 patches from rth as there's
a problem with one of them that's too complicated to try to
fix up.

thanks
-- PMM

The following changes since commit a8c6af67e1e8d460e2c6e87070807e0a02c0fec2:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-5.0-20200221' into staging (2020-02-21 14:20:42 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200221-1

for you to fetch changes up to 9eb4f58918a851fb46895fd9b7ce579afeac9d02:

  target/arm: Set MVFR0.FPSP for ARMv5 cpus (2020-02-21 16:07:03 +0000)

----------------------------------------------------------------
target-arm queue:
 * aspeed/scu: Implement chip ID register
 * hw/misc/iotkit-secctl: Fix writing to 'PPC Interrupt Clear' register
 * mainstone: Make providing flash images non-mandatory
 * z2: Make providing flash images non-mandatory
 * Fix failures to flush SVE high bits after AdvSIMD INS/ZIP/UZP/TRN/TBL/TBX/EXT
 * Minor performance improvement: spend less time recalculating hflags values
 * Code cleanup to isar_feature function tests
 * Implement ARMv8.1-PMU and ARMv8.4-PMU extensions
 * Bugfix: correct handling of PMCR_EL0.LC bit
 * Bugfix: correct definition of PMCRDP
 * Correctly implement ACTLR2, HACTLR2
 * allwinner: Wire up USB ports
 * Vectorize emulation of USHL, SSHL, PMUL*
 * xilinx_spips: Correct the number of dummy cycles for the FAST_READ_4 cmd
 * sh4: Fix PCI ISA IO memory subregion

----------------------------------------------------------------
Francisco Iglesias (1):
      xilinx_spips: Correct the number of dummy cycles for the FAST_READ_4 cmd

Guenter Roeck (6):
      mainstone: Make providing flash images non-mandatory
      z2: Make providing flash images non-mandatory
      hw: usb: hcd-ohci: Move OHCISysBusState and TYPE_SYSBUS_OHCI to include file
      hcd-ehci: Introduce "companion-enable" sysbus property
      arm: allwinner: Wire up USB ports
      sh4: Fix PCI ISA IO memory subregion

Joel Stanley (2):
      aspeed/scu: Create separate write callbacks
      aspeed/scu: Implement chip ID register

Peter Maydell (21):
      target/arm: Add _aa32_ to isar_feature functions testing 32-bit ID registers
      target/arm: Check aa32_pan in take_aarch32_exception(), not aa64_pan
      target/arm: Add isar_feature_any_fp16 and document naming/usage conventions
      target/arm: Define and use any_predinv isar_feature test
      target/arm: Factor out PMU register definitions
      target/arm: Add and use FIELD definitions for ID_AA64DFR0_EL1
      target/arm: Use FIELD macros for clearing ID_DFR0 PERFMON field
      target/arm: Define an aa32_pmu_8_1 isar feature test function
      target/arm: Add _aa64_ and _any_ versions of pmu_8_1 isar checks
      target/arm: Stop assuming DBGDIDR always exists
      target/arm: Move DBGDIDR into ARMISARegisters
      target/arm: Read debug-related ID registers from KVM
      target/arm: Implement ARMv8.1-PMU extension
      target/arm: Implement ARMv8.4-PMU extension
      target/arm: Provide ARMv8.4-PMU in '-cpu max'
      target/arm: Correct definition of PMCRDP
      target/arm: Correct handling of PMCR_EL0.LC bit
      target/arm: Test correct register in aa32_pan and aa32_ats1e1 checks
      target/arm: Use isar_feature function for testing AA32HPD feature
      target/arm: Use FIELD_EX32 for testing 32-bit fields
      target/arm: Correctly implement ACTLR2, HACTLR2

Philippe Mathieu-Daudé (1):
      hw/misc/iotkit-secctl: Fix writing to 'PPC Interrupt Clear' register

Richard Henderson (15):
      target/arm: Flush high bits of sve register after AdvSIMD EXT
      target/arm: Flush high bits of sve register after AdvSIMD TBL/TBX
      target/arm: Flush high bits of sve register after AdvSIMD ZIP/UZP/TRN
      target/arm: Flush high bits of sve register after AdvSIMD INS
      target/arm: Use bit 55 explicitly for pauth
      target/arm: Fix select for aa64_va_parameters_both
      target/arm: Remove ttbr1_valid check from get_phys_addr_lpae
      target/arm: Split out aa64_va_parameter_tbi, aa64_va_parameter_tbid
      target/arm: Vectorize USHL and SSHL
      target/arm: Convert PMUL.8 to gvec
      target/arm: Convert PMULL.64 to gvec
      target/arm: Convert PMULL.8 to gvec
      target/arm: Rename isar_feature_aa32_simd_r32
      target/arm: Use isar_feature_aa32_simd_r32 more places
      target/arm: Set MVFR0.FPSP for ARMv5 cpus

 hw/usb/hcd-ohci.h              |  16 ++
 include/hw/arm/allwinner-a10.h |   6 +
 target/arm/cpu.h               | 145 ++++++++++---
 target/arm/helper-sve.h        |   2 +
 target/arm/helper.h            |  21 +-
 target/arm/internals.h         |  47 ++++-
 target/arm/translate.h         |   6 +
 hw/arm/allwinner-a10.c         |  43 ++++
 hw/arm/mainstone.c             |  11 +-
 hw/arm/z2.c                    |   6 -
 hw/intc/armv7m_nvic.c          |  10 +-
 hw/misc/aspeed_scu.c           |  93 ++++++--
 hw/misc/iotkit-secctl.c        |   2 +-
 hw/sh4/sh_pci.c                |  11 +-
 hw/ssi/xilinx_spips.c          |   2 +-
 hw/usb/hcd-ehci-sysbus.c       |   2 +
 hw/usb/hcd-ohci.c              |  15 --
 linux-user/elfload.c           |   4 +-
 target/arm/cpu.c               | 169 +++++++--------
 target/arm/cpu64.c             |  58 +++--
 target/arm/debug_helper.c      |   6 +-
 target/arm/helper.c            | 468 +++++++++++++++++++++++------------------
 target/arm/kvm32.c             |  25 +++
 target/arm/kvm64.c             |  46 ++++
 target/arm/neon_helper.c       | 117 -----------
 target/arm/pauth_helper.c      |   3 +-
 target/arm/translate-a64.c     |  92 ++++----
 target/arm/translate-vfp.inc.c |  53 ++---
 target/arm/translate.c         | 356 ++++++++++++++++++++++++++-----
 target/arm/vec_helper.c        | 211 +++++++++++++++++++
 target/arm/vfp_helper.c        |   2 +-
 31 files changed, 1377 insertions(+), 671 deletions(-)

