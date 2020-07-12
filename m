Return-Path: <SRS0=QItv=AX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71375C433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 13:16:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4825820674
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 13:16:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4825820674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jubqF-0000JM-Jr
	for qemu-devel@archiver.kernel.org; Sun, 12 Jul 2020 09:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jubpe-0008KF-Kr
 for qemu-devel@nongnu.org; Sun, 12 Jul 2020 09:15:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:44396)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jubpc-0000Db-Dy
 for qemu-devel@nongnu.org; Sun, 12 Jul 2020 09:15:50 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jubpa-0005lW-JN
 for <qemu-devel@nongnu.org>; Sun, 12 Jul 2020 13:15:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 8D9E22E80BA
 for <qemu-devel@nongnu.org>; Sun, 12 Jul 2020 13:15:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Jul 2020 13:07:59 -0000
From: Ticketsolve <1809665@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: kawsper saveriomiroddi th-huth ticketsolve
X-Launchpad-Bug-Reporter: Saverio Miroddi (saveriomiroddi)
X-Launchpad-Bug-Modifier: Ticketsolve (ticketsolve)
References: <154566626385.25910.12711983515604457304.malonedeb@chaenomeles.canonical.com>
Message-Id: <159455927917.13459.12205518999191923746.malone@gac.canonical.com>
Subject: [Bug 1809665] Re: Xbox One controller USB passthrough disconnections
 and stops
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="4809fcb62f445aaa3ae919f7f6c3cc7d156ea57a";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 27447eaf70bfed191a26d28d9b2ca9126f16702e
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/12 04:40:51
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
Reply-To: Bug 1809665 <1809665@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> This happened to me as well, but I managed to find a solution, if I
ban the xpad driver through modprobe.d, then the problem disappear.

Thanks, that's very interesting (and useful, although nowadays I use the
BT connection).

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1809665

Title:
  Xbox One controller USB passthrough disconnections and stops

Status in QEMU:
  New

Bug description:
  I can't properly passthrough my Xbox One controller to a virtual
  machine; it causes USB disconnections on the host, ultimately
  preventing it to work (at all) on the guest

  I've seen a few other cases reported in other websites, which show the
  same symptoms:

  - https://www.reddit.com/r/VFIO/comments/97dhbw/qemu_w10_xbox_one_control=
ler
  - https://unix.stackexchange.com/questions/452751/how-can-i-pass-through-=
an-xbox-one-controller-to-a-windows-vm-on-ubuntu

  This is sample:

      libusb: error [udev_hotplug_event] ignoring udev action bind
      qemu-system-x86_64: libusb_release_interface: -4 [NO_DEVICE]
      qemu-system-x86_64: libusb_release_interface: -4 [NO_DEVICE]
      qemu-system-x86_64: libusb_release_interface: -4 [NO_DEVICE]
      libusb: error [_get_usbfs_fd] File doesn't exist, wait 10 ms and try =
again
      libusb: error [_get_usbfs_fd] libusb couldn't open USB device
          /dev/bus/usb/003/016: No such file or directory

  I think this is a quite long-standing issue, as I've been experiencing
  through several versions, including the current one (3.1).

  I can reproduce this 100% of the times, on multiple host O/S
  distributions (the current one being based on Ubuntu 18.04 x86-64).

  I compile QEMU directly from source, and execute it via commandline;
  the command is very long, however, the relevant part is standard (I
  think):

      -usb \
      -device usb-tablet \
      -device usb-host,vendorid=3D0x$VGAPT_XBOX_PAD_VEND_ID,productid=3D0x$=
VGAPT_XBOX_PAD_PROD_ID \

  The guest is Windows 10 64bit.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1809665/+subscriptions

