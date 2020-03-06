Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9580BC10F25
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 09:21:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ACA320848
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 09:21:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ACA320848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jA9B5-0004dU-Gh
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 04:21:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41875)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jA9AB-0003l3-QD
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 04:21:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jA9AA-0002E7-KI
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 04:20:59 -0500
Received: from indium.canonical.com ([91.189.90.7]:34244)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jA9AA-00024g-Ea
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 04:20:58 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jA9A7-0003hY-OP
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 09:20:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 082A12E80D3
 for <qemu-devel@nongnu.org>; Fri,  6 Mar 2020 09:20:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Mar 2020 09:09:31 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1860056@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: mips
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: amarkovic andrew-pennebaker
X-Launchpad-Bug-Reporter: mcandre (andrew-pennebaker)
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
References: <157922250983.5290.10201589814072308267.malonedeb@wampee.canonical.com>
Message-Id: <158348577264.11731.10683951416138736283.launchpad@wampee.canonical.com>
Subject: [Bug 1860056] Re: mips binaries segfault
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e0878392dc799b267dea80578fa65500a5d74155";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 22c70335a881231ff18589acebcd562573e24c47
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
Reply-To: Bug 1860056 <1860056@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1860056

Title:
  mips binaries segfault

Status in QEMU:
  Incomplete

Bug description:
  Hello World appears to segfault with qemu mips, on a Debian 10.0.0
  Buster amd64 host.

  Example:

  =

  $ cat mips/test/hello.cpp =

  #include <iostream>
  using std::cout;

  int main() {
      cout << "Hello World!\n";
      return 0;
  }

  $ mips-linux-gnu-g++ -o hello hello.cpp && ./hello
  qemu: uncaught target signal 11 (Segmentation fault) - core dumped

  Note that 64-bit MIPS and little endian 32-bit MIPS qemu work fine.
  The problem is limited to big endian 32-bit MIPS.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1860056/+subscriptions

