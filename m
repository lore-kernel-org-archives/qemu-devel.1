Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B260AC2D0F6
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 03:06:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 721CF2176D
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 03:06:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 721CF2176D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYhiq-0001Kk-KR
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 23:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jYhiI-0000uS-GA
 for qemu-devel@nongnu.org; Tue, 12 May 2020 23:05:42 -0400
Received: from indium.canonical.com ([91.189.90.7]:33250)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jYhiG-0004eJ-O3
 for qemu-devel@nongnu.org; Tue, 12 May 2020 23:05:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jYhiE-0000Fk-PV
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 03:05:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id BF1C32E8010
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 03:05:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2020 02:59:22 -0000
From: Alexander Bulekov <1878323@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: a1xndr
X-Launchpad-Bug-Reporter: Alexander Bulekov (a1xndr)
X-Launchpad-Bug-Modifier: Alexander Bulekov (a1xndr)
Message-Id: <158933876258.19393.11272084108763872012.malonedeb@chaenomeles.canonical.com>
Subject: [Bug 1878323] [NEW] Assertion-failure in usb_detach
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="013b6f2a3f3ba130b50b9eee1a89957ee38a5c15";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: eaccc04d4876bb05ed1c00c99be90054f76df2a4
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 22:09:52
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Bug 1878323 <1878323@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Hello,
While fuzzing, I found an input that triggers an assertion-failure in usb_d=
etach

