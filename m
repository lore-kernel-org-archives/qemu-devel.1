Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276D4C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 02:01:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E22EA20737
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 02:01:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E22EA20737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAklB-0007IW-6r
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 22:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kAkk7-0006Xt-Ku
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 22:00:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:41508)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kAkk4-00059G-KX
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 22:00:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kAkk2-0000zb-EI
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 02:00:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 665242E80E7
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 02:00:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2020 01:51:40 -0000
From: Alexander Bulekov <1892962@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: a1xndr
X-Launchpad-Bug-Reporter: Alexander Bulekov (a1xndr)
X-Launchpad-Bug-Modifier: Alexander Bulekov (a1xndr)
Message-Id: <159840670040.15692.684020983379862709.malonedeb@soybean.canonical.com>
Subject: [Bug 1892962] [NEW] Segfault in usb_bus_from_device
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="99c2d833c8d727fd05148486920aca032e908071"; Instance="production"
X-Launchpad-Hash: af46f9a6a2dcb68d07f5f209d764cd85d3004379
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 20:10:40
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_DNSWL_HI=-5,
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
Reply-To: Bug 1892962 <1892962@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Hello,
Reproducer:

cat << EOF | ./qemu-system-i386 -machine q35 \
-device ich9-usb-ehci1,bus=3Dpcie.0,addr=3D1d.7,\
multifunction=3Don,id=3Dich9-ehci-1 \
-device ich9-usb-uhci1,bus=3Dpcie.0,addr=3D1d.0,\
multifunction=3Don,masterbus=3Dich9-ehci-1.0,firstport=3D0 \
-device usb-tablet,bus=3Dich9-ehci-1.0,port=3D1,usb_version=3D1 \
-display none -nodefaults -qtest stdio -accel qtest
outl 0xcf8 0x8000e803
outl 0xcfc 0xff00ff00
outl 0xcf8 0x8000e821
outb 0xcfc 0xff
outl 0xff10 0x8500057e
clock_step
clock_step
outb 0xff00 0x49
write 0x2 0x1 0x40
write 0x400006 0x1 0xfb
write 0x400008 0x1 0x2d
write 0x40000a 0x1 0xe0
write 0x40000c 0x1 0x16
write 0x40000e 0x1 0xfa
write 0xfa001c 0x1 0x04
clock_step
write 0x400006 0x1 0xfb
write 0xfa001d 0x1 0xff
clock_step
write 0x8 0x1 0xe0
write 0xa 0x1 0x16
write 0x1600e6 0x1 0x9c
write 0x1600e8 0x1 0xe1
write 0x1600eb 0x1 0x30
clock_step
clock_step
write 0x10 0x1 0xe0
write 0x12 0x1 0x16
write 0x1600e6 0x1 0x9c
write 0x6 0x1 0x9c
write 0x8 0x1 0xe1
write 0xa 0x1 0x40
write 0xb 0x1 0x30
clock_step
write 0x14 0x1 0xe0
write 0x16 0x1 0x16
write 0x1600e6 0x1 0x9c
write 0x6 0x1 0x9c
clock_step
write 0x18 0x1 0xe0
write 0x1a 0x1 0x16
write 0x1600e6 0x1 0x9c
write 0x6 0x1 0x9c
clock_step
write 0x1c 0x1 0xe0
write 0x1e 0x1 0x16
write 0x1600e6 0x1 0x9c
write 0x6 0x1 0x9c
clock_step
write 0x20 0x1 0xe0
write 0x22 0x1 0x16
write 0x1600e6 0x1 0x9c
write 0x6 0x1 0x9c
clock_step
EOF

The trace:

...
[S +0.087589] OK
[R +0.087596] write 0x1600e6 0x1 0x9c
OK
[S +0.087603] OK
[R +0.087655] write 0x6 0x1 0x9c
OK
[S +0.087667] OK
[R +0.087675] clock_step
784168@1598406646.189133:usb_uhci_frame_start nr 8
784168@1598406646.189141:usb_uhci_td_load qh 0x0, td 0x1600e0, ctrl 0x9c018=
0, token 0x300000e1
784168@1598406646.189147:usb_uhci_packet_add token 0x0, td 0x1600e0
784168@1598406646.189151:usb_packet_state_change bus 0, port 1, ep 0, packe=
t 0x611000043c00, state undef -> setup
784168@1598406646.189161:usb_packet_state_change bus 0, port 1, ep 0, packe=
t 0x611000043c00, state setup -> complete
784168@1598406646.189165:usb_uhci_packet_complete_success token 0x0, td 0x1=
600e0
784168@1598406646.189168:usb_uhci_packet_del token 0x0, td 0x1600e0
784168@1598406646.189174:usb_uhci_td_complete qh 0x0, td 0x1600e0
784168@1598406646.189179:usb_uhci_td_load qh 0x0, td 0x0, ctrl 0x9c0182, to=
ken 0x304000e1
784168@1598406646.189183:usb_uhci_packet_add token 0x0, td 0x0
784168@1598406646.189187:usb_packet_state_change bus 0, port 1, ep 0, packe=
t 0x611000043d40, state undef -> setup
/home/alxndr/Development/qemu/general-fuzz/include/hw/usb.h:526:12: runtime=
 error: member access within null pointer of type 'USBDevice' (aka 'struct =
USBDevice')
SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior /home/alxndr/Develo=
pment/qemu/general-fuzz/include/hw/usb.h:526:12 in =

/home/alxndr/Development/qemu/general-fuzz/include/hw/usb.h:526:12: runtime=
 error: member access within null pointer of type 'DeviceState' (aka 'struc=
t DeviceState')
SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior /home/alxndr/Develo=
pment/qemu/general-fuzz/include/hw/usb.h:526:12 in =

AddressSanitizer:DEADLYSIGNAL
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D784168=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x000000=
000050 (pc 0x5599c43df445 bp 0x7ffec2833e50 sp 0x7ffec2833dc0 T0)
=3D=3D784168=3D=3DThe signal is caused by a READ memory access.
=3D=3D784168=3D=3DHint: address points to the zero page.
    #0 0x5599c43df445 in usb_bus_from_device /home/alxndr/Development/qemu/=
general-fuzz/include/hw/usb.h:526:12
    #1 0x5599c43ea95c in usb_packet_set_state /home/alxndr/Development/qemu=
/general-fuzz/build/../hw/usb/core.c:549:23
    #2 0x5599c43e8abd in usb_handle_packet /home/alxndr/Development/qemu/ge=
neral-fuzz/build/../hw/usb/core.c:438:17
    #3 0x5599c4b02497 in uhci_handle_td /home/alxndr/Development/qemu/gener=
al-fuzz/build/../hw/usb/hcd-uhci.c:892:9
    #4 0x5599c4afbd26 in uhci_process_frame /home/alxndr/Development/qemu/g=
eneral-fuzz/build/../hw/usb/hcd-uhci.c:1075:15
    #5 0x5599c4aed2e3 in uhci_frame_timer /home/alxndr/Development/qemu/gen=
eral-fuzz/build/../hw/usb/hcd-uhci.c:1174:9
    #6 0x5599c7620917 in timerlist_run_timers /home/alxndr/Development/qemu=
/general-fuzz/build/../util/qemu-timer.c:572:9
    #7 0x5599c7620e51 in qemu_clock_run_timers /home/alxndr/Development/qem=
u/general-fuzz/build/../util/qemu-timer.c:586:12
    #8 0x5599c5f35a13 in qtest_clock_warp /home/alxndr/Development/qemu/gen=
eral-fuzz/build/../softmmu/cpus.c:507:9
    #9 0x5599c61225d8 in qtest_process_command /home/alxndr/Development/qem=
u/general-fuzz/build/../softmmu/qtest.c:665:9
    #10 0x5599c611063e in qtest_process_inbuf /home/alxndr/Development/qemu=
/general-fuzz/build/../softmmu/qtest.c:710:9
    #11 0x5599c610f3e3 in qtest_read /home/alxndr/Development/qemu/general-=
fuzz/build/../softmmu/qtest.c:722:5
    #12 0x5599c7215762 in qemu_chr_be_write_impl /home/alxndr/Development/q=
emu/general-fuzz/build/../chardev/char.c:188:9
    #13 0x5599c72158aa in qemu_chr_be_write /home/alxndr/Development/qemu/g=
eneral-fuzz/build/../chardev/char.c:200:9
    #14 0x5599c723b514 in fd_chr_read /home/alxndr/Development/qemu/general=
-fuzz/build/../chardev/char-fd.c:68:9
    #15 0x5599c7127736 in qio_channel_fd_source_dispatch /home/alxndr/Devel=
opment/qemu/general-fuzz/build/../io/channel-watch.c:84:12
    #16 0x7f62623914cd in g_main_context_dispatch (/usr/lib/x86_64-linux-gn=
u/libglib-2.0.so.0+0x504cd)
    #17 0x5599c76b2c67 in glib_pollfds_poll /home/alxndr/Development/qemu/g=
eneral-fuzz/build/../util/main-loop.c:217:9
    #18 0x5599c76b0567 in os_host_main_loop_wait /home/alxndr/Development/q=
emu/general-fuzz/build/../util/main-loop.c:240:5
    #19 0x5599c76aff47 in main_loop_wait /home/alxndr/Development/qemu/gene=
ral-fuzz/build/../util/main-loop.c:516:11
    #20 0x5599c5e8e08d in qemu_main_loop /home/alxndr/Development/qemu/gene=
ral-fuzz/build/../softmmu/vl.c:1676:9
    #21 0x5599c382051c in main /home/alxndr/Development/qemu/general-fuzz/b=
uild/../softmmu/main.c:50:5
    #22 0x7f6261b9acc9 in __libc_start_main csu/../csu/libc-start.c:308:16
    #23 0x5599c3775cf9 in _start (/home/alxndr/Development/qemu/general-fuz=
z/build/qemu-system-i386+0x2cb0cf9)

AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: SEGV /home/alxndr/Development/qemu/general-fuzz/=
include/hw/usb.h:526:12 in usb_bus_from_device
=3D=3D784168=3D=3DABORTING

-Alex

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1892962

Title:
  Segfault in usb_bus_from_device

Status in QEMU:
  New

Bug description:
  Hello,
  Reproducer:

  cat << EOF | ./qemu-system-i386 -machine q35 \
  -device ich9-usb-ehci1,bus=3Dpcie.0,addr=3D1d.7,\
  multifunction=3Don,id=3Dich9-ehci-1 \
  -device ich9-usb-uhci1,bus=3Dpcie.0,addr=3D1d.0,\
  multifunction=3Don,masterbus=3Dich9-ehci-1.0,firstport=3D0 \
  -device usb-tablet,bus=3Dich9-ehci-1.0,port=3D1,usb_version=3D1 \
  -display none -nodefaults -qtest stdio -accel qtest
  outl 0xcf8 0x8000e803
  outl 0xcfc 0xff00ff00
  outl 0xcf8 0x8000e821
  outb 0xcfc 0xff
  outl 0xff10 0x8500057e
  clock_step
  clock_step
  outb 0xff00 0x49
  write 0x2 0x1 0x40
  write 0x400006 0x1 0xfb
  write 0x400008 0x1 0x2d
  write 0x40000a 0x1 0xe0
  write 0x40000c 0x1 0x16
  write 0x40000e 0x1 0xfa
  write 0xfa001c 0x1 0x04
  clock_step
  write 0x400006 0x1 0xfb
  write 0xfa001d 0x1 0xff
  clock_step
  write 0x8 0x1 0xe0
  write 0xa 0x1 0x16
  write 0x1600e6 0x1 0x9c
  write 0x1600e8 0x1 0xe1
  write 0x1600eb 0x1 0x30
  clock_step
  clock_step
  write 0x10 0x1 0xe0
  write 0x12 0x1 0x16
  write 0x1600e6 0x1 0x9c
  write 0x6 0x1 0x9c
  write 0x8 0x1 0xe1
  write 0xa 0x1 0x40
  write 0xb 0x1 0x30
  clock_step
  write 0x14 0x1 0xe0
  write 0x16 0x1 0x16
  write 0x1600e6 0x1 0x9c
  write 0x6 0x1 0x9c
  clock_step
  write 0x18 0x1 0xe0
  write 0x1a 0x1 0x16
  write 0x1600e6 0x1 0x9c
  write 0x6 0x1 0x9c
  clock_step
  write 0x1c 0x1 0xe0
  write 0x1e 0x1 0x16
  write 0x1600e6 0x1 0x9c
  write 0x6 0x1 0x9c
  clock_step
  write 0x20 0x1 0xe0
  write 0x22 0x1 0x16
  write 0x1600e6 0x1 0x9c
  write 0x6 0x1 0x9c
  clock_step
  EOF

  The trace:

  ...
  [S +0.087589] OK
  [R +0.087596] write 0x1600e6 0x1 0x9c
  OK
  [S +0.087603] OK
  [R +0.087655] write 0x6 0x1 0x9c
  OK
  [S +0.087667] OK
  [R +0.087675] clock_step
  784168@1598406646.189133:usb_uhci_frame_start nr 8
  784168@1598406646.189141:usb_uhci_td_load qh 0x0, td 0x1600e0, ctrl 0x9c0=
