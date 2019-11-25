Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E684C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 09:16:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4496020718
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 09:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4496020718
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZAU5-0000RP-J6
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 04:16:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56745)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iZATE-0007xx-8c
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 04:15:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iZATC-00043M-63
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 04:15:47 -0500
Received: from indium.canonical.com ([91.189.90.7]:51666)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iZATA-00042K-81
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 04:15:45 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iZAT8-0001w4-G0
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 09:15:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 6FEB22E80C0
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 09:15:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 Nov 2019 09:06:41 -0000
From: Evan Rysdam <1853781@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Invalid; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: baremetal raspi2
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: evan-rysdam philmd
X-Launchpad-Bug-Reporter: Evan Rysdam (evan-rysdam)
X-Launchpad-Bug-Modifier: Evan Rysdam (evan-rysdam)
References: <157463269344.7205.8988702228388398977.malonedeb@gac.canonical.com>
Message-Id: <157467280123.6153.1628874454148506644.malone@gac.canonical.com>
Subject: [Bug 1853781] Re: Baremetal kernel built from assembly runs multiple
 times
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="c597c3229eb023b1e626162d5947141bf7befb13";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: b2d11f1e83babd3e8f51de286752d80391fbef2f
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Reply-To: Bug 1853781 <1853781@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Aha! So this is not a bug after all, but an intentional feature.

Does "deal with handling all the secondary cores" basically mean
"detecting what core I'm currently running on, and continuing only if
it's the primary core"? If so, it's not clear to me how I could do this.
I tried a few obvious ideas, like inspecting the value of r0 as soon as
the program boots up, but I wasn't able to find a way to distinguish
between the cores. Could you point me to any resources that would have
the answer?

Thanks for your quick response!
Evan Rysdam

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1853781

Title:
  Baremetal kernel built from assembly runs multiple times

Status in QEMU:
  Invalid

Bug description:
  QEMU version: 4.1.0.

  Full command used to launch: qemu-system-arm -machine raspi2 -kernel
  main

  (Technically, the first term of the command is actually
  "~/Applications/QEMU/qemu-4.1.0/build/arm-softmmu/qemu-system-arm",
  but I shortened it for readability.)

  Host information: Running debian 9.9 on a 64-bit x86 processor (Intel
  i5-2520M).

  Guest information: No operating system. I'm providing my own kernel,
  which I assembled from a 60-line ARM assembly program using arm-none-
  eabi-as and then linked with arm-none-eabi-ld, both version
  2.28-5+9+b3.

  Additional details: To view the screen output of the program, I am
  using vncviewer version 6.19.1115 (r42122). All of the above software
  packages were installed as debian packages using apt, except for QEMU,
  which I built from source after downloading from the official website.

  .

  The issue here is that I have written a program in assembly and it
  isn't doing what I expect it to when I emulate it. Here's a summary of
  the code:

  1) Read a number from zero-initialized memory.

  2) Add one to the number and write it back.

  3) Use the number to determine a screen location to write to.

  4) Use the number to determine what color to write.

  5) Write 4000 half-words to the screen starting at that offset and
  using that color. This should result in a stripe across the whole
  screen that's about 6 pixels tall.

  The expected behavior is that *one* stripe should appear on the screen
  in a single color. However, the actual behavior is that up to *four*
  stripes appear, each in a different color. Furthermore, if I comment
  out the line that writes the incremented counter back to memory, then
  only one stripe will appear.

  I will also note that the Raspberry Pi 2, which is the system I'm
  emulating, has four cores. What I suspect is going on here is that my
  code is being loaded onto all four cores of the emulated machine. I
  couldn't find anything about this anywhere in the documentation, and
  it strikes me as bug.

  I have attached the assmebly code that I'm using, as well as a short
  makefile. Since I can only add one attachment to this report, I've
  combined the two into a single text file and labeled each. After
  separating the two into two files, you will need to change the first
  line of the makefile to point to your installation of qemu-system-arm
  v4.1.0. After that, type "make run" to run the program.

  Thanks in advance,
  Evan Rysdam

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1853781/+subscriptions

