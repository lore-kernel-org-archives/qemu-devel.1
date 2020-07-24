Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295E3C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 11:56:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1406206E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 11:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1406206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jywJT-0007vP-A8
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 07:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jywIp-0007W3-Ly
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 07:55:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:58474)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jywIn-0004pm-I5
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 07:55:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jywIl-0004b2-F0
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 11:55:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 706372E80D2
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 11:55:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2020 11:46:03 -0000
From: Robert Ball <1888431@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Won't Fix; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: build-failed macosx-10.11.6 v5.1.0-rc1
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ebolainfluenza th-huth
X-Launchpad-Bug-Reporter: Robert Ball (ebolainfluenza)
X-Launchpad-Bug-Modifier: Robert Ball (ebolainfluenza)
References: <159536546453.8597.9185320640612954142.malonedeb@wampee.canonical.com>
Message-Id: <159559116345.11614.16779761332135776655.malone@wampee.canonical.com>
Subject: [Bug 1888431] Re: v5.1.0-rc1 build fails on Mac OS X 10.11.6 
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="f877c5162b568393e2d07ce948459ba0abc456fe";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 9f516e177965b222acf8f9168787d8b1c0113f30
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 07:55:47
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
Reply-To: Bug 1888431 <1888431@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fantastic.   Thank you Thomas, greatly appreciated!

Best regards,

Robert Ball

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1888431

Title:
  v5.1.0-rc1 build fails on Mac OS X 10.11.6

Status in QEMU:
  Won't Fix

Bug description:
  Hi all,

  build of tag v5.1.0-rc1 fails on Mac OS X 10.11.6 (El Capitan) with
  the following error:

  git clone https://git.qemu.org/git/qemu.git
      <output elided, but all OK>
  cd qemu
  git submodule init
      <output elided, but all OK>
  git submodule update --recursive
      <output elided, but all OK>
  ./configure
      <output elided, but all OK>
  make
      <output elided, but all OK up until fail>

    CC      trace/control.o
  In file included from trace/control.c:29:
  In file included from /Users/rtb/src/qemu/include/monitor/monitor.h:4:
  In file included from /Users/rtb/src/qemu/include/block/block.h:4:
  In file included from /Users/rtb/src/qemu/include/block/aio.h:23:
  /Users/rtb/src/qemu/include/qemu/timer.h:843:9: warning: implicit declara=
tion of function 'clock_gettime' is invalid in C99
        [-Wimplicit-function-declaration]
          clock_gettime(CLOCK_MONOTONIC, &ts);
          ^
  /Users/rtb/src/qemu/include/qemu/timer.h:843:23: error: use of undeclared=
 identifier 'CLOCK_MONOTONIC'
          clock_gettime(CLOCK_MONOTONIC, &ts);
                        ^
  1 warning and 1 error generated.
  make: *** [trace/control.o] Error 1

  =

  rtb:qemu rtb$ git log -n1
  commit c8004fe6bbfc0d9c2e7b942c418a85efb3ac4b00 (HEAD -> master, tag: v5.=
1.0-rc1, origin/master, origin/HEAD)
  Author: Peter Maydell <peter.maydell@linaro.org>
  Date:   Tue Jul 21 20:28:59 2020 +0100

      Update version for v5.1.0-rc1 release
      =

      Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
  rtb:qemu rtb$ =


  =

  Please find the full output of all the commands (from git clone of the re=
po, to the make) in the attached file "buildfail.txt".

  Thank you!

  Best regards,

  Robert Ball

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1888431/+subscriptions

