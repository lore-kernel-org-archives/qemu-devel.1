Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338E4C76195
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 15:01:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00C1D21743
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 15:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00C1D21743
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnOxE-0005FC-Uk
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 11:01:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51835)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hnOwr-0004OA-Pk
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 11:01:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hnOwl-0004ek-M5
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 11:00:57 -0400
Received: from indium.canonical.com ([91.189.90.7]:54442)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hnOwi-0004cs-VA
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 11:00:49 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hnOwg-0004II-3r
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 15:00:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 1A47C2E8005
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 15:00:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jul 2019 14:53:58 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1836762@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: spice
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: philmd
X-Launchpad-Bug-Reporter: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
Message-Id: <156328883859.28108.13283790893247050323.malonedeb@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19007";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 0182143d503b03c1e923f82e6a973b19e1efc01c
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1836762] [NEW] Many leaks from
 qemu_spice_create_update
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
Reply-To: Bug 1836762 <1836762@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

tag: v4.1.0-rc0

Compiled with --enable-sanitizers

$ qemu-system-x86_64 -device qxl-vga ...
[guest exits calling 'hlt']
=3D=3D20452=3D=3DERROR: LeakSanitizer: detected memory leaks

Direct leak of 167616 byte(s) in 582 object(s) allocated from:
    #0 0x561146f2c8ef in calloc (x86_64-softmmu/qemu-system-x86_64+0x18248e=
f)
    #1 0x7f73af3dde1d in g_malloc0 (/lib64/libglib-2.0.so.0+0x54e1d)
    #2 0x561148c6d547 in qemu_spice_create_update qemu/ui/spice-display.c:2=
22:21
    #3 0x561148c6ba2b in qemu_spice_display_refresh qemu/ui/spice-display.c=
:488:9
    #4 0x561148172eff in display_refresh qemu/hw/display/qxl.c:2030:9
    #5 0x561148c2748f in dpy_refresh qemu/ui/console.c:1629:13
    #6 0x561148c263f1 in gui_update qemu/ui/console.c:206:5
    #7 0x561149558e6b in timerlist_run_timers qemu/util/qemu-timer.c:574:9
    #8 0x5611495591de in qemu_clock_run_timers qemu/util/qemu-timer.c:588:12
    #9 0x56114955a489 in qemu_clock_run_all_timers qemu/util/qemu-timer.c:7=
08:25
    #10 0x56114955b235 in main_loop_wait qemu/util/main-loop.c:519:5
    #11 0x561147c587b3 in main_loop qemu/vl.c:1791:9
    #12 0x561147c4976d in main qemu/vl.c:4473:5
    #13 0x7f73ac5c4412 in __libc_start_main (/lib64/libc.so.6+0x24412)

Direct leak of 5184 byte(s) in 18 object(s) allocated from:
    #0 0x561146f2c8ef in calloc (x86_64-softmmu/qemu-system-x86_64+0x18248e=
f)
    #1 0x7f73af3dde1d in g_malloc0 (/lib64/libglib-2.0.so.0+0x54e1d)
    #2 0x561148c6e3e7 in qemu_spice_create_update qemu/ui/spice-display.c:2=
43:13
    #3 0x561148c6ba2b in qemu_spice_display_refresh qemu/ui/spice-display.c=
:488:9
    #4 0x561148172eff in display_refresh qemu/hw/display/qxl.c:2030:9
    #5 0x561148c2748f in dpy_refresh qemu/ui/console.c:1629:13
    #6 0x561148c263f1 in gui_update qemu/ui/console.c:206:5
    #7 0x561149558e6b in timerlist_run_timers qemu/util/qemu-timer.c:574:9
    #8 0x5611495591de in qemu_clock_run_timers qemu/util/qemu-timer.c:588:12
    #9 0x56114955a489 in qemu_clock_run_all_timers qemu/util/qemu-timer.c:7=
08:25
    #10 0x56114955b235 in main_loop_wait qemu/util/main-loop.c:519:5
    #11 0x561147c587b3 in main_loop qemu/vl.c:1791:9
    #12 0x561147c4976d in main qemu/vl.c:4473:5
    #13 0x7f73ac5c4412 in __libc_start_main (/lib64/libc.so.6+0x24412)

