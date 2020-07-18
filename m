Return-Path: <SRS0=NumX=A5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7403EC433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 09:51:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 448FE2070E
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 09:51:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 448FE2070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwjUx-0000sC-GG
	for qemu-devel@archiver.kernel.org; Sat, 18 Jul 2020 05:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jwjUP-0000RZ-Ik
 for qemu-devel@nongnu.org; Sat, 18 Jul 2020 05:50:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:37410)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jwjUN-0002TP-67
 for qemu-devel@nongnu.org; Sat, 18 Jul 2020 05:50:41 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jwjUL-0002Q5-45
 for <qemu-devel@nongnu.org>; Sat, 18 Jul 2020 09:50:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 1DBFE2E80E7
 for <qemu-devel@nongnu.org>; Sat, 18 Jul 2020 09:50:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2020 09:41:18 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1878259@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Committed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: a1xndr philmd pjps
X-Launchpad-Bug-Reporter: Alexander Bulekov (a1xndr)
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
References: <158930827727.28996.11410630721148857402.malonedeb@soybean.canonical.com>
Message-Id: <159506527841.13569.18101626789324965561.malone@gac.canonical.com>
Subject: [Bug 1878259] Re: Null-pointer dereference in megasas_handle_frame
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="4809fcb62f445aaa3ae919f7f6c3cc7d156ea57a";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: c0d784aa40ac396b32891f1e413a25505c275b9b
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/18 03:50:36
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
Reply-To: Bug 1878259 <1878259@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixed in commit 77f55eac6c433e23e82a1b88b2d74f385c4c7d82.

** Changed in: qemu
       Status: New =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1878259

Title:
  Null-pointer dereference in megasas_handle_frame

Status in QEMU:
  Fix Committed

Bug description:
  Hello,
  While fuzzing, I found an input that triggers a null-pointer dereference =
in megasas_handle_frame:

  =3D=3D1595=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x000000=
000000 (pc 0x55e3e83e6e08 bp 0x7ffdb04c63b0 sp 0x7ffd
  =3D=3D1595=3D=3DThe signal is caused by a READ memory access.
  =3D=3D1595=3D=3DHint: address points to the zero page.
      #0 0x55e3e83e6e08 in megasas_handle_frame /home/alxndr/Development/qe=
mu/hw/scsi/megasas.c:1952:36
      #1 0x55e3e83e6e08 in megasas_mmio_write /home/alxndr/Development/qemu=
/hw/scsi/megasas.c:2122:9
      #2 0x55e3e7d088d6 in memory_region_write_accessor /home/alxndr/Develo=
pment/qemu/memory.c:483:5
      #3 0x55e3e7d0827f in access_with_adjusted_size /home/alxndr/Developme=
nt/qemu/memory.c:544:18
      #4 0x55e3e7d0827f in memory_region_dispatch_write /home/alxndr/Develo=
pment/qemu/memory.c:1476:16
      #5 0x55e3e7c1d1d3 in flatview_write_continue /home/alxndr/Development=
/qemu/exec.c:3137:23
      #6 0x55e3e7c15b97 in flatview_write /home/alxndr/Development/qemu/exe=
c.c:3177:14
      #7 0x55e3e7c15b97 in address_space_write /home/alxndr/Development/qem=
u/exec.c:3268:18
      #8 0x55e3e7d03bc4 in qtest_process_command /home/alxndr/Development/q=
emu/qtest.c:567:9
      #9 0x55e3e7cfe74d in qtest_process_inbuf /home/alxndr/Development/qem=
u/qtest.c:710:9
      #10 0x55e3e8804cad in fd_chr_read /home/alxndr/Development/qemu/chard=
ev/char-fd.c:68:9
      #11 0x7f602ef2a897 in g_main_context_dispatch (/usr/lib/x86_64-linux-=
gnu/libglib-2.0.so.0+0x4e897)
      #12 0x55e3e8948384 in glib_pollfds_poll /home/alxndr/Development/qemu=
/util/main-loop.c:219:9
      #13 0x55e3e8948384 in os_host_main_loop_wait /home/alxndr/Development=
/qemu/util/main-loop.c:242:5
      #14 0x55e3e8948384 in main_loop_wait /home/alxndr/Development/qemu/ut=
il/main-loop.c:518:11
      #15 0x55e3e7f27676 in qemu_main_loop /home/alxndr/Development/qemu/so=
ftmmu/vl.c:1664:9
      #16 0x55e3e8851c6a in main /home/alxndr/Development/qemu/softmmu/main=
.c:49:5
      #17 0x7f602dadae0a in __libc_start_main /build/glibc-GwnBeO/glibc-2.3=
0/csu/../csu/libc-start.c:308:16
      #18 0x55e3e7b5c7b9 in _start (/home/alxndr/Development/qemu/build/i38=
6-softmmu/qemu-system-i386+0x9027b9)

  I can reproduce it in qemu 5.0 using:

  cat << EOF | ~/Development/qemu/build/i386-softmmu/qemu-system-i386 -qtes=
t stdio -nographic -monitor none -serial none -M q35 -device megasas
  outl 0xcf8 0x80001814
  outl 0xcfc 0xc021
  outl 0xcf8 0x80001818
  outl 0xcf8 0x80001804
  outw 0xcfc 0x7
  outl 0xcf8 0x80001810
  outl 0xcfc 0xe10c0000
  outl 0xcf8 0x8000f810
  outl 0xcf8 0x8000fa24
  outl 0xcfc 0xe10c4000
  outl 0xcf8 0x8000fa04
  outw 0xcfc 0x7
  outl 0xcf8 0x8000fb20
  write 0xe10c4384 0x15 0x838383838383838383838383838383838383838383
  write 0xc021e10c00c0 0x4 0x082c04dd
  EOF

  I also attached the commands to this launchpad report, in case the
  formatting is broken:

  qemu-system-i386 -qtest stdio -nographic -monitor none -serial none -M
  q35 -device megasas < attachment

  Please let me know if I can provide any further info.
  -Alex

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1878259/+subscriptions

