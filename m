Return-Path: <SRS0=y3lU=7F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052B0C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 18:11:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD8632072C
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 18:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD8632072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcYcK-0004Bf-0B
	for qemu-devel@archiver.kernel.org; Sat, 23 May 2020 14:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jcYbi-0003gB-Qt
 for qemu-devel@nongnu.org; Sat, 23 May 2020 14:10:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:57972)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jcYbg-0006Vw-GA
 for qemu-devel@nongnu.org; Sat, 23 May 2020 14:10:50 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jcYbe-00053o-GR
 for <qemu-devel@nongnu.org>; Sat, 23 May 2020 18:10:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 77E9C2E802D
 for <qemu-devel@nongnu.org>; Sat, 23 May 2020 18:10:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2020 18:03:12 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1880326@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: philmd
X-Launchpad-Bug-Reporter: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
Message-Id: <159025699248.19687.6356837063531567895.malonedeb@soybean.canonical.com>
Subject: [Bug 1880326] [NEW] memory writes make artist_rop8() crash
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1f7bc749b40714a4cc10f5e4d787118a78037035";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: b5faab1973bdf337de0fdea4ab980267eb664abe
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/23 14:10:46
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
Reply-To: Bug 1880326 <1880326@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

As of commit d19f1ab0, LLVM libFuzzer found:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D6814=3D=3DERROR: AddressSanitizer: heap-buffer-overflow on address 0x=
7fd89f97bd5a at pc 0x55dc44594db5 bp 0x7ffd6f461b40 sp 0x7ffd6f461b38
READ of size 1 at 0x7fd89f97bd5a thread T0
    #0 0x55dc44594db4 in artist_rop8
    #1 0x55dc44595fd9 in draw_line
    #2 0x55dc445937e4 in draw_line_size
    #3 0x55dc4458ee9d in artist_reg_write
    #4 0x55dc43f77ba7 in memory_region_write_accessor
    #5 0x55dc43f775b8 in access_with_adjusted_size
    #6 0x55dc43f762b3 in memory_region_dispatch_write
    #7 0x55dc43dbb322 in flatview_write_continue
    #8 0x55dc43dab2e2 in flatview_write
    #9 0x55dc43daae14 in address_space_write

0x7fd89f97bd5a is located 1122 bytes to the right of 16777464-byte region [=
0x7fd89e97b800,0x7fd89f97b8f8)
allocated by thread T0 here:
    #0 0x55dc43d87abf in operator new(unsigned long)
    #1 0x55dc43c4274d in fuzzer::FuzzerDriver(int*, char***, int (*)(unsign=
ed char const*, unsigned long))
    #2 0x55dc43c3a526 in main (qemu-fuzz-hppa+0x982526)
    #3 0x7fd8d05edf42 in __libc_start_main (/lib64/libc.so.6+0x23f42)

SUMMARY: AddressSanitizer: heap-buffer-overflow (qemu-fuzz-hppa+0x12dcdb4) =
in artist_rop8
Shadow bytes around the buggy address:
  0x0ffb93f27750: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0ffb93f27760: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0ffb93f27770: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0ffb93f27780: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0ffb93f27790: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
=3D>0x0ffb93f277a0: fa fa fa fa fa fa fa fa fa fa fa[fa]fa fa fa fa
  0x0ffb93f277b0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0ffb93f277c0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0ffb93f277d0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0ffb93f277e0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0ffb93f277f0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07 =

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
=3D=3D6814=3D=3DABORTING

How to reproduce:

