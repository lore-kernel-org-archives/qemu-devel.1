Return-Path: <SRS0=iivN=EG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60ADC388F9
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 23:31:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAEB12087E
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 23:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAEB12087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZ0Lb-0001LC-RB
	for qemu-devel@archiver.kernel.org; Sat, 31 Oct 2020 19:31:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kZ0Kd-0000sR-9j
 for qemu-devel@nongnu.org; Sat, 31 Oct 2020 19:30:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:43726)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kZ0KZ-0003u5-R6
 for qemu-devel@nongnu.org; Sat, 31 Oct 2020 19:30:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kZ0KW-00017B-UZ
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2020 23:30:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id C387D2E8130
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2020 23:30:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2020 23:25:00 -0000
From: Tuan Anh <1902394@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ta2199
X-Launchpad-Bug-Reporter: Tuan Anh (ta2199)
X-Launchpad-Bug-Modifier: Tuan Anh (ta2199)
Message-Id: <160418670033.8081.6795887605849479929.malonedeb@soybean.canonical.com>
Subject: [Bug 1902394] [NEW] Guest stuck in Paused state right after created It
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="96ff31b88b65a0d0ea73b89333fe7c4a2669d8fb"; Instance="production"
X-Launchpad-Hash: 1759e2e9336a1f4f9d0e9ac595233c1a9544584b
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/31 19:30:41
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Reply-To: Bug 1902394 <1902394@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Im using Centos 8 . I have try to use many Distribution such as :
Centos, Ubuntum, Debian,.. on the guest but still all the the VM get
into paused state immidiately after using virt-install ( I have tried
using virt-manager too )

CPU INFO :
Architecture:        x86_64
CPU op-mode(s):      32-bit, 64-bit
Byte Order:          Little Endian
CPU(s):              8
On-line CPU(s) list: 0-7
Thread(s) per core:  1
Core(s) per socket:  1
Socket(s):           8
NUMA node(s):        1
Vendor ID:           GenuineIntel
CPU family:          6
Model:               85
Model name:          Intel(R) Xeon(R) Silver 4214 CPU @ 2.20GHz
Stepping:            7
CPU MHz:             2199.998
BogoMIPS:            4399.99
Virtualization:      VT-x
Hypervisor vendor:   KVM
Virtualization type: full
L1d cache:           32K
L1i cache:           32K
L2 cache:            4096K
L3 cache:            16384K
NUMA node0 CPU(s):   0-7
Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge m=
ca cmov pat pse36 clflush mmx fxsr sse sse2 ss syscall nx pdpe1gb rdtscp lm=
 constant_tsc arch_perfmon rep_good nopl xtopology cpuid tsc_known_freq pni=
 pclmulqdq vmx ssse3 fma cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_de=
adline_timer aes xsave avx f16c rdrand hypervisor lahf_lm abm 3dnowprefetch=
 invpcid_single pti ssbd ibrs ibpb tpr_shadow vnmi flexpriority ept vpid fs=
gsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms invpcid rtm mpx avx512f rdse=
ed adx smap clflushopt clwb avx512cd xsaveopt xsavec xgetbv1 arat

VM Log :

