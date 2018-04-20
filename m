Received: from eggs.gnu.org ([2001:4830:134:3::10]:47472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f9aDb-00088Q-9c
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 13:53:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f9aDX-0005FH-A4
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 13:53:07 -0400
Received: from indium.canonical.com ([91.189.90.7]:52588)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f9aDX-0005EK-3L
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 13:53:03 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f9aDU-0007ih-As
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 17:53:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4C1C12E80CC
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 17:53:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Apr 2018 17:33:32 -0000
From: Jason Wagner <1520730@bugs.launchpad.net>
Reply-To: Bug 1520730 <1520730@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20151128034327.2137.99161.malonedeb@wampee.canonical.com>
Message-Id: <152424561210.19798.13655458815806919532.malone@soybean.canonical.com>
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

I'm seeing this issue in version 2.12.0-rc4. I wasn't seeing this as
much in earlier 2.11, but its a major pain in the current version.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1520730

Title:
  32-bit editors vim/rhide broken keyboard handling in freedos 1.1 and
  ms-dos 6.22

Status in QEMU:
  New

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
