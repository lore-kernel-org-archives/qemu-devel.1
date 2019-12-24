Return-Path: <SRS0=g5aJ=2O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBABC2D0CF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2019 12:31:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2373420706
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2019 12:31:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2373420706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijjLw-0004dO-6P
	for qemu-devel@archiver.kernel.org; Tue, 24 Dec 2019 07:31:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60821)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1ijjKp-0004Be-00
 for qemu-devel@nongnu.org; Tue, 24 Dec 2019 07:30:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1ijjKl-0004D7-MN
 for qemu-devel@nongnu.org; Tue, 24 Dec 2019 07:30:46 -0500
Received: from indium.canonical.com ([91.189.90.7]:50004)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1ijjKl-0004C3-HD
 for qemu-devel@nongnu.org; Tue, 24 Dec 2019 07:30:43 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1ijjKj-0005MJ-71
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2019 12:30:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 323EE2E80C0
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2019 12:30:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Dec 2019 12:25:29 -0000
From: =?utf-8?b?Q2lybyBTYW50aWxsaSDlha3lm5vkuovku7Yg5rOV6L2u5Yqf?=
 <ciro.santilli@gmail.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: cirosantilli
X-Launchpad-Bug-Reporter: =?utf-8?b?Q2lybyBTYW50aWxsaSDlha3lm5vkuovku7Yg?=
 =?utf-8?b?5rOV6L2u5YqfIChjaXJvc2FudGlsbGkp?=
X-Launchpad-Bug-Modifier: =?utf-8?b?Q2lybyBTYW50aWxsaSDlha3lm5vkuovku7Yg?=
 =?utf-8?b?5rOV6L2u5YqfIChjaXJvc2FudGlsbGkp?=
Message-Id: <157719032956.5393.6667899255989227451.malonedeb@gac.canonical.com>
Subject: [Bug 1857449] [NEW] QEMU x86_64 -nographic full system breaks host
 Bash terminal line wrapping state after simulation ends,
 requires reset or "tput smam" to fix it
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="bceb5ef013b87ef7aafe0755545ceb689ca7ac60";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: e387f99b3cb3219357fa518d4785156cd83c71ef
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
Reply-To: Bug 1857449 <1857449@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

QEMU 4.2.0 compiled from source, Ubuntu 19.10, open a fresh new gnome
terminal.

If you print 1000 =3D chars on the host terminal, then they do wrap around
the end of the terminal:

printf "=3D%.0s" {0..1000}

However, if you first run QEMU:

x86_64-softmmu/qemu-system-x86_64 -nographic

and then quit it in any way, e.g. with Ctrl + A, and then re-run on the
host terminal:

printf "=3D%.0s" {0..1000}

then the signs don't wrap around anymore, they just go "off the terminal
to the right".

This can be fixed with either:

reset
tpam smam

but unfortunately those don't work in tmux for some reason:
https://github.com/tmux/tmux/issues/969

I consider this buggy behavior, QEMU should restore the original
terminal state if possible.

Related: https://github.com/cirosantilli/linux-kernel-module-
cheat/issues/110

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1857449

Title:
  QEMU x86_64 -nographic full system breaks host Bash terminal line
  wrapping state after simulation ends, requires reset or "tput smam" to
  fix it

Status in QEMU:
  New

Bug description:
  QEMU 4.2.0 compiled from source, Ubuntu 19.10, open a fresh new gnome
  terminal.

  If you print 1000 =3D chars on the host terminal, then they do wrap
  around the end of the terminal:

  printf "=3D%.0s" {0..1000}

  However, if you first run QEMU:

  x86_64-softmmu/qemu-system-x86_64 -nographic

  and then quit it in any way, e.g. with Ctrl + A, and then re-run on
  the host terminal:

  printf "=3D%.0s" {0..1000}

  then the signs don't wrap around anymore, they just go "off the
  terminal to the right".

  This can be fixed with either:

  reset
  tpam smam

  but unfortunately those don't work in tmux for some reason:
  https://github.com/tmux/tmux/issues/969

  I consider this buggy behavior, QEMU should restore the original
  terminal state if possible.

  Related: https://github.com/cirosantilli/linux-kernel-module-
  cheat/issues/110

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1857449/+subscriptions

