Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483E6C433E8
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 06:15:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DB0D21883
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 06:15:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DB0D21883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Iu1-0007ba-DM
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 02:15:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k0ItL-00074x-Aa
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 02:15:11 -0400
Received: from indium.canonical.com ([91.189.90.7]:56110)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k0ItH-0000fd-Sr
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 02:15:10 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k0ItF-0002ep-Mw
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 06:15:05 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 8F4D02E8010
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 06:15:05 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2020 06:03:07 -0000
From: Thomas Huth <1256122@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: vfio
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: anti-connard th-huth
X-Launchpad-Bug-Reporter: Val532 (anti-connard)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20131128221327.32583.75260.malonedeb@gac.canonical.com>
Message-Id: <159591618801.10780.12415904591479534493.malone@chaenomeles.canonical.com>
Subject: [Bug 1256122] Re: vfio bug with all no VGA card
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a24057fea7e4c6a98c0220d5f878da0f3c783699";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 7e6fbdecae8ca909fbfdde773b06d689927609bb
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 02:15:06
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Looking through old bug tickets... can you still reproduce this issue
with the latest version of QEMU? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1256122

Title:
  vfio bug with all no VGA card

Status in QEMU:
  Incomplete

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

