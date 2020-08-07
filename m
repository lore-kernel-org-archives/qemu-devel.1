Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045DEC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 18:20:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF8C5204EA
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 18:20:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF8C5204EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k46zB-0005x1-4U
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 14:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k46yD-000508-2l
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 14:19:57 -0400
Received: from indium.canonical.com ([91.189.90.7]:58172)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k46yB-00067X-6n
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 14:19:56 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k46y9-0001zT-OJ
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 18:19:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id B19382E808C
 for <qemu-devel@nongnu.org>; Fri,  7 Aug 2020 18:19:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2020 18:03:46 -0000
From: Thomas Huth <1428352@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: th-huth wpaul
X-Launchpad-Bug-Reporter: Bill Paul (wpaul)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20150304222256.6659.52366.malonedeb@wampee.canonical.com>
Message-Id: <159682342684.9018.11225813160215913583.malone@wampee.canonical.com>
Subject: [Bug 1428352] Re: SYSRET instruction incorrectly implemented
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="6a138c03da9cc3e2e03f6dd3bbb4a615b0be6ec2";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: dc48287d6fcf6b90c98cfee9a4a0e65235944c56
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 01:41:01
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1428352 <1428352@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If I've got that right, this has been fixed here:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Dac57622985220de0

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1428352

Title:
  SYSRET instruction incorrectly implemented

Status in QEMU:
  Fix Released

Bug description:
  The Intel architecture manual states that when returning to user mode,
  the SYSRET instruction will re-load the stack selector (%ss) from the
  IA32_STAR model specific register using the following logic:

  SS.Selector <-- (IA32_STAR[63:48]+8) OR 3; (* RPL forced to 3 *)

  Another description of the instruction behavior which shows the same
  logic in a slightly different form can also be found here:

  http://tptp.cc/mirrors/siyobik.info/instruction/SYSRET.html

  [...]
          SS(SEL) =3D IA32_STAR[63:48] + 8;
          SS(PL) =3D 0x3;
  [...]

  In other words, the value of the %ss register is supposed to be loaded
  from  bits 63:48 of the IA32_STAR model-specific register, incremented
  by 8, and then ORed with 3. ORing in the 3 sets the privilege level to
  3 (user). This is done since SYSRET returns to user mode after a
  system call.

  However, helper_sysret() in target-i386/seg_helper.c does not do the
  "OR 3" step. The code looks like this:

          cpu_x86_load_seg_cache(env, R_SS, selector + 8,
                                 0, 0xffffffff,
                                 DESC_G_MASK | DESC_B_MASK | DESC_P_MASK |
                                 DESC_S_MASK | (3 << DESC_DPL_SHIFT) |
                                 DESC_W_MASK | DESC_A_MASK);

  It should look like this:

          cpu_x86_load_seg_cache(env, R_SS, (selector + 8) | 3,
                                 0, 0xffffffff,
                                 DESC_G_MASK | DESC_B_MASK | DESC_P_MASK |
                                 DESC_S_MASK | (3 << DESC_DPL_SHIFT) |
                                 DESC_W_MASK | DESC_A_MASK);

  The code does correctly set the privilege level bits for the code
  selector register (%cs) but not for the stack selector (%ss).

  The effect of this is that when SYSRET returns control to the user-
  mode caller, %ss will be have the privilege level bits cleared. In my
  case, it went from 0x2b to 0x28. This caused a crash later: when the
  user-mode code was preempted by an interrupt, and the interrupt
  handler would do an IRET, a general protection fault would occur
  because the %ss value being loaded from the exception frame was not
  valid for user mode. (At least, I think that's what happened.)

  This behavior seems inconsistent with real hardware, and also appears
  to be wrong with respect to the Intel documentation, so I'm pretty
  confident in calling this a bug. :)

  Note that this issue seems to have been around for a long time. I
  discovered it while using QEMU 2.2.0, but I happened to have the
  sources for QEMU 0.10.5, and the problem is there too (in
  os_helper.c). I am using FreeBSD/amd64 9.1-RELEASE as my host system,
  without KVM.

  The fix is fairly simple. I'm attaching a patch which worked for me.
  Using this fix, the code that I'm testing now behaves the same on the
  QEMU virtual machine as on real hardware.

  - Bill (wpaul@windriver.com)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1428352/+subscriptions

