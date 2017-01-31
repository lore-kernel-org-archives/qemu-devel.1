Received: from eggs.gnu.org ([2001:4830:134:3::10]:38033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cYahf-00055Q-Iq
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:50:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cYaha-0001T2-7B
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:50:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54013)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cYahZ-0001SC-V1
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:50:38 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AE6429D43B
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 15:50:37 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 31 Jan 2017 16:50:20 +0100
Message-Id: <1485877831-28786-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 00/11] ui patch queue
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

Here comes the ui patch queue.  Nothing outstanding here.  Bugfixes and
small improvements all user interfaces.

v2 updates:
  * change "C.utf-8" locale to "C.UTF-8".
  * add forgotten "fix console resize" patch.

please pull,
  Gerd

The following changes since commit a0def594286d9110a6035e02eef558cf3cf5d8=
47:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into s=
taging (2017-01-30 10:23:20 +0000)

are available in the git repository at:


  git://git.kraxel.org/qemu tags/pull-ui-20170131-2

for you to fetch changes up to 3ef0c573d37b117867352a8bd8c567d3b774fe37:

  console: fix console resize (2017-01-31 16:09:16 +0100)

----------------------------------------------------------------
ui: bugfixes and small improvements all over the place.

----------------------------------------------------------------
Fabian Lesniak (3):
      qapi: add support for mice with extra/side buttons
      ps2: add support for mice with extra/side buttons
      ui: add support for mice with extra/side buttons

Gerd Hoffmann (2):
      vnc: fix overflow in vnc_update_stats
      console: fix console resize

Kevin Wolf (1):
      gtk: Hardcode LC_CTYPE as C.utf-8

Marc-Andr=C3=A9 Lureau (1):
      spice: wakeup QXL worker to pick up mouse changes

OGAWA Hirofumi (1):
      ui/gtk: Fix mouse wheel on 3.4.0 or later

Pierre Ossman (1):
      vnc: track LED state separately

Rami Rosen (1):
      ui: fix format specfier in vnc to avoid break in build.

Ziyue Yang (1):
      ui/gtk.c: add ctrl-alt-=3D support for zoom in acceleration

 hw/input/ps2.c         |  8 +++---
 include/hw/input/ps2.h |  6 +++++
 qapi-schema.json       |  7 +++++-
 ui/console.c           |  2 +-
 ui/gtk.c               | 32 +++++++++++++++++++++++-
 ui/input-linux.c       |  6 +++++
 ui/spice-display.c     |  2 ++
 ui/vnc.c               | 67 ++++++++++++++++----------------------------=
------
 ui/vnc.h               |  3 ++-
 9 files changed, 80 insertions(+), 53 deletions(-)
