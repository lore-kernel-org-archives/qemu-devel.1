Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B32FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 17:46:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A94F207F7
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 17:46:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A94F207F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjnlP-0001oI-Ja
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 13:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jjnkQ-0001L6-Nh
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 13:45:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:57852)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jjnkM-0002SE-UT
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 13:45:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jjnkK-000264-F7
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 17:45:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 6D4792E8050
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 17:45:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2020 17:36:47 -0000
From: =?utf-8?q?Alex_Benn=C3=A9e?= <1883268@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: arm testcase
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: christophe-lyon
X-Launchpad-Bug-Reporter: Christophe Lyon (christophe-lyon)
X-Launchpad-Bug-Modifier: =?utf-8?q?Alex_Benn=C3=A9e_=28ajbennee=29?=
References: <159197267869.7647.15246075911938911102.malonedeb@gac.canonical.com>
Message-Id: <159198340771.7893.3089877324736465012.launchpad@gac.canonical.com>
Subject: [Bug 1883268] Re: random errors on aarch64 when executing
 __aarch64_cas8_acq_rel
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="b190cebbf563f89e480a8b57f641753c8196bda0";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: b58afc5dbad3aaac991f195a3a45aa19d8625507
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 13:35:28
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Reply-To: Bug 1883268 <1883268@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Tags added: arm testcase

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1883268

Title:
  random errors on aarch64 when executing __aarch64_cas8_acq_rel

Status in QEMU:
  New

Bug description:
  Hello,

  Since I upgraded to qemu-5.0 when executing the GCC testsuite,
  I've noticed random failures of g++.dg/ext/sync-4.C.

  I'm attaching the source of the testcase, the binary executable and
  the qemu traces (huge, 111MB!) starting at main (with qemu-aarch64
  -cpu cortex-a57 -R 0 -d
  in_asm,int,exec,cpu,unimp,guest_errors,nochain)

  The traces where generated by a CI build, I built the executable
  manually but I expect it to be the same as the one executed by CI.

  In seems the problem occurs in f13, which leads to a call to abort()

  The preprocessed version of f13/t13 are as follows:
  static bool f13 (void *p) __attribute__ ((noinline));
  static bool f13 (void *p)
  {
    return (__sync_bool_compare_and_swap((ditype*)p, 1, 2));
  }
  static void t13 ()
  {
    try {
      f13(0);
    }
    catch (...) {
      return;
    }
    abort();
  }

  =

  When looking at the execution traces at address 0x00400c9c, main calls f1=
3, which in turn calls __aarch64_cas8_acq_rel (at 0x00401084)
  __aarch64_cas8_acq_rel returns to f13 (address 0x0040113c), then f13 retu=
rns to main (0x0040108c) which then calls abort (0x00400ca0)

  I'm not quite sure what's wrong :-(

  I've not noticed such random problems with native aarch64 hardware.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1883268/+subscriptions

