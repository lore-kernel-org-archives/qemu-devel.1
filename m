Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD73C2D0F6
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 02:10:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 801B0206CC
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 02:10:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 801B0206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYgr4-0004Lq-PA
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 22:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jYgqI-0003pn-VQ
 for qemu-devel@nongnu.org; Tue, 12 May 2020 22:09:54 -0400
Received: from indium.canonical.com ([91.189.90.7]:50776)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jYgqH-0007HQ-JM
 for qemu-devel@nongnu.org; Tue, 12 May 2020 22:09:54 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jYgqF-0002WY-NI
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 02:09:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id A580F2E802E
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 02:09:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2020 01:58:56 -0000
From: Alexander Bulekov <1525123@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Expired; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public Security
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: yes
X-Launchpad-Bug-Commenters: a1xndr janitor joveler th-huth
X-Launchpad-Bug-Reporter: Hajin Jang (joveler)
X-Launchpad-Bug-Modifier: Alexander Bulekov (a1xndr)
References: <20151211084346.25665.93589.malonedeb@gac.canonical.com>
Message-Id: <158933513720.13457.13559061694999933863.malone@wampee.canonical.com>
Subject: [Bug 1525123] Re: USB assert failure on hcd-uhci.c
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="013b6f2a3f3ba130b50b9eee1a89957ee38a5c15";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: b1ac0aaf1773d6994717389eb4b39df2f50e4f75
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
Reply-To: Bug 1525123 <1525123@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,
While fuzzing, I found an input that triggers this assertion-failure in usb=
_ep_get

/home/alxndr/Development/qemu/hw/usb/core.c:723: struct USBEndpoint *usb_ep=
_get(USBDevice *, int, int): Assertion `pid =3D=3D USB_TOKEN_IN || pid =3D=
=3D USB_TOKEN_OUT' failed.
#3  0x00007ffff6866092 in __GI___assert_fail (assertion=3D0x555557fd2c60 <s=
tr> "pid =3D=3D USB_TOKEN_IN || pid =3D=3D USB_TOKEN_OUT", file=3D0x555557f=
d1ec0 <str> "/home/alxndr/Development/qemu/hw/usb/core.c", line=3D0x2d3, fu=
nction=3D0x555557fd2c00 <__PRETTY_FUNCTION__.usb_ep_get> "struct USBEndpoin=
t *usb_ep_get(USBDevice *, int, int)") at assert.c:101
#4  0x000055555724690a in usb_ep_get (dev=3D0x623000001d00, pid=3D0x0, ep=
=3D0x2) at /home/alxndr/Development/qemu/hw/usb/core.c:723
#5  0x00005555572bdd8e in ehci_execute (p=3D0x611000048480, action=3D0x5555=
57fdd860 <str> "process") at /home/alxndr/Development/qemu/hw/usb/hcd-ehci.=
c:1366
#6  0x00005555572b74a3 in ehci_state_execute (q=3D0x60d000004f10) at /home/=
alxndr/Development/qemu/hw/usb/hcd-ehci.c:1942
#7  0x00005555572b3510 in ehci_advance_state (ehci=3D0x62100002d9f0, async=
=3D0x1) at /home/alxndr/Development/qemu/hw/usb/hcd-ehci.c:2083
#8  0x00005555572b2db9 in ehci_advance_async_state (ehci=3D0x62100002d9f0) =
at /home/alxndr/Development/qemu/hw/usb/hcd-ehci.c:2152
#9  0x00005555572a29c3 in ehci_work_bh (opaque=3D0x62100002d9f0) at /home/a=
lxndr/Development/qemu/hw/usb/hcd-ehci.c:2320
#10 0x0000555557bfba60 in aio_bh_call (bh=3D0x60400001cd90) at /home/alxndr=
/Development/qemu/util/async.c:136
#11 0x0000555557bfc1fe in aio_bh_poll (ctx=3D0x61300008fa00) at /home/alxnd=
r/Development/qemu/util/async.c:164
#12 0x0000555557c149e8 in aio_dispatch (ctx=3D0x61300008fa00) at /home/alxn=
dr/Development/qemu/util/aio-posix.c:380
#13 0x0000555557c00455 in aio_ctx_dispatch (source=3D0x61300008fa00, callba=
ck=3D0x0, user_data=3D0x0) at /home/alxndr/Development/qemu/util/async.c:306
#14 0x00007ffff7ca89ee in g_main_context_dispatch () at /usr/lib/x86_64-lin=
ux-gnu/libglib-2.0.so.0


I can reproduce it in qemu 5.0 using:

cat << EOF | ~/Development/qemu/build/i386-softmmu/qemu-system-i386 \
-qtest stdio -nographic -monitor none -serial none \
-M pc-q35-5.0 -machine q35 \
-device ich9-usb-ehci1,bus=3Dpcie.0,addr=3D1d.7,multifunction=3Don,id=3Dich=
9-ehci-1 \
-drive if=3Dnone,id=3Dusbcdrom,media=3Dcdrom \
-device usb-storage,bus=3Dich9-ehci-1.0,port=3D2,drive=3Dusbcdrom \
-display none -nodefaults -nographic
outl 0xcf8 0x8000ef10
outl 0xcfc 0xe0000000
outl 0xcf8 0x8000ef14
outl 0xcf8 0x8000ef04
outw 0xcfc 0x7
outl 0xcf8 0x8000fa20
write 0xe0000020 0x4b 0x21fe00695501ff21fe00695501ff21fe00695501ff21fe00695=
501ff21fe00695501ff21fe00695501ff21fe00695501ff21fe00695501ff21fe00695501ff=
21fe00695501ff21fe006955
write 0x5 0x1 0x92
write 0x15 0x3 0x92ab01
write 0x1b 0x1 0xab
write 0x1ab9208 0x2 0x92ab
EOF

I also attached the commands to this launchpad report, in case the formatti=
ng
is broken:

qemu-system-i386 \
-qtest stdio -nographic -monitor none -serial none \
-M pc-q35-5.0 -machine q35 \
-device ich9-usb-ehci1,bus=3Dpcie.0,addr=3D1d.7,multifunction=3Don,id=3Dich=
9-ehci-1 \
-drive if=3Dnone,id=3Dusbcdrom,media=3Dcdrom \
-device usb-storage,bus=3Dich9-ehci-1.0,port=3D2,drive=3Dusbcdrom \
-display none -nodefaults -nographic < attachment

Please let me know if I can provide any further info.
-Alex


** Attachment added: "attachment"
   https://bugs.launchpad.net/qemu/+bug/1525123/+attachment/5370680/+files/=
attachment

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1525123

Title:
  USB assert failure on hcd-uhci.c

Status in QEMU:
  Expired

Bug description:
  When inserting the attached kernel moudle in the guest OS, QEMU quits
  with therse assert failure:

  [insert kernel module in guest root shell]
  root@qemu:~# insmod mymod.ko
  root@qemu:~#
  Connection closed by foreign host.

  [host message]
  qemu-system-x86_64: hw/usb/core.c:718: usb_ep_get: Assertion `pid =3D=3D =
