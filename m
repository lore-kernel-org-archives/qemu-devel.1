Received: from eggs.gnu.org ([2001:4830:134:3::10]:38460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gRXBl-0001n7-ST
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 01:49:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gRXBi-0001Ly-Rn
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 01:49:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gRXBi-0001GG-JM
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 01:49:38 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AE9BB80F7B
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 06:49:36 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 27 Nov 2018 07:49:26 +0100
Message-Id: <20181127064932.7299-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/6] Fixes 31 20181127 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>

The following changes since commit 5298f4d67a911dd9cefa4c4185eed242074d64=
c2:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into sta=
ging (2018-11-23 08:54:52 +0000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/fixes-31-20181127-pull-request

for you to fetch changes up to e1ca8f7e1915496148f6e0ce1f7c2309af013312:

  qapi: add query-display-options command (2018-11-27 07:47:57 +0100)

----------------------------------------------------------------
various bugfixes for 3.1: fmops, ps2, cirrus, hda, usb-host, qapi

----------------------------------------------------------------

Gerd Hoffmann (3):
  fmops: fix off-by-one in AR_TABLE and DR_TABLE array size
  audio/hda: fix guest triggerable assert
  qapi: add query-display-options command

Herv=C3=A9 Poussineau (1):
  ps2kbd: default to scan enabled after reset

Wang Xin (1):
  cirrus_vga/migration: update the bank offset before use

linzhecheng (1):
  usb-host: set ifs.detached as true if kernel driver is not active

 hw/audio/fmopl.h        |  4 ++--
 hw/audio/intel-hda.c    |  6 ++++++
 hw/display/cirrus_vga.c |  7 ++++---
 hw/input/ps2.c          |  2 +-
 hw/usb/host-libusb.c    |  3 +++
 vl.c                    |  6 ++++++
 qapi/ui.json            | 13 +++++++++++++
 7 files changed, 35 insertions(+), 6 deletions(-)

--=20
2.9.3
