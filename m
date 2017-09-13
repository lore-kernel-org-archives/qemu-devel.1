Received: from eggs.gnu.org ([2001:4830:134:3::10]:40890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ds2Nz-0000yI-TT
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:47:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ds2Nw-0002rZ-0N
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:47:03 -0400
Received: from indium.canonical.com ([91.189.90.7]:41406)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ds2Nv-0002qd-QJ
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:46:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1ds2Ns-0002Cz-Pc
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 07:46:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 6620E2E84AD
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 07:46:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 Sep 2017 07:30:50 -0000
From: Thomas Huth <1254940@bugs.launchpad.net>
Reply-To: Bug 1254940 <1254940@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20131126015941.27755.36754.malonedeb@soybean.canonical.com>
Message-Id: <150528785171.16583.9445379905945917315.launchpad@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1254940] Re: qemu-KVM guest OS occurs many
 ext3-fs errors after multiple forced shutdown
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
     Assignee: benjamin_zb (zhuben1989) =3D> (unassigned)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1254940

Title:
  qemu-KVM guest OS occurs many ext3-fs errors after multiple forced
  shutdown

Status in QEMU:
  Incomplete

Bug description:
  Hi:
  I met some filesysterm errors in a sles guest on KVM. My system environme=
nt is:
  HOST:
  =C2=A0=C2=A0=C2=A0suse 10, the kernel version is 2.6.32.43
  =C2=A0=C2=A0=C2=A0Qemu-KVM 1.2
  =C2=A0=C2=A0=C2=A0Libvirt 1.0
  guest OS:
  =C2=A0=C2=A0=C2=A0suse 10, the kernel version is 2.6.32.43
  VMs use a qcow2 disk.

  Description of problem:
  I have 20+ VMs with qcow2 disk, these VMs have been forced to shut down by
  "virsh destroy" many times during and after VM installation.
  When these vm reboot,dmesg show a ext3-fs mount error occurred on /usr/lo=
cal
  partion /dev/vda3:
  =C2=A0=C2=A0=C2=A0=C2=A0EXT3-fs warning: mounting fs with errors, running=
 e2fsck is recommendedand
  when I wrote into partion /dev/vda3,some errors occurred in dmesg:
  1.error (device vda3): ext3_free_blocks: Freeing blocks not in datazone -=
 block
  =3D 1869619311, count =3D 1error (device vda3): ext3_free_blocks_sb: bit =
already
  cleared for block 2178152error (device vda3): ext3_readdir: bad entry in
  directory #1083501:
  2.[347470.661893] attempt to access beyond end of device[347470.661896] v=
da3:
  rw=3D0, want=3D6870892952, limit=3D41945715[347470.661897] EXT3-fs error =
(device
  vda3): ext3_free_branches: Read failure, inode=3D1083508, block=3D8588616=
18
  3.EXT3-fs error (device vda3): ext3_new_block: block(4295028581) >=3D blo=
cks
  count(-1) - block_group =3D 1, es =3D=3D ffff88021b6c7400

  I suspect this fs-error is caused by multiple forced shutdown, but I can't
  reproduce this bug now.

  So if someone else encountered the same bugs(or fs errors) with me,
  and what the reasons leads to these fs errors, is the qemu or KVM or
  just my "rough" cmd.

  Thanks in Advance
  Regards
  Ben

  Steps to Reproduce:
  I can't reproduce this bug now.

  additional:
  1.multiple forced shutdown during and after the vm installing
  2.vm with qcow2 disk
  3.different vm dmesg different errors in above error list(1/2/3)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1254940/+subscriptions
