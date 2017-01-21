Received: from eggs.gnu.org ([2001:4830:134:3::10]:44195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cUnJl-0001fK-En
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 23:30:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cUnJk-0003le-E6
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 23:30:21 -0500
Received: from indium.canonical.com ([91.189.90.7]:47331)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cUnJk-0003lW-89
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 23:30:20 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cUnJj-00006f-CH
	for <qemu-devel@nongnu.org>; Sat, 21 Jan 2017 04:30:19 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5A7552E80C0
	for <qemu-devel@nongnu.org>; Sat, 21 Jan 2017 04:30:19 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Jan 2017 04:17:33 -0000
From: Launchpad Bug Tracker <744856@bugs.launchpad.net>
Reply-To: Bug 744856 <744856@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110329092737.29142.71749.malonedeb@gandwana.canonical.com>
Message-Id: <20170121041733.20915.83752.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 744856] Re: can't boot when using more than 6
 disks since qemu-kvm-0.13
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
https://bugs.launchpad.net/bugs/744856

Title:
  can't boot when using more than 6 disks since qemu-kvm-0.13

Status in QEMU:
  Expired

Bug description:
  It's not possible to pass more than 6 disks to a guest since qemu-kvm-0.1=
3 (also tested with 0.14).
  If I pass more than 6 disks (as shown below) the machine complains that t=
heir is no bootable disk,

  The problem occurs with virtio and without virtio.

  eg.

  /usr/bin/qemu-system-x86_64  --enable-kvm -boot c   -drive
  file=3D/dev/vgr5/fs-01,if=3Dvirtio -drive file=3D/dev/vgr5/fs-
  01_srv_workspace,if=3Dvirtio -drive file=3D/dev/vgr5/fs-
  01_srv_media,if=3Dvirtio -drive file=3D/dev/vgr5/fs-
  01_srv_company,if=3Dvirtio -drive file=3D/dev/vgr5/fs-01_srv_tmp,if=3Dvir=
tio
  -drive file=3D/dev/vgr5/fs-01_srv_download,if=3Dvirtio -drive
  file=3D/dev/vgr5/fs-01_srv_share,if=3Dvirtio -drive file=3D/dev/vgr5/fs-
  01_srv_backup,if=3Dvirtio -drive file=3D/dev/vgr5/fs-
  01_srv_private,if=3Dvirtio -drive file=3D/dev/vgr5/fs-
  01_srv_build,if=3Dvirtio -drive file=3D/dev/vgr5/fs-01_srv_dev,if=3Dvirtio
  -drive file=3D/dev/vgr5/fs-01_srv_backup2,if=3Dvirtio -drive
  file=3D/dev/vgr5/fs-01_srv_ftp,if=3Dvirtio  -cpu qemu64 -smp 2  -m 4G
  -append root=3D/dev/vda -usbdevice tablet -net
  nic,macaddr=3D90:e6:ba:9d:00:0,model=3De1000 -net
  tap,ifname=3Dtap0,script=3D/usr/sbin/qemu-ifup,downscript=3D/usr/sbin/qem=
u-
  ifdown  -monitor unix:/var/run/kvm/fs-01/monitor,server,nowait
  -pidfile /var/run/kvm/fs-01/pid  -k de -kernel
  /srv/kvm/kernel/linux-2.6.38-gentoo -append root=3D/dev/vda -vnc :0
  -name fs-01,process=3Dfs-01 -vga std

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/744856/+subscriptions
