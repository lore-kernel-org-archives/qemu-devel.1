Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B34DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:49:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECD1E206BE
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V5I2C2vO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD1E206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA96F-00063n-4B
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 05:49:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kA95N-0004Qc-IR
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:48:17 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:39027)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kA95L-0004lf-Mq
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:48:17 -0400
Received: by mail-wr1-x431.google.com with SMTP id a5so8008926wrm.6
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 02:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KUKI9967rGrdm6aNTROGc5KTicNLlCSQUkrlEBzGpOU=;
 b=V5I2C2vO4pDBxLFm7XXD6F8DvHxh2bMd0IEi/NgPmlmXDn7bBQjfOf78kIcMJSkVOe
 6H5zaVvA7CJFNpa1IIlhWOFjzhJOYDwAeXaqXD8R39QGWa+DSjZn+C2irnoKyCvaRGn5
 d++QBtb/brl7w38Svh4mkHcJF0tAB4RoehWY4litA/zrE+bbg//gg/3/hp+r3HZ4jXFX
 VspD/JWOHi0LKa7AUS592Aqht5MBggAvjW251UFROBrZERzICvoa/3oJpPvhxgN5ly4G
 kvEVKZiwYPvPHWUs1V6f0LBwZeeIJZhVL15KWaTBICp1MVdSqd25ho3mEBnw3oukY7+p
 bm1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KUKI9967rGrdm6aNTROGc5KTicNLlCSQUkrlEBzGpOU=;
 b=JbxXL9qxu1ZLRd3dUz73tAvIIWPsTY15MOiLE6CjyICe4RS4ujCUG/RU0Zp3ofKmlf
 xzOdkFSBvcuOxcDI/jWiYfKbeCXsotUcn7DF7JRXaQfep7xRO2JGZyWjhIfw9M7/9tZH
 77K3XiqZ1fdzEnzJ5yKYnI5s3JHBW/K/00aC6/xFHaTa8JYkxuWf/tBK1wQHOoIMpU0X
 MoiroCW72RxGI0tjdpYsAjVKJT2JATw3DKtBjfGdqTMKg88W3fGT9cLHRSkngpXXjOK+
 pXcFT5uRNkXVQPN/crZZaHNINwgxInfgSpgf/VLOUhkdo0vImMUuV45YB267PXtOmEFU
 hxJw==
X-Gm-Message-State: AOAM531x3D8TITtsuy4ulXiZeobK2aUL7fx/8K8blwgvTFl6wTPruRYA
 JoS+8UhGc5KBAnb4H90YvUVVW94XB5xRcBJm
X-Google-Smtp-Source: ABdhPJw82KK+3uw3qhzbz2hYv07hdcBC3Y5FJLXjYGFY+vaZM3j/ZDOLzsn1iAE4DaEP7mZnZlYQSg==
X-Received: by 2002:adf:f610:: with SMTP id t16mr4759898wrp.97.1598262493532; 
 Mon, 24 Aug 2020 02:48:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q6sm24877057wma.22.2020.08.24.02.48.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 02:48:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/27] target-arm queue
Date: Mon, 24 Aug 2020 10:47:44 +0100
Message-Id: <20200824094811.15439-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

First arm pullreq for 5.2: Eric's SMMU stuff, and a bunch of
cleanup/refactoring from me.

thanks
-- PMM

The following changes since commit 8367a77c4d3f6e1e60890f5510304feb2c621611:

  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.2-pull-request' into staging (2020-08-23 16:34:43 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200824

for you to fetch changes up to b34aa5129e9c3aff890b4f4bcc84962e94185629:

  target/arm: Use correct FPST for VCMLA, VCADD on fp16 (2020-08-24 10:15:12 +0100)

----------------------------------------------------------------
target-arm queue:
 * hw/cpu/a9mpcore: Verify the machine use Cortex-A9 cores
 * hw/arm/smmuv3: Implement SMMUv3.2 range-invalidation
 * docs/system/arm: Document the Xilinx Versal Virt board
 * target/arm: Make M-profile NOCP take precedence over UNDEF
 * target/arm: Use correct FPST for VCMLA, VCADD on fp16
 * target/arm: Various cleanups preparing for fp16 support

