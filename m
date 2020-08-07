Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AE6C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 10:29:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7E2620855
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 10:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7E2620855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3zdE-0002w2-8H
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 06:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k3zYf-00056W-Ri
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 06:25:06 -0400
Received: from indium.canonical.com ([91.189.90.7]:38718)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k3zYZ-0000bB-7s
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 06:25:03 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k3zYV-0002j4-DB
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 10:24:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 2B0BC2E8082
 for <qemu-devel@nongnu.org>; Fri,  7 Aug 2020 10:24:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2020 10:11:23 -0000
From: Thomas Huth <1309034@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Wishlist; assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: masm-e
X-Launchpad-Bug-Reporter: Yuuki Harano (masm-e)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20140417141213.27030.31355.malonedeb@gac.canonical.com>
Message-Id: <159679508380.25952.5478722826430557250.launchpad@gac.canonical.com>
Subject: [Bug 1309034] Re: A way not to grab keyboards or mice
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="6a138c03da9cc3e2e03f6dd3bbb4a615b0be6ec2";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 1ba98a013ba2a15031fe40979ca672a083293fcc
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 01:41:01
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Reply-To: Bug 1309034 <1309034@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Changed in: qemu
   Importance: Undecided =3D> Wishlist

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1309034

Title:
  A way not to grab keyboards or mice

Status in QEMU:
  New

Bug description:
  I set up the window manager to move windows with Alt-Btn1, and to
  iconify windows with Shift-Btn1. But since qemu grabs keyboards and
  mice, I can't move or iconify the qemu window.

  I tried not to grab anything, by inserting return, just beginnig of
  ui/sdl.c:sdl_grab_start() as follows:

  static void sdl_grab_start(void)
  {
      return;
      /*

  It is comfortable. I'm glad if you make a way not to grab.
  Environment variables, options, etc are welcome.

  Current command line is:
  QEMU_AUDIO_DRV=3Dpa /usr/local/bin/qemu-system-x86_64 -enable-kvm -hda /d=
osc/win8_x64.img -soundhw hda -boot c -m 2G -cpu Nehalem,+sep -usb -usbdevi=
ce tablet -display sdl -rtc base=3Dlocaltime

  qemu version is:
  luna:linux % qemu-system-x86_64 --version
  QEMU emulator version 1.7.93, Copyright (c) 2003-2008 Fabrice Bellard
  luna:linux % =


  Host: slackware64 14.1
  Host Environment: xfce4 / sawfish
  Guest: Windows 8.1 x64

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1309034/+subscriptions

