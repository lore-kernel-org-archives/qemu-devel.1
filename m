Received: from eggs.gnu.org ([2001:4830:134:3::10]:34728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eMUnM-0002Bj-6I
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 03:11:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eMUnI-0002Ro-Gp
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 03:11:08 -0500
Received: from indium.canonical.com ([91.189.90.7]:45236)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eMUnI-0002RK-B1
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 03:11:04 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eMUnG-0001jf-RO
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 08:11:02 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C2B252E80C3
	for <qemu-devel@nongnu.org>; Wed,  6 Dec 2017 08:11:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 Dec 2017 08:04:55 -0000
From: Thomas Huth <1670509@bugs.launchpad.net>
Reply-To: Bug 1670509 <1670509@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170306224936.27687.97076.malonedeb@gac.canonical.com>
Message-Id: <151254749521.3366.12612717621677487825.malone@gac.canonical.com>
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

Looks like the fix has been included in QEMU's sgabios repository here:

https://git.qemu.org/?p=3Dsgabios.git;a=3Dcommitdiff;h=3Dcbaee52287e5f32373=
181cf

And the binary in the QEMU repository has been updated here:

 https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Dc8c33fca88fc3ab8a5e4b

So this fix is included in QEMU since version 2.10.


** Changed in: qemu
       Status: New =3D> Fix Released

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
