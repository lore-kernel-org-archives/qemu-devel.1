Received: from eggs.gnu.org ([2001:4830:134:3::10]:42356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fC2Ly-0007Ze-MS
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:19:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fC2Lx-00013I-Qd
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:19:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48738 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fC2Lx-00012V-Ly
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:19:53 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 27 Apr 2018 14:19:47 +0200
Message-Id: <20180427121951.29769-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/4] audio/hda: improve windows guest audio
 quality.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: martin@schrodt.org, Gerd Hoffmann <kraxel@redhat.com>

Based on a patch by Martin Schrodt.

v2: drop underrun detection, handle overruns only.

Gerd Hoffmann (4):
  audio/hda: create millisecond timers that handle IO
  audio/hda: turn some dprintfs into trace points
  audio/hda: tweak timer adjust logic
  audio/hda: detect output buffer overruns

 include/hw/compat.h   |   7 ++
 hw/audio/hda-codec.c  | 287 ++++++++++++++++++++++++++++++++++++++++++++------
 hw/audio/intel-hda.c  |   7 --
 hw/audio/trace-events |   6 ++
 4 files changed, 269 insertions(+), 38 deletions(-)

-- 
2.9.3
