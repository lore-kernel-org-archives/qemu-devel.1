Received: from eggs.gnu.org ([2001:4830:134:3::10]:33436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cQRb0-0004po-7j
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 23:30:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cQRav-0001ke-P4
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 23:30:10 -0500
Received: from indium.canonical.com ([91.189.90.7]:37183)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cQRav-0001kU-J5
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 23:30:05 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cQRau-0007l9-M7
	for <qemu-devel@nongnu.org>; Mon, 09 Jan 2017 04:30:04 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A53722E80C0
	for <qemu-devel@nongnu.org>; Mon,  9 Jan 2017 04:30:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Jan 2017 04:17:31 -0000
From: Launchpad Bug Tracker <772275@bugs.launchpad.net>
Reply-To: Bug 772275 <772275@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110428104838.18779.37169.malonedeb@soybean.canonical.com>
Message-Id: <20170109041731.18789.1007.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 772275] Re: qemu-kvm-0.14.0 + kernel 2.6.35 :
 win2008r2 virtio nic hanging
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
https://bugs.launchpad.net/bugs/772275

Title:
  qemu-kvm-0.14.0 + kernel 2.6.35 : win2008r2 virtio nic hanging

Status in QEMU:
  Expired

Bug description:
  Hi,

  I'm a proxmox distrib user,

  I have network error with virtio nic cards in win2008r2sp1 server,
  only with qemu 0.14 and 2.6.35 kernel combination.

  after some network transferts (can be 2mb or 500mb), nic doesn't
  respond anymore. only way is to reboot.

  e1000 driver working fine.

  revert back to qemu 0.13+ 2.6.35 kernel works fine  or qemu 0.14 +
  2.6.32 kernel is working fine too.

  i'm using virtio nic drivers 1.1.16 from
  http://alt.fedoraproject.org/pub/alt/virtio-win/latest/images/bin/

  i had also tried the virtio-win-prewhql-0.1-7-nic.tar.gz from
  https://bugzilla.redhat.com/show_bug.cgi?id=3D630830#c26

  i'm not the only proxmox user ,more users reports here :

  http://forum.proxmox.com/threads/6194-Troubles-with-latest-virtio-
  drivers-for-Windows-and-latest-PVE-1.8

  i've also see that a slackware user with winxp guest has the same
  problem

  http://www.spinics.net/lists/kvm/msg51089.html

  =

  I can help to debug if it's possible to have logs somewhere .....

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/772275/+subscriptions
