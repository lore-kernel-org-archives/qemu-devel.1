Received: from eggs.gnu.org ([209.51.188.92]:51966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hBDTK-0002lz-2W
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 03:04:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hBDTI-0001o3-P1
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 03:04:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42982)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hBDC1-0005Rw-OR
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 02:46:45 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E493E30BC657
	for <qemu-devel@nongnu.org>; Tue,  2 Apr 2019 06:46:44 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  2 Apr 2019 08:46:34 +0200
Message-Id: <20190402064639.27108-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/5] Fixes 20190402 patches
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

The following changes since commit 230ce19814ecc6bff8edac3b5b86e7c82f422c=
6c:

  Merge remote-tracking branch 'remotes/rth/tags/pull-axp-20190325' into =
staging (2019-03-29 19:29:00 +0000)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/fixes-20190402-pull-request

for you to fetch changes up to be1092afa07794e5247eb504095fb5f2ae421ec6:

  audio: fix audio timer rate conversion bug (2019-04-02 07:50:49 +0200)

----------------------------------------------------------------
fixes for 4.0 (audio, usb),

----------------------------------------------------------------

Bandan Das (2):
  usb-mtp: fix return status of delete
  usb-mtp: remove usb_mtp_object_free_one

Gerd Hoffmann (1):
  Revert "audio: fix pc speaker init"

Peter Maydell (1):
  hw/usb/bus.c: Handle "no speed matched" case in usb_mask_to_str()

Volker R=C3=BCmelin (1):
  audio: fix audio timer rate conversion bug

 audio/audio.c        |  2 +-
 audio/audio_legacy.c |  6 ++++
 hw/audio/pcspk.c     | 36 ++++++++++++---------
 hw/usb/bus.c         |  4 +++
 hw/usb/dev-mtp.c     | 76 +++++++++++++++++++++-----------------------
 5 files changed, 68 insertions(+), 56 deletions(-)

--=20
2.18.1
