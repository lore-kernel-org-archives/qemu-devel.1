Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3334DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 16:41:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AAB32064B
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 16:41:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AAB32064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k300Y-0003nz-7b
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 12:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k2zzo-0002dr-Bo
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 12:41:00 -0400
Received: from indium.canonical.com ([91.189.90.7]:45434)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k2zzm-0002Ui-El
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 12:41:00 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k2zzk-0001e7-MB
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 16:40:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id A6A2C2E80E7
 for <qemu-devel@nongnu.org>; Tue,  4 Aug 2020 16:40:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2020 16:26:11 -0000
From: Alexander Bulekov <1890312@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: a1xndr
X-Launchpad-Bug-Reporter: Alexander Bulekov (a1xndr)
X-Launchpad-Bug-Modifier: Alexander Bulekov (a1xndr)
Message-Id: <159655837180.16425.4114028291831523850.malonedeb@wampee.canonical.com>
Subject: [Bug 1890312] [NEW] Segfault in artist_vram_read
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a24057fea7e4c6a98c0220d5f878da0f3c783699";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 89b0995cb1cab779ae1b047de6b96509c06edc55
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 08:50:53
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
Reply-To: Bug 1890312 <1890312@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Hello,
Reproducer:

cat << EOF | ./hppa-softmmu/qemu-system-hppa -m 64 -display none \
-qtest stdio -accel qtest
writew 0xf8118001 0x105a
readq 0xf900f8ff
EOF

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D20118=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x7fc6fb8=
47672 (pc 0x55ec9c0f6828 bp 0x7ffd91000230 sp 0x7ffd90ffffd0 T0)
=3D=3D20118=3D=3DThe signal is caused by a READ memory access.
    #0 0x55ec9c0f6828 in artist_vram_read /hw/display/artist.c:1174:15
    #1 0x55ec9b84a582 in memory_region_read_accessor /softmmu/memory.c:434:=
11
    #2 0x55ec9b7d1adc in access_with_adjusted_size /softmmu/memory.c:539:18
    #3 0x55ec9b7cd769 in memory_region_dispatch_read1 /softmmu/memory.c:138=
5:16
    #4 0x55ec9b7cc855 in memory_region_dispatch_read /softmmu/memory.c:1414=
:9
    #5 0x55ec9ae621de in flatview_read_continue /exec.c:3239:23
    #6 0x55ec9ae64fb1 in flatview_read /exec.c:3279:12
    #7 0x55ec9ae64af7 in address_space_read_full /exec.c:3292:18
    #8 0x55ec9b87c990 in address_space_read /include/exec/memory.h:2429:18
    #9 0x55ec9b87c990 in qtest_process_command /softmmu/qtest.c:485:13
    #10 0x55ec9b870c08 in qtest_process_inbuf /softmmu/qtest.c:710:9
    #11 0x55ec9b86f895 in qtest_read /softmmu/qtest.c:722:5
    #12 0x55ec9dd2b2f3 in qemu_chr_be_write_impl /chardev/char.c:188:9
    #13 0x55ec9dd2b477 in qemu_chr_be_write /chardev/char.c:200:9
    #14 0x55ec9dd3f763 in fd_chr_read /chardev/char-fd.c:68:9
    #15 0x55ec9de93b24 in qio_channel_fd_source_dispatch /io/channel-watch.=
c:84:12
    #16 0x7fc7261ad897 in g_main_context_dispatch ()
    #17 0x55ec9e28ba2b in glib_pollfds_poll /util/main-loop.c:217:9
    #18 0x55ec9e28915b in os_host_main_loop_wait /util/main-loop.c:240:5
    #19 0x55ec9e288af4 in main_loop_wait /util/main-loop.c:516:11
    #20 0x55ec9b891d00 in qemu_main_loop /softmmu/vl.c:1676:9
    #21 0x55ec9decb911 in main /softmmu/main.c:49:5

The error occurs even with Message-Id:
<20200804140056.7690-1-deller@gmx.de> applied (I collected the above
trace with the patch-set applied)

Thanks
-Alex

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1890312

Title:
  Segfault in artist_vram_read

Status in QEMU:
  New

Bug description:
  Hello,
  Reproducer:

  cat << EOF | ./hppa-softmmu/qemu-system-hppa -m 64 -display none \
  -qtest stdio -accel qtest
  writew 0xf8118001 0x105a
  readq 0xf900f8ff
  EOF

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  =3D=3D20118=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x7fc6f=
b847672 (pc 0x55ec9c0f6828 bp 0x7ffd91000230 sp 0x7ffd90ffffd0 T0)
  =3D=3D20118=3D=3DThe signal is caused by a READ memory access.
      #0 0x55ec9c0f6828 in artist_vram_read /hw/display/artist.c:1174:15
      #1 0x55ec9b84a582 in memory_region_read_accessor /softmmu/memory.c:43=
4:11
      #2 0x55ec9b7d1adc in access_with_adjusted_size /softmmu/memory.c:539:=
18
      #3 0x55ec9b7cd769 in memory_region_dispatch_read1 /softmmu/memory.c:1=
385:16
      #4 0x55ec9b7cc855 in memory_region_dispatch_read /softmmu/memory.c:14=
14:9
      #5 0x55ec9ae621de in flatview_read_continue /exec.c:3239:23
      #6 0x55ec9ae64fb1 in flatview_read /exec.c:3279:12
      #7 0x55ec9ae64af7 in address_space_read_full /exec.c:3292:18
      #8 0x55ec9b87c990 in address_space_read /include/exec/memory.h:2429:18
      #9 0x55ec9b87c990 in qtest_process_command /softmmu/qtest.c:485:13
      #10 0x55ec9b870c08 in qtest_process_inbuf /softmmu/qtest.c:710:9
      #11 0x55ec9b86f895 in qtest_read /softmmu/qtest.c:722:5
      #12 0x55ec9dd2b2f3 in qemu_chr_be_write_impl /chardev/char.c:188:9
      #13 0x55ec9dd2b477 in qemu_chr_be_write /chardev/char.c:200:9
      #14 0x55ec9dd3f763 in fd_chr_read /chardev/char-fd.c:68:9
      #15 0x55ec9de93b24 in qio_channel_fd_source_dispatch /io/channel-watc=
h.c:84:12
      #16 0x7fc7261ad897 in g_main_context_dispatch ()
      #17 0x55ec9e28ba2b in glib_pollfds_poll /util/main-loop.c:217:9
      #18 0x55ec9e28915b in os_host_main_loop_wait /util/main-loop.c:240:5
      #19 0x55ec9e288af4 in main_loop_wait /util/main-loop.c:516:11
      #20 0x55ec9b891d00 in qemu_main_loop /softmmu/vl.c:1676:9
      #21 0x55ec9decb911 in main /softmmu/main.c:49:5

  The error occurs even with Message-Id:
  <20200804140056.7690-1-deller@gmx.de> applied (I collected the above
  trace with the patch-set applied)

  Thanks
  -Alex

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1890312/+subscriptions

