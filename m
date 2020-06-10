Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F39BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 23:31:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22E56207ED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 23:31:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22E56207ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjAC8-0006Vl-DW
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 19:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jjABI-00066r-Au
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 19:30:52 -0400
Received: from indium.canonical.com ([91.189.90.7]:53284)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jjABH-00084V-IQ
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 19:30:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jjABF-0003mW-Pq
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 23:30:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 807BC2E810B
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 23:30:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2020 23:22:07 -0000
From: Adriano Pinaffo <1881645@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: adrianopinaffo
X-Launchpad-Bug-Reporter: Adriano Pinaffo (adrianopinaffo)
X-Launchpad-Bug-Modifier: Adriano Pinaffo (adrianopinaffo)
References: <159103911759.13896.350911340978783530.malonedeb@soybean.canonical.com>
Message-Id: <159183132790.13748.13896918810813673206.launchpad@wampee.canonical.com>
Subject: [Bug 1881645] Re: qemu-system-x86_64 --help (or --version) gives no
 output
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="b190cebbf563f89e480a8b57f641753c8196bda0";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: f0fa1144a63b8d2f811cc63f3eba7f057c8b9f25
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 19:25:46
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
Reply-To: Bug 1881645 <1881645@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Description changed:

- I have Arch Linux with qemu 5.0.0-6 (seen with pacman). Running VMs work =
just fine, but when I run qemu-system-x86_64 --version or qemu-system-x86_6=
4 --help, there is no feedback on the screen. This behavior messes up other=
 applications (GNS3 in my case that cannot recognize qemu as correctly inst=
alled because there is no feedback.
+ I have Arch Linux with qemu 5.0.0-6 (seen with pacman). Running VMs work =
just fine, but when I run qemu-system-x86_64 --version or qemu-system-x86_6=
4 --help, there is no feedback on the screen. This behavior messes up other=
 applications (GNS3 in my case that cannot recognize qemu as correctly inst=
alled because there is no feedback.)
  My kernel is 5.6.11.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1881645

Title:
  qemu-system-x86_64 --help (or --version) gives no output

Status in QEMU:
  New

Bug description:
  I have Arch Linux with qemu 5.0.0-6 (seen with pacman). Running VMs work =
just fine, but when I run qemu-system-x86_64 --version or qemu-system-x86_6=
4 --help, there is no feedback on the screen. This behavior messes up other=
 applications (GNS3 in my case that cannot recognize qemu as correctly inst=
alled because there is no feedback.)
  My kernel is 5.6.11.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1881645/+subscriptions

