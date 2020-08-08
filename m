Return-Path: <SRS0=zX6u=BS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D1AC433E1
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2020 08:20:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C9E220855
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2020 08:20:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C9E220855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k4K5f-0006fA-S7
	for qemu-devel@archiver.kernel.org; Sat, 08 Aug 2020 04:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k4K4z-0005pD-1a
 for qemu-devel@nongnu.org; Sat, 08 Aug 2020 04:19:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:49968)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k4K4w-000375-AJ
 for qemu-devel@nongnu.org; Sat, 08 Aug 2020 04:19:48 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k4K4t-0000wp-7G
 for <qemu-devel@nongnu.org>; Sat, 08 Aug 2020 08:19:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 3340F2E808C
 for <qemu-devel@nongnu.org>; Sat,  8 Aug 2020 08:19:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2020 08:09:21 -0000
From: Thomas Huth <1503031@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: andrewoates pmaydell th-huth
X-Launchpad-Bug-Reporter: Andrew Oates (andrewoates)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20151005203328.1986.66361.malonedeb@wampee.canonical.com>
Message-Id: <159687416169.26824.16621021982700195278.malone@gac.canonical.com>
Subject: [Bug 1503031] Re: 32-to-64-bit call gate unsupported in IA32e mode
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="6a138c03da9cc3e2e03f6dd3bbb4a615b0be6ec2";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: c4657b89ebebbcf78473f1a9176ab4f4c348d74b
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/08 03:59:35
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
Reply-To: Bug 1503031 <1503031@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

That looks like the corresponding fix, indeed. Let's close this ticket.

** Changed in: qemu
       Status: Incomplete =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1503031

Title:
  32-to-64-bit call gate unsupported in IA32e mode

Status in QEMU:
  Fix Released

Bug description:
  In particular, the lcall implementation doesn't support the 64-bit
  TSS.

  helper_lcall_protected (target-i386/seg_helper.c:1884) calls
  get_ss_esp_from_tss() on a call gate to a lower privilege level, which
  tries to extract a 32-bit ESP and 16-bit SS from the TSS.  In IA32e
  mode (64-bit or compatibility mode), this instead grabs the lower
  32-bits of the target RSP, and 16 of the upper bits as the SS.
  Additionally, several of the subsequent checks are incorrect (even if
  the correct stack pointer were extracted).

  This isn't a problem for interrupts since the interrupts are given
  their own implementation entirely, that uses get_rsp_from_tss() rather
  than get_ss_esp_from_tss().

  I believe the missing logic is from the branch starting "ELSE (*
  current TSS is 64-bit *)" in the CALL pseudocode in the Intel manual
  (page 3-124 of the PDF I have).

  Reproduced at master (c0b520dfb8890294a9f8879f4759172900585995), and
  also as of a qemu built a year ago.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1503031/+subscriptions

