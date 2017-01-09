Received: from eggs.gnu.org ([2001:4830:134:3::10]:33471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cQRb3-0004ta-Qs
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 23:30:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cQRb2-0001sz-Mf
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 23:30:13 -0500
Received: from indium.canonical.com ([91.189.90.7]:37278)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cQRb2-0001sN-Gr
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 23:30:12 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cQRb1-0007x6-N9
	for <qemu-devel@nongnu.org>; Mon, 09 Jan 2017 04:30:11 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id AD4272E8030
	for <qemu-devel@nongnu.org>; Mon,  9 Jan 2017 04:30:11 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Jan 2017 04:17:47 -0000
From: Launchpad Bug Tracker <597351@bugs.launchpad.net>
Reply-To: Bug 597351 <597351@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100622164530.31796.85287.malonedeb@soybean.canonical.com>
Message-Id: <20170109041747.18789.12894.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 597351] Re: Slow UDP performance with virtio
 device
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
https://bugs.launchpad.net/bugs/597351

Title:
  Slow UDP performance with virtio device

Status in QEMU:
  Expired

Bug description:
  I'm working on an app that is very sensitive to round-trip latency
  between the guest and host, and qemu/kvm seems to be significantly
  slower than it needs to be.

  The attached program is a ping/pong over UDP.  Call it with a single
  argument to start a listener/echo server on that port.  With three
  arguments it becomes a counted "pinger" that will exit after a
  specified number of round trips for performance measurements.  For
  example:

    $ gcc -o udp-pong udp-pong.c
    $ ./udp-pong 12345 &                       # start a listener on port 1=
2345
    $ time ./udp-pong 127.0.0.1 12345 1000000  # time a million round trips

  When run on the loopback device on a single machine (true on the host
  or within a guest), I get about 100k/s.

  When run across a port forward using "user" networking on qemu (or
  kvm, the performance is the same) and the default rtl8139 driver (both
  the host and guest are Ubuntu Lucid), I get about 10k/s.  This seems
  very slow, but perhaps unavoidably so?

  When run in the same configuration using the "virtio" driver, I get
  only 2k/s.  This is almost certainly a bug in the virtio driver, given
  that it's a paravirtualized device that is 5x slower than the "slow"
  hardware emulation.

  I get no meaningful change in performance between kvm/qemu.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/597351/+subscriptions
