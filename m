Received: from eggs.gnu.org ([2001:4830:134:3::10]:54557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fwgaN-0002JE-6X
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 00:35:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fwgaK-0001b5-01
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 00:35:35 -0400
Received: from indium.canonical.com ([91.189.90.7]:40378)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fwgaJ-0001a9-Qm
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 00:35:31 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fwgaI-0007oQ-L5
	for <qemu-devel@nongnu.org>; Mon, 03 Sep 2018 04:35:30 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 94D1B2E8073
	for <qemu-devel@nongnu.org>; Mon,  3 Sep 2018 04:35:30 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Sep 2018 04:26:43 -0000
From: Thomas Huth <1787505@bugs.launchpad.net>
Reply-To: Bug 1787505 <1787505@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153446472677.27869.256879611828000197.malonedeb@chaenomeles.canonical.com>
Message-Id: <153594880557.32364.16399897366894656916.launchpad@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1787505] Re: Solaris host: no network connection,
 mouse pointer mismatch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1787505

Title:
  Solaris host: no network connection, mouse pointer mismatch

Status in QEMU:
  Invalid

Bug description:
  This is probably a bit far afield but on a Solaris 10 SPARC host (Sun
  M3000) running a Windows XP guest like this:

  ./qemu-system-x86_64 -m 1024 -boot d  -smp 3 -net nic -net user -hda
  /bkpool/qemuimages/XP.img -cdrom /bkpool/qemuimages/xp.iso &

  the vnc server starts up and Windows boots normally.  However, there
  is no network connectivity.  There are no network devices visible in
  XP's Networking tab of Control Panel and a ping of the local router
  reports "unreachable".

  Also, the keyboard works fine but the guest mouse pointer is offset
  from the host mouse position by an amount that varies by screen
  position.  This makes it impossible to point to locations near the
  edge of the qemu window.  This seems to be a previously reported
  problem, but the suggested fix, " -device usb-tablet", prevents qemu
  from even starting:

  qemu-system-x86_64: -device usb-tablet: No 'usb-bus' bus found for
  device 'usb-tablet'

  The physical mouse is connected to the USB port of a Sun Ray 2fs
  controlling the M3000 via Sun Ray server.  I apologize if this is a
  configuration issue and not a bug but I don't know where else to
  report it and have been unable to find a solution in the
  documentation.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1787505/+subscriptions
