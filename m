Received: from eggs.gnu.org ([2001:4830:134:3::10]:45430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dIWl2-0005kw-DW
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 04:56:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dIWkz-0007bh-Lw
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 04:56:04 -0400
Received: from indium.canonical.com ([91.189.90.7]:59052)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dIWkz-0007bD-Fh
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 04:56:01 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dIWky-0006ks-Dd
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 08:56:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 668642E8194
	for <qemu-devel@nongnu.org>; Wed,  7 Jun 2017 08:56:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Jun 2017 08:42:09 -0000
From: Thomas Huth <816860@bugs.launchpad.net>
Reply-To: Bug 816860 <816860@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110727090924.6502.46971.malonedeb@wampee.canonical.com>
Message-Id: <149682492898.32355.5381631999219578545.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 816860] Re: Guest machine freezes when NFS mount
 goes offline
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Can you still reproduce this problem with the latest version of QEMU
(currently version 2.9.0)?

** Changed in: qemu
       Status: Confirmed =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/816860

Title:
  Guest machine freezes when NFS mount goes offline

Status in QEMU:
  Incomplete

Bug description:
  I have a virtual KVM machine that has 2 CDROM units with ISOs mounted
  from a NFS mount point. When NFS server goes offline the virtual
  machine blocks completely instead of throwing read errors for the
  CDROM device.

  Host: Proxmox VE 1.8-11 (Debian GNU/Linux 5.0)
  KVM commandline version: QEMU emulator version 0.14.1 (qemu-kvm-devel)
  Guest: Windows 7 professional SP 1

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/816860/+subscriptions
