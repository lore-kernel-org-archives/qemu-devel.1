Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C46C31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 10:21:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C03D02085A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 10:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C03D02085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55408 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdBEo-00061u-Mk
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 06:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60991)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hdBEH-0005d8-Fn
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 06:20:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hdBEF-0007rY-KE
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 06:20:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:56104)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hdBEF-0007q7-E2
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 06:20:39 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hdBEE-0004AO-7A
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 10:20:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 331A02E80C7
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 10:20:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Jun 2019 10:07:16 -0000
From: "Wei, Yu" <1833204@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: kvm qemu
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: jared2016
X-Launchpad-Bug-Reporter: Wei, Yu (jared2016)
X-Launchpad-Bug-Modifier: Wei, Yu (jared2016)
Message-Id: <156085243624.27530.1654381196148266757.malonedeb@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18981";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 150350098f989ad2d0f32b91928bb5d12fbc0894
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1833204] [NEW] VM failed to start in nested
 virtualization with error "KVM: entry failed, hardware error 0x0"
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1833204 <1833204@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Hi,

I have 3 ubuntu nodes provisioned by IaaS. =

Then I tried to launch VM again in my ubuntu nodes.
It's a little strange that VM could be started successfully in two nodes. =

And always failed in one nodes with error "KVM: entry failed, hardware erro=
r 0x0". =


When using virsh to resume the VM, it failed with following error,
virsh # list
 Id   Name                State
----------------------------------
 1    default_vm-cirros   paused

virsh # resume default_vm-cirros
error: Failed to resume domain default_vm-cirros
error: internal error: unable to execute QEMU command 'cont': Resetting the=
 Virtual Machine is required


