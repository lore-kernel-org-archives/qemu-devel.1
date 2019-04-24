Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6F8C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 06:26:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C2E3218DA
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 06:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C2E3218DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36634 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJBMn-0004qN-FJ
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 02:26:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJBH3-0008Ii-NM
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 02:20:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJBH2-00019c-Ko
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 02:20:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:44384)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hJBH2-00017n-Eh
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 02:20:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hJBH1-0007nD-Ku
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 06:20:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9C40A2E80C9
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 06:20:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Apr 2019 06:11:54 -0000
From: Thomas Huth <1798659@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
	assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: orenmn pmaydell th-huth
X-Launchpad-Bug-Reporter: Oren Milman (orenmn)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <153989027444.15424.224613242357516969.malonedeb@gac.canonical.com>
Message-Id:
 <155608631514.13880.11850226665415342118.launchpad@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18928";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 737496503a7b20ea5f3f3f269e12a45b35a753e7
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1798659] Re: Replace comma with semicolon in
 trace/simple.c
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
Reply-To: Bug 1798659 <1798659@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424061154.wi0mOtwXJtQJyGwSQlC4i0JUFZbxSCPlCVm-nC3PEzo@z>

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1798659

Title:
  Replace comma with semicolon in trace/simple.c

Status in QEMU:
  Fix Released

Bug description:
  In the master branch in trace/simple.c in writeout_thread (https://github=
.com/qemu/qemu/blob/master/trace/simple.c#L174) we currently have:
    dropped.rec.length =3D sizeof(TraceRecord) + sizeof(uint64_t),
    dropped.rec.pid =3D trace_pid;

  It seems to me like a typo that the first line ends with a comma.
  Currently this causes no harm, but I think this should be fixed.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1798659/+subscriptions

