Received: from eggs.gnu.org ([2001:4830:134:3::10]:56527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ciPzi-0003kX-Po
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:25:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ciPzf-0008Qa-Mz
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:25:58 -0500
Received: from indium.canonical.com ([91.189.90.7]:48538)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ciPzf-0008QH-B2
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:25:55 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1ciPzY-0005y3-54
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 18:25:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 047572E80CA
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 18:25:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Feb 2017 18:07:40 -0000
From: Thomas Huth <760976@bugs.launchpad.net>
Reply-To: Bug 760976 <760976@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110414180333.30573.55328.malonedeb@palladium.canonical.com>
Message-Id: <20170227180740.5873.66917.malone@wampee.canonical.com>
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

Triaging old bug tickets ... Is this issue still reproducible with the
latest version of QEMU?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/760976

Title:
  Nexenta 3.0.1 fails to install

Status in QEMU:
  Incomplete

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
