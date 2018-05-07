Received: from eggs.gnu.org ([2001:4830:134:3::10]:43175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fFcjH-0003p6-F5
	for qemu-devel@nongnu.org; Mon, 07 May 2018 05:46:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fFcjG-000670-Nj
	for qemu-devel@nongnu.org; Mon, 07 May 2018 05:46:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45828 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fFcjG-00066Y-JC
	for qemu-devel@nongnu.org; Mon, 07 May 2018 05:46:46 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  7 May 2018 11:46:38 +0200
Message-Id: <20180507094642.5909-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/4] audio/hda: improve windows guest audio
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

v3: rebase to latest master, solve compat.h conflict.
v2: drop underrun detection, handle overruns only.

Gerd Hoffmann (4):
  audio/hda: create millisecond timers that handle IO
  audio/hda: turn some dprintfs into trace points
  audio/hda: tweak timer adjust logic
  audio/hda: detect output buffer overruns

 include/hw/compat.h   |   7 +-
 hw/audio/hda-codec.c  | 287 ++++++++++++++++++++++++++++++++++++++++++++------
 hw/audio/intel-hda.c  |   7 --
 hw/audio/trace-events |   6 ++
 4 files changed, 268 insertions(+), 39 deletions(-)

-- 
2.9.3
