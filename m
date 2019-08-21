Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6473FC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 03:51:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B9AF22DA7
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 03:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B9AF22DA7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Hf2-0003Np-8I
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 23:51:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47502)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1i0HeP-0002wt-TK
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 23:51:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1i0HeO-0004vA-R5
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 23:51:09 -0400
Received: from indium.canonical.com ([91.189.90.7]:34988)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1i0HeO-0004uZ-LS
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 23:51:08 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1i0HeM-00087l-TV
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 03:51:06 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id C555B2E807E
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 03:51:06 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Aug 2019 03:42:04 -0000
From: Brad Parker <1819289@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: cbparker curryrice71 dgilbert-h philmd pmaydell
X-Launchpad-Bug-Reporter: John M (curryrice71)
X-Launchpad-Bug-Modifier: Brad Parker (cbparker)
References: <155216177409.9624.16357609956497374456.malonedeb@gac.canonical.com>
Message-Id: <156635892465.26559.12940677354754486239.malone@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19022";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: a26d239688c6bc9873d4c5c516e80a419ddc959c
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1819289] Re: Windows 95 and Windows 98 will not
 install or run
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
Reply-To: Bug 1819289 <1819289@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Just finished a bisect between cfcca36 (working) and current master (not
working), here is the result:

$ git bisect bad
cd1bfd5ef336166b275a09dc9842542bf5e63ae3 is the first bad commit
commit cd1bfd5ef336166b275a09dc9842542bf5e63ae3
Author: Gerd Hoffmann <kraxel@redhat.com>
Date:   Wed Jun 20 12:17:34 2018 +0200

    seabios: update bios and vgabios binaries
    =

    Adds two new vgabios binaries, for ramfb and bochs-display.
    =

    Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

 pc-bios/bios-256k.bin             | Bin 262144 -> 262144 bytes
 pc-bios/bios.bin                  | Bin 131072 -> 131072 bytes
 pc-bios/vgabios-bochs-display.bin | Bin 0 -> 27648 bytes
 pc-bios/vgabios-cirrus.bin        | Bin 38400 -> 38400 bytes
 pc-bios/vgabios-qxl.bin           | Bin 38912 -> 38912 bytes
 pc-bios/vgabios-ramfb.bin         | Bin 0 -> 28160 bytes
 pc-bios/vgabios-stdvga.bin        | Bin 38912 -> 38912 bytes
 pc-bios/vgabios-virtio.bin        | Bin 38912 -> 38912 bytes
 pc-bios/vgabios-vmware.bin        | Bin 38912 -> 38912 bytes
 pc-bios/vgabios.bin               | Bin 38400 -> 38400 bytes
 10 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 pc-bios/vgabios-bochs-display.bin
 create mode 100644 pc-bios/vgabios-ramfb.bin

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1819289

Title:
  Windows 95 and Windows 98 will not install or run

Status in QEMU:
  New

Bug description:
  The last version of QEMU I have been able to run Windows 95 or Windows
  98 on was 2.7 or 2.8. Recent versions since then even up to 3.1 will
  either not install or will not run 95 or 98 at all. I have tried every
  combination of options like isapc or no isapc, cpu pentium  or cpu as
  486. Tried different memory configurations, but they just don't work
  anymore.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1819289/+subscriptions

