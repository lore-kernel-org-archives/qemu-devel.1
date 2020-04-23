Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F8CC54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 16:56:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C6BD20767
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 16:56:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C6BD20767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRf9D-0000AZ-BF
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 12:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jRf81-0006IM-1z
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 12:55:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jRf3r-0004IL-HT
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 12:50:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:38152)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jRf3q-0004Fr-W9
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 12:50:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jRf3m-0008Dr-C7
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 16:50:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 5928C2E8111
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 16:50:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2020 16:37:52 -0000
From: Ed Wittmann <1874486@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: edwittmann
X-Launchpad-Bug-Reporter: Ed Wittmann (edwittmann)
X-Launchpad-Bug-Modifier: Ed Wittmann (edwittmann)
Message-Id: <158765987293.9065.3835957221037707778.malonedeb@gac.canonical.com>
Subject: [Bug 1874486] [NEW] Bug in qemu-img when converting to
 streamOptimized vmdk images
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="486bbbd6cb608f8eb468ed0d08689a349dfabe49";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 9282ad4ca11556b625ddcbc627fa66aec860e1c2
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 12:50:47
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Received-From: 91.189.90.7
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
Reply-To: Bug 1874486 <1874486@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

I reviewed #1006655, and I think I'm already on a newer version, so this
is either a regression or a new bug.

I have been recently attempting to convert images from raw and qcow2
formats to vmdk. It appears that the option "subformat=3DstreamOptimized"
produces a broken or corrupted disk image.

Current versions, running on Devuan testing:

ii  ipxe-qemu                                 1.0.0+git-20190125.36a4c85-1 =
               all          PXE boot firmware - ROM images for qemu
ii  qemu                                      1:3.1+dfsg-8+deb10u4         =
               amd64        fast processor emulator, dummy package
ii  qemu-efi-aarch64                          0~20181115.85588389-3        =
               all          UEFI firmware for 64-bit ARM virtual machines
ii  qemu-efi-arm                              0~20181115.85588389-3        =
               all          UEFI firmware for 32-bit ARM virtual machines
ii  qemu-kvm                                  1:3.1+dfsg-8+deb10u4         =
               amd64        QEMU Full virtualization on x86 hardware
ii  qemu-slof                                 20180702+dfsg-1              =
               all          Slimline Open Firmware -- QEMU PowerPC version
ii  qemu-system                               1:3.1+dfsg-8+deb10u4         =
               amd64        QEMU full system emulation binaries
ii  qemu-system-arm                           1:3.1+dfsg-8+deb10u4         =
               amd64        QEMU full system emulation binaries (arm)
ii  qemu-system-common                        1:3.1+dfsg-8+deb10u4         =
               amd64        QEMU full system emulation binaries (common fil=
es)
ii  qemu-system-data                          1:3.1+dfsg-8+deb10u4         =
               all          QEMU full system emulation (data files)
ii  qemu-system-gui                           1:3.1+dfsg-8+deb10u4         =
               amd64        QEMU full system emulation binaries (user inter=
face and audio support)
ii  qemu-system-mips                          1:3.1+dfsg-8+deb10u4         =
               amd64        QEMU full system emulation binaries (mips)
ii  qemu-system-misc                          1:3.1+dfsg-8+deb10u4         =
               amd64        QEMU full system emulation binaries (miscellane=
ous)
ii  qemu-system-ppc                           1:3.1+dfsg-8+deb10u4         =
               amd64        QEMU full system emulation binaries (ppc)
ii  qemu-system-sparc                         1:3.1+dfsg-8+deb10u4         =
               amd64        QEMU full system emulation binaries (sparc)
ii  qemu-system-x86                           1:3.1+dfsg-8+deb10u4         =
               amd64        QEMU full system emulation binaries (x86)
ii  qemu-utils                                1:3.1+dfsg-8+deb10u4         =
               amd64        QEMU utilities

Current uname -a:
Linux laptop-dev 5.4.0-0.bpo.3-amd64 #1 SMP Debian 5.4.13-1~bpo10+1 (2020-0=
2-07) x86_64 GNU/Linux

Current CPU info:
$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 158
model name      : Intel(R) Core(TM) i7-8750H CPU @ 2.20GHz
stepping        : 10
microcode       : 0xca
cpu MHz         : 800.109
cache size      : 9216 KB
physical id     : 0
siblings        : 12
core id         : 0
cpu cores       : 6
apicid          : 0
initial apicid  : 0
fpu             : yes
fpu_exception   : yes
cpuid level     : 22
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca =
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx p=
dpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopo=
logy nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx e=
st tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt=
 tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpu=
