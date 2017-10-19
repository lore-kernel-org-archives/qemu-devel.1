Received: from eggs.gnu.org ([2001:4830:134:3::10]:53712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e5Boi-0000Ml-Jh
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 10:29:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e5Bof-0005hQ-FN
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 10:29:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35856)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e5Bof-0005hC-9D
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 10:28:57 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1330313A5D
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 14:28:56 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 19 Oct 2017 15:28:39 +0100
Message-Id: <20171019142848.572-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v1 0/9] Various fixes for input/ps2 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

While preparing to send the rest of my keycodemapdb patches I identified =
some
problems in the input code and particularly in the ps2 device handling of=
 the
pause & print / sysrq key that needed fixing.

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
 hw/input/trace-events |   3 +-
 qapi/ui.json          |   7 ++
 ui/input-legacy.c     |   5 ++
 ui/input.c            |  16 +++-
 ui/keycodemapdb       |   2 +-
 6 files changed, 201 insertions(+), 39 deletions(-)

--=20
2.13.6
