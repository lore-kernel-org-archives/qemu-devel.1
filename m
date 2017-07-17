Received: from eggs.gnu.org ([2001:4830:134:3::10]:48644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dWxlq-0001Dh-9v
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 00:36:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dWxln-0006w3-6a
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 00:36:34 -0400
Received: from indium.canonical.com ([91.189.90.7]:38838)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dWxln-0006vn-07
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 00:36:31 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dWxlj-000511-OJ
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 04:36:27 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E75722E81A1
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 04:36:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Jul 2017 04:21:55 -0000
From: Launchpad Bug Tracker <1181796@bugs.launchpad.net>
Reply-To: Bug 1181796 <1181796@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130519164858.7560.43164.malonedeb@wampee.canonical.com>
Message-Id: <150026531523.21839.285620209135957097.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1181796] Re: Qemu locks up when incoming serial
 fills up
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
https://bugs.launchpad.net/bugs/1181796

Title:
  Qemu locks up when incoming serial fills up

Status in QEMU:
  Expired

Bug description:
  I'm using Windows, I'm not sure if this happens on Linux, but for all
  I know it does. To repro, fire up any image (ideally one that does
  almost nothing, and doesn't read the serial port), and use the option
  "-serial pipe:mypipe". Then use Putty or something else to connect to
  that named pipe so Qemu starts up. Now start typing into Putty. For a
  VM image that never reads the serial port, upon typing the 16th
  character Qemu stops executing instructions in the guest (as evidenced
  either by being unable to step in gdb, seeing that "info registers" in
  the monitor always reports the same value, or just by observing that
  the guest is hung). For OS images that do regularly read the serial
  port, this may require pasting >16 bytes into Putty at once. This
  occurs with more than just Putty, use anything that can write at a
  named pipe.

  I would have expected that bytes get dropped, or even more ideally
  blocked at the sender's side of the named pipe. I would not expect
  that the entire VM stops. You seem to be able to unwedge the VM by
  switching to the monitor and running "i /1c 0x3f8" until you've pulled
  enough out of buffer that it's happy to run again. Interestingly, all
  bytes seem to come through (more than just the 16) when read from the
  monitor.

  I haven't been able to get a source environment set up, but I have
  tried a few of the Windows binaries. This repros in 1.4.1, 1.3.0, 1.2,
  and 1.0, the most recent build I found that did not have this behavior
  was 0.15.0.

  Maybe I'm missing something very obvious, and if so, I apologize in
  advance. I'm also happy to create an OS image that highlights this
  problem if it would help.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1181796/+subscriptions
