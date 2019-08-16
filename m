Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA6CC3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 05:07:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D93962064A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 05:07:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D93962064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyUSS-0002EL-Ed
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 01:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48294)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1hyUQ7-0008U7-Ba
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 01:05:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hyUQ6-0004Ox-DP
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 01:04:59 -0400
Received: from indium.canonical.com ([91.189.90.7]:52098)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hyUQ6-0004OP-8G
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 01:04:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hyUQ5-0003Ve-HK
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 05:04:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 7E9D52E80C7
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 05:04:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Aug 2019 04:53:41 -0000
From: Thomas Huth <1574327@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: th-huth v-launchpad-manuelbaesler
X-Launchpad-Bug-Reporter: Manuel Baesler (v-launchpad-manuelbaesler)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20160424164231.5758.64337.malonedeb@chaenomeles.canonical.com>
Message-Id: <156593122241.22565.17101085550197487911.launchpad@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19022";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: be6dbe9bb31f52e3c9219a48f9e3132f5ffe87d5
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1574327] Re: qemu-system-x86_64 -net nic,
 model=help outputs to stderr instead of std
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
Reply-To: Bug 1574327 <1574327@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1574327

Title:
  qemu-system-x86_64 -net nic,model=3Dhelp outputs to stderr instead of
  std

Status in QEMU:
  Fix Released

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