qemu-system-hppa -S -qtest stdio -accel qtest -display none < EOF
writeb 0xf8100081 0x40
writeb 0xf81000c5 0x40
writeb 0xf8100e44 0x2b
writeb 0xf8100e44 0x56
writeb 0xf8100e44 0x10
writeb 0xf8100600 0x0
writeb 0xf8100821 0x21
writeb 0xf8100b01 0x14
writew 0xf8100044 0x1245
writeb 0xf8100a0e 0x50
writeb 0xf8100a02 0x49
writeb 0xf8100821 0x0
writew 0xf8100014 0x0
writeb 0xf8100e46 0x46
writeb 0xf8100052 0xe
writeb 0xf8100621 0x14
writeb 0xf8100b01 0x14
writew 0xf8100044 0x1241
writeb 0xf8100b02 0x25
writeb 0xf8100b01 0x4
writeb 0xf8100e46 0xb0
writeb 0xf8100b02 0x0
writel 0xf81000c4 0x49494949
writeb 0xf8100b02 0x10
writew 0xf8100010 0x11
writew 0xf8100044 0x1212
writew 0xf8100044 0x1245
writew 0xf8100050 0xe2a
writeb 0xf8100002 0x11
writeb 0xf8100081 0xec
writeb 0xf8100081 0xec
writeb 0xf810030e 0xe
writeb 0xf810000e 0x44
writeb 0xf8100000 0xe
writeb 0xf8100044 0xe
writeb 0xf8100000 0xe
writeb 0xf810030e 0x13
writeb 0xf8100b44 0x2a
writeb 0xf8100bf8 0x4
writeb 0xf8100007 0x45
writeb 0xf81000ff 0xff
writew 0xf8100044 0xf042
writew 0xf8100000 0x45
writew 0xf8100044 0xf042
writeb 0xf8100000 0xc5
writeb 0xf81000ff 0xff
writel 0xf8100044 0x101364ff
writel 0xf81000c4 0xfba0a0a0
writeb 0xf8100000 0x2a
writeb 0xf81000c5 0x40
writeb 0xf81000ff 0xdf
writew 0xf8100000 0x4144
writeb 0xf81000df 0x0
writew 0xf8100044 0x4400
writel 0xf8100044 0x101364ff
writel 0xf81000c4 0xfb490045
writeb 0xf8100000 0x2a
writeb 0xf81000c5 0x40
writel 0xf8100044 0x101364ff
writel 0xf8100bc4 0x49004545
writeb 0xf8100000 0x2a
writeb 0xf81000c5 0x40
writeb 0xf810000e 0x21
writeb 0xf8100000 0x2a
writeb 0xf81000c3 0x40
writeb 0xf81000ff 0xdf
writew 0xf8100044 0x1210
writew 0xf8100044 0x1210
writew 0xf8100010 0x4412
writew 0xf8100010 0x4412
writew 0xf8100044 0x1210
writew 0xf8100044 0x1210
writew 0xf8100044 0x1210
writew 0xf8100000 0x4144
writew 0xf8100044 0x4400
writew 0xf8100000 0x4144
writew 0xf81000bc 0xc100
writew 0xf8100000 0x4144
writew 0xf81000bc 0xc100
writew 0xf8100044 0x1210
writel 0xf8100044 0xfb53000a
writew 0xf8100044 0x1210
writel 0xf8100044 0xfb53000a
writew 0xf8100044 0x1210
writel 0xf8100044 0xfba7000a
writew 0xf8100044 0x1210
writew 0xf8100044 0x1210
writew 0xf8100000 0x4144
writew 0xf8100000 0x4144
writew 0xf8100000 0x4144
writew 0xf8100044 0x4400
writew 0xf8100044 0x4411
writew 0xf8100044 0x1210
writew 0xf8100044 0x1210
writew 0xf8100044 0x1210
writew 0xf8100044 0x1212
writew 0xf8100044 0x4445
writeb 0xf81000ff 0xff
writeb 0xf8100121 0x14
writeb 0xf8100121 0x14
writeb 0xf8100421 0x0
writeb 0xf8100421 0x28
writeb 0xf8100000 0x2a
writeb 0xf81000c5 0x40
writeb 0xf8100040 0x0
writeb 0xf8100007 0x45
writeb 0xf8100007 0x45
writeb 0xf8100bf8 0x4
writeb 0xf8100bf8 0x4
writeb 0xf8100bf8 0x4
writeb 0xf8100bf8 0x4
writeb 0xf8100bf8 0x4
writew 0xf8100060 0x11
writew 0xf8100060 0x11
writew 0xf8100060 0x17
writeb 0xf8100446 0x46
writeb 0xf8100604 0x50
writeb 0xf8100821 0x21
writeb 0xf8100108 0x21
writeb 0xf810010c 0x21
writeb 0xf8100081 0xec
writeb 0xf8100041 0xec
writel 0xf8100044 0x101364ff
writel 0xf81000c4 0xfba0a0a0
writel 0xf8100044 0x101364ff
writel 0xf81000c4 0xfba0a0a0
writel 0xf8100044 0x101364ff
writel 0xf81000c4 0xfba0a0a0
writeb 0xf8100052 0x24
writew 0xf8100000 0x4144
writeb 0xf81000df 0x0
writew 0xf8100044 0x4400
writew 0xf8100000 0x4144
writeb 0xf81000df 0x41
writeb 0xf8100504 0x50
writew 0xf8100010 0x4412
writew 0xf8100010 0x4412
writew 0xf8100094 0x4145
writel 0xf8100044 0x10424410
writel 0xf81000a0 0xa0a0492a
writel 0xf8100044 0x10040000
writeb 0xf8100007 0x44
writeb 0xf81000ff 0xff
writeb 0xf8100007 0x44
writeb 0xf81000ff 0x4
writel 0xf8100044 0x10134900
writeb 0xf8100000 0x2a
writeb 0xf81000c5 0x40
writeb 0xf8100000 0x2a
writeb 0xf81000c5 0x40
writew 0xf8100040 0x1212
writew 0xf8100044 0x1245
writew 0xf8100040 0x1212
writew 0xf8100040 0x5002
writew 0xf8100040 0x5002
writew 0xf8100040 0x502a
writeb 0xf8100081 0x40
writeb 0xf810005d 0x40
writeb 0xf8100030 0x5d
writeb 0xf8100e44 0x44
writeb 0xf8100044 0x3
writeb 0xf8100044 0x3
writeb 0xf8100044 0x13
writew 0xf8100044 0x1210
writew 0xf8100044 0x1210
writew 0xf8100044 0x1210
writew 0xf8100044 0x6d10
writeb 0xf8100044 0x6d
writeb 0xf8100000 0x2a
writeb 0xf8100044 0x40
writeb 0xf8100045 0xec
writew 0xf8100044 0x1210
writew 0xf8100044 0x1245
writel 0xf8100044 0x101364ff
writel 0xf81000c4 0xfba0a0a0
writel 0xf8100044 0x101364ff
writel 0xf8100044 0x101364ff
writel 0xf8100044 0x101364ff
writel 0xf8100008 0xfba0a0a0
writel 0xf8100044 0x4208fba0
writew 0xf8100010 0x4412
writew 0xf8100010 0x4412
writew 0xf8100010 0x4412
writew 0xf8100010 0x4412
writew 0xf8100010 0x4412
writew 0xf8100000 0x4144
writeb 0xf810030e 0xe
writeb 0xf810030e 0xe
writeb 0xf810032b 0xe
writeb 0xf810032b 0xe
writew 0xf8100010 0x4412
writew 0xf81000ca 0x4441
writew 0xf8100010 0x4412
writew 0xf8100010 0x4412
writew 0xf8100010 0x4412
writew 0xf8100010 0x4412
writeb 0xf8100080 0xe
writeb 0xf8100080 0xd8
writeb 0xf8100080 0x26
writeb 0xf8100040 0x80
writeb 0xf8100040 0x26
writeb 0xf81000c3 0x40
writeb 0xf81000ff 0xdf
writeb 0xf81000c3 0x40
writeb 0xf81000ff 0xdf
writew 0xf8100014 0x4000
writeb 0xf8100000 0xe
writeb 0xf8100000 0x9e
writeb 0xf8100000 0x3c
writeb 0xf8100000 0x3c
writeb 0xf8100000 0x3c
writew 0xf8100000 0x4144
writeb 0xf81000df 0x41
writeb 0xf8100007 0x45
writeb 0xf81000ff 0xff
writeb 0xf8100007 0xb4
writeb 0xf81000ff 0xff
writeb 0xf8100007 0xb4
writeb 0xf8100007 0xb4
writel 0xf8100044 0x10139c05
writel 0xf81000c4 0xfba0a0a0
writeb 0xf8100604 0x50
writeb 0xf8100021 0xe
writeb 0xf8100021 0xe
writeb 0xf8100021 0xe
writeb 0xf8100021 0x90
writew 0xf8100010 0x11
writew 0xf8100010 0x11
writew 0xf8100010 0x11
writeb 0xf8100021 0xe
writeb 0xf8100021 0xe
writeb 0xf8100021 0xe
writeb 0xf8100021 0xe
writeb 0xf8100021 0xe
writew 0xf8100010 0x4412
writew 0xf8100010 0x4412
writew 0xf8100010 0x4412
writew 0xf8100010 0x4412
writew 0xf8100010 0x4412
writeb 0xf8100021 0xe
writeb 0xf8100021 0xe
writeb 0xf8100021 0x21
writeb 0xf8100021 0x21
writeb 0xf8100000 0x0
writeb 0xf8100e04 0x46
EOF

