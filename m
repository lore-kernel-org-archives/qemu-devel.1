Return-Path: <SRS0=rO5d=BF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1E0C433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2020 04:11:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2E7920674
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2020 04:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2E7920674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzY0R-0000j6-7h
	for qemu-devel@archiver.kernel.org; Sun, 26 Jul 2020 00:11:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jzXzt-0000JW-6g
 for qemu-devel@nongnu.org; Sun, 26 Jul 2020 00:10:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:47994)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jzXzr-0003bF-C2
 for qemu-devel@nongnu.org; Sun, 26 Jul 2020 00:10:48 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jzXzp-0005Ze-FK
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2020 04:10:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 474B62E80E7
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2020 04:10:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2020 03:57:51 -0000
From: Naresh GS <1888971@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: nareshgs
X-Launchpad-Bug-Reporter: Naresh GS (nareshgs)
X-Launchpad-Bug-Modifier: Naresh GS (nareshgs)
Message-Id: <159573587135.29737.8295812528041177661.malonedeb@chaenomeles.canonical.com>
Subject: [Bug 1888971] [NEW] SMI trigger causes hang with multiple cores
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e85d0ab92e2924d39b8285aeae075a01d25eff06";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: dab1d9cf5e73a9a5b5917087089b1a800f22d231
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/26 00:10:45
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Reply-To: Bug 1888971 <1888971@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

When using qemu , SMI trigger causes hang/reboot under following
conditions:

1. No KVM but there are more than 1 threads (-smp > 1)
2. When using KVM.

Info:
qemu-system-x86_64 --version
QEMU emulator version 2.11.1(Debian 1:2.11+dfsg-1ubuntu7.29)
Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers

SMI trigger was done by writing 0x00 in IO port 0xB2.

Command:
No failure in SMI trigger when using the below command:
qemu-system-x86_64 -M pc-q35-bionic -smp 1 -bios build/coreboot.rom  -seria=
l stdio -hda ../linux.img  -m 2048 | tee 1.txt

Hang/resets with below commands:
qemu-system-x86_64 -M pc-q35-bionic -smp 2 -bios build/coreboot.rom  -seria=
l stdio -hda ../linux.img  -m 2048 | tee 1.txt

sudo qemu-system-x86_64 -M pc-q35-bionic,accel=3Dkvm -smp 1 -bios
build/coreboot.rom  -serial stdio -hda ../linux.img  -m 2048 | tee 1.txt

** Affects: qemu
     Importance: Undecided
         Status: New

** Description changed:

- When using qemu , SMI trigger causes hand/reboot under following
+ When using qemu , SMI trigger causes hang/reboot under following
  conditions:
  =

  1. No KVM but there are more than 1 threads (-smp > 1)
  2. When using KVM.
  =

  Info:
  qemu-system-x86_64 --version
  QEMU emulator version 2.11.1(Debian 1:2.11+dfsg-1ubuntu7.29)
  Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers
  =

  SMI trigger was done by writing 0x00 in IO port 0xB2.

** Description changed:

  When using qemu , SMI trigger causes hang/reboot under following
  conditions:
  =

  1. No KVM but there are more than 1 threads (-smp > 1)
  2. When using KVM.
  =

  Info:
  qemu-system-x86_64 --version
  QEMU emulator version 2.11.1(Debian 1:2.11+dfsg-1ubuntu7.29)
  Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers
  =

  SMI trigger was done by writing 0x00 in IO port 0xB2.
+ =

+ Command:
+ No failure in SMI trigger when using the below command:
+ qemu-system-x86_64 -M pc-q35-bionic -smp 1 -bios build/coreboot.rom  -ser=
ial stdio -hda ../linux.img  -m 2048 | tee 1.txt
+ =

+ Hang/resets with below commands:
+ qemu-system-x86_64 -M pc-q35-bionic -smp 2 -bios build/coreboot.rom  -ser=
ial stdio -hda ../linux.img  -m 2048 | tee 1.txt
+ =

+ sudo qemu-system-x86_64 -M pc-q35-bionic,accel=3Dkvm -smp 1 -bios
+ build/coreboot.rom  -serial stdio -hda ../linux.img  -m 2048 | tee 1.txt

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1888971

Title:
  SMI trigger causes hang with multiple cores

Status in QEMU:
  New

Bug description:
  When using qemu , SMI trigger causes hang/reboot under following
  conditions:

  1. No KVM but there are more than 1 threads (-smp > 1)
  2. When using KVM.

  Info:
  qemu-system-x86_64 --version
  QEMU emulator version 2.11.1(Debian 1:2.11+dfsg-1ubuntu7.29)
  Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers

  SMI trigger was done by writing 0x00 in IO port 0xB2.

  Command:
  No failure in SMI trigger when using the below command:
  qemu-system-x86_64 -M pc-q35-bionic -smp 1 -bios build/coreboot.rom  -ser=
ial stdio -hda ../linux.img  -m 2048 | tee 1.txt

  Hang/resets with below commands:
  qemu-system-x86_64 -M pc-q35-bionic -smp 2 -bios build/coreboot.rom  -ser=
ial stdio -hda ../linux.img  -m 2048 | tee 1.txt

  sudo qemu-system-x86_64 -M pc-q35-bionic,accel=3Dkvm -smp 1 -bios
  build/coreboot.rom  -serial stdio -hda ../linux.img  -m 2048 | tee
  1.txt

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1888971/+subscriptions