2020-10-31 08:29:51.737+0000: starting up libvirt version: 4.5.0, package: =
42.module_el8.2.0+320+13f867d7 (CentOS Buildsys <bugs@centos.org>, 2020-05-=
28-17:13:31, ), qemu version: 2.12.0qemu-kvm-2.12.0-99.module_el8.2.0+524+f=
765f7e0.4, kernel: 4.18.0-193.28.1.el8_2.x86_64, hostname: interns.novalocal
LC_ALL=3DC PATH=3D/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin QEMU_AU=
DIO_DRV=3Dspice /usr/libexec/qemu-kvm -name guest=3Dcirros,debug-threads=3D=
on -S -object secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/q=
emu/domain-18-cirros/master-key.aes -machine pc-i440fx-rhel7.6.0,accel=3Dkv=
m,usb=3Doff,vmport=3Doff,dump-guest-core=3Doff -cpu Cascadelake-Server,ss=
=3Don,hypervisor=3Don,tsc-adjust=3Don,arch-capabilities=3Don,ibpb=3Don,skip=
-l1dfl-vmentry=3Don,invpcid=3Doff,avx512dq=3Doff,avx512bw=3Doff,avx512vl=3D=
off,pku=3Doff,avx512vnni=3Doff,pdpe1gb=3Doff -m 1024 -realtime mlock=3Doff =
-smp 1,sockets=3D1,cores=3D1,threads=3D1 -uuid ef9573a3-a02d-4ef0-86cb-e38d=
a7b7b20d -no-user-config -nodefaults -chardev socket,id=3Dcharmonitor,fd=3D=
29,server,nowait -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rt=
c base=3Dutc,driftfix=3Dslew -global kvm-pit.lost_tick_policy=3Ddelay -no-h=
pet -no-shutdown -global PIIX4_PM.disable_s3=3D1 -global PIIX4_PM.disable_s=
4=3D1 -boot strict=3Don -device ich9-usb-ehci1,id=3Dusb,bus=3Dpci.0,addr=3D=
0x5.0x7 -device ich9-usb-uhci1,masterbus=3Dusb.0,firstport=3D0,bus=3Dpci.0,=
multifunction=3Don,addr=3D0x5 -device ich9-usb-uhci2,masterbus=3Dusb.0,firs=
tport=3D2,bus=3Dpci.0,addr=3D0x5.0x1 -device ich9-usb-uhci3,masterbus=3Dusb=
.0,firstport=3D4,bus=3Dpci.0,addr=3D0x5.0x2 -device virtio-serial-pci,id=3D=
virtio-serial0,bus=3Dpci.0,addr=3D0x6 -drive file=3D/home/kvm/cirros-0.3.0-=
x86_64-disk.img,format=3Dqcow2,if=3Dnone,id=3Ddrive-ide0-0-0 -device ide-hd=
,bus=3Dide.0,unit=3D0,drive=3Ddrive-ide0-0-0,id=3Dide0-0-0,bootindex=3D1 -n=
etdev tap,fd=3D31,id=3Dhostnet0 -device e1000,netdev=3Dhostnet0,id=3Dnet0,m=
ac=3D52:54:00:c3:32:b0,bus=3Dpci.0,addr=3D0x3 -chardev pty,id=3Dcharserial0=
 -device isa-serial,chardev=3Dcharserial0,id=3Dserial0 -chardev spicevmc,id=
=3Dcharchannel0,name=3Dvdagent -device virtserialport,bus=3Dvirtio-serial0.=
0,nr=3D1,chardev=3Dcharchannel0,id=3Dchannel0,name=3Dcom.redhat.spice.0 -de=
vice usb-tablet,id=3Dinput0,bus=3Dusb.0,port=3D1 -spice port=3D5900,addr=3D=
127.0.0.1,disable-ticketing,image-compression=3Doff,seamless-migration=3Don=
 -device qxl-vga,id=3Dvideo0,ram_size=3D67108864,vram_size=3D67108864,vram6=
4_size_mb=3D0,vgamem_mb=3D16,max_outputs=3D1,bus=3Dpci.0,addr=3D0x2 -device=
 intel-hda,id=3Dsound0,bus=3Dpci.0,addr=3D0x4 -device hda-duplex,id=3Dsound=
0-codec0,bus=3Dsound0.0,cad=3D0 -chardev spicevmc,id=3Dcharredir0,name=3Dus=
bredir -device usb-redir,chardev=3Dcharredir0,id=3Dredir0,bus=3Dusb.0,port=
=3D2 -chardev spicevmc,id=3Dcharredir1,name=3Dusbredir -device usb-redir,ch=
ardev=3Dcharredir1,id=3Dredir1,bus=3Dusb.0,port=3D3 -device virtio-balloon-=
pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x7 -sandbox on,obsolete=3Ddeny,elevat=
eprivileges=3Ddeny,spawn=3Ddeny,resourcecontrol=3Ddeny -msg timestamp=3Don
2020-10-31T08:29:51.815604Z qemu-kvm: -chardev pty,id=3Dcharserial0: char d=
evice redirected to /dev/pts/1 (label charserial0)
KVM: exception 0 exit (error code 0x0)
EAX=3D00000000 EBX=3D00000000 ECX=3D00000000 EDX=3D00050656
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
0000000000000000
DR6=3D00000000ffff0ff0 DR7=3D0000000000000400
EFER=3D0000000000000000
Code=3D06 66 05 00 00 01 00 8e c1 26 66 a3 74 f0 66 5b 66 5e 66 c3 <ea> 5b =
e0 00 f0 30 36 2f 32 33 2f 39 39 00 fc 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00

The Error I have when try to resume the Guest with Virt Manager :

Error unpausing domain: internal error: unable to execute QEMU command
'cont': Resetting the Virtual Machine is required

Traceback (most recent call last):
  File "/usr/share/virt-manager/virtManager/asyncjob.py", line 75, in cb_wr=
apper
    callback(asyncjob, *args, **kwargs)
  File "/usr/share/virt-manager/virtManager/asyncjob.py", line 111, in tmpcb
    callback(*args, **kwargs)
  File "/usr/share/virt-manager/virtManager/object/libvirtobject.py", line =
