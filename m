Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4A5C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 05:49:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A28C2073F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 05:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A28C2073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45181 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFuUj-0002Sr-C0
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 01:49:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hFqc9-0003hy-AB
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 21:40:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hFqc8-0001EM-9A
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 21:40:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:44366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hFqc5-0001B9-7x
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 21:40:50 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hFqc3-0002Bw-Nr
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 01:40:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id AE66F2E8076
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 01:40:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Apr 2019 01:33:43 -0000
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: ppc
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: shawnanastasio
X-Launchpad-Bug-Reporter: shawn (shawnanastasio)
X-Launchpad-Bug-Modifier: shawn (shawnanastasio)
Message-Id:
 <155529202334.8409.17401063591999151604.malonedeb@wampee.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18920";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: a6f75f6e0a251e7b3b952f7dc062f5717e92481a
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
X-Mailman-Approved-At: Mon, 15 Apr 2019 01:48:14 -0400
Subject: [Qemu-devel] [Bug 1824744] [NEW] ivshmem device PCI device exposes
 wrong endianness on ppc64le
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
From: shawn via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Bug 1824744 <1824744@bugs.launchpad.net>
Cc: shawn <shawnanastasio@yahoo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415013343.91YyjnepvslDL_y7lGDCqss1mEaWjURWqLSqixgueYY@z>

Public bug reported:

On a ppc64le host with a ppc64le guest running on QEMU 3.1.0 when an
ivshmem device is used, the ivshmem device appears to expose the wrong
endianness for the values in BAR 0.

For example, when the guest is assigned an ivshmem device ID of 1, the
IVPosition register (u32, offset 8 in BAR 0) returns 0x1000000 instead
of 0x1. I tested on an x86_64 machine and the IVPosition reads 0x1 as
expected.

It seems possible that there's a ppc64*=3D=3Dbigendian assumption somewhere
that is erroneously affecting ppc64le.

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: ppc

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1824744

Title:
  ivshmem device PCI device exposes wrong endianness on ppc64le

Status in QEMU:
  New

Bug description:
  On a ppc64le host with a ppc64le guest running on QEMU 3.1.0 when an
  ivshmem device is used, the ivshmem device appears to expose the wrong
  endianness for the values in BAR 0.

  For example, when the guest is assigned an ivshmem device ID of 1, the
  IVPosition register (u32, offset 8 in BAR 0) returns 0x1000000 instead
  of 0x1. I tested on an x86_64 machine and the IVPosition reads 0x1 as
  expected.

  It seems possible that there's a ppc64*=3D=3Dbigendian assumption
  somewhere that is erroneously affecting ppc64le.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1824744/+subscriptions

