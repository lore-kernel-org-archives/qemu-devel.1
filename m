Received: from eggs.gnu.org ([2001:4830:134:3::10]:35133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eZO6R-0001iP-K6
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 16:40:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eZO6N-0003il-I5
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 16:40:07 -0500
Received: from indium.canonical.com ([91.189.90.7]:49240)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eZO6N-0003hn-5p
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 16:40:03 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eZO6L-0004bz-Tp
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 21:40:01 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id DC1982E80C7
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 21:40:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jan 2018 21:28:02 -0000
From: Thomas Huth <1066055@bugs.launchpad.net>
Reply-To: Bug 1066055 <1066055@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20121012173423.27389.27726.malonedeb@chaenomeles.canonical.com>
Message-Id: <151561968239.32264.1566703405808281703.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1066055] Re: Network performance regression with
 vde_switch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The fix had been included here:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3De1f7b4812eab992de46c9=
8b
... so closing this bug now.

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1066055

Title:
  Network performance regression with vde_switch

Status in QEMU:
  Fix Released

Bug description:
  I've noticed a significant network performance regression when using
  vde_switch, starting about one week ago (10/05/2012); before that
  date, I used to get about 1.5 Gbits host to guest, but now I can only
  get about 320 Mbits; I didn't find any modification in net/vde.*, just
  in hw/virtio*.

  My command line: =

   qemu-system-i386 -cdrom /bpd/bpd.iso -m 512 -boot d -enable-kvm \
    -localtime -ctrl-grab -usbdevice tablet \
    -device virtio-net-pci,mac=3D52:54:00:18:01:01,netdev=3Dvde0,tx=3Dbh,io=
eventfd=3Don,x-txburst=3D32 \
    -netdev vde,id=3Dvde0 -vga std -tb-size 2M -cpu host -clock unix

  My host runs a kernel 3.6.1 and my guest runs a kernel 3.5.4; the same
  problem happens with other host and guest versions, too.

  I know there are better ways of running a guest, but using vde I get a
  cleaner environment in the host (just one tun/tap interface to
  manage...), which is quite good when running some accademic
  experiments.

  Interestingly, at the same time I've noticed a performance enhancement
  of about 25~30 % when using a tun/tap interface, bridged or not.

  Thank you, very much.

  Edivaldo de Araujo Pereira

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1066055/+subscriptions