66, in newfn
    ret =3D fn(self, *args, **kwargs)
  File "/usr/share/virt-manager/virtManager/object/domain.py", line 1311, i=
n resume
    self._backend.resume()
  File "/usr/lib64/python3.6/site-packages/libvirt.py", line 2012, in resume
    if ret =3D=3D -1: raise libvirtError ('virDomainResume() failed', dom=
=3Dself)
libvirt.libvirtError: internal error: unable to execute QEMU command 'cont'=
: Resetting the Virtual Machine is required


Any help would be so helpful cause I stuck in this case for like 4 days alr=
eady.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1902394

Title:
  Guest stuck in Paused state right after created It

Status in QEMU:
  New

Bug description:
  Im using Centos 8 . I have try to use many Distribution such as :
  Centos, Ubuntum, Debian,.. on the guest but still all the the VM get
  into paused state immidiately after using virt-install ( I have tried
  using virt-manager too )

  CPU INFO :
  Architecture:        x86_64
  CPU op-mode(s):      32-bit, 64-bit
  Byte Order:          Little Endian
  CPU(s):              8
  On-line CPU(s) list: 0-7
  Thread(s) per core:  1
  Core(s) per socket:  1
  Socket(s):           8
  NUMA node(s):        1
  Vendor ID:           GenuineIntel
  CPU family:          6
  Model:               85
  Model name:          Intel(R) Xeon(R) Silver 4214 CPU @ 2.20GHz
  Stepping:            7
  CPU MHz:             2199.998
  BogoMIPS:            4399.99
  Virtualization:      VT-x
  Hypervisor vendor:   KVM
  Virtualization type: full
  L1d cache:           32K
  L1i cache:           32K
  L2 cache:            4096K
  L3 cache:            16384K
  NUMA node0 CPU(s):   0-7
  Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge=
 mca cmov pat pse36 clflush mmx fxsr sse sse2 ss syscall nx pdpe1gb rdtscp =
lm constant_tsc arch_perfmon rep_good nopl xtopology cpuid tsc_known_freq p=
ni pclmulqdq vmx ssse3 fma cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_=
deadline_timer aes xsave avx f16c rdrand hypervisor lahf_lm abm 3dnowprefet=
ch invpcid_single pti ssbd ibrs ibpb tpr_shadow vnmi flexpriority ept vpid =
fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms invpcid rtm mpx avx512f rd=
seed adx smap clflushopt clwb avx512cd xsaveopt xsavec xgetbv1 arat

  VM Log :

  2020-10-31 08:29:51.737+0000: starting up libvirt version: 4.5.0, package=
: 42.module_el8.2.0+320+13f867d7 (CentOS Buildsys <bugs@centos.org>, 2020-0=
5-28-17:13:31, ), qemu version: 2.12.0qemu-kvm-2.12.0-99.module_el8.2.0+524=
+f765f7e0.4, kernel: 4.18.0-193.28.1.el8_2.x86_64, hostname: interns.novalo=
cal
  LC_ALL=3DC PATH=3D/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin QEMU_=
AUDIO_DRV=3Dspice /usr/libexec/qemu-kvm -name guest=3Dcirros,debug-threads=
=3Don -S -object secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvir=
t/qemu/domain-18-cirros/master-key.aes -machine pc-i440fx-rhel7.6.0,accel=
=3Dkvm,usb=3Doff,vmport=3Doff,dump-guest-core=3Doff -cpu Cascadelake-Server=
,ss=3Don,hypervisor=3Don,tsc-adjust=3Don,arch-capabilities=3Don,ibpb=3Don,s=
kip-l1dfl-vmentry=3Don,invpcid=3Doff,avx512dq=3Doff,avx512bw=3Doff,avx512vl=
=3Doff,pku=3Doff,avx512vnni=3Doff,pdpe1gb=3Doff -m 1024 -realtime mlock=3Do=
ff -smp 1,sockets=3D1,cores=3D1,threads=3D1 -uuid ef9573a3-a02d-4ef0-86cb-e=
38da7b7b20d -no-user-config -nodefaults -chardev socket,id=3Dcharmonitor,fd=
=3D29,server,nowait -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol =
-rtc base=3Dutc,driftfix=3Dslew -global kvm-pit.lost_tick_policy=3Ddelay -n=
o-hpet -no-shutdown -global PIIX4_PM.disable_s3=3D1 -global PIIX4_PM.disabl=
e_s4=3D1 -boot strict=3Don -device ich9-usb-ehci1,id=3Dusb,bus=3Dpci.0,addr=
=3D0x5.0x7 -device ich9-usb-uhci1,masterbus=3Dusb.0,firstport=3D0,bus=3Dpci=
.0,multifunction=3Don,addr=3D0x5 -device ich9-usb-uhci2,masterbus=3Dusb.0,f=
irstport=3D2,bus=3Dpci.0,addr=3D0x5.0x1 -device ich9-usb-uhci3,masterbus=3D=
usb.0,firstport=3D4,bus=3Dpci.0,addr=3D0x5.0x2 -device virtio-serial-pci,id=
=3Dvirtio-serial0,bus=3Dpci.0,addr=3D0x6 -drive file=3D/home/kvm/cirros-0.3=
.0-x86_64-disk.img,format=3Dqcow2,if=3Dnone,id=3Ddrive-ide0-0-0 -device ide=
-hd,bus=3Dide.0,unit=3D0,drive=3Ddrive-ide0-0-0,id=3Dide0-0-0,bootindex=3D1=
 -netdev tap,fd=3D31,id=3Dhostnet0 -device e1000,netdev=3Dhostnet0,id=3Dnet=
