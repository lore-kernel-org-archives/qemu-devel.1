Received: from eggs.gnu.org ([2001:4830:134:3::10]:36289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fUn8p-0001Bc-Pj
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 01:55:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fUn8k-0006Ey-RD
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 01:55:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:42382)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fUn8k-0006ET-Kp
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 01:55:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fUn8h-0002j9-Qb
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 05:55:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 86F632E80D1
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 05:55:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 Jun 2018 05:48:28 -0000
From: Thomas Huth <1777293@bugs.launchpad.net>
Reply-To: Bug 1777293 <1777293@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152919926666.1690.14324498740395706513.malonedeb@chaenomeles.canonical.com>
Message-Id: <152930090810.2065.3736693606907887195.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1777293] Re: [REQUEST[ SHARING MEMORY WITH HOST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Sorry, but I have a hard to to imagine what you exactly mean here. Do
you mean a possibility for one application in the guest and one in the
host to share a piece of memory? Or do you mean that the operating
systems in the host and guest should somehow share the memory (why?)? Or
do you just look for a possibility to avoid that the guest has a lot of
memory allocated to it when it does not need it? In the latter case,
there is already virtio-balloon, so you should have a look at the virtio
drivers if you need something like this.

** Changed in: qemu
       Status: New =3D> Incomplete

** Changed in: qemu
   Importance: Undecided =3D> Wishlist

** Summary changed:

- [REQUEST[ SHARING MEMORY WITH HOST
+ [REQUEST] SHARING MEMORY WITH HOST

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1777293

Title:
  [REQUEST] SHARING MEMORY WITH HOST

Status in QEMU:
  Incomplete

Bug description:
  Instead of a preallocated memory heap I would like for QEMU to share
  memory using shm.

  Example: Instead of using 16gb out of 32gb of ram to run Windows 10,
  there would be no option to allocate it, but to share the hosts
  resources; ie giving the host full access to the entire ram stack

  =

  I'm not a great programmer but I'm pretty sure QEMU's team could find thi=
s useful

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1777293/+subscriptions
