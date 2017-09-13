Received: from eggs.gnu.org ([2001:4830:134:3::10]:36827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ds2Iu-00058Y-WB
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:41:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ds2Is-0003Kk-CF
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:41:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ds2Is-0003IW-63
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:41:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 303918553E
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 07:41:45 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 13 Sep 2017 09:41:34 +0200
Message-Id: <20170913074140.5160-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/6] Vga 20170913 patches
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

The following changes since commit 223cd0e13f2e46078d7b573f0b8402bfbee339=
be:

  Merge remote-tracking branch 'remotes/elmarco/tags/tidy-pull-request' i=
nto staging (2017-08-31 15:52:43 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/vga-20170913-pull-request

for you to fetch changes up to 79d16c21a565927943486b26789caa62413ff371:

  virtio-gpu: don't clear QemuUIInfo information on reset (2017-09-13 09:=
39:32 +0200)

----------------------------------------------------------------
vga: bugfixes.
qxl: chunked cursor support.

----------------------------------------------------------------

Dr. David Alan Gilbert (1):
  vga/migration: Update memory map in post_load

Gerd Hoffmann (5):
  vga: fix display update region calculation (split screen)
  vga: stop passing pointers to vga_draw_line* functions
  qxl: drop mono cursor support
  qxl: add support for chunked cursors.
  virtio-gpu: don't clear QemuUIInfo information on reset

 hw/display/vga-helpers.h | 202 ++++++++++++++++++++++++++---------------=
------
 hw/display/vga_int.h     |   1 +
 hw/display/qxl-render.c  |  45 +++++++----
 hw/display/vga.c         |  16 +++-
 hw/display/virtio-gpu.c  |  12 ---
 5 files changed, 152 insertions(+), 124 deletions(-)

--=20
2.9.3
