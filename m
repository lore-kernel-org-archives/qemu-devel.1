Received: from eggs.gnu.org ([2001:4830:134:3::10]:50410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ceUQ1-0000hA-N5
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 17:20:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ceUPx-0007l3-Im
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 17:20:53 -0500
Received: from indium.canonical.com ([91.189.90.7]:54874)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ceUPx-0007k7-8k
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 17:20:49 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1ceUPv-0001Go-Vo
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 22:20:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id EE9912E80C6
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 22:20:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Feb 2017 22:10:11 -0000
From: Nadav Goldin <1665389@bugs.launchpad.net>
Reply-To: Bug 1665389 <1665389@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170216160426.5716.21453.malonedeb@soybean.canonical.com>
Message-Id: <20170216221011.29891.92012.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1665389] Re: Nested kvm guest fails to start on a
 emulated Westmere CPU guest under a Broadwell CPU host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi Dave, thanks for looking into this.

> Can you clarify what the host and L1 kernels are please?

Host - 4.8.15-200.fc24.x86_64
Guest - 3.10.0-514.2.2.el7.x86_64

Results of adding the debug messages and running a simpler command(with
master again - 5dae13):

[root@vm-el73 ~]# /usr/bin/qemu-custom -s -machine pc,accel=3Dkvm,usb=3Doff=
 -cpu Westmere
