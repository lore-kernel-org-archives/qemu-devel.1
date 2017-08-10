Received: from eggs.gnu.org ([2001:4830:134:3::10]:45531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dfhSz-0003zc-M2
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 03:01:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dfhSu-0000Q7-G1
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 03:01:13 -0400
Received: from indium.canonical.com ([91.189.90.7]:55783)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dfhSu-0000Ns-7r
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 03:01:08 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dfhSq-0006cx-VK
	for <qemu-devel@nongnu.org>; Thu, 10 Aug 2017 07:01:05 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D93952E80D4
	for <qemu-devel@nongnu.org>; Thu, 10 Aug 2017 07:01:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Aug 2017 06:43:18 -0000
From: Andrew Cloke <andrew.cloke@canonical.com>
Reply-To: Bug 1709784 <1709784@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150234539347.8549.965612168462169477.malonedeb@soybean.canonical.com>
Message-Id: <150234739857.10925.3290004731340582617.launchpad@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1709784] Re: KVM on 16.04.3 throws an error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Also affects: qemu
   Importance: Undecided
       Status: New

** Also affects: qemu (Ubuntu)
   Importance: Undecided
       Status: New

** No longer affects: qemu

** Changed in: ubuntu-power-systems
     Assignee: (unassigned) =3D> Canonical Server Team (canonical-server)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1709784

Title:
  KVM on 16.04.3 throws an error

Status in The Ubuntu-power-systems project:
  New
Status in linux package in Ubuntu:
  New
Status in qemu package in Ubuntu:
  New

Bug description:
  Problem Description
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  KVM on Ubuntu 16.04.3 throws an error when used
   =

  ---uname output---
  Linux bastion-1 4.4.0-89-generic #112-Ubuntu SMP Mon Jul 31 19:37:08 UTC =
2017 ppc64le ppc64le ppc64le GNU/Linux
   =

  Machine Type =3D  8348-21C Habanero =

   =

  ---Steps to Reproduce---
   Install 16.04.3

  install KVM like:

  apt-get install libvirt-bin qemu qemu-slof qemu-system qemu-utils

  then exit and log back in so virsh will work without sudo

  then run my spawn script

  $ cat spawn.sh
  #!/bin/bash

  img=3D$1
  qemu-system-ppc64 \
  -machine pseries,accel=3Dkvm,usb=3Doff -cpu host -m 512 \
  -display none -nographic \
  -net nic -net user \
  -drive "file=3D$img"

  with a freshly downloaded ubuntu cloud image

  sudo ./spawn.sh xenial-server-cloudimg-ppc64el-disk1.img

  And I get nothing on the output.

  and errors in dmesg

  =

  ubuntu@bastion-1:~$ [  340.180295] Facility 'TM' unavailable, exception a=
t 0xd0000000148b7f10, MSR=3D9000000000009033
  [  340.180399] Oops: Unexpected facility unavailable exception, sig: 6 [#=
1]
  [  340.180513] SMP NR_CPUS=3D2048 NUMA PowerNV
  [  340.180547] Modules linked in: xt_CHECKSUM iptable_mangle ipt_MASQUERA=
DE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 =
nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpud=
p bridge stp llc ebtable_filter ebtables ip6table_filter ip6_tables iptable=
_filter ip_tables x_tables kvm_hv kvm binfmt_misc joydev input_leds mac_hid=
 opal_prd ofpart cmdlinepart powernv_flash ipmi_powernv ipmi_msghandler mtd=
 at24 uio_pdrv_genirq uio ibmpowernv powernv_rng vmx_crypto ib_iser rdma_cm=
 iw_cm ib_cm ib_sa ib_mad ib_core ib_addr iscsi_tcp libiscsi_tcp libiscsi s=
csi_transport_iscsi autofs4 btrfs raid10 raid456 async_raid6_recov async_me=
mcpy async_pq async_xor async_tx xor raid6_pq raid1 raid0 multipath linear =
mlx4_en hid_generic usbhid hid uas usb_storage ast i2c_algo_bit bnx2x ttm d=
rm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops mlx4_core drm a=
hci vxlan libahci ip6_udp_tunnel udp_tunnel mdio libcrc32c
  [  340.181331] CPU: 46 PID: 5252 Comm: qemu-system-ppc Not tainted 4.4.0-=
89-generic #112-Ubuntu
  [  340.181382] task: c000001e34c30b50 ti: c000001e34ce4000 task.ti: c0000=
01e34ce4000
  [  340.181432] NIP: d0000000148b7f10 LR: d000000014822a14 CTR: d000000014=
8b7e40
  [  340.181475] REGS: c000001e34ce77b0 TRAP: 0f60   Not tainted  (4.4.0-89=
-generic)
  [  340.181519] MSR: 9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 22024=
848  XER: 00000000
  [  340.181629] CFAR: d0000000148b7ea4 SOFTE: 1 =

  GPR00: d000000014822a14 c000001e34ce7a30 d0000000148cc018 c000001e37bc000=
0 =

  GPR04: c000001db9ac0000 c000001e34ce7bc0 0000000000000000 000000000000000=
0 =

  GPR08: 0000000000000001 c000001e34c30b50 0000000000000001 d0000000148278f=
