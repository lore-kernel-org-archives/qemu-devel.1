Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31112C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:08:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00599205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="J5YapKIy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00599205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE98l-0006k6-4x
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44879)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jE95X-0000kC-7c
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:04:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jE95V-0001DK-MF
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:04:43 -0400
Received: from ozlabs.org ([203.11.71.1]:57419)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jE95U-0000PH-Rm; Tue, 17 Mar 2020 06:04:41 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48hTKv25l7z9sR4; Tue, 17 Mar 2020 21:04:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584439475;
 bh=rqL6iLT4LjWb68J1CnzA4QnOzndydJXIPwQf7nMcQbo=;
 h=From:To:Cc:Subject:Date:From;
 b=J5YapKIygljlusLcp4YeVk4Nv+lCHIdIiWl2j7BshEPy91053QXojTQWl/zMZqYit
 UphCG5/9mz75V+H5o6gxztkQP+1Z+XkgUD48rS/xo79nSzwYCuyFFOBBC7bRSAL5h9
 M5jzn120yeQ9BvSaZ4VoXVoLV8pqWRlnRIb6qvzg=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 00/45] ppc-for-5.0 queue 20200317
Date: Tue, 17 Mar 2020 21:03:38 +1100
Message-Id: <20200317100423.622643-1-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com,
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit a98135f727595382e200d04c2996e868b7925a=
01:

  Merge remote-tracking branch 'remotes/kraxel/tags/vga-20200316-pull-req=
uest' into staging (2020-03-16 14:55:59 +0000)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-5.0-20200317

for you to fetch changes up to 6961eae79f58385482775dc0a6c3d553f633662d:

  pseries: Update SLOF firmware image (2020-03-17 17:00:22 +1100)

----------------------------------------------------------------
ppc patch queue 2020-03-17

Here's my final pull request for the qemu-5.0 soft freeze.  Sorry this
is just under the wire - I hit some last minute problems that took a
while to fix up and retest.

Highlights are:
 * Numerous fixes for the FWNMI feature
 * A handful of cleanups to the device tree construction code
 * Numerous fixes for the spapr-vscsi device
 * A number of fixes and cleanups for real mode (MMU off) softmmu
   handling
 * Fixes for handling of the PAPR RMA
 * Better handling of hotplug/unplug events during boot
 * Assorted other fixes

----------------------------------------------------------------
Alexey Kardashevskiy (5):
      pseries: Update SLOF firmware image
      ppc/spapr: Move GPRs setup to one place
      pseries: Update SLOF firmware image
      spapr/rtas: Reserve space for RTAS blob and log
      pseries: Update SLOF firmware image

C=C3=A9dric Le Goater (1):
      spapr/xive: use SPAPR_IRQ_IPI to define IPI ranges exposed to the g=
uest

David Gibson (19):
      ppc: Remove stub support for 32-bit hypervisor mode
      ppc: Remove stub of PPC970 HID4 implementation
      target/ppc: Correct handling of real mode accesses with vhyp on has=
h MMU
      target/ppc: Introduce ppc_hash64_use_vrma() helper
      spapr, ppc: Remove VPM0/RMLS hacks for POWER9
      target/ppc: Remove RMOR register from POWER9 & POWER10
      target/ppc: Use class fields to simplify LPCR masking
      target/ppc: Streamline calculation of RMA limit from LPCR[RMLS]
      target/ppc: Correct RMLS table
      target/ppc: Only calculate RMLS derived RMA limit on demand
      target/ppc: Don't store VRMA SLBE persistently
      spapr: Don't use weird units for MIN_RMA_SLOF
      spapr,ppc: Simplify signature of kvmppc_rma_size()
      spapr: Don't attempt to clamp RMA to VRMA constraint
      spapr: Don't clamp RMA to 16GiB on new machine types
      spapr: Clean up RMA size calculation
      spapr: Move creation of ibm,dynamic-reconfiguration-memory dt node
      spapr: Move creation of ibm,architecture-vec-5 property
      spapr: Rename DT functions to newer naming convention

Greg Kurz (2):
      spapr: Handle pending hot plug/unplug requests at CAS
      ppc: Officially deprecate the CPU "compat" property

Nicholas Piggin (8):
      ppc/spapr: Fix FWNMI machine check failure handling
      ppc/spapr: Change FWNMI names
      ppc/spapr: Add FWNMI System Reset state
      ppc/spapr: Fix FWNMI machine check interrupt delivery
      ppc/spapr: Allow FWNMI on TCG
      target/ppc: allow ppc_cpu_do_system_reset to take an alternate vect=
or
      ppc/spapr: Implement FWNMI System Reset delivery
      ppc/spapr: Ignore common "ibm,nmi-interlock" Linux bug

Philippe Mathieu-Daud=C3=A9 (8):
      hw/ppc/pnv: Fix typo in comment
      hw/scsi/viosrp: Add missing 'hw/scsi/srp.h' include
      hw/scsi/spapr_vscsi: Use SRP_MAX_IU_LEN instead of sizeof flexible =
array
      hw/scsi/spapr_vscsi: Simplify a bit
      hw/scsi/spapr_vscsi: Introduce req_iu() helper
      hw/scsi/spapr_vscsi: Do not mix SRP IU size with DMA buffer size
      hw/scsi/spapr_vscsi: Prevent buffer overflow
      hw/scsi/spapr_vscsi: Convert debug fprintf() to trace event

Shivaprasad G Bhat (1):
      spapr: Fix Coverity warning while validating nvdimm options

Vitaly Chikunov (1):
      target/ppc: Fix rlwinm on ppc64

 docs/system/deprecated.rst        |   7 +
 hw/intc/spapr_xive.c              |   4 +-
 hw/ppc/pnv_lpc.c                  |   2 +-
 hw/ppc/spapr.c                    | 980 ++++++++++++++++++++------------=
------
 hw/ppc/spapr_caps.c               |  19 +-
 hw/ppc/spapr_cpu_core.c           |  16 +-
 hw/ppc/spapr_events.c             |  51 +-
 hw/ppc/spapr_hcall.c              |  15 +-
 hw/ppc/spapr_nvdimm.c             |   7 +-
 hw/ppc/spapr_ovec.c               |   4 +-
 hw/ppc/spapr_rtas.c               |  45 +-
 hw/scsi/spapr_vscsi.c             |  72 +--
 hw/scsi/trace-events              |   1 +
 hw/scsi/viosrp.h                  |   3 +-
 include/hw/ppc/spapr.h            |  34 +-
 include/hw/ppc/spapr_cpu_core.h   |   4 +-
 include/hw/ppc/spapr_ovec.h       |   4 +-
 pc-bios/README                    |   2 +-
 pc-bios/slof.bin                  | Bin 931032 -> 965008 bytes
 roms/SLOF                         |   2 +-
 target/ppc/cpu-qom.h              |   1 +
 target/ppc/cpu.h                  |  28 +-
 target/ppc/excp_helper.c          |  79 ++-
 target/ppc/kvm.c                  |   5 +-
 target/ppc/kvm_ppc.h              |   7 +-
 target/ppc/mmu-hash64.c           | 319 +++++--------
 target/ppc/translate.c            |  20 +-
 target/ppc/translate_init.inc.c   | 116 ++---
 tests/qtest/libqos/libqos-spapr.h |   3 +-
 29 files changed, 930 insertions(+), 920 deletions(-)

