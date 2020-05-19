Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C28DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 17:42:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20FA420708
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 17:42:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20FA420708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb6GI-0000ND-5i
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 13:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jb6Eb-0007fZ-63
 for qemu-devel@nongnu.org; Tue, 19 May 2020 13:40:57 -0400
Received: from indium.canonical.com ([91.189.90.7]:35636)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jb6EZ-0008ER-Oe
 for qemu-devel@nongnu.org; Tue, 19 May 2020 13:40:56 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jb6EX-0006Wz-Gb
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 17:40:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 74F642E806D
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 17:40:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2020 17:32:01 -0000
From: Alexander Bulekov <1879531@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: a1xndr
X-Launchpad-Bug-Reporter: Alexander Bulekov (a1xndr)
X-Launchpad-Bug-Modifier: Alexander Bulekov (a1xndr)
References: <158990645210.17233.17999678627149634965.malonedeb@soybean.canonical.com>
Message-Id: <158990952181.22267.942585334462535418.malone@wampee.canonical.com>
Subject: [Bug 1879531] Re: Stack-overflow in _eth_get_rss_ex_dst_addr
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="0385b538081bc4718df6fb844a3afc89729c94ce";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 26a90d4bacb59d342cf5234268936cb25f5b6a9b
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 13:40:53
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
Reply-To: Bug 1879531 <1879531@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

>From Prasad:


=C2=A0struct ip6_ext_hdr {
 uint8_t ip6r_nxt; /* next header */
 uint8_t ip6r_len; /* length in units of 8 octets */
};
struct ip6_ext_hdr_routing {
 uint8_t nxt;
 uint8_t len;
 uint8_t rtype;
 uint8_t segleft;
 uint8_t rsvd[4];
};
=C2=A0Yes, it looks like because 'struct ip6_ext_hdr' type stack variable's=
 address is assigned to
'struct ip6_ext_hdr_routine' type pointer. And such a pointer is accessing =
'->rtype' variable,
which is not present in 'struct ip6_ext_hdr'.

=C2=A0diff --git a/include/net/eth.h b/include/net/eth.h
index 7f45c678e7..38f2d52bcd 100644
--- a/include/net/eth.h
+++ b/include/net/eth.h
@@ -129,6 +129,7 @@ typedef struct ip6_pseudo_header {
 struct ip6_ext_hdr {
 uint8_t ip6r_nxt; /* next header */
 uint8_t ip6r_len; /* length in units of 8 octets */
+ uint32_t padding;
 };
=C2=A0Above patch should help. It is okay to send this report upstream. Tha=
nk you.
--
Prasad J Pandit / Red Hat Product Security Team

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1879531

Title:
  Stack-overflow in _eth_get_rss_ex_dst_addr

Status in QEMU:
  New

Bug description:
  Hello,
  While fuzzing, I found a 1-byte stack-overflow (read) through the
  e1000e. =


  =3D=3D10318=3D=3DERROR: AddressSanitizer: stack-buffer-overflow on addres=
s 0x7ffdb76c16c2 at pc 0x55594f1a69e1 bp 0x7ffdb76c15a0 sp 0x7ffdb76c1598
  READ of size 1 at 0x7ffdb76c16c2 thread T0
      #0 0x55594f1a69e0 in _eth_get_rss_ex_dst_addr /home/alxndr/Developmen=
t/qemu/net/eth.c:410:17
      #1 0x55594f1a39da in eth_parse_ipv6_hdr /home/alxndr/Development/qemu=
/net/eth.c:532:17
      #2 0x55594ebc34f2 in net_tx_pkt_parse_headers /home/alxndr/Developmen=
t/qemu/hw/net/net_tx_pkt.c:228:14
      #3 0x55594ebc2149 in net_tx_pkt_parse /home/alxndr/Development/qemu/h=
w/net/net_tx_pkt.c:273:9
      #4 0x55594ec1ba76 in e1000e_process_tx_desc /home/alxndr/Development/=
qemu/hw/net/e1000e_core.c:737:29
      #5 0x55594ec1aea4 in e1000e_start_xmit /home/alxndr/Development/qemu/=
hw/net/e1000e_core.c:934:9
      #6 0x55594ec0e70e in e1000e_set_tdt /home/alxndr/Development/qemu/hw/=
net/e1000e_core.c:2451:9
      #7 0x55594ebec435 in e1000e_core_write /home/alxndr/Development/qemu/=
hw/net/e1000e_core.c:3261:9
      #8 0x55594ebdf11b in e1000e_mmio_write /home/alxndr/Development/qemu/=
hw/net/e1000e.c:109:5
      #9 0x55594dfd98b1 in memory_region_write_accessor /home/alxndr/Develo=
pment/qemu/memory.c:483:5
      #10 0x55594dfd9211 in access_with_adjusted_size /home/alxndr/Developm=
ent/qemu/memory.c:544:18
      #11 0x55594dfd7c30 in memory_region_dispatch_write /home/alxndr/Devel=
opment/qemu/memory.c:1476:16
      #12 0x55594dde24b8 in flatview_write_continue /home/alxndr/Developmen=
t/qemu/exec.c:3137:23
      #13 0x55594ddd12dc in flatview_write /home/alxndr/Development/qemu/ex=
ec.c:3177:14
      #14 0x55594ddd0dec in address_space_write /home/alxndr/Development/qe=
mu/exec.c:3268:18
      #15 0x55594dfcdbdc in qtest_process_command /home/alxndr/Development/=
qemu/qtest.c:567:9
      #16 0x55594dfc3700 in qtest_process_inbuf /home/alxndr/Development/qe=
mu/qtest.c:710:9
      #17 0x55594dfc2cc8 in qtest_read /home/alxndr/Development/qemu/qtest.=
c:722:5
      #18 0x55594f74b259 in qemu_chr_be_write_impl /home/alxndr/Development=
/qemu/chardev/char.c:183:9
      #19 0x55594f74b3ee in qemu_chr_be_write /home/alxndr/Development/qemu=
/chardev/char.c:195:9
      #20 0x55594f7556fc in fd_chr_read /home/alxndr/Development/qemu/chard=
ev/char-fd.c:68:9
      #21 0x55594f7ea488 in qio_channel_fd_source_dispatch /home/alxndr/Dev=
elopment/qemu/io/channel-watch.c:84:12
      #22 0x7f43f6c1d897 in g_main_context_dispatch (/usr/lib/x86_64-linux-=
gnu/libglib-2.0.so.0+0x4e897)
      #23 0x55594f9dea5d in glib_pollfds_poll /home/alxndr/Development/qemu=
