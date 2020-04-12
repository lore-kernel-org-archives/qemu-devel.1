Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576EBC2BB85
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 04:27:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2426A20578
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 04:27:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2426A20578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNUD5-0000q8-8l
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 00:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53915)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jNUBy-0008Im-LR
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 00:26:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jNUBx-0001F7-5c
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 00:25:58 -0400
Received: from indium.canonical.com ([91.189.90.7]:43798)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jNUBx-0001Eg-0O
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 00:25:57 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jNUBv-000692-13
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2020 04:25:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id C19382E8114
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2020 04:25:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Apr 2020 04:17:31 -0000
From: Launchpad Bug Tracker <1665389@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Expired; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: kvm
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: bonzini dgilbert-h janitor ngoldin th-huth
X-Launchpad-Bug-Reporter: Nadav Goldin (ngoldin)
X-Launchpad-Bug-Modifier: Launchpad Janitor (janitor)
References: <20170216160426.5716.21453.malonedeb@soybean.canonical.com>
Message-Id: <158666505118.12794.12855782690057738372.malone@loganberry.canonical.com>
Subject: [Bug 1665389] Re: Nested kvm guest fails to start on a emulated
 Westmere CPU guest under a Broadwell CPU host
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="2e26c9bbd21cdca248baaea29aeffb920afcc32a";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 40e1bb59e510b2b4a90fed2ff0ef0c842f6cc766
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
Reply-To: Bug 1665389 <1665389@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1665389

Title:
  Nested kvm guest fails to start on a emulated Westmere CPU guest under
  a Broadwell CPU host

Status in QEMU:
  Expired

Bug description:
  Using latest master(5dae13), qemu fails to start any nested guest in a
  Westmere emulated guest(layer 1), under a Broadwell host(layer 0),
  with the error:

  qemu-custom: /root/qemu/target/i386/kvm.c:1849: kvm_put_msrs:
  Assertion `ret =3D=3D cpu->kvm_msr_buf->nmsrs' failed.

  The qemu command used(though other CPUs didn't work either):
  /usr/bin/qemu-custom -name guest=3D12ed9230-vm-el73,debug-threads=3Don -S=
 -object secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/d=
omain-5-12ed9230-vm-el73/master-key.aes -machine pc-i440fx-2.9,accel=3Dkvm,=
usb=3Doff -cpu Westmere,+vmx -m 512 -realtime mlock=3Doff -smp 2,sockets=3D=
2,cores=3D1,threads=3D1 -object iothread,id=3Diothread1 -uuid f4ce4eba-985f=
-42a3-94c4-6e4a8a530347 -nographic -no-user-config -nodefaults -chardev soc=
ket,id=3Dcharmonitor,path=3D/var/lib/libvirt/qemu/domain-5-12ed9230-vm-el73=
/monitor.sock,server,nowait -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3D=
control -rtc base=3Dutc -no-shutdown -boot menu=3Doff,strict=3Don -device v=
irtio-serial-pci,id=3Dvirtio-serial0,bus=3Dpci.0,addr=3D0x3 -drive file=3D/=
root/lago/.lago/default/images/vm-el73_root.qcow2,format=3Dqcow2,if=3Dnone,=
id=3Ddrive-virtio-disk0,serial=3D1,discard=3Dunmap -device virtio-blk-pci,s=
csi=3Doff,bus=3Dpci.0,addr=3D0x4,drive=3Ddrive-virtio-disk0,id=3Dvirtio-dis=
k0,bootindex=3D1 -netdev tap,fd=3D26,id=3Dhostnet0,vhost=3Don,vhostfd=3D28 =
-device virtio-net-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D54:52:c0:a7:c8:02,=
bus=3Dpci.0,addr=3D0x2 -chardev pty,id=3Dcharserial0 -device isa-serial,cha=
rdev=3Dcharserial0,id=3Dserial0 -chardev socket,id=3Dcharchannel0,path=3D/v=
ar/lib/libvirt/qemu/channel/target/domain-5-12ed9230-vm-el73/org.qemu.guest=
_agent.0,server,nowait -device virtserialport,bus=3Dvirtio-serial0.0,nr=3D1=
,chardev=3Dcharchannel0,id=3Dchannel0,name=3Dorg.qemu.guest_agent.0 -object=
 rng-random,id=3Dobjrng0,filename=3D/dev/random -device virtio-rng-pci,rng=
=3Dobjrng0,id=3Drng0,bus=3Dpci.0,addr=3D0x9 -msg timestamp=3Don
  2017-02-16T15:14:45.840412Z qemu-custom: -chardev pty,id=3Dcharserial0: c=
har device redirected to /dev/pts/2 (label charserial0)
  qemu-custom: /root/qemu/target/i386/kvm.c:1849: kvm_put_msrs: Assertion `=
ret =3D=3D cpu->kvm_msr_buf->nmsrs' failed.

  =

  The CPU flags in the Westmere guest:
  flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pa=
