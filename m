Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C7DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 00:11:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 374BC206C3
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 00:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 374BC206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jioL9-00059n-F5
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 20:11:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jioKM-0004jG-Rs
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 20:10:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:40180)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jioKJ-0007i9-U6
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 20:10:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jioKI-00041W-2U
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 00:10:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id E302B2E810A
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 00:10:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2020 00:02:40 -0000
From: Diego Viola <1882851@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: diego-viola
X-Launchpad-Bug-Reporter: Diego Viola (diego-viola)
X-Launchpad-Bug-Modifier: Diego Viola (diego-viola)
References: <159174217343.32241.17743917589333297614.malonedeb@gac.canonical.com>
Message-Id: <159174736093.18468.3034671118077713503.malone@chaenomeles.canonical.com>
Subject: [Bug 1882851] Re: QEMU video freezes with "Guest disabled display"
 (virtio driver)
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="ef9fc486e875d54078fa61cf91e898b895125d89";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 0f13820493bea12d0fa601bfb3956a58e428d8b4
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 10:15:37
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Reply-To: Bug 1882851 <1882851@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

My bad, the workaround works, it's just a bit tricky.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1882851

Title:
  QEMU video freezes with "Guest disabled display" (virtio driver)

Status in QEMU:
  New

Bug description:
  I am using Arch Linux as my Guest and Host OS, after starting qemu
  with the following command:

    $ qemu-system-x86_64 -enable-kvm -hda arch-zoom.qcow2 -m 4G -vga
  virtio

  and waiting for a screen blank, I get this message:

    Guest disabled display

  And nothing happens after that, I can move the mouse or hit any key,
  and the message is still there.

  I can still reboot the VM but that's not optimal.

  I can reproduce this with the latest QEMU release (5.0.0) or git master, =

  I also tried this with older releases (4.0.0, 3.0.0) and the issue is sti=
ll there.

  I can't reproduce this with other video drivers (std, qxl).

  With std/qxl the screen will blank a bit and then continue as normal.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1882851/+subscriptions