/util/main-loop.c:219:9
      #24 0x55594f9dd1d7 in os_host_main_loop_wait /home/alxndr/Development=
/qemu/util/main-loop.c:242:5
      #25 0x55594f9dcd6e in main_loop_wait /home/alxndr/Development/qemu/ut=
il/main-loop.c:518:11
      #26 0x55594e44cd01 in qemu_main_loop /home/alxndr/Development/qemu/so=
ftmmu/vl.c:1664:9
      #27 0x55594f803c21 in main /home/alxndr/Development/qemu/softmmu/main=
.c:49:5
      #28 0x7f43f57b4e0a in __libc_start_main /build/glibc-GwnBeO/glibc-2.3=
0/csu/../csu/libc-start.c:308:16
      #29 0x55594dd03889 in _start (/home/alxndr/Development/qemu/build/i38=
6-softmmu/qemu-system-i386+0xdbd889)

  Address 0x7ffdb76c16c2 is located in stack of thread T0 at offset 34 in f=
rame
      #0 0x55594f1a303f in eth_parse_ipv6_hdr /home/alxndr/Development/qemu=
/net/eth.c:486

    This frame has 1 object(s):
      [32, 34) 'ext_hdr' (line 487) <=3D=3D Memory access at offset 34 over=
flows this variable
  HINT: this may be a false positive if your program uses some custom stack=
 unwind mechanism, swapcontext or vfork
        (longjmp and C++ exceptions *are* supported)
  SUMMARY: AddressSanitizer: stack-buffer-overflow /home/alxndr/Development=
