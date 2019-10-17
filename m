Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NUMERIC_HTTP_ADDR,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273F9ECE58D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 20:28:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4F3220872
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 20:28:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4F3220872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLCNu-0005EK-2r
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 16:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56040)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iLA5E-0006wM-1y
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 14:01:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iLA5C-0002iw-Ec
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 14:01:07 -0400
Received: from indium.canonical.com ([91.189.90.7]:35868)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iLA5C-0002ih-6a
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 14:01:06 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iLA59-0003uW-NU
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 18:01:03 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id B068A2E802D
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 18:01:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Oct 2019 17:48:11 -0000
From: Rod Smith <rod.smith@canonical.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: rodsmith
X-Launchpad-Bug-Reporter: Rod Smith (rodsmith)
X-Launchpad-Bug-Modifier: Rod Smith (rodsmith)
Message-Id: <157133449178.19203.719001918774596241.malonedeb@gac.canonical.com>
Subject: [Bug 1848556] [NEW] qemu-img check failing on remote image in Eoan
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="186023fa645d8be19d403a76064f0643f510db2f";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 780f2387557a03a34627d92382286cd7877f532b
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 91.189.90.7
X-Mailman-Approved-At: Thu, 17 Oct 2019 16:27:02 -0400
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

Public bug reported:

The "qemu-img check" function is failing on remote (HTTP-hosted) images,
beginning with Ubuntu 19.10 (qemu-utils version 1:4.0+dfsg-0ubuntu9).
With previous versions, through Ubuntu 19.04/qemu-utils version 1:3.1
+dfsg-2ubuntu3.5, the following worked:

$ /usr/bin/qemu-img check  http://10.193.37.117/cloud/eoan-server-cloudimg-=
amd64.img
No errors were found on the image.
19778/36032 =3D 54.89% allocated, 90.34% fragmented, 89.90% compressed clus=
ters
Image end offset: 514064384

The 10.193.37.117 server holds an Apache server that hosts the cloud
images on a LAN. Beginning with Ubuntu 19.10/qemu-utils 1:4.0+dfsg-
0ubuntu9, the same command never returns. (I've left it for up to an
hour with no change.) I'm able to wget the image from the same server
and installation on which qemu-img check fails. I've tried several .img
files on the server, ranging from Bionic to Eoan, with the same results
with all of them.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1848556

Title:
  qemu-img check failing on remote image in Eoan

Status in QEMU:
  New

Bug description:
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