0,mac=3D52:54:00:c3:32:b0,bus=3Dpci.0,addr=3D0x3 -chardev pty,id=3Dcharseri=
al0 -device isa-serial,chardev=3Dcharserial0,id=3Dserial0 -chardev spicevmc=
,id=3Dcharchannel0,name=3Dvdagent -device virtserialport,bus=3Dvirtio-seria=
l0.0,nr=3D1,chardev=3Dcharchannel0,id=3Dchannel0,name=3Dcom.redhat.spice.0 =
-device usb-tablet,id=3Dinput0,bus=3Dusb.0,port=3D1 -spice port=3D5900,addr=
=3D127.0.0.1,disable-ticketing,image-compression=3Doff,seamless-migration=
=3Don -device qxl-vga,id=3Dvideo0,ram_size=3D67108864,vram_size=3D67108864,=
vram64_size_mb=3D0,vgamem_mb=3D16,max_outputs=3D1,bus=3Dpci.0,addr=3D0x2 -d=
evice intel-hda,id=3Dsound0,bus=3Dpci.0,addr=3D0x4 -device hda-duplex,id=3D=
sound0-codec0,bus=3Dsound0.0,cad=3D0 -chardev spicevmc,id=3Dcharredir0,name=
=3Dusbredir -device usb-redir,chardev=3Dcharredir0,id=3Dredir0,bus=3Dusb.0,=
port=3D2 -chardev spicevmc,id=3Dcharredir1,name=3Dusbredir -device usb-redi=
r,chardev=3Dcharredir1,id=3Dredir1,bus=3Dusb.0,port=3D3 -device virtio-ball=
oon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x7 -sandbox on,obsolete=3Ddeny,el=
evateprivileges=3Ddeny,spawn=3Ddeny,resourcecontrol=3Ddeny -msg timestamp=
=3Don
  2020-10-31T08:29:51.815604Z qemu-kvm: -chardev pty,id=3Dcharserial0: char=
 device redirected to /dev/pts/1 (label charserial0)
  KVM: exception 0 exit (error code 0x0)
  EAX=3D00000000 EBX=3D00000000 ECX=3D00000000 EDX=3D00050656
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
=3D0000000000000000
  DR6=3D00000000ffff0ff0 DR7=3D0000000000000400
  EFER=3D0000000000000000
  Code=3D06 66 05 00 00 01 00 8e c1 26 66 a3 74 f0 66 5b 66 5e 66 c3 <ea> 5=
b e0 00 f0 30 36 2f 32 33 2f 39 39 00 fc 00 00 00 00 00 00 00 00 00 00 00 0=
0 00 00 00

  The Error I have when try to resume the Guest with Virt Manager :

  Error unpausing domain: internal error: unable to execute QEMU command
  'cont': Resetting the Virtual Machine is required

  Traceback (most recent call last):
    File "/usr/share/virt-manager/virtManager/asyncjob.py", line 75, in cb_=
wrapper
      callback(asyncjob, *args, **kwargs)
    File "/usr/share/virt-manager/virtManager/asyncjob.py", line 111, in tm=
pcb
      callback(*args, **kwargs)
    File "/usr/share/virt-manager/virtManager/object/libvirtobject.py", lin=
e 66, in newfn
      ret =3D fn(self, *args, **kwargs)
    File "/usr/share/virt-manager/virtManager/object/domain.py", line 1311,=
 in resume
      self._backend.resume()
    File "/usr/lib64/python3.6/site-packages/libvirt.py", line 2012, in res=
ume
      if ret =3D=3D -1: raise libvirtError ('virDomainResume() failed', dom=
=3Dself)
  libvirt.libvirtError: internal error: unable to execute QEMU command 'con=
t': Resetting the Virtual Machine is required

  =

  Any help would be so helpful cause I stuck in this case for like 4 days a=
lready.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1902394/+subscriptions

