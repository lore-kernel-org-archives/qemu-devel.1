Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408ACC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 16:02:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15DB8206B6
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 16:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15DB8206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBLMI-0003tW-Az
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 12:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45404)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iBKwo-0006QC-VI
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:35:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iBKwn-0006zB-HU
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:35:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:45990)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iBKwn-0006yn-Ba
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:35:49 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iBKwk-0006Kk-Rd
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 15:35:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 113142E80DD
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 15:35:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Sep 2019 15:23:02 -0000
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Committed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: javascript js softfp
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: dibalavs pmaydell
X-Launchpad-Bug-Reporter: Vasily Dybala (dibalavs)
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
References: <154987502048.21937.8846396923018937713.malonedeb@chaenomeles.canonical.com>
Message-Id: <156899298280.5220.6596651952841122573.malone@chaenomeles.canonical.com>
Subject: [Bug 1815423] Re: x86_64 TCG: Incorrect floating point cast to int.
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19048";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 21b8542e248c74573e2242d13ab55048c9f362b9
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
Reply-To: Bug 1815423 <1815423@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This should be fixed by commit 1e8a98b53867f61da9, which will be in the
4.2 release.


** Changed in: qemu
       Status: In Progress =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1815423

Title:
  x86_64 TCG: Incorrect floating point cast to int.

Status in QEMU:
  Fix Committed

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