Program terminated with signal SIGSEGV, Segmentation fault.
#0  0x000056367b2085c0 in artist_rop8 (s=3D0x56367d38b510, dst=3D0x7f9f972f=
ffff <error: Cannot access memory at address 0x7f9f972fffff>, val=3D0 '\000=
') at hw/display/artist.c:284
284             *dst &=3D ~plane_mask;
(gdb) bt
#0  0x000056367b2085c0 in artist_rop8 (s=3D0x56367d38b510, dst=3D0x7f9f972f=
ffff <error: Cannot access memory at address 0x7f9f972fffff>, val=3D0 '\000=
') at hw/display/artist.c:284
#1  0x000056367b209325 in draw_line (s=3D0x56367d38b510, x1=3D-20480, y1=3D=
-1, x2=3D0, y2=3D17920, update_start=3Dtrue, skip_pix=3D-1, max_pix=3D-1) a=
t hw/display/artist.c:646
#2  0x000056367b2095a0 in draw_line_size (s=3D0x56367d38b510, update_start=
=3Dtrue) at hw/display/artist.c:696
#3  0x000056367b20a214 in artist_reg_write (opaque=3D0x56367d38b510, addr=
=3D1052164, val=3D70, size=3D1) at hw/display/artist.c:932
#4  0x000056367b06ea7c in memory_region_write_accessor (mr=3D0x56367d38ba10=
, addr=3D1052164, value=3D0x7fff112132d8, size=3D1, shift=3D0, mask=3D255, =
attrs=3D...) at memory.c:483
#5  0x000056367b06ec33 in access_with_adjusted_size (addr=3D1052164, value=
=3D0x7fff112132d8, size=3D1, access_size_min=3D1, access_size_max=3D4, acce=
ss_fn=3D
    0x56367b06e999 <memory_region_write_accessor>, mr=3D0x56367d38ba10, att=
