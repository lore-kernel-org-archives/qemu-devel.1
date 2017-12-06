Received: from eggs.gnu.org ([2001:4830:134:3::10]:48533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eMP5m-0004I7-Na
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 21:05:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eMP5h-0008B1-V5
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 21:05:46 -0500
Received: from indium.canonical.com ([91.189.90.7]:48406)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eMP5h-0008AM-Pi
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 21:05:41 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eMP5g-0002dA-Fd
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 02:05:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 73F042E80CB
	for <qemu-devel@nongnu.org>; Wed,  6 Dec 2017 02:05:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 Dec 2017 01:58:08 -0000
From: Launchpad Bug Tracker <1670509@bugs.launchpad.net>
Reply-To: Bug 1670509 <1670509@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170306224936.27687.97076.malonedeb@gac.canonical.com>
Message-Id: <151252548925.10140.10105953954205001365.malone@wampee.canonical.com>
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

Status changed to 'Confirmed' because the bug affects multiple users.

** Changed in: sgabios (Ubuntu)
       Status: New =3D> Confirmed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1670509

Title:
  sgabios outputs incorrect video modes

Status in QEMU:
  New
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
