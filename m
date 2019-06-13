Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C37C31E46
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 00:21:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C25D20B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 00:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C25D20B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36292 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbDUq-0007t6-BG
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 20:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48457)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hbDTw-0006vK-Rx
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 20:20:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hbDTv-00060G-Hj
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 20:20:44 -0400
Received: from indium.canonical.com ([91.189.90.7]:35578)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hbDTv-0005zj-8V
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 20:20:43 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hbDTu-0004lT-CS
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 00:20:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 5C4F52E800F
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 00:20:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Jun 2019 00:14:38 -0000
From: Mason Back <1774853@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: alexaltea masonleeback tsiros
X-Launchpad-Bug-Reporter: tsiros (tsiros)
X-Launchpad-Bug-Modifier: Mason Back (masonleeback)
References: <152802310962.26200.2575137842813128178.malonedeb@wampee.canonical.com>
Message-Id: <156038487853.30940.15696613907398554463.malone@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18978";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 14eb40d2b2f5bc3e6c00a915faa4204aed5c5ed3
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1774853] Re: claims temp file is used by another
 process
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
Reply-To: Bug 1774853 <1774853@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi there! Our fork of QEMU still happens to have this issue. Did you
happen to find a solution?

$ ../orbital-qemu/ps4-softmmu/qemu-system-ps4 -bios ./ubios.bin -kernel ./b=
oot.img -drive file=3Dhdd.qcow2 -drive file=3Dfat:rw:sflash/,media=3Ddisk -=
monitor stdio -smp 8 -display orbital
vvfat sflash/ chs 1024,16,63
C:\tools\msys64\home\Alex\orbital\orbital-qemu\ps4-softmmu\qemu-system-ps4.=
exe: -drive file=3Dfat:rw:sflash/,media=3Ddisk: Could not open 'C:\tools\ms=
ys64\tmp\qem1DF0.tmp': The process cannot access the file because it is bei=
ng used by another process.

** Changed in: qemu
       Status: Invalid =3D> New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1774853

Title:
  claims temp file is used by another process

Status in QEMU:
  New

Bug description:
  QEMU emulator version 2.12.50 (v2.12.0-12378-g99a34dc4d2-dirty)

  "c:\Program Files\qemu\qemu-system-x86_64.exe" -net none -parallel none -=
bios OVMF.fd -L . -hda fat:rw:image
  vvfat image chs 1024,16,63
  c:\Program Files\qemu\qemu-system-x86_64.exe: -hda fat:rw:image: Could no=
t open 'C:\Users\tsiros\AppData\Local\Temp\qem5B92.tmp': The process cannot=
 access the file because it is being used by another process.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1774853/+subscriptions