8 =

  GPR12: d0000000148b7e40 c00000000fb5b500 0000000000000000 000000000000001=
f =

  GPR16: 00003fff91c30000 0000000000800000 00003fffa8e34390 00003fff9242f20=
0 =

  GPR20: 00003fff92430010 000001001de5c030 00003fff9242eb60 00000000100c1ff=
0 =

  GPR24: 00003fffc91fe990 00003fff91c10028 0000000000000000 c000001e37bc000=
0 =

  GPR28: 0000000000000000 c000001db9ac0000 c000001e37bc0000 c000001db9ac000=
0 =

  [  340.182315] NIP [d0000000148b7f10] kvmppc_vcpu_run_hv+0xd0/0xff0 [kvm_=
hv]
  [  340.182357] LR [d000000014822a14] kvmppc_vcpu_run+0x44/0x60 [kvm]
  [  340.182394] Call Trace:
  [  340.182413] [c000001e34ce7a30] [c000001e34ce7ab0] 0xc000001e34ce7ab0 (=
unreliable)
  [  340.182468] [c000001e34ce7b70] [d000000014822a14] kvmppc_vcpu_run+0x44=
/0x60 [kvm]
  [  340.182522] [c000001e34ce7ba0] [d00000001481f674] kvm_arch_vcpu_ioctl_=
run+0x64/0x170 [kvm]
  [  340.182581] [c000001e34ce7be0] [d000000014813918] kvm_vcpu_ioctl+0x528=
/0x7b0 [kvm]
  [  340.182634] [c000001e34ce7d40] [c0000000002fffa0] do_vfs_ioctl+0x480/0=
x7d0
  [  340.182678] [c000001e34ce7de0] [c0000000003003c4] SyS_ioctl+0xd4/0xf0
  [  340.182723] [c000001e34ce7e30] [c000000000009204] system_call+0x38/0xb4
  [  340.182766] Instruction dump:
  [  340.182788] e92d02a0 e9290a50 e9290108 792a07e3 41820058 e92d02a0 e929=
0a50 e9290108 =

  [  340.182863] 7927e8a4 78e71f87 40820ed8 e92d02a0 <7d4022a6> f9490ee8 e9=
2d02a0 7d4122a6 =

  [  340.182938] ---[ end trace bc5080cb7d18f102 ]---
  [  340.276202] =


  =

  This was with the latest ubuntu cloud image. I get the same thing when tr=
ying to use virt-install with an ISO image. =


  I have no way of loading a KVM on 16.04.3

  =3D=3D Comment: #2 - Jason M. Furmanek <furmanek@us.ibm.com> - 2017-08-09=
 17:42:34 =3D=3D
  I reinstalled with the HWE kernel (4.10).
  I can install VM and see the console and eveything seems fine.

  =3D=3D Comment: #3 - Jason M. Furmanek <furmanek@us.ibm.com> - 2017-08-09=
 17:44:03 =3D=3D
  I had another system at 16.04.2 (4.4) and updated that one to the latest =
and it hit the same issue as above.
  No qemu or libvirt updates were applied. Just kernel updates and a handfu=
l of other stuff.

  Seems this issue is specific to the latest kernel

  old version worked:
  Linux fs7 4.4.0-83-generic #106

  new version did not:
  Linux fs7 4.4.0-89-generic #112-Ubuntu

  =3D=3D Comment: #4 - Gustavo Bueno Romero <gromero@br.ibm.com> - 2017-08-=
09 20:26:42 =3D=3D
  Looks like 46a704f8409f79fd66567ad3f8a7304830a84293 was backported on 88 =
but e47057151422a67ce08747176fa21cb3b526a2c9 was not:

  [gromero@localhost ubuntu-xenial]$ git remote -vv
  origin	git://kernel.ubuntu.com/ubuntu/ubuntu-xenial.git (fetch)
  origin	git://kernel.ubuntu.com/ubuntu/ubuntu-xenial.git (push)

  [gromero@localhost ubuntu-xenial]$ git log Ubuntu-4.4.0-83.106..Ubuntu-4.=
4.0-89.112 --oneline | fgrep "Preserve userspace HTM state properly"
  a97e978 KVM: PPC: Book3S HV: Preserve userspace HTM state properly
  [gromero@localhost ubuntu-xenial]$ git log Ubuntu-4.4.0-83.106..Ubuntu-4.=
4.0-89.112 --oneline | fgrep "Enable TM before accessing TM registers"
  [gromero@localhost ubuntu-xenial]$ git tag --contains a97e978574f41ffcf18=
13c180aba2772d46fbb5b
  Ubuntu-4.4.0-88.111
  Ubuntu-4.4.0-89.112
  Ubuntu-raspi2-4.4.0-1066.74
  Ubuntu-raspi2-4.4.0-1067.75
  Ubuntu-snapdragon-4.4.0-1068.73
  Ubuntu-snapdragon-4.4.0-1069.74

  So =

  https://github.com/torvalds/linux/commit/46a704f8409f79fd66567ad3f8a73048=
30a84293 is present in ISO but https://github.com/torvalds/linux/commit/e47=
057151422a67ce08747176fa21cb3b526a2c9 is not.

To manage notifications about this bug go to:
https://bugs.launchpad.net/ubuntu-power-systems/+bug/1709784/+subscriptions
