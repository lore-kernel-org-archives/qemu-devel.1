Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC3FC4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 04:41:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13775208C7
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 04:41:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13775208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ1Gp-0004PE-5t
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 00:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kQ15W-0002WF-Qm
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 00:30:04 -0400
Received: from indium.canonical.com ([91.189.90.7]:37602)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kQ15R-0005Px-BS
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 00:30:00 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kQ15E-00027X-3X
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 04:29:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id DD6CA2E8111
 for <qemu-devel@nongnu.org>; Wed,  7 Oct 2020 04:29:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2020 04:17:27 -0000
From: Launchpad Bug Tracker <1219234@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Expired; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: crobinso janitor jnsnow th-huth
X-Launchpad-Bug-Reporter: Cole Robinson (crobinso)
X-Launchpad-Bug-Modifier: Launchpad Janitor (janitor)
References: <20130831150404.10743.73717.malonedeb@gac.canonical.com>
Message-Id: <160204424800.20421.13422584301323802360.malone@loganberry.canonical.com>
Subject: [Bug 1219234] Re: -device ide-hd will assign bus with with no free
 units
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="d50d1e75c500726862802414f880ee3e3bb759bf"; Instance="production"
X-Launchpad-Hash: 2e0a7ad41a297a6a8d9128df7691cc758a57fbac
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 22:50:47
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
Reply-To: Bug 1219234 <1219234@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1219234

Title:
  -device ide-hd will assign bus with with no free units

Status in QEMU:
  Expired

Bug description:
  Originally filed here:
  https://bugzilla.redhat.com/show_bug.cgi?id=3D1000118

  ./x86_64-softmmu/qemu-system-x86_64 -device ahci -drive id=3Daa,file=3D/t=
mp/foo,if=3Dnone -drive id=3Dbb,file=3D/tmp/foo,if=3Dnone -device ide-hd,dr=
ive=3Daa -device ide-hd,drive=3Dbb
  qemu-system-x86_64: -device ide-hd,drive=3Dbb: Can't create IDE unit 1, b=
us supports only 1 units
  qemu-system-x86_64: -device ide-hd,drive=3Dbb: Device initialization fail=
ed.
  qemu-system-x86_64: -device ide-hd,drive=3Dbb: Device 'ide-hd' could not =
be initialized

  If a bus isn't specified for -device ide-hd, it just uses the first
  bus it finds, not taking into account if that bus was already assigned
  for another device. So users are forced to do -device ide-hd,bus=3Dide.0
  -device ide-hd,bus=3Dide.1, etc.

  This isn't specific to -device ahci, but it's worse there since there
  isn't any -drive if=3DIDE or -hda convenience option, which both seem to
  get the logic correct.

  I know -device is the 'build it yourself' approach so I understand if
  this is WONTFIX.

  This is affects qemu.git as of today (8-31-2013)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1219234/+subscriptions

