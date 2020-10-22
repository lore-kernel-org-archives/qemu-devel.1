Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634AFC388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 14:36:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7307424171
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 14:36:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7307424171
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVbi5-0004qi-3x
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 10:36:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kVbgs-0003cQ-1k
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 10:35:42 -0400
Received: from indium.canonical.com ([91.189.90.7]:59110)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kVbgn-0004dM-IK
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 10:35:41 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kVbgk-0006ef-F2
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 14:35:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 702A22E812F
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 14:35:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2020 14:27:20 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1890310@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Committed; importance=Undecided;
 assignee=deller@gmx.de; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: a1xndr philmd
X-Launchpad-Bug-Reporter: Alexander Bulekov (a1xndr)
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
References: <159655836781.5403.11127209005915887374.malonedeb@soybean.canonical.com>
Message-Id: <160337684032.26978.4302772373962956567.malone@wampee.canonical.com>
Subject: [Bug 1890310] Re: Segfault in artist.c:block_move
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="bc5a16cfdc4ba776ecdf84a052201ef8fb1f3321"; Instance="production"
X-Launchpad-Hash: b4e110a4ce0ac9026dcf6d2d87f5ef5344203eaf
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 08:20:54
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
Reply-To: Bug 1890310 <1890310@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixed by commit a501bfc91763d4642390090dd4e6039d67b63702.

** Changed in: qemu
       Status: New =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1890310

Title:
  Segfault in artist.c:block_move

Status in QEMU:
  Fix Committed

Bug description:
  Hello,
  Reproducer:

  cat << EOF | ./hppa-softmmu/qemu-system-hppa -m 64 -display none \
  -qtest stdio -accel qtest
  writeq 0xf8100802 0xff5c651ffffb7c5c
  writeq 0xf8100afb 0x25e000000000000
  EOF

  AddressSanitizer:DEADLYSIGNAL
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  =3D=3D12686=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x7f001=
a540000 (pc 0x55af3a373078 bp 0x7ffc23001a00 sp 0x7ffc23001670 T0)
  =3D=3D12686=3D=3DThe signal is caused by a READ memory access.
      #0 0x55af3a373078 in block_move /hw/display/artist.c:525:13
      #1 0x55af3a365fbc in artist_reg_write /hw/display/artist.c:964:9
      #2 0x55af39a577a3 in memory_region_write_accessor /softmmu/memory.c:4=
83:5
      #3 0x55af39a56adc in access_with_adjusted_size /softmmu/memory.c:539:=
18
      #4 0x55af39a54873 in memory_region_dispatch_write /softmmu/memory.c:1=
466:16
      #5 0x55af39102056 in flatview_write_continue /exec.c:3176:23
      #6 0x55af390ea866 in flatview_write /exec.c:3216:14
      #7 0x55af390ea387 in address_space_write /exec.c:3308:18
      #8 0x55af39afe604 in qtest_process_command /softmmu/qtest.c:452:13
      #9 0x55af39af5c08 in qtest_process_inbuf /softmmu/qtest.c:710:9
      #10 0x55af39af4895 in qtest_read /softmmu/qtest.c:722:5
      #11 0x55af3bfb0c43 in qemu_chr_be_write_impl /chardev/char.c:188:9
      #12 0x55af3bfb0dc7 in qemu_chr_be_write /chardev/char.c:200:9
      #13 0x55af3bfc50b3 in fd_chr_read /chardev/char-fd.c:68:9
      #14 0x55af3c119474 in qio_channel_fd_source_dispatch /io/channel-watc=
h.c:84:12
      #15 0x7f0028f60897 in g_main_context_dispatch (/usr/lib/x86_64-linux-=
gnu/libglib-2.0.so.0+0x4e897)
      #16 0x55af3c51137b in glib_pollfds_poll /util/main-loop.c:217:9
      #17 0x55af3c50eaab in os_host_main_loop_wait /util/main-loop.c:240:5
      #18 0x55af3c50e444 in main_loop_wait /util/main-loop.c:516:11
      #19 0x55af39b16d00 in qemu_main_loop /softmmu/vl.c:1676:9
      #20 0x55af3c151261 in main /softmmu/main.c:49:5
      #21 0x7f0027ae6e0a in __libc_start_main /build/glibc-GwnBeO/glibc-2.3=
0/csu/../csu/libc-start.c:308:16
      #22 0x55af38ff5729 in _start (/home/alxndr/Development/qemu/general-f=
uzz/build/hppa-softmmu/qemu-system-hppa+0x22d4729)

  AddressSanitizer can not provide additional info.
  SUMMARY: AddressSanitizer: SEGV /hw/display/artist.c:525:13 in block_move
  =3D=3D12686=3D=3DABORTING

  The error occurs even with Message-Id:
  <20200804140056.7690-1-deller@gmx.de> applied (I collected the above
  trace with the patch-set applied)

  Thanks
  -Alex

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1890310/+subscriptions

