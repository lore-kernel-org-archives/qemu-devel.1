Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D186CA9EC3
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 06:48:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BB112083E
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 06:48:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BB112083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQ4FU-0001pL-U9
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 02:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45143)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iQ4DI-0000P2-MN
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 02:45:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iQ4DB-0006sx-EZ
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 02:45:39 -0400
Received: from indium.canonical.com ([91.189.90.7]:50674)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iQ4DB-0006s3-8x
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 02:45:37 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iQ4D9-0004cH-Fe
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2019 06:45:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 739502E80C0
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2019 06:45:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 31 Oct 2019 06:35:44 -0000
From: Leoyzen Liu <1850751@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: leoyzen
X-Launchpad-Bug-Reporter: Leoyzen Liu (leoyzen)
X-Launchpad-Bug-Modifier: Leoyzen Liu (leoyzen)
Message-Id: <157250374407.2833.9906203607973467907.malonedeb@gac.canonical.com>
Subject: [Bug 1850751] [NEW] kvm flag is not exposed by default
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="469f241f4e73cc0bdffa4e30654052a2af068e06";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 429bf9479833b53ca762b720007789211d3aa680
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
Reply-To: Bug 1850751 <1850751@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Hi I found that the kvm flags is not exposed by default, but according
to the source code, it should be exposed by default when the CPU Model
is a X86CPU.

we have to specifically add "kvm=3Don" in QEMU custom cpu args like this to=
 make VMWare Timing and KVM-Clock work:
<qemu:arg value=3D'host,kvm=3Don,+invtsc,+hypervisor'/>

Also the libvirt can't expose kvm because of this (libvirt assumes the
kvm flag is exposed by default in QEMU, so only "kvm hidden =3D 'true'"
can be used to disable the kvm expose flag.

I'm using QEMU 4.1.0 and libvirt 20190803.

** Affects: qemu
     Importance: Undecided
         Status: New

** Description changed:

  Hi I found that the kvm flags is not exposed by default, but according
  to the source code, it should be exposed by default when the CPU Model
  is a X86CPU.
  =

- we have to specifically add "kvm=3Don" in QEMU custom cpu args like this:
+ we have to specifically add "kvm=3Don" in QEMU custom cpu args like this =
to make VMWare Timing and KVM-Clock work:
  <qemu:arg value=3D'host,kvm=3Don,+invtsc,+hypervisor'/>
  =

  Also the libvirt can't expose kvm because this (libvirt assumes the kvm
  flag is exposed by default, only "kvm hidden =3D 'true'" can be used.
+ =

+ I'm using QEMU 4.1.0 and libvirt 20190803.

** Description changed:

  Hi I found that the kvm flags is not exposed by default, but according
  to the source code, it should be exposed by default when the CPU Model
  is a X86CPU.
  =

  we have to specifically add "kvm=3Don" in QEMU custom cpu args like this =
to make VMWare Timing and KVM-Clock work:
  <qemu:arg value=3D'host,kvm=3Don,+invtsc,+hypervisor'/>
  =

- Also the libvirt can't expose kvm because this (libvirt assumes the kvm
- flag is exposed by default, only "kvm hidden =3D 'true'" can be used.
+ Also the libvirt can't expose kvm because of this (libvirt assumes the
+ kvm flag is exposed by default in QEMU, so only "kvm hidden =3D 'true'"
+ can be used to disable the kvm expose flag.
  =

  I'm using QEMU 4.1.0 and libvirt 20190803.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1850751

Title:
  kvm flag is not exposed by default

Status in QEMU:
  New

Bug description:
  Hi I found that the kvm flags is not exposed by default, but according
  to the source code, it should be exposed by default when the CPU Model
  is a X86CPU.

  we have to specifically add "kvm=3Don" in QEMU custom cpu args like this =
to make VMWare Timing and KVM-Clock work:
  <qemu:arg value=3D'host,kvm=3Don,+invtsc,+hypervisor'/>

  Also the libvirt can't expose kvm because of this (libvirt assumes the
  kvm flag is exposed by default in QEMU, so only "kvm hidden =3D 'true'"
  can be used to disable the kvm expose flag.

  I'm using QEMU 4.1.0 and libvirt 20190803.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1850751/+subscriptions

