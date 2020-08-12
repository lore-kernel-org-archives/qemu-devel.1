Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABF7C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 12:58:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E27F6204FD
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 12:58:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E27F6204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5qKf-0003xx-52
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 08:58:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k5qIR-00026p-1b
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 08:55:59 -0400
Received: from indium.canonical.com ([91.189.90.7]:43170)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k5qIP-0007Tc-4E
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 08:55:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k5qIN-0008ME-3C
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 12:55:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 11AA92E8081
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 12:55:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2020 12:46:54 -0000
From: "Laszlo Ersek \(Red Hat\)" <1778350@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Invalid; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: jnsnow lersek mst-0 navicrej
X-Launchpad-Bug-Reporter: navicrej (navicrej)
X-Launchpad-Bug-Modifier: Laszlo Ersek (Red Hat) (lersek)
References: <152976906812.26719.4060539263907295716.malonedeb@gac.canonical.com>
Message-Id: <159723641473.5583.8716929658042542035.malone@soybean.canonical.com>
Subject: [Bug 1778350] Re: Android-x86 4.4-r5 won't boot on QEMU since
 v2.11.0-rc2
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="6a138c03da9cc3e2e03f6dd3bbb4a615b0be6ec2";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 063cc36c7798ae0d6ba0d70397736018b8e3fb89
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 06:10:59
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1778350 <1778350@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No feedback for almost two years, closing.

** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1778350

Title:
  Android-x86 4.4-r5 won't boot on QEMU since v2.11.0-rc2

Status in QEMU:
  Invalid

Bug description:
  Try to boot from the Android-x86 4.4-r5 ISO won't boot in QEMU after 2.11=
.0-rc2. The last known version it works is 2.11.0-rc1.
  It also works on the 2.10.x-line, even the 2.10.2 which was released afte=
r 2.11.0-rc2!

  How to reproduce:
  Download the ISO from
  http://www.android-x86.org/releases/releasenote-4-4-r5 or directly https:=
//www.fosshub.com/Android-x86.html/android-x86-4.4-r5.iso

  Start QEMU with this command-line: qemu-system-x86_64 -cdrom
  android-x86-4.4-r5.iso -m 1024

  On 2.11.0-rc1 and 2.10.2 after selecting to boot from CD it shows the And=
roid splash after a short while ...
  On 2.11.0-rc2 through the latest 2.12 line it goes to black screen shortl=
y right after selecting to boot from CD

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1778350/+subscriptions

