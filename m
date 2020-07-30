Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81010C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 15:56:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52C87206F5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 15:56:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52C87206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1AvR-0008Rv-JL
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 11:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k1Akh-0001O3-9t
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:45:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:44216)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k1Ake-0003ZG-Ia
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:45:50 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k1Akc-000646-Es
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 15:45:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 6F7DD2E80BA
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 15:45:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2020 15:37:41 -0000
From: TheCatFelix <1884684@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: thecatfelix
X-Launchpad-Bug-Reporter: TheCatFelix (thecatfelix)
X-Launchpad-Bug-Modifier: TheCatFelix (thecatfelix)
References: <159287262873.13509.14889128175029136647.malonedeb@wampee.canonical.com>
Message-Id: <159612346193.10348.2150148730413805044.malone@chaenomeles.canonical.com>
Subject: [Bug 1884684] Re: QEMU 5.0: Guest VM hangs/freeze when unplugging USB
 device
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a24057fea7e4c6a98c0220d5f878da0f3c783699";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: cfb3d4b427667f9c39a8d915abce29914b5c786a
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 09:45:41
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1884684 <1884684@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Following reports on Proxmox forums, this is still very much seen by
multiple users with no known workaround.

I was able to run QEMU 5.0.13 (Debian) with all traces turned on and
capture the following:

- Behavior is reproducible by unbinding usb device on the host (ex. "echo '=
1-8' > /sys/bus/usb/drivers/usb/unbind")
- qemu trace logs stops at exactly the same time when VM freezes
- Last few lines of the qemu trace:

1592303@1596123157.254134:virtio_notify vdev 0x56193d04d820 vq 0x7fcd5c48a0=
10
1592320@1596123158.822309:usb_xhci_oper_read off 0x0004, ret 0x00000008
1592320@1596123158.822397:usb_xhci_port_read port 1, off 0x0000, ret 0x0e00=
02a0
1592320@1596123158.822459:usb_xhci_port_read port 2, off 0x0000, ret 0x0e00=
02a0
1592320@1596123158.822513:usb_xhci_port_read port 3, off 0x0000, ret 0x0e00=
02a0
1592320@1596123158.822565:usb_xhci_port_read port 4, off 0x0000, ret 0x0e00=
02a0
1592303@1596123159.858372:virtqueue_alloc_element elem 0x56193c8c8990 size =
56 in_num 2 out_num 0
1592303@1596123159.858435:virtqueue_pop vq 0x7fcd5c48a010 elem 0x56193c8c89=
90 in_num 2 out_num 0
1592303@1596123159.858482:virtqueue_fill vq 0x7fcd5c48a010 elem 0x56193c8c8=
990 len 72 idx 0
1592303@1596123159.858533:virtqueue_flush vq 0x7fcd5c48a010 count 1
1592303@1596123159.858565:virtio_notify vdev 0x56193d04d820 vq 0x7fcd5c48a0=
10
1592303@1596123160.272641:virtqueue_alloc_element elem 0x56193c8c8990 size =
56 in_num 2 out_num 0
1592303@1596123160.272702:virtqueue_pop vq 0x7fcd5c48a010 elem 0x56193c8c89=
90 in_num 2 out_num 0
1592303@1596123160.272751:virtqueue_fill vq 0x7fcd5c48a010 elem 0x56193c8c8=
990 len 104 idx 0
1592303@1596123160.272802:virtqueue_flush vq 0x7fcd5c48a010 count 1
1592303@1596123160.272833:virtio_notify vdev 0x56193d04d820 vq 0x7fcd5c48a0=
10
1592303@1596123160.845694:lockcnt_unlock_attempt lockcnt 0x56193bea6514 unl=
ock 5->4
1592303@1596123160.846821:lockcnt_unlock_success lockcnt 0x56193bea6514 unl=
ock 5->4 succeeded
1592303@1596123160.847923:usb_host_req_complete dev 1:4, packet 0x7fcb84000=
ea8, status 0, length 0
1592303@1596123160.849369:usb_packet_state_change bus 0, port 1, ep 2, pack=
et 0x7fcb84000ea8, state async -> complete
1592303@1596123160.851157:usb_xhci_xfer_success 0x7fcb84000ea0: len 0
1592303@1596123160.851214:usb_xhci_queue_event v 3, idx 5, ER_TRANSFER, CC_=
SHORT_PACKET, p 0xffffac0c62444ae3, s 0x0d000000, c 0x02058005
1592303@1596123160.851285:usb_xhci_irq_msix nr 3
1592303@1596123160.851331:usb_xhci_ep_kick slotid 2, epid 5, streamid 0
1592303@1596123160.851374:usb_host_req_data dev 1:4, packet 0x56193cce8da8,=
 in 1, ep 2, size 4
1592303@1596123160.851434:usb_host_req_complete dev 1:4, packet 0x56193cce8=
da8, status -1, length 0
1592303@1596123160.851485:usb_packet_state_change bus 0, port 1, ep 2, pack=
et 0x56193cce8da8, state queued -> complete
1592303@1596123160.851541:usb_xhci_xfer_error 0x56193cce8da0: ret -1
1592303@1596123160.851577:usb_xhci_queue_event v 3, idx 6, ER_TRANSFER, CC_=
USB_TRANSACTION_ERROR, p 0x00000001c18a4e20, s 0x04000004, c 0x02058001
1592303@1596123160.851647:usb_xhci_ep_state slotid 2, epid 5, running -> ha=
lted
1592303@1596123160.852700:usb_xhci_ep_kick slotid 2, epid 5, streamid 0
1592303@1596123160.852744:usb_host_req_complete dev 1:4, packet 0x7fcb84000=
b98, status 0, length 0
1592303@1596123160.852788:usb_packet_state_change bus 0, port 1, ep 1, pack=
et 0x7fcb84000b98, state async -> complete
1592303@1596123160.852845:usb_xhci_xfer_success 0x7fcb84000b90: len 0
1592303@1596123160.852879:usb_xhci_queue_event v 3, idx 7, ER_TRANSFER, CC_=
SHORT_PACKET, p 0xffffac0c6229aae3, s 0x0d000000, c 0x02038005
1592303@1596123160.852945:usb_xhci_ep_kick slotid 2, epid 3, streamid 0
1592303@1596123160.852977:usb_host_req_data dev 1:4, packet 0x56193c9da348,=
 in 1, ep 1, size 8
1592303@1596123160.853031:usb_host_req_complete dev 1:4, packet 0x56193c9da=
348, status -1, length 0
1592303@1596123160.853080:usb_packet_state_change bus 0, port 1, ep 1, pack=
et 0x56193c9da348, state queued -> complete
1592303@1596123160.853136:usb_xhci_xfer_error 0x56193c9da340: ret -1
1592303@1596123160.853170:usb_xhci_queue_event v 3, idx 8, ER_TRANSFER, CC_=
USB_TRANSACTION_ERROR, p 0x00000001c18a4c20, s 0x04000008, c 0x02038001
1592303@1596123160.853240:usb_xhci_ep_state slotid 2, epid 3, running -> ha=
lted
1592303@1596123160.853280:usb_xhci_ep_kick slotid 2, epid 3, streamid 0
1592303@1596123160.853316:lockcnt_unlock_attempt lockcnt 0x56193bea6514 unl=
ock 1->4
1592303@1596123160.853352:lockcnt_unlock_success lockcnt 0x56193bea6514 unl=
ock 1->4 succeeded
1592303@1596123160.853564:usb_host_close dev 1:4
libusb: error [udev_hotplug_event] ignoring udev action unbind

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1884684

Title:
  QEMU 5.0: Guest VM hangs/freeze when unplugging USB device

Status in QEMU:
  New

Bug description:
  Setup:

  Host: Debian/SID, Kernel 5.6, QEMU 5.0
  Guest: Windows 10 VM with PCI and USB device passthrough.

  Problem: Guest VM suddenly hangs when pulling USB device out from the
  Host.

  Observations:
   - Issue appears to be related to QEMU 5.0
     - It started after an upgrade to QEMU 5.0.
     - Downgrading only QEMU on multiple systems fixes the issue.

   - Issue is very reproducible.
     - Most of the time within a few attempts of pulling/reconnecting the d=
evice.
     - Issue happens with multiple devices (I did try standard HID devices,=
 a webcam and an x-ray sensor).

   - Guest just hangs.
     - Display output remains on last frame shown.
     - Ping to Guest immediately stops working.
     - Logs in the Guest stop logging immediately.

   - Host is fine and thinks the Guest is fine. =

     - Guest continues to show as running in "virsh list".
     - No suspicious entries in the QEMU logs.
     - No suspicious entries in Host syslogs/messages.
     - Host can can kill guest "virsh destroy" and respawn fine.

   - Issue seems widespread.
     - Multiple similar reports from ProxMox users after upgrade to ProxMox=
 6.2 for both Windows and Linux guests (First version that uses QEMU 5.0)

  https://forum.proxmox.com/threads/vm-freezes-when-disconnecting-usb-keybo=
ard-and-mouse.70287/
  https://forum.proxmox.com/threads/usb-drive-crashes-vm.70214/
  https://forum.proxmox.com/threads/latest-proxmox-usb-disconnects-freeze-k=
vm.70398/
  https://forum.proxmox.com/threads/vm-with-gpu-passthrough-freezes-when-tu=
rning-off-monitor-after-proxmox-6-2-upgrade.69821/
  https://forum.proxmox.com/threads/vm-with-gpu-passthrough-freezes-when-tu=
rning-off-monitor-after-proxmox-6-2-upgrade.69824/

  I'd be more than happy any debugs that might be helpful.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1884684/+subscriptions