/qemu/net/eth.c:410:17 in _eth_get_rss_ex_dst_addr
  Shadow bytes around the buggy address:
    0x100036ed0280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    0x100036ed0290: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    0x100036ed02a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    0x100036ed02b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    0x100036ed02c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  =3D>0x100036ed02d0: 00 00 00 00 f1 f1 f1 f1[02]f3 f3 f3 00 00 00 00
    0x100036ed02e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    0x100036ed02f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    0x100036ed0300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    0x100036ed0310: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    0x100036ed0320: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  Shadow byte legend (one shadow byte represents 8 application bytes):
    Addressable:           00
    Partially addressable: 01 02 03 04 05 06 07
    Heap left redzone:       fa
    Freed heap region:       fd
    Stack left redzone:      f1
    Stack mid redzone:       f2
    Stack right redzone:     f3
    Stack after return:      f5
    Stack use after scope:   f8
    Global redzone:          f9
    Global init order:       f6
    Poisoned by user:        f7
    Container overflow:      fc
    Array cookie:            ac
    Intra object redzone:    bb
    ASan internal:           fe
    Left alloca redzone:     ca
    Right alloca redzone:    cb
    Shadow gap:              cc
  =3D=3D10318=3D=3DABORTING

  I can reproduce it in qemu 5.0 built with address sanitizer using:

  cat << EOF | ./qemu-system-i386 -M pc-q35-5.0 -accel qtest -qtest stdio -=
monitor none -serial none -nographic
  outl 0xcf8 0x80001010
  outl 0xcfc 0xe1020000
  outl 0xcf8 0x80001014
  outl 0xcf8 0x80001004
  outw 0xcfc 0x7
  outl 0xcf8 0x800010a2
  write 0x25 0x2b 0x86dd1900ff5df747002bfc90dd1900ff5df747002bfc9add1900ff5=
df747002bfca4dd1900ff5df747002b
  write 0xe1020030 0x409 0x190002e100000000350908077cdd190002e1000000003509=
12077cdd190002e10000000035091c077cdd190002e100000000350926077cdd190002e1000=
00000350930077cdd190002e10000000035093a077cdd190002e100000000350944077cdd19=
0002e10000000035094e077cdd190002e100000000350958077cdd190002e10000000035096=
2077cdd190002e10000000035096c077cdd190002e100000000350976077cdd190002e10000=
0000350980077cdd190002e10000000035098a077cdd190002e100000000350994077cdd190=
002e10000000035099e077cdd190002e1000000003509a8077cdd190002e1000000003509b2=
077cdd190002e1000000003509bc077cdd190002e1000000003509c6077cdd190002e100000=
0003509d0077cdd190002e1000000003509da077cdd190002e1000000003509e4077cdd1900=
02e1000000003509ee077cdd190002e1000000003509f8077cdd190002e1000000003509020=
77cdd190002e10000000035090c077cdd190002e100000000350916077cdd190002e1000000=
00350920077cdd190002e10000000035092a077cdd190002e100000000350934077cdd19000=
2e10000000035093e077cdd190002e100000000350948077cdd190002e10000000035095207=
7cdd190002e10000000035095c077cdd190002e100000000350966077cdd190002e10000000=
0350970077cdd190002e10000000035097a077cdd190002e100000000350984077cdd190002=
e10000000035098e077cdd190002e100000000350998077cdd190002e1000000003509a2077=
cdd190002e1000000003509ac077cdd190002e1000000003509b6077cdd190002e100000000=
3509c0077cdd190002e1000000003509ca077cdd190002e1000000003509d4077cdd190002e=
1000000003509de077cdd190002e1000000003509e8077cdd190002e1000000003509f2077c=
dd190002e1000000003509fc077cdd190002e100000000350906077cdd190002e1000000003=
50910077cdd190002e10000000035091a077cdd190002e100000000350924077cdd190002e1=
0000000035092e077cdd190002e100000000350938077cdd190002e100000000350942077cd=
d190002e10000000035094c077cdd190002e100000000350956077cdd190002e10000000035=
0960077cdd190002e10000000035096a077cdd190002e100000000350974077cdd190002e10=
000000035097e077cdd190002e100000000350988077cdd190002e100000000350992077cdd=
190002e10000000035099c077cdd190002e1000000003509a6077cdd190002e100000000350=
9b0077cdd190002e1000000003509ba077cdd190002e1000000003509c4077cdd190002e100=
0000003509ce077cdd190002e1000000003509d8077cdd190002e1000000003509e2
  EOF

  Also attaching these commands. They can be executed with
  ./qemu-system-i386 -M pc-q35-5.0 -accel qtest -qtest stdio -monitor none =
-serial none -nographic < attachment

  Let me know if I can provide any further info.
  -Alex

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1879531/+subscriptions

