Received: from eggs.gnu.org ([2001:4830:134:3::10]:58059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eUPpe-000151-7K
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 23:30:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eUPpb-0001Ip-EA
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 23:30:14 -0500
Received: from indium.canonical.com ([91.189.90.7]:58788)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eUPpb-0001Hr-7a
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 23:30:11 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eUPpa-0007Qk-FI
	for <qemu-devel@nongnu.org>; Thu, 28 Dec 2017 04:30:10 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 708762E8060
	for <qemu-devel@nongnu.org>; Thu, 28 Dec 2017 04:30:10 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 Dec 2017 04:17:20 -0000
From: Launchpad Bug Tracker <1336123@bugs.launchpad.net>
Reply-To: Bug 1336123 <1336123@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140701023616.19098.65962.malonedeb@gac.canonical.com>
Message-Id: <151443464148.28609.15417449887888776668.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1336123] Re: bad switch,
 segfault in hw/pci-host/bonito.c bonito_readl
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
https://bugs.launchpad.net/bugs/1336123

Title:
  bad switch, segfault in hw/pci-host/bonito.c bonito_readl

Status in QEMU:
  Expired

Bug description:
  http://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Dhw/pci-
  host/bonito.c;h=3D56292adb03cd1a9873c2c9e5a0b2978fd0572214;hb=3Dmaster#l3=
01

  The switch statement is error-prone, since two branches return the
  same result.

  Segfault reproducing steps:
  1. make a Linux kernel(for example 3.16.0-rc2) with fuloong2e_defconfig
  2. use 'qemu-system-mips64el -machine fulong2e' to boot the vmlinux

  qemu versions tried: 2.0.0, 1.6.2

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1336123/+subscriptions
