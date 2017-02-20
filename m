Received: from eggs.gnu.org ([2001:4830:134:3::10]:46930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cfohY-0000l1-OB
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:12:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cfohU-00052a-0a
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:12:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cfohT-000526-R1
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:12:23 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 134448123A
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 14:12:24 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 20 Feb 2017 15:12:16 +0100
Message-Id: <1487599939-4776-1-git-send-email-kraxel@redhat.com>
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

Here is the audio queue, bringing support for replay and fixing audio
with SDL2.

please pull,
  Gerd

The following changes since commit 5d42ff913bb294c661aed8dfcd386fed9e185148:

  Merge remote-tracking branch 'remotes/huth/tags/coldfire-20170219' into staging (2017-02-20 11:55:37 +0000)

are available in the git repository at:


  git://git.kraxel.org/qemu tags/pull-audio-20170220-1

for you to fetch changes up to 255a694376960826ead9a6e47c5c661d51b5e25b:

  audio/sdlaudio: Allow audio playback with SDL2 (2017-02-20 14:24:51 +0100)

----------------------------------------------------------------
audio: add sdl2 support, add replay support.

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