kvm_msr_entry_add: @0 index=3D174 value=3D0
kvm_msr_entry_add: @1 index=3D175 value=3D0
kvm_msr_entry_add: @2 index=3D176 value=3D0
kvm_msr_entry_add: @3 index=3D277 value=3D7040600070406
kvm_msr_entry_add: @4 index=3Dc0000081 value=3D0
kvm_msr_entry_add: @5 index=3Dc0010117 value=3D0
kvm_msr_entry_add: @6 index=3D3b value=3D0
kvm_msr_entry_add: @7 index=3D1a0 value=3D1
kvm_msr_entry_add: @8 index=3D9e value=3D30000
kvm_msr_entry_add: @9 index=3Dd90 value=3D0
kvm_msr_entry_add: @10 index=3Dc0000083 value=3D0
kvm_msr_entry_add: @11 index=3Dc0000102 value=3D0
kvm_msr_entry_add: @12 index=3Dc0000084 value=3D0
kvm_msr_entry_add: @13 index=3Dc0000082 value=3D0
kvm_msr_entry_add: @14 index=3D10 value=3D0
kvm_msr_entry_add: @15 index=3D12 value=3D0
kvm_msr_entry_add: @16 index=3D11 value=3D0
kvm_msr_entry_add: @17 index=3D4b564d02 value=3D0
kvm_msr_entry_add: @18 index=3D4b564d04 value=3D0
kvm_msr_entry_add: @19 index=3D4b564d03 value=3D0
kvm_msr_entry_add: @20 index=3D2ff value=3D0
kvm_msr_entry_add: @21 index=3D250 value=3D0
kvm_msr_entry_add: @22 index=3D258 value=3D0
kvm_msr_entry_add: @23 index=3D259 value=3D0
kvm_msr_entry_add: @24 index=3D268 value=3D0
kvm_msr_entry_add: @25 index=3D269 value=3D0
kvm_msr_entry_add: @26 index=3D26a value=3D0
kvm_msr_entry_add: @27 index=3D26b value=3D0
kvm_msr_entry_add: @28 index=3D26c value=3D0
kvm_msr_entry_add: @29 index=3D26d value=3D0
kvm_msr_entry_add: @30 index=3D26e value=3D0
kvm_msr_entry_add: @31 index=3D26f value=3D0
kvm_msr_entry_add: @32 index=3D200 value=3D0
kvm_msr_entry_add: @33 index=3D201 value=3D0
kvm_msr_entry_add: @34 index=3D202 value=3D0
kvm_msr_entry_add: @35 index=3D203 value=3D0
kvm_msr_entry_add: @36 index=3D204 value=3D0
kvm_msr_entry_add: @37 index=3D205 value=3D0
kvm_msr_entry_add: @38 index=3D206 value=3D0
kvm_msr_entry_add: @39 index=3D207 value=3D0
kvm_msr_entry_add: @40 index=3D208 value=3D0
kvm_msr_entry_add: @41 index=3D209 value=3D0
kvm_msr_entry_add: @42 index=3D20a value=3D0
kvm_msr_entry_add: @43 index=3D20b value=3D0
kvm_msr_entry_add: @44 index=3D20c value=3D0
kvm_msr_entry_add: @45 index=3D20d value=3D0
kvm_msr_entry_add: @46 index=3D20e value=3D0
kvm_msr_entry_add: @47 index=3D20f value=3D0
kvm_msr_entry_add: @48 index=3D17a value=3D0
kvm_msr_entry_add: @49 index=3D17b value=3Dffffffffffffffff
kvm_msr_entry_add: @50 index=3D400 value=3Dffffffffffffffff
kvm_msr_entry_add: @51 index=3D401 value=3D0
kvm_msr_entry_add: @52 index=3D402 value=3D0
kvm_msr_entry_add: @53 index=3D403 value=3D0
kvm_msr_entry_add: @54 index=3D404 value=3Dffffffffffffffff
kvm_msr_entry_add: @55 index=3D405 value=3D0
kvm_msr_entry_add: @56 index=3D406 value=3D0
kvm_msr_entry_add: @57 index=3D407 value=3D0
kvm_msr_entry_add: @58 index=3D408 value=3Dffffffffffffffff
kvm_msr_entry_add: @59 index=3D409 value=3D0
kvm_msr_entry_add: @60 index=3D40a value=3D0
kvm_msr_entry_add: @61 index=3D40b value=3D0
kvm_msr_entry_add: @62 index=3D40c value=3Dffffffffffffffff
kvm_msr_entry_add: @63 index=3D40d value=3D0
kvm_msr_entry_add: @64 index=3D40e value=3D0
kvm_msr_entry_add: @65 index=3D40f value=3D0
kvm_msr_entry_add: @66 index=3D410 value=3Dffffffffffffffff
kvm_msr_entry_add: @67 index=3D411 value=3D0
kvm_msr_entry_add: @68 index=3D412 value=3D0
kvm_msr_entry_add: @69 index=3D413 value=3D0
kvm_msr_entry_add: @70 index=3D414 value=3Dffffffffffffffff
kvm_msr_entry_add: @71 index=3D415 value=3D0
kvm_msr_entry_add: @72 index=3D416 value=3D0
kvm_msr_entry_add: @73 index=3D417 value=3D0
kvm_msr_entry_add: @74 index=3D418 value=3Dffffffffffffffff
kvm_msr_entry_add: @75 index=3D419 value=3D0
kvm_msr_entry_add: @76 index=3D41a value=3D0
kvm_msr_entry_add: @77 index=3D41b value=3D0
kvm_msr_entry_add: @78 index=3D41c value=3Dffffffffffffffff
kvm_msr_entry_add: @79 index=3D41d value=3D0
kvm_msr_entry_add: @80 index=3D41e value=3D0
kvm_msr_entry_add: @81 index=3D41f value=3D0
kvm_msr_entry_add: @82 index=3D420 value=3Dffffffffffffffff
kvm_msr_entry_add: @83 index=3D421 value=3D0
kvm_msr_entry_add: @84 index=3D422 value=3D0
kvm_msr_entry_add: @85 index=3D423 value=3D0
kvm_msr_entry_add: @86 index=3D424 value=3Dffffffffffffffff
kvm_msr_entry_add: @87 index=3D425 value=3D0
kvm_msr_entry_add: @88 index=3D426 value=3D0
kvm_msr_entry_add: @89 index=3D427 value=3D0
kvm_put_msrs: ret=3D9 expected=3D90
qemu-custom: /root/qemu/target/i386/kvm.c:1849: kvm_put_msrs: Assertion `re=
t =3D=3D cpu->kvm_msr_buf->nmsrs' failed.
Aborted

> Also, does the problem go away if you remove the +x2apic on the top
level qemu?

Don't think so, I actually added it because I thought it would solve
something. I can re-try with out it if needed(with the debug messages).

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1665389

Title:
  Nested kvm guest fails to start on a emulated Westmere CPU guest under
  a Broadwell CPU host

Status in QEMU:
  New

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
