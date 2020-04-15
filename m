Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1DBC2BA2B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 07:01:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D00D20768
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 07:01:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D00D20768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOc3Q-0006AO-OX
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 03:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43447)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jOc2W-0005Bk-7k
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:00:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jOc2U-0002j4-RR
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:00:52 -0400
Received: from indium.canonical.com ([91.189.90.7]:37386)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jOc2U-0002ii-MT
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:00:50 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jOc2S-0008Tb-Dj
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 07:00:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 64D7E2E8029
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 07:00:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Apr 2020 06:46:38 -0000
From: Laurent Vivier <Laurent@vivier.eu>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: alpha linux-user python
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: cyborgyn laurent-vivier
X-Launchpad-Bug-Reporter: Barnabas Viragh (cyborgyn)
X-Launchpad-Bug-Modifier: Laurent Vivier (laurent-vivier)
References: <158690356239.28566.12748384831078553261.malonedeb@gac.canonical.com>
Message-Id: <158693319901.27729.4593993236862002055.malone@gac.canonical.com>
Subject: [Bug 1872847] Re: qemu-alpha linux-user breaks python3.6
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="2e26c9bbd21cdca248baaea29aeffb920afcc32a";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 07c6faab3b3d090346de520f8171ac006e1ea5e1
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

Hi,

do you know if it works with previous version of qemu?
Do you know if it works with qemu built from git repo?

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

