Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A50C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 02:36:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC83B206D9
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 02:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC83B206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ju5NI-0001QW-74
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 22:36:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1ju5MW-0000vT-3M
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 22:35:36 -0400
Received: from indium.canonical.com ([91.189.90.7]:38176)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1ju5MU-0005JZ-7k
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 22:35:35 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1ju5MS-0002KF-2n
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 02:35:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 0BA7C2E8025
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 02:35:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2020 02:27:45 -0000
From: Alexander Bulekov <1880539@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: a1xndr philmd
X-Launchpad-Bug-Reporter: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
X-Launchpad-Bug-Modifier: Alexander Bulekov (a1xndr)
References: <159039895924.7312.8999076686824323072.malonedeb@gac.canonical.com>
Message-Id: <159443446527.13251.15549023390424273703.malone@gac.canonical.com>
Subject: [Bug 1880539] Re: I/O write make QXL abort in qxl_set_mode()
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="4809fcb62f445aaa3ae919f7f6c3cc7d156ea57a";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 7cfa17f55f67c7c183de8a777f07f82f57f8d9e6
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 22:35:32
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
Reply-To: Bug 1880539 <1880539@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Here's a qtest reproducer for this:
cat << EOF | ./i386-softmmu/qemu-system-i386 -M q35,accel=3Dqtest -qtest nu=
ll -nographic -vga qxl -qtest stdio -nodefaults
outl 0xcf8 0x80000804
outb 0xcfc 0xff
outl 0xcf8 0x80000819
outl 0xcfc 0x87caff7a
outb 0x86 0x23
EOF

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1880539

Title:
  I/O write make QXL abort in qxl_set_mode()

Status in QEMU:
  New

Bug description:
  libFuzzer found:

  qxl-0: guest bug: qxl_add_memslot: guest_start > guest_end 0xffffffffffff=
ffff > 0x3ffffff
  qemu-fuzz-i386: hw/display/qxl.c:1611: void qxl_set_mode(PCIQXLDevice *, =
unsigned int, int): Assertion `qxl_add_memslot(d, 0, devmem, QXL_SYNC) =3D=
=3D 0' failed.
  =3D=3D8134=3D=3D ERROR: libFuzzer: deadly signal
      #0 0x55fddfcfb3f0 in __sanitizer_print_stack_trace (qemu-fuzz-i386+0x=
cb13f0)
      #1 0x55fddfc0a3e1 in fuzzer::PrintStackTrace() (qemu-fuzz-i386+0xbc03=
e1)
      #2 0x55fddfbeac6f in fuzzer::Fuzzer::CrashCallback() (qemu-fuzz-i386+=
0xba0c6f)
      #3 0x55fddfbeacc3 in fuzzer::Fuzzer::StaticCrashSignalCallback() (qem=
u-fuzz-i386+0xba0cc3)
      #4 0x7fd640644c6f  (/lib64/libpthread.so.0+0x12c6f)
      #5 0x7fd640483e34 in __GI_raise (/lib64/libc.so.6+0x37e34)
      #6 0x7fd64046e894 in __GI_abort (/lib64/libc.so.6+0x22894)
      #7 0x7fd64046e768 in __assert_fail_base.cold (/lib64/libc.so.6+0x2276=
8)
      #8 0x7fd64047c565 in __GI___assert_fail (/lib64/libc.so.6+0x30565)
      #9 0x55fde08afd8b in qxl_set_mode (qemu-fuzz-i386+0x1865d8b)
      #10 0x55fde08b9602 in ioport_write (qemu-fuzz-i386+0x186f602)
      #11 0x55fddff170a7 in memory_region_write_accessor (qemu-fuzz-i386+0x=
ecd0a7)
      #12 0x55fddff16c13 in access_with_adjusted_size (qemu-fuzz-i386+0xecc=
c13)
      #13 0x55fddff157b4 in memory_region_dispatch_write (qemu-fuzz-i386+0x=
ecb7b4)

  Can be reproduce doing "writeb 0x06 0x23" on QXL I/O (PCI BAR #3).

  Command line: 'qemu-system-i386 -display none -M pc -vga qxl'

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1880539/+subscriptions

