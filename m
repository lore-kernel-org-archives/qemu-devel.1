Received: from eggs.gnu.org ([2001:4830:134:3::10]:33727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cOdDy-0004S5-6m
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 23:30:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cOdDw-0004tq-Ob
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 23:30:54 -0500
Received: from indium.canonical.com ([91.189.90.7]:60608)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cOdDw-0004sg-IP
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 23:30:52 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cOdDv-0002TA-4b
	for <qemu-devel@nongnu.org>; Wed, 04 Jan 2017 04:30:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id BABFC2E80DA
	for <qemu-devel@nongnu.org>; Wed,  4 Jan 2017 04:30:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Jan 2017 04:18:03 -0000
From: Launchpad Bug Tracker <590552@bugs.launchpad.net>
Reply-To: Bug 590552 <590552@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100606230821.4593.45646.malonedeb@soybean.canonical.com>
Message-Id: <20170104041803.27545.18572.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 590552] Re: New default network card doesn't work
 with tap networking
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
https://bugs.launchpad.net/bugs/590552

Title:
  New default network card doesn't work with tap networking

Status in QEMU:
  Expired

Bug description:
  Unfortunately, I can provide very little information.

  Hope this will be useful anyway.

  I've upgraded qemu using debian apt to lastest unstable (QEMU PC
  emulator version 0.12.4 (Debian 0.12.4+dfsg-2), Copyright (c)
  2003-2008 Fabrice Bellard): looks like at some point the default
  network card for -net nic option was switched to intel gigabit instead
  of the good old ne2k_pci.

  I was using -net tap -net nic options and my network stopped working.
  When not working,
  - tcpdump on the host shows me taht all packets are sent and received fin=
e from guest
  - tcpdump on guest shows that packets from host are NOT received

  obviously, both host tap interface and guest eth0 interfaces, routing
  tables, dns, firewall, etc... are well configured.

  Having banged my head for a while, I finally stopped the host and
  started it again using -net nic,model=3Dne2k_pci option, then my network
  magically started working again.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/590552/+subscriptions