0x69 || pid =3D=3D 0xe1' failed.
  Aborted

  The direct cause of this bug is due to misimplementation of UHCI.
  According to Intel's UHCI design guide, packet identification in transfer=
 descriptor must be one of these three values : IN (69h), OUT (E1h), and SE=
TUP (2Dh). Any other value in this field must cause the HALT of only HOST C=
ONTROLLER.

  However, due to misimplementation in uhci_handle_td, instead of host
  controller being halted, QEMU itself dies with assertion failure. The
  assertion code is in usb_ep_get():718, which is called during
  uhci_handle_td().

  Another issue resides in uhci_handle_td(). This function must check
  that transfer descriptor's pid is one of IN, OUT, SETUP before calling
  usb_ep_get() or other functions. If it does so, usb_ep_get() only
  needs to check if pid is not SETUP.

  This kind of assert failure can be misused by malwares to avoid being
  analyzed by terminating only in the virtual environments and still
  execute the malicious code in real machines.

  =

  [How to run exploit code]
  Prepare linux kernel's source header, then type these lines in root shell.
  # make
  # insmod mymod.ko

  It needs uhci-hcd.h from linux kernel source.
  I attached linux 3.18.24's uhci-hcd.h for tempory measure; You should get=
 proper version of uhci-hcd.h.
  In the following envrionment, this exploit worked, exiting whole QEMU, no=
t only USB.

  QEMU was running on these environment :
  [CPU model] Intel(R) Core(TM) i5-4590 CPU @ 3.30GHz
  [qemu version] QEMU 2.5.0-rc3 (compiled from source, gcc 4.8.4)
  [host info] Ubuntu 14.04.3, x86_64, 3.19.0-32-generic
  [guest info] Ubuntu 14.04.3, x86_64, 3.19.0-28-generic
  [QEMU argument]
  x86_64-softmmu/qemu-system-x86_64 -hda /media/hdd/img/ubuntu1404.qcow2 \
  =C2=A0-m 512 \
  =C2=A0--usbdevice disk:format=3Dqcow2:../usb.img \
  =C2=A0--enable-kvm

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1525123/+subscriptions

