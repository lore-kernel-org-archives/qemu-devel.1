Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7108EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 13:26:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 405F52065F
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 13:26:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 405F52065F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc7hB-0007SR-FW
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 09:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jc7gT-0006UN-3f
 for qemu-devel@nongnu.org; Fri, 22 May 2020 09:25:57 -0400
Received: from indium.canonical.com ([91.189.90.7]:44328)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jc7gN-000683-JN
 for qemu-devel@nongnu.org; Fri, 22 May 2020 09:25:56 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jc7gK-0006bM-Qw
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 13:25:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id BD3022E807E
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 13:25:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2020 13:15:50 -0000
From: Paul Goyette <1693667@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: paul-whooppee th-huth
X-Launchpad-Bug-Reporter: Paul Goyette (paul-whooppee)
X-Launchpad-Bug-Modifier: Paul Goyette (paul-whooppee)
References: <149576851455.3442.6872660890935328507.malonedeb@gac.canonical.com>
 <159012464460.7805.8570634820762993435.malone@gac.canonical.com>
Message-Id: <Pine.NEB.4.64.2005220613050.27617@speedy.whooppee.com>
Subject: Re: [Bug 1693667] Re: -cpu haswell / broadwell have no MONITOR in
 features1
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1f7bc749b40714a4cc10f5e4d787118a78037035";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: e97917cf8fe990b6f3b52275222b45f3ebb84441
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 09:00:55
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Bug 1693667 <1693667@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This bug seems not to be a problem, and may reflect an issue with
NetBSD.  Even though the decode of the features1 register does not
include MONITOR/MWAIT, that capability is separately reported on a
separate line, further down (apologies in advance for any confusing
line-wrap):

# cpuctl identify 0
cpu0: highest basic info 0000000d
cpu0: highest hypervisor info 40000001
cpu0: highest extended info 80000008
cpu0: Running on hypervisor: QEMU(TCG)
cpu0: "Intel Core Processor (Broadwell)"
cpu0: Intel Core M-5xxx, 5th gen Core (Broadwell) (686-class), 3198.24 MHz
cpu0: family 0x6 model 0x3d stepping 0x2 (id 0x306d2)
cpu0: features 0x78bfbfd<FPU,DE,PSE,TSC,MSR,PAE,MCE,CX8,APIC,SEP,MTRR,PGE,M=
CA>
cpu0: features 0x78bfbfd<CMOV,PAT,PSE36,CLFLUSH,MMX,FXSR,SSE,SSE2>
cpu0: features1 0xced82203<SSE3,PCLMULQDQ,SSSE3,CX16,SSE41,SSE42,MOVBE,POPC=
NT>
cpu0: features1 0xced82203<AES,XSAVE,OSXSAVE,RDRAND,RAZ>
cpu0: features2 0x28100800<SYSCALL/SYSRET,XD,RDTSCP,EM64T>
cpu0: features3 0x21<LAHF,LZCNT>
cpu0: features5 0x180389<FSGSBASE,BMI1,SMEP,BMI2,ERMS,ADX,SMAP>
cpu0: xsave features 0x7<x87,SSE,AVX>
cpu0: xsave instructions 0x1<XSAVEOPT>
cpu0: xsave area size: current 832, maximum 832, xgetbv enabled
cpu0: enabled xsave 0x7<x87,SSE,AVX>
cpu0: I-cache 32KB 64B/line 8-way, D-cache 32KB 64B/line 8-way
cpu0: L2 cache 4MB 64B/line 16-way
cpu0: L3 cache 16MB 64B/line 16-way
cpu0: Initial APIC ID 0
cpu0: Cluster/Package ID 0
cpu0: Core ID 0
cpu0: SMT ID 0
cpu0: MONITOR/MWAIT extensions 0x3<EMX,IBE>
cpu0: monitor-line size 0
cpu0: DSPM-eax 0x4<ARAT>
cpu0: SEF highest subleaf 00000000
cpu0: Power Management features: 0
cpu0: microcode version 0x0, platform ID 0
#

On Fri, 22 May 2020, Thomas Huth wrote:

> Can you still reproduce this issue with the latest version of QEMU?
> Looking at
> https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D0723cc8a5558c94388 =
for
> example, it might have been fixed since QEMU v4.2...
>
> ** Changed in: qemu
>       Status: New =3D> Incomplete
>
> -- =

