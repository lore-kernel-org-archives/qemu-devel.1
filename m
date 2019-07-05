Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFDFC5B57D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 05:06:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1A3F21852
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 05:06:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1A3F21852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjGQc-0003FI-RP
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 01:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50011)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hjGPj-0002o7-9R
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 01:05:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hjGPi-0008M0-Ar
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 01:05:39 -0400
Received: from indium.canonical.com ([91.189.90.7]:49524)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hjGPi-0008Kc-52
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 01:05:38 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hjGPf-00083p-LD
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 05:05:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 9ABEB2E804B
 for <qemu-devel@nongnu.org>; Fri,  5 Jul 2019 05:05:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jul 2019 04:59:28 -0000
From: Moshe Immerman <1835477@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: moshloop
X-Launchpad-Bug-Reporter: Moshe Immerman (moshloop)
X-Launchpad-Bug-Modifier: Moshe Immerman (moshloop)
Message-Id: <156230276883.25246.16130789765520855631.malonedeb@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19007";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 9aa382d60d817d35126f65bfefb191002744030c
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1835477] [NEW] Converting qcow2 to vmdk on MacOSX
 results in a non-bootable image
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
Reply-To: Bug 1835477 <1835477@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

When using qemu-img convert -O vmdk  with version 3.1.0 or 4.0.0 on OSX
(10.14.3) with a qcow2 image  (https://cloud-
images.ubuntu.com/bionic/20190703/bionic-server-cloudimg-amd64.img), the
resulting image is not bootable.

Running the same command on Ubuntu 18.04 results in a bootable image as
expected

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1835477

Title:
  Converting qcow2 to vmdk on MacOSX results in a non-bootable image

Status in QEMU:
  New

Bug description:
  When using qemu-img convert -O vmdk  with version 3.1.0 or 4.0.0 on
  OSX (10.14.3) with a qcow2 image  (https://cloud-
  images.ubuntu.com/bionic/20190703/bionic-server-cloudimg-amd64.img),
  the resulting image is not bootable.

  Running the same command on Ubuntu 18.04 results in a bootable image
  as expected

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1835477/+subscriptions

