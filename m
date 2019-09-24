Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046FFC432C2
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 13:37:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC13620872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 13:37:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC13620872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cloudbasesolutions.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCl0d-0006Vv-Uw
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 09:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39173)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iCidi-00087R-By
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 07:05:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iCidh-0001nG-7Q
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 07:05:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:48504)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iCidh-0001mh-27
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 07:05:49 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iCidf-00060P-MT
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 11:05:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 9DE532E8019
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 11:05:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Sep 2019 10:56:53 -0000
From: Adrian Vladu <avladu@cloudbasesolutions.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: avladu berrange fonthime pmaydell th-huth
X-Launchpad-Bug-Reporter: Gwendolyn Haller (fonthime)
X-Launchpad-Bug-Modifier: Adrian Vladu (avladu)
References: <155609955691.16667.3366200166619949036.malonedeb@soybean.canonical.com>
Message-Id: <156932261321.27303.8940310087786694778.malone@soybean.canonical.com>
Subject: [Bug 1826175] Re: Compilation on MSYS2/MinGW-w64 fails with error:
 "No rule to make target capstone.lib"
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19048";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 695895335a3d182cd82b7e6288ccd961c4909b40
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
X-Mailman-Approved-At: Tue, 24 Sep 2019 09:10:43 -0400
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

The fix in upstream capstone has been merged:
https://github.com/aquynh/capstone/commit/29893c63e34ee21846744d02c396ae3c8=
01b936b

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

