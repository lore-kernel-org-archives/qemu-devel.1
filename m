Received: from eggs.gnu.org ([2001:4830:134:3::10]:37757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d7p5B-0007WC-1H
	for qemu-devel@nongnu.org; Mon, 08 May 2017 16:16:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d7p57-0002mT-S9
	for qemu-devel@nongnu.org; Mon, 08 May 2017 16:16:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43690)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d7p57-0002mM-MH
	for qemu-devel@nongnu.org; Mon, 08 May 2017 16:16:33 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 780C3C04B31F
	for <qemu-devel@nongnu.org>; Mon,  8 May 2017 20:16:32 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon,  8 May 2017 17:16:25 -0300
Message-Id: <20170508201628.32502-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/3] arch_init: Move soundhw code to
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
Cc: Gerd Hoffmann <kraxel@redhat.com>

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
 vl.c                                    |   3 +-
 hw/audio/Makefile.objs                  |   2 +
 14 files changed, 172 insertions(+), 136 deletions(-)
 rename include/hw/audio/{audio.h => soundhw.h} (81%)
 create mode 100644 hw/audio/soundhw.c

-- 
2.11.0.259.g40922b1
