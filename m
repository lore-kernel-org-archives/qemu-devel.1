Received: from eggs.gnu.org ([2001:4830:134:3::10]:45902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d7piz-0006jt-9z
	for qemu-devel@nongnu.org; Mon, 08 May 2017 16:57:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d7piu-0001bG-DD
	for qemu-devel@nongnu.org; Mon, 08 May 2017 16:57:45 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon,  8 May 2017 17:57:32 -0300
Message-Id: <20170508205735.23444-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/3] arch_init: Move soundhw code to
 hw/audio/soundhw.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, hpoussin@reactos.org, Gerd Hoffmann <kraxel@redhat.com>, agraf@suse.de

Changes v2 -> v3:
* Build fix: update hw/ppc/prep.c too

Changes v1 -> v2:
* Rebase to latest qemu.git master

This moves the arch_init.c soundhw code to its own file, renames
audio_init() to soundhw_init(), and renames hw/audio/audio.h to
hw/audio/soundhw.h.

Eduardo Habkost (3):
  audio: Move arch_init audio code to hw/audio/soundhw.c
  audio: Rename audio_init() to soundhw_init()
  audio: Rename hw/audio/audio.h to hw/audio/soundhw.h

 include/hw/audio/{audio.h => soundhw.h} |   3 +
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
 hw/audio/soundhw.c                      | 156 ++++++++++++++++++++++++++++++++
 hw/ppc/prep.c                           |   3 +-
 vl.c                                    |   3 +-
 hw/audio/Makefile.objs                  |   2 +
 15 files changed, 174 insertions(+), 137 deletions(-)
 rename include/hw/audio/{audio.h => soundhw.h} (81%)
 create mode 100644 hw/audio/soundhw.c

-- 
2.11.0.259.g40922b1
