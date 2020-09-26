Return-Path: <SRS0=cZnO=DD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D24C4741F
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 17:07:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E18CD207C4
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 17:07:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E18CD207C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMDfL-0000W2-To
	for qemu-devel@archiver.kernel.org; Sat, 26 Sep 2020 13:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kMDdj-0007fF-PU
 for qemu-devel@nongnu.org; Sat, 26 Sep 2020 13:05:39 -0400
Received: from indium.canonical.com ([91.189.90.7]:44888)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kMDdh-0004FJ-3a
 for qemu-devel@nongnu.org; Sat, 26 Sep 2020 13:05:39 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kMDdg-00013Q-2A
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2020 17:05:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 0B16D2E80DB
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2020 17:05:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2020 16:58:29 -0000
From: Thomas Huth <1719689@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Wishlist; assignee=None; 
X-Launchpad-Bug-Tags: feature-request
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: erichspaker
X-Launchpad-Bug-Reporter: Erich Spaker (erichspaker)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <150644549574.30872.12487281678930398558.malonedeb@wampee.canonical.com>
Message-Id: <160113951061.9359.11266041422409885573.launchpad@chaenomeles.canonical.com>
Subject: [Bug 1719689] Re: [feature request] add flag to treat warnings as
 errors
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a314d157ca9be8d00eae0214fc0d7dff1cd406e4"; Instance="production"
X-Launchpad-Hash: 97ee71fc665f949a1344aabfbfc4cd5f695f6c79
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/26 13:05:34
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
Reply-To: Bug 1719689 <1719689@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Changed in: qemu
   Importance: Undecided =3D> Wishlist

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1719689

Title:
  [feature request] add flag to treat warnings as errors

Status in QEMU:
  New

Bug description:
  Since booting could potentially take a lot of time and warnings are
  likely to indicate that something is wrong, it would be useful to have
  a command line flag which would abort the boot if there are any
  warnings.

  An example might be network configuration. The following output most
  likely indicates that there is something the user has to fix before
  starting and being able to use the guest os.

  Warning: hub port hub0port0 has no peer
  Warning: vlan 0 with no nics
  Warning: netdev hub0port0 has no peer
  Warning: requested NIC (anonymous, model vitrio-net-device) was not creat=
ed (not supported by this machine?)

  Ideally, there would be an option the user could pass which would
  cause qemu to print these warnings then exit, rather than boot the
  kernel.

  Alternatively, or additionally, a dry run option would be helpful for
  the same purpose: making sure qemu get to the booting the kernel stage
  with everything in working order so that you do not have to wait for
  the kernel to boot and then shut down while debugging things like
  networking (things which can be debugged (at least partially) without
  booting, or trying to boot, the guest os).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1719689/+subscriptions

