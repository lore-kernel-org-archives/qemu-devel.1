Received: from eggs.gnu.org ([2001:4830:134:3::10]:49671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cZgl5-0002cP-5G
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 11:30:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cZgl2-0000Zx-05
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 11:30:47 -0500
Received: from indium.canonical.com ([91.189.90.7]:41308)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cZgl1-0000ZN-Ee
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 11:30:43 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cZgkz-0000Qe-CN
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 16:30:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 54BD02E80C6
	for <qemu-devel@nongnu.org>; Fri,  3 Feb 2017 16:30:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Feb 2017 16:25:15 -0000
From: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Reply-To: Bug 1661386 <1661386@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170202204510.26617.69309.malonedeb@wampee.canonical.com>
	<20170203125716.9045.84939.malone@gac.canonical.com>
Message-Id: <CAJs94EbYCb4XyY0H0Nefwbvt5iuPg_R3QOkCJBf4n5JHsOy_Fg@mail.gmail.com>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1661386] Re: Assertion `ret ==
 cpu->kvm_msr_buf->nmsrs' failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello,

The output is the following:

kvm_msr_entry_add: @0 index=3D174 value=3D0
kvm_msr_entry_add: @1 index=3D175 value=3D0
kvm_msr_entry_add: @2 index=3D176 value=3D0
kvm_msr_entry_add: @3 index=3D277 value=3D7040600070406
kvm_msr_entry_add: @4 index=3Dc0000081 value=3D0
kvm_msr_entry_add: @5 index=3Dc0010117 value=3D0
kvm_msr_entry_add: @6 index=3D3b value=3D0
kvm_msr_entry_add: @7 index=3D1a0 value=3D1
kvm_msr_entry_add: @8 index=3Dc0000083 value=3D0
kvm_msr_entry_add: @9 index=3Dc0000102 value=3D0
kvm_msr_entry_add: @10 index=3Dc0000084 value=3D0
kvm_msr_entry_add: @11 index=3Dc0000082 value=3D0
kvm_msr_entry_add: @12 index=3D10 value=3D0
kvm_msr_entry_add: @13 index=3D12 value=3D0
kvm_msr_entry_add: @14 index=3D11 value=3D0
kvm_msr_entry_add: @15 index=3D4b564d02 value=3D0
kvm_msr_entry_add: @16 index=3D4b564d04 value=3D0
kvm_msr_entry_add: @17 index=3D4b564d03 value=3D0
kvm_msr_entry_add: @18 index=3D38d value=3D0
kvm_msr_entry_add: @19 index=3D38f value=3D0
kvm_msr_entry_add: @20 index=3D309 value=3D0
kvm_msr_entry_add: @21 index=3D30a value=3D0
kvm_msr_entry_add: @22 index=3D30b value=3D0
kvm_msr_entry_add: @23 index=3Dc1 value=3D0
kvm_msr_entry_add: @24 index=3D186 value=3D0
kvm_msr_entry_add: @25 index=3Dc2 value=3D0
kvm_msr_entry_add: @26 index=3D187 value=3D0
kvm_msr_entry_add: @27 index=3Dc3 value=3D0
kvm_msr_entry_add: @28 index=3D188 value=3D0
kvm_msr_entry_add: @29 index=3Dc4 value=3D0
kvm_msr_entry_add: @30 index=3D189 value=3D0
kvm_msr_entry_add: @31 index=3D38e value=3D0
kvm_msr_entry_add: @32 index=3D390 value=3D0
kvm_msr_entry_add: @33 index=3D38d value=3D0
kvm_msr_entry_add: @34 index=3D38f value=3D0
kvm_msr_entry_add: @35 index=3D2ff value=3D0
kvm_msr_entry_add: @36 index=3D250 value=3D0
kvm_msr_entry_add: @37 index=3D258 value=3D0
kvm_msr_entry_add: @38 index=3D259 value=3D0
kvm_msr_entry_add: @39 index=3D268 value=3D0
kvm_msr_entry_add: @40 index=3D269 value=3D0
kvm_msr_entry_add: @41 index=3D26a value=3D0
kvm_msr_entry_add: @42 index=3D26b value=3D0
kvm_msr_entry_add: @43 index=3D26c value=3D0
kvm_msr_entry_add: @44 index=3D26d value=3D0
kvm_msr_entry_add: @45 index=3D26e value=3D0
kvm_msr_entry_add: @46 index=3D26f value=3D0
kvm_msr_entry_add: @47 index=3D200 value=3D0
kvm_msr_entry_add: @48 index=3D201 value=3D0
kvm_msr_entry_add: @49 index=3D202 value=3D0
kvm_msr_entry_add: @50 index=3D203 value=3D0
kvm_msr_entry_add: @51 index=3D204 value=3D0
kvm_msr_entry_add: @52 index=3D205 value=3D0
kvm_msr_entry_add: @53 index=3D206 value=3D0
kvm_msr_entry_add: @54 index=3D207 value=3D0
kvm_msr_entry_add: @55 index=3D208 value=3D0
kvm_msr_entry_add: @56 index=3D209 value=3D0
kvm_msr_entry_add: @57 index=3D20a value=3D0
kvm_msr_entry_add: @58 index=3D20b value=3D0
kvm_msr_entry_add: @59 index=3D20c value=3D0
kvm_msr_entry_add: @60 index=3D20d value=3D0
kvm_msr_entry_add: @61 index=3D20e value=3D0
kvm_msr_entry_add: @62 index=3D20f value=3D0
kvm_msr_entry_add: @63 index=3D17a value=3D0
kvm_msr_entry_add: @64 index=3D17b value=3Dffffffffffffffff
kvm_msr_entry_add: @65 index=3D400 value=3Dffffffffffffffff
kvm_msr_entry_add: @66 index=3D401 value=3D0
kvm_msr_entry_add: @67 index=3D402 value=3D0
kvm_msr_entry_add: @68 index=3D403 value=3D0
kvm_msr_entry_add: @69 index=3D404 value=3Dffffffffffffffff
kvm_msr_entry_add: @70 index=3D405 value=3D0
kvm_msr_entry_add: @71 index=3D406 value=3D0
kvm_msr_entry_add: @72 index=3D407 value=3D0
kvm_msr_entry_add: @73 index=3D408 value=3Dffffffffffffffff
kvm_msr_entry_add: @74 index=3D409 value=3D0
kvm_msr_entry_add: @75 index=3D40a value=3D0
kvm_msr_entry_add: @76 index=3D40b value=3D0
kvm_msr_entry_add: @77 index=3D40c value=3Dffffffffffffffff
kvm_msr_entry_add: @78 index=3D40d value=3D0
kvm_msr_entry_add: @79 index=3D40e value=3D0
kvm_msr_entry_add: @80 index=3D40f value=3D0
kvm_msr_entry_add: @81 index=3D410 value=3Dffffffffffffffff
kvm_msr_entry_add: @82 index=3D411 value=3D0
kvm_msr_entry_add: @83 index=3D412 value=3D0
kvm_msr_entry_add: @84 index=3D413 value=3D0
kvm_msr_entry_add: @85 index=3D414 value=3Dffffffffffffffff
kvm_msr_entry_add: @86 index=3D415 value=3D0
kvm_msr_entry_add: @87 index=3D416 value=3D0
kvm_msr_entry_add: @88 index=3D417 value=3D0
kvm_msr_entry_add: @89 index=3D418 value=3Dffffffffffffffff
kvm_msr_entry_add: @90 index=3D419 value=3D0
kvm_msr_entry_add: @91 index=3D41a value=3D0
kvm_msr_entry_add: @92 index=3D41b value=3D0
kvm_msr_entry_add: @93 index=3D41c value=3Dffffffffffffffff
kvm_msr_entry_add: @94 index=3D41d value=3D0
kvm_msr_entry_add: @95 index=3D41e value=3D0
kvm_msr_entry_add: @96 index=3D41f value=3D0
kvm_msr_entry_add: @97 index=3D420 value=3Dffffffffffffffff
kvm_msr_entry_add: @98 index=3D421 value=3D0
kvm_msr_entry_add: @99 index=3D422 value=3D0
kvm_msr_entry_add: @100 index=3D423 value=3D0
kvm_msr_entry_add: @101 index=3D424 value=3Dffffffffffffffff
kvm_msr_entry_add: @102 index=3D425 value=3D0
kvm_msr_entry_add: @103 index=3D426 value=3D0
kvm_msr_entry_add: @104 index=3D427 value=3D0
kvm_put_msrs: ret=3D18 expected=3D105
qemu-system-x86_64: /home/matwey/lab/qemu/target/i386/kvm.c:1852:
kvm_put_msrs: Assertion `ret =3D=3D cpu->kvm_msr_buf->nmsrs' failed.

