Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99765C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 08:52:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DAC7206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 08:52:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DAC7206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBDde-0002wJ-N8
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 04:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kBDd0-00029p-Lo
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 04:51:26 -0400
Received: from indium.canonical.com ([91.189.90.7]:53052)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kBDcy-0007mW-TV
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 04:51:26 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kBDcw-0006cO-HZ
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 08:51:22 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 2A2582E80EC
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 08:51:22 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2020 08:39:09 -0000
From: Mike Gelfand <1893010@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: linux-user
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: mike.dld
X-Launchpad-Bug-Reporter: Mike Gelfand (mike.dld)
X-Launchpad-Bug-Modifier: Mike Gelfand (mike.dld)
References: <159843096085.1469.8304847352897420087.malonedeb@wampee.canonical.com>
Message-Id: <159851754968.881.1099595992796828395.malone@wampee.canonical.com>
Subject: [Bug 1893010] Re: qemu linux-user doesn't support OFD fcntl locks
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="99c2d833c8d727fd05148486920aca032e908071"; Instance="production"
X-Launchpad-Hash: 9a5c70a9057740c53c28c57b1c2b044423c4bb76
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 04:51:23
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
Reply-To: Bug 1893010 <1893010@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The attached patch fixes the issue for me.

** Patch added: "qemu-5.0.0-ofd-fcntl.patch"
   https://bugs.launchpad.net/qemu/+bug/1893010/+attachment/5405131/+files/=
qemu-5.0.0-ofd-fcntl.patch

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1893010

Title:
  qemu linux-user doesn't support OFD fcntl locks

Status in QEMU:
  New

Bug description:
  "Open file description locks (non-POSIX)", as they are described in
  fcntl(2) man page, aren't supported by qemu-user  and attempting to
  use those results in EINVAL. I'm on Gentoo with latest QEMU version
  currently available (5.0.0-r2), and trying to emulate ppc64 and s390x
  on x86_64.

  Looking at linux-user/syscall.c, I'm guessing the issue is in (at
  least) `target_to_host_fcntl_cmd` where switch reaches the default
  clause as there're no cases for F_OFD_SETLK / F_OFD_SETLKW /
  F_OFD_GETLK.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1893010/+subscriptions

