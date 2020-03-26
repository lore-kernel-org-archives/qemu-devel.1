Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262DDC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 18:09:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F10CB20714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 18:09:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F10CB20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHWwv-0005dY-VD
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 14:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46751)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jHWtJ-0003IW-2d
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 14:06:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jHWtH-0007Tp-N5
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 14:06:05 -0400
Received: from indium.canonical.com ([91.189.90.7]:58846)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jHWtH-0007S9-GD
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 14:06:03 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jHWtD-0001bV-BS
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 18:05:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id CC57C2E80DA
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 18:05:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Mar 2020 17:54:11 -0000
From: Manuel Reimer <manuel.reimer@gmx.de>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: manuel-reimer
X-Launchpad-Bug-Reporter: Manuel Reimer (manuel-reimer)
X-Launchpad-Bug-Modifier: Manuel Reimer (manuel-reimer)
Message-Id: <158524525185.11288.13431171964395831782.malonedeb@soybean.canonical.com>
Subject: [Bug 1869241] [NEW] svn checkout fails with E000075 "Value too large
 for defined data type"
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="3a6db24bbe7280ec09bae73384238390fcc98ad3";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 6129ea762b1fa1abf00f0599616b5e9fcbe61fbd
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
Reply-To: Bug 1869241 <1869241@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

I try to autobuild for ARM7 with qemu-arm-static. Part of this is
downloading source via SVN.

Whenever I try to download a SVN repository I get the following output:

=C2=A0=C2=A0=C2=A0=C2=A0svn: E000075: Can't read directory '...': Value too=
 large for
defined data type

This is the repository I'm trying to check out:
https://svn.baycom.de/repos/vdr-mcli-plugin/

qemu-arm-static version is 4.2.0

I've also tried older versions without change.

Platform I try to emulate is armv7h (Arch Linux ARM for Raspberry Pi 2)

Host system is AMD64

This can be reproduced 100% of the time. Here I have the issue happening
on Travis CI:

https://travis-ci.com/github/VDR4Arch/vdr4arch/jobs/304839747#L9944

** Affects: qemu
     Importance: Undecided
         Status: New

** Description changed:

  I try to autobuild for ARM7 with qemu-arm-static. Part of this is
  downloading source via SVN.
  =

  Whenever I try to download a SVN repository I get the following output:
  =

-     svn: E000075: Can't read directory '...': Value too large for
+ =C2=A0=C2=A0=C2=A0=C2=A0svn: E000075: Can't read directory '...': Value t=
oo large for
  defined data type
  =

  qemu-arm-static version is 4.2.0
  =

  I've also tried older versions without change.
  =

  Platform I try to emulate is armv7h (Arch Linux ARM for Raspberry Pi 2)
  =

  Host system is AMD64
  =

  This can be reproduced 100% of the time. Here I have the issue happening
  on Travis CI:
  =

- https://travis-ci.com/github/VDR4Arch/vdr4arch/jobs/304839747#L7228
+ https://travis-ci.com/github/VDR4Arch/vdr4arch/jobs/304839747#L9944

** Description changed:

  I try to autobuild for ARM7 with qemu-arm-static. Part of this is
  downloading source via SVN.
  =

  Whenever I try to download a SVN repository I get the following output:
  =

  =C2=A0=C2=A0=C2=A0=C2=A0svn: E000075: Can't read directory '...': Value t=
oo large for
  defined data type
+ =

+ This is the repository I'm trying to check out:
+ https://svn.baycom.de/repos/vdr-mcli-plugin/
  =

  qemu-arm-static version is 4.2.0
  =

  I've also tried older versions without change.
  =

  Platform I try to emulate is armv7h (Arch Linux ARM for Raspberry Pi 2)
  =

  Host system is AMD64
  =

  This can be reproduced 100% of the time. Here I have the issue happening
  on Travis CI:
  =

  https://travis-ci.com/github/VDR4Arch/vdr4arch/jobs/304839747#L9944

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1869241

Title:
  svn checkout fails with E000075 "Value too large for defined data
  type"

Status in QEMU:
  New

Bug description:
  I try to autobuild for ARM7 with qemu-arm-static. Part of this is
  downloading source via SVN.

  Whenever I try to download a SVN repository I get the following
  output:

  =C2=A0=C2=A0=C2=A0=C2=A0svn: E000075: Can't read directory '...': Value t=
oo large for
  defined data type

  This is the repository I'm trying to check out:
  https://svn.baycom.de/repos/vdr-mcli-plugin/

  qemu-arm-static version is 4.2.0

  I've also tried older versions without change.

  Platform I try to emulate is armv7h (Arch Linux ARM for Raspberry Pi
  2)

  Host system is AMD64

  This can be reproduced 100% of the time. Here I have the issue
  happening on Travis CI:

  https://travis-ci.com/github/VDR4Arch/vdr4arch/jobs/304839747#L9944

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1869241/+subscriptions

