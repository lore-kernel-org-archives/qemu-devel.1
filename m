Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFAAC4BA3B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 12:12:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A04552468E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 12:12:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A04552468E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7I1P-00053C-Sz
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 07:12:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57716)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1j7I0B-00045o-I2
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 07:10:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1j7I0A-0002Ia-6t
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 07:10:51 -0500
Received: from indium.canonical.com ([91.189.90.7]:59002)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1j7I0A-0002I6-1B
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 07:10:50 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1j7I08-0001EB-Ji
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 12:10:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 8B2A12E804B
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 12:10:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Feb 2020 11:59:23 -0000
From: Gerd Hoffmann <1864984@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: kraxel-redhat valentin.david
X-Launchpad-Bug-Reporter: Valentin David (valentin.david)
X-Launchpad-Bug-Modifier: Gerd Hoffmann (kraxel-redhat)
References: <158279885836.19592.16795975857735049927.malonedeb@chaenomeles.canonical.com>
Message-Id: <158280476315.14511.10448100438712971959.malone@soybean.canonical.com>
Subject: [Bug 1864984] Re: "nr_entries is too big" when using virgl
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="9eff1c37c1740693bdcba94d8f8c608164af5689";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: a24c95cc02e16e00c2a9c93268191eff1b1c981f
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
Reply-To: Bug 1864984 <1864984@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

/me wonders what gnome shell is doing there ...

It is the number of scatter list entries for resources.  Even in the worst =
case (no chunks are continous in memory so each single page needs an entry)=
 this is enough for 64 MB.  An 4k display
framebuffer needs less than that.

Removing the limit isn't an option.  Raising maybe.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1864984

Title:
  "nr_entries is too big" when using virgl

Status in QEMU:
  New

Bug description:
  I have a bootable image where GNOME Shell fails because it hits a
  limit in virtio-gpu.

  In `hw/display/virtio-gpu.c`, there is a limit for `nr_entries` at
  16384. There is no explanation for that limit. But there does not seem
  to be any limit on the kernel side.

  Raising this limit with a patch to 262144 solves the issue.

  Could there be an explanation why this limit is needed? And why this
  value? Or could this limit be just removed?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1864984/+subscriptions

