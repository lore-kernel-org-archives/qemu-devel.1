Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5B6C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 04:35:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21B91208C7
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 04:35:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21B91208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ1Ap-0007mm-7U
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 00:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kQ15G-0002Lx-Mn
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 00:29:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:37278)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kQ15E-0005Nd-VM
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 00:29:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kQ15A-00027R-N0
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 04:29:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 8ABFC2E810C
 for <qemu-devel@nongnu.org>; Wed,  7 Oct 2020 04:29:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2020 04:17:35 -0000
From: Launchpad Bug Tracker <1323758@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Expired; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
 status=Expired; importance=Low; assignee=None; 
X-Launchpad-Bug-Tags: upstream
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: janitor maarten256 rubenportier serge-hallyn
 th-huth
X-Launchpad-Bug-Reporter: Ruben Portier (rubenportier)
X-Launchpad-Bug-Modifier: Launchpad Janitor (janitor)
References: <20140527170942.25223.59558.malonedeb@chaenomeles.canonical.com>
Message-Id: <160204425568.20421.4034007800560871562.malone@loganberry.canonical.com>
Subject: [Bug 1323758] Re: Mouse stops working when connected
 usb-storage-device
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="d50d1e75c500726862802414f880ee3e3bb759bf"; Instance="production"
X-Launchpad-Hash: 13cafa0126de3443990fe2b151406aa730f92165
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
Reply-To: Bug 1323758 <1323758@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Expired for qemu (Ubuntu) because there has been no activity for 60
days.]

** Changed in: qemu (Ubuntu)
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1323758

Title:
  Mouse stops working when connected usb-storage-device

Status in QEMU:
  Expired
Status in qemu package in Ubuntu:
  Expired

Bug description:
  I'm running a guest that has Windows 8 Pro (x64) installed. Every time
  I pass through a usb storage device from the host to the guest, the
  mouse stops working in the vnc client. When I remove the usb-device
  the mouse works again.

  The mouse only stops working when I pass through a usb storage device
  and then make the vlc viewer (client) inactive by clicking on another
  program on the local computer (where I'm running the vnc viewer
  (client)). As long as I keep the vnc viewer active, the mouse works
  without any problems. But as soon as I make the vnc viewer inactive
  and then active again, the mouse will no longer work. I have to reboot
  the guest or remove the usb storage device.

  I can't find any related problems on the internet, so it may be just
  me?

  I hope someone can help me with this.

  EDIT: I posted the extra/new information in comments. But as I know
  see it might be wrong and maybe I should've posted them in this bug
  description container (by editing)? Please tell me if I did it wrong
  and I will change it. Sorry for this misunderstanding.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1323758/+subscriptions

