Received: from eggs.gnu.org ([209.51.188.92]:52995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gzIcq-000339-Qe
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 05:09:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gzIco-0000yO-Pt
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 05:09:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gzIcm-0000r3-Qq
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 05:09:10 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2F8A79D1E2
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 10:09:02 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 28 Feb 2019 11:08:53 +0100
Message-Id: <20190228100858.28397-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/5] Audio 20190228 patches
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

The following changes since commit 86c7e2f4a93322a76afea5ee6806a83420d1df=
ea:

  Merge remote-tracking branch 'remotes/berrange/tags/authz-core-pull-req=
uest' into staging (2019-02-26 17:59:41 +0000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/audio-20190228-pull-request

for you to fetch changes up to 9399ef168377d9e7f2e33b1c2eb61751aa1b72fa:

  audio/sdlaudio: Simplify the sdl_callback function (2019-02-28 10:30:08=
 +0100)

----------------------------------------------------------------
audio: fixes and cleanups.

----------------------------------------------------------------

Frediano Ziglio (2):
  audio: Use g_strdup_printf instead of manual building a string
  audio: Do not check for audio_calloc failure

Gerd Hoffmann (1):
  audio: don't build alsa and sdl by default on linux

Thomas Huth (2):
  audio/sdlaudio: Remove the semaphore code
  audio/sdlaudio: Simplify the sdl_callback function

 configure        |   2 +-
 audio/audio.c    |  73 ++++-----------------
 audio/sdlaudio.c | 190 +++++++------------------------------------------=
------
 3 files changed, 36 insertions(+), 229 deletions(-)

--=20
2.9.3