id_fault epb invpcid_single pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpr=
iority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid=
 mpx rdseed adx smap clflushopt intel_pt xsaveopt xsavec xgetbv1 xsaves dth=
erm ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp md_clear flush_l=
1d
bugs            : cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf=
 mds swapgs itlb_multihit
bogomips        : 4399.99
clflush size    : 64
cache_alignment : 64
address sizes   : 39 bits physical, 48 bits virtual
power management:

$ cat /proc/meminfo
MemTotal:       16098356 kB
MemFree:         2292720 kB
MemAvailable:   12323616 kB


Steps to reproduce:
1) Create a base o/s image in .qcow2 or raw format. I am using a Debian 10 =
(buster) image, and my images are created using packer 1.5.5.
2) Verify that the base image in .qcow2 format boots correctly in virt-mana=
ger when attached to a new VM.
3) Convert the image to vmdk using the following command:
qemu-img convert -f qcow2 -O vmdk -o adapter_type=3Dlsilogic,subformat=3Dst=
reamOptimized,hwversion=3D6 <image name>.qcow2 <image name>.vmdk
4) Create a new VM using the newly-created .vmdk, being sure to make the st=
orage adapter SCSI
Result: The image, on boot, will display many disk read errors. It will boo=
t, but will start in read-only mode.

This same image will also not boot correctly in ESXi or VirtualBox. In
any of the three hypervisor environments, the bootloader menu (grub2)
shows up correctly, but the machine will fail to boot correctly.


I reviewed the vmdk header, and the output is here:

dd if=3Dbase.vmdk of=3Doutput-vm-disk1.descriptor bs=3D1 skip=3D512 count=
=3D1024

$ cat output-vm-disk1.descriptor =

# Disk DescriptorFile
version=3D1
CID=3D2120740c
parentCID=3Dffffffff
createType=3D"streamOptimized"

# Extent description
RW 61440000 SPARSE "base.vmdk"

# The Disk Data Base
#DDB

ddb.virtualHWVersion =3D "6"
ddb.geometry.cylinders =3D "3824"
ddb.geometry.heads =3D "255"
ddb.geometry.sectors =3D "63"
ddb.adapterType =3D "lsilogic"

Removing the "subformat=3DstreamOptimized" argument from the qemu-img
conversion command results in a working, albeit much larger image, with
no disk read errors.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1874486

Title:
  Bug in qemu-img when converting to streamOptimized vmdk images

Status in QEMU:
  New

Bug description:
  I reviewed #1006655, and I think I'm already on a newer version, so
  this is either a regression or a new bug.

  I have been recently attempting to convert images from raw and qcow2
  formats to vmdk. It appears that the option
  "subformat=3DstreamOptimized" produces a broken or corrupted disk image.

  Current versions, running on Devuan testing:

  ii  ipxe-qemu                                 1.0.0+git-20190125.36a4c85-=
1                all          PXE boot firmware - ROM images for qemu
  ii  qemu                                      1:3.1+dfsg-8+deb10u4       =
                 amd64        fast processor emulator, dummy package
  ii  qemu-efi-aarch64                          0~20181115.85588389-3      =
                 all          UEFI firmware for 64-bit ARM virtual machines
  ii  qemu-efi-arm                              0~20181115.85588389-3      =
                 all          UEFI firmware for 32-bit ARM virtual machines
  ii  qemu-kvm                                  1:3.1+dfsg-8+deb10u4       =
                 amd64        QEMU Full virtualization on x86 hardware
  ii  qemu-slof                                 20180702+dfsg-1            =
                 all          Slimline Open Firmware -- QEMU PowerPC version
  ii  qemu-system                               1:3.1+dfsg-8+deb10u4       =
                 amd64        QEMU full system emulation binaries
  ii  qemu-system-arm                           1:3.1+dfsg-8+deb10u4       =
                 amd64        QEMU full system emulation binaries (arm)
  ii  qemu-system-common                        1:3.1+dfsg-8+deb10u4       =
                 amd64        QEMU full system emulation binaries (common f=
iles)
  ii  qemu-system-data                          1:3.1+dfsg-8+deb10u4       =
                 all          QEMU full system emulation (data files)
  ii  qemu-system-gui                           1:3.1+dfsg-8+deb10u4       =
                 amd64        QEMU full system emulation binaries (user int=
erface and audio support)
  ii  qemu-system-mips                          1:3.1+dfsg-8+deb10u4       =
                 amd64        QEMU full system emulation binaries (mips)
  ii  qemu-system-misc                          1:3.1+dfsg-8+deb10u4       =
                 amd64        QEMU full system emulation binaries (miscella=
neous)
  ii  qemu-system-ppc                           1:3.1+dfsg-8+deb10u4       =
                 amd64        QEMU full system emulation binaries (ppc)
  ii  qemu-system-sparc                         1:3.1+dfsg-8+deb10u4       =
                 amd64        QEMU full system emulation binaries (sparc)
  ii  qemu-system-x86                           1:3.1+dfsg-8+deb10u4       =
                 amd64        QEMU full system emulation binaries (x86)
  ii  qemu-utils                                1:3.1+dfsg-8+deb10u4       =
                 amd64        QEMU utilities

  Current uname -a:
  Linux laptop-dev 5.4.0-0.bpo.3-amd64 #1 SMP Debian 5.4.13-1~bpo10+1 (2020=
