Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5314AC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 16:59:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28349222C7
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 16:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28349222C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDX6j-0002Wd-4R
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 12:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42211)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iDWfh-0006KO-5l
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:31:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iDWfb-0006dc-4T
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:31:11 -0400
Received: from indium.canonical.com ([91.189.90.7]:51792)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iDWfa-0006Y2-IU
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:31:07 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iDWfP-0007DL-1y
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 16:30:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 03AD22E80CB
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 16:30:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Sep 2019 16:23:06 -0000
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: janitor pmaydell rtos.pharos
X-Launchpad-Bug-Reporter: RTOS Pharos (rtos.pharos)
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
References: <152947435461.1911.16896504402050089205.malonedeb@chaenomeles.canonical.com>
Message-Id: <156951498637.20009.8100501858973091594.malone@wampee.canonical.com>
Subject: [Bug 1777777] Re: arm9 clock pending (SP804)
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19056";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 439285a25a8a10b751cc8c8bb920c2c670f09558
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
Reply-To: Bug 1777777 <1777777@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks for the repro case. Preliminary analysis: I added some
tracepoints to the sp804 code, and you're right that the value of the
interrupt status register isn't always correct:

A normal attempt to read the clock looks like this:

Taking exception 2 [SVC]
...from EL0 to EL1
...with ESR 0x11/0x4600000b
AArch32 mode switch from svc to sys PC 0x12010
AArch32 mode switch from sys to svc PC 0x12018
32696@1569513406.450378:sp804_read addr 0x00000004 value 0x00000681
32696@1569513406.450384:sp804_read addr 0x00000014 value 0x00000000
Exception return from AArch32 svc to usr PC 0x10ff0

Sometimes we might read the clock when it's exactly got down to 0 (this is =
more likely on QEMU than on real h/w for internal reasons of our implementa=
tion):
Taking exception 2 [SVC]
...from EL0 to EL1
...with ESR 0x11/0x4600000b
AArch32 mode switch from svc to sys PC 0x12010
AArch32 mode switch from sys to svc PC 0x12018
32696@1569513406.452273:sp804_read addr 0x00000004 value 0x00000000
32696@1569513406.452279:sp804_read addr 0x00000014 value 0x00000000
Exception return from AArch32 svc to usr PC 0x10ff0

A correct handling of the rollover looks like this (we read the counter,
which is rolled over, and the interrupt-status, which is 1, which causes
us to reread the counter; once we're done the IRQ handler itself runs):

4003@1569514474.944756:sp804_read addr 0x00000004 value 0x0000c29d
4001@1569514474.944761:sp804_arm_timer_update level 1
4003@1569514474.944797:sp804_read addr 0x00000014 value 0x00000001
4003@1569514474.944828:sp804_read addr 0x00000004 value 0x0000c255
Taking exception 5 [IRQ]
...from EL1 to EL1
...with ESR 0x11/0x4600000b
AArch32 mode switch from irq to svc PC 0x2a5e4
4003@1569514474.944943:sp804_read addr 0x00000014 value 0x00000001
4003@1569514474.944957:sp804_read addr 0x00000034 value 0x00000000
4003@1569514474.944962:sp804_read addr 0x00000014 value 0x00000001
4003@1569514474.944965:sp804_write addr 0x0000000c value 0x00000000
4003@1569514474.944966:sp804_arm_timer_update level 0
4003@1569514474.944969:sp804_read addr 0x00000034 value 0x00000000
AArch32 mode switch from svc to irq PC 0x2a718
Exception return from AArch32 irq to svc PC 0x2a3bc
Exception return from AArch32 svc to usr PC 0x10ff0

But sometimes we get this, where we read the rolled-over counter value
but the interrupt-status register is still 0:

Taking exception 2 [SVC]
...from EL0 to EL1
...with ESR 0x11/0x4600000b
AArch32 mode switch from svc to sys PC 0x12010
AArch32 mode switch from sys to svc PC 0x12018
4003@1569514475.794690:sp804_read addr 0x00000004 value 0x0000c2df
4003@1569514475.794698:sp804_read addr 0x00000014 value 0x00000000
4001@1569514475.794703:sp804_arm_timer_update level 1
Exception return from AArch32 svc to usr PC 0x10ff0
Taking exception 5 [IRQ]
...from EL0 to EL1
...with ESR 0x11/0x4600000b
AArch32 mode switch from irq to svc PC 0x2a5e4
4003@1569514475.794768:sp804_read addr 0x00000014 value 0x00000001
4003@1569514475.794937:sp804_read addr 0x00000034 value 0x00000000
4003@1569514475.794944:sp804_read addr 0x00000014 value 0x00000001
4003@1569514475.794947:sp804_write addr 0x0000000c value 0x00000000
4003@1569514475.794949:sp804_arm_timer_update level 0
4003@1569514475.794952:sp804_read addr 0x00000034 value 0x00000000
AArch32 mode switch from svc to irq PC 0x2a718
Exception return from AArch32 irq to usr PC 0x10ff0


This happens because the sp804 uses a QEMU timer abstraction "ptimer".
The ptimer updates its internal state when a raw QEMU timer expires and
calls the ptimer_tick() function. From this point on, a guest read of
the counter value will get the rolled-over value, because the sp804
implements this as a simple ptimer_get_count(). However, the ptimer
doesn't immediately call the sp804's arm_timer_tick() function (which is
where we update the interrupt-status flag and arrange for an IRQ to be
delivered) -- it just schedules that to happen later via a QEMU "bottom
half handler". Unfortunately it's possible for the guest CPU to run
between when the ptimer's ptimer_tick() happens and when the bottom-
half-handler is triggered, which means that the guest can see this
incorrectly out-of-sync state from the sp804 device.

I'm not currently sure how best to fix this.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1777777

Title:
  arm9 clock pending (SP804)

Status in QEMU:
  New

Bug description:
  Hello all,

  I'm using the versatilepb board and the timer Interrupt Mask Status
  register (offset 0x14 of the SP804) does not seem to be working
  properly on the latest qemu-2.12. I tried on the 2.5 (i believe this
  is the mainstream version that comes with Linux) and it works
  perfectly.

  What happens is that the pending bit does not seem to be set in some
  scenarios. In my case, I see the timer value decreasing to 0 and then
  being reset to the reload value and neither does the interrupt is
  triggered nor the pending bit is set.

  I believe this is a matter of timing since in the "long" run the
  system eventually catches up (after a few microseconds).

  Thank you

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1777777/+subscriptions

