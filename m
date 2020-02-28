Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84959C3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:39:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B1D320732
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qDDNl49U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B1D320732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7ig3-0000Ly-E8
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 11:39:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56353)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7if0-0007EG-Lb
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:38:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7iey-0001je-W3
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:38:46 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:38420)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7iey-0001jA-Ol
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:38:44 -0500
Received: by mail-wm1-x32e.google.com with SMTP id n64so2576086wme.3
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 08:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UeMgMMWL1JhRZfscpUF9zhH/44sltFzGtJGGfnvm3p4=;
 b=qDDNl49UiKAIqKpmMDqF6wXqtKnXcNawUqQAjHeHuu4HRTzw82od9XJGPh0mf25Niy
 GhUbu1gF7LA00MbvaQbpmw47UDsM3w2Q0IveijYt28qIvREchanw32Ah61nI+IRaY6rD
 zmjtN+CBvFiF5x5g1LR5cQzbqEQX2TFpnsRcavpknAk0Arvy+J9wffDKCnmpB02XRRl8
 XY7ciUcOfcdkjQCjBZ6RUHpNxTI7xLvw5EjQYbMC3/QJJwDw7+d+LlZHztGJs8QwFgAG
 LoOdeMeXOaev/aOrmyA8TRCHdDSdk3yyxY0zGcxBS0/WLI8zzKQpxAYljJNSm88PYC3f
 uyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UeMgMMWL1JhRZfscpUF9zhH/44sltFzGtJGGfnvm3p4=;
 b=cbh+pDUBp7hjUG7b1vQpGLV7E/z/cgUS39MUkH5kKaR0YY2L/b+H0SETRYUr76E84a
 gFrKGVjWLjy2dCU4IJ+a5/mc+LhMeyfkQmaJL1oxBTdaT4Mu4GSSS/Y/OnBqpTgJU1tT
 i3CY/q6VefUaygfOByDF55kOYDkUCyEwrZMU0aCT/BtzQnTwaSno7E3nIO1mcdFzHWc7
 T7e971PyZWCy5fh8hmYtTYVkJ6E7dZ5ilNqtjRRkPE3uCvsctmqoA86H3OCq1UEP6qk6
 pNCWoh8Tg7ii6crNaOroYrr9iLdruAe4DSLlbV+mZcixYOkMnA0PHpSrY7u/VfJw8LoD
 zAEQ==
X-Gm-Message-State: APjAAAUpsrGJcprjI+2NvzVTaF4LcGjiQERd2SmKml8+Ypd21RsU69SL
 J+IGE12lHDnTEqYdl9hilHnj+l3cgZN/7g==
X-Google-Smtp-Source: APXvYqww/9wtPgOj+KqxTVSZKiHzjT2MoUPJByHeettzooVq1I2zvhx91UyH6AU34lG1mo1WBIZYvQ==
X-Received: by 2002:a1c:984a:: with SMTP id a71mr5798495wme.185.1582907922990; 
 Fri, 28 Feb 2020 08:38:42 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c9sm13335214wrq.44.2020.02.28.08.38.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 08:38:42 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/33] target-arm queue
Date: Fri, 28 Feb 2020 16:38:07 +0000
Message-Id: <20200228163840.23585-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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

Another arm pullreq; nothing particularly exciting here.

-- PMM


