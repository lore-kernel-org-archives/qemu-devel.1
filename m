Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739A4C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 05:05:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 492112089E
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 05:05:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 492112089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyUQC-0008FC-Dm
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 01:05:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47883)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1hyUMI-0004uz-EX
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 01:01:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hyUMG-0001RI-O3
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 01:01:02 -0400
Received: from indium.canonical.com ([91.189.90.7]:51898)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hyUMG-0001QH-Gq
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 01:01:00 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hyUMD-0003BI-Rd
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 05:00:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id C23252E80DA
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 05:00:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Aug 2019 04:52:32 -0000
From: Thomas Huth <1701835@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=rth@twiddle.net; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: bruno-clisp rth stefanrin th-huth
X-Launchpad-Bug-Reporter: Bruno Haible (bruno-clisp)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <149893001258.15852.11258418521313176097.malonedeb@wampee.canonical.com>
Message-Id: <156593115302.26718.10972532832747241735.malone@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19022";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 93ba7009b09a7f4000ec1c7be1daea22db57b5be
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1701835] Re: floating-point operation bugs in
 qemu-alpha
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
Reply-To: Bug 1701835 <1701835@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D21ba856499f9c0ccdc

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1701835

Title:
  floating-point operation bugs in qemu-alpha

Status in QEMU:
  Fix Released

Bug description:
  When running the gnulib testsuite, I'm seeing test failures in the tests =
for libm functions
    cbrt
    cbrtf
    ceil
    ceilf
    coshf
    exp2
    exp2f
    floor
    floorf
    fma
    fmaf
    fmal
    frexp
    frexpf
    hypot
    hypotf
    hypotl
    ilogb
    ilogbf
    isfinite
    isinf
    isnan
    isnand
    isnanf
    ldexp
    ldexpf
    ldexpl
    log1p
    log1pf
    log2
    log2f
    logb
    logbf
    logbl
    rint
    rintf
    rintl
    signbit
    sqrt
    sqrtf
    strtod
  that I don't see when running the same (statically linked) executables in=
 a VM, through qemu-system-alpha.

  How to reproduce:
  - Using gnulib, run ./gnulib-tool --create-testdir --dir=3D../testdir-mat=
h --single-configure cbrt cbrtf ceil ceilf coshf exp2 exp2f float floor flo=
orf fma fmaf fmal frexp frexpf hypot hypotf hypotl ilogb ilogbf isfinite is=
inf isnan isnand isnanf ldexp ldexpf ldexpl log1p log1pf log2 log2f logb lo=
gbf logbl math printf-frexp rint rintf rintl round roundf signbit sqrt sqrt=
f strtod trunc truncf
  - Copy the resulting directory to a VM running Linux 2.6.26 with qemu-sys=
tem-alpha.
  - There, configure and build the package:
    mkdir build-native-static; cd build-native-static; ../configure CPPFLAG=
S=3D"-Wall" LDFLAGS=3D"-static"; make; make check
    Only 4 tests fail.
  - Copy the resulting binaries back to the original x86_64 machine.
  - Set environment variables for using qemu-alpha.
  - Here, 50 tests fail that did not fail originally:

  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-cbrt
  ../../gltests/test-cbrt.h:39: assertion 'err > - L_(4.0) * L_(16.0) / TWO=
_MANT_DIG && err < L_(4.0) * L_(16.0) / TWO_MANT_DIG' failed
  Aborted (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-ceil1
  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-ceil2
  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-ceilf1
  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-ceilf2
  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-coshf =

  ../../gltests/test-coshf.c:37: assertion 'y >=3D 1.1854652f && y <=3D 1.1=
854653f' failed
  Aborted (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-float
  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-floor1
  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-floor2
  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-floorf1
  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-floorf2
  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-fma1   =

  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-fma2
  ../../gltests/test-fma2.h:116: assertion 'result =3D=3D expected' failed
  Aborted (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-fmaf1
  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-fmaf2
  ../../gltests/test-fma2.h:116: assertion 'result =3D=3D expected' failed
  Aborted (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-fmal2
  ../../gltests/test-fma2.h:116: assertion 'result =3D=3D expected' failed
  Aborted (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-frexp
  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-frexpf
  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-hypot =

  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-hypotf
  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-hypotl
  ../../gltests/test-hypot.h:41: assertion 'z =3D=3D HUGEVAL' failed
  Aborted (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-ilogb =

  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-ilogbf
  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-isfinite
  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-isinf   =

  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-isnan
  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-isnand-nolibm
  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-isnand       =

  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-isnanf-nolibm
  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-isnanf       =

  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-ldexp =

  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-ldexpf
  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-ldexpl
  ../../gltests/test-ldexp.h:99: assertion 'y =3D=3D expected' failed
  Aborted (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-log1p =

  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-log1pf
  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-log2  =

  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-log2f
  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-logb =

  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-logbf
  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-math =

  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-printf-frexp
  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-rint        =

  ../../gltests/test-rint.c:63: assertion 'rint (0.7) =3D=3D 1.0' failed
  Aborted (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-rintf
  ../../gltests/test-rintf.c:63: assertion 'rintf (0.7f) =3D=3D 1.0f' failed
  Aborted (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-rintl
  ../../gltests/test-rintl.c:68: assertion 'rintl (0.7L) =3D=3D 1.0L' failed
  Aborted (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-round1
  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-roundf1
  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-signbit
  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-sqrt   =

  ../../gltests/test-sqrt.h:40: assertion 'err > - L_(16.0) / TWO_MANT_DIG =
&& err < L_(16.0) / TWO_MANT_DIG' failed
  Aborted (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-trunc1
  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-truncf1
  Floating point exception (core dumped)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1701835/+subscriptions

