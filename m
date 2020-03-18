Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802FFC10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 11:32:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5252620770
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 11:32:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5252620770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEWwE-0006tQ-Fy
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 07:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46448)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jEWuT-00065L-Ps
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 07:30:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jEWuQ-0000cN-Tb
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 07:30:52 -0400
Received: from indium.canonical.com ([91.189.90.7]:34528)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jEWuQ-0000Y1-N1
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 07:30:50 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jEWuO-0003oc-Qi
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 11:30:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id C6CE82E80CD
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 11:30:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Mar 2020 11:19:39 -0000
From: =?utf-8?q?Christian_Ehrhardt_=EE=83=BF?= <1867519@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
 status=Confirmed; importance=Undecided; assignee=None; 
X-Launchpad-Bug-Tags: focal
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: mohamadh paelzer
X-Launchpad-Bug-Reporter: Mohammad Heib (mohamadh)
X-Launchpad-Bug-Modifier: =?utf-8?q?Christian_Ehrhardt_=EE=83=BF_=28paelzer?=
 =?utf-8?q?=29?=
References: <158428174672.11238.3583143675239092561.malonedeb@soybean.canonical.com>
Message-Id: <158453037963.20791.1530706421439582976.malone@wampee.canonical.com>
Subject: [Bug 1867519] Re: libvirt 6.0 : virtual machine stuck when detaching
 PCI device using virsh command
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="3a6db24bbe7280ec09bae73384238390fcc98ad3";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 5cfe4a27bab04cae15e979408d98d69ea471a763
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Reply-To: Bug 1867519 <1867519@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I re-run the above, full PCI passthrough still attaches/detaches fine.

VFs attach fine
VFs break on detach

I've thrown qemu into GDB and this is the backtrace
Thread 4 "CPU 0/KVM" received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0x7f82f0e31700 (LWP 3998)]
0x000055d2f322d45d in notifier_remove (notifier=3Dnotifier@entry=3D0x55d2f4=
0c5078) at ./util/notify.c:31
31          QLIST_REMOVE(notifier, node);
(gdb) bt
#0  0x000055d2f322d45d in notifier_remove (notifier=3Dnotifier@entry=3D0x55=
d2f40c5078) at ./util/notify.c:31
#1  0x000055d2f2df8df9 in kvm_irqchip_remove_change_notifier (n=3Dn@entry=
=3D0x55d2f40c5078) at ./accel/kvm/kvm-all.c:1409
#2  0x000055d2f2e56989 in vfio_exitfn (pdev=3D<optimized out>) at ./hw/vfio=
/pci.c:3079
#3  0x000055d2f3025c1b in pci_qdev_unrealize (dev=3D<optimized out>, errp=
=3D<optimized out>) at ./hw/pci/pci.c:1131
#4  0x000055d2f2f8c6e2 in device_set_realized (obj=3D<optimized out>, value=
=3D<optimized out>, errp=3D0x0) at ./hw/core/qdev.c:932
#5  0x000055d2f312449b in property_set_bool (obj=3D0x55d2f40c4430, v=3D<opt=
imized out>, name=3D<optimized out>, opaque=3D0x55d2f4083ee0, errp=3D0x0) a=
t ./qom/object.c:2078
#6  0x000055d2f3128c84 in object_property_set_qobject (obj=3Dobj@entry=3D0x=
55d2f40c4430, value=3Dvalue@entry=3D0x7f82dc2f7130, name=3Dname@entry=3D0x5=
5d2f330d85d "realized", errp=3Derrp@entry=3D0x0)
    at ./qom/qom-qobject.c:26
#7  0x000055d2f31264ba in object_property_set_bool (obj=3D0x55d2f40c4430, v=
alue=3D<optimized out>, name=3D0x55d2f330d85d "realized", errp=3D0x0) at ./=
qom/object.c:1336
#8  0x000055d2f2f56bca in acpi_pcihp_device_unplug_cb (hotplug_dev=3D<optim=
ized out>, s=3D<optimized out>, dev=3D0x55d2f40c4430, errp=3D<optimized out=
>) at ./hw/acpi/pcihp.c:269
#9  0x000055d2f2f56253 in acpi_pcihp_eject_slot (s=3D<optimized out>, bsel=
=3D<optimized out>, slots=3Dslots@entry=3D256) at ./hw/acpi/pcihp.c:170
#10 0x000055d2f2f56383 in pci_write (size=3D<optimized out>, data=3D256, ad=
dr=3D8, opaque=3D<optimized out>) at ./hw/acpi/pcihp.c:341
#11 pci_write (opaque=3D<optimized out>, addr=3D<optimized out>, data=3D256=
, size=3D<optimized out>) at ./hw/acpi/pcihp.c:332
#12 0x000055d2f2de9cfb in memory_region_write_accessor (mr=3Dmr@entry=3D0x5=
5d2f4780970, addr=3D8, value=3Dvalue@entry=3D0x7f82f0e304f8, size=3Dsize@en=
try=3D4, shift=3D<optimized out>, =

    mask=3Dmask@entry=3D4294967295, attrs=3D...) at ./memory.c:483
#13 0x000055d2f2de79ee in access_with_adjusted_size (addr=3Daddr@entry=3D8,=
 value=3Dvalue@entry=3D0x7f82f0e304f8, size=3Dsize@entry=3D4, access_size_m=
