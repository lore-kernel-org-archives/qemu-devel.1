Received: from eggs.gnu.org ([2001:4830:134:3::10]:36835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e6Ytp-0005y1-2g
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 05:19:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e6Ytl-0005YR-3v
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 05:19:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e6Ytk-0005YB-UF
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 05:19:53 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0DC9D356C4
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 09:19:52 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 23 Oct 2017 11:19:38 +0200
Message-Id: <20171023091947.20771-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/9] Input 20171023 patches
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

The following changes since commit e822e81e350825dd94f41ee2538ff1432b812e=
b9:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request'=
 into staging (2017-10-20 15:04:00 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/input-20171023-pull-request

for you to fetch changes up to 2182608f1ca00f4559486e9173a8e4242dd2d65d:

  ui: pull in latest keycodemapdb (2017-10-23 10:50:02 +0200)

----------------------------------------------------------------
input: fixes for ui input code and ps/2 keyboard (mostly sysrq key)

----------------------------------------------------------------

Daniel P. Berrange (9):
  input: use hex in ps2 keycode trace events
  ui: fix crash with sendkey and raw key numbers
  ui: use correct union field for key number
  ps2: fix scancodes sent for Alt-Print key combination (aka SysRq)
  ps2: fix scancodes sent for Shift/Ctrl+Print key combination
  ps2: fix scancodess sent for Pause key in AT set 1
  ps2: fix scancodes sent for Ctrl+Pause key combination
  ui: normalize the 'sysrq' key into the 'print' key
  ui: pull in latest keycodemapdb

 hw/input/ps2.c        | 207 +++++++++++++++++++++++++++++++++++++++++---=
------
 ui/input-legacy.c     |   5 ++
 ui/input.c            |  16 +++-
 hw/input/trace-events |   3 +-
 qapi/ui.json          |   7 ++
 ui/keycodemapdb       |   2 +-
 6 files changed, 201 insertions(+), 39 deletions(-)

--=20
2.9.3
