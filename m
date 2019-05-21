Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AACC04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 05:56:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A343F20856
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 05:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A343F20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46935 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSxlF-0007vN-E4
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 01:56:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hSxkU-0007WE-0e
	for qemu-devel@nongnu.org; Tue, 21 May 2019 01:55:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hSxkT-0000Zj-0l
	for qemu-devel@nongnu.org; Tue, 21 May 2019 01:55:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:33950)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hSxkS-0000ZN-Rk
	for qemu-devel@nongnu.org; Tue, 21 May 2019 01:55:40 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hSxkQ-0007RI-HT
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 05:55:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 761922E80DB
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 05:55:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 May 2019 05:42:03 -0000
From: arseniy <1829498@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ffhguy jnsnow
X-Launchpad-Bug-Reporter: arseniy (ffhguy)
X-Launchpad-Bug-Modifier: arseniy (ffhguy)
References: <155808951981.15307.7632909900341712173.malonedeb@gac.canonical.com>
Message-Id: <155841732343.15101.340068642172654860.malone@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18962";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 7ec94c4c08c330c34ac8167ee1f33989bf1f55d8
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1829498] Re: window 8 stuck during boot on Qemu
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
Reply-To: Bug 1829498 <1829498@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

My host kernel is 4.15.0-47. Windows 8 version is 6.3.9600. About KVM,
i've got same problem in TCG mode.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1829498

Title:
  window 8 stuck during boot on Qemu

Status in QEMU:
  New

Bug description:
  Description of problem:
  I've got windows 8 image(64 bit), installed on Qemu(x86-64_softmmu) and t=
hen i'm trying to boot/shutdown it in the same Qemu configuration. Windows =
8 has feature - when you click "Shutdown" in UI, windows 8 doesn't actually=
 power off, it goes to "Suspend to disc" ACPI state. After shutdown, i'm tr=
ying to boot it again, but it stucks during boot.

  I've discovered, that it hangs when windows 8 writes to AHCI's command re=
gister, AHCI triggers irq, but windows 8 sends EOI, don't accessing AHCI re=
gister,so irq line stills in high state, and irq will be injected again and=
 again, while windows will send EOI on each AHCI interrupt. Strange thing i=
s that it happens only on TCG mode or =

  with option "kernel-irqchip=3Doff/split", with "kernel-irqchip=3Don" ever=
ything works ok(windows 8 accesses AHCI register and line goes to low state=
).

  Version-Release number of selected component (if applicable):
  Qemu revision: d8276573da58e8ce78dab8c46dd660efd664bcb7

  =

  Steps to Reproduce:
  1. Install Windows 8 on QEMU(qemu command line: "-enable-kvm -m 1G -hda <=
image>  -serial stdio  -cpu core2duo -machine q35,kernel-irqchip=3Doff"
  2. Click shutdown in UI.
  3. Try to boot again(it will stuck)
  4. Kill Qemu and boot again, it will boot, now go to 2) :)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1829498/+subscriptions

