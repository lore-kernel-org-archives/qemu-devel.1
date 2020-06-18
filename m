Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35BEC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 16:11:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8445E2073E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 16:11:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8445E2073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlx8U-0007RG-Rv
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 12:11:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jlx7w-00070x-EB
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 12:10:56 -0400
Received: from indium.canonical.com ([91.189.90.7]:33574)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jlx7s-0006vs-TT
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 12:10:56 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jlx7r-0008TN-08
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 16:10:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id F407B2E802B
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 16:10:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2020 16:03:13 -0000
From: Peter Maydell <1818075@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: berrange pmaydell rcfa ross
X-Launchpad-Bug-Reporter: Ross Burton (ross)
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
References: <155136199055.29310.6029801353341134939.malonedeb@chaenomeles.canonical.com>
Message-Id: <159249619361.17414.5365913606513605111.malone@chaenomeles.canonical.com>
Subject: [Bug 1818075] Re: qemu x86 TCG doesn't support AVX insns
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1cbd0aa39df153c901321817f9b57cf3f232b507";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: eaf1b5771713b454804b53f82f6e4d4b7191818a
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 11:20:43
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Reply-To: Bug 1818075 <1818075@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We do care about emulation; but as always with open source software
projects, the parts that get more care and attention are the parts that
people are either paid to work on or are personally interested in. x86
guest emulation in particular is not very well maintained (though it is
better than some targets), because mostly people are happy to use x86
hardware, and adding support for emulation of large new architectural
features like AVX is a lot of work. If you would like to help improve
x86 guest emulation, you are welcome to submit patches to fix bugs or
add new features. Merely saying "X should be better and you should
somehow magically find three months worth of developer time to make it
so" doesn't really do anything to move the situation forwards.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1818075

Title:
  qemu x86 TCG doesn't support AVX insns

Status in QEMU:
  New

Bug description:
  I'm trying to execute code that has been built with -march=3Dskylake
  -mtune=3Dgeneric -mavx2 under qemu-user x86-64 with -cpu Skylake-Client.
  However this code just hangs at 100% CPU.

  Adding input tracing shows that it is likely hanging when dealing with
  an AVX instruction:

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
prefetch [bit 8]
  warning: TCG doesn't support requested feature: CPUID.0DH:EAX.xsavec [bit=
 1]

  IN:
  0x4000b4ef3b:  c5 fb 5c ca              vsubsd   %xmm2, %xmm0, %xmm1
  0x4000b4ef3f:  c4 e1 fb 2c d1           vcvttsd2si %xmm1, %rdx
  0x4000b4ef44:  4c 31 e2                 xorq     %r12, %rdx
  0x4000b4ef47:  48 85 d2                 testq    %rdx, %rdx
  0x4000b4ef4a:  79 9e                    jns      0x4000b4eeea

  [ hangs ]

  Attaching a gdb produces this stacktrace:

  (gdb) bt
  #0  canonicalize (status=3D0x55a20ff67a88, parm=3D0x55a20bb807e0 <float64=
_params>, part=3D...)
      at /data/poky-tmp/master/work/x86_64-linux/qemu-native/3.1.0-r0/qemu-=
3.1.0/fpu/softfloat.c:350
  #1  float64_unpack_canonical (s=3D0x55a20ff67a88, f=3D0)
      at /data/poky-tmp/master/work/x86_64-linux/qemu-native/3.1.0-r0/qemu-=
3.1.0/fpu/softfloat.c:547
  #2  float64_sub (a=3D0, b=3D4890909195324358656, status=3D0x55a20ff67a88)
      at /data/poky-tmp/master/work/x86_64-linux/qemu-native/3.1.0-r0/qemu-=
3.1.0/fpu/softfloat.c:776
  #3  0x000055a20baa1949 in helper_subsd (env=3D<optimized out>, d=3D0x55a2=
0ff67ad8, s=3D<optimized out>)
      at /data/poky-tmp/master/work/x86_64-linux/qemu-native/3.1.0-r0/qemu-=
3.1.0/target/i386/ops_sse.h:623
  #4  0x000055a20cfcfea8 in static_code_gen_buffer ()
  #5  0x000055a20ba3f764 in cpu_tb_exec (itb=3D<optimized out>, cpu=3D0x55a=
20cea2180 <static_code_gen_buffer+15684720>)
      at /data/poky-tmp/master/work/x86_64-linux/qemu-native/3.1.0-r0/qemu-=
3.1.0/accel/tcg/cpu-exec.c:171
  #6  cpu_loop_exec_tb (tb_exit=3D<synthetic pointer>, last_tb=3D<synthetic=
 pointer>, tb=3D<optimized out>,
      cpu=3D0x55a20cea2180 <static_code_gen_buffer+15684720>)
      at /data/poky-tmp/master/work/x86_64-linux/qemu-native/3.1.0-r0/qemu-=
3.1.0/accel/tcg/cpu-exec.c:615
  #7  cpu_exec (cpu=3Dcpu@entry=3D0x55a20ff5f4d0)
      at /data/poky-tmp/master/work/x86_64-linux/qemu-native/3.1.0-r0/qemu-=
3.1.0/accel/tcg/cpu-exec.c:725
  #8  0x000055a20ba6d728 in cpu_loop (env=3D0x55a20ff67780)
      at /data/poky-tmp/master/work/x86_64-linux/qemu-native/3.1.0-r0/qemu-=
3.1.0/linux-user/x86_64/../i386/cpu_loop.c:93
  #9  0x000055a20ba049ff in main (argc=3D<optimized out>, argv=3D0x7ffc5857=
2868, envp=3D<optimized out>)
      at /data/poky-tmp/master/work/x86_64-linux/qemu-native/3.1.0-r0/qemu-=
3.1.0/linux-user/main.c:819

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1818075/+subscriptions

