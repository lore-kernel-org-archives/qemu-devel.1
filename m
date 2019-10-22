Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F7EC47E49
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 05:56:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FFAC20B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 05:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=duncanthrax.net header.i=@duncanthrax.net header.b="lxNqpS9z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FFAC20B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stackframe.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMnA1-0002ga-6a
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 01:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58914)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <svens@stackframe.org>) id 1iMn84-000141-CY
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 01:54:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <svens@stackframe.org>) id 1iMn82-00009a-Dx
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 01:54:47 -0400
Received: from [2001:470:70c5:1111::170] (port=59628 helo=smtp.duncanthrax.net)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <svens@stackframe.org>)
 id 1iMn80-00008y-L4
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 01:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=duncanthrax.net; s=dkim; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From;
 bh=2kvEHosWmV+tAZmZuj8ngVg6xodpqFBTZxypl0Od740=; b=lxNqpS9zLVnSx/C6ZZ7GdIer62
 8Tbc0BLIUBN9b4E/za2w8WVSVYFdN/8qOnkA0FHfA8iwmN2jqvITNeu5b90UT/wbEciePaBq3boDZ
 qHxmZb+jjUh6gVZDi3nl9H12NSCXIoCARjy08LoWYQtsb6IPhXKqsmuFNeudrkIianMw=;
Received: from hsi-kbw-046-005-233-221.hsi8.kabel-badenwuerttemberg.de
 ([46.5.233.221] helo=x280.stackframe.org)
 by smtp.eurescom.eu with esmtpa (Exim 4.86_2)
 (envelope-from <svens@stackframe.org>)
 id 1iMn7v-00072u-2F; Tue, 22 Oct 2019 07:54:39 +0200
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <rth@twiddle.net>
Subject: [PATCH v2 0/6] HPPA: i82596, PS/2 and graphics emulation
Date: Tue, 22 Oct 2019 07:54:09 +0200
Message-Id: <20191022055415.18122-1-svens@stackframe.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:470:70c5:1111::170
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
 hw/display/Kconfig          |    3 +
 hw/display/Makefile.objs    |    1 +
 hw/display/artist.c         | 1336 +++++++++++++++++++++++++++++++++++
 hw/display/trace-events     |    9 +
 hw/hppa/Kconfig             |    3 +
 hw/hppa/Makefile.objs       |    2 +-
 hw/hppa/dino.c              |   94 ++-
 hw/hppa/hppa_hardware.h     |    1 +
 hw/hppa/hppa_sys.h          |    2 +
 hw/hppa/lasi.c              |  368 ++++++++++
 hw/hppa/machine.c           |   18 +-
 hw/hppa/trace-events        |   10 +
 hw/input/Kconfig            |    3 +
 hw/input/Makefile.objs      |    1 +
 hw/input/lasips2.c          |  289 ++++++++
 hw/input/ps2.c              |   11 +
 hw/input/trace-events       |    5 +
 hw/net/Kconfig              |    7 +
 hw/net/Makefile.objs        |    2 +
 hw/net/i82596.c             |  734 +++++++++++++++++++
 hw/net/i82596.h             |   55 ++
 hw/net/lasi_i82596.c        |  188 +++++
 hw/net/trace-events         |   13 +
 include/hw/input/lasips2.h  |   16 +
 include/hw/input/ps2.h      |    1 +
 include/hw/net/lasi_82596.h |   29 +
 pc-bios/hppa-firmware.img   |  Bin 783724 -> 772876 bytes
 roms/seabios-hppa           |    2 +-
 29 files changed, 3191 insertions(+), 16 deletions(-)
 create mode 100644 hw/display/artist.c
 create mode 100644 hw/hppa/lasi.c
 create mode 100644 hw/input/lasips2.c
 create mode 100644 hw/net/i82596.c
 create mode 100644 hw/net/i82596.h
 create mode 100644 hw/net/lasi_i82596.c
 create mode 100644 include/hw/input/lasips2.h
 create mode 100644 include/hw/net/lasi_82596.h

-- 
2.23.0