Direct leak of 2560 byte(s) in 4 object(s) allocated from:
    #0 0x561146f2cb46 in realloc (x86_64-softmmu/qemu-system-x86_64+0x1824b=
46)
    #1 0x7f73ac04c420  (/lib64/libfontconfig.so.1+0x21420)

Direct leak of 22 byte(s) in 1 object(s) allocated from:
    #0 0x561146f2c6af in __interceptor_malloc (x86_64-softmmu/qemu-system-x=
86_64+0x18246af)
    #1 0x7f73ae781953 in XGetAtomName (/lib64/libX11.so.6+0x2a953)

Indirect leak of 54936 byte(s) in 510 object(s) allocated from:
    #0 0x561146f2c6af in __interceptor_malloc (x86_64-softmmu/qemu-system-x=
86_64+0x18246af)
    #1 0x7f73af3dddc5 in g_malloc (/lib64/libglib-2.0.so.0+0x54dc5)
    #2 0x561148c6d547 in qemu_spice_create_update qemu/ui/spice-display.c:2=
22:21
    #3 0x561148c6ba2b in qemu_spice_display_refresh qemu/ui/spice-display.c=
:488:9
    #4 0x561148172eff in display_refresh qemu/hw/display/qxl.c:2030:9
    #5 0x561148c2748f in dpy_refresh qemu/ui/console.c:1629:13
    #6 0x561148c263f1 in gui_update qemu/ui/console.c:206:5
    #7 0x561149558e6b in timerlist_run_timers qemu/util/qemu-timer.c:574:9
    #8 0x5611495591de in qemu_clock_run_timers qemu/util/qemu-timer.c:588:12
    #9 0x56114955a489 in qemu_clock_run_all_timers qemu/util/qemu-timer.c:7=
08:25
    #10 0x56114955b235 in main_loop_wait qemu/util/main-loop.c:519:5
    #11 0x561147c587b3 in main_loop qemu/vl.c:1791:9
    #12 0x561147c4976d in main qemu/vl.c:4473:5
    #13 0x7f73ac5c4412 in __libc_start_main (/lib64/libc.so.6+0x24412)

Indirect leak of 30720 byte(s) in 23 object(s) allocated from:
    #0 0x561146f2c6af in __interceptor_malloc (x86_64-softmmu/qemu-system-x=
86_64+0x18246af)
    #1 0x7f73af3dddc5 in g_malloc (/lib64/libglib-2.0.so.0+0x54dc5)
    #2 0x561148c6e3e7 in qemu_spice_create_update qemu/ui/spice-display.c:2=
43:13
    #3 0x561148c6ba2b in qemu_spice_display_refresh qemu/ui/spice-display.c=
:488:9
    #4 0x561148172eff in display_refresh qemu/hw/display/qxl.c:2030:9
    #5 0x561148c2748f in dpy_refresh qemu/ui/console.c:1629:13
    #6 0x561148c263f1 in gui_update qemu/ui/console.c:206:5
    #7 0x561149558e6b in timerlist_run_timers qemu/util/qemu-timer.c:574:9
    #8 0x5611495591de in qemu_clock_run_timers qemu/util/qemu-timer.c:588:12
    #9 0x56114955a489 in qemu_clock_run_all_timers qemu/util/qemu-timer.c:7=
08:25
    #10 0x56114955b235 in main_loop_wait qemu/util/main-loop.c:519:5
    #11 0x561147c587b3 in main_loop qemu/vl.c:1791:9
    #12 0x561147c4976d in main qemu/vl.c:4473:5
    #13 0x7f73ac5c4412 in __libc_start_main (/lib64/libc.so.6+0x24412)

Indirect leak of 8288 byte(s) in 259 object(s) allocated from:
    #0 0x561146f2c6af in __interceptor_malloc (x86_64-softmmu/qemu-system-x=
86_64+0x18246af)
    #1 0x7f73ac0385af  (/lib64/libfontconfig.so.1+0xd5af)

Indirect leak of 4068 byte(s) in 303 object(s) allocated from:
    #0 0x561146e78f40 in __interceptor_strdup (x86_64-softmmu/qemu-system-x=
