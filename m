Return-Path: <SRS0=L55N=BT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4602C433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2020 17:15:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6E4B206A2
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2020 17:15:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E4B206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k4ovF-00083x-43
	for qemu-devel@archiver.kernel.org; Sun, 09 Aug 2020 13:15:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k4ouF-0007Vk-Vm
 for qemu-devel@nongnu.org; Sun, 09 Aug 2020 13:14:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:40708)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k4ouD-0003lt-Tp
 for qemu-devel@nongnu.org; Sun, 09 Aug 2020 13:14:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k4ouB-0007Ga-9T
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2020 17:14:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 3D6FA2E8055
 for <qemu-devel@nongnu.org>; Sun,  9 Aug 2020 17:14:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2020 17:05:19 -0000
From: till <811683@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Triaged; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: exceptions ppc
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: afaerber agraf balaton-4 th-huth till-straumann
X-Launchpad-Bug-Reporter: till (till-straumann)
X-Launchpad-Bug-Modifier: till (till-straumann)
References: <20110716214931.3466.65125.malonedeb@soybean.canonical.com>
Message-Id: <159699271960.9290.10335956505266865256.malone@wampee.canonical.com>
Subject: [Bug 811683] Re: 7400, 7410,
 7450 cpus vector have wrong exception prefix at reset
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="6a138c03da9cc3e2e03f6dd3bbb4a615b0be6ec2";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 408973dd5d05cb95992c88ec9e6f3cfb7422f30e
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/09 13:14:43
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
Reply-To: Bug 811683 <811683@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Yes, it is a CPU feature, and yes you can select the exception vector
prefix with the MSR[IP] bit which should be set by a hardware reset. The
initial value seems wrong in qemu but that seems to fixed by the
machine-specific initialization. The 'none' machine, however, just uses
generic code and does not do anything PPC-specific. This means that

 - the MSR and probably other registers, too, are not initialized to what t=
he hardware
   documentation specifies as reset values.
 - the time-base is not initialized at all (and this leads to a segfault wh=
en you start the
   ppc 'none' machine)
 - probably other things are not properly initialized. I wonder, e.g., abou=
t the MMU...

It seems that all registers are simply initialized to zero. Then, there see=
ms to be a 'reset' function which initializes the registers to the proper r=
eset values (well - sort of bug 812398 reports that HID0 is not properly in=
itialized by some CPU flavours). However, that reset function
is not executed by the 'none' machine initialization....

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/811683

Title:
  7400,7410,7450 cpus vector have wrong exception prefix at reset

Status in QEMU:
  Triaged

Bug description:
  I have a proprietary ROM implementing system calls that are executed
  via the 'SC' instruction.

  I use qemu-0.14.1,

  qemu-system-ppc -M prep -cpu $CPU -bios my_bios -kernel my_kernel

  That works fine on a 604 (CPU=3D0x00040103) - but does not on an emulated=
 7400 (CPU=3D0x000c0209) or 7450 (CPU=3D0x80000201). I found that the emula=
tor jumps to 0x00000c00 instead of 0xfff00c00.
  Probably this is due to a wrong setting in target-ppc/translate_init.c:

  init_excp_604() correctly sets env->hreset_vector=3D0xfff00000UL;

  but

  init_excp_7400() says env->hreset_vector=3D0x00000000UL;

  which seems wrong. (the 7400 manual says a hard-reset jumps initializes t=
he
  prefix to 0xfff00000.)

  Likewise, init_excp_7450() (and probably other, related CPUs) are
  wrong.

  Indeed, when I change the value in init_excp_7400() to 0xfff00000UL then
  everything works as expected for me.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/811683/+subscriptions

