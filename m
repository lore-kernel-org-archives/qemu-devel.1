Received: from eggs.gnu.org ([2001:4830:134:3::10]:41566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f99L8-0004xZ-6I
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 09:11:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f99L4-0000ZK-6F
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 09:11:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45246 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1f99L4-0000Xk-0p
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 09:11:02 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 19 Apr 2018 15:10:47 +0200
Message-Id: <20180419131051.11249-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] audio/hda: improve windows guest audio
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

Gerd Hoffmann (4):
  audio/hda: create millisecond timers that handle IO
  audio/hda: turn some dprintfs into trace points
  audio/hda: tweak timer adjust logic
  audio/hda: detect output buffer overruns and underruns

 include/hw/compat.h   |   7 ++
 hw/audio/hda-codec.c  | 300 ++++++++++++++++++++++++++++++++++++++++++++------
 hw/audio/intel-hda.c  |   7 --
 hw/audio/trace-events |   7 ++
 4 files changed, 283 insertions(+), 38 deletions(-)

-- 
2.9.3