86_64+0x1770f40)
    #1 0x7f73ac04bc44 in FcValueSave (/lib64/libfontconfig.so.1+0x20c44)

Indirect leak of 2336 byte(s) in 73 object(s) allocated from:
    #0 0x561146f2c8ef in calloc (x86_64-softmmu/qemu-system-x86_64+0x18248e=
f)
    #1 0x7f73ac04c9cc  (/lib64/libfontconfig.so.1+0x219cc)

Indirect leak of 1536 byte(s) in 48 object(s) allocated from:
    #0 0x561146f2c8ef in calloc (x86_64-softmmu/qemu-system-x86_64+0x18248e=
f)
    #1 0x7f73ac04bf0c  (/lib64/libfontconfig.so.1+0x20f0c)

Indirect leak of 1440 byte(s) in 5 object(s) allocated from:
    #0 0x561146f2c8ef in calloc (x86_64-softmmu/qemu-system-x86_64+0x18248e=
f)
    #1 0x7f73af3dde1d in g_malloc0 (/lib64/libglib-2.0.so.0+0x54e1d)
    #2 0x561148c6e3e7 in qemu_spice_create_update qemu/ui/spice-display.c:2=
43:13
    #3 0x561148c6ba2b in qemu_spice_display_refresh qemu/ui/spice-display.c=
:488:9
    #4 0x561148172eff in display_refresh qemu/hw/display/qxl.c:2030:9
    #5 0x561148c2748f in dpy_refresh qemu/ui/console.c:1629:13
    #6 0x561148c263f1 in gui_update qemu/ui/console.c:206:5
    #7 0x561149558e6b in timerlist_run_timers qemu/util/qemu-timer.c:574:9
    #8 0x5611495591de in qemu_clock_run_timers qemu/util/qemu-timer.c:588:12
    #9 0x56114955a489 in qemu_clock_run_all_timers qemu/util/qemu-timer.c:7=
08:25
    #10 0x56114955b235 in main_loop_wait qemu/util/main-loop.c:519:5
    #11 0x561147c587b3 in main_loop qemu/vl.c:1791:9
    #12 0x561147c4976d in main qemu/vl.c:4473:5
    #13 0x7f73ac5c4412 in __libc_start_main (/lib64/libc.so.6+0x24412)

Indirect leak of 1440 byte(s) in 5 object(s) allocated from:
    #0 0x561146f2c8ef in calloc (x86_64-softmmu/qemu-system-x86_64+0x18248e=
f)
    #1 0x7f73af3dde1d in g_malloc0 (/lib64/libglib-2.0.so.0+0x54e1d)
    #2 0x561148c6d547 in qemu_spice_create_update qemu/ui/spice-display.c:2=
22:21
    #3 0x561148c6ba2b in qemu_spice_display_refresh qemu/ui/spice-display.c=
:488:9
    #4 0x561148172eff in display_refresh qemu/hw/display/qxl.c:2030:9
    #5 0x561148c2748f in dpy_refresh qemu/ui/console.c:1629:13
    #6 0x561148c263f1 in gui_update qemu/ui/console.c:206:5
    #7 0x561149558e6b in timerlist_run_timers qemu/util/qemu-timer.c:574:9
    #8 0x5611495591de in qemu_clock_run_timers qemu/util/qemu-timer.c:588:12
    #9 0x56114955a489 in qemu_clock_run_all_timers qemu/util/qemu-timer.c:7=
08:25
    #10 0x56114955b235 in main_loop_wait qemu/util/main-loop.c:519:5
    #11 0x561147c587b3 in main_loop qemu/vl.c:1791:9
    #12 0x561147c4976d in main qemu/vl.c:4473:5
    #13 0x7f73ac5c4412 in __libc_start_main (/lib64/libc.so.6+0x24412)

Indirect leak of 384 byte(s) in 12 object(s) allocated from:
    #0 0x561146f2c8ef in calloc (x86_64-softmmu/qemu-system-x86_64+0x18248e=
f)
    #1 0x7f73ac04bd9e  (/lib64/libfontconfig.so.1+0x20d9e)

