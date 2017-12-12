Received: from eggs.gnu.org ([2001:4830:134:3::10]:39103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eOqyk-0003XY-CA
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 15:16:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eOqyh-0004Ck-5R
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 15:16:38 -0500
Received: from indium.canonical.com ([91.189.90.7]:42322)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eOqyg-0004CK-Va
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 15:16:35 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eOqye-0002ZF-Ir
	for <qemu-devel@nongnu.org>; Tue, 12 Dec 2017 20:16:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C99FD2E81A0
	for <qemu-devel@nongnu.org>; Tue, 12 Dec 2017 20:16:29 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 Dec 2017 20:10:09 -0000
From: Nathan Rennie-Waldock <1670509@bugs.launchpad.net>
Reply-To: Bug 1670509 <1670509@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170306224936.27687.97076.malonedeb@gac.canonical.com>
Message-Id: <151310940909.10989.18091817669951735640.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1670509] Re: sgabios outputs incorrect video modes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Fixed in qemu, yes. But not Ubuntu. Ubuntu strips prebuilt files from
qemu and builds them from source. For sgabios, using the abandoned
source from Google code.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1670509

Title:
  sgabios outputs incorrect video modes

Status in QEMU:
  Fix Released
Status in sgabios package in Ubuntu:
  Confirmed

Bug description:
  When run with a bootstrap loader that uses int 0x10 with 0x1301 in
  %ax, incorrect video modes are output to the serial port.  I believe
  the VGA image will be correct.  This might also affect the returned
  values for some interrupts.

  This is caused because the set_cursor_position routine fails to save
  and restore %bx.

  I'm working on a fix for this.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1670509/+subscriptions