The detailed log from /var/log/libvirt/qemu/default_vm-cirros.log is as bel=
ow.
```
2019-06-18 09:55:52.397+0000: starting up libvirt version: 5.0.0, package: =
1.fc28 (Unknown, 2019-01-22-08:04:34, 64723eea657e48d296e6beb0b1be9c4c), qe=
mu version: 3.1.0qemu-3.1.0-4.fc28, kernel: 4.15.0-47-generic, hostname: vm=
-cirros
LC_ALL=3DC \
PATH=3D/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
HOME=3D/root \
QEMU_AUDIO_DRV=3Dnone \
/usr/bin/qemu-system-x86_64 \
-name guest=3Ddefault_vm-cirros,debug-threads=3Don \
-S \
-object secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/do=
main-1-default_vm-cirros/master-key.aes \
-machine pc-q35-3.1,accel=3Dkvm,usb=3Doff,dump-guest-core=3Doff \
-cpu Broadwell-IBRS,vme=3Don,ss=3Don,vmx=3Don,f16c=3Don,rdrand=3Don,hypervi=
sor=3Don,arat=3Don,tsc_adjust=3Don,mpx=3Don,avx512f=3Don,avx512cd=3Don,ssbd=
=3Don,xsaveopt=3Don,abm=3Don,invpcid=3Doff \
-m 489 \
-realtime mlock=3Doff \
-smp 1,sockets=3D1,cores=3D1,threads=3D1 \
-object iothread,id=3Diothread1 \
-uuid 0d2a2043-41c0-59c3-9b17-025022203668 \
-no-user-config \
-nodefaults \
-chardev socket,id=3Dcharmonitor,fd=3D22,server,nowait \
-mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol \
-rtc base=3Dutc \
-no-shutdown \
-boot strict=3Don \
-device pcie-root-port,port=3D0x10,chassis=3D1,id=3Dpci.1,bus=3Dpcie.0,mult=
ifunction=3Don,addr=3D0x2 \
-device pcie-root-port,port=3D0x11,chassis=3D2,id=3Dpci.2,bus=3Dpcie.0,addr=
=3D0x2.0x1 \
-device pcie-root-port,port=3D0x12,chassis=3D3,id=3Dpci.3,bus=3Dpcie.0,addr=
=3D0x2.0x2 \
-device pcie-root-port,port=3D0x13,chassis=3D4,id=3Dpci.4,bus=3Dpcie.0,addr=
=3D0x2.0x3 \
-device pcie-root-port,port=3D0x14,chassis=3D5,id=3Dpci.5,bus=3Dpcie.0,addr=
=3D0x2.0x4 \
-device virtio-serial-pci,id=3Dvirtio-serial0,bus=3Dpci.2,addr=3D0x0 \
-drive file=3D/var/run/kubevirt-ephemeral-disks/container-disk-data/default=
/vm-cirros/disk_containerdisk/disk-image.raw,format=3Draw,if=3Dnone,id=3Ddr=
ive-ua-containerdisk,cache=3Dnone \
-device virtio-blk-pci,scsi=3Doff,bus=3Dpci.3,addr=3D0x0,drive=3Ddrive-ua-c=
ontainerdisk,id=3Dua-containerdisk,bootindex=3D1,write-cache=3Don \
-drive file=3D/var/run/kubevirt-ephemeral-disks/cloud-init-data/default/vm-=
cirros/noCloud.iso,format=3Draw,if=3Dnone,id=3Ddrive-ua-cloudinitdisk,cache=
=3Dnone \
-device virtio-blk-pci,scsi=3Doff,bus=3Dpci.4,addr=3D0x0,drive=3Ddrive-ua-c=
loudinitdisk,id=3Dua-cloudinitdisk,write-cache=3Don \
-netdev tap,fd=3D24,id=3Dhostua-default,vhost=3Don,vhostfd=3D25 \
-device virtio-net-pci,host_mtu=3D1430,netdev=3Dhostua-default,id=3Dua-defa=
ult,mac=3D16:57:38:cd:57:cb,bus=3Dpci.1,addr=3D0x0 \
-chardev socket,id=3Dcharserial0,fd=3D26,server,nowait \
-device isa-serial,chardev=3Dcharserial0,id=3Dserial0 \
-chardev socket,id=3Dcharchannel0,fd=3D27,server,nowait \
-device virtserialport,bus=3Dvirtio-serial0.0,nr=3D1,chardev=3Dcharchannel0=
,id=3Dchannel0,name=3Dorg.qemu.guest_agent.0 \
-vnc vnc=3Dunix:/var/run/kubevirt-private/3b22a138-91af-11e9-af36-0016ac101=
123/virt-vnc \
-device VGA,id=3Dvideo0,vgamem_mb=3D16,bus=3Dpcie.0,addr=3D0x1 \
-sandbox on,obsolete=3Ddeny,elevateprivileges=3Ddeny,spawn=3Ddeny,resourcec=
ontrol=3Ddeny \
-msg timestamp=3Don
KVM: entry failed, hardware error 0x0
EAX=3D00000000 EBX=3D00000000 ECX=3D00000000 EDX=3D000306d2
ESI=3D00000000 EDI=3D00000000 EBP=3D00000000 ESP=3D00000000
EIP=3D0000fff0 EFL=3D00000002 [-------] CPL=3D0 II=3D0 A20=3D1 SMM=3D0 HLT=
=3D0
ES =3D0000 00000000 0000ffff 00009300
CS =3Df000 ffff0000 0000ffff 00009b00
SS =3D0000 00000000 0000ffff 00009300
DS =3D0000 00000000 0000ffff 00009300
FS =3D0000 00000000 0000ffff 00009300
GS =3D0000 00000000 0000ffff 00009300
LDT=3D0000 00000000 0000ffff 00008200
TR =3D0000 00000000 0000ffff 00008b00
GDT=3D     00000000 0000ffff
IDT=3D     00000000 0000ffff
CR0=3D60000010 CR2=3D00000000 CR3=3D00000000 CR4=3D00000000
DR0=3D0000000000000000 DR1=3D0000000000000000 DR2=3D0000000000000000 DR3=3D=
0000000000000000 =

DR6=3D00000000ffff0ff0 DR7=3D0000000000000400
EFER=3D0000000000000000
Code=3D06 66 05 00 00 01 00 8e c1 26 66 a3 14 f5 66 5b 66 5e 66 c3 <ea> 5b =
e0 00 f0 30 36 2f 32 33 2f 39 39 00 fc 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00
```

Ubuntu node version as follow,
cat /etc/os-release =

NAME=3D"Ubuntu"
VERSION=3D"18.04.2 LTS (Bionic Beaver)"
ID=3Dubuntu
ID_LIKE=3Ddebian
PRETTY_NAME=3D"Ubuntu 18.04.2 LTS"
VERSION_ID=3D"18.04"
HOME_URL=3D"https://www.ubuntu.com/"
SUPPORT_URL=3D"https://help.ubuntu.com/"
BUG_REPORT_URL=3D"https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL=3D"https://www.ubuntu.com/legal/terms-and-policies/priva=
cy-policy"
VERSION_CODENAME=3Dbionic
UBUNTU_CODENAME=3Dbionic

