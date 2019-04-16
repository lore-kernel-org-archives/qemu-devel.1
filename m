Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27499C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 07:31:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD50E20857
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 07:31:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD50E20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60638 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGIZ7-0005vo-7Y
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 03:31:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hGIYG-0005dJ-N6
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 03:30:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hGIYF-000142-Mt
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 03:30:44 -0400
Received: from indium.canonical.com ([91.189.90.7]:42004)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hGIYF-00012V-Do
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 03:30:43 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hGIYE-0002QC-3m
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 07:30:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 086752E80CC
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 07:30:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Apr 2019 07:16:46 -0000
From: Thomas Huth <1529226@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
	assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: davine-k pmaydell th-huth
X-Launchpad-Bug-Reporter: PeteVine (davine-k)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20151225114312.18411.84061.malonedeb@wampee.canonical.com>
Message-Id:
 <155539900643.8369.575534524882169330.malone@wampee.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18920";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: f6d58ece899d4a26516bfb728ad47a26519496d6
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1529226] Re: qemu-i386-user on 32-bit Linux:
 uncaught target signal 11
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
Reply-To: Bug 1529226 <1529226@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416071646.8vHjFYf2kDYLyzTn0dWP3YDg0sJvCPnt7EKmz-eqP9Y@z>

Looking through old bug tickets... can you still reproduce this issue
with the latest version of QEMU?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1529226

Title:
  qemu-i386-user on 32-bit Linux: uncaught target signal 11

Status in QEMU:
  Incomplete

Bug description:
  Even though the command I'm trying to run (a wrapper script for
  qemu-i386-user running rustc, the rust compiler)  produces the
  expected  compiled output, the build process is interrupted:

  qemu: uncaught target signal 11 (Segmentation fault) - core dumped
  i686-unknown-linux-gnu/stage0/bin/rustc: line 1:  7474 Segmentation fault=
      /usr/local/bin/qemu-i386 -cpu qemu32 /home/petevine/stage0/rustc.bin =
-C target-cpu=3Dpentium2 -L /home/petevine/unpacked/rust-master/i686-unknow=
n-linux-gnu/stage0/lib/rustlib/i686-unknown-linux-gnu/lib/ "$@"
  make: *** [i686-unknown-linux-gnu/stage0/lib/rustlib/i686-unknown-linux-g=
nu/lib/stamp.rustc_back] Error 139

  The stamp file is not being created so this could be about forking
  bash after finishing the wrapper script.

  Qemu was compiled from the latest git source.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1529226/+subscriptions

