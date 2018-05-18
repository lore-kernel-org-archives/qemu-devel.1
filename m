Received: from eggs.gnu.org ([2001:4830:134:3::10]:47297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fJa0X-0001ti-3V
	for qemu-devel@nongnu.org; Fri, 18 May 2018 03:40:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fJa0W-00053n-6D
	for qemu-devel@nongnu.org; Fri, 18 May 2018 03:40:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37856 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fJa0W-00053e-0z
	for qemu-devel@nongnu.org; Fri, 18 May 2018 03:40:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 964AB81FE147
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 07:40:55 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 18 May 2018 09:40:49 +0200
Message-Id: <20180518074052.31724-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/3] Ui 20180518 patches
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

The following changes since commit a4207e3b00e89f934adb231057dcf9a75ac2ae=
45:

  Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' int=
o staging (2018-05-17 11:59:50 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/ui-20180518-pull-request

for you to fetch changes up to e8dcb8ae5121965ac8c89e6b277ac127e9d08452:

  sdl: Move use of surface pointer below check for whether it is NULL (20=
18-05-18 09:14:24 +0200)

----------------------------------------------------------------
ui: bugfixes, move x11 dependency to modules.

----------------------------------------------------------------

Michal Privoznik (1):
  console: Avoid segfault in screendump

Paolo Bonzini (1):
  ui: add x_keymap.o to modules

Peter Maydell (1):
  sdl: Move use of surface pointer below check for whether it is NULL

 ui/console.c             |  5 +++++
 ui/sdl2-2d.c             |  6 +++---
 hw/display/Makefile.objs |  2 ++
 ui/Makefile.objs         | 11 +++++++----
 4 files changed, 17 insertions(+), 7 deletions(-)

--=20
2.9.3
