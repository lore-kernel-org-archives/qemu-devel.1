Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B06C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 04:21:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66D8B20706
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 04:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="escYPAB1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66D8B20706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7t7d-0000pB-FG
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 00:21:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k7t62-00078Q-JK; Tue, 18 Aug 2020 00:19:38 -0400
Received: from ozlabs.org ([203.11.71.1]:33681)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k7t60-0006JX-7i; Tue, 18 Aug 2020 00:19:38 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BVyNY44mtz9sTT; Tue, 18 Aug 2020 14:19:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597724365;
 bh=0sa5ISnS1965uWkVgS5kLNMaCY4IrxPbE+d8keUhk0o=;
 h=From:To:Cc:Subject:Date:From;
 b=escYPAB1E2BZTn6+PxMaWhEqt9f0MPFsMKrteaP6eV2Qz4dAQgBfV0/4m1fC+XHPK
 ME6rMRpd9Khr7P/bwbdygMCj709m46Vg8n5dAcoO9aUMHr/Hj/tJUUQFWzoNxAmWoq
 w/9QAzQVve0jeU+im7tKzOQCRKdTgKnjUimpUSFg=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org,
	groug@kaod.org
Subject: [PULL 00/40] ppc-for-5.2 queue 20200818
Date: Tue, 18 Aug 2020 14:18:42 +1000
Message-Id: <20200818041922.251708-1-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 00:19:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit d0ed6a69d399ae193959225cdeaa9382746c91cc:

  Update version for v5.1.0 release (2020-08-11 17:07:03 +0100)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-5.2-20200818

for you to fetch changes up to 3110f0ee19ccdb50adff3dfa1321039f69efddcd:

  spapr/xive: Use xive_source_esb_len() (2020-08-14 13:35:45 +1000)

----------------------------------------------------------------
ppc patch queue 2020-08-18

Here's my first pull request for qemu-5.2, which has quite a few
accumulated things.  Highlights are:

 * Preliminary support for POWER10 (Power ISA 3.1) instruction emulation
 * Add documentation on the (very confusing) pseries NUMA configuration
 * Fix some bugs handling edge cases with XICS, XIVE and kernel_irqchip
 * Fix icount for a number of POWER registers
 * Many cleanups to error handling in XIVE code
 * Validate size of -prom-env data

----------------------------------------------------------------
Anton Blanchard (1):
      ppc/spapr: Fix 32 bit logical memory block size assumptions

Cédric Le Goater (1):
      docs: Update POWER9 XIVE support for nested guests

Daniel Henrique Barboza (1):
      docs: adding NUMA documentation for pseries

Greg Kurz (24):
      spapr: Use error_append_hint() in spapr_caps.c
      spapr: Forbid nested KVM-HV in pre-power9 compat mode
      spapr: Clarify error and documentation for broken KVM XICS
      spapr/xive: Fix xive->fd if kvm_create_device() fails
      spapr/xive: Simplify kvmppc_xive_disconnect()
      ppc/xive: Rework setup of XiveSource::esb_mmio
      ppc/xive: Introduce dedicated kvm_irqchip_in_kernel() wrappers
      spapr/xive: Convert KVM device fd checks to assert()
      spapr: Simplify error handling in spapr_phb_realize()
      spapr/xive: Rework error handling of kvmppc_xive_cpu_connect()
      spapr/xive: Rework error handling of kvmppc_xive_source_reset()
      spapr/xive: Rework error handling of kvmppc_xive_mmap()
      spapr/xive: Rework error handling of kvmppc_xive_cpu_[gs]et_state()
      spapr/xive: Rework error handling of kvmppc_xive_[gs]et_queue_config()
      spapr/xive: Rework error handling in kvmppc_xive_get_queues()
      spapr/xive: Rework error handling of kvmppc_xive_set_source_config()
      spapr/kvm: Fix error handling in kvmppc_xive_pre_save()
      spapr/xive: Fix error handling in kvmppc_xive_post_load()
      ppc/xive: Fix error handling in vmstate_xive_tctx_*() callbacks
      spapr/xive: Simplify error handling in kvmppc_xive_connect()
      ppc/xive: Simplify error handling in xive_tctx_realize()
      spapr/xive: Simplify error handling of kvmppc_xive_cpu_synchronize_state()
      nvram: Exit QEMU if NVRAM cannot contain all -prom-env data
      spapr/xive: Use xive_source_esb_len()

Gustavo Romero (2):
      ppc/xive: Fix some typos in comments
      target/ppc: Integrate icount to purr, vtb, and tbu40

Lijun Pan (9):
      target/ppc: Introduce Power ISA 3.1 flag
      target/ppc: Enable Power ISA 3.1
      target/ppc: add byte-reverse br[dwh] instructions
      target/ppc: convert vmuluwm to tcg_gen_gvec_mul
      target/ppc: add vmulld instruction
      Update PowerPC AT_HWCAP2 definition
      target/ppc: add vmulld to INDEX_op_mul_vec case
      target/ppc: add vmulh{su}w instructions
      target/ppc: add vmulh{su}d instructions

Matthieu Bucchianeri (2):
      target/ppc: Fix TCG leak with the evmwsmiaa instruction
      target/ppc: Fix SPE unavailable exception triggering

 docs/specs/index.rst                |   1 +
 docs/specs/ppc-spapr-numa.rst       | 191 +++++++++++++++++++++++++++
 docs/specs/ppc-spapr-xive.rst       |  10 +-
 hw/intc/spapr_xive.c                |  47 ++++---
 hw/intc/spapr_xive_kvm.c            | 257 +++++++++++++++++-------------------
 hw/intc/xive.c                      |  57 +++++---
 hw/nvram/chrp_nvram.c               |  24 +++-
 hw/nvram/mac_nvram.c                |   2 +-
 hw/nvram/spapr_nvram.c              |   3 +-
 hw/ppc/spapr.c                      |   6 +-
 hw/ppc/spapr_caps.c                 |  99 ++++++++------
 hw/ppc/spapr_irq.c                  |  12 +-
 hw/ppc/spapr_pci.c                  |  16 +--
 hw/sparc/sun4m.c                    |   2 +-
 hw/sparc64/sun4u.c                  |   2 +-
 include/elf.h                       |   1 +
 include/hw/nvram/chrp_nvram.h       |   3 +-
 include/hw/ppc/spapr_xive.h         |   8 +-
 include/hw/ppc/xive.h               |  15 ++-
 target/ppc/cpu.h                    |   4 +-
 target/ppc/helper.h                 |   5 +-
 target/ppc/int_helper.c             |  48 +++++--
 target/ppc/translate.c              |  40 ++++++
 target/ppc/translate/spe-impl.inc.c | 101 +++++++++-----
 target/ppc/translate/vmx-impl.inc.c |  11 +-
 target/ppc/translate/vmx-ops.inc.c  |  10 +-
 target/ppc/translate_init.inc.c     |  32 ++++-
 tcg/ppc/tcg-target.h                |   2 +
 tcg/ppc/tcg-target.inc.c            |  12 +-
 29 files changed, 719 insertions(+), 302 deletions(-)
 create mode 100644 docs/specs/ppc-spapr-numa.rst

