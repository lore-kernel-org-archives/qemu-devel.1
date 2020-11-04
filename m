Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB5BC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 23:06:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32EA32071A
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 23:06:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32EA32071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaRqy-0001bt-LT
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 18:06:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kaRpu-00015z-O6
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 18:05:02 -0500
Received: from indium.canonical.com ([91.189.90.7]:38492)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kaRps-00015u-PA
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 18:05:02 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kaRpq-0008LH-RR
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 23:04:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id BEC442E8134
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 23:04:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2020 22:53:56 -0000
From: John Snow <1611394@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Committed; importance=Undecided;
 assignee=matthieu.bucchianeri@leostella.com; 
X-Launchpad-Bug-Tags: embedded floating-point ppc
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: andreas-rasmusson jnsnow matthieu-bucchianeri
X-Launchpad-Bug-Reporter: Andreas Rasmusson (andreas-rasmusson)
X-Launchpad-Bug-Modifier: John Snow (jnsnow)
References: <20160809142016.20365.3095.malonedeb@wampee.canonical.com>
Message-Id: <160453043676.18149.17498930524798696236.malone@soybean.canonical.com>
Subject: [Bug 1611394] Re: qemu-ppc: Scalar Single-Precision Floating-Point
 instructions should not test MSR[SPV]
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e39939c02bd86af4202bc6e2123a7708215ec8ea"; Instance="production"
X-Launchpad-Hash: 2791eb0421e136f2836b3191743d0381d0559e01
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 17:35:34
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
Reply-To: Bug 1611394 <1611394@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Assuming that this commit:
https://gitlab.com/qemu-project/qemu/-/commit/8dcdb535d7cc4ba6270bb756e12e1=
d323254ed4e

is sufficient to mark this bug as Fix Committed. Please re-open if I am
mistaken.

** Changed in: qemu
       Status: In Progress =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1611394

Title:
  qemu-ppc: Scalar Single-Precision Floating-Point instructions should
  not test  MSR[SPV]

Status in QEMU:
  Fix Committed

Bug description:
  According to "Signal Processing Engine (SPE) Programming Environments Man=
ual" at
  http://cache.nxp.com/files/32bit/doc/ref_manual/SPEPEM.pdf?fsrch=3D1&sr=
=3D1&pageNum=3D1

  c.f section 4.2.3  and also Figure 2-2.

  When MSR[SPV] is _NOT_ set, then the embedded scalar single-precision flo=
ating-point instructions
  should _NOT_ generate an Embedded Floating-Point Unavailable Interrupt.

  =

  Hence, some tests for MSR[SPV] in file target-ppc/translate.c need to be =
removed.
  Namely, in the definitions of =

  1. GEN_SPEFPUOP_ARITH2_32_32
  2. gen_efsabs
  3. gen_efsnabs
  4. gen_efsneg
  5. GEN_SPEFPUOP_COMP_32

  Note, the macro GEN_SPEFPUOP_CONV_32_32 is already correct.

  One more thing, afaict the macro GEN_SPEFPUOP_CONV_32_64 is used by both
  efs- and efd- instructions, and will need to be split in two versions.
  The efs-use (i.e for efscfd) should be as it is today, but the use by efd=
-instructions =

  (e.g efdctui) will need to add a test for MSR[SPV].


  (I've looked at today's HEAD-revision of target-ppc/translate.c).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1611394/+subscriptions