> You received this bug notification because you are subscribed to the bug
> report.
> https://bugs.launchpad.net/bugs/1693667
>
> Title:
>  -cpu haswell / broadwell have no MONITOR in features1
>
> Status in QEMU:
>  Incomplete
>
> Bug description:
>  In qemu 2.9.0 if you run
>
>      qemu-system-x86_64 -cpu Broadwell (or Haswell)
>
>  then the CPU features1 flag include the SSE3 bit, but do NOT include
>  the MONITOR/MWAIT bit.  This is so even when the host includes the
>  features.
>
>
>  Additionally, running qemu in this manner results in several error messa=
ges:
>
>  warning: TCG doesn't support requested feature: CPUID.01H:ECX.fma [bit 1=
2]
>  warning: TCG doesn't support requested feature: CPUID.01H:ECX.pcid [bit =
17]
>  warning: TCG doesn't support requested feature: CPUID.01H:ECX.x2apic [bi=
t 21]
>  warning: TCG doesn't support requested feature: CPUID.01H:ECX.tsc-deadli=
ne [bit 24]
>  warning: TCG doesn't support requested feature: CPUID.01H:ECX.avx [bit 2=
8]
>  warning: TCG doesn't support requested feature: CPUID.01H:ECX.f16c [bit =
29]
>  warning: TCG doesn't support requested feature: CPUID.01H:ECX.rdrand [bi=
t 30]
>  warning: TCG doesn't support requested feature: CPUID.07H:EBX.hle [bit 4]
>  warning: TCG doesn't support requested feature: CPUID.07H:EBX.avx2 [bit =
5]
>  warning: TCG doesn't support requested feature: CPUID.07H:EBX.invpcid [b=
it 10]
>  warning: TCG doesn't support requested feature: CPUID.07H:EBX.rtm [bit 1=
1]
>  warning: TCG doesn't support requested feature: CPUID.07H:EBX.rdseed [bi=
t 18]
>  warning: TCG doesn't support requested feature: CPUID.80000001H:ECX.3dno=
wprefetch
>
>
>  (Among possible other uses, the lack of the MONITOR feature bit causes N=
etBSD to fall-back on a
>  check-and-pause loop while an application CPU is waiting to be told to p=
roceed by the boot CPU.)
>
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1693667/+subscriptions
>
> !DSPAM:5ec76256254551748016490!
>
>

+--------------------+--------------------------+-----------------------+
| Paul Goyette       | PGP Key fingerprint:     | E-mail addresses:     |
| (Retired)          | FA29 0E3B 35AF E8AE 6651 | paul@whooppee.com     |
| Software Developer | 0786 F758 55DE 53BA 7731 | pgoyette@netbsd.org   |
+--------------------+--------------------------+-----------------------+

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1693667

Title:
  -cpu haswell / broadwell have no MONITOR in features1

Status in QEMU:
  Incomplete

Bug description:
  In qemu 2.9.0 if you run

      qemu-system-x86_64 -cpu Broadwell (or Haswell)

  then the CPU features1 flag include the SSE3 bit, but do NOT include
  the MONITOR/MWAIT bit.  This is so even when the host includes the
  features.

  =

  Additionally, running qemu in this manner results in several error messag=
es:

  warning: TCG doesn't support requested feature: CPUID.01H:ECX.fma [bit 12]
  warning: TCG doesn't support requested feature: CPUID.01H:ECX.pcid [bit 1=
7]
  warning: TCG doesn't support requested feature: CPUID.01H:ECX.x2apic [bit=
 21]
  warning: TCG doesn't support requested feature: CPUID.01H:ECX.tsc-deadlin=
e [bit 24]
  warning: TCG doesn't support requested feature: CPUID.01H:ECX.avx [bit 28]
  warning: TCG doesn't support requested feature: CPUID.01H:ECX.f16c [bit 2=
9]
  warning: TCG doesn't support requested feature: CPUID.01H:ECX.rdrand [bit=
 30]
  warning: TCG doesn't support requested feature: CPUID.07H:EBX.hle [bit 4]
  warning: TCG doesn't support requested feature: CPUID.07H:EBX.avx2 [bit 5]
  warning: TCG doesn't support requested feature: CPUID.07H:EBX.invpcid [bi=
t 10]
  warning: TCG doesn't support requested feature: CPUID.07H:EBX.rtm [bit 11]
  warning: TCG doesn't support requested feature: CPUID.07H:EBX.rdseed [bit=
 18]
  warning: TCG doesn't support requested feature: CPUID.80000001H:ECX.3dnow=
prefetch

  =

  (Among possible other uses, the lack of the MONITOR feature bit causes Ne=
tBSD to fall-back on a
  check-and-pause loop while an application CPU is waiting to be told to pr=
oceed by the boot CPU.)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1693667/+subscriptions

