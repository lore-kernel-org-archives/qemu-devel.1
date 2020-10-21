Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30663C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 22:27:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 384AE241A6
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 22:27:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 384AE241A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVMZe-0003GW-3j
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 18:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kVMY8-0002A0-4e
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 18:25:40 -0400
Received: from indium.canonical.com ([91.189.90.7]:37892)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kVMY6-0000y8-Cc
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 18:25:39 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kVMY4-0001Ex-TN
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 22:25:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id DC7922E812F
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 22:25:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2020 22:19:12 -0000
From: bwidawsk <1900918@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: bwidawsk
X-Launchpad-Bug-Reporter: bwidawsk (bwidawsk)
X-Launchpad-Bug-Modifier: bwidawsk (bwidawsk)
Message-Id: <160331875272.12077.2782132166583123288.malonedeb@soybean.canonical.com>
Subject: [Bug 1900918] [NEW] PXB devices
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="bc5a16cfdc4ba776ecdf84a052201ef8fb1f3321"; Instance="production"
X-Launchpad-Hash: 00c87a166ad8ffd2e1529f853b5f9ec31686c523
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 18:25:35
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1900918 <1900918@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

release: 4c41341af76cfc85b5a6c0f87de4838672ab9f89

qdev_device_add() will search for the "closest" bus possible, and bail out =
early if that bus is a root bus. pxb devices are considered root buses and =
so if you either
1. Add a PCI device on the QEMU command line *after* a pxb device, or
2. Add an integrated PCI device (like a watchdog)

#1: -device pxb-pcie,id=3Dcxl.0,bus=3Dpcie.0,bus_nr=3D52 -device ahci,id=3D=
sata0,addr=3D0x8
#2: -watchdog i6300esb -device pxb-pcie,id=3Dcxl.0,bus=3Dpcie.0,bus_nr=3D52

The PXB will get selected as the bus (instead of the real root bus) and
this will cause an assertion failure with the message like "qemu-system-
x86_64: -device ahci,id=3Dsata0,addr=3D0x8: PCI: Only PCI/PCIe bridges can
be plugged into pxb-pcie"

I think this is relatively solvable in the code base by determining if a
bus is an expander, and skipping it if so. However, I wonder if it makes
more sense to just allow expanders to have endpoint devices.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1900918

Title:
  PXB devices

Status in QEMU:
  New

Bug description:
  release: 4c41341af76cfc85b5a6c0f87de4838672ab9f89

  qdev_device_add() will search for the "closest" bus possible, and bail ou=
t early if that bus is a root bus. pxb devices are considered root buses an=
d so if you either
  1. Add a PCI device on the QEMU command line *after* a pxb device, or
  2. Add an integrated PCI device (like a watchdog)

  #1: -device pxb-pcie,id=3Dcxl.0,bus=3Dpcie.0,bus_nr=3D52 -device ahci,id=
=3Dsata0,addr=3D0x8
  #2: -watchdog i6300esb -device pxb-pcie,id=3Dcxl.0,bus=3Dpcie.0,bus_nr=3D=
52

  The PXB will get selected as the bus (instead of the real root bus)
  and this will cause an assertion failure with the message like "qemu-
  system-x86_64: -device ahci,id=3Dsata0,addr=3D0x8: PCI: Only PCI/PCIe
  bridges can be plugged into pxb-pcie"

  I think this is relatively solvable in the code base by determining if
  a bus is an expander, and skipping it if so. However, I wonder if it
  makes more sense to just allow expanders to have endpoint devices.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1900918/+subscriptions

