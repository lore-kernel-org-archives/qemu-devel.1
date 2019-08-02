Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5618AC32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 18:26:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 216DA204EC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 18:26:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 216DA204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htcG8-00072X-RP
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 14:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57756)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1htbry-0005SH-Mu
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 14:01:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1htbrw-00052P-Ti
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 14:01:34 -0400
Received: from indium.canonical.com ([91.189.90.7]:55834)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1htbrw-0004JD-MY
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 14:01:32 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1htbrY-0001jc-MZ
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 18:01:08 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 99B062E80CE
 for <qemu-devel@nongnu.org>; Fri,  2 Aug 2019 18:01:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Aug 2019 17:51:40 -0000
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: artem.pisarenko pmaydell
X-Launchpad-Bug-Reporter: Artem Pisarenko (artem.pisarenko)
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
References: <153596437135.32162.9985112313849579617.malonedeb@soybean.canonical.com>
Message-Id: <156476830098.29006.4959983778968773829.malone@wampee.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19014";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 85f2047a42ba7318aed20a0e6244378283de786f
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1790460] Re: -icount,
 sleep=off mode is broken (target slows down or hangs)
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
Reply-To: Bug 1790460 <1790460@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I think we fixed this bug in commit 013aabdc665e4256b38d which would
have been in the 3.1.0 release (this is why we closed #1774677, which as
you say is the same issue).


** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1790460

Title:
  -icount,sleep=3Doff mode is broken (target slows down or hangs)

Status in QEMU:
  Fix Released

Bug description:
  QEMU running with options "-icount,sleep=3Doff -rtc clock=3Dvm" doesn't e=
xecute emulation at maximum possible speed.
  Target virtual clock may run faster or slower than realtime clock by N ti=
mes, where N value depends on various unrelated conditions (i.e. random fro=
m the user point of view). The worst case is when target hangs (hopefully, =
early in booting stage).
  Example scenarios I've described here: http://lists.nongnu.org/archive/ht=
ml/qemu-discuss/2018-08/msg00102.html

  QEMU process just sleeps most of the time (polling, waiting some
  condition, etc.). I've tried to debug issue and came to 99% conclusion
  that there are racing somewhere in qemu internals.

  The feature is broken since v2.6.0 release.
  Bad commit is 281b2201e4e18d5b9a26e1e8d81b62b5581a13be by Pavel Dovgalyuk=
, 03/10/2016 05:56 PM:

    icount: remove obsolete warp call
    =

    qemu_clock_warp call in qemu_tcg_wait_io_event function is not needed
    anymore, because it is called in every iteration of main_loop_wait.
    =

    Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

    Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
    Message-Id: <20160310115603.4812.67559.stgit@PASHA-ISP>
    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

  I've reverted commit to all major releases and latest git master
  branch. Issue was fixed for all of them. My adaptation is trivial:
  just restoring removed function call before "qemu_cond_wait(...)"
  line.

  I'm sure following bugs are just particular cases of the issue:
  #1774677, #1653063 .

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1790460/+subscriptions

