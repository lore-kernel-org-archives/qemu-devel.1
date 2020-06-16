Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE4AC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:34:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFB51208D5
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:34:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFB51208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlDbh-0002eW-3N
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 11:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jlDY0-0008WJ-Ca
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 11:30:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:47796)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jlDXz-0005dP-Og
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 11:30:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jlDXv-0006va-GX
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 15:30:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 7B1FB2E80E7
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 15:30:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2020 15:23:23 -0000
From: Bugs SysSec <1810000@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: balaton-4 benquike bugs-syssec th-huth
X-Launchpad-Bug-Reporter: PH (benquike)
X-Launchpad-Bug-Modifier: Bugs SysSec (bugs-syssec)
References: <154603590627.5548.1380267988808710453.malonedeb@wampee.canonical.com>
Message-Id: <159232100345.25018.16908107977226174488.malone@wampee.canonical.com>
Subject: [Bug 1810000] Re: qemu system emulator crashed with the attachment of
 usb-bt-dongle device
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="b190cebbf563f89e480a8b57f641753c8196bda0";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 298d1bc8161e63a1925e8a84cbc047e13b19b444
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 11:30:43
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
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
Reply-To: Bug 1810000 <1810000@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We found a reproducer during fuzzing:

```
qemu-system-x86_64 -cdrom hypertrash_os_bios_crash.iso -nographic -m 100 -e=
nable-kvm -device virtio-gpu-pci -device nec-usb-xhci -device usb-audio
```

ISO is available under:
https://ruhr-uni-bochum.sciebo.de/s/3UyxvIAB3FeCJ8r?path=3D%2Fxhci_assert2

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1810000

Title:
  qemu system emulator crashed with the attachment of usb-bt-dongle
  device

Status in QEMU:
  New

Bug description:
  I am testing usb-bt-dongle device on xchi host controller, and found
  that the qemu crashed directly with an assertion failer.

  Here is the information to reproduce the crash:

  Qemu git revision: 9b2e891ec5ccdb4a7d583b77988848282606fdea
  System emulator: qemu-x86_64
  VM image: https://people.debian.org/~aurel32/qemu/amd64/debian_squeeze_am=
d64_desktop.qcow2
  CommandLine: qemu-system-x86_64 -M q35 -device qemu-xhci,id=3Dxhci -enabl=
e-kvm -device usb-bt-dongle  -hda ./debian_wheezy_amd64_standard.qcow2

  Error message:

  qemu-system-x86_64: /build/qemu-
  Eap4uc/qemu-2.11+dfsg/hw/usb/core.c:592: usb_packet_copy: Assertion
  `p->actual_length + bytes <=3D iov->size' failed.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1810000/+subscriptions

