Received: from eggs.gnu.org ([2001:4830:134:3::10]:50009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cie8s-00045I-Vt
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 04:32:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cie8p-0000wA-R2
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 04:32:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50522)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cie8p-0000vq-Kl
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 04:32:19 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 071F161BA5
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 09:32:19 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 28 Feb 2017 10:32:11 +0100
Message-Id: <1488274334-6387-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL v2 0/3] audio patch queue
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

v2: fix osx build failure.

please pull,
  Gerd

The following changes since commit 9b9fbe8a4e9eec9072ee2697a6af59144442785f:

  Merge remote-tracking branch 'remotes/kraxel/tags/pull-ui-20170227-1' into staging (2017-02-27 19:19:46 +0000)

are available in the git repository at:


  git://git.kraxel.org/qemu tags/pull-audio-20170228-1

for you to fetch changes up to 6d6616aa655850925ec2a0d096f5c22cb4522fa4:

  audio/sdlaudio: Allow audio playback with SDL2 (2017-02-28 10:09:35 +0100)

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
