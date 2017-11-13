Received: from eggs.gnu.org ([2001:4830:134:3::10]:43410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eE6Nr-0005E9-UP
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 23:30:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eE6Nn-0001Y0-Sv
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 23:30:07 -0500
Received: from indium.canonical.com ([91.189.90.7]:33524)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eE6Nn-0001Wk-Ml
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 23:30:03 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eE6Nk-0003Yj-Fc
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 04:30:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 3447D2E80D4
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 04:30:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Nov 2017 04:17:24 -0000
From: Launchpad Bug Tracker <1254940@bugs.launchpad.net>
Reply-To: Bug 1254940 <1254940@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20131126015941.27755.36754.malonedeb@soybean.canonical.com>
Message-Id: <151054664427.17693.17661495704434639698.malone@loganberry.canonical.com>
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

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1254940

Title:
  qemu-KVM guest OS occurs many ext3-fs errors after multiple forced
  shutdown

Status in QEMU:
  Expired

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
