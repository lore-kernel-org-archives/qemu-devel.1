Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B76C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 23:26:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C074520674
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 23:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jwpp8OhU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C074520674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jELb7-0002wo-UV
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 19:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52017)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1jELYr-0007Zu-0h
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:23:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1jELYp-00071D-OD
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:23:48 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:24394)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1jELYp-0006wY-Jx
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:23:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584487427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cHahSNwiZ0S11GGhmVAClzZQAiWGWz7RJWNwKdBbvT4=;
 b=Jwpp8OhUobwEWf0OulpCymLOzlG8NPCM6Y6RnhWz7RiwF+jNH54G63B2q10d2KYqNsHpAF
 ByyGi0tZneqFKeA6T3hcuReti6jbCstZePX+G8cneaXlHb32/s/KLxeDnksUndYKKZS/Rd
 VoN6t9Qmt6f4BZa5Gyyf/TXKdQdZQrc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-gQ2wartjNcKfTjFyosUaNg-1; Tue, 17 Mar 2020 19:23:45 -0400
X-MC-Unique: gQ2wartjNcKfTjFyosUaNg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 362F98010C7;
 Tue, 17 Mar 2020 23:23:43 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-191.rdu2.redhat.com [10.10.112.191])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 20D9160BE0;
 Tue, 17 Mar 2020 23:23:29 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/20] Ide patches
Date: Tue, 17 Mar 2020 19:23:09 -0400
Message-Id: <20200317232329.22362-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Helge Deller <deller@gmx.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>, John Snow <jsnow@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 373c7068dd610e97f0b551b5a6d0a27cd6da4506=
:

  qemu.nsi: Install Sphinx documentation (2020-03-09 16:45:00 +0000)

are available in the Git repository at:

  https://github.com/jnsnow/qemu.git tags/ide-pull-request

for you to fetch changes up to 7d0776ca7f853d466b6174d96daa5c8afc43d1a4:

  hw/ide: Remove unneeded inclusion of hw/ide.h (2020-03-17 12:22:36 -0400)

----------------------------------------------------------------
Pull request

----------------------------------------------------------------

BALATON Zoltan (10):
  ide/via: Get rid of via_ide_init()
  pci: Honour wmask when resetting PCI_INTERRUPT_LINE
  hw/ide: Get rid of piix3_init functions
  hw/isa/piix4.c: Introduce variable to store devfn
  hw/ide: Get rid of piix4_init function
  hw/ide: Remove now unneded #include "hw/pci/pci.h" from hw/ide.h
  hw/ide/pci.c: Coding style update to fix checkpatch errors
  hw/ide: Do ide_drive_get() within pci_ide_create_devs()
  hw/ide: Move MAX_IDE_DEVS define to hw/ide/internal.h
  hw/ide: Remove unneeded inclusion of hw/ide.h

Mark Cave-Ayland (9):
  cmd646: register cmd646_reset() function in DeviceClass
  cmd646: register vmstate_ide_pci VMStateDescription in DeviceClass
  dp264: use pci_create_simple() to initialise the cmd646 device
  cmd646: remove unused pci_cmd646_ide_init() function
  via-ide: move registration of VMStateDescription to DeviceClass
  via-ide: ensure that PCI_INTERRUPT_LINE is hard-wired to its default
    value
  via-ide: initialise IDE controller in legacy mode
  via-ide: allow guests to write to PCI_CLASS_PROG
  via-ide: always use legacy IRQ 14/15 routing

Markus Armbruster (1):
  hd-geo-test: Clean up use of buf[] in create_qcow2_with_mbr()

 hw/hppa/hppa_sys.h            |  1 -
 hw/ide/ahci_internal.h        |  1 +
 include/hw/ide.h              |  9 ---------
 include/hw/ide/internal.h     |  2 ++
 include/hw/ide/pci.h          |  3 ++-
 include/hw/misc/macio/macio.h |  1 +
 include/hw/southbridge/piix.h |  3 +--
 hw/alpha/dp264.c              | 11 ++++-------
 hw/hppa/machine.c             |  1 -
 hw/i386/pc_piix.c             | 18 +++++++++---------
 hw/ide/cmd646.c               | 21 ++++-----------------
 hw/ide/pci.c                  | 11 +++++++----
 hw/ide/piix.c                 | 31 +------------------------------
 hw/ide/via.c                  | 21 +++++----------------
 hw/isa/piix4.c                | 23 ++++++++++-------------
 hw/mips/mips_fulong2e.c       |  8 ++++----
 hw/mips/mips_malta.c          |  2 +-
 hw/mips/mips_r4k.c            |  1 +
 hw/pci/pci.c                  |  5 ++++-
 hw/ppc/mac_newworld.c         |  1 -
 hw/ppc/mac_oldworld.c         |  1 -
 hw/ppc/prep.c                 |  1 -
 hw/sparc64/sun4u.c            |  6 +-----
 tests/qtest/hd-geo-test.c     |  6 +++---
 24 files changed, 61 insertions(+), 127 deletions(-)

--=20
2.21.1


