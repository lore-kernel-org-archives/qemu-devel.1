Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EE0C7114E
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 23:07:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 136BB2083B
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 23:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 136BB2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55457 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j36XE-0002Lg-8X
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 18:07:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59466)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1j36VH-0007Vl-Cp
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 18:05:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1j36VG-0002IL-5x
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 18:05:39 -0500
Received: from indium.canonical.com ([91.189.90.7]:57424)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1j36VF-0002Ew-JY
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 18:05:38 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1j36VE-0006ol-EC
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2020 23:05:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 66E3E2E8054
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2020 23:05:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Feb 2020 22:56:13 -0000
From: Ayman Khamouma <1863445@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ak42
X-Launchpad-Bug-Reporter: Ayman Khamouma (ak42)
X-Launchpad-Bug-Modifier: Ayman Khamouma (ak42)
References: <158180717472.31124.817430819772209101.malonedeb@wampee.canonical.com>
Message-Id: <158180737348.24554.5160695425889904580.malone@gac.canonical.com>
Subject: [Bug 1863445] Re: assertion failed at translate-all.c:2523 with
 version 3.1.1 
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="19413b719a8df7423ab1390528edadce9e0e4aca";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 92f708fa9e6537cfb624673f559aed96b9692ec9
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
Reply-To: Bug 1863445 <1863445@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

tested on fedora 30:
```
uname -a
Linux bigfoot.home.ak42.io 5.4.18-100.fc30.x86_64 #1 SMP Fri Feb 7 14:37:00=
 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
```

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1863445

Title:
  assertion failed at translate-all.c:2523 with version 3.1.1

Status in QEMU:
  New

Bug description:
  I was trying to debug a userspace binary with radare2 and met the
  following assertion in qemu:

  ```
  qemu-mipsel: /builddir/build/BUILD/qemu-3.1.1/accel/tcg/translate-all.c:2=
523: page_check_range: Assertion `start < ((target_ulong)1 << L1_MAP_ADDR_S=
PACE_BITS)' failed.
  qemu:handle_cpu_signal received signal outside vCPU context @ pc=3D0x7fd1=
c11c5987
  ```

  ```
  # qemu-mipsel --version                                                  =
                                 =

  qemu-mipsel version 3.1.1 (qemu-3.1.1-2.fc30)
  Copyright (c) 2003-2018 Fabrice Bellard and the QEMU Project developers
  ```

  not much to add. seems like qemu is not properly checking for valid
  addresses

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1863445/+subscriptions

