Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C848FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 09:51:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CC892074F
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 09:51:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CC892074F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0MGJ-0000PG-T3
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 05:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k0MFE-0007eI-79
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 05:50:00 -0400
Received: from indium.canonical.com ([91.189.90.7]:41380)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k0MFB-0004BM-UM
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 05:49:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k0MFA-0004C1-3L
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 09:49:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 074632E80EE
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 09:49:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2020 09:39:03 -0000
From: John Paul Adrian Glaubitz <917645@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=helenos; status=Confirmed; importance=Wishlist;
 assignee=None; 
X-Launchpad-Bug: product=qemu; status=New; importance=Wishlist; assignee=None; 
X-Launchpad-Bug-Tags: enhancement ia64 ia64-softmmu itanium qemu
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: glaubitz jakub
X-Launchpad-Bug-Reporter: Jakub Jermar (jakub)
X-Launchpad-Bug-Modifier: John Paul Adrian Glaubitz (glaubitz)
References: <20120117134021.32382.93820.malonedeb@gac.canonical.com>
Message-Id: <159592914308.5176.11118445847595933001.malone@soybean.canonical.com>
Subject: [Bug 917645] Re: [Feature request] ia64-softmmu wanted
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a24057fea7e4c6a98c0220d5f878da0f3c783699";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 5799756b2be4a60be43745358217132b32382a14
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
Reply-To: Bug 917645 <917645@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Someone is working on it, see: https://github.com/XVilka/qemu-ia64

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/917645

Title:
  [Feature request] ia64-softmmu wanted

Status in HelenOS branches:
  Confirmed
Status in QEMU:
  New

Bug description:
  Qemu is missing support for full system emulation of the Itanium
  architecture, which is one of the main non-x86 server architectures
  today (despite the alleged decline in popularity). It would be really
  nice if someone had interest in adding full ia64 support to Qemu. Many
  OS projects could then use Qemu as the universal machine emulator for
  development and testing.

  Note that there is an open source Ski simulator which can emulate an
  ia64 CPU, memory and a couple of Ski-specific devices, but the project
  seems inactive and the simulated machine is too simplified (no real
  devices, no real firmware). Moreover, it'd be better to have one tool
  such as Qemu for all architectures of interest rather than one per
  each architecture.

To manage notifications about this bug go to:
https://bugs.launchpad.net/helenos/+bug/917645/+subscriptions

