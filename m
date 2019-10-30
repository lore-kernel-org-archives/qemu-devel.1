Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE0DCA9EC7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 23:26:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD9322087E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 23:26:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD9322087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPxMK-00073x-Ut
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 19:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50355)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iPxLV-0006cI-4p
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 19:25:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iPxLT-0005HQ-L9
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 19:25:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:35988)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iPxLT-0005GH-FK
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 19:25:43 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iPxLS-00049J-5H
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2019 23:25:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 151622E80C3
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2019 23:25:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Oct 2019 23:18:21 -0000
From: Toolybird <1850000@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: gschafer xanclic
X-Launchpad-Bug-Reporter: Toolybird (gschafer)
X-Launchpad-Bug-Modifier: Toolybird (gschafer)
References: <157212805514.19102.17568097209992499457.malonedeb@wampee.canonical.com>
Message-Id: <157247750126.29843.17849896384327233818.malone@soybean.canonical.com>
Subject: [Bug 1850000] Re: 4.1.0 bogus QCOW2 corruption reported after compress
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="469f241f4e73cc0bdffa4e30654052a2af068e06";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: f3b44a1ec6ae2984d96263b6f8a2d227dc366e56
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
Reply-To: Bug 1850000 <1850000@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thank you Max.

Can confirm your patch fixes my issue (qemu-img check ...)

Not sure about those other code paths. I don't use internal snapshots
and I'm not sure under which circumstances qcow2_free_any_clusters()
gets exercised.

Just for good measure, with patch applied I created another >4GB
compressed image then booted it a few times and all seems fine.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1850000

Title:
  4.1.0 bogus QCOW2 corruption reported after compress

Status in QEMU:
  New

Bug description:
  Creating a compressed image then running `qemu-img check <..>.qcow2'
  on said image seems to report bogus corruption in some (but not all)
  cases:

  Step 1.

  # qemu-img info win7-base.qcow2
  image: win7-base.qcow2
  file format: qcow2
  virtual size: 20 GiB (21474836480 bytes)
  disk size: 12.2 GiB
  cluster_size: 65536
  Format specific information:
      compat: 1.1
      lazy refcounts: true
      refcount bits: 16
      corrupt: false

  # qemu-img check win7-base.qcow2
  No errors were found on the image.
  327680/327680 =3D 100.00% allocated, 0.00% fragmented, 0.00% compressed c=
lusters
  Image end offset: 21478375424

  Step 2.

  # qemu-img convert -f qcow2 -O qcow2 -c win7-base.qcow2 test1-z.qcow2

  Step 3.

  # qemu-img info test1-z.qcow2
  image: test1-z.qcow2
  file format: qcow2
  virtual size: 20 GiB (21474836480 bytes)
  disk size: 5.78 GiB
  cluster_size: 65536
  Format specific information:
      compat: 1.1
      lazy refcounts: false
      refcount bits: 16
      corrupt: false

  # qemu-img check test1-z.qcow2
  ERROR cluster 1191 refcount=3D1 reference=3D2
  ERROR cluster 1194 refcount=3D1 reference=3D4
  ERROR cluster 1195 refcount=3D1 reference=3D7
  ERROR cluster 1196 refcount=3D1 reference=3D7
  ERROR cluster 1197 refcount=3D1 reference=3D6
  ERROR cluster 1198 refcount=3D1 reference=3D4
  ERROR cluster 1199 refcount=3D1 reference=3D4
  ERROR cluster 1200 refcount=3D1 reference=3D5
  ERROR cluster 1201 refcount=3D1 reference=3D3
  <...> snip many errors
  Leaked cluster 94847 refcount=3D3 reference=3D0
  Leaked cluster 94848 refcount=3D3 reference=3D0
  Leaked cluster 94849 refcount=3D11 reference=3D0
  Leaked cluster 94850 refcount=3D14 reference=3D0

  20503 errors were found on the image.
  Data may be corrupted, or further writes to the image may corrupt it.

  20503 leaked clusters were found on the image.
  This means waste of disk space, but no harm to data.
  197000/327680 =3D 60.12% allocated, 89.32% fragmented, 88.50% compressed =
clusters
  Image end offset: 6216220672

  =

  The resultant image seems to work fine in a VM when used as a backing fil=
e.

  Interestingly, if I substitute a qemu-img binary from qemu-4.0 then no
  errors are reported.

  # /tmp/qemu-img check test1-z.qcow2
  No errors were found on the image.
  197000/327680 =3D 60.12% allocated, 89.32% fragmented, 88.50% compressed =
clusters
  Image end offset: 6216220672

  Is the image corrupted or not? I'm guessing not.

  Just in case it matters, this is ext4 fs on rotational disk. Latest
  Arch Linux but self compiled 4.1.0 with recent QCOW2 corruption fixes
  added.

  I haven't tried latest trunk but might do so if time permits.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1850000/+subscriptions

