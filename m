Received: from eggs.gnu.org ([2001:4830:134:3::10]:43713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cWrhE-0001i2-CR
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 16:35:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cWrhA-0004NC-Fp
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 16:35:08 -0500
Received: from indium.canonical.com ([91.189.90.7]:48947)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cWrhA-0004MW-9z
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 16:35:04 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cWrh8-0006H4-32
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 21:35:02 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 258F02E80DC
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 21:35:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Jan 2017 21:20:29 -0000
From: Thomas Huth <1258626@bugs.launchpad.net>
Reply-To: Bug 1258626 <1258626@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20131206191703.25702.91020.malonedeb@wampee.canonical.com>
Message-Id: <20170126212029.17363.52945.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1258626] Re: Curses Keyboard Broken On OS X
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Does the problem still occur with the latest version of QEMU (currently
v2.8)?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1258626

Title:
  Curses Keyboard Broken On OS X

Status in QEMU:
  Incomplete

Bug description:
  Whenever I run ``qemu-system-i386 -curses ...'' (with or without a
  ``-k en-gb'') on OS X 10.9, the keyboard does not work properly. For
  example, when attempting to switch to the QEMU console with Alt+2, I
  get:

  ``Warning: no scancode found for keysym 226
  Warning: no scancode found for keysym 130
  Warning: no scancode found for keysym 172''

  I have checked and these scancodes are not mentioned in
  ``share/qemu/keymaps/''. This is using QEMU 1.6.1, but the problem
  also occurs with 1.3.1. Also, in case it makes a difference, I
  installed QEMU using Homebrew.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1258626/+subscriptions
