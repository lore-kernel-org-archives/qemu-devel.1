Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE6DC43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 14:22:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A03762073C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 14:22:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A03762073C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icVXX-0006D2-PZ
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 09:22:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42770)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1icVWq-0005oU-Nm
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 09:21:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1icVWp-0004yB-9g
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 09:21:20 -0500
Received: from indium.canonical.com ([91.189.90.7]:33482)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1icVWp-0004xq-4S
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 09:21:19 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1icVWn-0003Xa-H5
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 14:21:17 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 8044F2E80C7
 for <qemu-devel@nongnu.org>; Wed,  4 Dec 2019 14:21:17 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Dec 2019 14:06:43 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1852196@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=In Progress; importance=Undecided;
 assignee=philmd@redhat.com; 
X-Launchpad-Bug-Tags: feature-request
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: lersek philmd
X-Launchpad-Bug-Reporter: Laszlo Ersek (Red Hat) (lersek)
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
References: <157355353271.7205.5763587027166419396.malonedeb@gac.canonical.com>
Message-Id: <157546840618.22256.8254225462619747794.launchpad@chaenomeles.canonical.com>
Subject: [Bug 1852196] Re: update edk2 submodule & binaries to
 edk2-stable201911
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="c597c3229eb023b1e626162d5947141bf7befb13";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 494c0d762835b0ef47d6046c24df235e1479ad33
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
Reply-To: Bug 1852196 <1852196@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Changed in: qemu
     Assignee: Laszlo Ersek (Red Hat) (lersek) =3D> Philippe Mathieu-Daud=
=C3=A9 (philmd)

** Changed in: qemu
       Status: New =3D> In Progress

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1852196

Title:
  update edk2 submodule & binaries to edk2-stable201911

Status in QEMU:
  In Progress

Bug description:
  edk2-stable201911 will be tagged soon:

    https://github.com/tianocore/tianocore.github.io/wiki/EDK-II-
  Release-Planning

    https://github.com/tianocore/edk2/releases/tag/edk2-stable201911
    [upcoming link]

  It should be picked up by QEMU, after the v4.2.0 release.

  Relevant fixes / features in edk2, since edk2-stable201905 (which is
  what QEMU bundles at the moment, from LP#1831477):

  - enable UEFI HTTPS Boot in ArmVirtQemu* platforms
    https://bugzilla.tianocore.org/show_bug.cgi?id=3D1009
    (this is from edk2-stable201908)

  - fix CVE-2019-14553 (Invalid server certificate accepted in HTTPS Boot)
    https://bugzilla.tianocore.org/show_bug.cgi?id=3D960

  - consume OpenSSL-1.1.1d, for fixing CVE-2019-1543, CVE-2019-1552 and
    CVE-2019-1563
    https://bugzilla.tianocore.org/show_bug.cgi?id=3D2226

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1852196/+subscriptions

