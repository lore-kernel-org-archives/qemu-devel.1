Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1C6CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 09:13:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2144C2084B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 09:13:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2144C2084B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNCi0-0004ZW-36
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 05:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53040)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iNCax-0000tR-38
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 05:06:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iNCav-0004ZK-6b
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 05:06:19 -0400
Received: from indium.canonical.com ([91.189.90.7]:58044)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iNCat-0004Yb-Nd
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 05:06:17 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iNCar-0002jB-Ei
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 09:06:13 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 21A602E8074
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 09:06:13 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Oct 2019 08:50:48 -0000
From: Michal Suchanek <msuchanek@suse.de>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: bk-rakesh hramrach th-huth
X-Launchpad-Bug-Reporter: bk.rakesh (bk-rakesh)
X-Launchpad-Bug-Modifier: Michal Suchanek (hramrach)
References: <20130619071409.29504.88410.malonedeb@wampee.canonical.com>
Message-Id: <157182064886.25877.235936423402807182.malone@chaenomeles.canonical.com>
Subject: [Bug 1192464] Re: udp checksum computed as 0 not converted to 0xffff, 
 from guest os that share a common linux bridge among multiple guest os
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="186023fa645d8be19d403a76064f0643f510db2f";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 9c3819df8ad3d9f46470efadf4138ac662fa21d0
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
Reply-To: Bug 1192464 <1192464@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Question is where is this zero checksum observed which is not clear from
the report.

If in the guest it is certainly correct.

If in the host it is correct so long as the bridge appears to have
checksum offloading as well. If whatever interface the guest packets
appear to come from is not set up with checksum offloading this is a bug
which should be fixed by setting the offload flags to match the guest.

If outside the host this is a problem.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1192464

Title:
  udp checksum computed as 0 not converted to 0xffff, from guest os that
  share a common linux bridge among multiple guest os

Status in QEMU:
  Incomplete

Bug description:
  UDP checksum computed as '0' during transmission of packets that uses
  e1000 NIC in the Guest as well as emulated h/w in the qemu layer, That
  needs to be converted to 0xffff, This occurs only when Hardware
  checksum offload is been set in the guest OS NIC and made it as a
  transmitter. The guest O.S use the N/W interface that is been shared
  to the linux brige created in the host (used source=3D<bridge>) in the
  xml tags of libvirt.

  As per RFC768(http://tools.ietf.org/html/rfc768 [^]), If the computed
  checksum is zero, it is transmitted as all ones (the equivalent in
  one's complement arithmetic). An all zero transmitted checksum value
  means that the transmitter generated no checksum (for debugging or for
  higher level protocols that don't care).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1192464/+subscriptions

