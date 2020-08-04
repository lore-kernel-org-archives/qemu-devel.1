Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14283C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 12:52:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E13E42075A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 12:52:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E13E42075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2wQg-0004UM-3j
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 08:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k2wPC-0003MG-M8
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 08:50:58 -0400
Received: from indium.canonical.com ([91.189.90.7]:40744)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k2wP8-0000r8-Eu
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 08:50:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k2wP5-0001Q9-Qo
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 12:50:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id C46BA2E80F1
 for <qemu-devel@nongnu.org>; Tue,  4 Aug 2020 12:50:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2020 12:44:58 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1880189@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: display
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: philmd
X-Launchpad-Bug-Reporter: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
References: <159015472248.30432.13608778839061888464.malonedeb@wampee.canonical.com>
Message-Id: <159654509837.5527.2611619120469987061.malone@soybean.canonical.com>
Subject: [Bug 1880189] Re: I/O writes make cirrus_invalidate_region() crash
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a24057fea7e4c6a98c0220d5f878da0f3c783699";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 6193563723579c2c3bad9df94e12c24989ff6b0c
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
Reply-To: Bug 1880189 <1880189@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Making this bug public as secalert@ said "if an unprivileged guest user
can not trigger it, it can be treated as a normal bug".

** Information type changed from Private Security to Public

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1880189

Title:
  I/O writes make cirrus_invalidate_region() crash

Status in QEMU:
  New

Bug description:
  As of commit d19f1ab0, LLVM libFuzzer found:

  qemu-fuzz-i386: hw/display/cirrus_vga.c:646: void cirrus_invalidate_regio=
n(CirrusVGAState *, int, int, int, int): Assertion `off_cur_end >=3D off_cu=
r' failed.
  =3D=3D1336555=3D=3D ERROR: libFuzzer: deadly signal
      #0 0xaaaaaf943ce4 in __sanitizer_print_stack_trace
      #1 0xaaaaaf899474 in fuzzer::PrintStackTrace()
      #2 0xaaaaaf884c80 in fuzzer::Fuzzer::CrashCallback()
      #3 0xffff9b4e8568  (linux-vdso.so.1+0x568)
      #4 0xffff99ac406c in __libc_signal_restore_set /build/glibc-w4ZToO/gl=
ibc-2.31/signal/../sysdeps/unix/sysv/linux/internal-signals.h:86:3
      #5 0xffff99ac406c in raise /build/glibc-w4ZToO/glibc-2.31/signal/../s=
ysdeps/unix/sysv/linux/raise.c:48:3
      #6 0xffff99ab0d64 in abort /build/glibc-w4ZToO/glibc-2.31/stdlib/abor=
t.c:79:7
      #7 0xffff99abd5d8 in __assert_fail_base /build/glibc-w4ZToO/glibc-2.3=
1/assert/assert.c:92:3
      #8 0xffff99abd640 in __assert_fail /build/glibc-w4ZToO/glibc-2.31/ass=
ert/assert.c:101:3
      #9 0xaaaab040768c in cirrus_invalidate_region
      #10 0xaaaab0405404 in cirrus_bitblt_solidfill
      #11 0xaaaab0402a88 in cirrus_bitblt_start
      #12 0xaaaab04046a8 in cirrus_write_bitblt
      #13 0xaaaab0400db4 in cirrus_vga_write_gr
      #14 0xaaaab03fd33c in cirrus_vga_ioport_write
      #15 0xaaaaafb41674 in memory_region_write_accessor
      #16 0xaaaaafb411ec in access_with_adjusted_size
      #17 0xaaaaafb40180 in memory_region_dispatch_write
      #18 0xaaaaaf995dfc in flatview_write_continue
      #19 0xaaaaaf985bd8 in flatview_write
      #20 0xaaaaaf98574c in address_space_write
      #21 0xaaaab110510c in ioport_fuzz_qtest
      #22 0xaaaab1103a48 in i440fx_fuzz_qtest
      #23 0xaaaab11010d8 in LLVMFuzzerTestOneInput

  Reproducer:

  qemu-system-i386 -M isapc,accel=3Dqtest -vga cirrus -qtest stdio << 'EOF'
  outl 0x03b1 0x2fdc1001
  outb 0x03cc 0xe
  outb 0x03cc 0xe
  outb 0x03cc 0x2f
  outb 0x03cc 0xe
  outb 0x03cc 0x2f
  outb 0x03cc 0xe
  outl 0x03cc 0xedc100e
  outb 0x03cc 0x2f
  outl 0x03cc 0xe24f40e
  outl 0x03cc 0x2f23dc12
  outl 0x03cc 0xe23f40e
  outl 0x03cc 0xe31dc12
  outb 0x03cc 0x2f
  outl 0x03cc 0xe2af40e
  outl 0x03cc 0x2f235612
  outl 0x03cc 0xe23f40e
  outl 0x03cc 0xe31dc12
  outb 0x03cc 0x2f
  outl 0x03cc 0x2fdcf40e
  outb 0x03cc 0xe
  outl 0x03cc 0xedc100e
  outb 0x03cc 0x2f
  outl 0x03cc 0xe24f40e
  outl 0x03cc 0xe23dc12
  outb 0x03cc 0x2f
  outl 0x03cc 0xedc100e
  outl 0x03cc 0x2fdc400e
  outb 0x03cc 0xe
  outl 0x03cc 0xe130100e
  outb 0x03cc 0x2f
  outl 0x03cc 0xe23f40e
  outl 0x03cc 0xe31dc12
  outb 0x03cc 0x2f
  outl 0x03cc 0xe33f40e
  outl 0x03cc 0xdc235612
  outb 0x03cc 0xe
  outl 0x03cc 0x2fdc400e
  outb 0x03cc 0xe
  outl 0x03cc 0xfb24100e
  outb 0x03cc 0x2f
  outl 0x03cc 0xdc10dc0e
  outl 0x03cc 0x2f31dc12
  outl 0x03cc 0xe23f40e
  outl 0x03cc 0xe31dc12
  outb 0x03cc 0x2f
  outl 0x03cc 0xe23f40e
  outl 0x03cc 0xe31dc12
  outb 0x03cc 0x2f
  outl 0x03cc 0x1021f40e
  EOF
  qemu-system-i386: hw/display/cirrus_vga.c:645: cirrus_invalidate_region: =
Assertion `off_cur_end >=3D off_cur' failed.
  Aborted (core dumped)

  (gdb) bt
  #0  0x00007f1d019fee35 in raise () at /lib64/libc.so.6
  #1  0x00007f1d019e9895 in abort () at /lib64/libc.so.6
  #2  0x00007f1d019e9769 in _nl_load_domain.cold () at /lib64/libc.so.6
  #3  0x00007f1d019f7566 in annobin_assert.c_end () at /lib64/libc.so.6
  #4  0x00005645cb447a37 in cirrus_invalidate_region (s=3D0x5645cd237540, o=
