Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5ACAC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 04:27:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84440206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 04:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84440206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9ibL-0008UU-Ca
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 00:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33302)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1i9iaB-0007g6-R4
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 00:25:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1i9iaA-0004ef-Gd
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 00:25:47 -0400
Received: from indium.canonical.com ([91.189.90.7]:48174)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1i9iaA-0004eT-Bv
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 00:25:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1i9ia8-0004US-J0
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 04:25:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 8E2472E8070
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 04:25:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Sep 2019 04:17:38 -0000
From: Launchpad Bug Tracker <1835693@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Expired; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: linux-user s390x tcg
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ajbennee andrew-pennebaker janitor th-huth
X-Launchpad-Bug-Reporter: mcandre (andrew-pennebaker)
X-Launchpad-Bug-Modifier: Launchpad Janitor (janitor)
References: <156255431905.20694.13331706865581257211.malonedeb@gac.canonical.com>
Message-Id: <156860745887.25566.13580673202767029512.malone@loganberry.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19048";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 644f0238a6c65db0024d0f9484895db849a1cbd8
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1835693] Re: s390x binaries segfault
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
Reply-To: Bug 1835693 <1835693@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1835693

Title:
  s390x binaries segfault

Status in QEMU:
  Expired

Bug description:
  Hello World appears to segfault with qemu s390x, on a Debian 10.0.0
  Buster amd64 host.

  $ cat hello.cpp =

  #include <iostream>
  using std::cout;

  int main() {
      cout << "Hello World!\n";
      return 0;
  }

  $ s390x-linux-gnu-g++ -o hello hello.cpp

  $ qemu-s390x-static hello
  Segmentation fault

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1835693/+subscriptions

