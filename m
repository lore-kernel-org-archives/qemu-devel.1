Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CA9C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 17:12:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D832E206E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 17:12:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D832E206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia0rb-0000de-11
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 12:12:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37037)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1ia0qE-0007sa-QL
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 12:11:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1ia0qD-0007bx-1e
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 12:11:02 -0500
Received: from indium.canonical.com ([91.189.90.7]:44868)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1ia0qC-0007ZU-Fy
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 12:11:00 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1ia0qA-0007yG-26
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 17:10:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 0C1072E804F
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 17:10:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 Nov 2019 17:03:16 -0000
From: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: arm linux-user
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: a-hashmi ajbennee carolineconcatto
X-Launchpad-Bug-Reporter: Caroline Concatto (carolineconcatto)
X-Launchpad-Bug-Modifier: =?utf-8?q?Alex_Benn=C3=A9e_=28ajbennee=29?=
References: <157468002661.30952.10642264809488923382.malonedeb@wampee.canonical.com>
Message-Id: <157487419668.23081.15300873960832030619.malone@chaenomeles.canonical.com>
Subject: [Bug 1853826] Re: ELF loader fails to load shared object on ThunderX2
 running RHEL7
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="c597c3229eb023b1e626162d5947141bf7befb13";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 70596c773f93c38b73a0b7692f99b424614f542e
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Reply-To: Bug 1853826 <1853826@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I've attempted to replicate but it works for me:

16:55:37 [alex@idun:~/l/t/hello-armpl] $ ~/lsrc/qemu.git/builds/all/aarch64=
-linux-user/qemu-aarch64 ./hello-armpl
Hello World...
16:55:52 [alex@idun:~/l/t/hello-armpl] $ ldd ./hello-armpl
        linux-vdso.so.1 (0x0000ffffb9e78000)
        libamath_generic.so =3D> /home/alex/lsrc/tests/hello-armpl/libamath=
_generic.so (0x0000ffffb9d1a000)
        libm.so.6 =3D> /lib64/libm.so.6 (0x0000ffffb9c50000)
        libastring_generic.so =3D> /home/alex/lsrc/tests/hello-armpl/libast=
ring_generic.so (0x0000ffffb9c2f000)
        libarmflang.so =3D> /home/alex/lsrc/tests/hello-armpl/libarmflang.s=
o (0x0000ffffb97b2000)
        libomp.so =3D> /home/alex/lsrc/tests/hello-armpl/libomp.so (0x0000f=
fffb96d4000)
        librt.so.1 =3D> /lib64/librt.so.1 (0x0000ffffb96bc000)
        libpthread.so.0 =3D> /lib64/libpthread.so.0 (0x0000ffffb968a000)
        libarmpl_lp64_generic.so =3D> /home/alex/lsrc/tests/hello-armpl/lib=
armpl_lp64_generic.so (0x0000ffffb0e12000)
        libc.so.6 =3D> /lib64/libc.so.6 (0x0000ffffb0c95000)
        /lib/ld-linux-aarch64.so.1 =3D> /lib64/ld-linux-aarch64.so.1 (0x000=
0ffffb9e4a000)
        libstdc++.so.6 =3D> /home/alex/lsrc/tests/hello-armpl/libstdc++.so.=
6 (0x0000ffffb0a9c000)
        libgcc_s.so.1 =3D> /home/alex/lsrc/tests/hello-armpl/libgcc_s.so.1 =
(0x0000ffffb0a6b000)
        libdl.so.2 =3D> /lib64/libdl.so.2 (0x0000ffffb0a57000)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1853826

Title:
  ELF loader fails to load shared object on ThunderX2 running RHEL7

Status in QEMU:
  New

Bug description:
  Simple test:
  hello.c

  include <stdio.h>

  int main(int argc, char* argv[])
  {
    {
      printf("Hello World... \n");
    }
    return 0;
  }

  when compiled with :
  *Compiler =

  https://developer.arm.com/tools-and-software/server-and-hpc/arm-architect=
ure-tools/arm-allinea-studio/download
  Arm-Compiler-for-HPC_19.3_RHEL_7_aarch64.tar	 =


  *Running:
  1) with -armpl
       armclang -armpl hello.c
       ./qemu/build/aarch64-linux-user/qemu-aarch64 a.out
  2) without flag
      armclang hello.c
       ./qemu/build/aarch64-linux-user/qemu-aarch64 a.out

  =E2=80=A2With Docker image:
         CentOS Linux release 7.7.1908 (AltArch)

  *Two different machines:
         AArch64, Taishan. tsv110, Kunpeng 920, ARMv8.2-A
         AArch64, Taishan 2280, Cortex-A72, ARMv8-A

  *QEMU 4.0
       qemu-aarch64 version 4.1.91 (v4.2.0-rc1)

  =

  Results:

  =

   ****Taishan 2280 Cortex-A72 =

        Running =

  1)with -armpl flag with and without the docker
            WORKS-> Hello World...
                 -> ldd a.out
  ldd a.out =

  linux-vdso.so.1 =3D>  (0x0000ffffbc6a2000) =

  libamath_generic.so =3D> /scratch/arm-linux-compiler-19.3_Generic-AArch64=
_RHEL-8_aarch64-linux/lib/clang/9.0.1/armpl_links/lib/libamath_generic.so (=
0x0000ffffbc544000) =

  libm.so.6 =3D> /lib64/libm.so.6 (0x0000ffffbc493000) =

  libastring_generic.so =3D> /scratch/arm-linux-compiler-19.3_Generic-AArch=