----------------------------------------------------------------
Edgar E. Iglesias (1):
      docs/system/arm: Document the Xilinx Versal Virt board

Eric Auger (11):
      hw/arm/smmu-common: Factorize some code in smmu_ptw_64()
      hw/arm/smmu-common: Add IOTLB helpers
      hw/arm/smmu: Introduce smmu_get_iotlb_key()
      hw/arm/smmu: Introduce SMMUTLBEntry for PTW and IOTLB value
      hw/arm/smmu-common: Manage IOTLB block entries
      hw/arm/smmuv3: Introduce smmuv3_s1_range_inval() helper
      hw/arm/smmuv3: Get prepared for range invalidation
      hw/arm/smmuv3: Fix IIDR offset
      hw/arm/smmuv3: Let AIDR advertise SMMUv3.0 support
      hw/arm/smmuv3: Support HAD and advertise SMMUv3.1 support
      hw/arm/smmuv3: Advertise SMMUv3.2 range invalidation

Peter Maydell (14):
      target/arm: Pull handling of XScale insns out of disas_coproc_insn()
      target/arm: Separate decode from handling of coproc insns
      target/arm: Convert A32 coprocessor insns to decodetree
      target/arm: Tidy up disas_arm_insn()
      target/arm: Do M-profile NOCP checks early and via decodetree
      target/arm: Convert T32 coprocessor insns to decodetree
      target/arm: Remove ARCH macro
      target/arm: Delete unused VFP_DREG macros
      target/arm/translate.c: Delete/amend incorrect comments
      target/arm: Delete unused ARM_FEATURE_CRC
      target/arm: Replace A64 get_fpstatus_ptr() with generic fpstatus_ptr()
      target/arm: Make A32/T32 use new fpstatus_ptr() API
      target/arm: Implement FPST_STD_F16 fpstatus
      target/arm: Use correct FPST for VCMLA, VCADD on fp16

Philippe Mathieu-Daudé (1):
      hw/cpu/a9mpcore: Verify the machine use Cortex-A9 cores

 docs/system/arm/xlnx-versal-virt.rst | 176 +++++++++++++++++++++++
 docs/system/target-arm.rst           |   1 +
 hw/arm/smmu-internal.h               |   8 ++
 hw/arm/smmuv3-internal.h             |  10 +-
 include/hw/arm/smmu-common.h         |  19 ++-
 include/hw/arm/smmuv3.h              |   1 +
 target/arm/cpu.h                     |  10 +-
 target/arm/translate-a64.h           |   1 -
 target/arm/translate.h               |  52 +++++++
 target/arm/a32.decode                |  19 +++
 target/arm/m-nocp.decode             |  42 ++++++
 target/arm/t32.decode                |  19 +++
 target/arm/vfp.decode                |   2 -
 hw/arm/smmu-common.c                 | 214 ++++++++++++++++++---------
 hw/arm/smmuv3.c                      | 142 +++++++++---------
 hw/cpu/a9mpcore.c                    |  12 +-
 target/arm/cpu.c                     |   3 +
 target/arm/helper.c                  |  29 ++++
 target/arm/translate-a64.c           |  89 +++++-------
 target/arm/translate-sve.c           |  34 ++---
 target/arm/translate.c               | 272 +++++++++++++++++------------------
 target/arm/vfp_helper.c              |   5 +
 MAINTAINERS                          |   3 +-
 hw/arm/trace-events                  |  12 +-
 target/arm/meson.build               |   1 +
 target/arm/translate-neon.c.inc      |  28 ++--
 target/arm/translate-vfp.c.inc       |  96 ++++++++-----
 27 files changed, 885 insertions(+), 415 deletions(-)
 create mode 100644 docs/system/arm/xlnx-versal-virt.rst
 create mode 100644 target/arm/m-nocp.decode

