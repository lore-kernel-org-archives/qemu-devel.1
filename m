Received: from eggs.gnu.org ([2001:4830:134:3::10]:50241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gMDwM-0002r7-Vb
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 10:15:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gMDwH-0001QL-8A
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 10:15:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gMDwD-0001Nr-7O
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 10:15:43 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E4BD158E26
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 15:15:39 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 12 Nov 2018 16:15:12 +0100
Message-Id: <20181112151516.10012-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/4] Fixes 31 20181112 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

The following changes since commit 460f0236c12a86a38692c12d9bf8e2391dc10a=
77:

  Merge remote-tracking branch 'remotes/thibault/tags/samuel-thibault' in=
to staging (2018-11-12 10:12:07 +0000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/fixes-31-20181112-pull-request

for you to fetch changes up to f1aba960cc40ab65fa88c8678883bd2201708c55:

  ui/gtk: fix cursor in egl mode (2018-11-12 14:15:54 +0100)

----------------------------------------------------------------
fixes for 3.1: mark bt as deprecated, bugfixes for pulse, gtk and edid.

----------------------------------------------------------------

Gerd Hoffmann (2):
  pulseaudio: process audio data in smaller chunks
  ui/gtk: fix cursor in egl mode

Marc-Andr=C3=A9 Lureau (1):
  edid: silence a stringop-overflow warning

Thomas Huth (1):
  bt: Mark the bluetooth subsystem as deprecated

 audio/paaudio.c            |  4 ++--
 hw/display/edid-generate.c |  2 +-
 ui/gtk-egl.c               | 17 ++++++++++++-----
 vl.c                       |  4 ++++
 qemu-deprecated.texi       |  7 +++++++
 qemu-options.hx            |  4 ++++
 6 files changed, 30 insertions(+), 8 deletions(-)

--=20
2.9.3
