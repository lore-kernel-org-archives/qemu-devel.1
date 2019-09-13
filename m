Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10745C4CEC8
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:02:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB63220830
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:02:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB63220830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8n5t-0000KD-Rg
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 11:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50175)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1i8n4S-00089D-37
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:01:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1i8n4Q-0005pK-LQ
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:01:11 -0400
Received: from indium.canonical.com ([91.189.90.7]:42926)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1i8n4O-0005nw-M9
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:01:09 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1i8n4I-00044J-FF
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 15:01:03 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 6B6942E8079
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 15:01:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Sep 2019 14:50:37 -0000
From: Paul Clarke <pc@us.ibm.com>
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
X-Launchpad-Bug-Modifier: Paul Clarke (7-pc)
References: <156691209320.18814.746226319480624520.malonedeb@soybean.canonical.com>
 <20190913134935.29696-1-alex.bennee@linaro.org>
Message-Id: <70173025-eef0-ff89-3c8f-517397ca42f3@us.ibm.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19048";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: d0be6f86d32bb85309eceb43e4ce71118f6dafc1
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
Message-ID: <20190913145037.Ig5WDwC8utZbQmCzMLY70FbVeSc0GqeaGKO_XgXVPaE@z>

On 9/13/19 8:49 AM, Alex Benn=C3=A9e wrote:
> +static float f32_numbers[] =3D {
> +    -SNANF,
> +    -NAN,
> +    -INFINITY,
> +    -FLT_MAX,
> +    -1.111E+31,
> +    -1.111E+30,
> +    -1.08700982e-12,
> +    -1.78051176e-20,
> +    -FLT_MIN,
> +    0.0,
> +    FLT_MIN,
> +    2.98023224e-08,
> +    5.96046E-8, /* min positive FP16 subnormal */
> +    6.09756E-5, /* max subnormal FP16 */
> +    6.10352E-5, /* min positive normal FP16 */
> +    1.0,
> +    1.0009765625, /* smallest float after 1.0 FP16 */
> +    2.0,
> +    M_E, M_PI,
> +    65503.0,
> +    65504.0, /* max FP16 */
> +    65505.0,
> +    131007.0,
> +    131008.0, /* max AFP */
> +    131009.0,
> +    1.111E+30,
> +    FLT_MAX,
> +    INFINITY,
> +    NAN,
> +    SNANF
> +};

I've noticed that Glibc prefers to use hex representation for float values,=
 to ensure an accurate representation.  If you care to do so, here they are:
static float f32_numbers[] =3D {
    -SNANF, =

    -NAN,   =

    -INFINITY,
    -FLT_MAX,
    -0x1.1874b2p+103,
    -0x1.c0bab6p+99,
    -0x1.31f75p-40,
    -0x1.505444p-66,
    -FLT_MIN,
    0.0,    =

    FLT_MIN,
    0x1p-25,
    0x1.ffffe6p-25, /* min positive FP16 subnormal */
    0x1.ff801ap-15, /* max subnormal FP16 */
    0x1.00000cp-14, /* min positive normal FP16 */
    1.0,    =

    0x1.004p+0, /* smallest float after 1.0 FP16 */
    2.0,    =

    M_E, M_PI,
    0x1.ffbep+15,
    0x1.ffcp+15, /* max FP16 */
    0x1.ffc2p+15,
    0x1.ffbfp+16,
    0x1.ffcp+16, /* max AFP */
    0x1.ffc1p+16,
    0x1.c0bab6p+99,
    FLT_MAX,
    INFINITY,
    NAN,    =

    SNANF   =

};

PC

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