t pse36 clflush mmx fxsr sse sse2 syscall nx lm constant_tsc rep_good nopl =
pni pclmulqdq vmx ssse3 cx16 sse4_1 sse4_2 x2apic popcnt aes hypervisor lah=
f_lm arat tpr_shadow vnmi flexpriority ept vpid

  The guest kernel is 3.10.0-514.2.2.el7.x86_64.

  The CPU flags of the host(Broadwell): =

  flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pa=
t pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb =
rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology no=
nstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx smx e=
st tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt=
 tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch epb=
 intel_pt tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 hl=
e avx2 smep bmi2 erms invpcid rtm mpx rdseed adx smap clflushopt xsaveopt x=
savec xgetbv1 xsaves dtherm ida arat pln pts hwp hwp_notify hwp_act_window =
hwp_epp

  qemu command on the host - Broadwell(which works):
  /usr/bin/qemu-kvm -name 4ffcd448-vm-el73,debug-threads=3Don -S -machine p=
c-i440fx-2.6,accel=3Dkvm,usb=3Doff -cpu Westmere,+x2apic,+vmx,+vme -m 4096 =
-realtime mlock=3Doff -smp 2,sockets=3D2,cores=3D1,threads=3D1 -object ioth=
read,id=3Diothread1 -uuid 8cc0a2cf-d25a-4014-acdb-f159c376a532 -nographic -=
no-user-config -nodefaults -chardev socket,id=3Dcharmonitor,path=3D/var/lib=
/libvirt/qemu/domain-4-4ffcd448-vm-el73/monitor.sock,server,nowait -mon cha=
rdev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc base=3Dutc -no-shutdown=
 -boot menu=3Doff,strict=3Don -device virtio-scsi-pci,id=3Dscsi0,bus=3Dpci.=
0,addr=3D0x3 -device virtio-serial-pci,id=3Dvirtio-serial0,bus=3Dpci.0,addr=
=3D0x4 -drive file=3D/home/ngoldin/src/nvgoldin.github.com/lago-init-files/=
.lago/flags-tests/default/images/vm-el73_root.qcow2,format=3Dqcow2,if=3Dnon=
e,id=3Ddrive-virtio-disk0,serial=3D1,discard=3Dunmap -device virtio-blk-pci=
,scsi=3Doff,bus=3Dpci.0,addr=3D0x5,drive=3Ddrive-virtio-disk0,id=3Dvirtio-d=
isk0,bootindex=3D1 -drive file=3D/home/ngoldin/src/nvgoldin.github.com/lago=
-init-files/.lago/flags-tests/default/images/vm-el73_additonal.qcow2,format=
=3Dqcow2,if=3Dnone,id=3Ddrive-scsi0-0-0-0,serial=3D2,discard=3Dunmap -devic=
e scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D0,drive=3Ddrive-scsi0=
-0-0-0,id=3Dscsi0-0-0-0,bootindex=3D2 -netdev tap,fd=3D29,id=3Dhostnet0,vho=
st=3Don,vhostfd=3D31 -device virtio-net-pci,netdev=3Dhostnet0,id=3Dnet0,mac=
=3D54:52:c0:a8:c9:02,bus=3Dpci.0,addr=3D0x2 -chardev pty,id=3Dcharserial0 -=
device isa-serial,chardev=3Dcharserial0,id=3Dserial0 -chardev socket,id=3Dc=
harchannel0,path=3D/var/lib/libvirt/qemu/channel/target/domain-4-4ffcd448-v=
m-el73/org.qemu.guest_agent.0,server,nowait -device virtserialport,bus=3Dvi=
rtio-serial0.0,nr=3D1,chardev=3Dcharchannel0,id=3Dchannel0,name=3Dorg.qemu.=
guest_agent.0 -object rng-random,id=3Dobjrng0,filename=3D/dev/random -devic=
e virtio-rng-pci,rng=3Dobjrng0,id=3Drng0,bus=3Dpci.0,addr=3D0x9 -msg timest=
amp=3Don

  On the Broadwell host I'm using a distribution package if it matters
  (qemu-kvm-2.6.2-5.fc24.x86_64 and 4.8.15-200.fc24.x86_64)

  As the error indicates, I think this assertion was put in:
  commit 48e1a45c3166d659f781171a47dabf4a187ed7a5
  Author: Paolo Bonzini <pbonzini@redhat.com>
  Date:   Wed Mar 30 22:55:29 2016 +0200

      target-i386: assert that KVM_GET/SET_MSRS can set all requested MSRs
      =

      This would have caught the bug in the previous patch.
      =

      Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

  I tried going back one commit before to 273c515, and then the error is go=
ne and the nested guest comes up as expected. If I try to run with head at =
the above commit(48e145c) the error output is slightly different, though it=
 looks the same:
  /root/qemu/target-i386/kvm.c:1713: kvm_put_msrs: Assertion `ret =3D=3D n'=
 failed.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1665389/+subscriptions

