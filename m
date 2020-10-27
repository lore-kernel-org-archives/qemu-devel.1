Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40674C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:21:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 059332072D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="TDfXwITN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 059332072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXPqj-0005Vs-4d
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 10:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kXPnN-0001j3-5a; Tue, 27 Oct 2020 10:17:53 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:53743 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kXPnJ-0007Ym-BN; Tue, 27 Oct 2020 10:17:52 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4CLDLY1kHZz9sWC; Wed, 28 Oct 2020 01:17:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1603808261;
 bh=F0pX3LIMNwaIgDa9sZ6D1M2PF7Aeh/2SmS0nH+epsU4=;
 h=From:To:Cc:Subject:Date:From;
 b=TDfXwITNE29eowi76b/L+yPyCt/JqdMRrEX7P+gihMR+9aHXXTdAZvuuEkftalJNH
 m7xmkA5kdWC3+huEAHQx/J2/PNStYd+pZwWOnDHo60+tDr1Hn9cH32P2sZT/lOTq1f
 M8pL6LXM/6HeWco6qp9nn/PP4wWAuCRW3ii8pYwg=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 00/18] ppc-for-5.2 queue 20201028
Date: Wed, 28 Oct 2020 01:17:17 +1100
Message-Id: <20201027141735.728821-1-david@gibson.dropbear.id.au>
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
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit d55450df995d6223486db11c66491cbf6c131523:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20201026a' into staging (2020-10-27 10:25:42 +0000)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-5.2-20201028

for you to fetch changes up to 136fbf654dd5fa88a5057dcc43947536f3b418df:

  ppc/: fix some comment spelling errors (2020-10-28 01:08:53 +1100)

----------------------------------------------------------------
ppc patch queue 2020-10-28

Here's the next pull request for ppc and spapr related patches, which
should be the last things for soft freeze.  Includes:

 * Numerous error handling cleanups from Greg Kurz
 * Cleanups to cpu realization and hotplug handling from Greg Kurz
 * A handful of other small fixes and cleanups

This does include a change to pc_dimm_plug() that isn't in my normal
areas of concern.  That's there as a a prerequisite for ppc specific
changes, and has an ack from Igor.

----------------------------------------------------------------
Elena Afanasova (1):
      hw/net: move allocation to the heap due to very large stack frame

Greg Kurz (15):
      spapr: Clarify why DR connectors aren't user creatable
      spapr: Move spapr_create_nvdimm_dr_connectors() to core machine code
      spapr: Fix leak of CPU machine specific data
      spapr: Unrealize vCPUs with qdev_unrealize()
      spapr: Drop spapr_delete_vcpu() unused argument
      spapr: Make spapr_cpu_core_unrealize() idempotent
      spapr: Simplify spapr_cpu_core_realize() and spapr_cpu_core_unrealize()
      pc-dimm: Drop @errp argument of pc_dimm_plug()
      spapr: Use appropriate getter for PC_DIMM_ADDR_PROP
      spapr: Use appropriate getter for PC_DIMM_SLOT_PROP
      spapr: Pass &error_abort when getting some PC DIMM properties
      spapr: Simplify error handling in spapr_memory_plug()
      spapr: Use error_append_hint() in spapr_reallocate_hpt()
      target/ppc: Fix kvmppc_load_htab_chunk() error reporting
      spapr: Improve spapr_reallocate_hpt() error reporting

Laurent Vivier (1):
      ppc/spapr: re-assert IRQs during event-scan if there are pending

zhaolichang (1):
      ppc/: fix some comment spelling errors

 accel/tcg/user-exec-stub.c      |  4 ++
 hw/arm/virt.c                   |  9 +----
 hw/i386/pc.c                    |  8 +---
 hw/mem/pc-dimm.c                |  2 +-
 hw/net/spapr_llan.c             |  5 ++-
 hw/ppc/spapr.c                  | 90 +++++++++++++++++++++--------------------
 hw/ppc/spapr_cpu_core.c         | 69 ++++++++++++++-----------------
 hw/ppc/spapr_drc.c              |  3 +-
 hw/ppc/spapr_events.c           | 12 ++++++
 hw/ppc/spapr_nvdimm.c           | 16 ++------
 include/hw/mem/pc-dimm.h        |  2 +-
 include/hw/ppc/spapr.h          |  3 +-
 include/hw/ppc/spapr_nvdimm.h   |  3 +-
 target/ppc/cpu.h                |  6 +--
 target/ppc/excp_helper.c        |  6 +--
 target/ppc/fpu_helper.c         |  2 +-
 target/ppc/internal.h           |  2 +-
 target/ppc/kvm.c                | 13 +++---
 target/ppc/kvm_ppc.h            |  5 ++-
 target/ppc/machine.c            |  2 +-
 target/ppc/mmu-hash64.c         |  2 +-
 target/ppc/mmu_helper.c         |  4 +-
 target/ppc/translate_init.c.inc |  4 +-
 23 files changed, 131 insertions(+), 141 deletions(-)

