Received: from eggs.gnu.org ([2001:4830:134:3::10]:55580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fuBKM-0006Qp-7e
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 02:48:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fuB6y-0000bj-Pg
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 02:34:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:36770)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fuB6y-0000Xj-Dk
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 02:34:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fuB6x-0005ah-4E
	for <qemu-devel@nongnu.org>; Mon, 27 Aug 2018 06:34:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 188DE2E80C7
	for <qemu-devel@nongnu.org>; Mon, 27 Aug 2018 06:34:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Aug 2018 06:23:51 -0000
From: Thomas Huth <1485180@bugs.launchpad.net>
Reply-To: Bug 1485180 <1485180@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150815063138.25250.97747.malonedeb@chaenomeles.canonical.com>
Message-Id: <153535103141.25443.17359304652935693371.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1485180] Re: Ctrl Alt G -- Multiple Virtual
 Machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Looking through old bug tickets... can you still reproduce this issue
with the latest version of QEMU (version 3.0)? Which window manager were
you using here?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1485180

Title:
  Ctrl Alt G -- Multiple Virtual Machines

Status in QEMU:
  Incomplete

Bug description:
  I'm using Fedora 22.

  Firstly, what works:
  A single VM instance, running Windows. Although, I am keeping this (GTK) =
window focused.

  What really fails:
  If I have two running VM's, WIndows XP and Windows Vista:
  1. I press Ctrl-Alt-G to get the focus.
  2. That works first time.
  3. Then I press Ctrl-Alt-G again.
  4. Then Alt-Tab to the other machine (switching from XP to Vista, or back=
.)
  5. Then press Ctrl-Alt-G to gain focus:
  - Problem is that now the Ctrl-Alt-G, although showing in the title bar, =
only grabs the mouse, but NOT the keyboard. That is to say, whilst in Ctrl-=
Alt-G mode the second time, pressing Alt-Tab jumps back to the other VM!

  Pressing Alt-F4 quits!!!!!!!!!!!!! Regardless of whether Ctrl-Alt-G mode =
or not!
  But only when running two VM's.

  Thanks
  Misha

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1485180/+subscriptions
