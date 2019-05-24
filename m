Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E85CC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 17:40:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E683B21773
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 17:40:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E683B21773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58040 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUEB7-0006r2-8F
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 13:40:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hUEAM-0006a5-FR
	for qemu-devel@nongnu.org; Fri, 24 May 2019 13:39:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hUEAL-0004yZ-DX
	for qemu-devel@nongnu.org; Fri, 24 May 2019 13:39:38 -0400
Received: from indium.canonical.com ([91.189.90.7]:58598)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hUEAJ-0004wN-IG
	for qemu-devel@nongnu.org; Fri, 24 May 2019 13:39:36 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hUEAG-0005As-Gx
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 17:39:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7513C2E807C
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 17:39:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 May 2019 17:27:07 -0000
From: Thomas Huth <1574327@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Committed; importance=Undecided;
	assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: th-huth v-launchpad-manuelbaesler
X-Launchpad-Bug-Reporter: Manuel Baesler (v-launchpad-manuelbaesler)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20160424164231.5758.64337.malonedeb@chaenomeles.canonical.com>
Message-Id: <155871882756.8234.1435680112395740900.malone@wampee.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18968";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 6160c5e0bb9462b2ceb4225478da790d8598a9aa
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1574327] Re: qemu-system-x86_64 -net nic,
 model=help outputs to stderr instead of std
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
Reply-To: Bug 1574327 <1574327@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Finally fixed here:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D7b71e03af98fd7b5e1

** Changed in: qemu
       Status: New =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1574327

Title:
  qemu-system-x86_64 -net nic,model=3Dhelp outputs to stderr instead of
  std

Status in QEMU:
  Fix Committed

Bug description:
  qemu-system-x86_64 -net nic,model=3Dhelp

  output comes to stderr instead of std

  =

  qemu-system-x86_64 -net nic,model=3Dhelp  -> stdout
  qemu-system-x86_64 -machine help -> stdout
  qemu-system-x86_64 -cpu help -> stdout

  as of
  https://github.com/qemu/qemu/blob/044d65525f6ac2093042ae18dbf8c1300b5c1c1=
8/net/net.c#L831

  I run qemu 2.5 on x86_64

  kind regards

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1574327/+subscriptions

