Received: from eggs.gnu.org ([2001:4830:134:3::10]:44097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTYme-000234-LS
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 13:47:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTYmb-0002id-KX
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 13:47:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cTYmb-0002ht-E8
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 13:47:01 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8B6C637EE1
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 18:47:01 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 17 Jan 2017 16:46:35 -0200
Message-Id: <20170117184638.25809-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] arch_init: Move soundhw code to
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
