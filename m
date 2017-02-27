Received: from eggs.gnu.org ([2001:4830:134:3::10]:49634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ciMxg-00038E-5f
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 10:11:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ciMxd-0005BQ-1B
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 10:11:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57890)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ciMxc-0005BD-R4
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 10:11:36 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BE602C0567B2
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 15:11:36 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 27 Feb 2017 16:11:28 +0100
Message-Id: <1488208291-14775-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 0/3] audio patch queue
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

Three little audio patches, adding replay support
and fixing audio with SDL2.

please pull,
  Gerd

The following changes since commit 3b1d8169844fafee184366b0e0d7080534758b4d:

  tests-aio-multithread: use atomic_read properly (2017-02-27 12:54:08 +0000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/pull-audio-20170227-1

for you to fetch changes up to 516452fe6accef3f94b4bcf060b2518038f50c08:

  audio/sdlaudio: Allow audio playback with SDL2 (2017-02-27 14:37:59 +0100)

----------------------------------------------------------------
audio: replay support, sdl2 fix.

----------------------------------------------------------------
Pavel Dovgalyuk (2):
      replay: add record/replay for audio passthrough
      audio: make audio poll timer deterministic

Thomas Huth (1):
      audio/sdlaudio: Allow audio playback with SDL2

 audio/audio.c            | 11 +++++--
 audio/audio.h            |  5 +++
 audio/mixeng.c           | 31 +++++++++++++++++++
 audio/sdlaudio.c         | 48 +++++++++++++++++++++++++++++
 docs/replay.txt          |  7 +++++
 include/sysemu/replay.h  |  7 +++++
 replay/Makefile.objs     |  1 +
 replay/replay-audio.c    | 79 ++++++++++++++++++++++++++++++++++++++++++++++++
 replay/replay-internal.h |  4 +++
 9 files changed, 190 insertions(+), 3 deletions(-)
 create mode 100644 replay/replay-audio.c
