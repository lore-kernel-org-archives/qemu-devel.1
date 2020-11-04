Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777B6C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 20:36:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4BD0206DB
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 20:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4BD0206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaPWJ-0005yl-DM
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 15:36:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kaPQf-00017o-FA
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 15:30:49 -0500
Received: from indium.canonical.com ([91.189.90.7]:51598)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kaPQd-0007Kk-6t
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 15:30:49 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kaPQa-0001lx-HX
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 20:30:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 83AC92E812F
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 20:30:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2020 20:21:04 -0000
From: John Snow <1887309@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Committed; importance=Undecided;
 assignee=jsnow@redhat.com; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: a1xndr jnsnow philmd
X-Launchpad-Bug-Reporter: Alexander Bulekov (a1xndr)
X-Launchpad-Bug-Modifier: John Snow (jnsnow)
References: <159458555115.12636.15753095068884071065.malonedeb@gac.canonical.com>
Message-Id: <160452126487.18154.914379270865497825.malone@wampee.canonical.com>
Subject: [Bug 1887309] Re: Floating-point exception in ide_set_sector
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e39939c02bd86af4202bc6e2123a7708215ec8ea"; Instance="production"
X-Launchpad-Hash: 0038dafcef3ac341a4abc125fae88c0f33112162
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 14:49:49
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
Reply-To: Bug 1887309 <1887309@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Merged upstream:

55adb3c45620c31f29978f209e2a44a08d34e2da
4ac4e7281a2dd1ca5158812198c4d2cbacf2ae25
b45bcd81e05dea2781f2164ca1c9dd86069502ea
1a9925e3390b6adf1125e3abaa17c80ca012bede

** Changed in: qemu
       Status: In Progress =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1887309

Title:
  Floating-point exception in ide_set_sector

Status in QEMU:
  Fix Committed

Bug description:
  Hello,
  Here is a reproducer:
  cat << EOF | ./i386-softmmu/qemu-system-i386 -M pc,accel=3Dqtest\
   -qtest null -nographic -vga qxl -qtest stdio -nodefaults\
   -drive if=3Dnone,id=3Ddrive0,file=3Dnull-co://,file.read-zeroes=3Don,for=
mat=3Draw\
   -drive if=3Dnone,id=3Ddrive1,file=3Dnull-co://,file.read-zeroes=3Don,for=
mat=3Draw\
   -device ide-cd,drive=3Ddrive0 -device ide-hd,drive=3Ddrive1
  outw 0x176 0x3538
  outl 0xcf8 0x80000903
  outl 0xcfc 0x184275c
  outb 0x376 0x2f
  outb 0x376 0x0
  outw 0x176 0xa1a4
  outl 0xcf8 0x80000920
  outb 0xcfc 0xff
  outb 0xf8 0x9
  EOF

  The stack-trace:
  =3D=3D16513=3D=3DERROR: UndefinedBehaviorSanitizer: FPE on unknown addres=
s 0x556783603fdc (pc 0x556783603fdc bp 0x7fff82143b10 sp 0x7fff82143ab0 T16=
513)
      #0 0x556783603fdc in ide_set_sector /home/alxndr/Development/qemu/hw/=
ide/core.c:626:26
      #1 0x556783603fdc in ide_dma_cb /home/alxndr/Development/qemu/hw/ide/=
core.c:883:9
      #2 0x55678349d74d in dma_complete /home/alxndr/Development/qemu/dma-h=
elpers.c:120:9
      #3 0x55678349d74d in dma_blk_cb /home/alxndr/Development/qemu/dma-hel=
pers.c:138:9
      #4 0x556783962f25 in blk_aio_complete /home/alxndr/Development/qemu/b=
lock/block-backend.c:1402:9
      #5 0x556783962f25 in blk_aio_complete_bh /home/alxndr/Development/qem=
u/block/block-backend.c:1412:5
      #6 0x556783ac030f in aio_bh_call /home/alxndr/Development/qemu/util/a=
sync.c:136:5
      #7 0x556783ac030f in aio_bh_poll /home/alxndr/Development/qemu/util/a=
sync.c:164:13
      #8 0x556783a9a863 in aio_dispatch /home/alxndr/Development/qemu/util/=