64_RHEL-8_aarch64-linux/lib/clang/9.0.1/armpl_links/lib/libastring_generic.=
so (0x0000ffffbc472000) libarmflang.so =3D> /scratch/arm-linux-compiler-19.=
3_Generic-AArch64_RHEL-8_aarch64-linux/lib/libarmflang.so (0x0000ffffbbfd30=
00) =

  libomp.so =3D> /scratch/arm-linux-compiler-19.3_Generic-AArch64_RHEL-8_aa=
rch64-linux/lib/libomp.so (0x0000ffffbbef5000) =

  librt.so.1 =3D> /lib64/librt.so.1 (0x0000ffffbbed4000) =

  libpthread.so.0 =3D> /lib64/libpthread.so.0 (0x0000ffffbbe9f000) =

  libarmpl_lp64_generic.so =3D> /scratch/arm-linux-compiler-19.3_Generic-AA=
rch64_RHEL-8_aarch64-linux/lib/clang/9.0.1/armpl_links/lib/libarmpl_lp64_ge=
neric.so (0x0000ffffb3306000) =

  libc.so.6 =3D> /lib64/libc.so.6 (0x0000ffffb3180000) =

  libstdc++.so.6 =3D> /scratch/gcc-9.2.0_Generic-AArch64_RHEL-8_aarch64-lin=
ux/lib64/libstdc++.so.6 (0x0000ffffb2f30000) =

  libgcc_s.so.1 =3D> /scratch/gcc-9.2.0_Generic-AArch64_RHEL-8_aarch64-linu=
x/lib64/libgcc_s.so.1 (0x0000ffffb2eff000) =

  libdl.so.2 =3D> /lib64/libdl.so.2 (0x0000ffffb2ede000) =

  /lib/ld-linux-aarch64.so.1 (0x0000ffffbc674000)
             =


  Running =

  2) without -armpl flag with and without the docker
             WORKS -> Hello World...        =

                   -> ldd a.out
  ldd a.out
   linux-vdso.so.1 =3D>  (0x0000ffffa6895000) =

  libastring_generic.so =3D> /scratch/arm-linux-compiler-19.3_Generic-AArch=
64_RHEL-8_aarch64-linux/lib/clang/9.0.1/armpl_links/lib/libastring_generic.=
so (0x0000ffffa6846000) =

  libc.so.6 =3D> /lib64/libc.so.6 (0x0000ffffa66c0000) =

  /lib/ld-linux-aarch64.so.1 (0x0000ffffa6867000)
      =


  ****Taishan - tsv110  Kunpeng 920
         For Running =


  1)with -armpl flag with and without the docker
             DOES NOT WORK -> with and without Docker
                           -> It shows : qemu:handle_cpu_signal received si=
gnal outside vCPU
   context @ pc=3D0xffffaaa8844a
                           -> ldd a.out =

  ldd a.out =

  linux-vdso.so.1 =3D>  (0x0000ffffad4b0000)
  libamath_generic.so =3D> /scratch/arm-linux-compiler-19.3_Generic-AArch64=
_RHEL-8_aarch64-linux/lib/clang/9.0.1/armpl_links/lib/libamath_generic.so (=
0x0000ffffad370000) =

  libm.so.6 =3D> /lib64/libm.so.6 (0x0000ffffad2a0000) =

  libastring_generic.so =3D> /scratch/arm-linux-compiler-19.3_Generic-AArch=
64_RHEL-8_aarch64-linux/lib/clang/9.0.1/armpl_links/lib/libastring_generic.=
so (0x0000ffffad270000) libarmflang.so =3D> /scratch/arm-linux-compiler-19.=
3_Generic-AArch64_RHEL-8_aarch64-linux/lib/libarmflang.so (0x0000ffffacdd00=
00) =

  libomp.so =3D> /scratch/arm-linux-compiler-19.3_Generic-AArch64_RHEL-8_aa=
rch64-linux/lib/libomp.so (0x0000ffffaccf0000) =

  librt.so.1 =3D> /lib64/librt.so.1 (0x0000ffffaccc0000) =

  libpthread.so.0 =3D> /lib64/libpthread.so.0 (0x0000ffffacc80000) =

  libarmpl_lp64_generic.so =3D> /scratch/arm-linux-compiler-19.3_Generic-AA=
rch64_RHEL-8_aarch64-linux/lib/clang/9.0.1/armpl_links/lib/libarmpl_lp64_ge=
neric.so (0x0000ffffa40e0000) =

  libc.so.6 =3D> /lib64/libc.so.6 (0x0000ffffa3f50000) =

  libstdc++.so.6 =3D> /scratch/gcc-9.2.0_Generic-AArch64_RHEL-8_aarch64-lin=
ux/lib64/libstdc++.so.6 (0x0000ffffa3d00000) =

  libgcc_s.so.1 =3D> /scratch/gcc-9.2.0_Generic-AArch64_RHEL-8_aarch64-linu=
x/lib64/libgcc_s.so.1 (0x0000ffffa3cc0000)
  libdl.so.2 =3D> /lib64/libdl.so.2 (0x0000ffffa3c90000) =

  /lib/ld-linux-aarch64.so.1 (0x0000ffffad4c0000)
              =


  Running =

  2) without -armpl flag with and without the docker
                 WORKS -> Hello World..
                       -> ldd a.out
  ldd a.out  =

  linux-vdso.so.1 =3D>  (0x0000ffff880c0000) =

  libastring_generic.so =3D> /scratch/arm-linux-compiler-19.3_Generic-AArch=
64_RHEL-8_aarch64-linux/lib/clang/9.0.1/armpl_links/lib/libastring_generic.=
so (0x0000ffff88080000) =

  libc.so.6 =3D> /lib64/libc.so.6 (0x0000ffff87ee0000)
  /lib/ld-linux-aarch64.so.1 (0x0000ffff880d0000)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1853826/+subscriptions

