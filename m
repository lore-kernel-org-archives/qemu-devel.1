Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B33AC2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 21:31:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69DF620709
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 21:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69DF620709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijVIz-000514-HC
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 16:31:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42632)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1ijVIH-0004cC-L7
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 16:31:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1ijVIG-00089L-En
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 16:31:13 -0500
Received: from indium.canonical.com ([91.189.90.7]:52084)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1ijVIG-00088C-9O
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 16:31:12 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1ijVID-0001Nk-Ff
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2019 21:31:09 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 0B24E2E80D5
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2019 21:31:07 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Dec 2019 21:21:16 -0000
From: John Snow <1835477@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: jnsnow moshloop
X-Launchpad-Bug-Reporter: Moshe Immerman (moshloop)
X-Launchpad-Bug-Modifier: John Snow (jnsnow)
X-Launchpad-Bug-Duplicate: 1776920
References: <156230276883.25246.16130789765520855631.malonedeb@soybean.canonical.com>
Message-Id: <157713607606.5838.11849703681567954989.malone@gac.canonical.com>
Subject: [Bug 1835477] Re: Converting qcow2 to vmdk on MacOSX results in a
 non-bootable image
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="bceb5ef013b87ef7aafe0755545ceb689ca7ac60";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: a2a228691ab01b7c0d06215d0f96ada0a9d510f5
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
Reply-To: Bug 1835477 <1835477@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

*** This bug is a duplicate of bug 1776920 ***
    https://bugs.launchpad.net/bugs/1776920

Does the problem happen only when the image is on APFS? when the
destination is on APFS? Neither? Try to see if it's the filesystem. Use
OSX to convert images on a non-APFS formatted external drive to see if
that improves your luck.

I'm assuming this is a duplicate of 1776920 which is still open because
we have no OSX developers willing or able to debug this problem.

** This bug has been marked a duplicate of bug 1776920
   qemu-img convert on Mac OSX creates corrupt images

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

