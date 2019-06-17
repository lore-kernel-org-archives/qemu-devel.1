Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C128DC31E54
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 04:33:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C81E2189D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 04:33:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C81E2189D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44192 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcjKG-0000PV-NO
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 00:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51985)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hcjIQ-0008EN-0S
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 00:31:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hcjIO-0007qt-JW
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 00:31:05 -0400
Received: from indium.canonical.com ([91.189.90.7]:57078)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hcjIN-0007gK-91
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 00:31:03 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hcjI6-0007H3-Hs
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 04:30:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 863082E80C7
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 04:30:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Jun 2019 04:17:40 -0000
From: Launchpad Bug Tracker <1267520@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Expired; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: qemu qemu-1.7
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: andrewoates janitor lilmurfer richfletcher
 rowan-potgieter th-huth valor
X-Launchpad-Bug-Reporter: Mofi Taiwo (lilmurfer)
X-Launchpad-Bug-Modifier: Launchpad Janitor (janitor)
References: <20140109160856.15157.6320.malonedeb@wampee.canonical.com>
Message-Id: <156074506090.24961.13210862820073482366.malone@loganberry.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18981";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: bcbbc2acde6837dfd4a9f5dba9249448e2a9588d
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1267520] Re: Keyboard input not working when the
 "-k en-us" argument is specified.
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
Reply-To: Bug 1267520 <1267520@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1267520

Title:
  Keyboard input not working when the "-k en-us" argument is specified.

Status in QEMU:
  Expired

Bug description:
  This bug occurs on qemu compiled with i386_softmmu and x86-64_softmmu on =
linux kernel 3.5.0 (64-bit). (Haven't confirmed this for other targets).
  Whenever I run qemu (both i386 and x86_64) to use the en-us language (eve=
n though it is the default), I get "Warning: no scancode found for keysym X=
" (X is an integer).
  In the disk image I need qemu to run, I had a shell set up.  The shell do=
esn't register keyboard input when the '-k en-us' command line argument is =
set to run qemu. I did not have this problem with earlier versions of qemu.

  Additional information:
  Setting keymaps directory on command line -L doesn't resolve this.
  Bug occurs with on both curses and sdl VGA output.
  I am running qemu on Ubuntu 12.04 and I have not been able see if the bug=
 is distribution-specific. However, I am also experiencing the bug on Kali-=
Linux; another debian based distribution.
  It turns out that all languages reproduce the bug, not just 'en-us'.

  Update: I have narrowed the bug to be attributable to versions later
  than qemu-1.1.2.

  Here's a listing of key being mapped:

  Setting keysym exclam (33) to 258
  Setting keysym at (64) to 259
  Setting keysym numbersign (35) to 260
  Setting keysym dollar (36) to 261
  Setting keysym percent (37) to 262
  Setting keysym asciicircum (94) to 263
  Setting keysym ampersand (38) to 264
  Setting keysym asterisk (42) to 265
  Setting keysym parenleft (40) to 266
  Setting keysym parenright (41) to 267
  Setting keysym minus (45) to 12
  Setting keysym underscore (95) to 268
  Setting keysym equal (61) to 13
  Setting keysym plus (43) to 269
  Setting keysym bracketleft (91) to 26
  Setting keysym braceleft (123) to 282
  Setting keysym bracketright (93) to 27
  Setting keysym braceright (125) to 283
  Setting keysym semicolon (59) to 39
  Setting keysym colon (58) to 295
  Setting keysym apostrophe (39) to 40
  Setting keysym quotedbl (34) to 296
  Setting keysym grave (96) to 41
  Setting keysym asciitilde (126) to 297
  Setting keysym backslash (92) to 43
  Setting keysym bar (124) to 299
  Setting keysym comma (44) to 51
  Setting keysym less (60) to 307
  Setting keysym period (46) to 52
  Setting keysym greater (62) to 308
  Setting keysym slash (47) to 53
  Setting keysym question (63) to 309

  As one can see, the pc-bios/keymaps/common, contaning the QWWERTY
  keys, is not processed in parse_init_keyboard at ui/keymaps.c even
  though the XKB map (keymaps/en-us) includes the file.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1267520/+subscriptions