2017-02-03 15:57 GMT+03:00 Dr. David Alan Gilbert <dgilbert@redhat.com>:
> Hi Matwey,
>   That shouldn't happen!  The patch you've bisected to is just the one th=
at complains if the ioctl fails rather than silently ignoring the failure -=
 it means the failure probably previously existed and was ignored and that =
causes random other problems.
>
> What kernel are you using on the host?
>
> We need to figure out which MSR it's objecting to; probably the easiest
> way is to :
>
> 1) Edit mvm_msr_entry_add in target/i386/kvm.c to something like:
>
>     assert((void *)(entry + 1) <=3D limit);
>     fprintf(stderr,"kvm_msr_entry_add: @%d index=3D%x value=3D%lx\n", msr=
s->nmsrs, index, value);
>     entry->index =3D index;
>
> 2) edit kvm_put_msrs near the bottom:
>
>     fprintf(stderr,"kvm_put_msrs: ret=3D%d expected=3D%d\n", ret, cpu->kv=
m_msr_buf->nmsrs);
>     assert(ret =3D=3D cpu->kvm_msr_buf->nmsrs);
>
> Now with any luck the 'ret' value will tell you the entry which is bad, a=
nd you can match
> that to the @%d value (or maybe it's the entry before that one which fail=
ed?) then we get the index, look it up in the intel docs and figure out whi=
ch MSR it's complaining about.
>
> Dave
>
> --
> You received this bug notification because you are subscribed to the bug
> report.
> https://bugs.launchpad.net/bugs/1661386
>
> Title:
>   Assertion `ret =3D=3D cpu->kvm_msr_buf->nmsrs' failed
>
> Status in QEMU:
>   New
>
> Bug description:
>   Hello,
>
>
>   I see the following when try to run qemu from master as the following:
>
>   # ./x86_64-softmmu/qemu-system-x86_64 --version
>   QEMU emulator version 2.8.50 (v2.8.0-1006-g4e9f524)
>   Copyright (c) 2003-2016 Fabrice Bellard and the QEMU Project developers
>   # ./x86_64-softmmu/qemu-system-x86_64 -machine accel=3Dkvm -nodefaults
>   -no-reboot -nographic -cpu host -vga none  -kernel .build.kernel.kvm
>   -initrd .build.initrd.kvm -append 'panic=3D1 no-kvmclock console=3DttyS0
>   loglevel=3D7' -m 1024 -serial stdio
>   qemu-system-x86_64: /home/matwey/lab/qemu/target/i386/kvm.c:1849:
>   kvm_put_msrs: Assertion `ret =3D=3D cpu->kvm_msr_buf->nmsrs' failed.
>
>   First broken commit has been bisected:
>
>   commit 48e1a45c3166d659f781171a47dabf4a187ed7a5
>   Author: Paolo Bonzini <pbonzini@redhat.com>
>   Date:   Wed Mar 30 22:55:29 2016 +0200
>
>       target-i386: assert that KVM_GET/SET_MSRS can set all requested MSRs
>
>       This would have caught the bug in the previous patch.
>
>       Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>
>   My cpuinfo is the following:
>
>   processor       : 0
>   vendor_id       : GenuineIntel
>   cpu family      : 6
>   model           : 44
>   model name      : Intel(R) Xeon(R) CPU           X5675  @ 3.07GHz
>   stepping        : 2
>   microcode       : 0x14
>   cpu MHz         : 3066.775
>   cache size      : 12288 KB
>   physical id     : 0
>   siblings        : 2
>   core id         : 0
>   cpu cores       : 2
>   apicid          : 0
>   initial apicid  : 0
>   fpu             : yes
>   fpu_exception   : yes
>   cpuid level     : 11
>   wp              : yes
>   flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge =
mca cmov pat pse36 clflush dts mmx fxsr sse sse2 ss ht syscall nx rdtscp lm=
 constant_tsc arch_perfmon pebs bts nopl xtopology tsc_reliable nonstop_tsc=
 aperfmperf pni pclmulqdq vmx ssse3 cx16 sse4_1 sse4_2 popcnt aes hyperviso=
