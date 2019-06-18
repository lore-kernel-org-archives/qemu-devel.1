Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD85C31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 15:54:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95D0A213F2
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 15:54:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95D0A213F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59196 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdGRI-0007aW-Tv
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 11:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54936)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hdFue-0004e3-Av
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 11:20:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hdFuc-0004e7-UJ
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 11:20:44 -0400
Received: from indium.canonical.com ([91.189.90.7]:53300)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hdFuc-0004cX-Ot
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 11:20:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hdFua-0004Lk-U5
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 15:20:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id E26FD2E802D
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 15:20:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Jun 2019 15:14:16 -0000
From: David Lindsay <asmqb7@gmail.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Invalid; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: pl111 vexpress-a9
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: asmqb7 pmaydell
X-Launchpad-Bug-Reporter: David Lindsay (asmqb7)
X-Launchpad-Bug-Modifier: David Lindsay (asmqb7)
References: <156078563656.24847.5055295179031840026.malonedeb@gac.canonical.com>
Message-Id: <156087085668.1700.17734136322461905700.malone@wampee.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18981";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: ad11178035bdbafac7b43d18f3d2ade0acfefb92
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1833101] Re: vexpress-a9 (but not -a15) creates
 two pl111 LCDs due to duplicate sysbus_create_simple("pl111", ...) calls
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
Reply-To: Bug 1833101 <1833101@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks for following up, and helping me figure some things out.

I coincidentally stumbled on
https://translatedcode.wordpress.com/2016/11/03/installing-debian-on-
qemus-32-bit-arm-virt-board/ a few days ago, landed on the page you
linked, and immediately wanted to try it.

Thanks very much for prompting me to properly think^Wmuddle through and
properly model the fussy details of my situation so I could finally see
a solution :)

I happen to be fiddling with an ARMv8 binary built with a Squeeze-era
/usr/lib, so I was using vexpress-a9 primarily because a prebuilt
Squeeze environment was available from
https://people.debian.org/~aurel32/qemu/armel/, and I was able to copy
over the /lib/modules/ and kernel image from
https://people.debian.org/~aurel32/qemu/armhf/ and have a working
system.

...And so obviously I can get more or less the same result by putting a
chroot of my current setup on top of a newer kernel and userspace.
Duh/facepalm. That looks to be my next step. Perhaps I'll use Alpine so
the environment boots quickly :D (I find Jessie takes 3min, while Wheezy
takes 60sec... that was one of my hesitations to fiddle too much
actually)

But first stop, a (prebuilt, most definitely definitely prebuilt) cross
compiler. I don't NEED to make my laptop get to 72=C2=B0C :)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1833101

Title:
  vexpress-a9 (but not -a15) creates two pl111 LCDs due to duplicate
  sysbus_create_simple("pl111", ...) calls

Status in QEMU:
  Invalid

Bug description:
  Hi,

  Just a small report that (12ec8bd is current master)

  https://github.com/qemu/qemu/blob/12ec8bd/hw/arm/vexpress.c#L652:

    ...
    vexpress_common_init() {
      ...
      sysbus_create_simple("pl111", map[VE_CLCD], pic[14]);
      ...
    ...

  and

  https://github.com/qemu/qemu/blob/12ec8bd/hw/arm/vexpress.c#L304:

    ...
    a9_daughterboard_init() {
      ...
      sysbus_create_simple("pl111", 0x10020000, pic[44]);
      ...
    ...

  result in two LCD panels when using vexpress-a9.

  vexpress-a15 does not appear to be affected (my -a9 kernel does not
  work with it, but I see only one pl111 created).

  Understandably (but still annoyingly), -nodefaults has no effect.

  This bug is most evident when using SDL (so I can use ",frame=3Doff"),
  which dumps two top-level windows onto the screen. GTK hides this
  because, coincidentally, the pl111 that ends up being used is the one
  that is selected (possibly the one created last?), relegating this to
  an obscure glitch only noticeable if you scrutinize the menu.

  This is a bugreport as opposed to a pull request as I have no idea
  which call to remove - and complete ignorance of the potential
  housekeeping and consideration that may be warranted first.

  FWIW, a simple testcase can be made with the vmlinuz from
  https://people.debian.org/~aurel32/qemu/armhf/ and

  qemu-system-arm -M vexpress-a9 -kernel vmlinuz-3.2.0-4-vexpress
  -nodefaults -sdl

  Thanks!

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1833101/+subscriptions

