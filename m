Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B9FC00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 04:27:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC56720705
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 04:27:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC56720705
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip2wX-0002pM-LH
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 23:27:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47473)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1ip2uf-00018F-W0
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 23:25:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1ip2ue-00053L-PT
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 23:25:45 -0500
Received: from indium.canonical.com ([91.189.90.7]:52440)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1ip2ue-00051h-Jo
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 23:25:44 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1ip2uc-0005HF-Kn
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 04:25:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 9C6C72E8054
 for <qemu-devel@nongnu.org>; Wed,  8 Jan 2020 04:25:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jan 2020 04:17:35 -0000
From: Launchpad Bug Tracker <1851664@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Expired; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: alex-l-williamson gisena janitor th-huth
X-Launchpad-Bug-Reporter: IndrasenaReddy Gali (gisena)
X-Launchpad-Bug-Modifier: Launchpad Janitor (janitor)
References: <157313838504.19702.7205622932379991141.malonedeb@wampee.canonical.com>
Message-Id: <157845705513.10504.6200681801407490479.malone@loganberry.canonical.com>
Subject: [Bug 1851664] Re: qemu-system-x86_64: "VFIO_MAP_DMA : -28" error when
 we attache 6 VF's to guest machine
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="bceb5ef013b87ef7aafe0755545ceb689ca7ac60";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 67bb7a96b2a64c6d5b94d952ee32716a998a73ab
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
Reply-To: Bug 1851664 <1851664@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1851664

Title:
  qemu-system-x86_64: "VFIO_MAP_DMA : -28" error when we attache 6 VF's
  to guest machine

Status in QEMU:
  Expired

Bug description:
  We are trying to attach 6 VF's to the guest machine on 4.1.1 qemu emulato=
r.
  We are observing "VFIO_MAP_DMA : -28" error.

  We are using w-bits=3D48 bits while lunching VM.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1851664/+subscriptions