180, token 0x300000e1
  784168@1598406646.189147:usb_uhci_packet_add token 0x0, td 0x1600e0
  784168@1598406646.189151:usb_packet_state_change bus 0, port 1, ep 0, pac=
ket 0x611000043c00, state undef -> setup
  784168@1598406646.189161:usb_packet_state_change bus 0, port 1, ep 0, pac=
ket 0x611000043c00, state setup -> complete
  784168@1598406646.189165:usb_uhci_packet_complete_success token 0x0, td 0=
x1600e0
  784168@1598406646.189168:usb_uhci_packet_del token 0x0, td 0x1600e0
  784168@1598406646.189174:usb_uhci_td_complete qh 0x0, td 0x1600e0
  784168@1598406646.189179:usb_uhci_td_load qh 0x0, td 0x0, ctrl 0x9c0182, =
token 0x304000e1
  784168@1598406646.189183:usb_uhci_packet_add token 0x0, td 0x0
  784168@1598406646.189187:usb_packet_state_change bus 0, port 1, ep 0, pac=
ket 0x611000043d40, state undef -> setup
  /home/alxndr/Development/qemu/general-fuzz/include/hw/usb.h:526:12: runti=
me error: member access within null pointer of type 'USBDevice' (aka 'struc=
t USBDevice')
  SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior /home/alxndr/Deve=
lopment/qemu/general-fuzz/include/hw/usb.h:526:12 in =

  /home/alxndr/Development/qemu/general-fuzz/include/hw/usb.h:526:12: runti=
me error: member access within null pointer of type 'DeviceState' (aka 'str=
uct DeviceState')
  SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior /home/alxndr/Deve=
lopment/qemu/general-fuzz/include/hw/usb.h:526:12 in =

  AddressSanitizer:DEADLYSIGNAL
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  =3D=3D784168=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x0000=
00000050 (pc 0x5599c43df445 bp 0x7ffec2833e50 sp 0x7ffec2833dc0 T0)
  =3D=3D784168=3D=3DThe signal is caused by a READ memory access.
  =3D=3D784168=3D=3DHint: address points to the zero page.
      #0 0x5599c43df445 in usb_bus_from_device /home/alxndr/Development/qem=
u/general-fuzz/include/hw/usb.h:526:12
      #1 0x5599c43ea95c in usb_packet_set_state /home/alxndr/Development/qe=
mu/general-fuzz/build/../hw/usb/core.c:549:23
      #2 0x5599c43e8abd in usb_handle_packet /home/alxndr/Development/qemu/=
general-fuzz/build/../hw/usb/core.c:438:17
      #3 0x5599c4b02497 in uhci_handle_td /home/alxndr/Development/qemu/gen=
eral-fuzz/build/../hw/usb/hcd-uhci.c:892:9
      #4 0x5599c4afbd26 in uhci_process_frame /home/alxndr/Development/qemu=
/general-fuzz/build/../hw/usb/hcd-uhci.c:1075:15
      #5 0x5599c4aed2e3 in uhci_frame_timer /home/alxndr/Development/qemu/g=
eneral-fuzz/build/../hw/usb/hcd-uhci.c:1174:9
      #6 0x5599c7620917 in timerlist_run_timers /home/alxndr/Development/qe=
mu/general-fuzz/build/../util/qemu-timer.c:572:9
      #7 0x5599c7620e51 in qemu_clock_run_timers /home/alxndr/Development/q=
emu/general-fuzz/build/../util/qemu-timer.c:586:12
      #8 0x5599c5f35a13 in qtest_clock_warp /home/alxndr/Development/qemu/g=
eneral-fuzz/build/../softmmu/cpus.c:507:9
      #9 0x5599c61225d8 in qtest_process_command /home/alxndr/Development/q=
emu/general-fuzz/build/../softmmu/qtest.c:665:9
      #10 0x5599c611063e in qtest_process_inbuf /home/alxndr/Development/qe=
mu/general-fuzz/build/../softmmu/qtest.c:710:9
      #11 0x5599c610f3e3 in qtest_read /home/alxndr/Development/qemu/genera=
l-fuzz/build/../softmmu/qtest.c:722:5
      #12 0x5599c7215762 in qemu_chr_be_write_impl /home/alxndr/Development=
/qemu/general-fuzz/build/../chardev/char.c:188:9
      #13 0x5599c72158aa in qemu_chr_be_write /home/alxndr/Development/qemu=
/general-fuzz/build/../chardev/char.c:200:9
      #14 0x5599c723b514 in fd_chr_read /home/alxndr/Development/qemu/gener=
al-fuzz/build/../chardev/char-fd.c:68:9
      #15 0x5599c7127736 in qio_channel_fd_source_dispatch /home/alxndr/Dev=
elopment/qemu/general-fuzz/build/../io/channel-watch.c:84:12
      #16 0x7f62623914cd in g_main_context_dispatch (/usr/lib/x86_64-linux-=
gnu/libglib-2.0.so.0+0x504cd)
      #17 0x5599c76b2c67 in glib_pollfds_poll /home/alxndr/Development/qemu=
/general-fuzz/build/../util/main-loop.c:217:9
      #18 0x5599c76b0567 in os_host_main_loop_wait /home/alxndr/Development=
/qemu/general-fuzz/build/../util/main-loop.c:240:5
      #19 0x5599c76aff47 in main_loop_wait /home/alxndr/Development/qemu/ge=
neral-fuzz/build/../util/main-loop.c:516:11
      #20 0x5599c5e8e08d in qemu_main_loop /home/alxndr/Development/qemu/ge=
neral-fuzz/build/../softmmu/vl.c:1676:9
      #21 0x5599c382051c in main /home/alxndr/Development/qemu/general-fuzz=
/build/../softmmu/main.c:50:5
      #22 0x7f6261b9acc9 in __libc_start_main csu/../csu/libc-start.c:308:16
      #23 0x5599c3775cf9 in _start (/home/alxndr/Development/qemu/general-f=
uzz/build/qemu-system-i386+0x2cb0cf9)

  AddressSanitizer can not provide additional info.
  SUMMARY: AddressSanitizer: SEGV /home/alxndr/Development/qemu/general-fuz=
z/include/hw/usb.h:526:12 in usb_bus_from_device
  =3D=3D784168=3D=3DABORTING

  -Alex

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1892962/+subscriptions

