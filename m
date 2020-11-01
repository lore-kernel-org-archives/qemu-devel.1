Return-Path: <SRS0=Dm/C=EH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CF2C388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 01:16:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 932E920888
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 01:16:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 932E920888
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZ1zA-0002ez-9g
	for qemu-devel@archiver.kernel.org; Sat, 31 Oct 2020 21:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kZ1yE-0002Fk-IA
 for qemu-devel@nongnu.org; Sat, 31 Oct 2020 21:15:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:48816)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kZ1yB-0008FE-Uy
 for qemu-devel@nongnu.org; Sat, 31 Oct 2020 21:15:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kZ1y9-0007SA-VJ
 for <qemu-devel@nongnu.org>; Sun, 01 Nov 2020 01:15:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id E86292E8042
 for <qemu-devel@nongnu.org>; Sun,  1 Nov 2020 01:15:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2020 01:05:59 -0000
From: Alexander Bulekov <1890333@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: a1xndr
X-Launchpad-Bug-Reporter: Alexander Bulekov (a1xndr)
X-Launchpad-Bug-Modifier: Alexander Bulekov (a1xndr)
References: <159656782458.2385.15174533675764579105.malonedeb@gac.canonical.com>
Message-Id: <160419275993.8291.6853562879896269991.malone@soybean.canonical.com>
Subject: [Bug 1890333] Re: [OSS-Fuzz] Issue 26693:
 qemu:qemu-fuzz-i386-target-generic-fuzz-xhci: Index-out-of-bounds in
 xhci_runtime_write Assertion failure in address_space_stw_le_cached through
 virtio-* devices
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="96ff31b88b65a0d0ea73b89333fe7c4a2669d8fb"; Instance="production"
X-Launchpad-Hash: 0044be84d84a7dad4dd4dea201340fa37dd2e63c
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/31 19:30:41
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
Reply-To: Bug 1890333 <1890333@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

OSS-Fuzz Report: https://bugs.chromium.org/p/oss-
fuzz/issues/detail?id=3D26797

=3D=3D=3D Reproducer (build with --enable-sanitizers) =3D=3D=3D
cat << EOF | ./qemu-system-i386 -display none \
-machine accel=3Dqtest, -m 512M -machine q35 \
-device virtio-blk,drive=3Ddisk0 \
-drive file=3Dnull-co://,id=3Ddisk0,if=3Dnone,format=3Draw \
-qtest stdio
outl 0xcf8 0x80001889
outl 0xcfc 0x1000ffff
outl 0xcf8 0x80001897
outl 0xcf8 0x80001890
outl 0xcfc 0x4
outl 0xcf8 0x800018ff
outl 0xcf8 0x80001897
inb 0xcfc
outl 0xcf8 0x8000188a
outl 0xcfc 0xd4624
outl 0xcf8 0x80001897
outl 0xcf8 0x80001806
outl 0xcf8 0x80001897
outl 0xcfc 0xff6ca0ba
outl 0xcf8 0x8000188c
outw 0xcfc 0x14
outl 0xcf8 0x80001897
outl 0xcf8 0x8000185a
outl 0xcf8 0x80001897
outl 0xcfc 0x5f6c6346
inb 0xcfc
outl 0xcf8 0x80001802
outl 0xcfc 0x65a6055
outl 0xcf8 0x80001897
inb 0xcfc
outl 0xcf8 0x80001889
outl 0xcfc 0x1869ffff
outl 0xcf8 0x80001812
outl 0xcf8 0x80001897
outl 0xcfc 0x5f6c6346
outl 0xcf8 0x8000188c
outw 0xcfc 0x24
outl 0xcf8 0x80001890
outl 0xcf8 0x80001897
outl 0xcfc 0x1
outl 0xcf8 0x80001892
outl 0xcfc 0x1ff04
outl 0xcf8 0x8000188c
outw 0xcfc 0x1c
outl 0xcf8 0x80001890
outl 0xcfc 0x1
outl 0xcf8 0x80001897
outl 0xcfc 0xfd467562
outl 0xcf8 0x8000188a
outl 0xcfc 0x245a5546
outl 0xcf8 0x80001890
outl 0xcf8 0x80001897
inb 0xcfc
outl 0xcf8 0x8000188c
outw 0xcfc 0x14
outl 0xcf8 0x80001897
outl 0xcf8 0x80001806
outl 0xcf8 0x80001889
outl 0xcfc 0x1869ffff
outl 0xcf8 0x80001812
outl 0xcf8 0x80001897
outl 0xcfc 0x6c6346
outl 0xcf8 0x8000188c
outw 0xcfc 0x14
outl 0xcf8 0x80001890
outl 0xcf8 0x80001897
outl 0xcfc 0x1ff04
EOF

