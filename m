Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00B9C04AA8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 19:32:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92F8F21743
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 19:32:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92F8F21743
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52285 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLYUF-0000vR-Nb
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 15:32:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hLYSk-0008FE-JM
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 15:30:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hLYSj-00089z-GV
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 15:30:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:45314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hLYSj-00089Z-Av
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 15:30:45 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hLYSi-0005Px-4O
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 19:30:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0DE322E8079
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 19:30:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Apr 2019 19:22:14 -0000
From: Thomas Huth <1634726@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
	assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: edward-vielmetti pmaydell th-huth
X-Launchpad-Bug-Reporter: Edward Vielmetti (edward-vielmetti)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20161019021427.23110.23706.malonedeb@soybean.canonical.com>
Message-Id:
 <155665213466.16809.16731790246220587035.malone@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18928";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 0a533d6f4029463f8c494f4da03953d99dc1b70f
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1634726] Re: qemu "make test" fails in iov.c with
 "undefined reference" on aarch64 on Ubuntu 16.04
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1634726 <1634726@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430192214.4CJ5m5ys4dnnmZ0LdsDDB33oiNSsUnVMyEQzD_ZIgK8@z>

"make test" has been removed, so I'll mark this as fixed now.

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1634726

Title:
  qemu "make test" fails in iov.c with "undefined reference" on aarch64
  on Ubuntu 16.04

Status in QEMU:
  Fix Released

Bug description:
  I'm building the master tree on a multicore ARMv8 machine running
  Ubuntu 16.04. The build worked just fine, using the simple directions
  in the README file and "make -j 64" to do the build.

  Next, I did "make test", and got this:

  emv@armv8hello:~/src/qemu/qemu/build$ make test
  make -C tests/tcg test
  make[1]: Entering directory '/mnt/src/qemu/qemu/build/tests/tcg'
    CC      test_path.o
    LINK    test_path
  test_path.o: In function `qemu_iovec_is_zero':
  /home/emv/src/qemu/qemu/util/iov.c:365: undefined reference to `buffer_is=
_zero'
  collect2: error: ld returned 1 exit status
  /home/emv/src/qemu/qemu/rules.mak:105: recipe for target 'test_path' fail=
ed
  make[1]: *** [test_path] Error 1
  make[1]: Leaving directory '/mnt/src/qemu/qemu/build/tests/tcg'
  Makefile:498: recipe for target 'test' failed
  make: *** [test] Error 2

  I expected "make test" to complete with no errors.

  uname -a:
  Linux armv8hello.local.lan 4.4.0-38-generic #57-Ubuntu SMP Wed Sep 7 10:1=
9:14 UTC 2016 aarch64 aarch64 aarch64 GNU/Linux

  emv@armv8hello:~/src/qemu/qemu$ more VERSION =

  2.7.50

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1634726/+subscriptions