in=3D<optimized out>, =

    access_size_max=3D<optimized out>, access_fn=3Daccess_fn@entry=3D0x55d2=
f2de9bd0 <memory_region_write_accessor>, mr=3D0x55d2f4780970, attrs=3D...) =
at ./memory.c:544
#14 0x000055d2f2debfc3 in memory_region_dispatch_write (mr=3Dmr@entry=3D0x5=
5d2f4780970, addr=3D8, data=3D<optimized out>, op=3D<optimized out>, attrs=
=3Dattrs@entry=3D...) at ./memory.c:1475
#15 0x000055d2f2d96a30 in flatview_write_continue (fv=3Dfv@entry=3D0x7f82dc=
14bbc0, addr=3Daddr@entry=3D44552, attrs=3D..., buf=3Dbuf@entry=3D0x7f82f17=
e9000 "", len=3Dlen@entry=3D4, addr1=3D<optimized out>, =

    l=3D<optimized out>, mr=3D0x55d2f4780970) at ./include/qemu/host-utils.=
h:164
#16 0x000055d2f2d96c46 in flatview_write (fv=3D0x7f82dc14bbc0, addr=3D44552=
, attrs=3D..., buf=3D0x7f82f17e9000 "", len=3D4) at ./exec.c:3169
#17 0x000055d2f2d9b01f in address_space_write (as=3Das@entry=3D0x55d2f39569=
60 <address_space_io>, addr=3Daddr@entry=3D44552, attrs=3D..., buf=3D<optim=
ized out>, len=3Dlen@entry=3D4) at ./exec.c:3259
#18 0x000055d2f2d9b09e in address_space_rw (as=3Das@entry=3D0x55d2f3956960 =
<address_space_io>, addr=3Daddr@entry=3D44552, attrs=3D..., attrs@entry=3D.=
.., buf=3D<optimized out>, len=3Dlen@entry=3D4, =

    is_write=3Dis_write@entry=3Dtrue) at ./exec.c:3269
#19 0x000055d2f2dfc94f in kvm_handle_io (count=3D1, size=3D4, direction=3D<=
optimized out>, data=3D<optimized out>, attrs=3D..., port=3D44552) at ./acc=
el/kvm/kvm-all.c:2104
#20 kvm_cpu_exec (cpu=3Dcpu@entry=3D0x55d2f3dc9090) at ./accel/kvm/kvm-all.=
c:2350
#21 0x000055d2f2dde53e in qemu_kvm_cpu_thread_fn (arg=3D0x55d2f3dc9090) at =
./cpus.c:1318
#22 qemu_kvm_cpu_thread_fn (arg=3Darg@entry=3D0x55d2f3dc9090) at ./cpus.c:1=
290
#23 0x000055d2f321fe13 in qemu_thread_start (args=3D<optimized out>) at ./u=
til/qemu-thread-posix.c:519
#24 0x00007f82f4290609 in start_thread (arg=3D<optimized out>) at pthread_c=
reate.c:477
#25 0x00007f82f41b7153 in clone () at ../sysdeps/unix/sysv/linux/x86_64/clo=
ne.S:95

** Package changed: libvirt (Ubuntu) =3D> qemu (Ubuntu)

** Summary changed:

- libvirt 6.0 : virtual machine stuck when detaching PCI device using virsh=
 command
+ qemu 4.2 segfaults on VF detach

** Also affects: qemu
   Importance: Undecided
       Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1867519

Title:
  qemu 4.2 segfaults on VF detach

Status in QEMU:
  New
Status in qemu package in Ubuntu:
  Confirmed

Bug description:
  After updating Ubuntu 20.04 to the Beta version, we get the following
  error and the virtual machines stucks when detaching PCI devices using
  virsh command:

  Error:
  error: Failed to detach device from /tmp/vf_interface_attached.xml
  error: internal error: End of file from qemu monitor

  steps to reproduce:
   1. create a VM over Ubuntu 20.04 (5.4.0-14-generic)
   2. attach PCI device to this VM (Mellanox VF for example)
   3. try to detaching  the PCI device using virsh command:
     a. create a pci interface xml file:
          =

        <hostdev mode=3D'subsystem' type=3D'pci' managed=3D'yes'>
        <driver name=3D'vfio'/>
        <source>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x11' slot=3D'0x00' =
function=3D'0x2' />
        </source>
        </hostdev>
      =

     b.  #virsh detach-device <VM-Doman-name> <pci interface xml file>


  - Ubuntu release:
    Description:    Ubuntu Focal Fossa (development branch)
    Release:        20.04

  - Package ver:
    libvirt0:
    Installed: 6.0.0-0ubuntu3
    Candidate: 6.0.0-0ubuntu5
    Version table:
       6.0.0-0ubuntu5 500
          500 http://il.archive.ubuntu.com/ubuntu focal/main amd64 Packages
   *** 6.0.0-0ubuntu3 100
          100 /var/lib/dpkg/status

  - What you expected to happen: =

    PCI device detached without any errors.

  - What happened instead:
    getting the errors above and he VM stuck

  additional info:
  after downgrading the libvirt0 package and all the dependent packages to =
5.4 the previous, version, seems that the issue disappeared

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1867519/+subscriptions

