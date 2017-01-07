Received: from eggs.gnu.org ([2001:4830:134:3::10]:47804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cPyri-0007jY-6c
	for qemu-devel@nongnu.org; Sat, 07 Jan 2017 16:49:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cPyrf-0006g4-41
	for qemu-devel@nongnu.org; Sat, 07 Jan 2017 16:49:30 -0500
Received: from indium.canonical.com ([91.189.90.7]:51439)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cPyre-0006fZ-U4
	for qemu-devel@nongnu.org; Sat, 07 Jan 2017 16:49:27 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cPyrd-0005rj-8R
	for <qemu-devel@nongnu.org>; Sat, 07 Jan 2017 21:49:25 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 3652E2E80C3
	for <qemu-devel@nongnu.org>; Sat,  7 Jan 2017 21:49:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Jan 2017 21:36:14 -0000
From: Patrick Schleizer <adrelanos@riseup.net>
Reply-To: Bug 1253465 <1253465@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20131120230014.7464.50074.malonedeb@wampee.canonical.com>
Message-Id: <20170107213614.14095.1814.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1253465] Re: qemu-img: 'image' uses a vmdk
 feature which is not supported by this qemu version: VMDK version 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

> If you are aware of open source software which already supports
version 3, please let us know!

VirtualBox can.

- VirtualBox uses VMDK version 3 disks.
- When you export a VM with VirtualBox (creating an .ova), it will include =
VMDK version 3 disks.
- VirtualBox can convert from vmkd to vdi. ('VBoxManage clonehd --format VD=
I "vmdk_file" "vdi_file"')

Does that help?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1253465

Title:
  qemu-img: 'image' uses a vmdk feature which is not supported by this
  qemu version: VMDK version 3

Status in QEMU:
  New

Bug description:
  qemu-img convert in.vmdk  -O RAW out.img

  Fails with:
  qemu-img: 'image' uses a vmdk feature which is not supported by this qemu=
 version: VMDK version 3

  qemu-img version 1.6.1

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1253465/+subscriptions
