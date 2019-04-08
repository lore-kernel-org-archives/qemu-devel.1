Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A62C10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 20:41:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A00C20857
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 20:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A00C20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58700 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDb5H-000102-2P
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 16:41:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hDb4S-0000bv-3O
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 16:40:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hDb4Q-0002J2-3m
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 16:40:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:59292)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hDb4M-0002Hp-A8
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 16:40:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hDb4K-0000BZ-TI
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 20:40:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D51822E80C9
	for <qemu-devel@nongnu.org>; Mon,  8 Apr 2019 20:40:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Apr 2019 20:34:54 -0000
From: =?utf-8?q?Matthias_L=C3=BCscher?= <1823790@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: m-luescher
X-Launchpad-Bug-Reporter: =?utf-8?q?Matthias_L=C3=BCscher_=28m-luescher=29?=
X-Launchpad-Bug-Modifier: =?utf-8?q?Matthias_L=C3=BCscher_=28m-luescher=29?=
Message-Id:
 <155475569461.20468.17957138207618410360.malonedeb@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18920";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 20962a2a353686e572db3056512f20644dd478db
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1823790] [NEW] QEMU forces systemd into tight loop
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
Reply-To: Bug 1823790 <1823790@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408203454.43BH00Ydga5lUSuSklTZCVYbymt9u_DEZywvOAecxVc@z>

Public bug reported:

While building Debian images for embedded ARM target systems I detected
that QEMU seems to force newer systemd daemons into a tight loop.

My setup is the following:

Host machine: Ubuntu 18.04, amd64
LXD container: Debian Buster, arm64, systemd 241
QEMU: qemu-aarch64-static, 4.0.0-rc2 (custom build) and 3.1.0 (Debian 1:3.1=
+dfsg-7)

To easily reproduce the issue I have created the following repository:
https://github.com/lueschem/edi-qemu

The call where systemd gets looping is the following:
2837 getsockopt(3,1,31,274891889456,274887218756,274888927920) =3D -1 errno=
=3D34 (Numerical result out of range)

Furthermore I also verified that the issue is not related to LXD.
The same behavior can be reproduced using systemd-nspawn.

This issue reported against systemd seems to be related:
https://github.com/systemd/systemd/issues/11557

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1823790

Title:
  QEMU forces systemd into tight loop

Status in QEMU:
  New

Bug description:
  While building Debian images for embedded ARM target systems I
  detected that QEMU seems to force newer systemd daemons into a tight
  loop.

  My setup is the following:

  Host machine: Ubuntu 18.04, amd64
  LXD container: Debian Buster, arm64, systemd 241
  QEMU: qemu-aarch64-static, 4.0.0-rc2 (custom build) and 3.1.0 (Debian 1:3=
.1+dfsg-7)

  To easily reproduce the issue I have created the following repository:
  https://github.com/lueschem/edi-qemu

  The call where systemd gets looping is the following:
  2837 getsockopt(3,1,31,274891889456,274887218756,274888927920) =3D -1 err=
no=3D34 (Numerical result out of range)

  Furthermore I also verified that the issue is not related to LXD.
  The same behavior can be reproduced using systemd-nspawn.

  This issue reported against systemd seems to be related:
  https://github.com/systemd/systemd/issues/11557

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1823790/+subscriptions