/home/alxndr/Development/qemu/hw/usb/core.c:69: void usb_detach(USBPort *):=
 Assertion `dev->state !=3D USB_STATE_NOTATTACHED' failed.
#3  0x00007ffff6866092 in __GI___assert_fail (assertion=3D0x555557fd2040 <s=
tr> "dev->state !=3D USB_STATE_NOTATTACHED", file=3D0x555557fd1ec0 <str> "/=
home/alxndr/Development/qemu/hw/usb/core.c", line=3D0x45, function=3D0x5555=
57fd2000 <__PRETTY_FUNCTION__.usb_detach> "void usb_detach(USBPort *)") at =
assert.c:101
#4  0x000055555723f0ce in usb_detach (port=3D0x62100002df30) at /home/alxnd=
r/Development/qemu/hw/usb/core.c:69
#5  0x00005555572a05a4 in ehci_reset (opaque=3D0x62100002d9f0) at /home/alx=
ndr/Development/qemu/hw/usb/hcd-ehci.c:863
#6  0x00005555572bf941 in ehci_opreg_write (ptr=3D0x62100002d9f0, addr=3D0x=
0, val=3D0xbebebebe, size=3D0x4) at /home/alxndr/Development/qemu/hw/usb/hc=
d-ehci.c:1032
#7  0x00005555564938b5 in memory_region_write_accessor (mr=3D0x62100002dcb0=
, addr=3D0x0, value=3D0x7fffffffaad0, size=3D0x4, shift=3D0x0, mask=3D0xfff=
fffff, attrs=3D...) at /home/alxndr/Development/qemu/memory.c:483
#8  0x000055555649328a in access_with_adjusted_size (addr=3D0x0, value=3D0x=
7fffffffaad0, size=3D0x4, access_size_min=3D0x1, access_size_max=3D0x4, acc=
ess_fn=3D0x555556493360 <memory_region_write_accessor>, mr=3D0x62100002dcb0=
, attrs=3D...) at /home/alxndr/Development/qemu/memory.c:544
#9  0x0000555556491df6 in memory_region_dispatch_write (mr=3D0x62100002dcb0=
, addr=3D0x0, data=3D0xbebebebe, op=3DMO_32, attrs=3D...) at /home/alxndr/D=
evelopment/qemu/memory.c:1476
#10 0x00005555562cbbf4 in flatview_write_continue (fv=3D0x60600003e600, add=
r=3D0xe0000020, attrs=3D..., ptr=3D0x625000260000, len=3D0xfe0, addr1=3D0x0=
, l=3D0x4, mr=3D0x62100002dcb0) at /home/alxndr/Development/qemu/exec.c:3137
#11 0x00005555562bbad9 in flatview_write (fv=3D0x60600003e600, addr=3D0xe00=
00000, attrs=3D..., buf=3D0x625000260000, len=3D0x1000) at /home/alxndr/Dev=
elopment/qemu/exec.c:3177
#12 0x00005555562bb609 in address_space_write (as=3D0x62100002d328, addr=3D=
0xe0000000, attrs=3D..., buf=3D0x625000260000, len=3D0x1000) at /home/alxnd=
r/Development/qemu/exec.c:3268
#13 0x00005555562c06a6 in address_space_unmap (as=3D0x62100002d328, buffer=
=3D0x625000260000, len=3D0x1000, is_write=3D0x1, access_len=3D0x1000) at /h=
ome/alxndr/Development/qemu/exec.c:3592
#14 0x0000555557257d73 in dma_memory_unmap (as=3D0x62100002d328, buffer=3D0=
x625000260000, len=3D0x1000, dir=3DDMA_DIRECTION_FROM_DEVICE, access_len=3D=
0x1000) at /home/alxndr/Development/qemu/include/sysemu/dma.h:145
#15 0x0000555557257c57 in usb_packet_unmap (p=3D0x6110000484c0, sgl=3D0x611=
000048548) at /home/alxndr/Development/qemu/hw/usb/libhw.c:65
#16 0x00005555572a5953 in ehci_free_packet (p=3D0x611000048480) at /home/al=
xndr/Development/qemu/hw/usb/hcd-ehci.c:536
#17 0x00005555572a4ed4 in ehci_cancel_queue (q=3D0x60d000004f10) at /home/a=
lxndr/Development/qemu/hw/usb/hcd-ehci.c:584
#18 0x00005555572a49ab in ehci_free_queue (q=3D0x60d000004f10, warn=3D0x0) =
at /home/alxndr/Development/qemu/hw/usb/hcd-ehci.c:611
#19 0x00005555572b102d in ehci_queues_rip_device (ehci=3D0x62100002d9f0, de=
v=3D0x623000001d00, async=3D0x1) at /home/alxndr/Development/qemu/hw/usb/hc=
d-ehci.c:674
#20 0x00005555572af7a3 in ehci_detach (port=3D0x62100002df78) at /home/alxn=
dr/Development/qemu/hw/usb/hcd-ehci.c:733
#21 0x000055555723f15c in usb_detach (port=3D0x62100002df78) at /home/alxnd=
r/Development/qemu/hw/usb/core.c:70
#22 0x00005555572a05a4 in ehci_reset (opaque=3D0x62100002d9f0) at /home/alx=
ndr/Development/qemu/hw/usb/hcd-ehci.c:863
#23 0x00005555572bf941 in ehci_opreg_write (ptr=3D0x62100002d9f0, addr=3D0x=
0, val=3D0xbebebebe, size=3D0x4) at /home/alxndr/Development/qemu/hw/usb/hc=
d-ehci.c:1032
#24 0x00005555564938b5 in memory_region_write_accessor (mr=3D0x62100002dcb0=
, addr=3D0x0, value=3D0x7fffffffc410, size=3D0x4, shift=3D0x0, mask=3D0xfff=
fffff, attrs=3D...) at /home/alxndr/Development/qemu/memory.c:483
#25 0x000055555649328a in access_with_adjusted_size (addr=3D0x0, value=3D0x=
7fffffffc410, size=3D0x4, access_size_min=3D0x1, access_size_max=3D0x4, acc=
ess_fn=3D0x555556493360 <memory_region_write_accessor>, mr=3D0x62100002dcb0=
, attrs=3D...) at /home/alxndr/Development/qemu/memory.c:544
#26 0x0000555556491df6 in memory_region_dispatch_write (mr=3D0x62100002dcb0=
, addr=3D0x0, data=3D0xbebebebe, op=3DMO_32, attrs=3D...) at /home/alxndr/D=
evelopment/qemu/memory.c:1476
#27 0x00005555562cbbf4 in flatview_write_continue (fv=3D0x60600003e600, add=
r=3D0xe0000020, attrs=3D..., ptr=3D0x625000260000, len=3D0xfe0, addr1=3D0x0=
, l=3D0x4, mr=3D0x62100002dcb0) at /home/alxndr/Development/qemu/exec.c:3137
#28 0x00005555562bbad9 in flatview_write (fv=3D0x60600003e600, addr=3D0xe00=
00000, attrs=3D..., buf=3D0x625000260000, len=3D0x1000) at /home/alxndr/Dev=
elopment/qemu/exec.c:3177
#29 0x00005555562bb609 in address_space_write (as=3D0x62100002d328, addr=3D=
0xe0000000, attrs=3D..., buf=3D0x625000260000, len=3D0x1000) at /home/alxnd=
r/Development/qemu/exec.c:3268
#30 0x00005555562c06a6 in address_space_unmap (as=3D0x62100002d328, buffer=
=3D0x625000260000, len=3D0x1000, is_write=3D0x1, access_len=3D0x1000) at /h=
ome/alxndr/Development/qemu/exec.c:3592
#31 0x0000555557257d73 in dma_memory_unmap (as=3D0x62100002d328, buffer=3D0=
x625000260000, len=3D0x1000, dir=3DDMA_DIRECTION_FROM_DEVICE, access_len=3D=
0x1000) at /home/alxndr/Development/qemu/include/sysemu/dma.h:145
#32 0x0000555557257c57 in usb_packet_unmap (p=3D0x6110000484c0, sgl=3D0x611=
000048548) at /home/alxndr/Development/qemu/hw/usb/libhw.c:65
#33 0x00005555572aa87e in ehci_execute_complete (q=3D0x60d000004f10) at /ho=
me/alxndr/Development/qemu/hw/usb/hcd-ehci.c:1324
#34 0x00005555572a7b8c in ehci_state_executing (q=3D0x60d000004f10) at /hom=
e/alxndr/Development/qemu/hw/usb/hcd-ehci.c:1973
#35 0x00005555572b3685 in ehci_advance_state (ehci=3D0x62100002d9f0, async=
=3D0x1) at /home/alxndr/Development/qemu/hw/usb/hcd-ehci.c:2094
#36 0x00005555572b2db9 in ehci_advance_async_state (ehci=3D0x62100002d9f0) =
at /home/alxndr/Development/qemu/hw/usb/hcd-ehci.c:2152
#37 0x00005555572a29c3 in ehci_work_bh (opaque=3D0x62100002d9f0) at /home/a=
lxndr/Development/qemu/hw/usb/hcd-ehci.c:2320
#38 0x0000555557bfba60 in aio_bh_call (bh=3D0x60400001cd90) at /home/alxndr=
/Development/qemu/util/async.c:136


I can reproduce it in qemu 5.0 using the commands in the attachment:

qemu-system-i386 \
-qtest stdio -nographic -monitor none -serial none \
-M pc-q35-5.0 -machine q35 \
-device ich9-usb-ehci1,bus=3Dpcie.0,addr=3D1d.7,multifunction=3Don,id=3Dich=
9-ehci-1 \
-device ich9-usb-uhci1,bus=3Dpcie.0,addr=3D1d.0,multifunction=3Don,masterbu=
s=3Dich9-ehci-1.0,firstport=3D0 \
-device ich9-usb-uhci2,bus=3Dpcie.0,addr=3D1d.1,multifunction=3Don,masterbu=
s=3Dich9-ehci-1.0,firstport=3D2 \
-device ich9-usb-uhci3,bus=3Dpcie.0,addr=3D1d.2,multifunction=3Don,masterbu=
s=3Dich9-ehci-1.0,firstport=3D4 \
-drive if=3Dnone,id=3Dusbcdrom,media=3Dcdrom \
-device usb-tablet,bus=3Dich9-ehci-1.0,port=3D1,usb_version=3D1 \
-device usb-storage,bus=3Dich9-ehci-1.0,port=3D2,drive=3Dusbcdrom \
-display none -nodefaults -nographic < attachment

Please let me know if I can provide any further info.
-Alex

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "attachment"
   https://bugs.launchpad.net/bugs/1878323/+attachment/5370723/+files/attac=
hment

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1878323

Title:
  Assertion-failure in usb_detach

Status in QEMU:
  New

Bug description:
  Hello,
  While fuzzing, I found an input that triggers an assertion-failure in usb=
_detach

  /home/alxndr/Development/qemu/hw/usb/core.c:69: void usb_detach(USBPort *=
): Assertion `dev->state !=3D USB_STATE_NOTATTACHED' failed.
  #3  0x00007ffff6866092 in __GI___assert_fail (assertion=3D0x555557fd2040 =
