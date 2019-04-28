Received: from eggs.gnu.org ([209.51.188.92]:42457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hKbXl-0004B5-Qh
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 00:36:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hKbSl-0005cc-PU
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 00:30:52 -0400
Received: from indium.canonical.com ([91.189.90.7]:54414)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hKbSl-0005cQ-KW
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 00:30:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hKbSk-0007mC-Px
	for <qemu-devel@nongnu.org>; Sun, 28 Apr 2019 04:30:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C30022E80C7
	for <qemu-devel@nongnu.org>; Sun, 28 Apr 2019 04:30:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Apr 2019 04:17:19 -0000
From: Launchpad Bug Tracker <1520730@bugs.launchpad.net>
Reply-To: Bug 1520730 <1520730@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20151128034327.2137.99161.malonedeb@wampee.canonical.com>
Message-Id: <155642503997.20856.12902498558713999216.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1520730] Re: 32-bit editors vim/rhide broken
 keyboard handling in freedos 1.1 and ms-dos 6.22
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1520730

Title:
  32-bit editors vim/rhide broken keyboard handling in freedos 1.1 and
  ms-dos 6.22

Status in QEMU:
  Expired

Bug description:
  This bug is present as of the latest commit:
  714487515dbe0c65d5904251e796cd3a5b3579fb

  I also saw it in 2.4.1, but that was a distro package.

  You can see the bug simply using the following line: qemu-system-i386
  -hda freedos.disk

  Simply type vim (or rhide) and start entering in some text. You'll
  notice repeating characters, and also eventually the key mode will
  change as if you're holding down the shift button. Not capslock. "a"
  will become "A", but "\" will also become "|".

  I don't think this is a bug in freedos because I get the same behavior
  with dos 6.22. Not dosbox, though.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1520730/+subscriptions
