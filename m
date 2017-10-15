Received: from eggs.gnu.org ([2001:4830:134:3::10]:34364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <spheenik@zoidberg.machine.schrodt.org>)
	id 1e3lnU-00059Y-Kl
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 12:29:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <spheenik@zoidberg.machine.schrodt.org>)
	id 1e3lnP-0000Le-RY
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 12:29:52 -0400
Received: from hermes.schrodt.org ([2a01:488:66:1000:b24d:49f5:0:1]:40596)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <spheenik@zoidberg.machine.schrodt.org>)
	id 1e3lnP-0000Kx-L7
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 12:29:47 -0400
From: Martin Schrodt <martin@schrodt.org>
Date: Sun, 15 Oct 2017 18:29:42 +0200
Message-Id: <20171015162944.4538-1-martin@schrodt.org>
Subject: [Qemu-devel] [PATCH v2 0/2] Improve audio output quality
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com

After being annoyed for too long with the crackling QEMU produces, I decided
to dive in and try to fix this. 

This has already been tested by several people, please see the corresponding
Reddit-thread:

https://www.reddit.com/r/VFIO/comments/74vokw/improved_pulse_audio_driver_for_qemu/

I presented this to the list a few days ago, but it was in too rough a state,
so I cleaned it up and wrote better commit messages.

This is still missing proper handling for VMState-migration, which I will need a bit of assistance with.

Signed-off-by: Martin Schrodt <martin@schrodt.org>

Martin Schrodt (2):
  audio/paaudio: remove separate PA feeder threads
  audio/hda: create millisecond timers that handle IO

 audio/audio.c        |   5 +
 audio/audio_int.h    |   2 +
 audio/paaudio.c      | 862 ++++++++++++++++++++++-----------------------------
 hw/audio/hda-codec.c | 193 +++++++++---
 hw/audio/intel-hda.c |   7 -
 5 files changed, 531 insertions(+), 538 deletions(-)

-- 
2.14.2
