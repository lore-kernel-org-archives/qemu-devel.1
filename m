Received: from eggs.gnu.org ([2001:4830:134:3::10]:50691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ehcmg-0004Dx-Sx
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:57:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ehcmd-0001th-28
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:57:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ehcmc-0001t8-TF
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:57:42 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4B02428205
	for <qemu-devel@nongnu.org>; Fri,  2 Feb 2018 07:50:13 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  2 Feb 2018 08:50:07 +0100
Message-Id: <20180202075009.11653-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] Audio 20180202 patches
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

The following changes since commit b05631954d6dfe93340d516660397e2c1a2a5d=
d6:

  Merge remote-tracking branch 'remotes/rth/tags/pull-hppa-20180131' into=
 staging (2018-01-31 15:50:29 +0000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/audio-20180202-pull-request

for you to fetch changes up to 8ec660b80ed511fa333679e38bf0cf714799d6fa:

  hw/audio/sb16.c: change dolog() to qemu_log_mask() (2018-02-02 08:19:47=
 +0100)

----------------------------------------------------------------
audio: two small fixes.

----------------------------------------------------------------

John Arbuckle (1):
  hw/audio/sb16.c: change dolog() to qemu_log_mask()

Philippe Mathieu-Daud=C3=A9 (1):
  hw/audio/wm8750: move WM8750 declarations from i2c/i2c.h to
    audio/wm8750.h

 include/hw/audio/wm8750.h  | 30 ++++++++++++++++++
 include/hw/i2c/i2c.h       |  9 ------
 hw/arm/musicpal.c          |  3 +-
 hw/arm/spitz.c             |  3 +-
 hw/arm/z2.c                |  3 +-
 hw/audio/marvell_88w8618.c |  1 +
 hw/audio/sb16.c            | 79 +++++++++++++++++++++++++---------------=
------
 hw/audio/wm8750.c          |  6 ++--
 8 files changed, 82 insertions(+), 52 deletions(-)
 create mode 100644 include/hw/audio/wm8750.h

--=20
2.9.3
