Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA33C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 11:41:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08F7E21BF6
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 11:41:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08F7E21BF6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvKK0-0003sl-Fw
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 07:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56764)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hvKJa-0003Sp-PJ
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 07:41:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hvKJZ-0006QS-OS
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 07:41:10 -0400
Received: from indium.canonical.com ([91.189.90.7]:37990)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hvKJZ-0006PF-JY
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 07:41:09 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hvKJY-0001rL-7A
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 11:41:08 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 3519C2E806F
 for <qemu-devel@nongnu.org>; Wed,  7 Aug 2019 11:41:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Aug 2019 11:32:58 -0000
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Committed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: glaubitz pmaydell
X-Launchpad-Bug-Reporter: John Paul Adrian Glaubitz (glaubitz)
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
References: <151343792336.25601.1495072942778945687.malonedeb@wampee.canonical.com>
Message-Id: <156517757828.618.901169621091815934.malone@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19015";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 2e9dfc179e0e611535edc564368b67a7200872c1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1738545] Re: Go binaries panic with "mmap errno
 9" on qemu-user
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
Reply-To: Bug 1738545 <1738545@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Could you file a separate bug for the sh4 case, then, please (with repro
instructions)?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1738545

Title:
  Go binaries panic with "mmap errno 9" on qemu-user

Status in QEMU:
  Fix Committed

Bug description:
  Go binaries panic with "mmap errno 9" on qemu-user.

  root@nofan:/# cat hello.go =

  package main

  import "fmt"

  func main() {
      fmt.Println("hello world")
  }
  root@nofan:/# gccgo-7 hello.go -o hello
  root@nofan:/# ./hello =

  mmap errno 9
  fatal error: mmap

  runtime stack:
  mmap errno 9
  fatal error: mmap
  panic during panic

  runtime stack:
  mmap errno 9
  fatal error: mmap
  stack trace unavailable
  root@nofan:/#

  Tested with qemu from git master with Debian unstable for armel.

  Same binaries work fine on real hardware.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1738545/+subscriptions

