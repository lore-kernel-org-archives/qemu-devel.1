Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBAFCA9EB9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 19:11:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4AF921872
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 19:11:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4AF921872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNM2g-0001Tt-GS
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 15:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34609)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iNKrF-0004o7-K5
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:55:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iNKrE-0005Rw-Eg
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:55:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:33796)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iNKrE-0005RY-9P
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:55:40 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iNKrD-0006rg-1n
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 17:55:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 067032E8074
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 17:55:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Oct 2019 17:40:41 -0000
From: Eduardo <1596579@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: alex-l-williamson eduardok th-huth
X-Launchpad-Bug-Reporter: Eduardo (eduardok)
X-Launchpad-Bug-Modifier: Eduardo (eduardok)
References: <20160627153749.31174.93791.malonedeb@chaenomeles.canonical.com>
Message-Id: <157185244187.3410.5702145833081104575.malone@gac.canonical.com>
Subject: [Bug 1596579] Re: segfault upon reboot
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="469f241f4e73cc0bdffa4e30654052a2af068e06";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: e891a84927f03796c690080ab23de06acc77bfa0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Reply-To: Bug 1596579 <1596579@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I have no way of reproducing now, should be good by now, I wouldn't
worry about it, just close this, thanks.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1596579

Title:
  segfault upon reboot

Status in QEMU:
  Incomplete

Bug description:
  [   31.167946] VFIO - User Level meta-driver version: 0.3
  [   34.969182] kvm: zapping shadow pages for mmio generation wraparound
  [   43.095077] vfio-pci 0000:1a:00.0: irq 50 for MSI/MSI-X
  [166493.891331] perf interrupt took too long (2506 > 2500), lowering kern=
el.perf_event_max_sample_rate to 50000
  [315765.858431] qemu-kvm[1385]: segfault at 0 ip           (null) sp 0000=
7ffe5430db18 error 14
  [315782.002077] vfio-pci 0000:1a:00.0: transaction is not cleared; procee=
ding with reset anyway
  [315782.910854] mptsas 0000:1a:00.0: Refused to change power state, curre=
ntly in D3
  [315782.911236] mptbase: ioc1: Initiating bringup
  [315782.911238] mptbase: ioc1: WARNING - Unexpected doorbell active!
  [315842.957613] mptbase: ioc1: ERROR - Failed to come READY after reset! =
IocState=3Df0000000
  [315842.957670] mptbase: ioc1: WARNING - ResetHistory bit failed to clear!
  [315842.957675] mptbase: ioc1: ERROR - Diagnostic reset FAILED! (ffffffff=
h)
  [315842.957717] mptbase: ioc1: WARNING - NOT READY WARNING!
  [315842.957720] mptbase: ioc1: ERROR - didn't initialize properly! (-1)
  [315842.957890] mptsas: probe of 0000:1a:00.0 failed with error -1

  The qemu-kvm segfault happens when I issue a reboot on the Windows VM. Th=
e card I have is:
  1a:00.0 SCSI storage controller: LSI Logic / Symbios Logic SAS1068E PCI-E=
xpress Fusion-MPT SAS (rev ff)

  I have two of these cards (bought with many years difference), exact same=
 model, and they fail the same way. I'm using PCI passthrough on this card =
for access to the tape drive.
  This is very easy to reproduce, so feel free to let me know what to try.
  Kernel 3.10.0-327.18.2.el7.x86_64 (Centos 7.2.1511).
  qemu-kvm-1.5.3-105.el7_2.4.x86_64
  Reporting it here because of the segfault, but I guess I might have to op=
en a bug report with mptbase as well?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1596579/+subscriptions

