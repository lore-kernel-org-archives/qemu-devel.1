Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1B6C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 13:21:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EC3A20707
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 13:21:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EC3A20707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfNuD-0006ft-Ga
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 09:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jfNtI-0005g9-CZ
 for qemu-devel@nongnu.org; Sun, 31 May 2020 09:20:40 -0400
Received: from indium.canonical.com ([91.189.90.7]:58086)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jfNtH-0003Od-4P
 for qemu-devel@nongnu.org; Sun, 31 May 2020 09:20:39 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jfNtF-0001IX-7N
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 13:20:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 338172E8107
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 13:20:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2020 13:11:24 -0000
From: Laurent Vivier <1881450@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=In Progress; importance=Undecided;
 assignee=Laurent@vivier.eu; 
X-Launchpad-Bug-Tags: m68k
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ahmedkrmn laurent-vivier
X-Launchpad-Bug-Reporter: Ahmed Karaman (ahmedkrmn)
X-Launchpad-Bug-Modifier: Laurent Vivier (laurent-vivier)
References: <159088695339.29529.1797786788240960646.malonedeb@chaenomeles.canonical.com>
Message-Id: <159093068467.13516.11169557805908918912.malone@soybean.canonical.com>
Subject: [Bug 1881450] Re: Emulation of a math function fails for m68k Linux
 user mode
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="275d46a24253e557e4403d52832837e4bfa425b6";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: f1f097a89f478914348120c3ffcac2f443b2eaf9
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/31 08:45:39
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Bug 1881450 <1881450@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Patch added: "0001-target-m68k-implement-opcode-fetoxm1x.patch"
   https://bugs.launchpad.net/qemu/+bug/1881450/+attachment/5379012/+files/=
0001-target-m68k-implement-opcode-fetoxm1x.patch

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1881450

Title:
  Emulation of a math function fails for m68k Linux user mode

Status in QEMU:
  In Progress

Bug description:
  Please check the attached math-example.c file.
  When running the m68k executable under QEMU, it results in an =

  "Illegal instruction" error.
  Other targets don't produce this error.

  Steps to reproduce the bug:

  1. Download the math-example.c attached file.
  2. Compile it by running:
  =C2=A0=C2=A0=C2=A0m68k-linux-gnu-gcc -O2 -static math-example.c -o math-e=
xample-m68k -lm
  3. Run the executable with QEMU:
  =C2=A0=C2=A0=C2=A0/build/qemu-5.0.0/build-gcc/m68k-linux-user/qemu-m68k m=
ath-example-m68k

  The output of execution is:
  =C2=A0=C2=A0=C2=A0Profiling function expm1f():
  =C2=A0=C2=A0=C2=A0qemu: uncaught target signal 4 (Illegal instruction) - =
core dumped
  =C2=A0=C2=A0=C2=A0Illegal instruction (core dumped)

  Output when running on other targets:
  =C2=A0=C2=A0=C2=A0Profiling function expm1f():
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Elapsed time: 47 ms
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Control result: 71804.953125

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1881450/+subscriptions