rs=3D...) at memory.c:540
#6  0x000056367b071bb4 in memory_region_dispatch_write (mr=3D0x56367d38ba10=
, addr=3D1052164, data=3D70, op=3DMO_8, attrs=3D...) at memory.c:1477
#7  0x000056367b00fe33 in flatview_write_continue (fv=3D0x56367d6f9fa0, add=
r=3D4161801732, attrs=3D..., ptr=3D0x7fff112134e0, len=3D1, addr1=3D1052164=
, l=3D1, mr=3D0x56367d38ba10) at exec.c:3147
#8  0x000056367b00ff81 in flatview_write (fv=3D0x56367d6f9fa0, addr=3D41618=
01732, attrs=3D..., buf=3D0x7fff112134e0, len=3D1) at exec.c:3190
#9  0x000056367b0102eb in address_space_write (as=3D0x56367cff99c0, addr=3D=
4161801732, attrs=3D..., buf=3D0x7fff112134e0, len=3D1) at exec.c:3289

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1880326

Title:
  memory writes make artist_rop8() crash

Status in QEMU:
  New

Bug description:
  As of commit d19f1ab0, LLVM libFuzzer found:

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  =3D=3D6814=3D=3DERROR: AddressSanitizer: heap-buffer-overflow on address =
0x7fd89f97bd5a at pc 0x55dc44594db5 bp 0x7ffd6f461b40 sp 0x7ffd6f461b38
  READ of size 1 at 0x7fd89f97bd5a thread T0
      #0 0x55dc44594db4 in artist_rop8
      #1 0x55dc44595fd9 in draw_line
      #2 0x55dc445937e4 in draw_line_size
      #3 0x55dc4458ee9d in artist_reg_write
      #4 0x55dc43f77ba7 in memory_region_write_accessor
      #5 0x55dc43f775b8 in access_with_adjusted_size
      #6 0x55dc43f762b3 in memory_region_dispatch_write
      #7 0x55dc43dbb322 in flatview_write_continue
      #8 0x55dc43dab2e2 in flatview_write
      #9 0x55dc43daae14 in address_space_write

  0x7fd89f97bd5a is located 1122 bytes to the right of 16777464-byte region=
 [0x7fd89e97b800,0x7fd89f97b8f8)
  allocated by thread T0 here:
      #0 0x55dc43d87abf in operator new(unsigned long)
      #1 0x55dc43c4274d in fuzzer::FuzzerDriver(int*, char***, int (*)(unsi=
