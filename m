Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351F5C2D0CE
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 04:21:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0360D2070A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 04:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0360D2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuqT7-0000fH-6a
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 23:21:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41775)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iuqSX-0000CT-O5
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 23:20:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iuqSW-0005fm-98
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 23:20:41 -0500
Received: from indium.canonical.com ([91.189.90.7]:56112)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iuqSW-0005dI-3l
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 23:20:40 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iuqSU-0006dc-MW
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 04:20:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 93BC02E8073
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 04:20:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jan 2020 04:12:35 -0000
From: Logan Bateman <1860742@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: bootloop xv6
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: nametable
X-Launchpad-Bug-Reporter: Logan Bateman (nametable)
X-Launchpad-Bug-Modifier: Logan Bateman (nametable)
References: <157983858012.5517.4456579868320256063.malonedeb@chaenomeles.canonical.com>
Message-Id: <157983915593.4679.3358124039014642660.launchpad@soybean.canonical.com>
Subject: [Bug 1860742] Re: xv6 Bootloop
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="b8d1327fd820d6bf500589d6da587d5037c7d88e";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 26fd090cf9bd0d04dcc75b67c626804257c215ae
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
Reply-To: Bug 1860742 <1860742@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Description changed:

  Qemu Version: 4.2.0
  =

- Launch command: =

+ Launch command:
  qemu-system-x86_64 -nographic -drive file=3Dfs.img,index=3D1,media=3Ddisk=
,format=3Draw -drive file=3Dxv6.img,index=3D0,media=3Ddisk,format=3Draw -sm=
p 2 -m 512
  =

- How to reproduce? =

+ How to reproduce?
  1.)  Use/install latest release of qemu (4.2.0 at time of writing)
  =

  2.)  Download, build, and run xv6 (a simple os designed for learning
  operating systems fundamentals)
  =

  cd /tmp
  git clone https://github.com/mit-pdos/xv6-public.git
  cd xv6-public
  make qemu-nox
  =

  3.)  Qemu should now bootloop (seem to try to boot but then just
  repeat). This is what it looks like below before it repeats:
  =

  SeaBIOS (version ?-20191223_100556-anatol)
  =

- iPXE (http://ipxe.org) 00:03.0 CA00 PCI2.10 PnP PMM+1FF92A50+1FEF2A50 CA00
-                                                                          =
      =

+ iPXE (http://ipxe.org) 00:03.0 CA00 PCI2.10 PnP PMM+1FF92A50+1FEF2A50
+ CA00
+ =

  Booting from Hard Disk..
- =

  =

  Host: Arch Linux - Kernel version: 5.4.13
  Guest: xv6 (https://github.com/mit-pdos/xv6-public)
  =

  Suspicion:
  =

- When I was using qemu 2.11.1 inside docker, the xv6 os booted with no
- problem. I am thinking that something changed between Qemu 2.11.1 and
- Qemu 4.2.0 which is now causing boot problems.
+ When I was using qemu 2.11.1 inside an ubuntu docker container, the xv6
+ os booted with no problem. I am thinking that something changed between
+ Qemu 2.11.1 and Qemu 4.2.0 which is now causing boot problems.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1860742

Title:
  xv6 Bootloop

Status in QEMU:
  New

Bug description:
  Qemu Version: 4.2.0

  Launch command:
  qemu-system-x86_64 -nographic -drive file=3Dfs.img,index=3D1,media=3Ddisk=
,format=3Draw -drive file=3Dxv6.img,index=3D0,media=3Ddisk,format=3Draw -sm=
p 2 -m 512

  How to reproduce?
  1.)  Use/install latest release of qemu (4.2.0 at time of writing)

  2.)  Download, build, and run xv6 (a simple os designed for learning
  operating systems fundamentals)

  cd /tmp
  git clone https://github.com/mit-pdos/xv6-public.git
  cd xv6-public
  make qemu-nox

  3.)  Qemu should now bootloop (seem to try to boot but then just
  repeat). This is what it looks like below before it repeats:

  SeaBIOS (version ?-20191223_100556-anatol)

  iPXE (http://ipxe.org) 00:03.0 CA00 PCI2.10 PnP PMM+1FF92A50+1FEF2A50
  CA00

  Booting from Hard Disk..

  Host: Arch Linux - Kernel version: 5.4.13
  Guest: xv6 (https://github.com/mit-pdos/xv6-public)

  Suspicion:

  When I was using qemu 2.11.1 inside an ubuntu docker container, the
  xv6 os booted with no problem. I am thinking that something changed
  between Qemu 2.11.1 and Qemu 4.2.0 which is now causing boot problems.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1860742/+subscriptions

