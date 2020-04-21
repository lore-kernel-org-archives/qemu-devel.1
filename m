Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0205CC54FD0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 11:51:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7EA8206F4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 11:51:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7EA8206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQrRK-0004g1-Rg
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 07:51:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55528)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jQrQO-00045N-8z
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 07:50:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jQrQK-0005t5-1Y
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 07:50:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:37728)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jQrQJ-0005sP-Iq
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 07:50:43 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jQrQG-0005PF-Su
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 11:50:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id D10C22E8104
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 11:50:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Apr 2020 11:45:28 -0000
From: Philipp Eppelt <1871842@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: babumoger e-philipp ehabkost imammedo
X-Launchpad-Bug-Reporter: Philipp Eppelt (e-philipp)
X-Launchpad-Bug-Modifier: Philipp Eppelt (e-philipp)
References: <158643709116.17430.15995069125716778943.malonedeb@wampee.canonical.com>
 <20200417215345.64800.73351.stgit@localhost.localdomain>
Message-Id: <30a0794e-de41-1188-94bc-611f257f622e@kernkonzept.com>
Subject: Re: [Bug 1871842] [v2 PATCH] target/i386: Fix the CPUID leaf
 CPUID_Fn80000008
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="aad6b57d58e2f621954298e262c1cc904860f5d2";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: d178793a63660bc73c8e298c0ef1f525c6d1dfd4
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 07:50:41
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
Reply-To: Bug 1871842 <1871842@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

thanks for the patch, I tested it in my setup and I'm seeing numbers
that make sense.

However, I can create a setup which places the value 02h* into the
ApicIdSize field, which is reserved. However, I deem this a
configuration issue as well.

* -cpu EPYC-v2 -smp 4,cores=3D4 --> 0x8000_0008[ECX] =3D 0x2003

Cheers,
Philipp

On 4/17/20 11:55 PM, Babu Moger wrote:
> CPUID leaf CPUID_Fn80000008_ECX provides information about the
> number of threads supported by the processor. It was found that
> the field ApicIdSize(bits 15-12) was not set correctly.
> =

> ApicIdSize is defined as the number of bits required to represent
> all the ApicId values within a package.
> =

> Valid Values: Value Description
> 3h-0h		Reserved.
> 4h		up to 16 threads.
> 5h		up to 32 threads.
> 6h		up to 64 threads.
> 7h		up to 128 threads.
> Fh-8h		Reserved.
> =

> Fix the bit appropriately.
> =

> This came up during following thread.
> https://lore.kernel.org/qemu-devel/158643709116.17430.1599506912571677894=
3.malonedeb@wampee.canonical.com/#t
> =

> Refer the Processor Programming Reference (PPR) for AMD Family 17h
> Model 01h, Revision B1 Processors. The documentation is available
> from the bugzilla Link below.
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D206537
> =

> Reported-by: Philipp Eppelt <1871842@bugs.launchpad.net>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v2: =

>   Used env->pkg_offset for bits 15:12 which is already available.
> =

>  target/i386/cpu.c |   15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> =

> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 90ffc5f..5e5a605 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -5830,11 +5830,20 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t ind=
ex, uint32_t count,
>              *eax =3D cpu->phys_bits;
>          }
>          *ebx =3D env->features[FEAT_8000_0008_EBX];
> -        *ecx =3D 0;
> -        *edx =3D 0;
>          if (cs->nr_cores * cs->nr_threads > 1) {
> -            *ecx |=3D (cs->nr_cores * cs->nr_threads) - 1;
> +            /*
> +             * Bits 15:12 is "The number of bits in the initial
> +             * Core::X86::Apic::ApicId[ApicId] value that indicate
> +             * thread ID within a package". This is already stored at
> +             * CPUX86State::pkg_offset.
> +             * Bits 7:0 is "The number of threads in the package is NC+1"
> +             */
> +            *ecx =3D (env->pkg_offset << 12) |
> +                   ((cs->nr_cores * cs->nr_threads) - 1);
> +        } else {
> +            *ecx =3D 0;
>          }
> +        *edx =3D 0;
>          break;
>      case 0x8000000A:
>          if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_SVM) {
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