<str> "dev->state !=3D USB_STATE_NOTATTACHED", file=3D0x555557fd1ec0 <str> =
"/home/alxndr/Development/qemu/hw/usb/core.c", line=3D0x45, function=3D0x55=
5557fd2000 <__PRETTY_FUNCTION__.usb_detach> "void usb_detach(USBPort *)") a=
t assert.c:101
  #4  0x000055555723f0ce in usb_detach (port=3D0x62100002df30) at /home/alx=
ndr/Development/qemu/hw/usb/core.c:69
  #5  0x00005555572a05a4 in ehci_reset (opaque=3D0x62100002d9f0) at /home/a=
lxndr/Development/qemu/hw/usb/hcd-ehci.c:863
  #6  0x00005555572bf941 in ehci_opreg_write (ptr=3D0x62100002d9f0, addr=3D=
0x0, val=3D0xbebebebe, size=3D0x4) at /home/alxndr/Development/qemu/hw/usb/=
hcd-ehci.c:1032
  #7  0x00005555564938b5 in memory_region_write_accessor (mr=3D0x62100002dc=
b0, addr=3D0x0, value=3D0x7fffffffaad0, size=3D0x4, shift=3D0x0, mask=3D0xf=
fffffff, attrs=3D...) at /home/alxndr/Development/qemu/memory.c:483
  #8  0x000055555649328a in access_with_adjusted_size (addr=3D0x0, value=3D=
