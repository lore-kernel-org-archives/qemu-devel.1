Received: from eggs.gnu.org ([2001:4830:134:3::10]:39390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fTNgl-00076G-PJ
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:33:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fTNgh-0000nL-SU
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:33:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58938 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fTNgh-0000n4-Ni
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:32:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 59A0281A8A05
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 08:32:59 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 14 Jun 2018 10:32:56 +0200
Message-Id: <20180614083258.14618-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] Ui 20180614 patches
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

The following changes since commit 2ab09bf2f9f55b9fb8d2de6eb2ba2a8570e268=
e2:

  Merge remote-tracking branch 'remotes/kraxel/tags/usb-20180612-pull-req=
uest' into staging (2018-06-12 15:34:34 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/ui-20180614-pull-request

for you to fetch changes up to 64bf97e56f3ab44d587c92c40503d646273a24df:

  sdl2: restore window dimensions by resize (2018-06-14 09:55:09 +0200)

----------------------------------------------------------------
ui: bugfixes for sdl and gtk

----------------------------------------------------------------

Amadeusz S=C5=82awi=C5=84ski (1):
  sdl2: restore window dimensions by resize

Keno Fischer (1):
  ui: darwin: gtk: Add missing input keymap

 Makefile           | 1 +
 include/ui/input.h | 3 +++
 ui/input-keymap.c  | 1 +
 ui/sdl2.c          | 3 +--
 4 files changed, 6 insertions(+), 2 deletions(-)

--=20
2.9.3
