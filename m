Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621CCC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 09:36:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A3522068F
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 09:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A3522068F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXisy-0002iQ-0n
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 04:36:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35879)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iXisA-0001fa-Ey
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 04:35:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iXis8-0007CK-Sc
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 04:35:34 -0500
Received: from indium.canonical.com ([91.189.90.7]:42632)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iXis8-0007C4-NT
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 04:35:32 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iXis6-0006wo-Sw
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 09:35:30 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id D602D2E806D
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 09:35:30 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 Nov 2019 09:28:23 -0000
From: Spencer Yu <1853429@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: yushb
X-Launchpad-Bug-Reporter: Spencer Yu (yushb)
X-Launchpad-Bug-Modifier: Spencer Yu (yushb)
Message-Id: <157432850401.22889.9178893768216767833.malonedeb@chaenomeles.canonical.com>
Subject: [Bug 1853429] [NEW] qemu-kvm on aarch64 attach volume failed when vm
 is booting
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="c597c3229eb023b1e626162d5947141bf7befb13";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 20621fbba3e53a637a856a813e0cebe4e56f1fbc
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
Reply-To: Bug 1853429 <1853429@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

I use libvirt and qemu-kvm on aarch64 platform to attach volume to a
booting vm=EF=BC=8Cwhen the system of vm has not boot up, attach volume wil=
l be
failed, after vm system booting up, attach volume can be successful.

libvirt: 4.5.0
qemu : 2.12.0

console log and qemu command of vm is in attachment.

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "aarch64=E8=99=9A=E6=9C=BA=E7=B3=BB=E7=BB=9F=E6=9C=AA=
=E5=90=AF=E5=8A=A8=E6=8C=82=E8=BD=BD=E7=9B=98qemu=E5=91=BD=E4=BB=A4.txt"
   https://bugs.launchpad.net/bugs/1853429/+attachment/5306838/+files/aarch=
64%E8%99%9A%E6%9C%BA%E7%B3%BB%E7%BB%9F%E6%9C%AA%E5%90%AF%E5%8A%A8%E6%8C%82%=
E8%BD%BD%E7%9B%98qemu%E5%91%BD%E4%BB%A4.txt

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1853429

Title:
  qemu-kvm on aarch64 attach volume failed when vm is booting

Status in QEMU:
  New

Bug description:
  I use libvirt and qemu-kvm on aarch64 platform to attach volume to a
  booting vm=EF=BC=8Cwhen the system of vm has not boot up, attach volume w=
ill
  be failed, after vm system booting up, attach volume can be
  successful.

  libvirt: 4.5.0
  qemu : 2.12.0

  console log and qemu command of vm is in attachment.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1853429/+subscriptions

