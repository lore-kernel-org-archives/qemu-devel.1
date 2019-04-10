Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40904C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 07:21:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E9962070D
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 07:21:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E9962070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54864 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hE7Y4-0001ZT-9P
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 03:21:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hE7XB-0001Fr-J4
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 03:20:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hE7XA-0005Rh-H8
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 03:20:37 -0400
Received: from indium.canonical.com ([91.189.90.7]:37702)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hE7XA-0005RG-9n
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 03:20:36 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hE7X9-0006GO-2e
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 07:20:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 056AA2E80C9
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 07:20:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Apr 2019 07:14:29 -0000
From: Chen Zhang <1823831@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: hvf osx
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: cuser2
X-Launchpad-Bug-Reporter: Chen Zhang (cuser2)
X-Launchpad-Bug-Modifier: Chen Zhang (cuser2)
References: <155478160922.20745.7830680070590942423.malonedeb@chaenomeles.canonical.com>
Message-Id:
 <155488046945.20785.17246810099498141171.malone@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18920";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 81ea7363cb00cac1084cc40ceddc3e07a7cafb4c
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1823831] Re: BSD bootloader halts with
 hypervisor.framework
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1823831 <1823831@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410071429.iCDRUPwij3Nvz9Hxu5XamheSByDMuJabeaTjRlcSCFA@z>

Git bisect shows that 92d5f1a4147c3722b5e9a8bcfb7dc261b7a8b855 is the
first bad commit.

Author: Paolo Bonzini <pbonzini@redhat.com>
Date:   Tue Aug 21 15:31:24 2018 +0200

    target/i386: unify masking of interrupts
    =

    Interrupt handling depends on various flags in env->hflags or env->hfla=
gs2,
    and the exact detail were not exactly replicated between x86_cpu_has_wo=
rk
    and x86_cpu_exec_interrupt.  Create a new function that extracts the
    highest-priority non-masked interrupt, and use it in both functions.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1823831

Title:
  BSD bootloader halts with hypervisor.framework

Status in QEMU:
  New

Bug description:
  Guest: FreeBSD 12.0 Install CD
  Host: MacOS 11.14.3 qemu master at 90fb864a7df0a9af677352e94f8225f7b03de9=
22

  Command arguments:

  qemu-system-x86_64 -m 4000m -cdrom Downloads/FreeBSD-12.0-RELEASE-
  amd64-bootonly.iso

  When qemu was run with -accel hvf, the bootloader would halt after
  showing the menu. The bootloader would not respond to any keyboard
  events.

  Without acceleration option, the bootloader would count down to zero
  and proceed.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1823831/+subscriptions

