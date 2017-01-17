Received: from eggs.gnu.org ([2001:4830:134:3::10]:52339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTZqD-0006gH-4I
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 14:54:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTZq9-0008BY-4q
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 14:54:49 -0500
Received: from indium.canonical.com ([91.189.90.7]:33270)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cTZq8-0008BD-VM
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 14:54:45 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cTZq5-0005va-Px
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 19:54:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8B48D2E80C6
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 19:54:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Jan 2017 19:42:25 -0000
From: Thomas Huth <629791@bugs.launchpad.net>
Reply-To: Bug 629791 <629791@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100903200317.22391.99418.malonedeb@palladium.canonical.com>
Message-Id: <20170117194227.27527.14454.launchpad@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 629791] Re: sysret sets invalid ss
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/629791

Title:
  sysret sets invalid ss

Status in QEMU:
  Invalid

Bug description:
  I'm developing an OS. I use only sysret to enter user space. When an
  interrupt occurred, it would GPF on iretq'ing from it. On
  investigating, the cs on the stack is 0x2b (valid and correct). The ss
  on the stack is 0x20, which has a rpl of 0 which is incorrect. iretq
  checks that and gpf's. Making the irq handler manually modify it to
  0x23 fixes it locally.

  This happens on the non-kvm'ed qemu. I haven't tried the kvm'ed one.
  Qemu version 0.12.5. I haven't tried with the current development
  version either.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/629791/+subscriptions
