Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F71CC2BA19
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 03:06:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54A6520936
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 03:06:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54A6520936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMk08-0008S2-DF
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 23:06:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44871)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jMjzL-00081z-3A
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 23:05:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jMjzJ-0000Ui-VR
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 23:05:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:58400)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jMjzJ-0000TD-QQ
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 23:05:49 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jMjzI-0007lp-8q
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2020 03:05:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 3A4D82E8105
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2020 03:05:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Apr 2020 02:56:39 -0000
From: John Snow <1863441@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: fysnet jnsnow
X-Launchpad-Bug-Reporter: Benjamin David Lunt (fysnet)
X-Launchpad-Bug-Modifier: John Snow (jnsnow)
References: <158179973601.15520.14709037359293558924.malonedeb@soybean.canonical.com>
Message-Id: <158648739981.5491.10260814958879587102.malone@chaenomeles.canonical.com>
Subject: [Bug 1863441] Re: cmd_mode_sense always reports 0x70, no CDROM present
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="2e26c9bbd21cdca248baaea29aeffb920afcc32a";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 952b58e5949601c58051f602dc8e3fa52bdb132f
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
Reply-To: Bug 1863441 <1863441@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Roger that, thanks!

I don't think we're very careful about which version we try to emulate.
In practice it's "Whatever seems to work across the largest swatch of
guest operating systems simultaneously".

If this comes up again, feel free to file against a specific guest OS
that appears to be non-functioning.

Thanks!

--js

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1863441

Title:
  cmd_mode_sense always reports 0x70, no CDROM present

Status in QEMU:
  New

Bug description:
  cmd_mode_sense
    https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Dhw/ide/atapi.c;hb=3Dref=
s/heads/master#l852
  always reports 0x70 in byte 2 returned, indicating no CD-ROM present.

  If CD-ROM is present, should report 0x01 (or 0x11).
  If CD-ROM absent, should report 0x70.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1863441/+subscriptions

