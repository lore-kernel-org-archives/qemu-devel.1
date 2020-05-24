Return-Path: <SRS0=Dt9u=7G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F048C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 22:06:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7662C2076C
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 22:06:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7662C2076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcyl4-0002LU-Kq
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 18:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jcykX-0001rw-Ip
 for qemu-devel@nongnu.org; Sun, 24 May 2020 18:05:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:48264)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jcykW-0000Bv-8j
 for qemu-devel@nongnu.org; Sun, 24 May 2020 18:05:41 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jcykT-0004GJ-Ti
 for <qemu-devel@nongnu.org>; Sun, 24 May 2020 22:05:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id DE8392E807D
 for <qemu-devel@nongnu.org>; Sun, 24 May 2020 22:05:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 24 May 2020 21:57:21 -0000
From: BALATON Zoltan <1810000@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: balaton-4 benquike th-huth
X-Launchpad-Bug-Reporter: PH (benquike)
X-Launchpad-Bug-Modifier: BALATON Zoltan (balaton-4)
References: <154603590627.5548.1380267988808710453.malonedeb@wampee.canonical.com>
Message-Id: <159035744156.1842.16776636825826676221.malone@chaenomeles.canonical.com>
Subject: [Bug 1810000] Re: qemu system emulator crashed with the attachment of
 usb-bt-dongle device
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1f7bc749b40714a4cc10f5e4d787118a78037035";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 6f28353f6164daca77c19b9f9f234b87c4e1fce8
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/24 18:05:38
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
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
Reply-To: Bug 1810000 <1810000@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This issue has nothing to do with bluetooth rather something with xhci. I'v=
e got the same error while trying to pass through a usb device to a Windows=
 VM, once the guest driver is loaded in the the assert fires so probably it=
's trying to send something that's not handled correctly. A similar (same?)=
 issue is also mentioned in this bug tracker: =

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D849884

For me it happens with both qemu-xhci and nec-usb-xhci

Here are some debug infos I could gather, not sure if it helps:

qemu-system-x86_64: hw/usb/core.c:591: usb_packet_copy: Assertion `p->actua=
l_length + bytes <=3D iov->size' failed.
(gdb) bt
#0  0x00007ffff6b85a7a in raise () at /lib64/libc.so.6
#1  0x00007ffff6b6e524 in abort () at /lib64/libc.so.6
#2  0x00007ffff6b6e40f in _nl_load_domain.cold.0 () at /lib64/libc.so.6
#3  0x00007ffff6b7a9a2 in  () at /lib64/libc.so.6
#4  0x0000555555bd1c93 in usb_packet_copy (p=3D0x7fff680fc8f8, ptr=3D0x5555=
5772d63c, bytes=3D5) at hw/usb/core.c:591
#5  0x0000555555bd10ba in usb_generic_async_ctrl_complete (s=3D0x55555772d5=
50, p=3D0x7fff680fc8f8) at hw/usb/core.c:332
#6  0x0000555555c0dc54 in usb_host_req_complete_ctrl (xfer=3D0x7fff681a6430=
) at hw/usb/host-libusb.c:416
#7  0x00007ffff7c68082 in  () at /lib64/libusb-1.0.so.0
#8  0x00007ffff7c6bd1a in  () at /lib64/libusb-1.0.so.0
#9  0x00007ffff7c6daa8 in  () at /lib64/libusb-1.0.so.0
#10 0x00007ffff7c67a28 in  () at /lib64/libusb-1.0.so.0
#11 0x00007ffff7c68b13 in libusb_handle_events_timeout_completed () at /lib=
64/libusb-1.0.so.0
#12 0x0000555555c0d4a6 in usb_host_handle_fd (opaque=3D0x5555568eeb70) at h=
w/usb/host-libusb.c:226
#13 0x0000555555e2099c in aio_dispatch_handler (ctx=3D0x555556614530, node=
=3D0x5555570c06c0) at util/aio-posix.c:339
[...]
(gdb) up
#4  0x0000555555bd1c93 in usb_packet_copy (p=3D0x7fff680fc8f8, ptr=3D0x5555=
5772d63c, bytes=3D5) at hw/usb/core.c:591
591	    assert(p->actual_length + bytes <=3D iov->size);
(gdb) list
586	void usb_packet_copy(USBPacket *p, void *ptr, size_t bytes)
587	{
588	    QEMUIOVector *iov =3D p->combined ? &p->combined->iov : &p->iov;
589	=

590	    assert(p->actual_length >=3D 0);
591	    assert(p->actual_length + bytes <=3D iov->size);
(gdb) p/x *p
$3 =3D {pid =3D 0x69, id =3D 0x1a20f5c0, ep =3D 0x55555772e650, stream =3D =
0x0,
     iov =3D {iov =3D 0x7fff680fc200, niov =3D 0x0, {{nalloc =3D 0x1, local=
_iov =3D {iov_base =3D 0x0, iov_len =3D 0x0}}, {__pad =3D {
     0x1, 0x0 <repeats 11 times>}, size =3D 0x0}}}, parameter =3D 0x500000f=
000680, short_not_ok =3D 0x0, int_req =3D 0x1,
     status =3D 0x0, actual_length =3D 0x0, state =3D 0x3, combined =3D 0x0,
     queue =3D {tqe_next =3D 0x0, tqe_circ =3D {tql_next =3D 0x0, tql_prev =
=3D 0x55555772e668}},
     combined_entry =3D {tqe_next =3D 0x0, tqe_circ =3D {tql_next =3D 0x0, =
tql_prev =3D 0x0}}}


** Bug watch added: Debian Bug tracker #849884
   https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D849884

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

