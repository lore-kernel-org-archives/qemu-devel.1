Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F79AC04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 13:56:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F11E2054F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 13:56:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F11E2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCOpc-0003qx-De
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 09:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33700)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iCOos-0003Pa-4B
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 09:56:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iCOoq-0004qg-S0
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 09:56:02 -0400
Received: from indium.canonical.com ([91.189.90.7]:46454)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iCOoq-0004qC-MH
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 09:56:00 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iCOoo-0005Dz-Uh
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 13:55:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id CFE9E2E80C9
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 13:55:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Sep 2019 13:43:47 -0000
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=In Progress; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: arm
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ilg karl-erik-zimmerman pmaydell
X-Launchpad-Bug-Reporter: Liviu Ionescu (ilg)
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
References: <20130826101205.25802.19011.malonedeb@soybean.canonical.com>
Message-Id: <156924622799.5337.3996293478856402411.malone@chaenomeles.canonical.com>
Subject: [Bug 1216845] Re: qemu-system-arm semihosting always calls exit(0)
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19048";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 30fe523a58212f371d83ca2169b0cefed247c6b2
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
Reply-To: Bug 1216845 <1216845@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

https://patchew.org/QEMU/20190916141544.17540-1-peter.maydell@linaro.org/
is a patchset which adds semihosting v2 support to QEMU. With those
patches and a guest binary which understands semihosting v2 and knows
how to probe for the existence of the EXIT_EXTENDED extension, arm guest
binaries will be able to pass a non-zero exit status.


** Changed in: qemu
       Status: Confirmed =3D> In Progress

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1216845

Title:
  qemu-system-arm semihosting always calls exit(0)

Status in QEMU:
  In Progress

Bug description:
  In my embedded ARM project I have a bunch of unit tests that I run in
  a POSIX synthetic environment, and, as usual for POSIX processes,
  these tests return 0 for success and !=3D0 for error.

  Now I expanded the testing environment to run some of these tests
  compiled for ARM, under QEMU, with the tracing messages forwarded via
  the semihosting API.

  Up to now everything is fine with the emulation.

  However I have a problem with passing the failure code back to the
  operating system, to drive the continuous integration framework.

  I checked the arm-semi.c code and for SYS_EXIT and I discovered that
  the parameter passed is ignored and it always calls exit(0):

      case SYS_EXIT:
          gdb_exit(env, 0);
          exit(0);

  To solve my problem I temporarily made a patch, and for cases that
  should return non zero codes, I call an unsupported BKPT instruction,
  which makes QEMU abort, and pass an non zero code (1) back to the
  operating system.

      qemu: Unsupported SemiHosting SWI 0xf1

  This kludge is more or less functional, but is quite inconvenient.

  After checking the ARM manuals, I discovered that SYS_EXIT is not
  standard, and the 0x18 code used for it originally was used for
  angel_SWIreason_ReportException, which has a slightly different
  purpose.

  Now the question:

  Would it be possible to no longer ignore the code passed to 0x18, and
  if it is non zero, to call exit() with a different value?

  The suggested rule would be:

  if (code =3D=3D0 || code =3D=3D 0x20026)
    exit(0);
  elif (code < 256)
    exit(code);
  else
    exit(1);

  The value 0x20026 means ADP_Stopped_ApplicationExit, and, if I
  understood it right, it means that the program terminated
  successfully. If this is not true, it can be removed from the first
  conditional statement.

  What do you think? Can this be added to arm-semi.c?

  =

  Regards,

  Liviu

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1216845/+subscriptions