The following changes since commit e27d5b488ef08408691bfed61f34ee2858136287:

  Merge remote-tracking branch 'remotes/juanquintela/tags/pull-migration-pull-request' into staging (2020-02-28 14:02:31 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200228

for you to fetch changes up to 1904f9b5f1d94fe12fe021db6b504c87d684f6db:

  hw/intc/arm_gic_kvm: Don't assume kernel can provide a GICv2 (2020-02-28 16:14:57 +0000)

----------------------------------------------------------------
target-arm queue:
 * hw/arm: Use TYPE_PL011 to create serial port
 * target/arm: Set ID_MMFR4.HPDS for aarch64_max_initfn
 * hw/arm/integratorcp: Map the audio codec controller
 * GICv2: Correctly implement the limited number of priority bits
 * target/arm: refactoring of VFP related feature checks and decode
 * xilinx_zynq: Fix USB port instantiation
 * acceptance tests for n800, n810, integratorcp
 * Implement v8.3-RCPC, v8.4-RCPC, v8.3-CCIDX
 * arm_gic_kvm: Don't assume kernel can provide a GICv2
   (provide better error message for user error)

----------------------------------------------------------------
Gavin Shan (1):
      hw/arm: Use TYPE_PL011 to create serial port

Guenter Roeck (2):
      hw/arm/xilinx_zynq: Fix USB port instantiation
      hw/usb/hcd-ehci-sysbus: Remove obsolete xlnx, ps7-usb class

Peter Maydell (5):
      target/arm: Fix wrong use of FIELD_EX32 on ID_AA64DFR0
      target/arm: Implement v8.3-RCPC
      target/arm: Implement v8.4-RCPC
      target/arm: Implement ARMv8.3-CCIDX
      hw/intc/arm_gic_kvm: Don't assume kernel can provide a GICv2

Philippe Mathieu-Daudé (3):
      hw/arm/integratorcp: Map the audio codec controller
      tests/acceptance: Extract boot_integratorcp() from test_integratorcp()
      tests/acceptance/integratorcp: Verify Tux is displayed on framebuffer

Richard Henderson (17):
      target/arm: Set ID_MMFR4.HPDS for aarch64_max_initfn
      target/arm: Add isar_feature_aa32_vfp_simd
      target/arm: Rename isar_feature_aa32_fpdp_v2
      target/arm: Add isar_feature_aa32_{fpsp_v2, fpsp_v3, fpdp_v3}
      target/arm: Add isar_feature_aa64_fp_simd, isar_feature_aa32_vfp
      target/arm: Perform fpdp_v2 check first
      target/arm: Replace ARM_FEATURE_VFP3 checks with fp{sp, dp}_v3
      target/arm: Add missing checks for fpsp_v2
      target/arm: Replace ARM_FEATURE_VFP4 with isar_feature_aa32_simdfmac
      target/arm: Remove ARM_FEATURE_VFP check from disas_vfp_insn
      target/arm: Move VLLDM and VLSTM to vfp.decode
      target/arm: Move the vfp decodetree calls next to the base isa
      linux-user/arm: Replace ARM_FEATURE_VFP* tests for HWCAP
      target/arm: Remove ARM_FEATURE_VFP*
      target/arm: Add formats for some vfp 2 and 3-register insns
      target/arm: Split VFM decode
      target/arm: Split VMINMAXNM decode

Sai Pavan Boddu (3):
      arm_gic: Mask the un-supported priority bits
      cpu/a9mpcore: Set number of GIC priority bits to 5
      cpu/arm11mpcore: Set number of GIC priority bits to 4

Thomas Huth (2):
      tests/acceptance: Add a test for the N800 and N810 arm machines
      tests/acceptance: Add a test for the integratorcp arm machine

 include/hw/intc/arm_gic.h                    |   2 +
 include/hw/intc/arm_gic_common.h             |   1 +
 target/arm/cpu.h                             |  88 +++++-
 hw/arm/integratorcp.c                        |   1 +
 hw/arm/sbsa-ref.c                            |   3 +-
 hw/arm/virt.c                                |   3 +-
 hw/arm/xilinx_zynq.c                         |   5 +-
 hw/arm/xlnx-versal.c                         |   3 +-
 hw/cpu/a9mpcore.c                            |   4 +
 hw/cpu/arm11mpcore.c                         |   5 +
 hw/intc/arm_gic.c                            |  33 +-
 hw/intc/arm_gic_common.c                     |   1 +
 hw/intc/arm_gic_kvm.c                        |   9 +
 hw/intc/armv7m_nvic.c                        |  20 +-
 hw/usb/hcd-ehci-sysbus.c                     |  17 -
 linux-user/arm/signal.c                      |   4 +-
 linux-user/elfload.c                         |  25 +-
 target/arm/arch_dump.c                       |  11 +-
 target/arm/cpu.c                             |  44 +--
 target/arm/cpu64.c                           |   5 +-
 target/arm/helper.c                          |  23 +-
 target/arm/kvm32.c                           |   5 -
 target/arm/kvm64.c                           |   1 -
 target/arm/m_helper.c                        |  11 +-
 target/arm/machine.c                         |   5 +-
 target/arm/translate-a64.c                   | 114 +++++++
 target/arm/translate-vfp.inc.c               | 448 +++++++++++++++++----------
 target/arm/translate.c                       | 122 ++------
 MAINTAINERS                                  |   2 +
 hw/arm/Kconfig                               |   1 +
 target/arm/vfp-uncond.decode                 |  12 +-
 target/arm/vfp.decode                        | 153 ++++-----
 tests/acceptance/machine_arm_integratorcp.py |  99 ++++++
 tests/acceptance/machine_arm_n8x0.py         |  49 +++
 34 files changed, 865 insertions(+), 464 deletions(-)
 create mode 100644 tests/acceptance/machine_arm_integratorcp.py
 create mode 100644 tests/acceptance/machine_arm_n8x0.py

