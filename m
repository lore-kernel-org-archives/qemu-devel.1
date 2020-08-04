Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5026C433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 20:02:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B58AF20842
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 20:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B58AF20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k338X-0005rD-NV
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 16:02:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k337H-0004ye-5g
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 16:00:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:52242)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k337E-0002h5-Rf
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 16:00:54 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k337D-0000Ix-OG
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 20:00:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id B243B2E80DC
 for <qemu-devel@nongnu.org>; Tue,  4 Aug 2020 20:00:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2020 19:54:38 -0000
From: Helge Deller <1890311@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided;
 assignee=deller@gmx.de; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: a1xndr
X-Launchpad-Bug-Reporter: Alexander Bulekov (a1xndr)
X-Launchpad-Bug-Modifier: Helge Deller (hdeller)
References: <159655836950.10566.1129235625267302731.malonedeb@chaenomeles.canonical.com>
Message-Id: <159657087977.16561.15710633680972571356.launchpad@wampee.canonical.com>
Subject: [Bug 1890311] Re: Segfault in cpu_physical_memory_set_dirty_range on
 hppa + artist
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a24057fea7e4c6a98c0220d5f878da0f3c783699";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: f740956860da01dffa64487a2350f30ef51f8f42
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 15:05:58
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
Reply-To: Bug 1890311 <1890311@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Changed in: qemu
     Assignee: (unassigned) =3D> Helge Deller (hdeller)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1890311

Title:
  Segfault in cpu_physical_memory_set_dirty_range on hppa + artist

Status in QEMU:
  New

Bug description:
  Hello,
  Reproducer:

  cat << EOF | ./hppa-softmmu/qemu-system-hppa -m 64 -display none \
  -qtest stdio -accel qtest
  writeq 0xf810049f 0x85000000000000
  writew 0xf8118001 0x14
  writeq 0xf81005fb 0x5c00006418001832
  EOF

  AddressSanitizer:DEADLYSIGNAL
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  =3D=3D10793=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x7f93d=
bb40000 (pc 0x5577f5523078 bp 0x7ffd41ad6360 sp 0x7ffd41ad5fd0 T0)
  =3D=3D10793=3D=3DThe signal is caused by a READ memory access.

      #0 0x5577f5523078 in block_move /hw/display/artist.c:525:13
      #1 0x5577f5515fbc in artist_reg_write /hw/display/artist.c:964:9
      #2 0x5577f4c077a3 in memory_region_write_accessor /softmmu/memory.c:4=
83:5
      #3 0x5577f4c06adc in access_with_adjusted_size /softmmu/memory.c:539:=
18
      #4 0x5577f4c04873 in memory_region_dispatch_write /softmmu/memory.c:1=
466:16
      #5 0x5577f42b2056 in flatview_write_continue /exec.c:3176:23
      #6 0x5577f429a866 in flatview_write /exec.c:3216:14
      #7 0x5577f429a387 in address_space_write /exec.c:3308:18
      #8 0x5577f4cae604 in qtest_process_command /softmmu/qtest.c:452:13
      #9 0x5577f4ca5c08 in qtest_process_inbuf /softmmu/qtest.c:710:9
      #10 0x5577f4ca4895 in qtest_read /softmmu/qtest.c:722:5
      #11 0x5577f7160c43 in qemu_chr_be_write_impl /chardev/char.c:188:9
      #12 0x5577f7160dc7 in qemu_chr_be_write /chardev/char.c:200:9
      #13 0x5577f71750b3 in fd_chr_read /chardev/char-fd.c:68:9
      #14 0x5577f72c9474 in qio_channel_fd_source_dispatch /io/channel-watc=
h.c:84:12
      #15 0x7f93ea531897 in g_main_context_dispatch (/usr/lib/x86_64-linux-=
gnu/libglib-2.0.so.0+0x4e897)
      #16 0x5577f76c137b in glib_pollfds_poll /util/main-loop.c:217:9
      #17 0x5577f76beaab in os_host_main_loop_wait /util/main-loop.c:240:5
      #18 0x5577f76be444 in main_loop_wait /util/main-loop.c:516:11
      #19 0x5577f4cc6d00 in qemu_main_loop /softmmu/vl.c:1676:9
      #20 0x5577f7301261 in main /softmmu/main.c:49:5
      #21 0x7f93e90b7e0a in __libc_start_main /build/glibc-GwnBeO/glibc-2.3=
0/csu/../csu/libc-start.c:308:16
      #22 0x5577f41a5729 in _start (/home/alxndr/Development/qemu/general-f=
uzz/build/hppa-softmmu/qemu-system-hppa+0x22d4729)

  AddressSanitizer can not provide additional info.
  SUMMARY: AddressSanitizer: SEGV /hw/display/artist.c:525:13 in block_move
  =3D=3D10793=3D=3DABORTING

  =

  The error occurs even with Message-Id: <20200804140056.7690-1-deller@gmx.=
de> applied (I collected the above trace with the patch-set applied)

  Thanks
  -Alex

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1890311/+subscriptions