0x7fffffffaad0, size=3D0x4, access_size_min=3D0x1, access_size_max=3D0x4, a=
ccess_fn=3D0x555556493360 <memory_region_write_accessor>, mr=3D0x62100002dc=
b0, attrs=3D...) at /home/alxndr/Development/qemu/memory.c:544
  #9  0x0000555556491df6 in memory_region_dispatch_write (mr=3D0x62100002dc=
b0, addr=3D0x0, data=3D0xbebebebe, op=3DMO_32, attrs=3D...) at /home/alxndr=
/Development/qemu/memory.c:1476
  #10 0x00005555562cbbf4 in flatview_write_continue (fv=3D0x60600003e600, a=
ddr=3D0xe0000020, attrs=3D..., ptr=3D0x625000260000, len=3D0xfe0, addr1=3D0=
x0, l=3D0x4, mr=3D0x62100002dcb0) at /home/alxndr/Development/qemu/exec.c:3=
137
  #11 0x00005555562bbad9 in flatview_write (fv=3D0x60600003e600, addr=3D0xe=
0000000, attrs=3D..., buf=3D0x625000260000, len=3D0x1000) at /home/alxndr/D=
evelopment/qemu/exec.c:3177
  #12 0x00005555562bb609 in address_space_write (as=3D0x62100002d328, addr=