r lahf_lm ida arat epb dtherm tpr_shadow vnmi ept vpid
>   bugs            :
>   bogomips        : 6133.55
>   clflush size    : 64
>   cache_alignment : 64
>   address sizes   : 40 bits physical, 48 bits virtual
>   power management:
>
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1661386/+subscriptions


-- =

With best regards,
Matwey V. Kornilov
http://blog.matwey.name
xmpp://0x2207@jabber.ru

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1661386

Title:
  Assertion `ret =3D=3D cpu->kvm_msr_buf->nmsrs' failed

Status in QEMU:
  New

Bug description:
  Hello,

  =

  I see the following when try to run qemu from master as the following:

  # ./x86_64-softmmu/qemu-system-x86_64 --version
  QEMU emulator version 2.8.50 (v2.8.0-1006-g4e9f524)
  Copyright (c) 2003-2016 Fabrice Bellard and the QEMU Project developers
  # ./x86_64-softmmu/qemu-system-x86_64 -machine accel=3Dkvm -nodefaults
  -no-reboot -nographic -cpu host -vga none  -kernel .build.kernel.kvm
  -initrd .build.initrd.kvm -append 'panic=3D1 no-kvmclock console=3DttyS0
  loglevel=3D7' -m 1024 -serial stdio
  qemu-system-x86_64: /home/matwey/lab/qemu/target/i386/kvm.c:1849:
  kvm_put_msrs: Assertion `ret =3D=3D cpu->kvm_msr_buf->nmsrs' failed.

  First broken commit has been bisected:

  commit 48e1a45c3166d659f781171a47dabf4a187ed7a5
  Author: Paolo Bonzini <pbonzini@redhat.com>
  Date:   Wed Mar 30 22:55:29 2016 +0200

      target-i386: assert that KVM_GET/SET_MSRS can set all requested MSRs
      =

      This would have caught the bug in the previous patch.
      =

      Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

  My cpuinfo is the following:

  processor       : 0
  vendor_id       : GenuineIntel
  cpu family      : 6
  model           : 44
  model name      : Intel(R) Xeon(R) CPU           X5675  @ 3.07GHz
  stepping        : 2
  microcode       : 0x14
  cpu MHz         : 3066.775
  cache size      : 12288 KB
  physical id     : 0
  siblings        : 2
  core id         : 0
  cpu cores       : 2
  apicid          : 0
  initial apicid  : 0
  fpu             : yes
  fpu_exception   : yes
  cpuid level     : 11
  wp              : yes
  flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mc=
a cmov pat pse36 clflush dts mmx fxsr sse sse2 ss ht syscall nx rdtscp lm c=
onstant_tsc arch_perfmon pebs bts nopl xtopology tsc_reliable nonstop_tsc a=
perfmperf pni pclmulqdq vmx ssse3 cx16 sse4_1 sse4_2 popcnt aes hypervisor =
lahf_lm ida arat epb dtherm tpr_shadow vnmi ept vpid
  bugs            :
  bogomips        : 6133.55
  clflush size    : 64
  cache_alignment : 64
  address sizes   : 40 bits physical, 48 bits virtual
  power management:

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1661386/+subscriptions
