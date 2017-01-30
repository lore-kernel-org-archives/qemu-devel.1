Received: from eggs.gnu.org ([2001:4830:134:3::10]:49694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cY3bx-0008HH-C6
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 23:30:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cY3bv-0004o4-Iz
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 23:30:37 -0500
Received: from indium.canonical.com ([91.189.90.7]:42588)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cY3bv-0004nP-9u
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 23:30:35 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cY3bu-0004c2-Dt
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 04:30:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 663992E80C0
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 04:30:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 30 Jan 2017 04:17:35 -0000
From: Launchpad Bug Tracker <1027525@bugs.launchpad.net>
Reply-To: Bug 1027525 <1027525@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120721234521.2031.53549.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170130041736.7435.51844.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1027525] Re: Unable to insert cd media located on
 ro nfs mount
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
https://bugs.launchpad.net/bugs/1027525

Title:
  Unable to insert cd media located on ro nfs mount

Status in QEMU:
  Expired

Bug description:
  When issuing a "change" command via the monitor, qemu is unable to
  open the iso file if it is mounted on a read-only nfs share. If I
  mount read-write (and make sure the file is writable by the qemu
  process), then the change command succeeds. Note that this doesn't
  affect media specified on the command line when starting qemu, only
  when changing via the monitor.

  To reproduce, mount cd images directory read only, e.g.

  [root@kvmhost0 ~]# grep iso /etc/fstab
  10.48.50.20:/iso /srv/kvm/iso nfs4 defaults,ro 0 0

  Start qemu with minimal options, just need access to the monitor:

  [root@kvmhost0 ~]# kvm -vnc 127.0.0.1:0 -S

  Connect to the monitor and issue a change command:

  (qemu) change ide1-cd0 /srv/kvm/iso/ubuntu-12.04-server-amd64.iso
  Could not open '/srv/kvm/iso/ubuntu-12.04-server-amd64.iso

  Re-mount the iso directory read-write and notice that the command
  succeeds:

  [root@kvmhost0 ~]# mount -o remount,rw /srv/kvm/iso

  (qemu) change ide1-cd0 /srv/kvm/iso/ubuntu-12.04-server-amd64.iso
  (qemu)

  [root@kvmhost0 ~]# kvm --version
  QEMU emulator version 1.1.1 (qemu-kvm-1.1.1), Copyright (c) 2003-2008 Fab=
rice Bellard
  [root@kvmhost0 ~]# uname -a
  Linux kvmhost0 3.4.5-1-ARCH #1 SMP PREEMPT Mon Jul 16 21:35:54 CEST 2012 =
x86_64 GNU/Linux

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1027525/+subscriptions