Indirect leak of 96 byte(s) in 2 object(s) allocated from:
    #0 0x561146f2c6af in __interceptor_malloc (x86_64-softmmu/qemu-system-x=
86_64+0x18246af)
    #1 0x7f73ac045e51 in FcLangSetCreate (/lib64/libfontconfig.so.1+0x1ae51)

SUMMARY: AddressSanitizer: 280628 byte(s) leaked in 1847 allocation(s).

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: spice

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1836762

Title:
  Many leaks from qemu_spice_create_update

Status in QEMU:
  New

Bug description:
  tag: v4.1.0-rc0

  Compiled with --enable-sanitizers

  $ qemu-system-x86_64 -device qxl-vga ...
  [guest exits calling 'hlt']
  =3D=3D20452=3D=3DERROR: LeakSanitizer: detected memory leaks

  Direct leak of 167616 byte(s) in 582 object(s) allocated from:
      #0 0x561146f2c8ef in calloc (x86_64-softmmu/qemu-system-x86_64+0x1824=
8ef)
      #1 0x7f73af3dde1d in g_malloc0 (/lib64/libglib-2.0.so.0+0x54e1d)
      #2 0x561148c6d547 in qemu_spice_create_update qemu/ui/spice-display.c=
:222:21
      #3 0x561148c6ba2b in qemu_spice_display_refresh qemu/ui/spice-display=
.c:488:9
      #4 0x561148172eff in display_refresh qemu/hw/display/qxl.c:2030:9
      #5 0x561148c2748f in dpy_refresh qemu/ui/console.c:1629:13
      #6 0x561148c263f1 in gui_update qemu/ui/console.c:206:5
      #7 0x561149558e6b in timerlist_run_timers qemu/util/qemu-timer.c:574:9
      #8 0x5611495591de in qemu_clock_run_timers qemu/util/qemu-timer.c:588=
:12
      #9 0x56114955a489 in qemu_clock_run_all_timers qemu/util/qemu-timer.c=
:708:25
      #10 0x56114955b235 in main_loop_wait qemu/util/main-loop.c:519:5
      #11 0x561147c587b3 in main_loop qemu/vl.c:1791:9
      #12 0x561147c4976d in main qemu/vl.c:4473:5
      #13 0x7f73ac5c4412 in __libc_start_main (/lib64/libc.so.6+0x24412)

  Direct leak of 5184 byte(s) in 18 object(s) allocated from:
      #0 0x561146f2c8ef in calloc (x86_64-softmmu/qemu-system-x86_64+0x1824=
8ef)
      #1 0x7f73af3dde1d in g_malloc0 (/lib64/libglib-2.0.so.0+0x54e1d)
      #2 0x561148c6e3e7 in qemu_spice_create_update qemu/ui/spice-display.c=
:243:13
      #3 0x561148c6ba2b in qemu_spice_display_refresh qemu/ui/spice-display=
.c:488:9
      #4 0x561148172eff in display_refresh qemu/hw/display/qxl.c:2030:9
      #5 0x561148c2748f in dpy_refresh qemu/ui/console.c:1629:13
      #6 0x561148c263f1 in gui_update qemu/ui/console.c:206:5
      #7 0x561149558e6b in timerlist_run_timers qemu/util/qemu-timer.c:574:9
      #8 0x5611495591de in qemu_clock_run_timers qemu/util/qemu-timer.c:588=
:12
      #9 0x56114955a489 in qemu_clock_run_all_timers qemu/util/qemu-timer.c=
:708:25
      #10 0x56114955b235 in main_loop_wait qemu/util/main-loop.c:519:5
      #11 0x561147c587b3 in main_loop qemu/vl.c:1791:9
      #12 0x561147c4976d in main qemu/vl.c:4473:5
      #13 0x7f73ac5c4412 in __libc_start_main (/lib64/libc.so.6+0x24412)

  Direct leak of 2560 byte(s) in 4 object(s) allocated from:
      #0 0x561146f2cb46 in realloc (x86_64-softmmu/qemu-system-x86_64+0x182=
4b46)
      #1 0x7f73ac04c420  (/lib64/libfontconfig.so.1+0x21420)

  Direct leak of 22 byte(s) in 1 object(s) allocated from:
      #0 0x561146f2c6af in __interceptor_malloc (x86_64-softmmu/qemu-system=