=3D0xe0000000, attrs=3D..., buf=3D0x625000260000, len=3D0x1000) at /home/al=
xndr/Development/qemu/exec.c:3268
  #13 0x00005555562c06a6 in address_space_unmap (as=3D0x62100002d328, buffe=
r=3D0x625000260000, len=3D0x1000, is_write=3D0x1, access_len=3D0x1000) at /=
home/alxndr/Development/qemu/exec.c:3592
  #14 0x0000555557257d73 in dma_memory_unmap (as=3D0x62100002d328, buffer=
=3D0x625000260000, len=3D0x1000, dir=3DDMA_DIRECTION_FROM_DEVICE, access_le=
n=3D0x1000) at /home/alxndr/Development/qemu/include/sysemu/dma.h:145
  #15 0x0000555557257c57 in usb_packet_unmap (p=3D0x6110000484c0, sgl=3D0x6=
11000048548) at /home/alxndr/Development/qemu/hw/usb/libhw.c:65
  #16 0x00005555572a5953 in ehci_free_packet (p=3D0x611000048480) at /home/=
alxndr/Development/qemu/hw/usb/hcd-ehci.c:536
  #17 0x00005555572a4ed4 in ehci_cancel_queue (q=3D0x60d000004f10) at /home=
/alxndr/Development/qemu/hw/usb/hcd-ehci.c:584
  #18 0x00005555572a49ab in ehci_free_queue (q=3D0x60d000004f10, warn=3D0x0=
) at /home/alxndr/Development/qemu/hw/usb/hcd-ehci.c:611
  #19 0x00005555572b102d in ehci_queues_rip_device (ehci=3D0x62100002d9f0, =
dev=3D0x623000001d00, async=3D0x1) at /home/alxndr/Development/qemu/hw/usb/=
hcd-ehci.c:674
  #20 0x00005555572af7a3 in ehci_detach (port=3D0x62100002df78) at /home/al=
xndr/Development/qemu/hw/usb/hcd-ehci.c:733
  #21 0x000055555723f15c in usb_detach (port=3D0x62100002df78) at /home/alx=
ndr/Development/qemu/hw/usb/core.c:70
  #22 0x00005555572a05a4 in ehci_reset (opaque=3D0x62100002d9f0) at /home/a=
lxndr/Development/qemu/hw/usb/hcd-ehci.c:863
  #23 0x00005555572bf941 in ehci_opreg_write (ptr=3D0x62100002d9f0, addr=3D=
0x0, val=3D0xbebebebe, size=3D0x4) at /home/alxndr/Development/qemu/hw/usb/=
hcd-ehci.c:1032
  #24 0x00005555564938b5 in memory_region_write_accessor (mr=3D0x62100002dc=
b0, addr=3D0x0, value=3D0x7fffffffc410, size=3D0x4, shift=3D0x0, mask=3D0xf=
fffffff, attrs=3D...) at /home/alxndr/Development/qemu/memory.c:483
  #25 0x000055555649328a in access_with_adjusted_size (addr=3D0x0, value=3D=
0x7fffffffc410, size=3D0x4, access_size_min=3D0x1, access_size_max=3D0x4, a=
ccess_fn=3D0x555556493360 <memory_region_write_accessor>, mr=3D0x62100002dc=
b0, attrs=3D...) at /home/alxndr/Development/qemu/memory.c:544
  #26 0x0000555556491df6 in memory_region_dispatch_write (mr=3D0x62100002dc=
b0, addr=3D0x0, data=3D0xbebebebe, op=3DMO_32, attrs=3D...) at /home/alxndr=
/Development/qemu/memory.c:1476
  #27 0x00005555562cbbf4 in flatview_write_continue (fv=3D0x60600003e600, a=
ddr=3D0xe0000020, attrs=3D..., ptr=3D0x625000260000, len=3D0xfe0, addr1=3D0=
x0, l=3D0x4, mr=3D0x62100002dcb0) at /home/alxndr/Development/qemu/exec.c:3=
137
  #28 0x00005555562bbad9 in flatview_write (fv=3D0x60600003e600, addr=3D0xe=
