Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1384C54FCB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 15:47:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0D252075A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 15:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0D252075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS0YD-0004qY-L5
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 11:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57566)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jS0Rp-0002W2-E7
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 11:41:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jS0Ro-0001oW-P4
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 11:41:01 -0400
Received: from indium.canonical.com ([91.189.90.7]:59766)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jS0Ro-0001iD-AQ
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 11:41:00 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jS0Rm-0002Ht-2x
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2020 15:40:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id DB0082E8076
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2020 15:40:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2020 15:35:05 -0000
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: 8-deller philmd
X-Launchpad-Bug-Reporter: Helge Deller (8-deller)
X-Launchpad-Bug-Modifier: Helge Deller (8-deller)
References: <158767392171.23001.17996085062254045820.malonedeb@chaenomeles.canonical.com>
Message-Id: <158774250536.17144.8266268746457869041.malone@wampee.canonical.com>
Subject: [Bug 1874539] Re: tulip driver broken in v5.0.0-rc4
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="486bbbd6cb608f8eb468ed0d08689a349dfabe49";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 7d4371dd4aa3d431c9c4931b44f2f5290fd0c184
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 11:40:58
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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
Reply-To: Bug 1874539 <1874539@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Attached trivial patch fixes it.


** Attachment added: "patch to fix tulip rx hangs"
   https://bugs.launchpad.net/qemu/+bug/1874539/+attachment/5359564/+files/=
p2

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1874539

Title:
  tulip driver broken in v5.0.0-rc4

Status in QEMU:
  New

Bug description:
  In a qemu-system-hppa system, qemu release v5.0.0-rc, the tulip nic drive=
r is broken.
  The tulip nic is detected, even getting DHCP info does work.
  But when trying to download bigger files via network, the tulip driver ge=
ts stuck.

  For example when trying to download a 100MB file:

  root@debian:~# wget https://speed.hetzner.de/100MB.bin
  --2020-04-23 20:26:43--  https://speed.hetzner.de/100MB.bin
  Resolving speed.hetzner.de (speed.hetzner.de)... 88.198.248.254, 2a01:4f8=
:0:59ed::2
  Connecting to speed.hetzner.de (speed.hetzner.de)|88.198.248.254|:443... =
connected.
  <waiting and stuck here>

  When reverting this commit, everything works again:
  commit 8ffb7265af64ec81748335ec8f20e7ab542c3850
  Author: Prasad J Pandit <pjp@fedoraproject.org>
  Date:   Tue Mar 24 22:57:22 2020 +0530
  PATCH: net: tulip: check frame size and r/w data length

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1874539/+subscriptions

