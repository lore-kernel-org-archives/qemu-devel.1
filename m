Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CC5C10F25
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 04:27:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76E44208C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 04:27:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76E44208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBsxW-0007ir-Lu
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 00:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43707)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jBswe-0006re-TB
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 00:26:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jBswd-0007Rj-Q2
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 00:26:12 -0400
Received: from indium.canonical.com ([91.189.90.7]:41888)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jBswd-0007QS-KX
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 00:26:11 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jBswb-0008Mq-8z
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 04:26:09 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id D401E2E80D2
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 04:26:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Mar 2020 04:17:26 -0000
From: Launchpad Bug Tracker <1656927@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Expired; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: janitor jom-3 th-huth
X-Launchpad-Bug-Reporter: Joan Moreau (jom-3)
X-Launchpad-Bug-Modifier: Launchpad Janitor (janitor)
References: <20170116193627.27340.49782.malonedeb@chaenomeles.canonical.com>
Message-Id: <158390024619.22252.11528267192607324862.malone@loganberry.canonical.com>
Subject: [Bug 1656927] Re: Network (TCP) access regression
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e0878392dc799b267dea80578fa65500a5d74155";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 6fbbf36f02188975450126d15d44b39d838f4741
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
Reply-To: Bug 1656927 <1656927@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1656927

Title:
  Network (TCP) access regression

Status in QEMU:
  Expired

Bug description:
  Starting a VM with

  /usr/bin/qemu-system-x86_64 -machine pc-i440fx-1.7,accel=3Dkvm -usb -usbd=
evice tablet -usbdevice keyboard -enable-kvm -cpu core2duo -smp 2 -drive fi=
le=3Dwinp
  ro.qcow,index=3D0,media=3Ddisk,format=3Dqcow2 -m 4096 -vga vmware -vnc :3=
 -k en-us -device rtl8139,netdev=3Dnic1 -netdev user,id=3Dnic1,smb=3D/data/=
vps/files/,hostfw
  d=3Dtcp::10053-:10053,hostfwd=3Dtcp::3387-:3389 -rtc base=3Dutc,clock=3Dh=
ost -daemonize

  in 2.5.1, all works fine

  in any version after 2.5.1.1, the network terminate TCP connections
  after a certain period .

  To reproduce, starts an app that use always connected TCP sockets (I
  am using Metatrader 4), let it run a an hour, the app does not realize
  the TCP is out of order but the TCP connection is closed by QEMU

  in 2.5.1.x, Metatrader works perfectly

  Thank you for your help

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1656927/+subscriptions

