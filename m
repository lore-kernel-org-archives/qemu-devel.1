Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919DCC31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 12:52:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67E9420665
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 12:52:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67E9420665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57004 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdDbT-0005jh-Lo
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 08:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37763)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hdDZl-00041v-DK
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 08:51:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hdDZj-00085U-7q
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 08:51:01 -0400
Received: from indium.canonical.com ([91.189.90.7]:44746)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hdDZh-0007p2-DR
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 08:50:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hdDZV-00019Q-OT
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 12:50:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id B57022E80D3
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 12:50:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Jun 2019 12:40:04 -0000
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
Message-Id: <156086160457.22508.2412712603874412180.malone@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18981";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: e86dc612800fc61687ec47339bf2a367897af09a
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

Ah.

:)

As is probably somewhat evident at this point, I'm using vexpress-a9
because it's such a convenient QEMU target, rather than because I have
real hardware anywhere.

Hm, I didn't once stop and think that maybe there actually were two LCD
controllers. (And this is where software is great; I got to learn my
assumptions were invalid without blowing anything up. :D)

I tried to find the actual Versatile Express board I'm "using"; the
closest I was able to come was https://community.arm.com/developer
/tools-software/tools/b/tools-software-ides-blog/posts/50-off-arm-
versatile-express-development-boards. It looks like it has two
(...three?) processors and four PCIe slots. Very nice.

Thanks again.

** Changed in: qemu
       Status: New =3D> Invalid

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

