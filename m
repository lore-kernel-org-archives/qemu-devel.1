Received: from eggs.gnu.org ([2001:4830:134:3::10]:36289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d4K1k-00069k-Qc
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 00:30:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d4K1h-0003xU-N1
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 00:30:36 -0400
Received: from indium.canonical.com ([91.189.90.7]:48550)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1d4K1h-0003xH-HH
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 00:30:33 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1d4K1g-00026q-DE
	for <qemu-devel@nongnu.org>; Sat, 29 Apr 2017 04:30:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5DB5A2E80C1
	for <qemu-devel@nongnu.org>; Sat, 29 Apr 2017 04:30:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 29 Apr 2017 04:17:52 -0000
From: Launchpad Bug Tracker <760976@bugs.launchpad.net>
Reply-To: Bug 760976 <760976@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110414180333.30573.55328.malonedeb@palladium.canonical.com>
Message-Id: <20170429041752.4182.25782.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 760976] Re: Nexenta 3.0.1 fails to install
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
https://bugs.launchpad.net/bugs/760976

Title:
  Nexenta 3.0.1 fails to install

Status in QEMU:
  Expired

Bug description:
  The latest git version of qemu (commit
  420b6c317de87890e06225de6e2f8af7bf714df0) fails to boot Nexenta3.0.1.
  I don't know if this is a bug in nextenta, or in QEMU or both.

  You can obtain a bootable image of Nextenta from
  http://www.nexenta.org/releases/nexenta-core-
  platform_3.0.1-b134_x86.iso.zip

  Host: Linux/x86_64 gcc4.5 ./configure --enable-linux-aio --enable-io-
  thread --enable-kvm

  qemu-img create nexenta3.0.1 3G
  qemu -hda nexenta3.0.1 -cdrom nexenta-core-platform3.0.1-b134x86.iso -boo=
t d -k en-us -m 256

  Boots to grub OK, but when you hit install you get
  panic[cpu0]/thread=3Dfec226c0: vmem_hash_delete(d4404690, d445abc0, 0):
  bad free.

  You get the same error with or without -enable-kvm

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/760976/+subscriptions
