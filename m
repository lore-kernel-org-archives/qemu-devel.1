Return-Path: <SRS0=dICq=5N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE75C43331
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 12:31:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB20320716
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 12:31:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB20320716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIAco-0001sh-VQ
	for qemu-devel@archiver.kernel.org; Sat, 28 Mar 2020 08:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50168)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jIAbt-0001GZ-7m
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 08:30:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jIAbr-0007oJ-WF
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 08:30:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:49540)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jIAbr-0007nf-Qr
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 08:30:43 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jIAbq-0008SR-Dn
 for <qemu-devel@nongnu.org>; Sat, 28 Mar 2020 12:30:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 633952E80C8
 for <qemu-devel@nongnu.org>; Sat, 28 Mar 2020 12:30:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Mar 2020 12:23:12 -0000
From: =?utf-8?q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <1821515@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: archimedesmp trofi
X-Launchpad-Bug-Reporter: Sergei Trofimovich (trofi)
X-Launchpad-Bug-Modifier: =?utf-8?q?Carlo_Marcelo_Arenas_Bel=C3=B3n_=28care?=
 =?utf-8?q?nasgm=29?=
X-Launchpad-Bug-Duplicate: 1821444
References: <155342942845.31965.16406839542937078170.malonedeb@soybean.canonical.com>
Message-Id: <158539819272.11416.2911868336573471662.launchpad@chaenomeles.canonical.com>
Subject: [Bug 1821515] Re: qemu-ppc (user) incorrectly converts
 float(nan)->double(non-nan)
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a296f04231dee355be5db73cc878b9e21689a253";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 83f1d8cf802957e009d327cbcdb457b6cab74756
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
Reply-To: Bug 1821515 <1821515@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

*** This bug is a duplicate of bug 1821444 ***
    https://bugs.launchpad.net/bugs/1821444

** This bug has been marked a duplicate of bug 1821444
   qemu-ppc (user) incorrectly translates float32 arithmetics

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

