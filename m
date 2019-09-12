Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F30EC4CEC7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 19:36:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 048C82084D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 19:36:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 048C82084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8UtY-0001IE-2B
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 15:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41030)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1i8UsW-0000Oe-Pl
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 15:35:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1i8UsV-000495-8b
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 15:35:40 -0400
Received: from indium.canonical.com ([91.189.90.7]:49664)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1i8UsV-00048F-3i
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 15:35:39 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1i8UsT-0004jc-0n
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 19:35:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 049312E80CD
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 19:35:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Sep 2019 19:27:40 -0000
From: Richard Henderson <rth@twiddle.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: ppc64 testcase
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: 7-pc ajbennee rth
X-Launchpad-Bug-Reporter: Paul Clarke (7-pc)
X-Launchpad-Bug-Modifier: Richard Henderson (rth)
References: <156691209320.18814.746226319480624520.malonedeb@soybean.canonical.com>
Message-Id: <156831646095.1120.12247489491937744903.malone@wampee.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19044";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 8b789267a449a18d77ddb2e03eb1634b6e24bb3e
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1841592] Re: ppc: softfloat float implementation
 issues
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

It should be a fused multiply add; you may need to use -ffast-math or
something to get the compiler to generate the proper instruction.

However, one can see from target/ppc/translate/fp-impl.inc.c:

/* fmadd - fmadds */
GEN_FLOAT_ACB(madd, 0x1D, 1, PPC_FLOAT);

through to _GEN_FLOAT_ACB:

    gen_helper_f##op(t3, cpu_env, t0, t1, t2);         \
    if (isfloat) {                                     \
        gen_helper_frsp(t3, cpu_env, t3);              \
    }                                                  \

That right there is a double-precision fma followed by a round
to single precision.  This pattern is replicated for all single
precision operations, and is of course wrong.

I believe that correct results may be obtained by having
single-precision helpers that first convert the double-precision
input into a single-precision input using helper_tosingle(),
perform the required operation, then convert the result back to
double-precision using helper_todouble().

The manual says:

# For single-precision arithmetic instructions, all input values
# must be representable in single format; if they are not, the
# result placed into the target FPR, and the setting of
# status bits in the FPSCR and in the Condition Register
# (if Rc=3D1), are undefined.

The tosingle/todouble conversions are exact and bit-preserving.
They are used by load-single and store-single that convert a
single-precision in-memory value to the double-precision register
value.  Therefore the input given to float32_add using this
conversion would be exactly the same as if we had given the
value unmollested from a memory input.

I don't know what real ppc hw does -- whether it takes all of
the double-precision input bits and rounds to 23-bits, like the
old 80387 hardware does, or truncates the input as I propose.
But for architectural results we don't have to care, because
of the UNDEFINED escape clause.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1841592

Title:
  ppc: softfloat float implementation issues

Status in QEMU:
  New

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