gned char const*, unsigned long))
      #2 0x55dc43c3a526 in main (qemu-fuzz-hppa+0x982526)
      #3 0x7fd8d05edf42 in __libc_start_main (/lib64/libc.so.6+0x23f42)

  SUMMARY: AddressSanitizer: heap-buffer-overflow (qemu-fuzz-hppa+0x12dcdb4=
) in artist_rop8
  Shadow bytes around the buggy address:
    0x0ffb93f27750: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
    0x0ffb93f27760: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
    0x0ffb93f27770: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
    0x0ffb93f27780: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
    0x0ffb93f27790: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  =3D>0x0ffb93f277a0: fa fa fa fa fa fa fa fa fa fa fa[fa]fa fa fa fa
    0x0ffb93f277b0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
    0x0ffb93f277c0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
    0x0ffb93f277d0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
    0x0ffb93f277e0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
    0x0ffb93f277f0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  Shadow byte legend (one shadow byte represents 8 application bytes):
    Addressable:           00
    Partially addressable: 01 02 03 04 05 06 07 =

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
  =3D=3D6814=3D=3DABORTING

  How to reproduce:

  qemu-system-hppa -S -qtest stdio -accel qtest -display none < EOF
  writeb 0xf8100081 0x40
  writeb 0xf81000c5 0x40
  writeb 0xf8100e44 0x2b
  writeb 0xf8100e44 0x56
  writeb 0xf8100e44 0x10
  writeb 0xf8100600 0x0
  writeb 0xf8100821 0x21
  writeb 0xf8100b01 0x14
  writew 0xf8100044 0x1245
  writeb 0xf8100a0e 0x50
  writeb 0xf8100a02 0x49
  writeb 0xf8100821 0x0
  writew 0xf8100014 0x0
  writeb 0xf8100e46 0x46
  writeb 0xf8100052 0xe
  writeb 0xf8100621 0x14
  writeb 0xf8100b01 0x14
  writew 0xf8100044 0x1241
  writeb 0xf8100b02 0x25
  writeb 0xf8100b01 0x4
  writeb 0xf8100e46 0xb0
  writeb 0xf8100b02 0x0
  writel 0xf81000c4 0x49494949
  writeb 0xf8100b02 0x10
  writew 0xf8100010 0x11
  writew 0xf8100044 0x1212
  writew 0xf8100044 0x1245
  writew 0xf8100050 0xe2a
  writeb 0xf8100002 0x11
  writeb 0xf8100081 0xec
  writeb 0xf8100081 0xec
  writeb 0xf810030e 0xe
  writeb 0xf810000e 0x44
  writeb 0xf8100000 0xe
  writeb 0xf8100044 0xe
  writeb 0xf8100000 0xe
  writeb 0xf810030e 0x13
  writeb 0xf8100b44 0x2a
  writeb 0xf8100bf8 0x4
  writeb 0xf8100007 0x45
  writeb 0xf81000ff 0xff
  writew 0xf8100044 0xf042
  writew 0xf8100000 0x45
  writew 0xf8100044 0xf042
  writeb 0xf8100000 0xc5
  writeb 0xf81000ff 0xff
  writel 0xf8100044 0x101364ff
  writel 0xf81000c4 0xfba0a0a0
  writeb 0xf8100000 0x2a
  writeb 0xf81000c5 0x40
  writeb 0xf81000ff 0xdf
  writew 0xf8100000 0x4144
  writeb 0xf81000df 0x0
  writew 0xf8100044 0x4400
  writel 0xf8100044 0x101364ff
  writel 0xf81000c4 0xfb490045
  writeb 0xf8100000 0x2a
  writeb 0xf81000c5 0x40
  writel 0xf8100044 0x101364ff
  writel 0xf8100bc4 0x49004545
  writeb 0xf8100000 0x2a
  writeb 0xf81000c5 0x40
  writeb 0xf810000e 0x21
  writeb 0xf8100000 0x2a
  writeb 0xf81000c3 0x40
  writeb 0xf81000ff 0xdf
  writew 0xf8100044 0x1210
  writew 0xf8100044 0x1210
  writew 0xf8100010 0x4412
  writew 0xf8100010 0x4412
  writew 0xf8100044 0x1210
  writew 0xf8100044 0x1210
  writew 0xf8100044 0x1210
  writew 0xf8100000 0x4144
  writew 0xf8100044 0x4400
  writew 0xf8100000 0x4144
  writew 0xf81000bc 0xc100
  writew 0xf8100000 0x4144
  writew 0xf81000bc 0xc100
  writew 0xf8100044 0x1210
  writel 0xf8100044 0xfb53000a
  writew 0xf8100044 0x1210
  writel 0xf8100044 0xfb53000a
  writew 0xf8100044 0x1210
  writel 0xf8100044 0xfba7000a
  writew 0xf8100044 0x1210
  writew 0xf8100044 0x1210
  writew 0xf8100000 0x4144
  writew 0xf8100000 0x4144
  writew 0xf8100000 0x4144
  writew 0xf8100044 0x4400
  writew 0xf8100044 0x4411
  writew 0xf8100044 0x1210
  writew 0xf8100044 0x1210
  writew 0xf8100044 0x1210
  writew 0xf8100044 0x1212
  writew 0xf8100044 0x4445
  writeb 0xf81000ff 0xff
  writeb 0xf8100121 0x14
  writeb 0xf8100121 0x14
  writeb 0xf8100421 0x0
  writeb 0xf8100421 0x28
  writeb 0xf8100000 0x2a
  writeb 0xf81000c5 0x40
  writeb 0xf8100040 0x0
  writeb 0xf8100007 0x45
  writeb 0xf8100007 0x45
  writeb 0xf8100bf8 0x4
  writeb 0xf8100bf8 0x4
  writeb 0xf8100bf8 0x4
  writeb 0xf8100bf8 0x4
  writeb 0xf8100bf8 0x4
  writew 0xf8100060 0x11
  writew 0xf8100060 0x11
  writew 0xf8100060 0x17
  writeb 0xf8100446 0x46
  writeb 0xf8100604 0x50
  writeb 0xf8100821 0x21
  writeb 0xf8100108 0x21
  writeb 0xf810010c 0x21
  writeb 0xf8100081 0xec
  writeb 0xf8100041 0xec
  writel 0xf8100044 0x101364ff
  writel 0xf81000c4 0xfba0a0a0
  writel 0xf8100044 0x101364ff
  writel 0xf81000c4 0xfba0a0a0
  writel 0xf8100044 0x101364ff
  writel 0xf81000c4 0xfba0a0a0
  writeb 0xf8100052 0x24
  writew 0xf8100000 0x4144
  writeb 0xf81000df 0x0
  writew 0xf8100044 0x4400
  writew 0xf8100000 0x4144
  writeb 0xf81000df 0x41
  writeb 0xf8100504 0x50
  writew 0xf8100010 0x4412
  writew 0xf8100010 0x4412
  writew 0xf8100094 0x4145
  writel 0xf8100044 0x10424410
  writel 0xf81000a0 0xa0a0492a
  writel 0xf8100044 0x10040000
  writeb 0xf8100007 0x44
  writeb 0xf81000ff 0xff
  writeb 0xf8100007 0x44
  writeb 0xf81000ff 0x4
  writel 0xf8100044 0x10134900
  writeb 0xf8100000 0x2a
  writeb 0xf81000c5 0x40
  writeb 0xf8100000 0x2a
  writeb 0xf81000c5 0x40
  writew 0xf8100040 0x1212
  writew 0xf8100044 0x1245
  writew 0xf8100040 0x1212
  writew 0xf8100040 0x5002
  writew 0xf8100040 0x5002
  writew 0xf8100040 0x502a
  writeb 0xf8100081 0x40
  writeb 0xf810005d 0x40
  writeb 0xf8100030 0x5d
  writeb 0xf8100e44 0x44
  writeb 0xf8100044 0x3
  writeb 0xf8100044 0x3
  writeb 0xf8100044 0x13
  writew 0xf8100044 0x1210
  writew 0xf8100044 0x1210
  writew 0xf8100044 0x1210
  writew 0xf8100044 0x6d10
  writeb 0xf8100044 0x6d
  writeb 0xf8100000 0x2a
  writeb 0xf8100044 0x40
  writeb 0xf8100045 0xec
  writew 0xf8100044 0x1210
  writew 0xf8100044 0x1245
  writel 0xf8100044 0x101364ff
  writel 0xf81000c4 0xfba0a0a0
  writel 0xf8100044 0x101364ff
  writel 0xf8100044 0x101364ff
  writel 0xf8100044 0x101364ff
  writel 0xf8100008 0xfba0a0a0
  writel 0xf8100044 0x4208fba0
  writew 0xf8100010 0x4412
  writew 0xf8100010 0x4412
  writew 0xf8100010 0x4412
  writew 0xf8100010 0x4412
  writew 0xf8100010 0x4412
  writew 0xf8100000 0x4144
  writeb 0xf810030e 0xe
  writeb 0xf810030e 0xe
  writeb 0xf810032b 0xe
  writeb 0xf810032b 0xe
  writew 0xf8100010 0x4412
  writew 0xf81000ca 0x4441
  writew 0xf8100010 0x4412
  writew 0xf8100010 0x4412
  writew 0xf8100010 0x4412
  writew 0xf8100010 0x4412
  writeb 0xf8100080 0xe
  writeb 0xf8100080 0xd8
  writeb 0xf8100080 0x26
  writeb 0xf8100040 0x80
  writeb 0xf8100040 0x26
  writeb 0xf81000c3 0x40
  writeb 0xf81000ff 0xdf
  writeb 0xf81000c3 0x40
  writeb 0xf81000ff 0xdf
  writew 0xf8100014 0x4000
  writeb 0xf8100000 0xe
  writeb 0xf8100000 0x9e
  writeb 0xf8100000 0x3c
  writeb 0xf8100000 0x3c
  writeb 0xf8100000 0x3c
  writew 0xf8100000 0x4144
  writeb 0xf81000df 0x41
  writeb 0xf8100007 0x45
  writeb 0xf81000ff 0xff
  writeb 0xf8100007 0xb4
  writeb 0xf81000ff 0xff
  writeb 0xf8100007 0xb4
  writeb 0xf8100007 0xb4
  writel 0xf8100044 0x10139c05
  writel 0xf81000c4 0xfba0a0a0
  writeb 0xf8100604 0x50
  writeb 0xf8100021 0xe
  writeb 0xf8100021 0xe
  writeb 0xf8100021 0xe
  writeb 0xf8100021 0x90
  writew 0xf8100010 0x11
  writew 0xf8100010 0x11
  writew 0xf8100010 0x11
  writeb 0xf8100021 0xe
  writeb 0xf8100021 0xe
  writeb 0xf8100021 0xe
  writeb 0xf8100021 0xe
  writeb 0xf8100021 0xe
  writew 0xf8100010 0x4412
  writew 0xf8100010 0x4412
  writew 0xf8100010 0x4412
  writew 0xf8100010 0x4412
  writew 0xf8100010 0x4412
  writeb 0xf8100021 0xe
  writeb 0xf8100021 0xe
  writeb 0xf8100021 0x21
  writeb 0xf8100021 0x21
  writeb 0xf8100000 0x0
  writeb 0xf8100e04 0x46
  EOF

  Program terminated with signal SIGSEGV, Segmentation fault.
  #0  0x000056367b2085c0 in artist_rop8 (s=3D0x56367d38b510, dst=3D0x7f9f97=
