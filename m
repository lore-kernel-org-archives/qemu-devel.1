Return-Path: <SRS0=IrLN=YF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948A5C10F14
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 15:08:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67B5C206CD
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 15:08:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67B5C206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJJ0K-0000JB-Ug
	for qemu-devel@archiver.kernel.org; Sat, 12 Oct 2019 11:08:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38349)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iJI6V-0001Wt-3l
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 10:10:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iJI6T-0000gC-GL
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 10:10:43 -0400
Received: from indium.canonical.com ([91.189.90.7]:49884)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iJI6T-0000fs-Ap
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 10:10:41 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iJI6R-0001dM-Qh
 for <qemu-devel@nongnu.org>; Sat, 12 Oct 2019 14:10:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id C8F5A2E806E
 for <qemu-devel@nongnu.org>; Sat, 12 Oct 2019 14:10:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Oct 2019 14:05:01 -0000
From: Emanuele Faranda <black.silver@hotmail.it>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: berrange black-silver yakman2020
X-Launchpad-Bug-Reporter: Bruce Campbell (yakman2020)
X-Launchpad-Bug-Modifier: Emanuele Faranda (black-silver)
References: <153012207304.7182.2374266143525192096.malonedeb@soybean.canonical.com>
Message-Id: <157088910158.6203.16185066400804645483.malone@gac.canonical.com>
Subject: [Bug 1778966] Re: Windows 1803 and later crashes on KVM
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="af2eefe214bd95389a09b7c956720881bab16807";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 8455e4ef3600acbf1e2217891003036287ad70c2
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 91.189.90.7
X-Mailman-Approved-At: Sat, 12 Oct 2019 11:06:39 -0400
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
Reply-To: Bug 1778966 <1778966@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I ran into the same problem on threadripper 1900X. I was using cpu type
"host-passthough" and it crashed. I fixed the crash by disabling the MSR
with

kvm.ignore_msrs=3D1

as describe in https://forum.level1techs.com/t/windows-10-1803-as-guest-
with-qemu-kvm-bsod-under-install/127425/10

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1778966

Title:
  Windows 1803 and later crashes on KVM

Status in QEMU:
  New

Bug description:
  For a bionic host, using the current public kvm modules, KVM is not
  capable of booting a WindowsInsider or msdn Windows 1803 Windows
  Server iso. In snstalling from an ISO from a started windows 2016
  guest results in an unbootable and unrepairable guest.

  The hardware is a threadripper 1920x with 32GB of main memory, disk
  mydigital BPX SSD and WD based 4 column RAID 5 via mdadm.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1778966/+subscriptions

