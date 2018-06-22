Received: from eggs.gnu.org ([2001:4830:134:3::10]:55769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fWJz4-0005vu-Uw
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 07:12:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fWJz2-0001fc-OH
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 07:12:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46924 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fWJz2-0001fA-KT
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 07:12:04 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 22 Jun 2018 13:11:55 +0200
Message-Id: <20180622111200.30561-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v4 0/5] audio/hda: improve windows guest audio
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
Cc: martin@schrodt.org, maxehr@umiacs.umd.edu, Gerd Hoffmann <kraxel@redhat.com>

Based on a patch by Martin Schrodt.

v4: rebase to latest master, move enable-by-default to separate patch.
v3: rebase to latest master, solve compat.h conflict.
v2: drop underrun detection, handle overruns only.

Gerd Hoffmann (5):
  audio/hda: create millisecond timers that handle IO
  audio/hda: turn some dprintfs into trace points
  audio/hda: tweak timer adjust logic
  audio/hda: detect output buffer overruns
  audio/hda: enable new timer code by default.

 include/hw/compat.h   |   4 +
 hw/audio/hda-codec.c  | 287 ++++++++++++++++++++++++++++++++++++++++++++------
 hw/audio/intel-hda.c  |   7 --
 hw/audio/trace-events |   6 ++
 4 files changed, 266 insertions(+), 38 deletions(-)

-- 
2.9.3
