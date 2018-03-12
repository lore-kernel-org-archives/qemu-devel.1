Received: from eggs.gnu.org ([2001:4830:134:3::10]:40207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1evF6A-0007zq-LN
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 00:30:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1evF69-0005y1-GY
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 00:30:10 -0400
Received: from indium.canonical.com ([91.189.90.7]:36038)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1evF69-0005x6-B1
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 00:30:09 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1evF68-0001LB-HO
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 04:30:08 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7F9962E80C7
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 04:30:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Mar 2018 04:17:34 -0000
From: Launchpad Bug Tracker <1055090@bugs.launchpad.net>
Reply-To: Bug 1055090 <1055090@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120923165018.22472.41239.malonedeb@chaenomeles.canonical.com>
Message-Id: <152082825482.7858.15769829611230092158.malone@loganberry.canonical.com>
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

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1055090

Title:
  esp error: NetBSD/sparc on qemu-system-sparc

Status in QEMU:
  Expired

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
