Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30018C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 05:56:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7163206DA
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 05:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7163206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5NGj-000834-45
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 01:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k5NG7-0007bX-SY
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 01:55:39 -0400
Received: from indium.canonical.com ([91.189.90.7]:45626)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k5NG5-0001KW-DT
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 01:55:39 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k5NG3-0000R6-18
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 05:55:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id E159D2E808D
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 05:55:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Aug 2020 05:46:41 -0000
From: Alexander Bulekov <1883732@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: a1xndr bugs-syssec
X-Launchpad-Bug-Reporter: Bugs SysSec (bugs-syssec)
X-Launchpad-Bug-Modifier: Alexander Bulekov (a1xndr)
References: <159232165417.10932.651014003255038636.malonedeb@gac.canonical.com>
Message-Id: <159712480155.21280.7686767813194078458.malone@chaenomeles.canonical.com>
Subject: [Bug 1883732] Re: xhci_kick_epctx: Assertion `ring->dequeue != 0'
 failed.
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="6a138c03da9cc3e2e03f6dd3bbb4a615b0be6ec2";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 3072008b614fc89910bf900ab07833fe3e77f861
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 01:55:35
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
Reply-To: Bug 1883732 <1883732@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Here's a QTest reproducer:

cat << EOF | ./i386-softmmu/qemu-system-i386 \
-device nec-usb-xhci -trace usb\* \
-device usb-audio -device usb-storage,drive=3Dmydrive \
-drive id=3Dmydrive,file=3Dnull-co://,size=3D2M,format=3Draw,if=3Dnone \
-nodefaults -nographic -qtest stdio
outl 0xcf8 0x80001014
outl 0xcfc 0xff000a8e
outl 0xcf8 0x80001004
outl 0xcfc 0x1c77695e
writel 0xff000a8e00000040 0x1d00d815
write 0x1d 0x1 0x5c
write 0x2d 0x1 0x27
write 0x3d 0x1 0x2e
write 0xd 0x1 0x60
write 0x17232 0x1 0x03
write 0x17254 0x1 0x05
write 0x4d 0x1 0x5c
write 0x5d 0x1 0x27
write 0x60 0x1 0x2e
write 0x61 0x1 0x72
write 0x62 0x1 0x01
write 0x6d 0x1 0x2e
write 0x6f 0x1 0x01
writel 0xff000a8e00002000 0x0
writeq 0xff000a8e00002000 0x514ef0100000009
EOF

The trace:
[R +0.031152] writel 0xff000a8e00000040 0x1d00d815
26994@1597124755.565242:usb_xhci_oper_write off 0x0000, val 0x1d00d815
26994@1597124755.565247:usb_xhci_run
26994@1597124755.565252:usb_xhci_irq_intx level 0
OK
[S +0.031173] OK
[R +0.031179] write 0x1d 0x1 0x5c
OK
[S +0.031190] OK
[R +0.031195] write 0x2d 0x1 0x27
OK
[S +0.031198] OK
[R +0.031203] write 0x3d 0x1 0x2e
OK
[S +0.031207] OK
[R +0.031211] write 0xd 0x1 0x60
OK
[S +0.031214] OK
[R +0.031219] write 0x17232 0x1 0x03
OK
[S +0.031224] OK
[R +0.031228] write 0x17254 0x1 0x05
OK
[S +0.031231] OK
[R +0.031236] write 0x4d 0x1 0x5c
OK
[S +0.031239] OK
[R +0.031244] write 0x5d 0x1 0x27
OK
[S +0.031247] OK
[R +0.031251] write 0x60 0x1 0x2e
OK
[S +0.031254] OK
[R +0.031259] write 0x61 0x1 0x72
OK
[S +0.031262] OK
[R +0.031267] write 0x62 0x1 0x01
OK
[S +0.031270] OK
[R +0.031275] write 0x6d 0x1 0x2e
OK
[S +0.031278] OK
[R +0.031282] write 0x6f 0x1 0x01
OK
[S +0.031286] OK
[R +0.031290] writel 0xff000a8e00002000 0x0
26994@1597124755.565377:usb_xhci_doorbell_write off 0x0000, val 0x00000000
26994@1597124755.565384:usb_xhci_fetch_trb addr 0x0000000000000000, ???, p =
0x0000000000000000, s 0x00000000, c 0x00006000
26994@1597124755.565390:usb_xhci_unimplemented command (0x18)
26994@1597124755.565395:usb_xhci_fetch_trb addr 0x0000000000000010, CR_NOOP=
, p 0x0000000000000000, s 0x00000000, c 0x00005c00
26994@1597124755.565399:usb_xhci_fetch_trb addr 0x0000000000000020, CR_ENAB=
LE_SLOT, p 0x0000000000000000, s 0x00000000, c 0x00002700
26994@1597124755.565403:usb_xhci_slot_enable slotid 1
26994@1597124755.565406:usb_xhci_fetch_trb addr 0x0000000000000030, CR_ADDR=
ESS_DEVICE, p 0x0000000000000000, s 0x00000000, c 0x00002e00
26994@1597124755.565411:usb_xhci_fetch_trb addr 0x0000000000000040, CR_NOOP=
, p 0x0000000000000000, s 0x00000000, c 0x00005c00
26994@1597124755.565416:usb_xhci_fetch_trb addr 0x0000000000000050, CR_ENAB=
LE_SLOT, p 0x0000000000000000, s 0x00000000, c 0x00002700
26994@1597124755.565421:usb_xhci_slot_enable slotid 2
26994@1597124755.565423:usb_xhci_fetch_trb addr 0x0000000000000060, CR_ADDR=
ESS_DEVICE, p 0x000000000001722e, s 0x00000000, c 0x01002e00
26994@1597124755.565431:usb_xhci_slot_address slotid 1, port 1
26994@1597124755.565436:usb_xhci_ep_enable slotid 1, epid 1
26994@1597124755.565444:usb_xhci_fetch_trb addr 0x0000000000000070, TRB_RES=
ERVED, p 0x0000000000000000, s 0x00000000, c 0x00000000
OK
[S +0.031365] OK
[R +0.031370] writeq 0xff000a8e00002000 0x514ef0100000009
26994@1597124755.565456:usb_xhci_doorbell_write off 0x0000, val 0x00000009
26994@1597124755.565459:usb_xhci_doorbell_write off 0x0004, val 0x0514ef01
26994@1597124755.565462:usb_xhci_ep_kick slotid 1, epid 1, streamid 1300
qemu-system-i386: /home/alxndr/Development/qemu/general-fuzz/hw/usb/hcd-xhc=
i.c:1955: void xhci_kick_epctx(XHCIEPContext *, unsigned int): Assertion `r=
ing->dequeue !=3D 0' failed.
Aborted

-Alex

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1883732

Title:
  xhci_kick_epctx: Assertion `ring->dequeue !=3D 0' failed.

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
https://bugs.launchpad.net/qemu/+bug/1883732/+subscriptions

