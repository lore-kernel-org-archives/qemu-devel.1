Return-Path: <SRS0=fVwN=XJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDFEC4CEC7
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 18:11:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B554A20640
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 18:11:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B554A20640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9CWK-0007bZ-OK
	for qemu-devel@archiver.kernel.org; Sat, 14 Sep 2019 14:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48755)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1i9CVZ-0007AD-Jx
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 14:10:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1i9CVY-0003MA-FP
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 14:10:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:47880)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1i9CVY-0003Kf-AH
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 14:10:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1i9CVW-0002Wx-77
 for <qemu-devel@nongnu.org>; Sat, 14 Sep 2019 18:10:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 33F7E2E8060
 for <qemu-devel@nongnu.org>; Sat, 14 Sep 2019 18:10:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Sep 2019 17:59:24 -0000
From: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: ppc64 testcase
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: 7-pc ajbennee rth
X-Launchpad-Bug-Reporter: Paul Clarke (7-pc)
X-Launchpad-Bug-Modifier: =?utf-8?q?Alex_Benn=C3=A9e_=28ajbennee=29?=
References: <156691209320.18814.746226319480624520.malonedeb@soybean.canonical.com>
Message-Id: <87v9tuahdv.fsf@linaro.org>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19048";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 1afdda403246010467f5ccc4c6f2abb0b5839647
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1841592] Re: [PATCH] tests/tcg: add float_madds
 test to multiarch
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
Reply-To: Bug 1841592 <1841592@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190914175924.R3MKKGNgxi678cOZ0hzzXqLG1Fl6T0annGQh5U1TxGc@z>

Richard Henderson <richard.henderson@linaro.org> writes:

> On 9/13/19 9:49 AM, Alex Benn=C3=A9e wrote:
>> +                    /* must be built with -O2 to generate fused op */
>> +                    r =3D a * b + c;
>
> I would prefer to use fmaf() or __builtin_fmaf() here.
>
> Although you'll need to link with -lm just in case the
> target doesn't support an instruction for fmaf and so
> the builtin expands to the standard library call.

I can do that - we have other tests that link to libm.

I was expecting to see more breakage but the ppc64 tests all passed (or
at least against the power8 David ran it on). What am I missing to hit
the cases you know are broken?

I've also experimented with reducing the number of iterations because if
we want to have golden references we probably don't want to dump several
hundred kilobytes of "golden" references into the source tree.

> I also like Paul's suggestion to use hex float constants.

Hmm I guess - look a bit weird but I guess that's lack of familiarity.
Is is still normalised? I guess the frac shows up (without the implicit
bit).

>
>
> r~


--
Alex Benn=C3=A9e

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1841592

Title:
  ppc: softfloat float implementation issues

Status in QEMU:
  Incomplete

Bug description:
  Per bug #1841491, Richard Henderson (rth) said:
  > The float test failure is part of a larger problem for target/powerpc
  > in which all float routines are implemented incorrectly. They are all
  > implemented as double operations with rounding to float as a second
  > step. Which not only produces incorrect exceptions, as in this case,
  > but incorrect numerical results from the double rounding.
  >
  > This should probably be split to a separate bug...

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1841592/+subscriptions

