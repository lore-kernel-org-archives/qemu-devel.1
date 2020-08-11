Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F36EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 22:11:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C88B206DA
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 22:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C88B206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5cUM-00032G-DA
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 18:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k5cTn-0002cL-1j
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 18:10:47 -0400
Received: from indium.canonical.com ([91.189.90.7]:47086)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k5cTk-0000J3-DU
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 18:10:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k5cTh-0002Do-QC
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 22:10:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id C41312E8072
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 22:10:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Aug 2020 22:01:24 -0000
From: Alexander Bulekov <1883728@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: testcase
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: a1xndr bugs-syssec
X-Launchpad-Bug-Reporter: Bugs SysSec (bugs-syssec)
X-Launchpad-Bug-Modifier: Alexander Bulekov (a1xndr)
References: <159232150625.30008.14587531607819527800.malonedeb@chaenomeles.canonical.com>
Message-Id: <159718328433.10114.14681135248488747440.malone@wampee.canonical.com>
Subject: [Bug 1883728] Re: address_space_unmap: Assertion `mr != NULL' failed.
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="6a138c03da9cc3e2e03f6dd3bbb4a615b0be6ec2";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 4d7a28907454ca8661093639277a9201268301c2
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 17:11:05
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
Reply-To: Bug 1883728 <1883728@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Here's a qtest reproducer:

cat << EOF | ./i386-softmmu/qemu-system-i386 \
-device nec-usb-xhci -trace usb\* \
-device usb-audio -device usb-storage,drive=3Dmydrive \
-drive id=3Dmydrive,file=3Dnull-co://,size=3D2M,format=3Draw,if=3Dnone \
-nodefaults -nographic -qtest stdio
outl 0xcf8 0x80001016
outl 0xcfc 0x3c319f0d
outl 0xcf8 0x80001004
outl 0xcfc 0xc77695e
writel 0x9f0d000000000040 0xffffd855
write 0x1d 0x1 0x27
write 0x2d 0x1 0x2e
write 0x17232 0x1 0x03
write 0x17254 0x1 0x05
write 0x17276 0x1 0x72
write 0x17278 0x1 0x02
write 0x3d 0x1 0x27
write 0x40 0x1 0x2e
write 0x41 0x1 0x72
write 0x42 0x1 0x01
write 0x4d 0x1 0x2e
write 0x4f 0x1 0x01
writeq 0x9f0d000000002000 0x5c05140100000000
writeq 0x9f0d000000002000 0x5c05140100000000
write 0x2008d 0x1 0x13
writeq 0x9f0d000000002000 0x100ef0100000009
write 0x200ad 0x1 0x27
write 0x200bd 0x1 0x5c
write 0x200cd 0x1 0x2e
write 0x200dd 0x1 0x2f
write 0x200e8 0x1 0x08
write 0x200ec 0x1 0xfe
write 0x200ed 0x1 0x08
write 0x200fd 0x1 0x05
write 0x2010d 0x1 0x2e
write 0x2011d 0x1 0x2f
write 0x2012d 0x1 0x08
write 0x20137 0x1 0x5e
write 0x2013a 0x1 0x2f
write 0x2013d 0x1 0x05
write 0x2014d 0x1 0x13
writeq 0x9f0d000000002000 0x100ef0100000009
EOF

...
[S +0.017146] OK
[R +0.017149] writeq 0x9f0d000000002000 0x5c05140100000000
30899@1597183147.299108:usb_xhci_doorbell_write off 0x0000, val 0x00000000
30899@1597183147.299112:usb_xhci_fetch_trb addr 0x0000000000000000, TRB_RES=
ERVED, p 0x0000000000000000, s 0x00000000, c 0x00000000
30899@1597183147.299115:usb_xhci_doorbell_write off 0x0004, val 0x5c051401
OK
[S +0.017162] OK
[R +0.017166] writeq 0x9f0d000000002000 0x5c05140100000000
30899@1597183147.299124:usb_xhci_doorbell_write off 0x0000, val 0x00000000
30899@1597183147.299126:usb_xhci_fetch_trb addr 0x0000000000000010, CR_ENAB=
LE_SLOT, p 0x0000000000000000, s 0x00000000, c 0x00002700
30899@1597183147.299129:usb_xhci_slot_enable slotid 1
30899@1597183147.299132:usb_xhci_fetch_trb addr 0x0000000000000020, CR_ADDR=
ESS_DEVICE, p 0x0000000000000000, s 0x00000000, c 0x00002e00
30899@1597183147.299134:usb_xhci_fetch_trb addr 0x0000000000000030, CR_ENAB=
LE_SLOT, p 0x0000000000000000, s 0x00000000, c 0x00002700
30899@1597183147.299137:usb_xhci_slot_enable slotid 2
30899@1597183147.299139:usb_xhci_fetch_trb addr 0x0000000000000040, CR_ADDR=
ESS_DEVICE, p 0x000000000001722e, s 0x00000000, c 0x01002e00
30899@1597183147.299144:usb_xhci_slot_address slotid 1, port 1
30899@1597183147.299148:usb_xhci_ep_enable slotid 1, epid 1
30899@1597183147.299151:usb_xhci_fetch_trb addr 0x0000000000000050, TRB_RES=
ERVED, p 0x0000000000000000, s 0x00000000, c 0x00000000
30899@1597183147.299154:usb_xhci_doorbell_write off 0x0004, val 0x5c051401
30899@1597183147.299157:usb_xhci_ep_kick slotid 1, epid 1, streamid 23557
30899@1597183147.299161:usb_xhci_fetch_trb addr 0x0000000000020070, TRB_RES=
ERVED, p 0x0000000000000000, s 0x00000000, c 0x00000000
OK
[S +0.017210] OK
[R +0.017214] write 0x2008d 0x1 0x13
OK
[S +0.017219] OK
[R +0.017223] writeq 0x9f0d000000002000 0x100ef0100000009
30899@1597183147.299181:usb_xhci_doorbell_write off 0x0000, val 0x00000009
30899@1597183147.299183:usb_xhci_doorbell_write off 0x0004, val 0x0100ef01
30899@1597183147.299185:usb_xhci_ep_kick slotid 1, epid 1, streamid 256
30899@1597183147.299189:usb_xhci_fetch_trb addr 0x0000000000020080, TR_STAT=
US, p 0x0000000000000000, s 0x00000000, c 0x00001300
30899@1597183147.299191:usb_xhci_xfer_start 0x5622548f9760: slotid 1, epid =
1, streamid 0
TRB_SETUP 1300 1300 1300 0
30899@1597183147.299196:usb_xhci_fetch_trb addr 0x0000000000020090, TRB_RES=
ERVED, p 0x0000000000000000, s 0x00000000, c 0x00000000
OK
[S +0.017244] OK
[R +0.017248] write 0x200ad 0x1 0x27
OK
[S +0.017338] OK
[R +0.017342] writeq 0x9f0d000000002000 0x100ef0100000009
30899@1597183147.299300:usb_xhci_doorbell_write off 0x0000, val 0x00000009
30899@1597183147.299302:usb_xhci_doorbell_write off 0x0004, val 0x0100ef01
30899@1597183147.299304:usb_xhci_ep_kick slotid 1, epid 1, streamid 256
30899@1597183147.299308:usb_xhci_fetch_trb addr 0x00000000000200a0, CR_ENAB=
LE_SLOT, p 0x0000000000000000, s 0x00000000, c 0x00002700
30899@1597183147.299310:usb_xhci_xfer_start 0x5622548f9890: slotid 1, epid =
1, streamid 0
TRB_SETUP 2700 2700 2700 0
30899@1597183147.299315:usb_xhci_fetch_trb addr 0x00000000000200b0, CR_NOOP=
, p 0x0000000000000000, s 0x00000000, c 0x00005c00
30899@1597183147.299318:usb_xhci_xfer_start 0x5622548f99a0: slotid 1, epid =
1, streamid 0
TRB_SETUP 5c00 5c00 5c00 0
30899@1597183147.299322:usb_xhci_fetch_trb addr 0x00000000000200c0, CR_ADDR=
ESS_DEVICE, p 0x0000000000000000, s 0x00000000, c 0x00002e00
30899@1597183147.299325:usb_xhci_xfer_start 0x5622548f9ab0: slotid 1, epid =
1, streamid 0
TRB_SETUP 2e00 2e00 2e00 0
30899@1597183147.299329:usb_xhci_fetch_trb addr 0x00000000000200d0, CR_ADDR=
ESS_DEVICE, p 0x0000000000000000, s 0x00000000, c 0x00002f00
30899@1597183147.299331:usb_xhci_xfer_start 0x5622548f9c10: slotid 1, epid =
1, streamid 0
TRB_SETUP 2f00 2f00 2f00 0
30899@1597183147.299337:usb_xhci_fetch_trb addr 0x00000000000200e0, TR_SETU=
P, p 0x0000000000000000, s 0x00000008, c 0x000008fe
30899@1597183147.299340:usb_xhci_fetch_trb addr 0x00000000000200f0, TR_NORM=
AL, p 0x0000000000000000, s 0x00000000, c 0x00000500
30899@1597183147.299342:usb_xhci_fetch_trb addr 0x0000000000020100, CR_ADDR=
ESS_DEVICE, p 0x0000000000000000, s 0x00000000, c 0x00002e00
30899@1597183147.299345:usb_xhci_fetch_trb addr 0x0000000000020110, CR_ADDR=
ESS_DEVICE, p 0x0000000000000000, s 0x00000000, c 0x00002f00
30899@1597183147.299348:usb_xhci_fetch_trb addr 0x0000000000020120, TR_SETU=
P, p 0x0000000000000000, s 0x00000000, c 0x00000800
30899@1597183147.299351:usb_xhci_fetch_trb addr 0x0000000000020130, TR_NORM=
AL, p 0x5e00000000000000, s 0x002f0000, c 0x00000500
30899@1597183147.299353:usb_xhci_fetch_trb addr 0x0000000000020140, TR_STAT=
US, p 0x0000000000000000, s 0x00000000, c 0x00001300
30899@1597183147.299356:usb_xhci_xfer_start 0x5622548f9d70: slotid 1, epid =
1, streamid 0
TRB_SETUP 8fe 1300 8fe 8
30899@1597183147.299361:usb_packet_state_change bus 0, port 1, ep 0, packet=
 0x5622548f9d78, state undef -> setup
30899@1597183147.299466:usb_packet_state_change bus 0, port 1, ep 0, packet=
 0x5622548f9d78, state setup -> complete
qemu-system-i386: /home/alxndr/Development/qemu/general-fuzz/exec.c:3623: v=
oid address_space_unmap(AddressSpace *, void *, hwaddr, _Bool, hwaddr): Ass=
ertion `mr !=3D NULL' failed.



