Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB2DC3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 05:18:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 058A52064A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 05:18:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 058A52064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyUdO-0001O8-06
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 01:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49829)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1hyUac-0007Zx-7K
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 01:15:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hyUab-0004O3-4i
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 01:15:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:53508)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hyUaa-0004NQ-VT
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 01:15:49 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hyUaa-0004Bv-2T
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 05:15:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 0F0A42E8048
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 05:15:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Aug 2019 05:08:49 -0000
From: Thomas Huth <1738545@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: glaubitz pmaydell th-huth
X-Launchpad-Bug-Reporter: John Paul Adrian Glaubitz (glaubitz)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <151343792336.25601.1495072942778945687.malonedeb@wampee.canonical.com>
Message-Id: <156593212933.26859.14020746682777210288.malone@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19022";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: af211b63de66b0bed82a75f5ea47d214e0242bac
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

I'm marking this bug as "fix released" now since the Arm problem has
been fixed. If there is something else to do for sh4, please open a new
bug as suggested by Peter.

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1738545

Title:
  Go binaries panic with "mmap errno 9" on qemu-user

Status in QEMU:
  Fix Released

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

