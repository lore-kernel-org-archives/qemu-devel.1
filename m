Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB15C388F3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 04:07:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84FB4206B7
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 04:07:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84FB4206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iF9Rt-00069X-GZ
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 00:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34541)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iF9R2-0005Ha-Bt
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 00:06:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iF9R1-0007uj-64
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 00:06:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:36914)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iF9R1-0007uV-0s
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 00:06:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iF9R0-0005AD-Aa
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 04:06:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 4AC0E2E8025
 for <qemu-devel@nongnu.org>; Tue,  1 Oct 2019 04:06:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Oct 2019 03:47:44 -0000
From: Thomas Huth <1618265@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Invalid; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: th-huth vans-163
X-Launchpad-Bug-Reporter: vans163 (vans-163)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20160829235224.32680.99105.malonedeb@gac.canonical.com>
Message-Id: <156990166473.20357.11841598504221954818.malone@soybean.canonical.com>
Subject: [Bug 1618265] Re: Loading virtio-input-host-pci drivers before boot?
 To allow using passthrough devices in grub and other preboot menus?
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19066";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 035cc0a6f48dbf82deed858dc9b5f1320741d08d
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
Reply-To: Bug 1618265 <1618265@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This can not be fixed on the QEMU side. If you want to have virtio-input
support in seabios or grub for example, you've got to ask the seabios or
grub project to add it.

** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1618265

Title:
  Loading virtio-input-host-pci drivers before boot? To allow using
  passthrough devices in grub and other preboot menus?

Status in QEMU:
  Invalid

Bug description:
  Currently virtio-input devices cannot be used before the kernel loads.
  This is not really a full bug but it would be much more useful if you
  can use the keyboard+mouse this way.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1618265/+subscriptions

