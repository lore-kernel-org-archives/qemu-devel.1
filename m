Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8390AC7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 16:01:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BB9E205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 16:01:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BB9E205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn3QM-00055E-C4
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 12:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55394)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hn3PF-0001EB-BU
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 12:00:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hn3PD-0004Mr-O2
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 12:00:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:42492)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hn3PD-0004Ih-HU
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 12:00:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hn3PC-0008Vk-Pr
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 16:00:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id BA4642E80C7
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 16:00:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jul 2019 15:52:42 -0000
From: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@gmail.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Confirmed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: linux-user ppc
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: alex-bennee scherft
X-Launchpad-Bug-Reporter: Daan Scherft (scherft)
X-Launchpad-Bug-Modifier: =?utf-8?q?Alex_Benn=C3=A9e_=28alex-bennee=29?=
References: <156318593102.28533.3075291509963886255.malonedeb@chaenomeles.canonical.com>
Message-Id: <156320596219.28429.12314000798052307695.malone@wampee.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19007";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: e812588781174b7f5626aeb2c306f3f9d9e997dc
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1836558] Re: Qemu-ppc Memory leak creating threads
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
Reply-To: Bug 1836558 <1836558@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

By running:

  valgrind --leak-check=3Dyes ./qemu-ppc tests/testthread

I can replicate a leak compared to qemu-arm with the same test....

=3D=3D25789=3D=3D    at 0x483577F: malloc (vg_replace_malloc.c:299)        =
                                                                           =
                      [13/7729]
=3D=3D25789=3D=3D    by 0x4D7F8D0: g_malloc (in /usr/lib/x86_64-linux-gnu/l=
ibglib-2.0.so.0.5800.3)
=3D=3D25789=3D=3D    by 0x1FC65D: create_new_table (translate_init.inc.c:92=
52)
=3D=3D25789=3D=3D    by 0x1FC65D: register_ind_in_table (translate_init.inc=
.c:9291)
=3D=3D25789=3D=3D    by 0x1FC971: register_ind_insn (translate_init.inc.c:9=
325)
=3D=3D25789=3D=3D    by 0x1FC971: register_insn (translate_init.inc.c:9390)
=3D=3D25789=3D=3D    by 0x1FC971: create_ppc_opcodes (translate_init.inc.c:=
9450)
=3D=3D25789=3D=3D    by 0x1FC971: ppc_cpu_realize (translate_init.inc.c:981=
9)
=3D=3D25789=3D=3D    by 0x277263: device_set_realized (qdev.c:834)
=3D=3D25789=3D=3D    by 0x27BBC6: property_set_bool (object.c:2076)
=3D=3D25789=3D=3D    by 0x28019E: object_property_set_qobject (qom-qobject.=
c:26)
=3D=3D25789=3D=3D    by 0x27DAF4: object_property_set_bool (object.c:1334)
=3D=3D25789=3D=3D    by 0x27AE4B: cpu_create (cpu.c:62)
=3D=3D25789=3D=3D    by 0x1C89B8: cpu_copy (main.c:188)
=3D=3D25789=3D=3D    by 0x1CA44F: do_fork (syscall.c:5604)
=3D=3D25789=3D=3D    by 0x1D665A: do_syscall1.isra.43 (syscall.c:9160)
=3D=3D25789=3D=3D
=3D=3D25789=3D=3D 6,656 bytes in 26 blocks are possibly lost in loss record=
 216 of 238
