Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEF5C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 02:16:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 916E82176B
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 02:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 916E82176B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLGoJ-0007qA-Lu
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 22:16:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kLGnR-0007Dq-Hn
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 22:15:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:56684)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kLGnN-0003Er-Fk
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 22:15:45 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kLGnJ-0006W1-SM
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 02:15:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id D2FA22E80E9
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 02:15:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2020 02:06:18 -0000
From: Peter Xu <1896317@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: i386
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: peterx philmd
X-Launchpad-Bug-Reporter: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
X-Launchpad-Bug-Modifier: Peter Xu (peterx)
References: <160050668992.17815.17282420990273568963.malonedeb@soybean.canonical.com>
Message-Id: <160091317830.4484.12274341291596596946.malone@gac.canonical.com>
Subject: [Bug 1896317] Re: ioapic: UndefinedBehaviorSanitizer starting
 qemu-system-i386
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="83bdf6c8a3a5f87722c8927e54838522f3e57504"; Instance="production"
X-Launchpad-Hash: f64df8dc4dcecad749364d8353adb6ccc9cfec95
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 22:15:38
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
Reply-To: Bug 1896317 <1896317@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I cannot reproduce locally with 053a4177817...  What could I have
missed?

It's kind of odd - For i386, ioapic_as should be set in
../softmmu/vl.c:4355 in pc_memory_init().

The failure triggered at qemu_init softmmu/vl.c:4458:5, which is later.

However I don't see any place that ioapic_as can be cleared, yet.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1896317

Title:
  ioapic: UndefinedBehaviorSanitizer starting qemu-system-i386

Status in QEMU:
  New

Bug description:
  As of commit 053a4177817:

  $ ./configure --enable-sanitizers --disable-kvm

  $ make qemu-system-i386

  $ ./build/i386-softmmu/qemu-system-i386
  include/exec/memory.h:688:12: runtime error: member access within null po=
inter of type 'AddressSpace' (aka 'struct AddressSpace')
  SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior include/exec/memo=
ry.h:688:12 in =

  AddressSanitizer:DEADLYSIGNAL
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  =3D=3D249513=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x0000=
00000020 (pc 0x55955d7f8c4f bp 0x7fff10f3cff0 sp 0x7fff10f3cf20 T0)
  =3D=3D249513=3D=3DThe signal is caused by a READ memory access.
  =3D=3D249513=3D=3DHint: address points to the zero page.
      #0 0x55955d7f8c4f in address_space_to_flatview include/exec/memory.h:=
688:12
      #1 0x55955d8003d2 in address_space_translate include/exec/memory.h:22=
86:31
      #2 0x55955d8315f3 in address_space_stl_internal memory_ldst.c.inc:312=
:10
      #3 0x55955d831cd1 in address_space_stl_le memory_ldst.c.inc:353:5
      #4 0x55955d7ef2e1 in stl_le_phys include/exec/memory_ldst_phys.h.inc:=
103:5
      #5 0x55955d7ed299 in ioapic_service hw/intc/ioapic.c:138:17
      #6 0x55955d7f0e30 in ioapic_set_irq hw/intc/ioapic.c:186:17
      #7 0x55955e34b825 in qemu_set_irq hw/core/irq.c:45:5
      #8 0x55955d0409e6 in gsi_handler hw/i386/x86.c:583:5
      #9 0x55955e34b825 in qemu_set_irq hw/core/irq.c:45:5
      #10 0x55955ca539c9 in hpet_handle_legacy_irq hw/timer/hpet.c:724:13
      #11 0x55955e34b825 in qemu_set_irq hw/core/irq.c:45:5
      #12 0x55955ce7a695 in pit_irq_timer_update hw/timer/i8254.c:264:5
      #13 0x55955ce7a1d8 in pit_irq_control hw/timer/i8254.c:306:9
      #14 0x55955e34b825 in qemu_set_irq hw/core/irq.c:45:5
      #15 0x55955ca52276 in hpet_reset hw/timer/hpet.c:707:5
      #16 0x55955e342e91 in device_transitional_reset hw/core/qdev.c:1114:9
      #17 0x55955e345cfc in resettable_phase_hold hw/core/resettable.c:182:=
13
      #18 0x55955e31c1e5 in bus_reset_child_foreach hw/core/bus.c:94:9
      #19 0x55955e348a58 in resettable_child_foreach hw/core/resettable.c:9=
6:9
      #20 0x55955e34596f in resettable_phase_hold hw/core/resettable.c:173:5
      #21 0x55955e344a72 in resettable_assert_reset hw/core/resettable.c:60=
:5
      #22 0x55955e344919 in resettable_reset hw/core/resettable.c:45:5
      #23 0x55955e3473e9 in resettable_cold_reset_fn hw/core/resettable.c:2=
69:5
      #24 0x55955e344898 in qemu_devices_reset hw/core/reset.c:69:9
      #25 0x55955d05c5b0 in pc_machine_reset hw/i386/pc.c:1632:5
      #26 0x55955d55ab84 in qemu_system_reset softmmu/vl.c:1403:9
      #27 0x55955d56816d in qemu_init softmmu/vl.c:4458:5
      #28 0x55955bc13609 in main softmmu/main.c:49:5
      #29 0x7f3baad20041 in __libc_start_main (/lib64/libc.so.6+0x27041)
      #30 0x55955bb398ed in _start (build-sanitizer/qemu-system-i386+0x1b3d=
8ed)

  AddressSanitizer can not provide additional info.
  SUMMARY: AddressSanitizer: SEGV include/exec/memory.h:688:12 in address_s=
pace_to_flatview

  Comment and stl_le_phys() added in commit cb135f59b80:
      /* No matter whether IR is enabled, we translate
       * the IOAPIC message into a MSI one, and its
       * address space will decide whether we need a
       * translation. */
      stl_le_phys(ioapic_as, info.addr, info.data);

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1896317/+subscriptions

