Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E598DC4CECF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 19:03:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF25320665
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 19:03:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF25320665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCTcs-0003Lg-K5
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 15:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55478)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iCTaE-0002Bw-Hl
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 15:01:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iCTaC-000206-IW
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 15:01:14 -0400
Received: from indium.canonical.com ([91.189.90.7]:46980)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iCTaA-0001wW-Lg
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 15:01:12 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iCTa7-0006PJ-EL
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 19:01:07 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 6331B2E80C9
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 19:01:07 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Sep 2019 18:50:43 -0000
From: RTOS Pharos <1777777@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: janitor pmaydell rtos.pharos
X-Launchpad-Bug-Reporter: RTOS Pharos (rtos.pharos)
X-Launchpad-Bug-Modifier: RTOS Pharos (rtos.pharos)
References: <152947435461.1911.16896504402050089205.malonedeb@chaenomeles.canonical.com>
Message-Id: <156926464393.14129.17484932167733030378.malone@gac.canonical.com>
Subject: [Bug 1777777] Re: arm9 clock pending (SP804)
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19048";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 0016e15959f9d8b80da417446b3677f89def10c1
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

Sorry to have taken some time to answer.

Created the binary with the test.

Here is the output when it fails (tested in Qemu 2.12):

Checked 0 times if the time is always increasing
Checked 100000 times if the time is always increasing
Checked 200000 times if the time is always increasing
Checked 300000 times if the time is always increasing
Checked 400000 times if the time is always increasing
Checked 500000 times if the time is always increasing
Checked 600000 times if the time is always increasing
Checked 700000 times if the time is always increasing
Error: the time read is smaller than the previous time read


And here with the latest Qemu (4.1.0):

Checked 0 times if the time is always increasing
Checked 100000 times if the time is always increasing
Error: the time read is smaller than the previous time read


The error can occur basically at any time. But when tested with Qemu 2.5
it goes well:

Checked 0 times if the time is always increasing
Checked 100000 times if the time is always increasing
Checked 200000 times if the time is always increasing
Checked 300000 times if the time is always increasing
Checked 400000 times if the time is always increasing
Checked 500000 times if the time is always increasing
Checked 600000 times if the time is always increasing
Checked 700000 times if the time is always increasing
Checked 800000 times if the time is always increasing
Checked 900000 times if the time is always increasing
Checked 1000000 times if the time is always increasing
Checked 1100000 times if the time is always increasing
Checked 1200000 times if the time is always increasing
Checked 1300000 times if the time is always increasing
Checked 1400000 times if the time is always increasing
Checked 1500000 times if the time is always increasing
Checked 1600000 times if the time is always increasing
Checked 1700000 times if the time is always increasing
Checked 1800000 times if the time is always increasing
Checked 1900000 times if the time is always increasing
Checked 2000000 times if the time is always increasing
Checked 2100000 times if the time is always increasing
Checked 2200000 times if the time is always increasing
Checked 2300000 times if the time is always increasing
Checked 2400000 times if the time is always increasing
Checked 2500000 times if the time is always increasing
Checked 2600000 times if the time is always increasing
Checked 2700000 times if the time is always increasing
Checked 2800000 times if the time is always increasing
Checked 2900000 times if the time is always increasing
.
.
.
Checked 9500000 times if the time is always increasing
Checked 9600000 times if the time is always increasing
Checked 9700000 times if the time is always increasing
Checked 9800000 times if the time is always increasing
Checked 9900000 times if the time is always increasing
Example finished


Just to give some background on the test itself, the main.c file
contains this:

void helloWorld0()
{
    uint64_t microseconds;
    uint64_t previousMicroseconds =3D 0;
    uint32_t i;

    for(i =3D 0; i < NUMBER_REPETITIONS; i++)
    {
        microseconds =3D pharosClockGetSinceBoot();

        if(microseconds < previousMicroseconds)
        {
            printk("Error: the time read is smaller than the previous time =
read\r\n");
            pharosThreadSuspendSelf();
        }

        previousMicroseconds =3D microseconds;

        /* only print 100 times the message */
        if(i % (NUMBER_REPETITIONS / 100) =3D=3D 0)
        {
            printk("Checked %d times if the time is always increasing\r\n" =
, i);
        }
    }

    printk("Example finished\r\n");
    pharosThreadSuspendSelf();
}


And where I suspect the code is reading the wrong hardware level is here:

bool pharosCpuClockIsrIsPending(void)
{
    /* apparently QEMU has a bug when it comes to reading the SP804 interru=
pt status. It seems that we have to read
      it multiple times in order for it to give the correct result since it=
 does not update the interrupt status =

      of the SP804 when it should. Qemu 2.5 did not have this problem but a=
t least Qemu 2.12, 3.1 and 4.1.0 have this
      problem. So we just create a work-around for it. */
#if 0

    /* number of times to read it. */
#define N 100

    uint32_t i;

    /* read the interrupts status a lot of times to wait for QEMU to update=
 the status */
    for(i =3D 0; i < N; i++)
    {
        /* if there is an interrupt */
        if(armSp804TimerInterruptIsPending(TIMER1_BASE_ADDRESS) =3D=3D TRUE)
        {
            /* return right away */
            return TRUE;
        }
    }

    /* read the status a LOT of times, there is no interrupt pending */
    return FALSE;

    /* On a real hardware this problem should not occur so we only have to =
read it once */
#else
    /* read the SP804 timer interrupt pending info */
    return armSp804TimerInterruptIsPending(TIMER1_BASE_ADDRESS);
#endif
}

that is, the armSp804TimerInterruptIsPending is not correctly returning
if the timer1 has a pending interrupt (even though I check the timer
load value and it was reset just before and no interrupt was raised -
interrupts disabled)


** Attachment added: "myApplication"
   https://bugs.launchpad.net/qemu/+bug/1777777/+attachment/5290737/+files/=
myApplication

** Changed in: qemu
       Status: Expired =3D> New

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

