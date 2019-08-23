Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1135BC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 14:22:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6B3422CE3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 14:22:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6B3422CE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1ASG-0006DV-Nn
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 10:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48117)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1i1AQm-0004uz-Bo
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:20:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1i1AQk-0000Jo-SV
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:20:44 -0400
Received: from indium.canonical.com ([91.189.90.7]:46294)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1i1AQk-0000J6-KK
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:20:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1i1AQi-0005Xd-P8
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 14:20:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id BB0192E80CD
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 14:20:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Aug 2019 14:15:13 -0000
From: Bilal Wasim <1724590@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Wishlist; assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: bwasim123 samuel-thibault willemmaster-hotmail
X-Launchpad-Bug-Reporter: Willem Mulder (willemmaster-hotmail)
X-Launchpad-Bug-Modifier: Bilal Wasim (bwasim123)
References: <150833765599.17635.13860559072232712887.malonedeb@gac.canonical.com>
Message-Id: <156656971397.2597.5973308798225466710.malone@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19031";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: d59fcfe0aa06cc2217d4c13938359a91a2b0343b
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1724590] Re: Usermode networking hostfwd only
 listens on IPv4
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
Reply-To: Bug 1724590 <1724590@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Guys - I'm currently trying to use IPv6 with QEMU on ARM / AARCH64 Model=
s (Sabre-Lite / Zync SOCs) and I see this problem. The system gets an IPv6 =
address from the QEMU in-built router which can be used to ping the default=
 gateway (the dhcp router itself). All this is good but not really useful a=
s I want to communicate with a TCP6 client on the host (Windows / Linux) ma=
chine running on port 8080. I've added the co-responding port mappings (lik=
e I do with IPv4) but I never receive packets from the host OS which is thi=
s issue. So I have the following questions, =

- It seems that this issue is still open and on the wishlist. Is this corre=
ct ? If so, is there any ETA to when someone will take this up ? If none, m=
ay be I can look at this ;-).. I'm currently using QEMU 3.0
- Assuming that its not working, what are the alternatives that I can use ?=
 I understand that there is TAP-TUN Networking where the QEMU model can com=
municate with the hardware interface over a bridge.. This should work with =
IPv6.. Can you confirm ?

This needs quick closure on my side and so quick comments will be
appreciated..

Thanks, =

Bilal

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1724590

Title:
  Usermode networking hostfwd only listens on IPv4

Status in QEMU:
  New

Bug description:
  When forwarding ports in usermode networking (-net user,hostfwd=3D),
  QEMU binds to IPv4 only. Therefore, connecting to the port over IPv6
  results in 'connection refused'.

  I experienced this in QEMU 2.10.1, but it looks to still be present in
  the current master (861cd431c99e56ddb5953ca1da164a9c32b477ca), since
  slirp_hostfwd in net/slirp.c uses in_addr instead of in6_addr.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1724590/+subscriptions

