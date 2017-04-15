Received: from eggs.gnu.org ([2001:4830:134:3::10]:39175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1czFLr-00039Z-Na
	for qemu-devel@nongnu.org; Sat, 15 Apr 2017 00:30:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1czFLq-0000lg-UK
	for qemu-devel@nongnu.org; Sat, 15 Apr 2017 00:30:23 -0400
Received: from indium.canonical.com ([91.189.90.7]:57730)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1czFLq-0000lM-O5
	for qemu-devel@nongnu.org; Sat, 15 Apr 2017 00:30:22 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1czFLp-0005Lx-8u
	for <qemu-devel@nongnu.org>; Sat, 15 Apr 2017 04:30:21 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4166A2E80CE
	for <qemu-devel@nongnu.org>; Sat, 15 Apr 2017 04:30:21 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Apr 2017 04:18:01 -0000
From: Launchpad Bug Tracker <988909@bugs.launchpad.net>
Reply-To: Bug 988909 <988909@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120426144637.14416.74996.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170415041801.25352.35272.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 988909] Re: Assert failed in arp_table.c
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
https://bugs.launchpad.net/bugs/988909

Title:
  Assert failed in arp_table.c

Status in QEMU:
  Expired

Bug description:
  =

  With latest git (8001954) hen running:

  qemu-system-64 -hda $VDISK -kernel arch/x86/boot/bzImage \
          -append "ro root=3D/dev/hda1 console=3DttyS0 init=3D/bin/systemd"=
 \
          -curses \
          -net nic  -smp 3 -m 312 $@

  I'm getting this:

   qemu-system-x86_64: slirp/arp_table.c:75: arp_table_search: Assertion
  `(ip_addr & (__extension__ ({ register unsigned int __v, __x =3D (~(0xf
  << 28)); if (__builtin_constant_p (__x)) __v =3D ((((__x) & 0xff000000)
  >> 24) | (((__x) & 0x00ff0000) >> 8) | (((__x) & 0x0000ff00) << 8) |
  (((__x) & 0x000000ff) << 24)); else __asm__ ("bswap %0" : "=3Dr" (__v) :
  "0" (__x)); __v; }))) !=3D 0' failed.

  Bug #824650 seems to be related to this one, but it is not. Fix for that =
one is already upstream. =

  I can help on testing.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/988909/+subscriptions
