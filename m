Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED303C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:27:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B507E206A5
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h2dBo3YL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B507E206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZEpW-0003jE-QF
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:27:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEk3-0002eq-U5
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:21:43 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:37153)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEk2-0005Mq-Ji
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:21:43 -0400
Received: by mail-wr1-x429.google.com with SMTP id l17so4377371wrr.4
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JaG+BjkA6VM628CB8baRfDvcdIasSLEWsnM5ah049i8=;
 b=h2dBo3YLOoZOe1wLZI2wichBLj1K+4urqGchRdFU0V+OpgWMkPv2FnznKMSGmup4SB
 +tHjW5yapUCyH/wxjlDMCzLP4uCTAQN0cJx0FumoOT6mFOY8CfVJiiypgIHutA/4Q+5v
 OZgJ0ihqlr0xtPJajpU3x5qCfFQsqj55PaOqgSY/VT4evjZpZFjUqBKHtq8xtKCvkhir
 zUe9lTEBdM+9uHYq7i8hLDg1QZi6XUjMG4pDKeG8bpJ5BHvGBIHRKMaBLzgElgEyxdEH
 80Vvlt0UtoqU3W4rERM9dwVMzCoBhguuoaE4LysuZzcgr6rjIrrR3XzbSakDoGVNqokr
 KFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JaG+BjkA6VM628CB8baRfDvcdIasSLEWsnM5ah049i8=;
 b=PX3ccjrIVWGi6x0HS3e0hSmjNZo2Sc66MMYHrHht6tEDaOtrpBRFIMjjKLKL89A3hf
 9U6fchhrxLJosZffS+uztYgwVRzR4gYv9fya9KPZKoiz8kSzWeIZCP5VRouOBGdDLZ/B
 lUyYbaD6wtmuiuq1vw5x7U1Pq7LMLIGFkHf79ydb5x6FaejZ9ZqFhUwrxwv++EHT8co4
 KicmHj2c8UtrnTqwOs/jhqmJdKJKf5wiVAXXfr4S5if1DMzNqL8/OkstzT1N4+clhLxO
 FX0Ph+N1kbvFQm2O2tHNULOcTPUPuXVFfyYbANSzdF77I3i6ZLyk0OdPM5eSiGk1UtQ1
 qxsw==
X-Gm-Message-State: AOAM531xWkmyzQWW4Z+pI46S0QgN10lKth7hmHCFxbZKLDWisBaqwbdx
 CihJkT4sHKjH6IkGIhh+tSMSXOWIm97SQg==
X-Google-Smtp-Source: ABdhPJzpM8JZUv1w/W8HeARdE4mP1piPzJByNLM6xUUU1S28zsXf0C+f+QeIIUaLRm+fx7x4fOHrBQ==
X-Received: by 2002:adf:afdb:: with SMTP id y27mr5461991wrd.323.1589466100454; 
 Thu, 14 May 2020 07:21:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 88sm4077443wrq.77.2020.05.14.07.21.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:21:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/45] target-arm queue
Date: Thu, 14 May 2020 15:20:53 +0100
Message-Id: <20200514142138.20875-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

Mostly this is patches from me and RTH cleaning up and doing
more decodetree conversion for AArch32 Neon. The major new feature
is Dongjiu Geng's patchset to report host memory errors to KVM guests;
also a new aspeed board from Patrick Williams.

thanks
-- PMM