-x86_64+0x18246af)
      #1 0x7f73ae781953 in XGetAtomName (/lib64/libX11.so.6+0x2a953)

  Indirect leak of 54936 byte(s) in 510 object(s) allocated from:
      #0 0x561146f2c6af in __interceptor_malloc (x86_64-softmmu/qemu-system=
-x86_64+0x18246af)
      #1 0x7f73af3dddc5 in g_malloc (/lib64/libglib-2.0.so.0+0x54dc5)
      #2 0x561148c6d547 in qemu_spice_create_update qemu/ui/spice-display.c=
:222:21
      #3 0x561148c6ba2b in qemu_spice_display_refresh qemu/ui/spice-display=
.c:488:9
      #4 0x561148172eff in display_refresh qemu/hw/display/qxl.c:2030:9
      #5 0x561148c2748f in dpy_refresh qemu/ui/console.c:1629:13
      #6 0x561148c263f1 in gui_update qemu/ui/console.c:206:5
      #7 0x561149558e6b in timerlist_run_timers qemu/util/qemu-timer.c:574:9
      #8 0x5611495591de in qemu_clock_run_timers qemu/util/qemu-timer.c:588=
:12
      #9 0x56114955a489 in qemu_clock_run_all_timers qemu/util/qemu-timer.c=
:708:25
      #10 0x56114955b235 in main_loop_wait qemu/util/main-loop.c:519:5
      #11 0x561147c587b3 in main_loop qemu/vl.c:1791:9
      #12 0x561147c4976d in main qemu/vl.c:4473:5
      #13 0x7f73ac5c4412 in __libc_start_main (/lib64/libc.so.6+0x24412)

  Indirect leak of 30720 byte(s) in 23 object(s) allocated from:
      #0 0x561146f2c6af in __interceptor_malloc (x86_64-softmmu/qemu-system=
-x86_64+0x18246af)
      #1 0x7f73af3dddc5 in g_malloc (/lib64/libglib-2.0.so.0+0x54dc5)
      #2 0x561148c6e3e7 in qemu_spice_create_update qemu/ui/spice-display.c=
:243:13
      #3 0x561148c6ba2b in qemu_spice_display_refresh qemu/ui/spice-display=
.c:488:9
      #4 0x561148172eff in display_refresh qemu/hw/display/qxl.c:2030:9
      #5 0x561148c2748f in dpy_refresh qemu/ui/console.c:1629:13
      #6 0x561148c263f1 in gui_update qemu/ui/console.c:206:5
      #7 0x561149558e6b in timerlist_run_timers qemu/util/qemu-timer.c:574:9
      #8 0x5611495591de in qemu_clock_run_timers qemu/util/qemu-timer.c:588=
:12
      #9 0x56114955a489 in qemu_clock_run_all_timers qemu/util/qemu-timer.c=
:708:25
      #10 0x56114955b235 in main_loop_wait qemu/util/main-loop.c:519:5
      #11 0x561147c587b3 in main_loop qemu/vl.c:1791:9
      #12 0x561147c4976d in main qemu/vl.c:4473:5
      #13 0x7f73ac5c4412 in __libc_start_main (/lib64/libc.so.6+0x24412)

  Indirect leak of 8288 byte(s) in 259 object(s) allocated from:
      #0 0x561146f2c6af in __interceptor_malloc (x86_64-softmmu/qemu-system=
-x86_64+0x18246af)
      #1 0x7f73ac0385af  (/lib64/libfontconfig.so.1+0xd5af)

  Indirect leak of 4068 byte(s) in 303 object(s) allocated from:
      #0 0x561146e78f40 in __interceptor_strdup (x86_64-softmmu/qemu-system=
-x86_64+0x1770f40)
      #1 0x7f73ac04bc44 in FcValueSave (/lib64/libfontconfig.so.1+0x20c44)

  Indirect leak of 2336 byte(s) in 73 object(s) allocated from:
      #0 0x561146f2c8ef in calloc (x86_64-softmmu/qemu-system-x86_64+0x1824=
