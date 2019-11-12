Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61994C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 10:21:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 363032196E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 10:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 363032196E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUTIS-0008Hj-Ee
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 05:21:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55811)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iUTHr-0007rl-AF
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 05:20:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iUTHq-000549-0y
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 05:20:39 -0500
Received: from indium.canonical.com ([91.189.90.7]:52064)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iUTHp-00053W-Qz
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 05:20:37 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iUTHn-00050F-UA
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 10:20:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id DD30E2E80C0
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 10:20:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 Nov 2019 10:12:12 -0000
From: "Laszlo Ersek \(Red Hat\)" <lersek@redhat.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided;
 assignee=lersek@redhat.com; 
X-Launchpad-Bug-Tags: feature-request
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: lersek
X-Launchpad-Bug-Reporter: Laszlo Ersek (Red Hat) (lersek)
X-Launchpad-Bug-Modifier: Laszlo Ersek (Red Hat) (lersek)
Message-Id: <157355353271.7205.5763587027166419396.malonedeb@gac.canonical.com>
Subject: [Bug 1852196] [NEW] update edk2 submodule & binaries to
 edk2-stable201911
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="c597c3229eb023b1e626162d5947141bf7befb13";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 5d59ca94ec0a1fb290c48770f2fb241fa11155ec
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

Public bug reported:

edk2-stable201911 will be tagged soon:

  https://github.com/tianocore/tianocore.github.io/wiki/EDK-II-Release-
Planning

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

** Affects: qemu
     Importance: Undecided
     Assignee: Laszlo Ersek (Red Hat) (lersek)
         Status: New


** Tags: feature-request

** Changed in: qemu
     Assignee: (unassigned) =3D> Laszlo Ersek (Red Hat) (lersek)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1852196

Title:
  update edk2 submodule & binaries to edk2-stable201911

Status in QEMU:
  New

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