Output of `uname -a` is:
4.15.0-47-generic #50-Ubuntu SMP Wed Mar 13 10:44:52 UTC 2019 x86_64 x86_64=
 x86_64 GNU/Linux


Any additional information needed, please let me know.
Thx.

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: kvm qemu

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1833204

Title:
  VM failed to start in nested virtualization with error "KVM: entry
  failed, hardware error 0x0"

Status in QEMU:
  New

Bug description:
  Hi,

  I have 3 ubuntu nodes provisioned by IaaS. =

  Then I tried to launch VM again in my ubuntu nodes.
  It's a little strange that VM could be started successfully in two nodes. =

  And always failed in one nodes with error "KVM: entry failed, hardware er=
ror 0x0". =


  When using virsh to resume the VM, it failed with following error,
  virsh # list
   Id   Name                State
  ----------------------------------
   1    default_vm-cirros   paused

  virsh # resume default_vm-cirros
  error: Failed to resume domain default_vm-cirros
  error: internal error: unable to execute QEMU command 'cont': Resetting t=
he Virtual Machine is required

  =

  The detailed log from /var/log/libvirt/qemu/default_vm-cirros.log is as b=
elow.
  ```
  2019-06-18 09:55:52.397+0000: starting up libvirt version: 5.0.0, package=
: 1.fc28 (Unknown, 2019-01-22-08:04:34, 64723eea657e48d296e6beb0b1be9c4c), =
qemu version: 3.1.0qemu-3.1.0-4.fc28, kernel: 4.15.0-47-generic, hostname: =
vm-cirros
  LC_ALL=3DC \
  PATH=3D/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
  HOME=3D/root \
  QEMU_AUDIO_DRV=3Dnone \
  /usr/bin/qemu-system-x86_64 \
  -name guest=3Ddefault_vm-cirros,debug-threads=3Don \
  -S \
  -object secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/=
domain-1-default_vm-cirros/master-key.aes \
  -machine pc-q35-3.1,accel=3Dkvm,usb=3Doff,dump-guest-core=3Doff \
  -cpu Broadwell-IBRS,vme=3Don,ss=3Don,vmx=3Don,f16c=3Don,rdrand=3Don,hyper=
visor=3Don,arat=3Don,tsc_adjust=3Don,mpx=3Don,avx512f=3Don,avx512cd=3Don,ss=
bd=3Don,xsaveopt=3Don,abm=3Don,invpcid=3Doff \
  -m 489 \
  -realtime mlock=3Doff \
  -smp 1,sockets=3D1,cores=3D1,threads=3D1 \
  -object iothread,id=3Diothread1 \
  -uuid 0d2a2043-41c0-59c3-9b17-025022203668 \
  -no-user-config \
  -nodefaults \
  -chardev socket,id=3Dcharmonitor,fd=3D22,server,nowait \
  -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol \
  -rtc base=3Dutc \
  -no-shutdown \
  -boot strict=3Don \
  -device pcie-root-port,port=3D0x10,chassis=3D1,id=3Dpci.1,bus=3Dpcie.0,mu=
ltifunction=3Don,addr=3D0x2 \
  -device pcie-root-port,port=3D0x11,chassis=3D2,id=3Dpci.2,bus=3Dpcie.0,ad=
dr=3D0x2.0x1 \
  -device pcie-root-port,port=3D0x12,chassis=3D3,id=3Dpci.3,bus=3Dpcie.0,ad=
dr=3D0x2.0x2 \
  -device pcie-root-port,port=3D0x13,chassis=3D4,id=3Dpci.4,bus=3Dpcie.0,ad=
dr=3D0x2.0x3 \
  -device pcie-root-port,port=3D0x14,chassis=3D5,id=3Dpci.5,bus=3Dpcie.0,ad=
dr=3D0x2.0x4 \
  -device virtio-serial-pci,id=3Dvirtio-serial0,bus=3Dpci.2,addr=3D0x0 \
  -drive file=3D/var/run/kubevirt-ephemeral-disks/container-disk-data/defau=
lt/vm-cirros/disk_containerdisk/disk-image.raw,format=3Draw,if=3Dnone,id=3D=
drive-ua-containerdisk,cache=3Dnone \
  -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.3,addr=3D0x0,drive=3Ddrive-ua=
-containerdisk,id=3Dua-containerdisk,bootindex=3D1,write-cache=3Don \
  -drive file=3D/var/run/kubevirt-ephemeral-disks/cloud-init-data/default/v=
m-cirros/noCloud.iso,format=3Draw,if=3Dnone,id=3Ddrive-ua-cloudinitdisk,cac=
he=3Dnone \
  -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.4,addr=3D0x0,drive=3Ddrive-ua=
-cloudinitdisk,id=3Dua-cloudinitdisk,write-cache=3Don \
  -netdev tap,fd=3D24,id=3Dhostua-default,vhost=3Don,vhostfd=3D25 \
  -device virtio-net-pci,host_mtu=3D1430,netdev=3Dhostua-default,id=3Dua-de=
fault,mac=3D16:57:38:cd:57:cb,bus=3Dpci.1,addr=3D0x0 \
  -chardev socket,id=3Dcharserial0,fd=3D26,server,nowait \
  -device isa-serial,chardev=3Dcharserial0,id=3Dserial0 \
  -chardev socket,id=3Dcharchannel0,fd=3D27,server,nowait \
  -device virtserialport,bus=3Dvirtio-serial0.0,nr=3D1,chardev=3Dcharchanne=
l0,id=3Dchannel0,name=3Dorg.qemu.guest_agent.0 \
  -vnc vnc=3Dunix:/var/run/kubevirt-private/3b22a138-91af-11e9-af36-0016ac1=
01123/virt-vnc \
  -device VGA,id=3Dvideo0,vgamem_mb=3D16,bus=3Dpcie.0,addr=3D0x1 \
  -sandbox on,obsolete=3Ddeny,elevateprivileges=3Ddeny,spawn=3Ddeny,resourc=
econtrol=3Ddeny \
  -msg timestamp=3Don
  KVM: entry failed, hardware error 0x0
  EAX=3D00000000 EBX=3D00000000 ECX=3D00000000 EDX=3D000306d2
  ESI=3D00000000 EDI=3D00000000 EBP=3D00000000 ESP=3D00000000
  EIP=3D0000fff0 EFL=3D00000002 [-------] CPL=3D0 II=3D0 A20=3D1 SMM=3D0 HL=
T=3D0
  ES =3D0000 00000000 0000ffff 00009300
  CS =3Df000 ffff0000 0000ffff 00009b00
  SS =3D0000 00000000 0000ffff 00009300
  DS =3D0000 00000000 0000ffff 00009300
  FS =3D0000 00000000 0000ffff 00009300
  GS =3D0000 00000000 0000ffff 00009300
  LDT=3D0000 00000000 0000ffff 00008200
  TR =3D0000 00000000 0000ffff 00008b00
  GDT=3D     00000000 0000ffff
  IDT=3D     00000000 0000ffff
  CR0=3D60000010 CR2=3D00000000 CR3=3D00000000 CR4=3D00000000
  DR0=3D0000000000000000 DR1=3D0000000000000000 DR2=3D0000000000000000 DR3=
=3D0000000000000000 =

  DR6=3D00000000ffff0ff0 DR7=3D0000000000000400
  EFER=3D0000000000000000
  Code=3D06 66 05 00 00 01 00 8e c1 26 66 a3 14 f5 66 5b 66 5e 66 c3 <ea> 5=
b e0 00 f0 30 36 2f 32 33 2f 39 39 00 fc 00 00 00 00 00 00 00 00 00 00 00 0=
0 00 00 00
  ```

  Ubuntu node version as follow,
  cat /etc/os-release =

  NAME=3D"Ubuntu"
  VERSION=3D"18.04.2 LTS (Bionic Beaver)"
  ID=3Dubuntu
  ID_LIKE=3Ddebian
  PRETTY_NAME=3D"Ubuntu 18.04.2 LTS"
  VERSION_ID=3D"18.04"
  HOME_URL=3D"https://www.ubuntu.com/"
  SUPPORT_URL=3D"https://help.ubuntu.com/"
  BUG_REPORT_URL=3D"https://bugs.launchpad.net/ubuntu/"
  PRIVACY_POLICY_URL=3D"https://www.ubuntu.com/legal/terms-and-policies/pri=
vacy-policy"
  VERSION_CODENAME=3Dbionic
  UBUNTU_CODENAME=3Dbionic

  Output of `uname -a` is:
  4.15.0-47-generic #50-Ubuntu SMP Wed Mar 13 10:44:52 UTC 2019 x86_64 x86_=
64 x86_64 GNU/Linux


  Any additional information needed, please let me know.
  Thx.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1833204/+subscriptions

