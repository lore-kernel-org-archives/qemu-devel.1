Received: from eggs.gnu.org ([2001:4830:134:3::10]:35134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eZO6R-0001iQ-K5
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 16:40:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eZO6O-0003jN-Bv
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 16:40:07 -0500
Received: from indium.canonical.com ([91.189.90.7]:49272)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eZO6O-0003ip-4W
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 16:40:04 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eZO6N-0004e0-B2
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 21:40:03 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 50F612E804C
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 21:40:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jan 2018 21:23:39 -0000
From: Thomas Huth <1055090@bugs.launchpad.net>
Reply-To: Bug 1055090 <1055090@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120923165018.22472.41239.malonedeb@chaenomeles.canonical.com>
Message-Id: <151561941983.26237.15260019959788932939.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1055090] Re: esp error: NetBSD/sparc on
 qemu-system-sparc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets... can you still reproduce this issue with the
latest version of QEMU (and NetBSD)? Or could we close this ticket
nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1055090

Title:
  esp error: NetBSD/sparc on qemu-system-sparc

Status in QEMU:
  Incomplete

Bug description:
  On qemu-1.2.0's qemu-system-sparc, NetBSD/sparc (32bit) 5.1.2 and
  6.0_RC2 generates the following NetBSD's errors.

  esp0: !TC on DATA XFER [intr 18, stat 82, step 4] prevphase 2, resid 0
  esp0: !TC on DATA XFER [intr 10, stat 83, step 0] prevphase 2, resid 0

  On qemu-0.15.1's qemu-system-sparc, NetBSD/sparc 5.1.2 and 6.0_RC2
  works fine.

  To reproduce with NetBSD/sparc 6.0_RC2, run

  % qemu-system-sparc -M SS-20 -m 265M -hda NetBSD-sparc-6.0_RC2.qed
  -nographic -cdrom NetBSD-6.0_RC2-sparc.iso -boot d

  and try to install NetBSD. You can get above errors when newfs command is=
 invoked.
  I can reporduce this problem on NetBSD/i386 (32bit) and NetBSD/amd64(64bi=
t; x86_64) host OSes.

  NetBSD-6.0_RC2-sparc.iso is here,
  ftp://ftp.netbsd.org/pub/NetBSD/NetBSD-6.0_RC2/images/NetBSD-6.0_RC2-spar=
c.iso

  NetBSD-sparc-6.0_RC2.qed is created with
  % qemu-img create -f qed NetBSD-sparc-6.0_RC2.qed 3G

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1055090/+subscriptions
