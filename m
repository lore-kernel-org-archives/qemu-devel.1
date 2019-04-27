Return-Path: <SRS0=rME2=S5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C9DC43219
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2019 01:16:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED7C7206E0
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2019 01:16:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED7C7206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54019 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKBxV-0005pH-3Z
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 21:16:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hKBwQ-0005G7-6O
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 21:15:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hKBwO-0002IX-Df
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 21:15:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:44958)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hKBwO-0002HY-8R
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 21:15:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hKBwM-0001qM-B1
	for <qemu-devel@nongnu.org>; Sat, 27 Apr 2019 01:15:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 522292E806F
	for <qemu-devel@nongnu.org>; Sat, 27 Apr 2019 01:15:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Apr 2019 01:04:17 -0000
From: Richard Henderson <rth@twiddle.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=In Progress; importance=Undecided;
	assignee=rth@twiddle.net; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: bruno-clisp rth stefanrin th-huth
X-Launchpad-Bug-Reporter: Bruno Haible (bruno-clisp)
X-Launchpad-Bug-Modifier: Richard Henderson (rth)
References: <149893001258.15852.11258418521313176097.malonedeb@wampee.canonical.com>
Message-Id:
 <155632705735.7089.11723781753272346192.malone@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18928";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: adddab94177a4635d4fca31bf1b88fe667b829d9
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1701835] Re: floating-point operation bugs in
 qemu-alpha
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1701835 <1701835@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190427010417.0dfAemIf3jEvWdp93Z-4-pQNq-Cm9RIPmG-YmX32qwQ@z>

There is quite a bit missing for proper user-level emulation.
Please try

https://patchwork.ozlabs.org/patch/1091847/

** Changed in: qemu
     Assignee: (unassigned) =3D> Richard Henderson (rth)

** Changed in: qemu
       Status: New =3D> In Progress

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1701835

Title:
  floating-point operation bugs in qemu-alpha

Status in QEMU:
  In Progress

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

