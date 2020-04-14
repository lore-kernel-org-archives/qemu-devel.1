Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E11FC2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 22:41:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F18F206D5
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 22:41:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F18F206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOUFQ-0003aO-Ce
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 18:41:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41529)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jOUEi-0003Bi-Bi
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 18:40:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jOUEh-0002Ot-4A
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 18:40:56 -0400
Received: from indium.canonical.com ([91.189.90.7]:56020)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jOUEg-0002NP-Us
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 18:40:55 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jOUEf-0006Au-EL
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 22:40:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 6A50F2E80E7
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 22:40:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Apr 2020 22:32:42 -0000
From: Barnabas Viragh <1872847@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: alpha linux-user python
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: cyborgyn
X-Launchpad-Bug-Reporter: Barnabas Viragh (cyborgyn)
X-Launchpad-Bug-Modifier: Barnabas Viragh (cyborgyn)
Message-Id: <158690356239.28566.12748384831078553261.malonedeb@gac.canonical.com>
Subject: [Bug 1872847] [NEW] qemu-alpha linux-user breaks python3.6
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="2e26c9bbd21cdca248baaea29aeffb920afcc32a";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: c852ca8fcd70a29e67091cbbe6e1c78bcd479c89
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
Reply-To: Bug 1872847 <1872847@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Running on Gentoo Linux in a chroot environment:
# python3 -c 'import selectors; selectors.DefaultSelector()'
Traceback (most recent call last):
  File "<string>", line 1, in <module>
  File "/usr/lib/python3.7/selectors.py", line 349, in __init__
    self._selector =3D self._selector_cls()
OSError: [Errno 22] Invalid argument

However, on real hardware, with the same binaries there is no exception.

This impacts whole python3 based Gentoo ebuild system (package
management), and renders linux user mode alpha emulation in chroot
environment building useless, more or less.

The used systems:
# qemu-alpha --version
qemu-alpha version 4.2.0
Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers
# uname -a
Linux blackbird 5.4.28-gentoo-blackbird-06 #2 SMP Sat Apr 4 13:13:10 CEST 2=
020 x86_64 AMD Ryzen 5 3600 6-Core Processor AuthenticAMD GNU/Linux
(chroot)# python3 --version
Python 3.7.7

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: alpha linux-user python

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1872847

Title:
  qemu-alpha linux-user breaks python3.6

Status in QEMU:
  New

Bug description:
  Running on Gentoo Linux in a chroot environment:
  # python3 -c 'import selectors; selectors.DefaultSelector()'
  Traceback (most recent call last):
    File "<string>", line 1, in <module>
    File "/usr/lib/python3.7/selectors.py", line 349, in __init__
      self._selector =3D self._selector_cls()
  OSError: [Errno 22] Invalid argument

  However, on real hardware, with the same binaries there is no
  exception.

  This impacts whole python3 based Gentoo ebuild system (package
  management), and renders linux user mode alpha emulation in chroot
  environment building useless, more or less.

  The used systems:
  # qemu-alpha --version
  qemu-alpha version 4.2.0
  Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers
  # uname -a
  Linux blackbird 5.4.28-gentoo-blackbird-06 #2 SMP Sat Apr 4 13:13:10 CEST=
 2020 x86_64 AMD Ryzen 5 3600 6-Core Processor AuthenticAMD GNU/Linux
  (chroot)# python3 --version
  Python 3.7.7

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1872847/+subscriptions

