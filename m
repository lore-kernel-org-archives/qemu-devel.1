Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43153C74A35
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 14:52:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A52921537
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 14:52:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A52921537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlaQv-00067d-5C
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 10:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40790)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hlaPX-00059A-8n
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 10:51:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hlaPW-0004DR-0g
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 10:51:03 -0400
Received: from indium.canonical.com ([91.189.90.7]:46608)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hlaPV-00049x-Q2
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 10:51:01 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hlaPR-0006CD-Q5
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 14:50:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id ECFCF2E8191
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 14:50:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jul 2019 14:38:58 -0000
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=In Progress; importance=Undecided;
 assignee=alex.bennee@linaro.org; 
X-Launchpad-Bug-Tags: arm testcase
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ajbennee christophe-lyon pmaydell
X-Launchpad-Bug-Reporter: Christophe Lyon (christophe-lyon)
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
References: <156277131341.2267.3199507288563083183.malonedeb@wampee.canonical.com>
 <20190711103737.10017-1-alex.bennee@linaro.org>
Message-Id:
 <CAFEAcA-mJ5qcA-iS8BxfoVVMkAt13k11bYOT_eELw-WzcSEvRQ@mail.gmail.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19007";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 01297fc4c0e7740d9ead60de51307ae0773a0b01
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1836078] Re: [PATCH v2 for 4.1] target/arm:
 report ARMv8-A FP support for AArch32 -cpu max
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
Reply-To: Bug 1836078 <1836078@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190711143858.FDCrCB8jyN-mDm8sWMcOr8l4hDmQAjBb7owLv7z_A8U@z>

On Thu, 11 Jul 2019 at 11:37, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> When we converted to using feature bits in 602f6e42cfbf we missed out
> the fact (dp && arm_dc_feature(s, ARM_FEATURE_V8)) was supported for
> -cpu max configurations. This caused a regression in the GCC test
> suite. Fix this by setting the appropriate bits in mvfr1.FPHP to
> report ARMv8-A with FP support (but not ARMv8.2-FP16).
>
> Fixes: https://bugs.launchpad.net/qemu/+bug/1836078
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index e75a64a25a..ad164a773b 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -2452,6 +2452,10 @@ static void arm_max_initfn(Object *obj)
>              t =3D FIELD_DP32(t, ID_ISAR6, SPECRES, 1);
>              cpu->isar.id_isar6 =3D t;
>
> +            t =3D cpu->isar.mvfr1;
> +            t =3D FIELD_DP32(t, MVFR1, FPHP, 2);     /* v8.0 FP support =
*/
> +            cpu->isar.mvfr1 =3D t;
> +
>              t =3D cpu->isar.mvfr2;
>              t =3D FIELD_DP32(t, MVFR2, SIMDMISC, 3); /* SIMD MaxNum */
>              t =3D FIELD_DP32(t, MVFR2, FPMISC, 4);   /* FP MaxNum */
> --
> 2.20.1


Applied to target-arm.next, thanks.

-- PMM

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1836078

Title:
  Regressions on arm-linux-gnueabihf target with some GCC tests

Status in QEMU:
  In Progress

Bug description:
  Hi,

  After trying qemu master:
  commit 474f3938d79ab36b9231c9ad3b5a9314c2aeacde
  Merge: 68d7ff0 14f5d87
  Author: Peter Maydell <email address hidden>
  Date: Fri Jun 21 15:40:50 2019 +0100

  even with the fix for https://bugs.launchpad.net/qemu/+bug/1834496,
  I've noticed several regressions compared to qemu-3.1 when running the GC=
C testsuite.
  I'm attaching a tarball containing several GCC tests (binaries), needed s=
hared libs, and a short script to run all the tests.

  All tests used to pass w/o error, but with a recent qemu, all of them
  make qemu crash.

  This was noticed with GCC master configured with
  --target arm-none-linux-gnueabihf
  --with-cpu cortex-a57
  --with-fpu crypto-neon-fp-armv8

  Thanks

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1836078/+subscriptions

