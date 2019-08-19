Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A90C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 18:11:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 306B62087E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 18:11:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 306B62087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzm7y-0004Tb-EJ
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 14:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54869)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1hzm7E-0003ei-P3
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 14:10:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hzm7D-0004NY-Gm
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 14:10:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:52130)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hzm7D-0004NC-BD
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 14:10:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hzm7B-0004nT-U9
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 18:10:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id DE8E32E80CC
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 18:10:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Aug 2019 17:55:50 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1819289@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: cbparker curryrice71 philmd
X-Launchpad-Bug-Reporter: John M (curryrice71)
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
References: <155216177409.9624.16357609956497374456.malonedeb@gac.canonical.com>
Message-Id: <156623735058.22999.5452030542189411929.malone@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19022";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 9a9c095989f5006fd881d0b5cbba17906a01dbda
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1819289] Re: Windows 95 and Windows 98 will not
 install or run
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
Reply-To: Bug 1819289 <1819289@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/19/19 7:26 PM, Brad Parker wrote:
> Whoops, 3.11.0 does not exist. Went back and did a full bisect. 3.0.0
> works fine, and the breakage starts before 3.0.1 and 3.1.0 was released,
> specifically, with commit 05306935b1ae49107c2dc2f301574dd6c29b6838.

This commit is migration related. Are you trying to restore/launch a
pre-installed image?

John reported "either not install or will not run 95 or 98 at all" but
you report "95 just reboots infinitely after trying to boot from HDD
after the initial setup." which is slighly different.

What host/os/distrib are you using?

What command line are you using to start QEMU?

If you are using migration, I wonder if the following commit might
affect here:

commit 341ba0df4c69269cac839ddbacb2a0ca641a856d
Author: Peter Maydell <peter.maydell@linaro.org>
Date:   Tue Sep 25 17:19:24 2018 +0100

    migration/ram.c: Avoid taking address of fields in packed MultiFDInit_t=
 struct
    =

    Taking the address of a field in a packed struct is a bad idea, because
    it might not be actually aligned enough for that pointer type (and
    thus cause a crash on dereference on some host architectures). Newer
    versions of clang warn about this:
    =

    Avoid the bug by not using the "modify in place" byteswapping
    functions.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1819289

Title:
  Windows 95 and Windows 98 will not install or run

Status in QEMU:
  New

Bug description:
  The last version of QEMU I have been able to run Windows 95 or Windows
  98 on was 2.7 or 2.8. Recent versions since then even up to 3.1 will
  either not install or will not run 95 or 98 at all. I have tried every
  combination of options like isapc or no isapc, cpu pentium  or cpu as
  486. Tried different memory configurations, but they just don't work
  anymore.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1819289/+subscriptions

