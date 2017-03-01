Received: from eggs.gnu.org ([2001:4830:134:3::10]:34042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cj6N9-0000N2-1w
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 10:40:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cj6N5-0000By-9r
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 10:40:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59430)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cj6N4-0000Be-Jy
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 10:40:54 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BCFC683F43
	for <qemu-devel@nongnu.org>; Wed,  1 Mar 2017 15:40:54 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed,  1 Mar 2017 16:40:47 +0100
Message-Id: <1488382850-19252-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL v3 0/3] audio patch queue
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

v3: really fix osx build failure.

The following changes since commit e7c83a885f865128ae3cf1946f8cb538b63cbfba:

  vhost-user: delay vhost_user_stop (2017-02-28 19:11:15 +0000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/pull-audio-20170301-1

for you to fetch changes up to bcf19777df78193f7cdb108a55db44fd4f20d5b5:

  audio/sdlaudio: Allow audio playback with SDL2 (2017-03-01 15:12:03 +0100)

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
 audio/mixeng.c           | 32 ++++++++++++++++++++
 audio/sdlaudio.c         | 48 +++++++++++++++++++++++++++++
 docs/replay.txt          |  7 +++++
 include/sysemu/replay.h  |  7 +++++
 replay/Makefile.objs     |  1 +
 replay/replay-audio.c    | 79 ++++++++++++++++++++++++++++++++++++++++++++++++
 replay/replay-internal.h |  4 +++
 9 files changed, 191 insertions(+), 3 deletions(-)
 create mode 100644 replay/replay-audio.c
