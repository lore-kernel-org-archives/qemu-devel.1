Received: from eggs.gnu.org ([2001:4830:134:3::10]:34629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6B1t-0001UB-Ve
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6B1p-0004Xu-Dt
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d6B1p-0004XT-5W
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:21 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3D55783F45
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 07:18:20 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  4 May 2017 09:17:41 +0200
Message-Id: <20170504071811.3547-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/30] audio patch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

  Hi,

First audio pull for 2.10, with a bunch of cleanups sent during the
freeze, and two memory leak fixes.

please pull,
  Gerd

The following changes since commit e619b14746e5d8c0e53061661fd0e1da01fd4d=
60:

  Merge remote-tracking branch 'sthibault/tags/samuel-thibault' into stag=
ing (2017-05-02 15:16:29 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/pull-audio-20170504-1

for you to fetch changes up to 9ea5ada76f34a0ef048b131c3a166d8564199bdb:

  audio: Use ARRAY_SIZE from qemu/osdep.h (2017-05-04 09:16:05 +0200)

----------------------------------------------------------------
audio: cleanups, bugfixes (memory leaks).

----------------------------------------------------------------
Gerd Hoffmann (1):
      audio: release capture buffers

Juan Quintela (26):
      adlib: Remove support for YMF262
      audio: remove Y8950 configuration
      audio: Remove YM3526 support
      audio: YM3812 was always defined
      audio: Remove UINT8
      audio: remove UINT16
      audio: remove UINT32
      audio: Remove INT8
      audio: remove INT16
      audio: Remove INT32
      audio: Unfold OPLSAMPLE
      audio: Remove Unused OPL_TYPE_*
      audio: Remove type field
      audio: Remove unused fields
      audio: GUSbyte is uint8_t
      audio: remove GUSchar
      audio: GUSword is uint16_t
      audio: GUSword is uint16_t
      audio: GUSsample is int16_t
      audio: OPLSetIRQHandler is not used anywhere
      audio: OPLSetUpdateHandler is not used anywhere
      audio: IRQHandler is not used anymore
      audio: UpdateHandler is not used anymore
      audio: Remove unused typedefs
      audio: un-export OPLResetChip
      audio: Use ARRAY_SIZE from qemu/osdep.h

Marc-Andr=C3=A9 Lureau (1):
      audio: fix WAVState leak

Zihan Yang (2):
      hw/audio: replace exit with unrealize in hda_codec_device_class_ini=
t
      hw/audio: convert exit callback in HDACodecDeviceClass to void

 hw/audio/fmopl.h        | 175 +++++++++---------------------
 hw/audio/gusemu.h       |  22 +---
 hw/audio/intel-hda.h    |   2 +-
 audio/audio.c           |   2 +
 audio/wavcapture.c      |   1 +
 hw/audio/adlib.c        |  47 +-------
 hw/audio/fmopl.c        | 277 ++++++++----------------------------------=
------
 hw/audio/gus.c          |   2 +-
 hw/audio/gusemu_hal.c   |  74 ++++++-------
 hw/audio/gusemu_mixer.c |  28 ++---
 hw/audio/hda-codec.c    |   3 +-
 hw/audio/intel-hda.c    |   5 +-
 hw/audio/Makefile.objs  |   2 -
 13 files changed, 160 insertions(+), 480 deletions(-)
