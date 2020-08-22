Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A130BC433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 16:56:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D2E7206C0
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 16:56:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D2E7206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9Woj-0004fO-LW
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 12:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k9Wnr-00044p-IE
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 12:55:39 -0400
Received: from indium.canonical.com ([91.189.90.7]:59948)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k9Wnp-0007WV-Kf
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 12:55:39 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k9Wnm-0003Zu-QA
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2020 16:55:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id B23792E8072
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2020 16:55:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2020 16:49:22 -0000
From: Diego Viola <1892581@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: diego-viola
X-Launchpad-Bug-Reporter: Diego Viola (diego-viola)
X-Launchpad-Bug-Modifier: Diego Viola (diego-viola)
References: <159810419955.15369.6411904597131705076.malonedeb@soybean.canonical.com>
Message-Id: <159811496220.16435.500218203294753970.malone@soybean.canonical.com>
Subject: [Bug 1892581] Re: QEMU 5.1 no longer says anything about inaccessible
 devices
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="99c2d833c8d727fd05148486920aca032e908071"; Instance="production"
X-Launchpad-Hash: ac5c8a0aa9e41258d2e0832bab05de10f4264fc3
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/22 12:55:35
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
Reply-To: Bug 1892581 <1892581@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Not sure this is a bug.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1892581

Title:
  QEMU 5.1 no longer says anything about inaccessible devices

Status in QEMU:
  New

Bug description:
  Previously, with QEMU 5.0.0 running a VM with the following command:

  $ qemu-system-x86_64 -enable-kvm -hda arch-zoom.qcow2 -m 4G -device
  usb-ehci,id=3Dehci -device usb-
  host,bus=3Dehci.0,vendorid=3D0x04f2,productid=3D0xb449 -device intel-hda
  -device hda-duplex -vga virtio

  Would display something like the following:

  libusb: error [_get_usbfs_fd] libusb couldn't open USB device /dev/bus/us=
b/002/004: Permission denied
  libusb: error [_get_usbfs_fd] libusb requires write access to USB device =
nodes.
  libusb: error [_get_usbfs_fd] libusb couldn't open USB device /dev/bus/us=
b/002/004: Permission denied
  libusb: error [_get_usbfs_fd] libusb requires write access to USB device =
nodes.

  With insufficient permissions.

  QEMU 5.1.0 no longer displays anything.

  I did a git bisect and this is the result:

  [diego@thinkpad qemu]$ git bisect bad
  9f815e83e983d247a3cd67579d2d9c1765adc644 is the first bad commit
  commit 9f815e83e983d247a3cd67579d2d9c1765adc644
  Author: Gerd Hoffmann <kraxel@redhat.com>
  Date:   Fri Jun 5 14:59:52 2020 +0200

      usb: add hostdevice property to usb-host

      The new property allows to specify usb host device name.  Uses standa=
rd
      qemu_open(), so both file system path (/dev/bus/usb/$bus/$dev on linu=
x)
      and file descriptor passing can be used.

      Requires libusb 1.0.23 or newer.  The hostdevice property is only
      present in case qemu is compiled against a new enough library version,
      so the presence of the property can be used for feature detection.

      Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
      Message-Id: <20200605125952.13113-1-kraxel@redhat.com>

   hw/usb/host-libusb.c | 75 ++++++++++++++++++++++++++++++++++++++++++----=
------
   hw/usb/trace-events  |  1 +
   2 files changed, 62 insertions(+), 14 deletions(-)
  [diego@thinkpad qemu]$

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1892581/+subscriptions

