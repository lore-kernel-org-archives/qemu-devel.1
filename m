Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AA9C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 05:39:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 795322078C
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 05:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Uh44WCHJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 795322078C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdomy-0003Kr-Il
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 01:39:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jdolj-00015T-6m; Wed, 27 May 2020 01:38:23 -0400
Received: from ozlabs.org ([203.11.71.1]:35639)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jdolg-0001br-RS; Wed, 27 May 2020 01:38:22 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49X03q1Gwcz9sSd; Wed, 27 May 2020 15:38:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1590557895;
 bh=P20zmXgZeVw3tlpqdOCU79Zdnez1v4tVVXdtG7lBac8=;
 h=From:To:Cc:Subject:Date:From;
 b=Uh44WCHJRw8jN97krDHHTwPp5M2GtQCgdN76ADE82EvtbmHXq1uyIxVsAsBZOKdQQ
 nIJUtUWnI/x1TYKkUmt1p/79VvNw2Kwmq0zjFQ4VS2DgGzq2QS9BGGAYAAOXZD3riC
 mTLTK6FhtrQybv4cS+xBDOBuRnDv9kskWKfG58b4=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 00/15] ppc-for-5.1 queue 20200527
Date: Wed, 27 May 2020 15:37:54 +1000
Message-Id: <20200527053809.356168-1-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 01:38:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, philmd@redhat.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit ddc760832fa8cf5e93b9d9e6e854a5114ac63510:

  Merge remote-tracking branch 'remotes/gkurz/tags/9p-next-2020-05-26' into staging (2020-05-26 14:05:53 +0100)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-5.1-20200527

for you to fetch changes up to 9c7c0407028355ca83349b8a60fddfad46f2ebd8:

  vfio/nvlink: Remove exec permission to avoid SELinux AVCs (2020-05-27 15:29:36 +1000)

----------------------------------------------------------------
ppc patch queue 2020-05-27

Here's the next pull request for qemu-5.1.  It includes:
 * Support for the scv and rfscv POWER9 instructions in TCG
 * Support for the new SPAPR_LMB_FLAGS_HOTREMOVABLE flag, which
   provides a way for guests to know memory which should be removable
   (so the guest can avoid putting immovable allocations there).
 * Some fixes for the recently added partition scope radix translation
   in softmmu
 * Assorted minor fixes and cleanups

It includes one patch to avoid a clash with SELinux when using NVLink
VFIO devices.  That's not technically within the files under my
maintainership, but it is in a section of the VFIO quirks code that's
specific to the POWER-only NVLink devices, and has an ack from Alex
Williamson.

----------------------------------------------------------------
Cédric Le Goater (1):
      ppc/spapr: add a POWER10 CPU model

Greg Kurz (8):
      target/ppc: Untabify excp_helper.c
      target/ppc: Pass const pointer to ppc_radix64_get_prot_amr()
      target/ppc: Pass const pointer to ppc_radix64_get_fully_qualified_addr()
      target/ppc: Don't initialize some local variables in ppc_radix64_xlate()
      target/ppc: Add missing braces in ppc_radix64_partition_scoped_xlate()
      target/ppc: Fix arguments to ppc_radix64_partition_scoped_xlate()
      target/ppc: Don't update radix PTE R/C bits with gdbstub
      target/ppc: Fix argument to ppc_radix64_partition_scoped_xlate() again

Leonardo Bras (2):
      ppc/spapr: Add hotremovable flag on DIMM LMBs on drmem_v2
      vfio/nvlink: Remove exec permission to avoid SELinux AVCs

Nicholas Piggin (2):
      ppc/pnv: Fix NMI system reset SRR1 value
      target/ppc: Add support for scv and rfscv instructions

Philippe Mathieu-Daudé (2):
      hw/pci-bridge/dec: Remove dead debug code
      hw/nvram/mac_nvram: Convert debug printf()s to trace events

 hw/nvram/mac_nvram.c            |  17 +-----
 hw/nvram/trace-events           |   4 ++
 hw/pci-bridge/dec.c             |  10 ----
 hw/ppc/pnv.c                    |  26 ++++++--
 hw/ppc/spapr.c                  |   3 +-
 hw/ppc/spapr_cpu_core.c         |   1 +
 hw/vfio/pci-quirks.c            |   4 +-
 include/hw/ppc/spapr.h          |   1 +
 linux-user/ppc/cpu_loop.c       |   1 +
 target/ppc/cpu.h                |  28 ++++++++-
 target/ppc/excp_helper.c        | 130 +++++++++++++++++++++++++++-------------
 target/ppc/helper.h             |   1 +
 target/ppc/mmu-radix64.c        |  53 +++++++++-------
 target/ppc/mmu-radix64.h        |   4 +-
 target/ppc/translate.c          |  53 +++++++++++++++-
 target/ppc/translate_init.inc.c |   3 +-
 16 files changed, 237 insertions(+), 102 deletions(-)