-02-07) x86_64 GNU/Linux

  Current CPU info:
  $ cat /proc/cpuinfo
  processor       : 0
  vendor_id       : GenuineIntel
  cpu family      : 6
  model           : 158
  model name      : Intel(R) Core(TM) i7-8750H CPU @ 2.20GHz
  stepping        : 10
  microcode       : 0xca
  cpu MHz         : 800.109
  cache size      : 9216 KB
  physical id     : 0
  siblings        : 12
  core id         : 0
  cpu cores       : 6
  apicid          : 0
  initial apicid  : 0
  fpu             : yes
  fpu_exception   : yes
  cpuid level     : 22
  wp              : yes
  flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mc=
a cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx=
 pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xto=
pology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx=
 est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popc=
nt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch c=
puid_fault epb invpcid_single pti ssbd ibrs ibpb stibp tpr_shadow vnmi flex=
priority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpc=
id mpx rdseed adx smap clflushopt intel_pt xsaveopt xsavec xgetbv1 xsaves d=
therm ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp md_clear flush=
_l1d
  bugs            : cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1=
tf mds swapgs itlb_multihit
  bogomips        : 4399.99
  clflush size    : 64
  cache_alignment : 64
  address sizes   : 39 bits physical, 48 bits virtual
  power management:

  $ cat /proc/meminfo
  MemTotal:       16098356 kB
  MemFree:         2292720 kB
  MemAvailable:   12323616 kB

  =

  Steps to reproduce:
  1) Create a base o/s image in .qcow2 or raw format. I am using a Debian 1=
0 (buster) image, and my images are created using packer 1.5.5.
  2) Verify that the base image in .qcow2 format boots correctly in virt-ma=
nager when attached to a new VM.
  3) Convert the image to vmdk using the following command:
  qemu-img convert -f qcow2 -O vmdk -o adapter_type=3Dlsilogic,subformat=3D=
streamOptimized,hwversion=3D6 <image name>.qcow2 <image name>.vmdk
  4) Create a new VM using the newly-created .vmdk, being sure to make the =
storage adapter SCSI
  Result: The image, on boot, will display many disk read errors. It will b=
oot, but will start in read-only mode.

  This same image will also not boot correctly in ESXi or VirtualBox. In
  any of the three hypervisor environments, the bootloader menu (grub2)
  shows up correctly, but the machine will fail to boot correctly.

  =

  I reviewed the vmdk header, and the output is here:

  dd if=3Dbase.vmdk of=3Doutput-vm-disk1.descriptor bs=3D1 skip=3D512 count=
=3D1024

  $ cat output-vm-disk1.descriptor =

  # Disk DescriptorFile
  version=3D1
  CID=3D2120740c
  parentCID=3Dffffffff
  createType=3D"streamOptimized"

  # Extent description
  RW 61440000 SPARSE "base.vmdk"

  # The Disk Data Base
  #DDB

  ddb.virtualHWVersion =3D "6"
  ddb.geometry.cylinders =3D "3824"
  ddb.geometry.heads =3D "255"
  ddb.geometry.sectors =3D "63"
  ddb.adapterType =3D "lsilogic"

  Removing the "subformat=3DstreamOptimized" argument from the qemu-img
  conversion command results in a working, albeit much larger image,
  with no disk read errors.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1874486/+subscriptions

