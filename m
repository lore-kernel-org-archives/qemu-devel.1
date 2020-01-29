Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B784C33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 07:01:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6D0A2070E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 07:01:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6D0A2070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwhMK-0003KI-Tr
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 02:01:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50426)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iwhLO-0002sk-80
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 02:00:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iwhLN-0005C1-5b
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 02:00:58 -0500
Received: from indium.canonical.com ([91.189.90.7]:44004)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iwhLM-00054K-Uc
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 02:00:57 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iwhLL-0007MP-9p
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 07:00:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 47B1F2E805B
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 07:00:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jan 2020 06:52:12 -0000
From: Tobias Koch <1823790@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Confirmed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: arm linux-user
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: fritz-the-cat m-luescher pmaydell tobijk
X-Launchpad-Bug-Reporter: =?utf-8?q?Matthias_L=C3=BCscher_=28m-luescher=29?=
X-Launchpad-Bug-Modifier: Tobias Koch (tobijk)
References: <155475569461.20468.17957138207618410360.malonedeb@chaenomeles.canonical.com>
Message-Id: <158028073316.19366.664170740594000918.launchpad@gac.canonical.com>
Subject: [Bug 1823790] Re: QEMU mishandling of SO_PEERSEC forces systemd into
 tight loop
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="b8d1327fd820d6bf500589d6da587d5037c7d88e";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 148d699b6136c87cc3c3ae5fad404b1fa79e69ed
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Reply-To: Bug 1823790 <1823790@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Changed in: qemu
       Status: New =3D> Confirmed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1823790

Title:
  QEMU mishandling of SO_PEERSEC forces systemd into tight loop

Status in QEMU:
  Confirmed

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

