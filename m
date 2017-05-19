Received: from eggs.gnu.org ([2001:4830:134:3::10]:51242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dBg1B-00077P-Cz
	for qemu-devel@nongnu.org; Fri, 19 May 2017 07:24:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dBg17-00023T-Cu
	for qemu-devel@nongnu.org; Fri, 19 May 2017 07:24:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dBg17-00022f-6o
	for qemu-devel@nongnu.org; Fri, 19 May 2017 07:24:21 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0DA4CC056792
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 11:24:20 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 19 May 2017 13:24:12 +0200
Message-Id: <20170519112415.19191-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/3] audio patch queue.
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

Smallish audio patch queue, renaming moving soundhw init code.

please pull,
  Gerd

The following changes since commit 56821559f0ba682fe6b367815572e6f974d329=
ab:

  Merge remote-tracking branch 'dgilbert/tags/pull-hmp-20170517' into sta=
ging (2017-05-18 13:36:15 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/pull-audio-20170519-1

for you to fetch changes up to 8a824e4d74213a2da39323304f949c5b4243e1fb:

  audio: Rename hw/audio/audio.h to hw/audio/soundhw.h (2017-05-19 10:48:=
54 +0200)

----------------------------------------------------------------
audio: move & rename soundhw init code.

----------------------------------------------------------------
Eduardo Habkost (3):
      audio: Move arch_init audio code to hw/audio/soundhw.c
      audio: Rename audio_init() to soundhw_init()
      audio: Rename hw/audio/audio.h to hw/audio/soundhw.h

 include/hw/audio/{audio.h =3D> soundhw.h} |   3 +
 include/sysemu/arch_init.h              |   2 -
 arch_init.c                             | 126 +-------------------------
 hw/audio/ac97.c                         |   2 +-
 hw/audio/adlib.c                        |   2 +-
 hw/audio/cs4231a.c                      |   2 +-
 hw/audio/es1370.c                       |   2 +-
 hw/audio/gus.c                          |   2 +-
 hw/audio/intel-hda.c                    |   2 +-
 hw/audio/pcspk.c                        |   2 +-
 hw/audio/sb16.c                         |   2 +-
 hw/audio/soundhw.c                      | 156 ++++++++++++++++++++++++++=
++++++
 hw/ppc/prep.c                           |   3 +-
 vl.c                                    |   3 +-
 hw/audio/Makefile.objs                  |   2 +
 15 files changed, 174 insertions(+), 137 deletions(-)
 rename include/hw/audio/{audio.h =3D> soundhw.h} (81%)
 create mode 100644 hw/audio/soundhw.c
