Return-Path: <SRS0=nktx=5V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76DCC2BA15
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2020 02:11:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AC4020672
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2020 02:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AC4020672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKukx-0007G3-O3
	for qemu-devel@archiver.kernel.org; Sat, 04 Apr 2020 22:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58332)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jKukP-0006qE-NY
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 22:10:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jKukO-0000Zy-Dh
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 22:10:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:32970)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jKukO-0000ZK-8O
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 22:10:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jKukM-0006uO-Bv
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2020 02:10:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 584462E80E7
 for <qemu-devel@nongnu.org>; Sun,  5 Apr 2020 02:10:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Apr 2020 02:04:59 -0000
From: Chad Kennedy <1826175@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: avladu berrange chadkennedyonline fonthime
 pmaydell th-huth
X-Launchpad-Bug-Reporter: Gwendolyn Haller (fonthime)
X-Launchpad-Bug-Modifier: Chad Kennedy (chadkennedyonline)
References: <155609955691.16667.3366200166619949036.malonedeb@soybean.canonical.com>
Message-Id: <158605230006.22377.6285180775740448805.malone@wampee.canonical.com>
Subject: [Bug 1826175] Re: Compilation on MSYS2/MinGW-w64 fails with error:
 "No rule to make target capstone.lib"
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a296f04231dee355be5db73cc878b9e21689a253";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: a226a14ca22c9cf21083d9ad21631fcfb310ff2e
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
Reply-To: Bug 1826175 <1826175@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I am still running into this issue when compiling QEMU on Windows using
MSYS2. I can manually apply the fix per the Capstone commit above and
compile just fine.

For moving forward, how should this be handled in the codebase to get
the MSYS2 build cleanly working? I imagine wholesale pulling the latest
Capstone may break quite a bit. Is it possible to cherry-pick this one
change into the submodule?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1826175

Title:
  Compilation on MSYS2/MinGW-w64 fails with error: "No rule to make
  target capstone.lib"

Status in QEMU:
  New

Bug description:
  I submitted this bug to Capstone directly but I figured it'd be useful
  to post it here too. The IS_MINGW check in the Makefile for Capstone
  fails under MSYS2 MinGW-w64 because cc --version doesn't have mingw in
  the output anymore:

  $ whereis cc
  cc: /mingw64/bin/cc.exe

  $ cc --version
  cc.exe (Rev2, Built by MSYS2 project) 8.3.0
  Copyright (C) 2018 Free Software Foundation, Inc.
  This is free software; see the source for copying conditions.  There is NO
  warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOS=
E.

  Really simple patch:

  diff --git "a/Makefile" "b/Makefile"
  index 063f50db..1d9f042e 100644
  --- "a/Makefile"
  +++ "b/Makefile"
  @@ -288,7 +288,7 @@ CFLAGS :=3D $(CFLAGS:-fPIC=3D)
   # On Windows we need the shared library to be executable
   else
   # mingw?
  -IS_MINGW :=3D $(shell $(CC) --version | grep -i mingw | wc -l)
  +IS_MINGW :=3D $(shell $(CC) --version | grep -i msys2 | wc -l)
   ifeq ($(IS_MINGW),1)
   EXT =3D dll
   AR_EXT =3D lib

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1826175/+subscriptions