ff_begin=3D2097204, off_pitch=3D251, bytesperline=3D1, lines=3D7169) at hw/=
display/cirrus_vga.c:645
  #5  0x00005645cb447cc8 in cirrus_bitblt_solidfill (s=3D0x5645cd237540, bl=
t_rop=3D0) at hw/display/cirrus_vga.c:704
  #6  0x00005645cb448886 in cirrus_bitblt_start (s=3D0x5645cd237540) at hw/=
display/cirrus_vga.c:1005
  #7  0x00005645cb448dd1 in cirrus_write_bitblt (s=3D0x5645cd237540, reg_va=
lue=3D47) at hw/display/cirrus_vga.c:1090
  #8  0x00005645cb449b02 in cirrus_vga_write_gr (s=3D0x5645cd237540, reg_in=
dex=3D49, reg_value=3D47) at hw/display/cirrus_vga.c:1593
  #9  0x00005645cb44bb2f in cirrus_vga_ioport_write (opaque=3D0x5645cd23754=
0, addr=3D975, val=3D47, size=3D1) at hw/display/cirrus_vga.c:2686
  #10 0x00005645cb1e0d6e in memory_region_write_accessor (mr=3D0x5645cd247f=
10, addr=3D31, value=3D0x7fff178d6c18, size=3D1, shift=3D24, mask=3D255, at=
trs=3D...) at memory.c:483
  #11 0x00005645cb1e0f7f in access_with_adjusted_size (addr=3D28, value=3D0=
x7fff178d6c18, size=3D4, access_size_min=3D1, access_size_max=3D1, access_f=
n=3D
      0x5645cb1e0c8b <memory_region_write_accessor>, mr=3D0x5645cd247f10, a=
ttrs=3D...) at memory.c:544
  #12 0x00005645cb1e3e9d in memory_region_dispatch_write (mr=3D0x5645cd247f=
10, addr=3D28, data=3D791796754, op=3DMO_32, attrs=3D...) at memory.c:1476
  #13 0x00005645cb1845e5 in flatview_write_continue (fv=3D0x5645cd65e510, a=
ddr=3D972, attrs=3D..., ptr=3D0x7fff178d6da4, len=3D4, addr1=3D28, l=3D4, m=
r=3D0x5645cd247f10) at exec.c:3137
  #14 0x00005645cb18472a in flatview_write (fv=3D0x5645cd65e510, addr=3D972=
, attrs=3D..., buf=3D0x7fff178d6da4, len=3D4) at exec.c:3177
  #15 0x00005645cb184a7d in address_space_write (as=3D0x5645cbd7bb20 <addre=
ss_space_io>, addr=3D972, attrs=3D..., buf=3D0x7fff178d6da4, len=3D4) at ex=
ec.c:3268
  #16 0x00005645cb1db385 in cpu_outl (addr=3D972, val=3D791796754) at iopor=
t.c:80

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1880189/+subscriptions

