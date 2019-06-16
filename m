Return-Path: <SRS0=kfsH=UP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DD6C31E49
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 04:32:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 705062084D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 04:32:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 705062084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37586 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcMpr-0001wS-Mo
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 00:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50891)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hcMni-0000p8-Nu
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 00:29:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hcMng-0003q0-Rq
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 00:29:54 -0400
Received: from indium.canonical.com ([91.189.90.7]:42802)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hcMng-0003m0-MK
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 00:29:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hcMnb-0008Gv-O1
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2019 04:29:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id B27D82E80CC
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2019 04:29:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 16 Jun 2019 04:17:26 -0000
From: Launchpad Bug Tracker <1529226@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Expired; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: davine-k janitor pmaydell th-huth
X-Launchpad-Bug-Reporter: PeteVine (davine-k)
X-Launchpad-Bug-Modifier: Launchpad Janitor (janitor)
References: <20151225114312.18411.84061.malonedeb@wampee.canonical.com>
Message-Id: <156065864659.14650.5471122738605372540.malone@loganberry.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18981";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: d7ba3f8fb9121d866b36b38bb9ab37db942e37dc
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1529226] Re: qemu-i386-user on 32-bit Linux:
 uncaught target signal 11
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
Reply-To: Bug 1529226 <1529226@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1529226

Title:
  qemu-i386-user on 32-bit Linux: uncaught target signal 11

Status in QEMU:
  Expired

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

