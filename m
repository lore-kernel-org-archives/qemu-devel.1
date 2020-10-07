Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485C3C47095
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 04:32:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC1A9208C7
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 04:32:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC1A9208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ17l-0004JB-OZ
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 00:32:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kQ15F-0002KK-A7
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 00:29:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:36936)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kQ158-0005L3-PW
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 00:29:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kQ156-00027A-5N
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 04:29:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 24A5A2E80EC
 for <qemu-devel@nongnu.org>; Wed,  7 Oct 2020 04:29:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2020 04:17:33 -0000
From: Launchpad Bug Tracker <1505041@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Expired; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: berrange fgouget janitor th-huth
X-Launchpad-Bug-Reporter: Francois Gouget (fgouget)
X-Launchpad-Bug-Modifier: Launchpad Janitor (janitor)
References: <20151012003458.26359.57214.malonedeb@chaenomeles.canonical.com>
Message-Id: <160204425389.20421.11462990134619226294.malone@loganberry.canonical.com>
Subject: [Bug 1505041] Re: Live snapshot revert times increases linearly with
 snapshot age
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="d50d1e75c500726862802414f880ee3e3bb759bf"; Instance="production"
X-Launchpad-Hash: ccb105764b2721860bb66e40c56f78a93a7277c3
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
Reply-To: Bug 1505041 <1505041@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1505041

Title:
  Live snapshot revert times increases linearly with snapshot age

Status in QEMU:
  Expired

Bug description:
  The WineTestBot (https://testbot.winehq.org/) uses QEmu live snapshots
  to ensure the Wine tests are always run in a pristine Windows
  environment. However the revert times keep increasing linearly with
  the age of the snapshot, going from tens of seconds to thousands.
  While the revert takes place the qemu process takes 100% of a core and
  there is no disk activity. Obviously waiting over 20 minutes before
  being able to run a 10 second test is not viable.

  Only some VMs are impacted. Based on libvirt's XML files the common
  point appears to be the presence of the following <timer> tags:

      <clock offset=3D'localtime'>
        <timer name=3D'rtc' tickpolicy=3D'delay'/>
        <timer name=3D'pit' tickpolicy=3D'delay'/>
        <timer name=3D'hpet' present=3D'no'/>
      </clock>

  Where the unaffected VMs have the following clock definition instead:

      <clock offset=3D'localtime'/>

  Yet shutting down the affected VMs, changing the clock definition,
  creating a live snapshot and trying to revert to it 6 months later
  results in slow revert times (>400 seconds).

  Changing the tickpolicy to catchup for rtc and/or pit has no effect on
  the revert time (and unsurprisingly causes the clock to run fast in
  the guest).

  =

  To reproduce this problem do the following:
  * Create a Windows VM (either 32 or 64 bits). This is known to happen wit=
h at least Windows 2000, XP, 2003, 2008 and 10.
  * That VM will have the <timer> tags shown above, with the possible addit=
ion of an hypervclock timer.
  * Shut down the VM.
  * date -s "2014/04/01"
  * Start the VM.
  * Take a live snapshot.
  * Shut down the VM.
  * date -s "<your current date>"
  * Revert to the live snapshot.

  If the revert takes more than 2 minutes then there is a problem.

  =

  A workaround is to set track=3D'guest' on the rtc timer. This makes the r=
evert fast and may even be the correct solution. But why is it not the defa=
ult or better documented?
   * It setting track=3D'wall' or omitting track, then the revert is slow a=
nd the clock in the guest is not updated.
   * It setting track=3D'guest' the revert is fast and the clock in the gue=
st is not updated.

  =

  I found three past mentions of this issue but as far as I can tell none o=
f them got anywhere:

  * [Qemu-discuss] massive slowdown for reverts after given amount of time =
on any newer versions
     https://lists.gnu.org/archive/html/qemu-discuss/2013-02/msg00000.html

  * The above post references another one from 2011 wrt qemu 0.14:
     https://lists.gnu.org/archive/html/qemu-devel/2011-03/msg02645.html

  * Comment #9 of Launchpad bug 1174654 matches this slow revert issue. How=
ever
     the bug was really about another issue so this was not followed on.
     https://bugs.launchpad.net/qemu/+bug/1174654/comments/9

  =

  I'm currently running into this issue with QEmu 2.1 but it looks like thi=
s bug has been there all along.
  1:2.1+dfsg-12+deb8u2 qemu-kvm
  1:2.1+dfsg-12+deb8u2 qemu-system-common
  1:2.1+dfsg-12+deb8u2 qemu-system-x86

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1505041/+subscriptions