=3D=3D25789=3D=3D    at 0x483577F: malloc (vg_replace_malloc.c:299)
=3D=3D25789=3D=3D    by 0x4D7F8D0: g_malloc (in /usr/lib/x86_64-linux-gnu/l=
ibglib-2.0.so.0.5800.3)
=3D=3D25789=3D=3D    by 0x1FC65D: create_new_table (translate_init.inc.c:92=
52)
=3D=3D25789=3D=3D    by 0x1FC65D: register_ind_in_table (translate_init.inc=
.c:9291)
=3D=3D25789=3D=3D    by 0x1FC9BA: register_dblind_insn (translate_init.inc.=
c:9337)
=3D=3D25789=3D=3D    by 0x1FC9BA: register_insn (translate_init.inc.c:9384)
=3D=3D25789=3D=3D    by 0x1FC9BA: create_ppc_opcodes (translate_init.inc.c:=
9450)
=3D=3D25789=3D=3D    by 0x1FC9BA: ppc_cpu_realize (translate_init.inc.c:981=
9)
=3D=3D25789=3D=3D    by 0x277263: device_set_realized (qdev.c:834)
=3D=3D25789=3D=3D    by 0x27BBC6: property_set_bool (object.c:2076)
=3D=3D25789=3D=3D    by 0x28019E: object_property_set_qobject (qom-qobject.=
c:26)
=3D=3D25789=3D=3D    by 0x27DAF4: object_property_set_bool (object.c:1334)
=3D=3D25789=3D=3D    by 0x27AE4B: cpu_create (cpu.c:62)
=3D=3D25789=3D=3D    by 0x17304D: main (main.c:681)
=3D=3D25789=3D=3D
=3D=3D25789=3D=3D 10,752 (1,024 direct, 9,728 indirect) bytes in 4 blocks a=
re definitely lost in loss record 223 of 238
=3D=3D25789=3D=3D    at 0x483577F: malloc (vg_replace_malloc.c:299)
=3D=3D25789=3D=3D    by 0x4D7F8D0: g_malloc (in /usr/lib/x86_64-linux-gnu/l=
ibglib-2.0.so.0.5800.3)
=3D=3D25789=3D=3D    by 0x1FC65D: create_new_table (translate_init.inc.c:92=
52)
=3D=3D25789=3D=3D    by 0x1FC65D: register_ind_in_table (translate_init.inc=
.c:9291)
=3D=3D25789=3D=3D    by 0x1FC998: register_dblind_insn (translate_init.inc.=
c:9332)
=3D=3D25789=3D=3D    by 0x1FC998: register_insn (translate_init.inc.c:9384)
=3D=3D25789=3D=3D    by 0x1FC998: create_ppc_opcodes (translate_init.inc.c:=
9450)
=3D=3D25789=3D=3D    by 0x1FC998: ppc_cpu_realize (translate_init.inc.c:981=
9)
=3D=3D25789=3D=3D    by 0x277263: device_set_realized (qdev.c:834)
=3D=3D25789=3D=3D    by 0x27BBC6: property_set_bool (object.c:2076)
=3D=3D25789=3D=3D    by 0x28019E: object_property_set_qobject (qom-qobject.=
c:26)
=3D=3D25789=3D=3D    by 0x27DAF4: object_property_set_bool (object.c:1334)
=3D=3D25789=3D=3D    by 0x27AE4B: cpu_create (cpu.c:62)
=3D=3D25789=3D=3D    by 0x1C89B8: cpu_copy (main.c:188)
=3D=3D25789=3D=3D    by 0x1CA44F: do_fork (syscall.c:5604)
=3D=3D25789=3D=3D    by 0x1D665A: do_syscall1.isra.43 (syscall.c:9160)

So something funky happens to the PPC translator for each new thread....

** Changed in: qemu
       Status: New =3D> Confirmed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1836558

Title:
  Qemu-ppc Memory leak creating threads

Status in QEMU:
  Confirmed

Bug description:
  When creating c++ threads (with c++ std::thread), the resulting binary
  has memory leaks when running with qemu-ppc.

  Eg the following c++ program, when compiled with gcc, consumes more
  and more memory while running at qemu-ppc. (does not have memory leaks
  when compiling for Intel, when running same binary on real powerpc CPU
  hardware also no memory leaks).

  (Note I used function getCurrentRSS to show available memory, see
  https://stackoverflow.com/questions/669438/how-to-get-memory-usage-at-
  runtime-using-c; calls commented out here)

  Compiler: powerpc-linux-gnu-g++ (Debian 8.3.0-2) 8.3.0 (but same problem =
with older g++ compilers even 4.9)
  Os: Debian 10.0 ( Buster) (but same problem seen on Debian 9/stetch)
  qemu: qemu-ppc version 3.1.50


  ---

  #include <iostream>
  #include <thread>
  #include <chrono>

  =

  using namespace std::chrono_literals;

  // Create/run and join a 100 threads.
  void Fun100()
  {
  //    auto b4 =3D getCurrentRSS();
  //    std::cout << getCurrentRSS() << std::endl;
      for(int n =3D 0; n < 100; n++)
      {
          std::thread t([]
          {
              std::this_thread::sleep_for( 10ms );
          });
  //        std::cout << n << ' ' << getCurrentRSS() << std::endl;
          t.join();
      }
      std::this_thread::sleep_for( 500ms ); // to give OS some time to wipe=
 memory...
  //    auto after =3D getCurrentRSS();
      std::cout << b4 << ' ' << after << std::endl;
  }

  =

  int main(int, char **)
  {
      Fun100();
      Fun100();  // memory used keeps increasing
  }

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1836558/+subscriptions

