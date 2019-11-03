Return-Path: <SRS0=n1BB=Y3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D62CA9ED0
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2019 20:59:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4798921744
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2019 20:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=duncanthrax.net header.i=@duncanthrax.net header.b="ufdLtRta"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4798921744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stackframe.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRMyA-0001gy-5v
	for qemu-devel@archiver.kernel.org; Sun, 03 Nov 2019 15:59:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51359)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <svens@stackframe.org>) id 1iRMv3-0008JH-DG
 for qemu-devel@nongnu.org; Sun, 03 Nov 2019 15:56:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <svens@stackframe.org>) id 1iRMv2-0002JU-3S
 for qemu-devel@nongnu.org; Sun, 03 Nov 2019 15:56:17 -0500
Received: from shroom.duncanthrax.net ([2a01:4f8:121:41fa::169]:35105
 helo=smtp.duncanthrax.net)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <svens@stackframe.org>)
 id 1iRMv1-0002I1-IO
 for qemu-devel@nongnu.org; Sun, 03 Nov 2019 15:56:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=duncanthrax.net; s=dkim; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CqRKv3uM9FROhN85zVgUv4Joy2oKXjlzMfmtnodH/ps=; b=ufdLtRtaukHESXkvRtqbEaILGx
 7EHstj7UNEBQ3SC72HFZWsxcn2OeOYrsKRkQVMdPsLylhYvFA2FgrhPnIQvSN72JH8vvh/b5qrdWK
 4iwL4w4d34GLsNJka7mMuLlAGGCaqKBVl4FNg1stDN2oTeidGZZjC+pHpuD2Bmkn4G0E=;
Received: from hsi-kbw-046-005-233-221.hsi8.kabel-badenwuerttemberg.de
 ([46.5.233.221] helo=x280.stackframe.org)
 by smtp.duncanthrax.net with esmtpa (Exim 4.90_1)
 (envelope-from <svens@stackframe.org>)
 id 1iRMux-00059W-4z; Sun, 03 Nov 2019 21:56:11 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <rth@twiddle.net>
Subject: [PATCH v4 0/6] HPPA: i82596, PS/2 and graphics emulation
Date: Sun,  3 Nov 2019 21:56:01 +0100
Message-Id: <20191103205607.6590-1-svens@stackframe.org>
X-Mailer: git-send-email 2.24.0.rc2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:4f8:121:41fa::169
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
Cc: Helge Deller <deller@gmx.de>, Sven Schnelle <svens@stackframe.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

these series adds quite a lot to the HPPA emulation in QEMU:
i82596 emulation from Helge, PS/2 and Artist graphics emulation.

See https://parisc.wiki.kernel.org/index.php/Qemu for a few screenshots
of QEMU running a X11/CDE session in HP-UX.

changes in v4:
 - introduce Artist-internal address space
 - rewrite screen update functions to use the generic framebuffer routines
 - use dirty bitmap code to not always redraw the whole screen

Changes in v3:
 - use BIT() macro in gsc_to_pci_forwarding()
 - fix version id in vm state
 - fix an error in the PS/2 KBD_CMD_SET_MAKE_BREAK implementation

Changes in v2:
 - dropped 'hppa: remove ISA region' as that patch requires some more work
 - added shortlog to seabios update
 - use const and MAKE_64BIT_MASK in dino.c

Regards,
Sven

Helge Deller (2):
  hw/hppa/dino.c: Improve emulation of Dino PCI chip
  hppa: Add support for LASI chip with i82596 NIC

Sven Schnelle (4):
  ps2: accept 'Set Key Make and Break' commands
  hppa: add emulation of LASI PS2 controllers
  hppa: Add emulation of Artist graphics
  seabios-hppa: update to latest version

 MAINTAINERS                 |    4 +-
 hw/display/Kconfig          |    4 +
 hw/display/Makefile.objs    |    1 +
 hw/display/artist.c         | 1449 +++++++++++++++++++++++++++++++++++
 hw/display/trace-events     |    9 +
 hw/hppa/Kconfig             |    3 +
 hw/hppa/Makefile.objs       |    2 +-
 hw/hppa/dino.c              |   97 ++-
 hw/hppa/hppa_hardware.h     |    1 +
 hw/hppa/hppa_sys.h          |    2 +
 hw/hppa/lasi.c              |  368 +++++++++
 hw/hppa/machine.c           |   17 +-
 hw/hppa/trace-events        |   10 +
 hw/input/Kconfig            |    3 +
 hw/input/Makefile.objs      |    1 +
 hw/input/lasips2.c          |  289 +++++++
 hw/input/ps2.c              |   15 +
 hw/input/trace-events       |    5 +
 hw/net/Kconfig              |    7 +
 hw/net/Makefile.objs        |    2 +
 hw/net/i82596.c             |  734 ++++++++++++++++++
 hw/net/i82596.h             |   55 ++
 hw/net/lasi_i82596.c        |  188 +++++
 hw/net/trace-events         |   14 +
 include/hw/input/lasips2.h  |   16 +
 include/hw/input/ps2.h      |    1 +
 include/hw/net/lasi_82596.h |   29 +
 pc-bios/hppa-firmware.img   |  Bin 783724 -> 772876 bytes
 roms/seabios-hppa           |    2 +-
 29 files changed, 3310 insertions(+), 18 deletions(-)
 create mode 100644 hw/display/artist.c
 create mode 100644 hw/hppa/lasi.c
 create mode 100644 hw/input/lasips2.c
 create mode 100644 hw/net/i82596.c
 create mode 100644 hw/net/i82596.h
 create mode 100644 hw/net/lasi_i82596.c
 create mode 100644 include/hw/input/lasips2.h
 create mode 100644 include/hw/net/lasi_82596.h

-- 
2.24.0.rc2


