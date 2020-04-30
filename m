Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D64C83000
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:16:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47A7A206D9
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:16:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47A7A206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU9zd-0005gp-DC
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 10:16:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57040)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jU9wg-0007Jd-Bb
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:14:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jU9uA-0006ep-7E
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:13:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:41220)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jU9u9-0006VI-Oe
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:11:09 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jU9u8-00026p-2m
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 14:11:08 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 131492E8010
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 14:11:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Apr 2020 13:57:02 -0000
From: Laurent Vivier <Laurent@vivier.eu>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug: distribution=gentoo; sourcepackage=None; component=None;
 status=Fix Released; importance=Undecided; assignee=None; 
X-Launchpad-Bug-Tags: alpha linux-user python
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: cyborgyn laurent-vivier trofi
X-Launchpad-Bug-Reporter: Barnabas Viragh (cyborgyn)
X-Launchpad-Bug-Modifier: Laurent Vivier (laurent-vivier)
References: <158690356239.28566.12748384831078553261.malonedeb@gac.canonical.com>
Message-Id: <158825502363.14049.6385512449949322374.launchpad@gac.canonical.com>
Subject: [Bug 1872847] Re: qemu-alpha linux-user breaks python3.6
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="fbdff7602bd10fb883bf7e2ddcc7fd5a16f60398";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 33db0bb0b961334530fa7368f8a527c6917d4c27
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 09:35:36
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1872847

Title:
  qemu-alpha linux-user breaks python3.6

Status in QEMU:
  Fix Released
Status in Gentoo Linux:
  Fix Released

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

