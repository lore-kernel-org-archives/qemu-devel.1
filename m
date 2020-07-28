Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DEFC433E8
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 14:52:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FB41206F5
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 14:52:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FB41206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0QxT-0004oM-CA
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 10:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k0QwM-0003Zc-3c
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 10:50:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:45722)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k0QwK-0004CP-4L
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 10:50:49 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k0QwH-00040z-RF
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 14:50:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id BD9602E80EF
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 14:50:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2020 14:44:29 -0000
From: =?utf-8?q?Alex_Benn=C3=A9e?= <1859021@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Confirmed; importance=Undecided;
 assignee=alex.bennee@linaro.org; 
X-Launchpad-Bug-Tags: arm tcg testcase
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ajbennee alexlngw pmaydell
X-Launchpad-Bug-Reporter: Alex Longwall (alexlngw)
X-Launchpad-Bug-Modifier: =?utf-8?q?Alex_Benn=C3=A9e_=28ajbennee=29?=
References: <157857629827.5165.2496570379985305724.malonedeb@gac.canonical.com>
Message-Id: <159594746923.10348.3935993314603968059.malone@chaenomeles.canonical.com>
Subject: [Bug 1859021] Re: qemu-system-aarch64 (tcg): cval + voff overflow not
 handled, causes qemu to hang
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a24057fea7e4c6a98c0220d5f878da0f3c783699";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: cfa70ea079b24d33de5222ce40c64b997c30ef15
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 10:25:41
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
Reply-To: Bug 1859021 <1859021@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A different approach was posted that basically elides the overflow case
by not scheduling timers for IRQ events which have already happened:

  https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg07915.html

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1859021

Title:
  qemu-system-aarch64 (tcg):  cval + voff overflow not handled, causes
  qemu to hang

Status in QEMU:
  Confirmed

Bug description:
  The Armv8 architecture reference manual states that for any timer set
  (e.g. CNTP* and CNTV*), the condition for such timer to generate an
  interrupt (if enabled & unmasked) is:

  CVAL <=3D CNT(P/V)CT

  Although this is arguably sloppy coding, I have seen code that is
  therefore assuming it can set CVAL to a very high value (e.g.
  UINT64_MAX) and leave the interrupt enabled in CTL, and never get the
  interrupt.

  On latest master commit as the time of writing, there is an integer
  overflow in target/arm/helper.c gt_recalc_timer affecting the virtual
  timer when the interrupt is enabled in CTL:

      /* Next transition is when we hit cval */
      nexttick =3D gt->cval + offset;

  When this overflow happens, I notice that qemu is no longer responsive an=
d that I have to SIGKILL the process:
      - qemu takes nearly all the cpu time of the cores it is running on (e=
.g. 50% cpu usage if running on half the cores) and is completely unrespons=
ive
      - no guest interrupt (reported via -d int) is generated

  Here the minimal code example to reproduce the issue:

      mov     x0, #1
      msr     cntvoff_el2, x0
      mov     x0, #-1
      msr     cntv_cval_el0, x0
      mov     x0, #1
      msr     cntv_ctl_el0, x0 // interrupt generation enabled, not masked;=
 qemu will start to hang here

  Options used:
  -nographic -machine virt,virtualization=3Don,gic-version=3D2,accel=3Dtcg =
-cpu cortex-a57
  -smp 4 -m 1024 -kernel whatever.elf -d unimp,guest_errors,int -semihostin=
g-config enable,target=3Dnative
  -serial mon:stdio

  Version used: 4.2

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1859021/+subscriptions

