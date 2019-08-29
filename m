Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA92CC3A5A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 06:14:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB619215EA
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 06:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="UmCoksk1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB619215EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3Dha-0001Je-KR
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 02:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35164)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i3Dbw-0004CM-SS
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 02:08:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i3Dbu-0003ah-NO
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 02:08:44 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:53443)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i3Dbt-0003Wy-VV; Thu, 29 Aug 2019 02:08:42 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46JscK5n5yz9s7T; Thu, 29 Aug 2019 16:08:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1567058913;
 bh=H5kKHasB5DdHAbSB05m5/w7BFTEl219N/5gsJITToyA=;
 h=From:To:Cc:Subject:Date:From;
 b=UmCoksk1cYaXLIO/E5e9A7iBRECmzN4uJrU02E6zWxp5w5vM2RrUgcQwsZVHcJNbf
 Kjx+3n4puHMNudEZWvrsirpO75DL94RNP+dBKWN3o+wbARvtAmJ5h2m5ZvFNKkYKMY
 7JyKThF3H0HGiXXmpim21vBaZi56+kbD7mwRevfQ=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Thu, 29 Aug 2019 16:08:08 +1000
Message-Id: <20190829060827.25731-1-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 00/19] ppc-for-4.2 queue 20190829
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, groug@kaod.org, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 23919ddfd56135cad3cb468a8f54d5a595f024=
f4:

  Merge remote-tracking branch 'remotes/aperard/tags/pull-xen-20190827' i=
nto staging (2019-08-27 15:52:36 +0100)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-4.2-20190829

for you to fetch changes up to b1e815674343a171e51ce447495957e289091e9f:

  spapr: Set compat mode in spapr_core_plug() (2019-08-29 09:46:07 +1000)

----------------------------------------------------------------
ppc patch queue 2018-08-29

Another pull request for ppc-for-4.2.  Includes

  * Several powernv patches which were pulled last minute from the
    last PULL, now that some problems with them have been sorted out
  * A fix for -no-reboot which has been broken since the
    pseries-rhel4.1.0 machine type
  * Add some host threads information which AIX guests will need to
    properly scale the PURR and SPURR
  * Change behaviour to match x86 when unplugging function 0 of a
    multifunction PCI device
  * A number of TCG fixes in FPU emulation

And a handful of other assorted fixes and cleanups.

----------------------------------------------------------------
Alexey Kardashevskiy (2):
      pseries: Update SLOF firmware image
      spapr_pci: Advertise BAR reallocation capability

C=C3=A9dric Le Goater (4):
      ppc/pnv: add more dummy XSCOM addresses for the P9 CAPP
      ppc/pnv: Generate phandle for the "interrupt-parent" property
      ppc/pnv: Introduce PowerNV machines with fixed CPU models
      tests/boot-serial-test: add support for all the PowerNV machines

Daniel Henrique Barboza (1):
      spapr_pci: remove all child functions in function zero unplug

David Gibson (1):
      spapr: Use SHUTDOWN_CAUSE_SUBSYSTEM_RESET for CAS reboots

Greg Kurz (2):
      spapr/pci: Convert types to QEMU coding style
      spapr: Set compat mode in spapr_core_plug()

Joel Stanley (2):
      ppc/pnv: Set default ram size to 1.75GB
      ppc/pnv: update skiboot to v6.4

Laurent Vivier (1):
      pseries: Fix compat_pvr on reset

Paul A. Clarke (2):
      ppc: Fix xsmaddmdp and friends
      ppc: Fix xscvdpspn for SNAN

Richard Henderson (2):
      target/ppc: Set float_tininess_before_rounding at cpu reset
      target/ppc: Fix do_float_check_status vs inexact

Stefan Brankovic (1):
      target/ppc: Refactor emulation of vmrgew and vmrgow instructions

Suraj Jitindar Singh (1):
      powerpc/spapr: Add host threads parameter to ibm,get_system_paramet=
er

 hw/ppc/pnv.c                        |  81 ++++++++++++++++++++++++++++++=
++----
 hw/ppc/pnv_xscom.c                  |  20 +++++++++
 hw/ppc/spapr.c                      |  29 +++++++++++--
 hw/ppc/spapr_cpu_core.c             |   5 ---
 hw/ppc/spapr_hcall.c                |   2 +-
 hw/ppc/spapr_pci.c                  |  40 +++++++++---------
 hw/ppc/spapr_pci_nvlink2.c          |  40 +++++++++---------
 hw/ppc/spapr_rtas.c                 |  15 +++++++
 include/hw/pci-host/spapr.h         |  24 ++++++-----
 include/hw/ppc/spapr.h              |   1 +
 pc-bios/README                      |   2 +-
 pc-bios/skiboot.lid                 | Bin 1591384 -> 1667280 bytes
 pc-bios/slof.bin                    | Bin 926784 -> 930656 bytes
 roms/SLOF                           |   2 +-
 roms/skiboot                        |   2 +-
 target/ppc/cpu-qom.h                |   1 +
 target/ppc/fpu_helper.c             |  42 +++++++++++++++----
 target/ppc/translate/vmx-impl.inc.c |  66 ++++++++++++++++-------------
 target/ppc/translate/vsx-impl.inc.c |   2 +-
 target/ppc/translate_init.inc.c     |   6 +++
 tests/boot-serial-test.c            |   3 +-
 tests/pnv-xscom-test.c              |  16 ++++++-
 22 files changed, 289 insertions(+), 110 deletions(-)

