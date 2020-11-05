Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C1EC4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 04:26:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C650A2067B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 04:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C650A2067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaWrE-00073t-G9
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 23:26:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kaWqM-0005XZ-NJ
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 23:25:50 -0500
Received: from indium.canonical.com ([91.189.90.7]:38130)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kaWqI-0000C4-HR
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 23:25:50 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kaWqH-0002rR-9W
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 04:25:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 4302D2E811E
 for <qemu-devel@nongnu.org>; Thu,  5 Nov 2020 04:25:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2020 04:17:21 -0000
From: Launchpad Bug Tracker <1712818@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Expired; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: eblake janitor meeho schu-schu th-huth
X-Launchpad-Bug-Reporter: meeho yuen (meeho)
X-Launchpad-Bug-Modifier: Launchpad Janitor (janitor)
References: <150357954932.16920.8202218494274187188.malonedeb@gac.canonical.com>
Message-Id: <160454984183.10129.11153655809108897733.malone@loganberry.canonical.com>
Subject: [Bug 1712818] Re: live migration with storage encounter
 assert(!(bs->open_flags & BDRV_O_INACTIVE)) crashes
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e39939c02bd86af4202bc6e2123a7708215ec8ea"; Instance="production"
X-Launchpad-Hash: 6d9798614c53bfbdcb065921979c22c1779dc409
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 21:30:42
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Reply-To: Bug 1712818 <1712818@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1712818

Title:
  live migration with storage encounter assert(!(bs->open_flags &
  BDRV_O_INACTIVE)) crashes

Status in QEMU:
  Expired

Bug description:
  The vm guest runs a iotest program, and i migrate it with virsh
  --copy-storage-all,then the qemu process on the source host happens to
  crash with the following message:

  kvm: block/io.c:1543: bdrv_co_pwritev: Assertion `!(bs->open_flags & 0x08=
00)' failed.
  2017-08-24 11:43:45.919+0000: shutting down, reason=3Dcrashed

  here is the release:
  qemu 2.7 & 2.10.rc3 were tested.
  libvirt 3.0.0 & 3.2.0 were tested.

  command line:
  src_host:virsh migrate --verbose --live --persistent --copy-storage-all v=
m-core qemu+ssh://dst_host/system

  Possible Reason: After bdrv_inactivate_all() was called, mirror_run
  coroutine still writes the left dirty disk data to remote nbd server,
  which triggers the assertion. But I don't known how to avoid the
  problem, help is needed!  Thanks.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1712818/+subscriptions

