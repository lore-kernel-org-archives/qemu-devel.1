Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C37C4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 08:42:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 537A6217D4
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 08:42:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 537A6217D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38183 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCKQj-0003pq-00
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 04:42:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hCKPs-0003YQ-AF
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 04:41:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hCKPr-0004rj-1T
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 04:41:40 -0400
Received: from indium.canonical.com ([91.189.90.7]:35072)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hCKPq-0004mv-Iu
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 04:41:38 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hCKPn-0001dH-TZ
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 08:41:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8A0812E80D0
	for <qemu-devel@nongnu.org>; Fri,  5 Apr 2019 08:41:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Apr 2019 08:26:31 -0000
From: Sebastian <1821515@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: archimedesmp trofi
X-Launchpad-Bug-Reporter: Sergei Trofimovich (trofi)
X-Launchpad-Bug-Modifier: Sebastian (archimedesmp)
References: <155342942845.31965.16406839542937078170.malonedeb@soybean.canonical.com>
Message-Id:
 <155445279162.20317.6876364032547268934.malone@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18920";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 7c270aa22004152843c7b3290adfd5924f8e8c17
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1821515] Re: qemu-ppc (user) incorrectly converts
 float(nan)->double(non-nan)
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
Reply-To: Bug 1821515 <1821515@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405082631.jN6jDzH8fEQznZoldmSod0mkDjbXj9Q7BHYsnTsuyIk@z>

We also hit this regression when testing CompCert for e5500 with qemu
3.1.0.

The minimal example
> #include <stdio.h>
> #include <math.h>
>  =

> union C { float f; unsigned long l; };
> int main (void) {
>     union C c;
>     c.f =3D NAN;
>     printf("Float: %f\n  Hex: 0x%x\n", c.f, c.l);
>     printf("The above float is %s NAN\n", c.f =3D=3D NAN ? "=3D=3D" : "!=
=3D");                                                      =

>     return 0;
> }

does not exhibit the error with GCC 6.3.0, since that statically
optimizes the c.f =3D=3D NAN to always be false. But CompCert doesn't do
this optimization and thus triggers the regression in the float compare.

With qemu 3.0.0 the example outputs (whether built with compcert or gcc):
> Float: nan
>   Hex: 0x7fc00000
> The above float is !=3D NAN

The example works well with qemu 3.0.0 and we stumbled over this with
qemu 3.1.0; both build from the released source tarballs. My native
system is a x86_64 GNU/Linux (openSUSE Tumbleweed with Kernel
4.20.13-1-default).

Output with qemu 3.1.0 and built with GCC:
> $ ./qemu-ppc64abi32-3.1.0 bug25310.gcc.elf =

> Float: 510423550381407695195061911147652317184.000000
>   Hex: 0x7fc00000
> The above float is !=3D NAN

qemu 3.1.0 and example built with CompCert:
> $ ./qemu-ppc64abi32-3.1.0 bug25310.ccomp.elf =

> Float: 510423550381407695195061911147652317184.000000
>   Hex: 0x7fc00000
> The above float is =3D=3D NAN

I attached example binaries (statically built):
> $ ../../compcert_internal_ppc/bin/ccomp --version
> The CompCert C verified compiler, Release: 18.10i, Build: 4503984, Tag: a=
uto/2019/02/11/1924
> $ ../../compcert_internal_ppc/bin/ccomp -target e5500-linux -g -static bu=
g25310.c -o bug25310.ccomp.elf =

> =

> $ ../../compcert_internal_ppc/gcc/bin/powerpc-unknown-linux-gnu-gcc --ver=
sion
> powerpc-unknown-linux-gnu-gcc (crosstool-NG crosstool-ng-1.23.0) 6.3.0
> $ ../../compcert_internal_ppc/gcc/bin/powerpc-unknown-linux-gnu-gcc bug25=
310.c -g -static -O0 -o bug25310.gcc.elf -mcpu=3De5500

** Attachment added: "Examples built with gcc and compcert"
   https://bugs.launchpad.net/qemu/+bug/1821515/+attachment/5253003/+files/=
qemu-1821515.tar.xz

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1821515

Title:
  qemu-ppc (user) incorrectly converts float(nan)->double(non-nan)

Status in QEMU:
  New

Bug description:
  Noticed on qemu-3.1.0 on GHC test suite where float32 comparisons didn't =
work on NaNs.
  Here is the minimal reproducer:

  ```c
  // cat a.c
  #include <stdio.h>
  #include <math.h>
  #include <stdint.h>

  int main() {
      volatile float f1 =3D NAN;
      volatile float f2 =3D NAN;
      printf ("f1 (%e, %#x) >=3D f2 (%e, %#x): %s\n",
          f1, *(volatile uint32_t*)&f1,
          f2, *(volatile uint32_t*)&f2,
          (f1 >=3D f2) ? "True"
                     : "False");
      volatile double d =3D f1;
      printf ("d (%e, %#llx)\n",
          d, *(volatile uint64_t*)&d);
  }
  ```

  ```
  # incorrect execution:
  $ powerpc-unknown-linux-gnu-gcc -O2 a.c -o a -static && qemu-ppc ./a =

  f1 (5.104236e+38, 0x7fc00000) >=3D f2 (5.104236e+38, 0x7fc00000): True
  d (5.104236e+38, 0x47f8000000000000)

  # correct execution
  $ scp a timberdoodle.ppc64.dev.gentoo.org:~/;  ssh timberdoodle.ppc64.dev=
.gentoo.org ./a
  f1 (nan, 0x7fc00000) >=3D f2 (nan, 0x7fc00000): False
  d (nan, 0x7ff8000000000000)
  ```

  Note: qemu-ppc handled float32 extension as it was not a NaN
  (exp=3D111..1111) but a normalized number.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1821515/+subscriptions

