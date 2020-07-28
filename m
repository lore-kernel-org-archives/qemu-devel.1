Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE4EC433EC
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 18:16:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8EA22070B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 18:16:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8EA22070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0U9L-0006jg-7N
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 14:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k0U8e-0006Ho-2V
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 14:15:44 -0400
Received: from indium.canonical.com ([91.189.90.7]:52640)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k0U8c-000262-4L
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 14:15:43 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k0U8Z-0002ns-3L
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 18:15:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 129242E80EC
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 18:15:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2020 18:01:36 -0000
From: Peter Maydell <1889288@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Invalid; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: pmaydell ubuntu-10-rmn30
X-Launchpad-Bug-Reporter: Robert (ubuntu-10-rmn30)
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
References: <159595596008.2765.9252796063113419577.malonedeb@gac.canonical.com>
Message-Id: <159595929665.16561.12945967811327222694.malone@wampee.canonical.com>
Subject: [Bug 1889288] Re: aarch64 BICS instruciton doesn't set flags
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a24057fea7e4c6a98c0220d5f878da0f3c783699";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 6038d323913666a2b038e8aaea15afe217a72815
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 13:15:38
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
Reply-To: Bug 1889288 <1889288@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The code is correct (though it is admittedly not entirely obvious at
first glance). The switch statement at line 4753 is on "(opc | (invert
<< 2))" (where opc is a 2 bit field and invert a 1 bit field). Both ANDS
and BICS have opc=3D=3D3 and so will cause a call to gen_logic_CC(). The
difference between the two insns is that ANDC has invert=3D=3D0 and BICS has
invert=3D=3D1.


** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1889288

Title:
  aarch64 BICS instruciton doesn't set flags

Status in QEMU:
  Invalid

Bug description:
  When reading the source for translate-a64.c here:

  https://github.com/qemu/qemu/blob/a466dd084f51cdc9da2e99361f674f98d721855=
9/target/arm/translate-a64.c#L4783

  I noticed that it does not appear to call gen_logic_CC for the BICS
  instruction so is not setting the flags as required. I haven't tried
  to produce a test case for it but it seems like it might be a bug.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1889288/+subscriptions

