Received: from eggs.gnu.org ([2001:4830:134:3::10]:41473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1evKur-00029q-VD
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:42:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1evKuo-0000jf-UM
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:42:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45768 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1evKuo-0000iD-Nk
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:42:50 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D84AD401DEAB
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 10:42:48 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 12 Mar 2018 11:42:33 +0100
Message-Id: <20180312104241.24965-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/8] Audio 20180312 patches
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

The following changes since commit e4ae62b802cec437f877f2cadc4ef059cc0eca=
76:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request'=
 into staging (2018-03-09 17:28:16 +0000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/audio-20180312-pull-request

for you to fetch changes up to 051c7d5c1e2f4a392a4b89027b27aa4c50c16fe0:

  audio/sdl: build as module (2018-03-12 11:18:27 +0100)

----------------------------------------------------------------
modules: use gmodule-export.
audio: add driver registry, enable module builds.

----------------------------------------------------------------

Gerd Hoffmann (8):
  modules: use gmodule-export
  audio: add driver registry
  audio: add module loading support
  build: enable audio modules
  audio/alsa: build as module
  audio/oss: build as module
  audio/pulseaudio: build as module
  audio/sdl: build as module

 configure             |  9 ++++--
 Makefile              |  4 +++
 Makefile.objs         |  1 +
 audio/audio_int.h     | 14 ++++-----
 include/qemu/module.h |  1 +
 audio/alsaaudio.c     |  8 ++++-
 audio/audio.c         | 83 +++++++++++++++++++++++++++++++++++----------=
------
 audio/coreaudio.c     |  8 ++++-
 audio/dsoundaudio.c   |  8 ++++-
 audio/noaudio.c       |  8 ++++-
 audio/ossaudio.c      |  8 ++++-
 audio/paaudio.c       |  8 ++++-
 audio/sdlaudio.c      |  8 ++++-
 audio/spiceaudio.c    |  8 ++++-
 audio/wavaudio.c      |  8 ++++-
 audio/Makefile.objs   | 30 +++++++++++++------
 scripts/create_config |  2 +-
 17 files changed, 160 insertions(+), 56 deletions(-)

--=20
2.9.3
