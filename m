Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC1AC388F7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 11:06:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 575FF206CB
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 11:06:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 575FF206CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaGcm-0001Fh-TF
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 06:06:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kaGby-0000h0-BG
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 06:05:54 -0500
Received: from indium.canonical.com ([91.189.90.7]:42092)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kaGbv-0007Th-RR
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 06:05:54 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kaGbt-00008V-On
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 11:05:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id B55192E811E
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 11:05:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2020 10:54:08 -0000
From: Gaoning Pan <1901981@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided;
 assignee=pgn@zju.edu.cn; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: hades0506 kraxel-redhat
X-Launchpad-Bug-Reporter: Gaoning Pan (hades0506)
X-Launchpad-Bug-Modifier: Gaoning Pan (hades0506)
References: <160395133608.8291.17236692663498581160.malonedeb@soybean.canonical.com>
Message-Id: <160448724836.7104.8035875855775706417.malone@chaenomeles.canonical.com>
Subject: [Bug 1901981] Re: assert issue locates in hw/usb/dev-storage.c:248:
 usb_msd_send_status
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="8e1d622aa7e69e8b5bd9e10dd26da4991d9a7dfb"; Instance="production"
X-Launchpad-Hash: 029385a01ac71d976a3ab0fef2e4d5ee1a3953f7
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 05:35:47
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
Reply-To: Bug 1901981 <1901981@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sorry, my reproduced environment is as follows:
    Host: ubuntu 18.04
    Guest: ubuntu 18.04

Stderr log is as follows:
usb-msd: Reset
usb-msd: Command on LUN 0
usb-msd: Command tag 0x0 flags 00000000 len 0 data 0
[scsi.0 id=3D0] INQUIRY 0x00 0x00 0x00 0x01 0x00 - from-dev len=3D1
usb-msd: Deferring packet 0x6110002d2d40 [wait status]
usb-msd: Command status 0 tag 0x0, len 256
qemu-system-x86_64: hw/usb/dev-storage.c:248: usb_msd_send_status: Assertio=
n `s->csw.sig =3D=3D cpu_to_le32(0x53425355)' failed.
[1]    643 abort      sudo  -enable-kvm -boot c -m 4G -drive format=3Dqcow2=
,file=3D./ubuntu.img -nic


Backtrace is as follows:
#0  0x00007f8b36a63f47 in __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps/un=
ix/sysv/linux/raise.c:51
#1  0x00007f8b36a658b1 in __GI_abort () at abort.c:79
#2  0x00007f8b36a5542a in __assert_fail_base (fmt=3D0x7f8b36bdca38 "%s%s%s:=
%u: %s%sAssertion `%s' failed.\n%n", assertion=3Dassertion@entry=3D0x55aef4=
1e7440 "s->csw.sig =3D=3D cpu_to_le32(0x53425355)", file=3Dfile@entry=3D0x5=
5aef41e7180 "hw/usb/dev-storage.c", line=3Dline@entry=3D248, function=3Dfun=
ction@entry=3D0x55aef41e7980 <__PRETTY_FUNCTION__.29124> "usb_msd_send_stat=
us") at assert.c:92
#3  0x00007f8b36a554a2 in __GI___assert_fail (assertion=3Dassertion@entry=
=3D0x55aef41e7440 "s->csw.sig =3D=3D cpu_to_le32(0x53425355)", file=3Dfile@=
entry=3D0x55aef41e7180 "hw/usb/dev-storage.c", line=3Dline@entry=3D248, fun=
ction=3Dfunction@entry=3D0x55aef41e7980 <__PRETTY_FUNCTION__.29124> "usb_ms=
d_send_status") at assert.c:101
#4  0x000055aef32226d5 in usb_msd_send_status (s=3D0x623000001d00, p=3D0x61=
10002e3500) at hw/usb/dev-storage.c:248
#5  0x000055aef322804e in usb_msd_handle_data (dev=3D0x623000001d00, p=3D0x=
6110002e3500) at hw/usb/dev-storage.c:525
#6  0x000055aef30bc46a in usb_device_handle_data (dev=3Ddev@entry=3D0x62300=
0001d00, p=3Dp@entry=3D0x6110002e3500) at hw/usb/bus.c:179
#7  0x000055aef30a0ab4 in usb_process_one (p=3Dp@entry=3D0x6110002e3500) at=
 hw/usb/core.c:387
