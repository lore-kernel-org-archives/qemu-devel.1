Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A04C4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 07:56:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB866217D4
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 07:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB866217D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37744 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCJia-0006HQ-8V
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 03:56:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hCJhp-0005ne-MI
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 03:56:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hCJho-0005yb-EK
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 03:56:09 -0400
Received: from indium.canonical.com ([91.189.90.7]:52416)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hCJho-0005vB-6g
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 03:56:08 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hCJhk-0003O1-SX
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 07:56:05 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 01A0E2E8181
	for <qemu-devel@nongnu.org>; Fri,  5 Apr 2019 07:56:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Apr 2019 07:44:30 -0000
From: Robert Uomini <1823169@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Invalid; importance=Undecided;
	assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: fractalbob paelzer th-huth
X-Launchpad-Bug-Reporter: Robert Uomini (fractalbob)
X-Launchpad-Bug-Modifier: Robert Uomini (fractalbob)
References: <155437966834.20937.13725906067731199360.malonedeb@chaenomeles.canonical.com>
	<155444394987.21192.3332237882695030786.malone@soybean.canonical.com>
Message-Id:
 <CAB6aw5F4t7d2fqJCcXWAuAXBKmZFPa2vpeF906OZViFSn7KrzA@mail.gmail.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18920";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 295ea023a753643c790b479a59d03ef18128ca05
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: Re: [Qemu-devel] [Bug 1823169] Re: qemu displays message "Setup
 failed, please check external storage is available and has enough room."
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1823169 <1823169@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405074430.mKH5gEJtBS22dS974Yf3EEuBhxzOPeNIBFYiFIAmjMA@z>

On Fri, Apr 5, 2019 at 8:05 AM Christian Ehrhardt =EE=83=BF <
1823169@bugs.launchpad.net> wrote:

> I agree to Thomas, and in that case referring to your comment #2 - qemu
> versions in Ubuntu are associated with the base Ubuntu version - so Ubuntu
> 16.04 will stick to qemu 2.5 + fixes.
> Ubuntu 19.10 released next week has qemu 3.1 btw, see [1]
>
Awesome!

>
> And vice versa for an upstream report (which is often helpful for deep
> technical discussions) you'll want to try with the latest version anyway
> - which for just a few days is 3.1 still, then it will be 4.0 :-)
>
Even better!

>
> [1]: https://launchpad.net/ubuntu/+source/qemu
> [2]: https://wiki.qemu.org/Planning/4.0
>
> --
> You received this bug notification because you are subscribed to the bug
> report.
> https://bugs.launchpad.net/bugs/1823169
>
> Title:
>   qemu displays message "Setup failed, please check external storage is
>   available and has enough room."
>
> Status in QEMU:
>   Invalid
>
> Bug description:
>   I tried to launch the Android app PokerStarsFR, and after it began
>   initialization, the launch failed with the above error. I'm running
>   qemu on a Dell XPS 13 (9370) laptop running Ubuntu 16.04 LTS. The
>   standard apps launch OK, but this one does not. I had downloaded it
>   from the PokerStars site
>   https://www.pokerstars.fr/en/poker/download/android/.
>
>   I am running qemu version 2.5.0
>
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1823169/+subscriptions
>

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1823169

Title:
  qemu displays message "Setup failed, please check external storage is
  available and has enough room."

Status in QEMU:
  Invalid

Bug description:
  I tried to launch the Android app PokerStarsFR, and after it began
  initialization, the launch failed with the above error. I'm running
  qemu on a Dell XPS 13 (9370) laptop running Ubuntu 16.04 LTS. The
  standard apps launch OK, but this one does not. I had downloaded it
  from the PokerStars site
  https://www.pokerstars.fr/en/poker/download/android/.

  I am running qemu version 2.5.0

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1823169/+subscriptions

