Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01B2C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:36:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BC4A2067C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:36:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BC4A2067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCRl4-00004u-OQ
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 13:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44723)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jCRkB-0007ls-0G
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 13:35:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jCRk9-0005tj-UK
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 13:35:38 -0400
Received: from indium.canonical.com ([91.189.90.7]:49566)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jCRk9-0005st-P8
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 13:35:37 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jCRk7-0003cJ-PC
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 17:35:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id A56C02E80C8
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 17:35:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Mar 2020 17:26:56 -0000
From: Peter Collingbourne <1867072@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=In Progress; importance=Undecided;
 assignee=rth@twiddle.net; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: pcc-goog rth
X-Launchpad-Bug-Reporter: Peter Collingbourne (pcc-goog)
X-Launchpad-Bug-Modifier: Peter Collingbourne (pcc-goog)
References: <158397461074.11691.9165479040998830806.malonedeb@soybean.canonical.com>
Message-Id: <158403401628.28469.2199192139830063340.malone@gac.canonical.com>
Subject: [Bug 1867072] Re: ARM: tag bits cleared in FAR_EL1
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="3a6db24bbe7280ec09bae73384238390fcc98ad3";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 2b87f0d00da1d896055c82becbc45c8d57dd3881
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
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
Reply-To: Bug 1867072 <1867072@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With those two patches applied I can no longer reproduce the problem,
thanks!

For posterity, this is how I've been reproducing the problem:

1. Build a Linux kernel with this patch applied: https://patchwork.kernel.o=
rg/patch/11435077/
2. Run this program under the kernel:

#include <stdint.h>
#include <stdio.h>
#include <signal.h>

void handler(int signo, siginfo_t *siginfo, void *context) {
  uint32_t *begin =3D (uint32_t *)context;
  uint32_t *end =3D ((uint32_t *)context) + (sizeof(ucontext_t)/4);
  for (uint32_t *i =3D begin; i !=3D end; ++i) {
    printf("%08p %08x\n", i, *i);
  }
  _exit(0);
}

int main() {
  struct sigaction sa;
  sa.sa_sigaction =3D handler;
  sa.sa_flags =3D SA_SIGINFO;
  sigaction(SIGSEGV, &sa, 0);

  return *(int *)((1ULL << 56) + 0x123456);
}

I would expect this program's output to include something like the
following:

0xffffd5869bd0 46415201
0xffffd5869bd4 00000010
0xffffd5869bd8 00123456
0xffffd5869bdc 01000000

But the output that I was seeing with the bad qemu looked like this:

0xffffd5869bd0 46415201
0xffffd5869bd4 00000010
0xffffd5869bd8 00123456
0xffffd5869bdc 00000000

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1867072

Title:
  ARM: tag bits cleared in FAR_EL1

Status in QEMU:
  In Progress

Bug description:
  The ARM Architecture Reference Manual provides the following for
  FAR_EL1:

  "For a Data Abort or Watchpoint exception, if address tagging is
  enabled for the address accessed by the data access that caused the
  exception, then this field includes the tag."

  However, I have found that the tag bits in FAR_EL1 are always clear,
  even if the tag bits were set in the original access.

  I can reproduce the problem on both 4.1.1 and master
  (6e8a73e911f066527e775e04b98f31ebd19db600).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1867072/+subscriptions

