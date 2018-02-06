Received: from eggs.gnu.org ([2001:4830:134:3::10]:56381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ej9Ga-00032u-1k
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:50:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ej9GW-0003sW-Qt
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:50:55 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40144 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ej9GW-0003rh-GR
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:50:52 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 30DCA40A0971
	for <qemu-devel@nongnu.org>; Tue,  6 Feb 2018 19:50:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
	[10.36.116.148])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E529B946A0
	for <qemu-devel@nongnu.org>; Tue,  6 Feb 2018 19:50:45 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  6 Feb 2018 20:50:30 +0100
Message-Id: <20180206195044.8347-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/14] Error reporting patches for 2018-02-06
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 20e0d439a6ded635ec89f6135c08cd5541c689=
62:

  Merge remote-tracking branch 'remotes/rth/tags/pull-hppa-20180204' into=
 staging (2018-02-06 14:21:41 +0000)

are available in the git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-error-2018-02-06

for you to fetch changes up to 493d89bf74d17fa304b7a02f531b024df2003fea:

  tcg: Replace fprintf(stderr, "*\n" with error_report() (2018-02-06 18:2=
9:46 +0100)

----------------------------------------------------------------
Error reporting patches for 2018-02-06

----------------------------------------------------------------
Alistair Francis (13):
      audio: Replace AUDIO_FUNC with __func__
      hw/arm: Replace fprintf(stderr, "*\n" with error_report()
      hw/dma: Replace fprintf(stderr, "*\n" with error_report()
      hw/lm32: Replace fprintf(stderr, "*\n" with error_report()
      hw/mips: Replace fprintf(stderr, "*\n" with error_report()
      hw/moxie: Replace fprintf(stderr, "*\n" with error_report()
      hw/openrisc: Replace fprintf(stderr, "*\n" with error_report()
      hw/pci*: Replace fprintf(stderr, "*\n" with error_report()
      hw/ppc: Replace fprintf(stderr, "*\n" with error_report()
      hw/sd: Replace fprintf(stderr, "*\n" with DPRINTF()
      hw/sparc*: Replace fprintf(stderr, "*\n" with error_report()
      hw/xen*: Replace fprintf(stderr, "*\n" with error_report()
      tcg: Replace fprintf(stderr, "*\n" with error_report()

Markus Armbruster (1):
      error: Improve documentation of error_append_hint()

 audio/alsaaudio.c          |  4 ++--
 audio/audio.c              | 40 ++++++++++++++++-----------------
 audio/audio_int.h          |  6 -----
 audio/audio_pt_int.c       | 28 +++++++++++------------
 audio/audio_template.h     | 26 ++++++++++-----------
 audio/dsoundaudio.c        |  2 +-
 audio/mixeng.c             |  2 +-
 audio/ossaudio.c           | 10 ++++-----
 audio/paaudio.c            | 56 +++++++++++++++++++++++-----------------=
------
 audio/sdlaudio.c           |  2 +-
 audio/wavaudio.c           |  2 +-
 cpus.c                     | 10 ++++-----
 exec.c                     |  6 ++---
 hw/arm/armv7m.c            |  2 +-
 hw/arm/boot.c              | 16 ++++++-------
 hw/arm/gumstix.c           | 13 ++++++-----
 hw/arm/mainstone.c         |  7 +++---
 hw/arm/musicpal.c          |  2 +-
 hw/arm/omap1.c             |  5 +++--
 hw/arm/omap2.c             |  3 ++-
 hw/arm/omap_sx1.c          |  2 +-
 hw/arm/pxa2xx.c            |  7 +++---
 hw/arm/vexpress.c          |  8 +++----
 hw/arm/z2.c                |  6 ++---
 hw/dma/soc_dma.c           | 36 ++++++++++++++---------------
 hw/lm32/lm32_boards.c      |  7 +++---
 hw/lm32/milkymist.c        |  7 +++---
 hw/mips/mips_fulong2e.c    | 13 +++++------
 hw/mips/mips_jazz.c        |  4 ++--
 hw/mips/mips_malta.c       | 16 ++++++-------
 hw/mips/mips_mipssim.c     | 11 +++++----
 hw/mips/mips_r4k.c         | 16 ++++++-------
 hw/moxie/moxiesim.c        | 13 +++++------
 hw/openrisc/openrisc_sim.c |  4 ++--
 hw/pci-host/bonito.c       |  6 ++---
 hw/pci/pci.c               |  4 ++--
 hw/ppc/e500.c              | 16 ++++++-------
 hw/ppc/mac_newworld.c      |  2 +-
 hw/ppc/mac_oldworld.c      |  2 +-
 hw/ppc/ppc405_boards.c     | 15 +++++--------
 hw/ppc/ppc440_bamboo.c     | 16 ++++++-------
 hw/ppc/prep.c              |  4 ++--
 hw/ppc/virtex_ml507.c      |  4 ++--
 hw/sd/sd.c                 |  7 +++---
 hw/sparc/leon3.c           | 16 ++++++-------
 hw/sparc/sun4m.c           | 16 ++++++-------
 hw/sparc64/niagara.c       |  4 ++--
 hw/sparc64/sun4u.c         | 10 ++++-----
 hw/xen/xen-common.c        |  5 +++--
 hw/xenpv/xen_machine_pv.c  |  9 ++++----
 include/qapi/error.h       |  8 +++++++
 vl.c                       |  2 +-
 52 files changed, 265 insertions(+), 273 deletions(-)

--=20
2.13.6
