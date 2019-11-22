Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NUMERIC_HTTP_ADDR,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17A7C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 15:12:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4B512071B
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 15:12:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4B512071B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYAcA-0001Bn-UN
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 10:12:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39914)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iYAaE-0007Sw-J7
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 10:10:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iYAaD-0001Sv-9S
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 10:10:54 -0500
Received: from indium.canonical.com ([91.189.90.7]:54372)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iYAaD-0001S6-33
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 10:10:53 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iYAaB-00080M-Mx
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 15:10:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id A75822E8070
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 15:10:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 Nov 2019 14:56:30 -0000
From: Ubuntu SRU Bot <1848556@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
 status=Fix Released; importance=Medium;
 assignee=christian.ehrhardt@canonical.com; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=eoan; sourcepackage=qemu;
 component=main; status=Fix Committed; importance=Medium;
 assignee=christian.ehrhardt@canonical.com; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=focal; sourcepackage=qemu; 
 component=main; status=Fix Released; importance=Medium;
 assignee=christian.ehrhardt@canonical.com; 
X-Launchpad-Bug-Tags: verification-needed verification-needed-eoan
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: janitor paelzer rodsmith tjaalton ubuntu-sru-bot
 xanclic
X-Launchpad-Bug-Reporter: Rod Smith (rodsmith)
X-Launchpad-Bug-Modifier: Ubuntu SRU Bot (ubuntu-sru-bot)
References: <157133449178.19203.719001918774596241.malonedeb@gac.canonical.com>
Message-Id: <20191122145630.0CDD7240348@snakefruit.canonical.com>
Subject: [Bug 1848556] Autopkgtest regression report
 (qemu/1:4.0+dfsg-0ubuntu9.2)
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="c597c3229eb023b1e626162d5947141bf7befb13";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 979e4042608f3665b8eea3b5446265836e267b3b
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Reply-To: Bug 1848556 <1848556@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All autopkgtests for the newly accepted qemu (1:4.0+dfsg-0ubuntu9.2) for eo=
an have finished running.
The following regressions have been reported in tests triggered by the pack=
age:

ganeti/2.16.0-5ubuntu1 (ppc64el)


Please visit the excuses page listed below and investigate the failures, pr=
oceeding afterwards as per the StableReleaseUpdates policy regarding autopk=
gtest regressions [1].

https://people.canonical.com/~ubuntu-archive/proposed-
migration/eoan/update_excuses.html#qemu

[1] https://wiki.ubuntu.com/StableReleaseUpdates#Autopkgtest_Regressions

Thank you!

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1848556

Title:
  qemu-img check failing on remote image in Eoan

Status in QEMU:
  Fix Released
Status in qemu package in Ubuntu:
  Fix Released
Status in qemu source package in Eoan:
  Fix Committed
Status in qemu source package in Focal:
  Fix Released

Bug description:
  Ubuntu SRU Template:

  [Impact]

   * There is fallout due to changes in libcurl that affect qemu and might =

     lead to a hang.

   * Fix by backporting the upstream fix

  [Test Case]

   * If you have network just run
     $ qemu-img check http://10.193.37.117/cloud/eoan-server-cloudimg-amd64=
.img

   * Without network, install apache2, and get a complex qemu file (like a =

     cloud image) onto the system. Then access the file via apache http but =

     not localhost (that would work)

  [Regression Potential]

   * The change is local to the libcurl usage of qemu, so that could be =

     affected. But then this is what has been found to not work here, so I'=
d =

     expect not too much trouble. But if so then in the curl usage (which =

     means disks on http)

  [Other Info]
   =

   * n/a

  ---

  The "qemu-img check" function is failing on remote (HTTP-hosted)
  images, beginning with Ubuntu 19.10 (qemu-utils version 1:4.0+dfsg-
  0ubuntu9). With previous versions, through Ubuntu 19.04/qemu-utils
  version 1:3.1+dfsg-2ubuntu3.5, the following worked:

  $ /usr/bin/qemu-img check  http://10.193.37.117/cloud/eoan-server-cloudim=
g-amd64.img
  No errors were found on the image.
  19778/36032 =3D 54.89% allocated, 90.34% fragmented, 89.90% compressed cl=
usters
  Image end offset: 514064384

  The 10.193.37.117 server holds an Apache server that hosts the cloud
  images on a LAN. Beginning with Ubuntu 19.10/qemu-utils 1:4.0+dfsg-
  0ubuntu9, the same command never returns. (I've left it for up to an
  hour with no change.) I'm able to wget the image from the same server
  and installation on which qemu-img check fails. I've tried several
  .img files on the server, ranging from Bionic to Eoan, with the same
  results with all of them.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1848556/+subscriptions