=3D=3D=3D Stack Trace =3D=3D=3D

qemu-fuzz-i386-target-generic-fuzz-virtio-blk: /src/qemu/include/exec/memor=
y_ldst_cached.h.inc:88: void address_space_stw_le_cached(MemoryRegionCache =
*, hwaddr, uint32_t, MemTxAttrs, MemTxResult *): Assertion `addr < cache->l=
en && 2 <=3D cache->len - addr' failed.
=3D=3D46=3D=3D ERROR: libFuzzer: deadly signal
#0 0x55deb7b59e61 in __sanitizer_print_stack_trace /src/llvm-project/compil=
er-rt/lib/asan/asan_stack.cpp:86:3
#1 0x55deb7aa1158 in fuzzer::PrintStackTrace() /src/llvm-project/compiler-r=
t/lib/fuzzer/FuzzerUtil.cpp:210:5
#2 0x55deb7a87053 in fuzzer::Fuzzer::CrashCallback() /src/llvm-project/comp=
iler-rt/lib/fuzzer/FuzzerLoop.cpp:233:3
#3 0x7fccd310638f in libpthread.so.0
#4 0x7fccd273e437 in gsignal
#5 0x7fccd2740039 in abort
#6 0x7fccd2736be6 in libc.so.6
#7 0x7fccd2736c91 in __assert_fail
#8 0x55deb8416ba3 in address_space_stw_le_cached /src/qemu/include/exec/mem=
ory_ldst_cached.h.inc:88:5
#9 0x55deb8416a40 in stw_le_phys_cached /src/qemu/include/exec/memory_ldst_=
phys.h.inc:121:5
#10 0x55deb8416a13 in virtio_stw_phys_cached /src/qemu/include/hw/virtio/vi=
rtio-access.h:196:9
#11 0x55deb8416899 in vring_set_avail_event /src/qemu/hw/virtio/virtio.c:42=
8:5
#12 0x55deb8406ba8 in virtio_queue_split_set_notification /src/qemu/hw/virt=
io/virtio.c:437:9
#13 0x55deb84067a2 in virtio_queue_set_notification /src/qemu/hw/virtio/vir=
tio.c:498:9
#14 0x55deb84755d3 in virtio_blk_handle_vq /src/qemu/hw/block/virtio-blk.c:=
795:13
#15 0x55deb84916ce in virtio_blk_data_plane_handle_output /src/qemu/hw/bloc=
k/dataplane/virtio-blk.c:165:12
#16 0x55deb841afaf in virtio_queue_notify_aio_vq /src/qemu/hw/virtio/virtio=
.c:2325:15
#17 0x55deb8415adb in virtio_queue_host_notifier_aio_read /src/qemu/hw/virt=
io/virtio.c:3529:9
#18 0x55deb892af84 in aio_dispatch_handler /src/qemu/util/aio-posix.c:329:9
#19 0x55deb8929b8a in aio_dispatch_handlers /src/qemu/util/aio-posix.c:372:=
20
#20 0x55deb8929ac0 in aio_dispatch /src/qemu/util/aio-posix.c:382:5
#21 0x55deb893ae2c in aio_ctx_dispatch /src/qemu/util/async.c:306:5
#22 0x7fccd3868196 in g_main_context_dispatch
#23 0x55deb8947fed in glib_pollfds_poll /src/qemu/util/main-loop.c:221:9
#24 0x55deb8947264 in os_host_main_loop_wait /src/qemu/util/main-loop.c:244=
:5
#25 0x55deb8946f25 in main_loop_wait /src/qemu/util/main-loop.c:520:11
#26 0x55deb7b8806a in flush_events /src/qemu/tests/qtest/fuzz/fuzz.c:48:9
#27 0x55deb7b85a32 in generic_fuzz /src/qemu/tests/qtest/fuzz/generic_fuzz.=
c:681:17
#28 0x55deb7b88450 in LLVMFuzzerTestOneInput /src/qemu/tests/qtest/fuzz/fuz=
z.c:150:5
#29 0x55deb7a887c1 in fuzzer::Fuzzer::ExecuteCallback(unsigned char const*,=
 unsigned long) /src/llvm-project/compiler-rt/lib/fuzzer/FuzzerLoop.cpp:595=
:15
#30 0x55deb7a73892 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, unsi=
gned long) /src/llvm-project/compiler-rt/lib/fuzzer/FuzzerDriver.cpp:323:6
#31 0x55deb7a7994e in fuzzer::FuzzerDriver(int*, char***, int (*)(unsigned =
char const*, unsigned long)) /src/llvm-project/compiler-rt/lib/fuzzer/Fuzze=
rDriver.cpp:852:9
#32 0x55deb7aa1932 in main /src/llvm-project/compiler-rt/lib/fuzzer/FuzzerM=
ain.cpp:20:10
#33 0x7fccd272983f in __libc_start_main
#34 0x55deb7a4eb38 in _start

** Summary changed:

- Assertion failure in address_space_stw_le_cached through virtio-* devices
+ [OSS-Fuzz] Issue 26693: qemu:qemu-fuzz-i386-target-generic-fuzz-xhci: Ind=
ex-out-of-bounds in xhci_runtime_write Assertion failure in address_space_s=
tw_le_cached through virtio-* devices

** Summary changed:

- [OSS-Fuzz] Issue 26693: qemu:qemu-fuzz-i386-target-generic-fuzz-xhci: Ind=
ex-out-of-bounds in xhci_runtime_write Assertion failure in address_space_s=
tw_le_cached through virtio-* devices
+ [OSS-Fuzz]  Issue 26797: qemu:qemu-fuzz-i386-target-generic-fuzz-virtio-b=
lk: ASSERT: addr < cache->len && 2 <=3D cache->len - addr

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1890333

Title:
  [OSS-Fuzz]  Issue 26797: qemu:qemu-fuzz-i386-target-generic-fuzz-
  virtio-blk: ASSERT: addr < cache->len && 2 <=3D cache->len - addr

Status in QEMU:
  New

Bug description:
  Hello,
  Reproducer:
  cat << EOF | ./i386-softmmu/qemu-system-i386 \
  -drive id=3Dmydrive,file=3Dnull-co://,size=3D2M,format=3Draw,if=3Dnone \
  -device virtio-blk,drive=3Dmydrive \
  -nodefaults -qtest stdio -nographic
  outl 0xcf8 0x80001001
  outl 0xcfc 0x6574c1ff
  outl 0xcf8 0x8000100e
  outl 0xcfc 0xefe5e1e
  outl 0xe86 0x3aff9090
  outl 0xe84 0x3aff9090
  outl 0xe8e 0xe
  EOF

  qemu-system-i386: /home/alxndr/Development/qemu/general-fuzz/include/exec=
/memory_ldst_cached.inc.h:88: void address_space_stw_le_cached(MemoryRegion=
Cache *, hwaddr, uint32_t, MemTxAttrs, MemTxResult *): Assertion `addr < ca=
che->len && 2 <=3D cache->len - addr' failed.
  Aborted

  I can trigger similar assertions with other VIRTIO devices, as-well.
  I reported this at some point in Message-ID: <20200511033001.dzvtbdhl3oz5=
pgiy@mozz.bu.edu> but never created a Launchpad issue...
  -Alex

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1890333/+subscriptions