aio-posix.c:380:5
      #9 0x556783ac1b4c in aio_ctx_dispatch /home/alxndr/Development/qemu/u=
til/async.c:306:5
      #10 0x7f4f1c0fe9ed in g_main_context_dispatch (/usr/lib/x86_64-linux-=
gnu/libglib-2.0.so.0+0x4e9ed)
      #11 0x556783acdccb in glib_pollfds_poll /home/alxndr/Development/qemu=
/util/main-loop.c:219:9
      #12 0x556783acdccb in os_host_main_loop_wait /home/alxndr/Development=
/qemu/util/main-loop.c:242:5
      #13 0x556783acdccb in main_loop_wait /home/alxndr/Development/qemu/ut=
il/main-loop.c:518:11
      #14 0x5567833613e5 in qemu_main_loop /home/alxndr/Development/qemu/so=
ftmmu/vl.c:1664:9
      #15 0x556783a07a4d in main /home/alxndr/Development/qemu/softmmu/main=
.c:49:5
      #16 0x7f4f1ac84e0a in __libc_start_main /build/glibc-GwnBeO/glibc-2.3=
0/csu/../csu/libc-start.c:308:16
      #17 0x5567830a9089 in _start (/home/alxndr/Development/qemu/build/i38=
6-softmmu/qemu-system-i386+0x7d2089)

  With -trace ide*

  12163@1594585516.671265:ide_reset IDEstate 0x56162a269058
  [R +0.024963] outw 0x176 0x3538
  12163@1594585516.673676:ide_ioport_write IDE PIO wr @ 0x176 (Device/Head)=
; val 0x38; bus 0x56162a268c00 IDEState 0x56162a268c88
  12163@1594585516.673683:ide_ioport_write IDE PIO wr @ 0x177 (Command); va=
l 0x35; bus 0x56162a268c00 IDEState 0x56162a269058
  12163@1594585516.673686:ide_exec_cmd IDE exec cmd: bus 0x56162a268c00; st=
ate 0x56162a269058; cmd 0x35
  OK
  [S +0.025002] OK
  [R +0.025012] outl 0xcf8 0x80000903
  OK
  [S +0.025018] OK
  [R +0.025026] outl 0xcfc 0x184275c
  OK
  [S +0.025210] OK
  [R +0.025219] outb 0x376 0x2f
  12163@1594585516.673916:ide_cmd_write IDE PIO wr @ 0x376 (Device Control)=
; val 0x2f; bus 0x56162a268c00
  OK
  [S +0.025229] OK
  [R +0.025234] outb 0x376 0x0
  12163@1594585516.673928:ide_cmd_write IDE PIO wr @ 0x376 (Device Control)=
; val 0x00; bus 0x56162a268c00
  OK
  [S +0.025240] OK
  [R +0.025246] outw 0x176 0xa1a4
  12163@1594585516.673940:ide_ioport_write IDE PIO wr @ 0x176 (Device/Head)=
; val 0xa4; bus 0x56162a268c00 IDEState 0x56162a269058
  12163@1594585516.673943:ide_ioport_write IDE PIO wr @ 0x177 (Command); va=
l 0xa1; bus 0x56162a268c00 IDEState 0x56162a268c88
  12163@1594585516.673946:ide_exec_cmd IDE exec cmd: bus 0x56162a268c00; st=
ate 0x56162a268c88; cmd 0xa1
  OK
  [S +0.025265] OK
  [R +0.025270] outl 0xcf8 0x80000920
  OK
  [S +0.025274] OK
  [R +0.025279] outb 0xcfc 0xff
  OK
  [S +0.025443] OK
  [R +0.025451] outb 0xf8 0x9
  12163@1594585516.674221:ide_dma_cb IDEState 0x56162a268c88; sector_num=3D=
0 n=3D1 cmd=3DDMA READ
  OK
  [S +0.025724] OK
  UndefinedBehaviorSanitizer:DEADLYSIGNAL
  =3D=3D12163=3D=3DERROR: UndefinedBehaviorSanitizer: FPE on unknown addres=
s 0x5616279cffdc (pc 0x5616279cffdc bp 0x7ffcdaabae90 sp 0x7ffcdaabae30 T12=
163)

  -Alex

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1887309/+subscriptions