The following changes since commit 035b448b84f3557206abc44d786c5d3db2638f7d:

  Merge remote-tracking branch 'remotes/gkurz/tags/9p-next-2020-05-14' into staging (2020-05-14 10:58:30 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200514

for you to fetch changes up to e95485f85657be21135c17a9226e297c21e73360:

  target/arm: Convert NEON VFMA, VFMS 3-reg-same insns to decodetree (2020-05-14 15:03:09 +0100)

----------------------------------------------------------------
target-arm queue:
 * target/arm: Use correct GDB XML for M-profile cores
 * target/arm: Code cleanup to use gvec APIs better
 * aspeed: Add support for the sonorapass-bmc board
 * target/arm: Support reporting KVM host memory errors
   to the guest via ACPI notifications
 * target/arm: Finish conversion of Neon 3-reg-same insns to decodetree

----------------------------------------------------------------
Dongjiu Geng (10):
      acpi: nvdimm: change NVDIMM_UUID_LE to a common macro
      hw/arm/virt: Introduce a RAS machine option
      docs: APEI GHES generation and CPER record description
      ACPI: Build related register address fields via hardware error fw_cfg blob
      ACPI: Build Hardware Error Source Table
      ACPI: Record the Generic Error Status Block address
      KVM: Move hwpoison page related functions into kvm-all.c
      ACPI: Record Generic Error Status Block(GESB) table
      target-arm: kvm64: handle SIGBUS signal from kernel or KVM
      MAINTAINERS: Add ACPI/HEST/GHES entries

Patrick Williams (1):
      aspeed: Add support for the sonorapass-bmc board

Peter Maydell (18):
      target/arm: Use correct GDB XML for M-profile cores
      target/arm: Convert Neon 3-reg-same VQRDMLAH/VQRDMLSH to decodetree
      target/arm: Convert Neon 3-reg-same SHA to decodetree
      target/arm: Convert Neon 64-bit element 3-reg-same insns
      target/arm: Convert Neon VHADD 3-reg-same insns
      target/arm: Convert Neon VABA/VABD 3-reg-same to decodetree
      target/arm: Convert Neon VRHADD, VHSUB 3-reg-same insns to decodetree
      target/arm: Convert Neon VQSHL, VRSHL, VQRSHL 3-reg-same insns to decodetree
      target/arm: Convert Neon VPMAX/VPMIN 3-reg-same insns to decodetree
      target/arm: Convert Neon VPADD 3-reg-same insns to decodetree
      target/arm: Convert Neon VQDMULH/VQRDMULH 3-reg-same to decodetree
      target/arm: Convert Neon VADD, VSUB, VABD 3-reg-same insns to decodetree
      target/arm: Convert Neon VPMIN/VPMAX/VPADD float 3-reg-same insns to decodetree
      target/arm: Convert Neon fp VMUL, VMLA, VMLS 3-reg-same insns to decodetree
      target/arm: Convert Neon 3-reg-same compare insns to decodetree
      target/arm: Move 'env' argument of recps_f32 and rsqrts_f32 helpers to usual place
      target/arm: Convert Neon fp VMAX/VMIN/VMAXNM/VMINNM/VRECPS/VRSQRTS to decodetree
      target/arm: Convert NEON VFMA, VFMS 3-reg-same insns to decodetree

Richard Henderson (16):
      target/arm: Create gen_gvec_[us]sra
      target/arm: Create gen_gvec_{u,s}{rshr,rsra}
      target/arm: Create gen_gvec_{sri,sli}
      target/arm: Remove unnecessary range check for VSHL
      target/arm: Tidy handle_vec_simd_shri
      target/arm: Create gen_gvec_{ceq,clt,cle,cgt,cge}0
      target/arm: Create gen_gvec_{mla,mls}
      target/arm: Swap argument order for VSHL during decode
      target/arm: Create gen_gvec_{cmtst,ushl,sshl}
      target/arm: Create gen_gvec_{uqadd, sqadd, uqsub, sqsub}
      target/arm: Remove fp_status from helper_{recpe, rsqrte}_u32
      target/arm: Create gen_gvec_{qrdmla,qrdmls}
      target/arm: Pass pointer to qc to qrdmla/qrdmls
      target/arm: Clear tail in gvec_fmul_idx_*, gvec_fmla_idx_*
      target/arm: Vectorize SABD/UABD
      target/arm: Vectorize SABA/UABA

 docs/specs/acpi_hest_ghes.rst          |  110 ++
 docs/specs/index.rst                   |    1 +
 configure                              |    4 +-
 default-configs/arm-softmmu.mak        |    1 +
 include/hw/acpi/aml-build.h            |    1 +
 include/hw/acpi/generic_event_device.h |    2 +
 include/hw/acpi/ghes.h                 |   74 +
 include/hw/arm/virt.h                  |    1 +
 include/qemu/uuid.h                    |   27 +
 include/sysemu/kvm.h                   |    3 +-
 include/sysemu/kvm_int.h               |   12 +
 target/arm/cpu.h                       |    4 +
 target/arm/helper.h                    |   78 +-
 target/arm/internals.h                 |    5 +-
 target/arm/translate.h                 |   84 +-
 target/i386/cpu.h                      |    2 +
 target/arm/neon-dp.decode              |  119 +-
 accel/kvm/kvm-all.c                    |   36 +
 hw/acpi/aml-build.c                    |    2 +
 hw/acpi/generic_event_device.c         |   19 +
 hw/acpi/ghes.c                         |  448 ++++++
 hw/acpi/nvdimm.c                       |   10 +-
 hw/arm/aspeed.c                        |   78 ++
 hw/arm/virt-acpi-build.c               |   15 +
 hw/arm/virt.c                          |   23 +
 target/arm/cpu_tcg.c                   |    1 +
 target/arm/gdbstub.c                   |   22 +-
 target/arm/helper.c                    |    2 +-
 target/arm/kvm64.c                     |   77 ++
 target/arm/neon_helper.c               |   17 -
 target/arm/tlb_helper.c                |    2 +-
 target/arm/translate-a64.c             |  210 +--
 target/arm/translate-neon.inc.c        |  682 +++++++++-
 target/arm/translate.c                 | 2349 +++++++++++++++++---------------
 target/arm/vec_helper.c                |  240 +++-
 target/arm/vfp_helper.c                |    9 +-
 target/i386/kvm.c                      |   36 -
 MAINTAINERS                            |    9 +
 gdb-xml/arm-m-profile.xml              |   27 +
 hw/acpi/Kconfig                        |    4 +
 hw/acpi/Makefile.objs                  |    1 +
 41 files changed, 3402 insertions(+), 1445 deletions(-)
 create mode 100644 docs/specs/acpi_hest_ghes.rst
 create mode 100644 include/hw/acpi/ghes.h
 create mode 100644 hw/acpi/ghes.c
 create mode 100644 gdb-xml/arm-m-profile.xml