8ef)
      #1 0x7f73ac04c9cc  (/lib64/libfontconfig.so.1+0x219cc)

  Indirect leak of 1536 byte(s) in 48 object(s) allocated from:
      #0 0x561146f2c8ef in calloc (x86_64-softmmu/qemu-system-x86_64+0x1824=
8ef)
      #1 0x7f73ac04bf0c  (/lib64/libfontconfig.so.1+0x20f0c)

  Indirect leak of 1440 byte(s) in 5 object(s) allocated from:
      #0 0x561146f2c8ef in calloc (x86_64-softmmu/qemu-system-x86_64+0x1824=
8ef)
      #1 0x7f73af3dde1d in g_malloc0 (/lib64/libglib-2.0.so.0+0x54e1d)
      #2 0x561148c6e3e7 in qemu_spice_create_update qemu/ui/spice-display.c=
:243:13
      #3 0x561148c6ba2b in qemu_spice_display_refresh qemu/ui/spice-display=
.c:488:9
      #4 0x561148172eff in display_refresh qemu/hw/display/qxl.c:2030:9
      #5 0x561148c2748f in dpy_refresh qemu/ui/console.c:1629:13
      #6 0x561148c263f1 in gui_update qemu/ui/console.c:206:5
      #7 0x561149558e6b in timerlist_run_timers qemu/util/qemu-timer.c:574:9
      #8 0x5611495591de in qemu_clock_run_timers qemu/util/qemu-timer.c:588=
:12
      #9 0x56114955a489 in qemu_clock_run_all_timers qemu/util/qemu-timer.c=
:708:25
      #10 0x56114955b235 in main_loop_wait qemu/util/main-loop.c:519:5
      #11 0x561147c587b3 in main_loop qemu/vl.c:1791:9
      #12 0x561147c4976d in main qemu/vl.c:4473:5
      #13 0x7f73ac5c4412 in __libc_start_main (/lib64/libc.so.6+0x24412)

  Indirect leak of 1440 byte(s) in 5 object(s) allocated from:
      #0 0x561146f2c8ef in calloc (x86_64-softmmu/qemu-system-x86_64+0x1824=
8ef)
      #1 0x7f73af3dde1d in g_malloc0 (/lib64/libglib-2.0.so.0+0x54e1d)
      #2 0x561148c6d547 in qemu_spice_create_update qemu/ui/spice-display.c=
:222:21
      #3 0x561148c6ba2b in qemu_spice_display_refresh qemu/ui/spice-display=
.c:488:9
      #4 0x561148172eff in display_refresh qemu/hw/display/qxl.c:2030:9
      #5 0x561148c2748f in dpy_refresh qemu/ui/console.c:1629:13
      #6 0x561148c263f1 in gui_update qemu/ui/console.c:206:5
      #7 0x561149558e6b in timerlist_run_timers qemu/util/qemu-timer.c:574:9
      #8 0x5611495591de in qemu_clock_run_timers qemu/util/qemu-timer.c:588=
:12
      #9 0x56114955a489 in qemu_clock_run_all_timers qemu/util/qemu-timer.c=
:708:25
      #10 0x56114955b235 in main_loop_wait qemu/util/main-loop.c:519:5
      #11 0x561147c587b3 in main_loop qemu/vl.c:1791:9
      #12 0x561147c4976d in main qemu/vl.c:4473:5
      #13 0x7f73ac5c4412 in __libc_start_main (/lib64/libc.so.6+0x24412)

  Indirect leak of 384 byte(s) in 12 object(s) allocated from:
      #0 0x561146f2c8ef in calloc (x86_64-softmmu/qemu-system-x86_64+0x1824=
8ef)
      #1 0x7f73ac04bd9e  (/lib64/libfontconfig.so.1+0x20d9e)

  Indirect leak of 96 byte(s) in 2 object(s) allocated from:
      #0 0x561146f2c6af in __interceptor_malloc (x86_64-softmmu/qemu-system=
-x86_64+0x18246af)
      #1 0x7f73ac045e51 in FcLangSetCreate (/lib64/libfontconfig.so.1+0x1ae=
51)

  SUMMARY: AddressSanitizer: 280628 byte(s) leaked in 1847
  allocation(s).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1836762/+subscriptions

