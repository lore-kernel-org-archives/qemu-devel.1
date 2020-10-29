Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8618C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 18:36:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9778D20759
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 18:36:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9778D20759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYCmw-0003nI-0B
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 14:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kYClz-000328-QD
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 14:35:43 -0400
Received: from indium.canonical.com ([91.189.90.7]:40844)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kYClu-0005oP-Vc
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 14:35:43 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kYClq-0000u3-Av
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 18:35:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 493C32E809C
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 18:35:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2020 18:26:57 -0000
From: Alexander Bulekov <1902112@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: a1xndr
X-Launchpad-Bug-Reporter: Alexander Bulekov (a1xndr)
X-Launchpad-Bug-Modifier: Alexander Bulekov (a1xndr)
Message-Id: <160399601757.31440.689059510574712583.malonedeb@gac.canonical.com>
Subject: [Bug 1902112] [NEW] [OSS-Fuzz] Issue 26693:
 qemu:qemu-fuzz-i386-target-generic-fuzz-xhci: Index-out-of-bounds in
 xhci_runtime_write 
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="96ff31b88b65a0d0ea73b89333fe7c4a2669d8fb"; Instance="production"
X-Launchpad-Hash: 58ddb99362a2756fedc1afe0a3bb1b645b7e1854
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 14:35:34
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
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
Reply-To: Bug 1902112 <1902112@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

OSS-Fuzz Report: https://bugs.chromium.org/p/oss-
fuzz/issues/detail?id=3D26693

=3D=3D=3D Reproducer (build with --enable-sanitizers) =3D=3D=3D
export UBSAN_OPTIONS=3D"print_stacktrace=3D1:silence_unsigned_overflow=3D1"
cat << EOF | ./qemu-system-i386 -display none -machine\
 accel=3Dqtest, -m 512M -machine q35 -nodefaults -drive\
 file=3Dnull-co://,if=3Dnone,format=3Draw,id=3Ddisk0 -device\
 qemu-xhci,id=3Dxhci -device usb-tablet,bus=3Dxhci.0\
 -device usb-bot -device usb-storage,drive=3Ddisk0\
 -chardev null,id=3Dcd0 -chardev null,id=3Dcd1 -device\
 usb-braille,chardev=3Dcd0 -device usb-ccid -device\
 usb-ccid -device usb-kbd -device usb-mouse -device\
 usb-serial,chardev=3Dcd1 -device usb-tablet -device\
 usb-wacom-tablet -device usb-audio -qtest stdio
outl 0xcf8 0x80000803
outl 0xcfc 0x18caffff
outl 0xcf8 0x80000810
outl 0xcfc 0x555a2e46
write 0x555a1004 0x4 0xe7b9aa7a
EOF

=3D=3D=3D Stack Trace =3D=3D=3D
 	=

SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../hw/usb/hcd-xhci.=
c:3012:30 in
../hw/usb/hcd-xhci.c:3012:30: runtime error: index -1 out of bounds for typ=
e 'XHCIInterrupter [16]'
#0 0x55bd2e97c8b0 in xhci_runtime_write /src/qemu/hw/usb/hcd-xhci.c:3012:30
#1 0x55bd2edfdd13 in memory_region_write_accessor /src/qemu/softmmu/memory.=
c:484:5
#2 0x55bd2edfdb14 in access_with_adjusted_size /src/qemu/softmmu/memory.c:5=
45:18
#3 0x55bd2edfd54b in memory_region_dispatch_write /src/qemu/softmmu/memory.=
c:0:13
#4 0x55bd2ed7fa46 in flatview_write_continue /src/qemu/softmmu/physmem.c:27=
67:23
#5 0x55bd2ed7cac0 in flatview_write /src/qemu/softmmu/physmem.c:2807:14
#6 0x55bd2ed7c9f8 in address_space_write /src/qemu/softmmu/physmem.c:2899:18
#7 0x55bd2e85cf9b in __wrap_qtest_writeq /src/qemu/tests/qtest/fuzz/qtest_w=
rappers.c:187:9
#8 0x55bd2e85b7b1 in op_write /src/qemu/tests/qtest/fuzz/generic_fuzz.c:476=
:13
#9 0x55bd2e85a84c in generic_fuzz /src/qemu/tests/qtest/fuzz/generic_fuzz.c=
:678:17
#10 0x55bd2e85dd6f in LLVMFuzzerTestOneInput /src/qemu/tests/qtest/fuzz/fuz=
z.c:150:5
#11 0x55bd2e7e9661 in fuzzer::Fuzzer::ExecuteCallback(unsigned char const*,=
 unsigned long) /src/llvm-project/compiler-rt/lib/fuzzer/FuzzerLoop.cpp:595=