2fffff <error: Cannot access memory at address 0x7f9f972fffff>, val=3D0 '\0=
00') at hw/display/artist.c:284
  284             *dst &=3D ~plane_mask;
  (gdb) bt
  #0  0x000056367b2085c0 in artist_rop8 (s=3D0x56367d38b510, dst=3D0x7f9f97=
2fffff <error: Cannot access memory at address 0x7f9f972fffff>, val=3D0 '\0=
00') at hw/display/artist.c:284
  #1  0x000056367b209325 in draw_line (s=3D0x56367d38b510, x1=3D-20480, y1=
=3D-1, x2=3D0, y2=3D17920, update_start=3Dtrue, skip_pix=3D-1, max_pix=3D-1=
) at hw/display/artist.c:646
  #2  0x000056367b2095a0 in draw_line_size (s=3D0x56367d38b510, update_star=
t=3Dtrue) at hw/display/artist.c:696
  #3  0x000056367b20a214 in artist_reg_write (opaque=3D0x56367d38b510, addr=
=3D1052164, val=3D70, size=3D1) at hw/display/artist.c:932
  #4  0x000056367b06ea7c in memory_region_write_accessor (mr=3D0x56367d38ba=
10, addr=3D1052164, value=3D0x7fff112132d8, size=3D1, shift=3D0, mask=3D255=
, attrs=3D...) at memory.c:483
  #5  0x000056367b06ec33 in access_with_adjusted_size (addr=3D1052164, valu=
e=3D0x7fff112132d8, size=3D1, access_size_min=3D1, access_size_max=3D4, acc=
ess_fn=3D
      0x56367b06e999 <memory_region_write_accessor>, mr=3D0x56367d38ba10, a=
ttrs=3D...) at memory.c:540
  #6  0x000056367b071bb4 in memory_region_dispatch_write (mr=3D0x56367d38ba=
10, addr=3D1052164, data=3D70, op=3DMO_8, attrs=3D...) at memory.c:1477
  #7  0x000056367b00fe33 in flatview_write_continue (fv=3D0x56367d6f9fa0, a=
ddr=3D4161801732, attrs=3D..., ptr=3D0x7fff112134e0, len=3D1, addr1=3D10521=
64, l=3D1, mr=3D0x56367d38ba10) at exec.c:3147
  #8  0x000056367b00ff81 in flatview_write (fv=3D0x56367d6f9fa0, addr=3D416=
1801732, attrs=3D..., buf=3D0x7fff112134e0, len=3D1) at exec.c:3190
  #9  0x000056367b0102eb in address_space_write (as=3D0x56367cff99c0, addr=
=3D4161801732, attrs=3D..., buf=3D0x7fff112134e0, len=3D1) at exec.c:3289

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1880326/+subscriptions

