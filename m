Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0E6C4646B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 21:47:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2BB2204FD
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 21:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2BB2204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54836 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfWo2-0004q8-Pe
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 17:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51818)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hfWnD-0004Og-W3
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 17:46:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hfWnC-0006UE-3H
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 17:46:27 -0400
Received: from indium.canonical.com ([91.189.90.7]:33428)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hfWnA-0006S2-6i
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 17:46:26 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hfWn6-0000g3-HT
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 21:46:20 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 834512E80CB
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 21:46:20 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Jun 2019 21:33:58 -0000
From: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Committed; importance=Undecided;
 assignee=alex.bennee@linaro.org; 
X-Launchpad-Bug-Tags: regression tcg
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: andrew-randrianasulu
X-Launchpad-Bug-Reporter: Andrew Randrianasulu (andrew-randrianasulu)
X-Launchpad-Bug-Modifier: =?utf-8?q?Alex_Benn=C3=A9e_=28ajbennee=29?=
References: <155962633298.7880.15982922254182327026.malonedeb@wampee.canonical.com>
Message-Id: <156141203898.17093.9390421319287465132.launchpad@wampee.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18991";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: ae8875bbed49a8266bfdeb94d4d5000d722f7940
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1831545] Re: "accel/tcg: demacro cputlb" break
 qemu-system-x86_64 on 32-bit x86 host
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
Reply-To: Bug 1831545 <1831545@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Changed in: qemu
       Status: In Progress =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1831545

Title:
  "accel/tcg: demacro cputlb" break qemu-system-x86_64 on 32-bit x86
  host

Status in QEMU:
  Fix Committed

Bug description:
  As described in https://lists.gnu.org/archive/html/qemu-
  devel//2019-05/msg07362.html I run into TCG regression in qemu-git.

  Unfortunately, fix from bug
  https://bugs.launchpad.net/qemu/+bug/1830872 seems to be nonn-
  effective for my case.

  For reproduction (on 32-bit x86 host, in my case Slackware with gcc
  5.5.0):

  ./configure --target-list=3Dx86_64-softmmu --disable-werror --enable-
  debug-tcg

  make (-j5 in my case)

  try to boot any 64-bit kernel:

  x86_64-softmmu/qemu-system-x86_64 -kernel /boot/bzImage-4.12.0-x64
  -accel tcg

  result is - qemu appear to hang right after "Booting the kernel" line.
  Decompression (xz) was ok.

  Tested with qemu-git commit  e2a58ff493a2e00db3e963c1839c5374500110f2

  32-bit OS can be booted fine, and -enable-kvm also allow 64 bit
  kernel/os to boot.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1831545/+subscriptions

