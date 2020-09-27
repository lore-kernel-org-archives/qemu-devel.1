Return-Path: <SRS0=PST1=DE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99438C47426
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 04:30:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E55EB221EC
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 04:30:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E55EB221EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMOKP-0005DC-P5
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 00:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kMOJq-0004md-Uo
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 00:29:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:53636)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kMOJo-0008J6-Te
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 00:29:50 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kMOJm-0000Ca-R8
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2020 04:29:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id BB8762E80F1
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2020 04:29:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2020 04:17:28 -0000
From: Launchpad Bug Tracker <1256122@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Expired; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: vfio
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: anti-connard janitor th-huth
X-Launchpad-Bug-Reporter: Val532 (anti-connard)
X-Launchpad-Bug-Modifier: Launchpad Janitor (janitor)
References: <20131128221327.32583.75260.malonedeb@gac.canonical.com>
Message-Id: <160118024821.16940.13796290633010748066.malone@loganberry.canonical.com>
Subject: [Bug 1256122] Re: vfio bug with all no VGA card
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a314d157ca9be8d00eae0214fc0d7dff1cd406e4"; Instance="production"
X-Launchpad-Hash: 5cb98756a9d1515539e2da993d46eccc6ad503d0
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/27 00:29:47
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
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
Reply-To: Bug 1256122 <1256122@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1256122

Title:
  vfio bug with all no VGA card

Status in QEMU:
  Expired

Bug description:
  Hello,

  I whant to report to you a realy big bug.

  vfio passthrough work only with VGA card ! When i try to use vfio with
  any other PCI or PCI-E card it does not work.

  When i use vfio for VGA i can reboot (or shutdown and start again) my
  VM with out problem, but for any other PCI card the VM refuse to
  reboot.

  In dmesg i have this error :

  dmar: DRHD: handling fault status reg 2
  dmar: DMAR:[DMA Read] Request device [xx:xx.x] fault addr 2affde000
  DMAR:[fault reason 06] PTE Read access is not set

  and some time the same but for Write and not Read.

  I found a kind of work around but it's ugly. Just detach your devices
  from vfio, re-atach to his normal driver and bind again to vfio.

  For information i use an Asrock Z87 Extrem 6 with a CoreI5 4570S
  My kernel is 3.12 and Qemu is 1.7-rc0

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1256122/+subscriptions

