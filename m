Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04ADFC43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 05:23:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A820121897
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 05:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="lMGIJf9V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A820121897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFW6A-0002Zz-Ml
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 01:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kFW3B-0005ia-4g; Tue, 08 Sep 2020 01:20:13 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:40963 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kFW37-0005rF-6p; Tue, 08 Sep 2020 01:20:12 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4Bltkj2dbKz9sTM; Tue,  8 Sep 2020 15:19:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1599542397;
 bh=afu/DxukOoZ6szAGtLQx9NAEkZb17yMrxTFVoVTikaQ=;
 h=From:To:Cc:Subject:Date:From;
 b=lMGIJf9VFKJBAhqJMG24l1vQJlm2HjnxhLkCygS0XMdQVC0mH1/gtdyoAX0JpxDo0
 R2TfxkKHbB2+j+zDYn0FTobu1MdndctvR912R5IBhfsARUcaVT+qf+ePJpQOSNL0bZ
 0zcWflmMFTKDsAAxZWqyzH6z0EaJJ4CykZ9uecac=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 00/33] ppc-for-5.2 queue 20200908
Date: Tue,  8 Sep 2020 15:19:20 +1000
Message-Id: <20200908051953.1616885-1-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: danielhb413@gmail.com, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, bauerman@linux.ibm.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit e11bd71f89649da3cff439c030d2ccac0cc914e3:

  Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2020-09-07' into staging (2020-09-07 16:51:00 +0100)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-5.2-20200908

for you to fetch changes up to 876ab8d89d0d288945334c8caa908b07ef847de2:

  spapr_numa: use spapr_numa_get_vcpu_assoc() in home_node hcall (2020-09-08 11:34:30 +1000)

----------------------------------------------------------------
ppc patch queue 2020-09-08

This supersedes ppc-for-5.2-20200904, it fixes a couple of bugs in
that PR and adds a few extra patches.

Next pull request for qemu-5.2.  The biggest thing here is the
generalization of ARM's start-powered-off machine property to all
targets.  This can fix a number of odd little edge cases where KVM
could run vcpus before they were properly initialized.  This does
include changes to a number of files that aren't normally in my
purview.  There are suitable Acked-by lines and Peter requested this
come in via my tree, since the most pressing requirement for it is in
pseries machines with the POWER secure virtual machine facility.

In addition we have:
 * Daniel Barboza's rework and clean up of pseries machine NUMA handling
 * Correction to behaviour of the nvdimm= generic machine property on
   pseries
 * An optimization to the allocation of XIVE interrupts on KVM
 * Some fixes for confused behaviour with kernel_irqchip when both
   XICS and XIVE are in play
 * Add HIOMAP comamnd to pnv flash
 * Properly advertise the fact that spapr_vscsi doesn't handle
   hotplugged disks
 * Some assorted minor enhancements

----------------------------------------------------------------
Cédric Le Goater (8):
      ppc/pnv: Fix TypeInfo of PnvLpcController abstract class
      spapr/xive: Add a 'hv-prio' property to represent the KVM escalation priority
      ppc/pnv: Add a HIOMAP erase command
      spapr/xive: Use the xics flag to check for XIVE-only IRQ backends
      spapr/xive: Modify kvm_cpu_is_enabled() interface
      spapr/xive: Use kvmppc_xive_source_reset() in post_load
      spapr/xive: Allocate IPIs independently from the other sources
      spapr/xive: Allocate vCPU IPIs from the vCPU contexts

Daniel Henrique Barboza (13):
      spapr_vscsi: do not allow device hotplug
      ppc/spapr_nvdimm: use g_autofree in spapr_nvdimm_validate_opts()
      spapr, spapr_nvdimm: fold NVDIMM validation in the same place
      ppc/spapr_nvdimm: do not enable support with 'nvdimm=off'
      ppc: introducing spapr_numa.c NUMA code helper
      ppc/spapr_nvdimm: turn spapr_dt_nvdimm() static
      spapr: introduce SpaprMachineState::numa_assoc_array
      spapr, spapr_numa: handle vcpu ibm,associativity
      spapr, spapr_numa: move lookup-arrays handling to spapr_numa.c
      spapr_numa: move NVLink2 associativity handling to spapr_numa.c
      spapr: move h_home_node_associativity to spapr_numa.c
      spapr_numa: create a vcpu associativity helper
      spapr_numa: use spapr_numa_get_vcpu_assoc() in home_node hcall

David Gibson (2):
      adb: Correct class size on TYPE_ADB_DEVICE
      spapr: Remove unnecessary DRC type-checker macros

Philippe Mathieu-Daudé (2):
      hw/ppc/ppc4xx_pci: Use ARRAY_SIZE() instead of magic value
      hw/ppc/ppc4xx_pci: Replace pointless warning by assert()

Thiago Jung Bauermann (8):
      target/arm: Move start-powered-off property to generic CPUState
      target/arm: Move setting of CPU halted state to generic code
      ppc/spapr: Use start-powered-off CPUState property
      ppc/e500: Use start-powered-off CPUState property
      mips/cps: Use start-powered-off CPUState property
      sparc/sun4m: Don't set cs->halted = 0 in main_cpu_reset()
      sparc/sun4m: Use start-powered-off CPUState property
      target/s390x: Use start-powered-off CPUState property

 exec.c                        |   1 +
 hw/core/cpu.c                 |   2 +-
 hw/input/adb.c                |   1 +
 hw/intc/spapr_xive.c          |  33 +++---
 hw/intc/spapr_xive_kvm.c      | 102 ++++++++++++++----
 hw/mips/cps.c                 |  15 ++-
 hw/ppc/e500.c                 |  13 ++-
 hw/ppc/meson.build            |   3 +-
 hw/ppc/pnv_bmc.c              |  29 ++++-
 hw/ppc/pnv_lpc.c              |   3 +-
 hw/ppc/ppc4xx_pci.c           |   8 +-
 hw/ppc/spapr.c                | 109 ++++---------------
 hw/ppc/spapr_cpu_core.c       |  10 +-
 hw/ppc/spapr_hcall.c          |  40 -------
 hw/ppc/spapr_irq.c            |   2 +-
 hw/ppc/spapr_numa.c           | 242 ++++++++++++++++++++++++++++++++++++++++++
 hw/ppc/spapr_nvdimm.c         |  68 +++++++-----
 hw/ppc/spapr_pci.c            |   9 +-
 hw/ppc/spapr_pci_nvlink2.c    |  20 +---
 hw/scsi/spapr_vscsi.c         |   3 +
 hw/sparc/sun4m.c              |  26 ++---
 include/hw/core/cpu.h         |   4 +
 include/hw/ipmi/ipmi.h        |   1 +
 include/hw/ppc/spapr.h        |  17 +++
 include/hw/ppc/spapr_drc.h    |  43 +-------
 include/hw/ppc/spapr_numa.h   |  35 ++++++
 include/hw/ppc/spapr_nvdimm.h |   7 +-
 include/hw/ppc/spapr_xive.h   |   2 +
 target/arm/cpu.c              |   4 +-
 target/arm/cpu.h              |   3 -
 target/arm/kvm32.c            |   2 +-
 target/arm/kvm64.c            |   2 +-
 target/s390x/cpu.c            |   2 +-
 33 files changed, 548 insertions(+), 313 deletions(-)
 create mode 100644 hw/ppc/spapr_numa.c
 create mode 100644 include/hw/ppc/spapr_numa.h