:15
#12 0x55bd2e7d4732 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, unsi=
gned long) /src/llvm-project/compiler-rt/lib/fuzzer/FuzzerDriver.cpp:323:6
#13 0x55bd2e7da7ee in fuzzer::FuzzerDriver(int*, char***, int (*)(unsigned =
char const*, unsigned long)) /src/llvm-project/compiler-rt/lib/fuzzer/Fuzze=
rDriver.cpp:852:9
#14 0x55bd2e8027d2 in main /src/llvm-project/compiler-rt/lib/fuzzer/FuzzerM=
ain.cpp:20:10
#15 0x7f3d153b783f in __libc_start_main

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1902112

Title:
  [OSS-Fuzz] Issue 26693: qemu:qemu-fuzz-i386-target-generic-fuzz-xhci:
  Index-out-of-bounds in xhci_runtime_write

Status in QEMU:
  New

Bug description:
  OSS-Fuzz Report: https://bugs.chromium.org/p/oss-
  fuzz/issues/detail?id=3D26693

  =3D=3D=3D Reproducer (build with --enable-sanitizers) =3D=3D=3D
  export UBSAN_OPTIONS=3D"print_stacktrace=3D1:silence_unsigned_overflow=3D=
1"
  cat << EOF | ./qemu-system-i386 -display none -machine\
   accel=3Dqtest, -m 512M -machine q35 -nodefaults -drive\
   file=3Dnull-co://,if=3Dnone,format=3Draw,id=3Ddisk0 -device\
   qemu-xhci,id=3Dxhci -device usb-tablet,bus=3Dxhci.0\
   -device usb-bot -device usb-storage,drive=3Ddisk0\
   -chardev null,id=3Dcd0 -chardev null,id=3Dcd1 -device\
   usb-braille,chardev=3Dcd0 -device usb-ccid -device\
   usb-ccid -device usb-kbd -device usb-mouse -device\
   usb-serial,chardev=3Dcd1 -device usb-tablet -device\
   usb-wacom-tablet -device usb-audio -qtest stdio
  outl 0xcf8 0x80000803
  outl 0xcfc 0x18caffff
  outl 0xcf8 0x80000810
  outl 0xcfc 0x555a2e46
  write 0x555a1004 0x4 0xe7b9aa7a
  EOF

  =3D=3D=3D Stack Trace =3D=3D=3D
   	=

  SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../hw/usb/hcd-xhc=
i.c:3012:30 in
  ../hw/usb/hcd-xhci.c:3012:30: runtime error: index -1 out of bounds for t=
ype 'XHCIInterrupter [16]'
  #0 0x55bd2e97c8b0 in xhci_runtime_write /src/qemu/hw/usb/hcd-xhci.c:3012:=
30
  #1 0x55bd2edfdd13 in memory_region_write_accessor /src/qemu/softmmu/memor=
y.c:484:5
  #2 0x55bd2edfdb14 in access_with_adjusted_size /src/qemu/softmmu/memory.c=
:545:18
  #3 0x55bd2edfd54b in memory_region_dispatch_write /src/qemu/softmmu/memor=
y.c:0:13
  #4 0x55bd2ed7fa46 in flatview_write_continue /src/qemu/softmmu/physmem.c:=
2767:23
  #5 0x55bd2ed7cac0 in flatview_write /src/qemu/softmmu/physmem.c:2807:14
  #6 0x55bd2ed7c9f8 in address_space_write /src/qemu/softmmu/physmem.c:2899=
:18
  #7 0x55bd2e85cf9b in __wrap_qtest_writeq /src/qemu/tests/qtest/fuzz/qtest=
_wrappers.c:187:9
  #8 0x55bd2e85b7b1 in op_write /src/qemu/tests/qtest/fuzz/generic_fuzz.c:4=
76:13
  #9 0x55bd2e85a84c in generic_fuzz /src/qemu/tests/qtest/fuzz/generic_fuzz=
.c:678:17
  #10 0x55bd2e85dd6f in LLVMFuzzerTestOneInput /src/qemu/tests/qtest/fuzz/f=
uzz.c:150:5
  #11 0x55bd2e7e9661 in fuzzer::Fuzzer::ExecuteCallback(unsigned char const=
*, unsigned long) /src/llvm-project/compiler-rt/lib/fuzzer/FuzzerLoop.cpp:5=
95:15
  #12 0x55bd2e7d4732 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, un=
signed long) /src/llvm-project/compiler-rt/lib/fuzzer/FuzzerDriver.cpp:323:6
  #13 0x55bd2e7da7ee in fuzzer::FuzzerDriver(int*, char***, int (*)(unsigne=
d char const*, unsigned long)) /src/llvm-project/compiler-rt/lib/fuzzer/Fuz=
zerDriver.cpp:852:9
  #14 0x55bd2e8027d2 in main /src/llvm-project/compiler-rt/lib/fuzzer/Fuzze=
rMain.cpp:20:10
  #15 0x7f3d153b783f in __libc_start_main

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1902112/+subscriptions