#8 0x7f8f9e7e6091 in __assert_fail /build/glibc-GwnBeO/glibc-2.30/assert/as=
sert.c:101:3
#9 0x55f7507b374a in address_space_unmap exec.c:3623:9
#10 0x55f750baeab8 in dma_memory_unmap include/sysemu/dma.h:145:5
#11 0x55f750baea1b in usb_packet_unmap hw/usb/libhw.c:65:9
#12 0x55f750bcbb73 in xhci_xfer_unmap hw/usb/hcd-xhci.c:1487:5
#13 0x55f750bcba3d in xhci_try_complete_packet hw/usb/hcd-xhci.c:1642:9
#14 0x55f750bcc888 in xhci_fire_ctl_transfer hw/usb/hcd-xhci.c:1728:5
#15 0x55f750bcb306 in xhci_kick_epctx hw/usb/hcd-xhci.c:1991:13
#16 0x55f750bd04e9 in xhci_kick_ep hw/usb/hcd-xhci.c:1861:5
#17 0x55f750bd253c in xhci_doorbell_write hw/usb/hcd-xhci.c:3162:13
#18 0x55f75091def1 in memory_region_write_accessor softmmu/memory.c:483:5
#19 0x55f75091ddf3 in access_with_adjusted_size softmmu/memory.c:544:18
#20 0x55f75091dac5 in memory_region_dispatch_write softmmu/memory.c
#21 0x55f7507b51e2 in flatview_write_continue exec.c:3176:23
#22 0x55f7507b2a30 in flatview_write exec.c:3216:14
#23 0x55f7507b2968 in address_space_write exec.c:3308:18
#24 0x55f750929e3b in qtest_process_command softmmu/qtest.c

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1883728

Title:
  address_space_unmap: Assertion `mr !=3D NULL' failed.

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
https://bugs.launchpad.net/qemu/+bug/1883728/+subscriptions

