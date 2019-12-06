Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=FORGED_HOTMAIL_RCVD2,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DA5C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 03:01:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0E802173E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 03:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0E802173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1id3sQ-000434-Tt
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 22:01:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51082)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1id3rg-0003eI-52
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 22:01:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1id3re-0002lC-Gp
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 22:01:07 -0500
Received: from indium.canonical.com ([91.189.90.7]:39958)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1id3rc-0002iI-C3
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 22:01:06 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1id3rY-0006vK-7Q
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 03:01:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 108182E80CF
 for <qemu-devel@nongnu.org>; Fri,  6 Dec 2019 03:01:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Dec 2019 02:52:48 -0000
From: wzis <wzis@hotmail.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: sparc
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: mark-cave-ayland michal-nowak-b wzis
X-Launchpad-Bug-Reporter: Michal Nowak (michal-nowak-b)
X-Launchpad-Bug-Modifier: wzis (wzis)
References: <20170305190118.21996.2136.malonedeb@gac.canonical.com>
Message-Id: <157560076861.21339.15386387648150298716.malone@soybean.canonical.com>
Subject: [Bug 1670175] Re: qemu-system-sparc64 with tribblix-sparc-0m16.iso
 ends with "panic - kernel: no nucleus hblk8 to allocate"
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="c597c3229eb023b1e626162d5947141bf7befb13";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: b9be3b09a402ce62ecd657d83d83d56ad04ec956
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
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
Reply-To: Bug 1670175 <1670175@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qemu sparc64 also failed to boot Oracle Linux

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1670175

Title:
  qemu-system-sparc64 with tribblix-sparc-0m16.iso ends with "panic -
  kernel: no nucleus hblk8 to allocate"

Status in QEMU:
  New

Bug description:
  > qemu-system-sparc64 -m 1024 -cdrom Downloads/tribblix-sparc-0m16.iso -b=
oot d -nographic
  OpenBIOS for Sparc64
  Configuration device id QEMU version 1 machine id 0
  kernel cmdline =

  CPUs: 1 x SUNW,UltraSPARC-IIi
  UUID: 00000000-0000-0000-0000-000000000000
  Welcome to OpenBIOS v1.1 built on Nov 24 2016 21:23
    Type 'help' for detailed information
  Trying cdrom:f...
  Not a bootable ELF image
  Not a bootable a.out image

  Loading FCode image...
  Loaded 7120 bytes
  entry point is 0x4000
  Evaluating FCode...
  Evaluating FCode...
  Ignoring failed claim for va 10a96a0 memsz 19!
  Ignoring failed claim for va 1000000 memsz d1fb6!
  Ignoring failed claim for va 1402000 memsz 32518!
  Ignoring failed claim for va 1800000 memsz 52ac8!
  SunOS Release 5.11 Version tribblix-m16 64-bit
  Copyright (c) 1983, 2010, Oracle and/or its affiliates. All rights reserv=
ed.
  could not find debugger-vocabulary-hook>threads:interpret: exception -13 =
caught
  interpret \ ident	"%Z%%M%	%I%	%E% SMI"
  \ Copyright 2005 Sun Microsystems, Inc.  All rights reserved.
  \ Use is subject to license terms.
  \
  \ CDDL HEADER START
  \
  \ The contents of this file are subject to the terms of the
  \ Common Development and Distribution License, Version 1.0 only
  \ (the "License").  You may not use this file except in compliance
  \ with the License.
  \
  \ You can obtain a copy of the license at usr/src/OPENSOLARIS.LICENSE
  \ or http://www.opensolaris.org/os/licensing.
  \ See the License for =

  WARNING: add_spec: No major number for sf
  panic - kernel: no nucleus hblk8 to allocate
  EXIT

  QEMU keeps running (CPU is on 100 % all the time), I can interact with
  the prompt:

  0 > boot
  Not a Linux kernel image
  Not a bootable ELF image
  Not a bootable a.out image

  Loading FCode image...
  Unhandled Exception 0x0000000000000018
  PC =3D 0x00000000ffd25310 NPC =3D 0x00000000ffd25314
  Stopping execution

  > qemu-system-sparc64 -version
  QEMU emulator version 2.8.0(Virtualization:Staging / SLE_12_SP2)

  from
  https://build.opensuse.org/package/show/Virtualization:Staging/qemu on
  openSUSE Leap 42.2.

  ISO: http://pkgs.tribblix.org/iso/tribblix-sparc-0m16.iso.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1670175/+subscriptions

