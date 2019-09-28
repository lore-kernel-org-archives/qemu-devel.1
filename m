Return-Path: <SRS0=JFFZ=XX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421F4C4360C
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2019 04:38:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FBFD2075D
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2019 04:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FBFD2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iE4VS-0006PH-6P
	for qemu-devel@archiver.kernel.org; Sat, 28 Sep 2019 00:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48485)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iE4TI-0005kv-B3
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 00:36:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iE4TD-0001ee-A1
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 00:36:37 -0400
Received: from indium.canonical.com ([91.189.90.7]:58376)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iE4TD-0001Zr-4B
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 00:36:35 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iE4TC-000677-3e
 for <qemu-devel@nongnu.org>; Sat, 28 Sep 2019 04:36:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 168012E80CC
 for <qemu-devel@nongnu.org>; Sat, 28 Sep 2019 04:36:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Sep 2019 04:17:21 -0000
From: Launchpad Bug Tracker <1010484@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Expired; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: jan-kiszka janitor marcandre-lureau zoup
X-Launchpad-Bug-Reporter: Armin ranjbar (zoup)
X-Launchpad-Bug-Modifier: Launchpad Janitor (janitor)
References: <20120608135400.14469.39467.malonedeb@gac.canonical.com>
Message-Id: <156964424118.19189.540557642186320716.malone@loganberry.canonical.com>
Subject: [Bug 1010484] Re: slirp to accept non-local dns server
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19064";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 68d645f3adbc18ad774e504a14ccdb74207ced2c
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
Reply-To: Bug 1010484 <1010484@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1010484

Title:
  slirp to accept non-local dns server

Status in QEMU:
  Expired

Bug description:
  current version of slirp doesn't allow feeded dns address to be outside o=
f given network.
  in many scenarios you need to provide dns server that isn't local.

  this simple patch removes checking for if dns server isn't in local
  subnet.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1010484/+subscriptions

