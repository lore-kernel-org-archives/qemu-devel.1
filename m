Received: from eggs.gnu.org ([2001:4830:134:3::10]:34146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fXRIh-0008Q4-Mk
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 09:13:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fXRId-0001Wl-Mr
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 09:12:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40010 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fXRId-0001UI-Gk
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 09:12:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8B4E04001388
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 13:12:54 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 25 Jun 2018 15:12:47 +0200
Message-Id: <20180625131253.11218-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/6] Audio 20180625 patches
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

The following changes since commit 46012db666990ff2eed1d3dc199ab8006439a9=
3b:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20180619' into =
staging (2018-06-20 09:51:30 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/audio-20180625-pull-request

for you to fetch changes up to 441b345313f1355fb2464f3b37a07a1ded85b61a:

  audio: Convert use of atoi to qemu_strtoi (2018-06-25 14:03:30 +0200)

----------------------------------------------------------------
audio: new timer code for hda codec, fix audio_get_conf_int

----------------------------------------------------------------

Gerd Hoffmann (5):
  audio/hda: create millisecond timers that handle IO
  audio/hda: turn some dprintfs into trace points
  audio/hda: tweak timer adjust logic
  audio/hda: detect output buffer overruns
  audio/hda: enable new timer code by default.

Nia Alarie (1):
  audio: Convert use of atoi to qemu_strtoi

 include/hw/compat.h   |   4 +
 audio/audio.c         |   3 +-
 hw/audio/hda-codec.c  | 287 ++++++++++++++++++++++++++++++++++++++++++++=
------
 hw/audio/intel-hda.c  |   7 --
 hw/audio/trace-events |   6 ++
 5 files changed, 267 insertions(+), 40 deletions(-)

--=20
2.9.3
