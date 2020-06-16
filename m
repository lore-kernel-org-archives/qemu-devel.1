Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7917CC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:43:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57538214DB
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:43:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57538214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlDk8-0002pN-Eq
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 11:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jlDiW-00014R-IP
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 11:41:40 -0400
Received: from indium.canonical.com ([91.189.90.7]:50366)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jlDiU-0008KS-QJ
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 11:41:40 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jlDiP-0008TR-DR
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 15:41:33 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 705152E814C
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 15:41:29 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2020 15:33:40 -0000
From: Bugs SysSec <1883729@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: bugs-syssec
X-Launchpad-Bug-Reporter: Bugs SysSec (bugs-syssec)
X-Launchpad-Bug-Modifier: Bugs SysSec (bugs-syssec)
Message-Id: <159232162102.10413.11793430476734031615.malonedeb@gac.canonical.com>
Subject: [Bug 1883729] [NEW] xhci_find_stream: Assertion `streamid != 0'
 failed.
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="b190cebbf563f89e480a8b57f641753c8196bda0";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 45f161702416359059e9309de29ad5fe13bc82ec
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 11:30:43
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Reply-To: Bug 1883729 <1883729@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

To reproduce run the QEMU with the following command line:
```
qemu-system-x86_64 -cdrom hypertrash_os_bios_crash.iso -nographic -m 100 -e=
nable-kvm -device virtio-gpu-pci -device nec-usb-xhci -device usb-audio
```

QEMU Version:
```
# qemu-5.0.0
$ ./configure --target-list=3Dx86_64-softmmu --enable-sanitizers; make
$ x86_64-softmmu/qemu-system-x86_64 --version
QEMU emulator version 5.0.0
Copyright (c) 2003-2020 Fabrice Bellard and the QEMU Project developers
```

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "xhci_assert3.zip"
   https://bugs.launchpad.net/bugs/1883729/+attachment/5384432/+files/xhci_=
assert3.zip

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1883729

Title:
  xhci_find_stream: Assertion `streamid !=3D 0' failed.

Status in QEMU:
  New

Bug description:
  To reproduce run the QEMU with the following command line:
  ```
  qemu-system-x86_64 -cdrom hypertrash_os_bios_crash.iso -nographic -m 100 =
-enable-kvm -device virtio-gpu-pci -device nec-usb-xhci -device usb-audio
  ```

  QEMU Version:
  ```
  # qemu-5.0.0
  $ ./configure --target-list=3Dx86_64-softmmu --enable-sanitizers; make
  $ x86_64-softmmu/qemu-system-x86_64 --version
  QEMU emulator version 5.0.0
  Copyright (c) 2003-2020 Fabrice Bellard and the QEMU Project developers
  ```

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1883729/+subscriptions

