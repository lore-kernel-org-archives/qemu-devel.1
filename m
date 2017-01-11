Received: from eggs.gnu.org ([2001:4830:134:3::10]:38499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRQBg-0001gW-0z
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 16:12:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRQBb-00066D-3I
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 16:12:03 -0500
Received: from indium.canonical.com ([91.189.90.7]:43433)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cRQBa-00065q-Tn
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 16:11:59 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cRQBZ-0000Om-1K
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 21:11:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 29BCC2E80CB
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 21:11:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Jan 2017 20:55:13 -0000
From: Thomas Huth <1256826@bugs.launchpad.net>
Reply-To: Bug 1256826 <1256826@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20131202092045.6379.27394.malonedeb@soybean.canonical.com>
Message-Id: <20170111205513.26927.69056.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1256826] Re: INT instruction bug in WindowsXP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Which QEMU version did you use here? Can you still reproduce this
problem with the latest version of QEMU (currently 2.8)?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1256826

Title:
  INT instruction bug in WindowsXP

Status in QEMU:
  Incomplete

Bug description:
  This bug is in -no-kvm mode.

  In windowsXP at IDT entry 2&8 is Task gate

  when application use INT 2 or INT 8 it will cause blue screen in XP.

  I found it should cause #GP but not generate hw interrupt.

  also I check this bug with -enable-kvm & my PC and works correctly.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1256826/+subscriptions