0000000, attrs=3D..., buf=3D0x625000260000, len=3D0x1000) at /home/alxndr/D=
evelopment/qemu/exec.c:3177
  #29 0x00005555562bb609 in address_space_write (as=3D0x62100002d328, addr=
=3D0xe0000000, attrs=3D..., buf=3D0x625000260000, len=3D0x1000) at /home/al=
xndr/Development/qemu/exec.c:3268
  #30 0x00005555562c06a6 in address_space_unmap (as=3D0x62100002d328, buffe=
r=3D0x625000260000, len=3D0x1000, is_write=3D0x1, access_len=3D0x1000) at /=
home/alxndr/Development/qemu/exec.c:3592
  #31 0x0000555557257d73 in dma_memory_unmap (as=3D0x62100002d328, buffer=
=3D0x625000260000, len=3D0x1000, dir=3DDMA_DIRECTION_FROM_DEVICE, access_le=
n=3D0x1000) at /home/alxndr/Development/qemu/include/sysemu/dma.h:145
  #32 0x0000555557257c57 in usb_packet_unmap (p=3D0x6110000484c0, sgl=3D0x6=
11000048548) at /home/alxndr/Development/qemu/hw/usb/libhw.c:65
  #33 0x00005555572aa87e in ehci_execute_complete (q=3D0x60d000004f10) at /=
home/alxndr/Development/qemu/hw/usb/hcd-ehci.c:1324
  #34 0x00005555572a7b8c in ehci_state_executing (q=3D0x60d000004f10) at /h=
ome/alxndr/Development/qemu/hw/usb/hcd-ehci.c:1973
  #35 0x00005555572b3685 in ehci_advance_state (ehci=3D0x62100002d9f0, asyn=
c=3D0x1) at /home/alxndr/Development/qemu/hw/usb/hcd-ehci.c:2094
  #36 0x00005555572b2db9 in ehci_advance_async_state (ehci=3D0x62100002d9f0=
) at /home/alxndr/Development/qemu/hw/usb/hcd-ehci.c:2152
  #37 0x00005555572a29c3 in ehci_work_bh (opaque=3D0x62100002d9f0) at /home=
/alxndr/Development/qemu/hw/usb/hcd-ehci.c:2320
  #38 0x0000555557bfba60 in aio_bh_call (bh=3D0x60400001cd90) at /home/alxn=
dr/Development/qemu/util/async.c:136

  =

  I can reproduce it in qemu 5.0 using the commands in the attachment:

  qemu-system-i386 \
  -qtest stdio -nographic -monitor none -serial none \
  -M pc-q35-5.0 -machine q35 \
  -device ich9-usb-ehci1,bus=3Dpcie.0,addr=3D1d.7,multifunction=3Don,id=3Di=
ch9-ehci-1 \
  -device ich9-usb-uhci1,bus=3Dpcie.0,addr=3D1d.0,multifunction=3Don,master=
bus=3Dich9-ehci-1.0,firstport=3D0 \
  -device ich9-usb-uhci2,bus=3Dpcie.0,addr=3D1d.1,multifunction=3Don,master=
bus=3Dich9-ehci-1.0,firstport=3D2 \
  -device ich9-usb-uhci3,bus=3Dpcie.0,addr=3D1d.2,multifunction=3Don,master=
bus=3Dich9-ehci-1.0,firstport=3D4 \
  -drive if=3Dnone,id=3Dusbcdrom,media=3Dcdrom \
  -device usb-tablet,bus=3Dich9-ehci-1.0,port=3D1,usb_version=3D1 \
  -device usb-storage,bus=3Dich9-ehci-1.0,port=3D2,drive=3Dusbcdrom \
  -display none -nodefaults -nographic < attachment

  Please let me know if I can provide any further info.
  -Alex

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1878323/+subscriptions

