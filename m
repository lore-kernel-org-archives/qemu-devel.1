Received: from eggs.gnu.org ([2001:4830:134:3::10]:59632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gYuhJ-0005je-OG
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 10:20:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gYuhE-0007Nr-RY
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 10:20:45 -0500
Received: from indium.canonical.com ([91.189.90.7]:49106)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gYuhE-0007L4-Gz
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 10:20:40 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gYuhD-00057u-9p
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 15:20:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0C8612E80D1
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 15:20:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Dec 2018 15:09:01 -0000
From: William Razgunas <bjraz@abstractions.me>
Reply-To: Bug 1808824 <1808824@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154505934144.23344.12423865582266502170.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1808824] [NEW] Mouse leaves VM window when Grab
 on Hover isn't selected Windows 10 and Intel HAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

On Windows 10.0.17134 I have been having the problem that the mouse will
leave the VM window after a short time when grab on hover isn't
selected.  The VM will then try to grab on Hover and the mouse will grab
in weird places and it will become very unwieldy to control the mouse in
the VM window.

This is exasperated by super slow response making it nearly unusable  if
the Intel=C2=AE Hardware Accelerated Execution Manager (Intel=C2=AE HAXM) i=
s not
currently installed on my machine.

I know they are different things but they compounded on each other when
you have a mouse that is not staying in the VM window and the VM's
visualized cpu is acting VERY slow the system is unusable.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1808824

Title:
  Mouse leaves VM window when Grab on Hover isn't selected Windows 10
  and Intel HAX

Status in QEMU:
  New

Bug description:
  On Windows 10.0.17134 I have been having the problem that the mouse
  will leave the VM window after a short time when grab on hover isn't
  selected.  The VM will then try to grab on Hover and the mouse will
  grab in weird places and it will become very unwieldy to control the
  mouse in the VM window.

  This is exasperated by super slow response making it nearly unusable
  if the Intel=C2=AE Hardware Accelerated Execution Manager (Intel=C2=AE HA=
XM) is
  not currently installed on my machine.

  I know they are different things but they compounded on each other
  when you have a mouse that is not staying in the VM window and the
  VM's visualized cpu is acting VERY slow the system is unusable.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1808824/+subscriptions
