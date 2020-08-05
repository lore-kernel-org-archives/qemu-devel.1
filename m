Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E5DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 06:31:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDDFC204EA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 06:31:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDDFC204EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3CxM-00027K-6A
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 02:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k3Cw8-0001Tm-7G
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 02:30:04 -0400
Received: from indium.canonical.com ([91.189.90.7]:46188)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k3Cw5-0000uu-6Z
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 02:30:03 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k3Cw3-0006SI-CB
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 06:29:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 4A40E2E80EF
 for <qemu-devel@nongnu.org>; Wed,  5 Aug 2020 06:29:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2020 06:17:22 -0000
From: Nahuel Pastorale <1502613@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=In Progress; importance=Wishlist;
 assignee=snizovtsev@gmail.com; 
X-Launchpad-Bug-Tags: battery management power virtual
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: kranebrain naftaly-avadiaev npastorale philmd
 snizovtsev wolfgangandreas
X-Launchpad-Bug-Reporter: Wolfgang Andreas (wolfgangandreas)
X-Launchpad-Bug-Modifier: Nahuel Pastorale (npastorale)
References: <20151004131253.1871.94138.malonedeb@wampee.canonical.com>
Message-Id: <159660824205.10292.17586559699424490822.malone@chaenomeles.canonical.com>
Subject: [Bug 1502613] Re: [Feature Request] Battery Status / Virtual Battery
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a24057fea7e4c6a98c0220d5f878da0f3c783699";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 732aa0c5f5ea5e2da474693c89b50df4038d309e
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 00:25:36
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
Reply-To: Bug 1502613 <1502613@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I just wanted to add that this would (probably) help solve the error 43 on =
mobile Nvidia GPU passthrough scenarios. While facing this myself I was abl=
e to get it working by simulating a battery and attaching it via an ACPI ta=
ble.
Your work is greatly appreciated Sergey.
Thank you very much!

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1502613

Title:
  [Feature Request] Battery Status / Virtual Battery

Status in QEMU:
  In Progress

Bug description:
  When using virtualization on notebooks heavily then virtual machines
  do not realize that they're running on a notebook device causing high
  power consumption because they're not switching into a optimized
  "laptop mode". This leads to the circumstance that they are trying to
  do things like defragmentation / virtus scan / etc. while the host is
  still running on batteries.

  So it would be great if QEMU / KVM would have support for emulating
  "Virtual Batteries" to guests causing them to enable power-saving
  options like disabling specific services / devices / file operations
  automatically by OS.

  Optionally a great feature would be to set virtual battery's status
  manually. For example: Current charge rate / charging / discharging /
  ...

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1502613/+subscriptions

