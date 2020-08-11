Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29638C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 02:16:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F35F2206DC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 02:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F35F2206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Jpp-0004S6-7X
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 22:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k5JpH-00041g-O0
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 22:15:43 -0400
Received: from indium.canonical.com ([91.189.90.7]:39062)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k5JpF-0005rX-Ma
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 22:15:43 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k5JpD-0002N3-BU
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 02:15:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 4A45D2E80AB
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 02:15:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Aug 2020 02:10:26 -0000
From: Alexander Bulekov <1883729@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: a1xndr bugs-syssec
X-Launchpad-Bug-Reporter: Bugs SysSec (bugs-syssec)
X-Launchpad-Bug-Modifier: Alexander Bulekov (a1xndr)
References: <159232162102.10413.11793430476734031615.malonedeb@gac.canonical.com>
Message-Id: <159711182692.26666.7816341258147977917.malone@gac.canonical.com>
Subject: [Bug 1883729] Re: xhci_find_stream: Assertion `streamid != 0' failed.
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="6a138c03da9cc3e2e03f6dd3bbb4a615b0be6ec2";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: e5c9624b889c849a252b7f8606b631d64cf54891
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 21:25:38
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
Reply-To: Bug 1883729 <1883729@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Attaching a QTest reproducer.
./i386-softmmu/qemu-system-i386 -device nec-usb-xhci -trace usb\* \
-device usb-audio -device usb-storage,drive=3Dmydrive \
-drive id=3Dmydrive,file=3Dnull-co://,size=3D2M,format=3Draw,if=3Dnone \
-nodefaults -nographic -qtest stdio < repro


Close to the crash:
21000@1597111713.503068:usb_xhci_slot_configure slotid 58
21000@1597111713.503074:usb_xhci_ep_disable slotid 58, epid 2
21000@1597111713.503077:usb_xhci_ep_enable slotid 58, epid 2
21000@1597111713.503085:usb_xhci_ep_disable slotid 58, epid 6
21000@1597111713.503088:usb_xhci_ep_enable slotid 58, epid 6
21000@1597111713.503092:usb_xhci_ep_disable slotid 58, epid 24
21000@1597111713.503095:usb_xhci_ep_enable slotid 58, epid 24
21000@1597111713.503099:usb_xhci_ep_disable slotid 58, epid 25
21000@1597111713.503102:usb_xhci_ep_enable slotid 58, epid 25
21000@1597111713.503106:usb_xhci_ep_disable slotid 58, epid 29
21000@1597111713.503109:usb_xhci_ep_enable slotid 58, epid 29
21000@1597111713.503113:usb_xhci_ep_disable slotid 58, epid 30
21000@1597111713.503116:usb_xhci_ep_enable slotid 58, epid 30
21000@1597111713.503121:usb_xhci_fetch_trb addr 0x0000000000000b20, CR_ENAB=
LE_SLOT, p 0x0000000000000000, s 0x00000000, c 0x00002700
21000@1597111713.503127:usb_xhci_slot_enable slotid 59
21000@1597111713.503130:usb_xhci_fetch_trb addr 0x0000000000000b30, CR_SET_=
TR_DEQUEUE, p 0x0000000000000000, s 0x00000000, c 0x00004300
21000@1597111713.503135:usb_xhci_fetch_trb addr 0x0000000000000b40, CR_ENAB=
LE_SLOT, p 0x0000000000000000, s 0x00000000, c 0x00002700
21000@1597111713.503140:usb_xhci_slot_enable slotid 60
21000@1597111713.503143:usb_xhci_fetch_trb addr 0x0000000000000b50, CR_EVAL=
UATE_CONTEXT, p 0x0000000000000000, s 0x00000000, c 0x00003600
21000@1597111713.503149:usb_xhci_fetch_trb addr 0x0000000000000b60, CR_STOP=
_ENDPOINT, p 0x0000000000000000, s 0x00000000, c 0x3afd3c00
21000@1597111713.503154:usb_xhci_ep_stop slotid 58, epid 29
21000@1597111713.503159:usb_xhci_ep_state slotid 58, epid 29, running -> st=
opped
21000@1597111713.503163:usb_xhci_fetch_trb addr 0x0000000000000b70, CR_ENAB=
LE_SLOT, p 0x0000000000000000, s 0x00000000, c 0x00002700
21000@1597111713.503168:usb_xhci_slot_enable slotid 61
21000@1597111713.503171:usb_xhci_fetch_trb addr 0x0000000000000b80, CR_SET_=
TR_DEQUEUE, p 0x0000000000000000, s 0x00000000, c 0x3afd4300
21000@1597111713.503177:usb_xhci_ep_set_dequeue slotid 58, epid 29, streami=
d 0, ptr 0x0000000000000000
qemu-system-i386: hw/usb/hcd-xhci.c:1016: XHCIStreamContext *xhci_find_stre=
am(XHCIEPContext *, unsigned int, uint32_t *): Assertion `streamid !=3D 0' =
failed.
Aborted


** Attachment added: "repro"
   https://bugs.launchpad.net/qemu/+bug/1883729/+attachment/5400547/+files/=
repro

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

