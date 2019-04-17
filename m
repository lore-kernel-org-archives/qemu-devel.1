Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19603C282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 15:31:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0FBF20674
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 15:31:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0FBF20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55384 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGmXN-0007Xd-1y
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 11:31:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hGmW1-0006n2-Gx
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 11:30:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hGmVz-0002W7-RB
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 11:30:25 -0400
Received: from indium.canonical.com ([91.189.90.7]:33444)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hGmVz-0002VP-Ec
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 11:30:23 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hGmVy-00006W-PF
	for <qemu-devel@nongnu.org>; Wed, 17 Apr 2019 15:30:22 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id BC5512E806D
	for <qemu-devel@nongnu.org>; Wed, 17 Apr 2019 15:30:22 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Apr 2019 15:19:56 -0000
From: Thomas Huth <1267520@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
	assignee=None; 
X-Launchpad-Bug-Tags: qemu qemu-1.7
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: andrewoates lilmurfer richfletcher rowan-potgieter
	th-huth valor
X-Launchpad-Bug-Reporter: Mofi Taiwo (lilmurfer)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20140109160856.15157.6320.malonedeb@wampee.canonical.com>
Message-Id: <155551439607.13880.5653310165775565536.malone@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18928";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 1f3704f291a49f81fb501d5fc31bfdfd13a2339b
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1267520] Re: Keyboard input not working when the
 "-k en-us" argument is specified.
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
Reply-To: Bug 1267520 <1267520@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190417151956.Gzphd-6zXULOswDZn0vb-CObh_Pxv3zqrpYrGrk7NW4@z>

I think this is likely fixed with QEMU 4.0 by this commit here:

https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D26b1cbf8b65b3b55c3f

Could you please try again with QEMU 4.0-rc4 (or the final 4.0 release
next week)?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1267520

Title:
  Keyboard input not working when the "-k en-us" argument is specified.

Status in QEMU:
  Incomplete

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

