Received: from eggs.gnu.org ([2001:4830:134:3::10]:46421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eLpQu-0006Tl-C0
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 07:01:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eLpQo-0001Td-Hp
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 07:01:12 -0500
Received: from indium.canonical.com ([91.189.90.7]:38476)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eLpQo-0001T3-CB
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 07:01:06 -0500
Received: from chaenomeles.canonical.com ([91.189.89.119])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eLpQl-0005mM-3T
	for <qemu-devel@nongnu.org>; Mon, 04 Dec 2017 12:01:03 +0000
Received: from chaenomeles.canonical.com (localhost [IPv6:::1])
	by chaenomeles.canonical.com (Postfix) with ESMTPS id 12C636807D4
	for <qemu-devel@nongnu.org>; Mon,  4 Dec 2017 12:01:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 Dec 2017 12:01:02 -0000
From: Launchpad Bug Tracker <1736042@bugs.launchpad.net>
Reply-To: Bug 1736042 <1736042@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151234883142.11175.15433643697954166633.malonedeb@soybean.canonical.com>
Message-Id: <151238886290.20280.10767099388397565837.launchpad@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1736042] [NEW] qemu-system-x86_64 does not boot
 image reliably
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

You have been subscribed to a public bug:

Booting image as root user with following command works randomly.

./qemu-system-x86_64 -enable-kvm -curses -smp cpus=3D4 -m 8192
/root/ructfe2917_g.qcow2

Most of the time it ends up on "800x600 Graphic mode"(been stuck there
even for 4 hours before killed), but 1 out of ~20 it boots image
correctly(and instantly).

This is visible in v2.5.0 build from sources, v2.5.0 from Ubuntu Xenial
and v2.1.2 from Debian Jessie.

The image in question was converted from vmdk using:

qemu-img convert -O qcow2 file.vmdk file.qcow2

The image contains Ubuntu with grub.

I can provide debug logs, but will need guidance how to enable them(and
what logs are necessary).

As a side note, it seems that booting is more certain after
connecting(or mounting) partition using qemu-nbd/mount.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

qemu-system-x86_64 does not boot image reliably
https://bugs.launchpad.net/bugs/1736042
You received this bug notification because you are a member of qemu-devel-m=
l, which is subscribed to QEMU.