#8  0x000055aef30a9db0 in usb_handle_packet (dev=3D0x623000001d00, p=3Dp@en=
try=3D0x6110002e3500) at hw/usb/core.c:419
#9  0x000055aef30fe890 in uhci_handle_td (s=3Ds@entry=3D0x61f000002a80, q=
=3D0x6060000c9200, q@entry=3D0x0, qh_addr=3Dqh_addr@entry=3D0, td=3Dtd@entr=
y=3D0x7ffd88f90620, td_addr=3D<optimized out>, int_mask=3Dint_mask@entry=3D=
0x7ffd88f905a0) at hw/usb/hcd-uhci.c:899
#10 0x000055aef3104c6f in uhci_process_frame (s=3Ds@entry=3D0x61f000002a80)=
 at hw/usb/hcd-uhci.c:1075
#11 0x000055aef31098e0 in uhci_frame_timer (opaque=3D0x61f000002a80) at hw/=
usb/hcd-uhci.c:1174
#12 0x000055aef3ae5f95 in timerlist_run_timers (timer_list=3D0x60b000051be0=
) at util/qemu-timer.c:572
#13 0x000055aef3ae619b in qemu_clock_run_timers (type=3DQEMU_CLOCK_VIRTUAL)=
 at util/qemu-timer.c:586
#14 0x000055aef3ae6922 in qemu_clock_run_all_timers () at util/qemu-timer.c=
:672
#15 0x000055aef3aca63d in main_loop_wait (nonblocking=3D0) at util/main-loo=
p.c:523
#16 0x000055aef1f320f5 in qemu_main_loop () at /home/zjusvn/new-hyper/qemu-=
5.1.0/softmmu/vl.c:1676
#17 0x000055aef397475c in main (argc=3D18, argv=3D0x7ffd88f90e98, envp=3D0x=
7ffd88f90f30) at /home/zjusvn/new-hyper/qemu-5.1.0/softmmu/main.c:49
#18 0x00007f8b36a46b97 in __libc_start_main (main=3D0x55aef397471d <main>, =
argc=3D18, argv=3D0x7ffd88f90e98, init=3D<optimized out>, fini=3D<optimized=
 out>, rtld_fini=3D<optimized out>, stack_end=3D0x7ffd88f90e88) at ../csu/l=
ibc-start.c:310
#19 0x000055aef1a3481a in _start ()

thanks.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1901981

Title:
  assert issue locates in hw/usb/dev-storage.c:248: usb_msd_send_status

Status in QEMU:
  New

Bug description:
  Hello,

  I found an assertion failure through hw/usb/dev-storage.c.

  This was found in latest version 5.1.0.

  --------

  qemu-system-x86_64: hw/usb/dev-storage.c:248: usb_msd_send_status: Assert=
ion `s->csw.sig =3D=3D cpu_to_le32(0x53425355)' failed.
  [1]    29544 abort      sudo  -enable-kvm -boot c -m 2G -drive format=3Dq=
cow2,file=3D./ubuntu.img -nic

  To reproduce the assertion failure, please run the QEMU with following
  command line.

  =

  $ qemu-system-x86_64 -enable-kvm -boot c -m 2G -drive format=3Dqcow2,file=
=3D./ubuntu.img -nic user,model=3Drtl8139,hostfwd=3Dtcp:0.0.0.0:5555-:22 -d=
evice piix4-usb-uhci,id=3Duhci -device usb-storage,drive=3Dmydrive -drive i=
d=3Dmydrive,file=3Dnull-co://,size=3D2M,format=3Draw,if=3Dnone

  The poc is attached.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1901981/+subscriptions

