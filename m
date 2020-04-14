Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0C7C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 08:31:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D586206D5
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 08:31:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D586206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOGz4-000078-Hl
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 04:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52631)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jOGyJ-00081P-VN
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 04:31:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jOGyH-0004zP-UJ
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 04:31:07 -0400
Received: from indium.canonical.com ([91.189.90.7]:34786)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jOGyH-0004yv-O7
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 04:31:05 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jOGyE-00022H-Nj
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 08:31:03 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 891842E810E
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 08:31:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Apr 2020 08:24:52 -0000
From: Philipp Eppelt <1871842@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: babumoger e-philipp imammedo
X-Launchpad-Bug-Reporter: Philipp Eppelt (e-philipp)
X-Launchpad-Bug-Modifier: Philipp Eppelt (e-philipp)
References: <158643709116.17430.15995069125716778943.malonedeb@wampee.canonical.com>
 <20200409160037.431ec776@redhat.com>
 <5f7b85c6-09af-1064-f7f8-66ea7abf3ae3@amd.com>
Message-Id: <4ac73ad4-db45-f2a8-ddcd-a162a6c0eb73@kernkonzept.com>
Subject: Re: [Bug 1871842] [NEW] AMD CPUID leaf 0x8000'0008 reported number of
 cores inconsistent with ACPI.MADT
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="2e26c9bbd21cdca248baaea29aeffb920afcc32a";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 37c8d0c178dfc6b2d973400ff6f96658687ca972
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
Reply-To: Bug 1871842 <1871842@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

thanks for looking into this so quickly.

With this patch applied ontop of git commit
f3bac27cc1e303e1860cc55b9b6889ba39dee587 I still have the issue and it
reports the same numbers. I like the new usage of the ApicIdSize field.


I looked into the mentioned pc_smp_parse() and had it print the topology
for -smp 4:

qemu-system-x86_64: warning: cpu topology: sockets (4) , dies (1) ,
cores (1) , threads (1) , maxcpus (4), cpus (4)

and with -smp 4,cores=3D4:

qemu-system-x86_64: warning: cpu topology: sockets (1) , dies (1) ,
cores (4) , threads (1) , maxcpus (4), cpus (4)

As far as I understand it, these are the numbers the cpuid:8000'0008
code relies on:
`cs->nr_cores`, `cs->nr_threads` with `cs` being of type CPUState.

So I think the issue is rooted with the preferring sockets over cores
when the -smp cmdline option is parsed, as stated in hw/i386/pc.c:729.

I guess this is the same code for Intel and AMD CPUs alike and this
issue just didn't surface for us on Intel CPUs, as they don't have this
CPUID leaf and we don't look at the topology.

This seems to boil down to a more careful use of the -smp option on my
end.

Thanks again for looking into this.

Cheers,
Philipp


On 4/10/20 2:12 AM, Babu Moger wrote:
> Philipp,
>   Can you please check if this patch works for you.
> =

> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 90ffc5f..e467fee 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -5831,10 +5831,17 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t
> index, uint32_t count,
>          }
>          *ebx =3D env->features[FEAT_8000_0008_EBX];
>          *ecx =3D 0;
> -        *edx =3D 0;
>          if (cs->nr_cores * cs->nr_threads > 1) {
> -            *ecx |=3D (cs->nr_cores * cs->nr_threads) - 1;
> +            unsigned long max_apicids, bits_required;
> +
> +            max_apicids =3D (cs->nr_cores * cs->nr_threads) - 1;
> +            if (max_apicids) {
> +                /* Find out the number of bits to represent all the
> apicids */
> +                bits_required =3D find_last_bit(&max_apicids,
> BITS_PER_BYTE) + 1;
> +                *ecx |=3D bits_required << 12 | max_apicids;
> +            }
>          }
> +        *edx =3D 0;
>          break;
>      case 0x8000000A:
>          if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_SVM) {
> =

> =

> On 4/9/20 9:00 AM, Igor Mammedov wrote:
>> On Thu, 09 Apr 2020 12:58:11 -0000
>> Philipp Eppelt <1871842@bugs.launchpad.net> wrote:
>>
>>> Public bug reported:
>>>
>>> Setup:
>>> CPU: AMD EPYC-v2 or host's EPYC cpu
>>> Linux 64-bit fedora host; Kernel version 5.5.15-200.fc31
>>> qemu version: self build
>>> git-head: f3bac27cc1e303e1860cc55b9b6889ba39dee587
>>> config: Configured with: '../configure' '--target-list=3Dx86_64-softmmu=
,mips64el-softmmu,mips64-softmmu,mipsel-softmmu,mips-softmmu,i386-softmmu,a=
arch64-softmmu,arm-softmmu' '--prefix=3D/opt/qemu-master'
>>>
>>> Cmdline: =

>>> qemu-system-x86_64 -kernel /home/peppelt/code/l4/internal/.build-x86_64=
/bin/amd64_gen/bootstrap -append "" -initrd "./fiasco/.build-x86_64/fiasco =
, ... " -serial stdio -nographic -monitor none -nographic -monitor none -cp=
u EPYC-v2 -m 4G -smp 4 =

>>>
>>> Issue:
>>> We are developing an microkernel operating system called L4Re. We recen=
tly got an AMD EPYC server for testing and we couldn't execute SMP tests of=
 our system when running Linux + qemu + VM w/ L4Re.
>>> In fact, the kernel did not recognize any APs at all. On AMD CPUs the k=
ernel checks for the number of cores reported in CPUID leaf 0x8000_0008.ECX=
[NC] or [ApicIdSize].  [0][1]
>>>
>>> The physical machine reports for leaf 0x8000_0008:  EAX: 0x3030 EBX: 0x=
18cf757 ECX: 0x703f EDX: 0x1000
>>> The lower four bits of ECX are the [NC] field and all set.
>>>
>>> When querying inside qemu with -enable-kvm -cpu host -smp 4 (basically =
as replacement and addition to the above cmdline) the CPUID leaf shows: EAX=
: 0x3024, EBX: 0x1001000, ECX: 0x0, EDX: 0x0
>>> Note, ECX is zero. Indicating that this is no SMP capabale CPU.
>>>
>>> I'm debugging it using my local machine and the QEMU provided EPYC-v2
>>> CPU model and it is reproducible there as well and reports:  EAX:
>>> 0x3028, EBX: 0x0, ECX: 0x0, EDX: 0x0
>>>
>>> I checked other AMD based CPU models (phenom, opteron_g3/g5) and they b=
ehave the same. [2] shows the CPUID 0x8000'0008 handling in the QEMU source.
>>> I believe that behavior here is wrong as ECX[NC] should report the numb=
er of cores per processor, as stated in the AMD manual [2] p.584. In my und=
erstanding -smp 4 should then lead to ECX[NC] =3D 0x3.
>>>
>>> The following table shows my findings with the -smp option:
>>> Option | Qemu guest observed ECX value
>>> -smp 4 | 0x0
>>> -smp 4,cores=3D4  | 0x3
>>> -smp 4,cores=3D2,thread=3D2 | 0x3
>>> -smp 4,cores=3D4,threads=3D2 | QEMU boot error: topology false.
>>>
>>> Now, I'm asking myself how the terminology of the AMD manual maps to QE=
MU's -smp option.
>>> Obviously, nr_cores and nr_threads correspond to the cores and threads =
options on the cmdline and cores * threads <=3D 4 (in this example), but wh=
at corresponds the X in -smp X to?
>> I'd say X corresponds to number of logical CPUs.
>> Depending on presence of other options these are distributed among them =
in magical manner
>> (see pc_smp_parse() for starters)
>>
>>> Querying 0x8000'0008 on the physical processor results in different
>>> reports than quering QEMU's model as does it with -enable-kvm -cpu host.
>>>
>>> Furthermore, the ACPI.MADT shows 4 local APICs to be present while the
>>> CPU leave reports a single core processor.
>> it matches -smp X as it should be.
>>
>>>
>>> This leads me to the conclusion that CPUID 0x8000'0008.ECX reports the
>>> wrong number.
>> CCed author of recent epyc patches who might know how AMD should work be=
tter than me.
>>
>>>
>>> Please let me know, if you need more information from my side.
>>>
>>>
>>> [0] https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Fgithub.com%2Fkernkonzept%2Ffiasco%2Fblob%2F522ccc5f29ab120213cf02d71328e2b=
879cbbd19%2Fsrc%2Fkern%2Fia32%2Fkernel_thread-ia32.cpp%23L109&amp;data=3D02=
%7C01%7Cbabu.moger%40amd.com%7C57569f7959744399655b08d7dc8e6e24%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637220379083511672&amp;sdata=3DhcFJzLAVQo=
Ih5IN9CP%2F9cUQNOZoBnpRA6FliJur1wzQ%3D&amp;reserved=3D0
>>> [1] https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Fgithub.com%2Fkernkonzept%2Ffiasco%2Fblob%2F522ccc5f29ab120213cf02d71328e2b=
879cbbd19%2Fsrc%2Fkern%2Fia32%2Fcpu-ia32.cpp%23L1120&amp;data=3D02%7C01%7Cb=
abu.moger%40amd.com%7C57569f7959744399655b08d7dc8e6e24%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637220379083511672&amp;sdata=3DANJIbYKbwfq2bDelH%2=
FRLKnDPIUZc1BwxHspmgxLU7gs%3D&amp;reserved=3D0
>>> [2] https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Fgithub.com%2Fqemu%2Fqemu%2Fblob%2Ff2a8261110c32c4dccd84e774d8dd7a0524e00fb=
%2Ftarget%2Fi386%2Fcpu.c%23L5835&amp;data=3D02%7C01%7Cbabu.moger%40amd.com%=
7C57569f7959744399655b08d7dc8e6e24%7C3dd8961fe4884e608e11a82d994e183d%7C0%7=
C0%7C637220379083511672&amp;sdata=3Doj3mv9e5YOzUsfUjXK44gC8LybyWgMKo8JBIrRR=
%2BmDA%3D&amp;reserved=3D0
>>> [3] https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Fwww.amd.com%2Fsystem%2Ffiles%2FTechDocs%2F24594.pdf&amp;data=3D02%7C01%7Cb=
abu.moger%40amd.com%7C57569f7959744399655b08d7dc8e6e24%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637220379083511672&amp;sdata=3D7Yr3J9ihlqSqXCXKN5J=
JNTByO3NGI%2BGMz2EqBF2Y4hw%3D&amp;reserved=3D0
>>>
>>> ** Affects: qemu
>>>      Importance: Undecided
>>>          Status: New
>>>
>>
> =


-- =

philipp.eppelt@kernkonzept.com - Tel. 0351-41 883 221
http://www.kernkonzept.com

Kernkonzept GmbH.  Sitz: Dresden.  Amtsgericht Dresden, HRB 31129.
Gesch=C3=A4ftsf=C3=BChrer: Dr.-Ing. Michael Hohmuth

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1871842

Title:
  AMD CPUID leaf 0x8000'0008 reported number of cores  inconsistent with
  ACPI.MADT

Status in QEMU:
  New

Bug description:
  Setup:
  CPU: AMD EPYC-v2 or host's EPYC cpu
  Linux 64-bit fedora host; Kernel version 5.5.15-200.fc31
  qemu version: self build
  git-head: f3bac27cc1e303e1860cc55b9b6889ba39dee587
  config: Configured with: '../configure' '--target-list=3Dx86_64-softmmu,m=
ips64el-softmmu,mips64-softmmu,mipsel-softmmu,mips-softmmu,i386-softmmu,aar=
ch64-softmmu,arm-softmmu' '--prefix=3D/opt/qemu-master'

  Cmdline: =

  qemu-system-x86_64 -kernel /home/peppelt/code/l4/internal/.build-x86_64/b=
in/amd64_gen/bootstrap -append "" -initrd "./fiasco/.build-x86_64/fiasco , =
... " -serial stdio -nographic -monitor none -nographic -monitor none -cpu =
EPYC-v2 -m 4G -smp 4 =


  Issue:
  We are developing an microkernel operating system called L4Re. We recentl=
y got an AMD EPYC server for testing and we couldn't execute SMP tests of o=
ur system when running Linux + qemu + VM w/ L4Re.
  In fact, the kernel did not recognize any APs at all. On AMD CPUs the ker=
nel checks for the number of cores reported in CPUID leaf 0x8000_0008.ECX[N=
C] or [ApicIdSize].  [0][1]

  The physical machine reports for leaf 0x8000_0008:  EAX: 0x3030 EBX: 0x18=
cf757 ECX: 0x703f EDX: 0x1000
  The lower four bits of ECX are the [NC] field and all set.

  When querying inside qemu with -enable-kvm -cpu host -smp 4 (basically as=
 replacement and addition to the above cmdline) the CPUID leaf shows: EAX: =
0x3024, EBX: 0x1001000, ECX: 0x0, EDX: 0x0
  Note, ECX is zero. Indicating that this is no SMP capabale CPU.

  I'm debugging it using my local machine and the QEMU provided EPYC-v2
  CPU model and it is reproducible there as well and reports:  EAX:
  0x3028, EBX: 0x0, ECX: 0x0, EDX: 0x0

  I checked other AMD based CPU models (phenom, opteron_g3/g5) and they beh=
ave the same. [2] shows the CPUID 0x8000'0008 handling in the QEMU source.
  I believe that behavior here is wrong as ECX[NC] should report the number=
 of cores per processor, as stated in the AMD manual [2] p.584. In my under=
standing -smp 4 should then lead to ECX[NC] =3D 0x3.

  The following table shows my findings with the -smp option:
  Option | Qemu guest observed ECX value
  -smp 4 | 0x0
  -smp 4,cores=3D4  | 0x3
  -smp 4,cores=3D2,thread=3D2 | 0x3
  -smp 4,cores=3D4,threads=3D2 | QEMU boot error: topology false.

  Now, I'm asking myself how the terminology of the AMD manual maps to QEMU=
's -smp option.
  Obviously, nr_cores and nr_threads correspond to the cores and threads op=
tions on the cmdline and cores * threads <=3D 4 (in this example), but what=
 corresponds the X in -smp X to?

  Querying 0x8000'0008 on the physical processor results in different
  reports than quering QEMU's model as does it with -enable-kvm -cpu
  host.

  Furthermore, the ACPI.MADT shows 4 local APICs to be present while the
  CPU leave reports a single core processor.

  This leads me to the conclusion that CPUID 0x8000'0008.ECX reports the
  wrong number.

  =

  Please let me know, if you need more information from my side.

  =

  [0] https://github.com/kernkonzept/fiasco/blob/522ccc5f29ab120213cf02d713=
28e2b879cbbd19/src/kern/ia32/kernel_thread-ia32.cpp#L109
  [1] https://github.com/kernkonzept/fiasco/blob/522ccc5f29ab120213cf02d713=
28e2b879cbbd19/src/kern/ia32/cpu-ia32.cpp#L1120
  [2] https://github.com/qemu/qemu/blob/f2a8261110c32c4dccd84e774d8dd7a0524=
e00fb/target/i386/cpu.c#L5835
  [3] https://www.amd.com/system/files/TechDocs/24594.pdf

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1871842/+subscriptions

