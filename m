Received: from eggs.gnu.org ([2001:4830:134:3::10]:36655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d2Z63-0001qX-Ad
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 04:11:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d2Z60-0001kp-51
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 04:11:47 -0400
Received: from indium.canonical.com ([91.189.90.7]:42005)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1d2Z5z-0001jm-VH
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 04:11:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1d2Z5x-0007Mv-2c
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 08:11:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 15E222F6145
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 08:11:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Apr 2017 08:01:07 -0000
From: Thomas Huth <1682681@bugs.launchpad.net>
Reply-To: Bug 1682681 <1682681@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170413234628.24443.78476.malonedeb@soybean.canonical.com>
Message-Id: <20170424080109.20512.68940.launchpad@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1682681] Re: qemu 2.5 network model rtl8139
 collisions Ubuntu 16.04.2 LTS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Project changed: qemu =3D> qemu (Ubuntu)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1682681

Title:
  qemu 2.5 network model rtl8139 collisions Ubuntu 16.04.2 LTS

Status in qemu package in Ubuntu:
  New

Bug description:
  When I use NIC model rtl8139, I have a lot collisions and very low transf=
er.
  I tested that with brctl and Open vSwitch, because I thought that was a v=
Switch issue. =

  When I change NIC model to virtio all works as expect.

  Host: Ubuntu 16.04.2 LTS
  Guest: Ubuntu 14.04.5 LTS - affected
  Guest: Ubuntu 16.04.2 LTS - not affected

  QEMU emulator version 2.5.0 (Debian 1:2.5+dfsg-5ubuntu10.10)

To manage notifications about this bug go to:
https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1682681/+subscriptions
