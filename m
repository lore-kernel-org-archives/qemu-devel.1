Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8401C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 13:34:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A88E020661
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 13:34:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A88E020661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipXxf-00062R-Mw
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 08:34:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36790)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1ipXte-0001DE-R6
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:30:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1ipXta-0000aV-A0
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:30:46 -0500
Received: from indium.canonical.com ([91.189.90.7]:33068)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1ipXtZ-0000Ye-Ka
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:30:41 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1ipXtY-0000Wv-At
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 13:30:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 437332E80C0
 for <qemu-devel@nongnu.org>; Thu,  9 Jan 2020 13:30:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jan 2020 13:23:06 -0000
From: Thomas Huth <1815423@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: javascript js softfp
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: dibalavs pmaydell
X-Launchpad-Bug-Reporter: Vasily Dybala (dibalavs)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <154987502048.21937.8846396923018937713.malonedeb@chaenomeles.canonical.com>
Message-Id: <157857618727.3160.16103783506639525037.launchpad@soybean.canonical.com>
Subject: [Bug 1815423] Re: x86_64 TCG: Incorrect floating point cast to int.
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="bceb5ef013b87ef7aafe0755545ceb689ca7ac60";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 8fb964636e1e4b93700e88687d337ebaee838f63
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
Reply-To: Bug 1815423 <1815423@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1815423

Title:
  x86_64 TCG: Incorrect floating point cast to int.

Status in QEMU:
  Fix Released

Bug description:
  I used exaample from:
  https://stackoverflow.com/questions/3986795/what-is-the-result-of-casting=
-float-inf-inf-and-nan-to-integer-in-c

  #include <stdio.h>
  #include <math.h>

  int main(int argc, char** argv) {
    float a =3D INFINITY;
    float b =3D -INFINITY;
    float c =3D NAN;

    printf("float %f %f %f\n", a, b, c); =

    printf("int %d %d %d\n", (int) a, (int) b, (int) c); =

    printf("uint %u %u %u\n", (unsigned int) a, (unsigned int) b, (unsigned=
 int) c); =

    printf("lint %ld %ld %ld\n", (long int) a, (long int) b, (long int) b); =

    printf("luint %lu %lu %lu\n", (unsigned long int) a, (unsigned long int=
) b, (unsigned long int) c); =


    return 0;
  }

  And got different results on real computer and on qemu.

  output from real HW is the same as on stackoverflow:

  $ gcc test.c && ./a.out =

  float inf -inf nan
  int -2147483648 -2147483648 -2147483648
  uint 0 0 0
  lint -9223372036854775808 -9223372036854775808 -9223372036854775808
  luint 0 9223372036854775808 9223372036854775808

  =

  But on qemu I got another results:

  float inf -inf nan
  int 2147483647 -2147483648 2147483647
  uint 4294967295 0 4294967295
  lint 9223372036854775807 -9223372036854775808 -9223372036854775808
  luint 18446744073709551615 9223372036854775808 9223372036854775807

  qemu launch string:
  /qemu-system-x86_64 -m 1024 -cpu core2duo -serial stdio -netdev user,id=
=3Dnetwork0 -device e1000,netdev=3Dnetwork0 -kernel my_kernel

  =

  qemu version:
  x86_64-softmmu/qemu-system-x86_64 --version
  QEMU emulator version 3.1.50 (v3.1.0-1676-ge47f81b617-dirty)
  Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers

  =

  This bug affect some javascript (surprise) calculations:

  var conversion =3D "01234567890";
  var x;
  var result =3D conversion[x & 42];
  console.log(result)

  =

  In example, var x is "undefined"
  and when do calculation "x & 42" on js we should get 0 (it is documented =
feature), but actually got "42"

  and "result" sould be "0" but actually we got "undefined"

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1815423/+subscriptions

