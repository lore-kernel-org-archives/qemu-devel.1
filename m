Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E97C04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 14:26:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42F9F20867
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 14:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42F9F20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCPIa-0005l0-D9
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 10:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38323)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iCPHn-00052H-8j
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:25:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iCPHl-0004e3-3a
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:25:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:52648)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iCPHk-0004cU-U2
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:25:53 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iCPHi-0000Rk-Tn
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 14:25:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id DEED62E80C9
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 14:25:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Sep 2019 14:17:36 -0000
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: nsz
X-Launchpad-Bug-Reporter: Szabolcs Nagy (nsz)
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
X-Launchpad-Bug-Duplicate: 1749393
References: <154894897582.27692.3144790006245349699.malonedeb@soybean.canonical.com>
Message-Id: <156924825750.14041.10839508127725341852.launchpad@gac.canonical.com>
Subject: [Bug 1814128] Re: qemu-user fails to set up a reasonable brk for
 static-pie
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19048";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 1923de7f93f9eca5d9d724f78960ea6412b4dbd1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
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
Reply-To: Bug 1814128 <1814128@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

*** This bug is a duplicate of bug 1749393 ***
    https://bugs.launchpad.net/bugs/1749393

** This bug has been marked a duplicate of bug 1749393
   sbrk() not working under qemu-user with a PIE-compiled binary?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1814128

Title:
  qemu-user fails to set up a reasonable brk for static-pie

Status in QEMU:
  New

Bug description:
  static pie binaries may not get a reasonable brk,
  with glibc this means they crash in early tls setup code:
  https://sourceware.org/bugzilla/show_bug.cgi?id=3D24152

  qemu seems to put brk at the end of the data segment,
  but if the stack starts (ends) right next to it then
  allocation with brk fails.

  in such situation i think qemu should arrange the
  stack or brk to be elsewhere so there is plenty
  space to grow (in case of glibc it's enough if tls
  setup works: later allocations can fall back to mmap).

  (ubuntu bionic x86_64 ldconfig.real from libc-bin package)
  $ qemu-x86_64 -strace -d page /sbin/ldconfig.real
  host mmap_min_addr=3D0x8000
  guest_base  0x0
  start            end              size             prot
  0000004000000000-00000040000f2000 00000000000f2000 r-x
  00000040000f2000-00000040002f2000 0000000000200000 ---
  00000040002f2000-00000040002fa000 0000000000008000 rw-
  00000040002fa000-00000040002fb000 0000000000001000 ---
  00000040002fb000-0000004000afb000 0000000000800000 rw-
  start_brk   0x0000000000000000
  end_code    0x00000040000f1ee8
  start_code  0x0000004000000000
  start_data  0x00000040002f2838
  end_data    0x00000040002f8518
  start_stack 0x0000004000afa130
  brk         0x00000040002f9dd8
  entry       0x0000004000009bc0
  argv_start  0x0000004000afa138
  env_start   0x0000004000afa148
  auxv_start  0x0000004000afa280
  28561 brk(NULL) =3D 0x00000040002fa000
  28561 brk(0x00000040002fb1c0) =3D 0x00000040002fa000
  --- SIGSEGV {si_signo=3DSIGSEGV, si_code=3D1, si_addr=3D0xffffffffffffffc=
0} ---
  qemu: uncaught target signal 11 (Segmentation fault) - core dumped

  $ readelf -hldSW /tmp/ldconfig.real
  ELF Header:
    Magic:   7f 45 4c 46 02 01 01 03 00 00 00 00 00 00 00 00 =

    Class:                             ELF64
    Data:                              2's complement, little endian
    Version:                           1 (current)
    OS/ABI:                            UNIX - GNU
    ABI Version:                       0
    Type:                              DYN (Shared object file)
    Machine:                           Advanced Micro Devices X86-64
    Version:                           0x1
    Entry point address:               0x9bc0
    Start of program headers:          64 (bytes into file)
    Start of section headers:          1022920 (bytes into file)
    Flags:                             0x0
    Size of this header:               64 (bytes)
    Size of program headers:           56 (bytes)
    Number of program headers:         8
    Size of section headers:           64 (bytes)
    Number of section headers:         38
    Section header string table index: 37

  Section Headers:
    [Nr] Name              Type            Address          Off    Size   E=
S Flg Lk Inf Al
    [ 0]                   NULL            0000000000000000 000000 000000 0=
0      0   0  0
    [ 1] .note.ABI-tag     NOTE            0000000000000200 000200 000020 0=
0   A  0   0  4
    [ 2] .note.gnu.build-id NOTE            0000000000000220 000220 000024 =
00   A  0   0  4
    [ 3] .gnu.hash         GNU_HASH        0000000000000248 000248 00001c 0=
0   A  4   0  8
    [ 4] .dynsym           DYNSYM          0000000000000268 000268 000018 1=
8   A  5   1  8
    [ 5] .dynstr           STRTAB          0000000000000280 000280 000001 0=
0   A  0   0  1
    [ 6] .rela.dyn         RELA            0000000000000288 000288 008748 1=
8   A  4   0  8
    [ 7] .rela.plt         RELA            00000000000089d0 0089d0 000318 1=
8  AI  4  27  8
    [ 8] .init             PROGBITS        0000000000008ce8 008ce8 000017 0=
0  AX  0   0  4
    [ 9] .plt              PROGBITS        0000000000008d00 008d00 000270 1=
0  AX  0   0 16
    [10] .plt.got          PROGBITS        0000000000008f70 008f70 000060 0=
8  AX  0   0  8
    [11] .text             PROGBITS        0000000000008fd0 008fd0 0bd29c 0=
0  AX  0   0 16
    [12] __libc_freeres_fn PROGBITS        00000000000c6270 0c6270 0016b3 0=
0  AX  0   0 16
    [13] __libc_thread_freeres_fn PROGBITS        00000000000c7930 0c7930 0=
0108f 00  AX  0   0 16
    [14] .fini             PROGBITS        00000000000c89c0 0c89c0 000009 0=
0  AX  0   0  4
    [15] .rodata           PROGBITS        00000000000c89e0 0c89e0 01af08 0=
0   A  0   0 32
    [16] .stapsdt.base     PROGBITS        00000000000e38e8 0e38e8 000001 0=
0   A  0   0  1
    [17] .eh_frame_hdr     PROGBITS        00000000000e38ec 0e38ec 001f94 0=
0   A  0   0  4
    [18] .eh_frame         PROGBITS        00000000000e5880 0e5880 00c5b8 0=
0   A  0   0  8
    [19] .gcc_except_table PROGBITS        00000000000f1e38 0f1e38 0000b0 0=
0   A  0   0  1
    [20] .tdata            PROGBITS        00000000002f2838 0f2838 000028 0=
0 WAT  0   0  8
    [21] .tbss             NOBITS          00000000002f2860 0f2860 000040 0=
0 WAT  0   0  8
    [22] .init_array       INIT_ARRAY      00000000002f2860 0f2860 000010 0=
8  WA  0   0  8
    [23] .fini_array       FINI_ARRAY      00000000002f2870 0f2870 000010 0=
8  WA  0   0  8
    [24] .data.rel.ro      PROGBITS        00000000002f2880 0f2880 0034c4 0=
0  WA  0   0 32
    [25] .dynamic          DYNAMIC         00000000002f5d48 0f5d48 0001a0 1=
0  WA  5   0  8
    [26] .got              PROGBITS        00000000002f5ee8 0f5ee8 000110 0=
8  WA  0   0  8
    [27] .got.plt          PROGBITS        00000000002f6000 0f6000 000148 0=
8  WA  0   0  8
    [28] .data             PROGBITS        00000000002f6160 0f6160 001bd4 0=
0  WA  0   0 32
    [29] __libc_subfreeres PROGBITS        00000000002f7d38 0f7d38 000060 0=
0  WA  0   0  8
    [30] __libc_IO_vtables PROGBITS        00000000002f7da0 0f7da0 000768 0=
0  WA  0   0 32
    [31] __libc_atexit     PROGBITS        00000000002f8508 0f8508 000008 0=
0  WA  0   0  8
    [32] __libc_thread_subfreeres PROGBITS        00000000002f8510 0f8510 0=
00008 00  WA  0   0  8
    [33] .bss              NOBITS          00000000002f8520 0f8518 001890 0=
0  WA  0   0 32
    [34] __libc_freeres_ptrs NOBITS          00000000002f9db0 0f8518 000028=
 00  WA  0   0  8
    [35] .note.stapsdt     NOTE            0000000000000000 0f8518 0014cc 0=
0      0   0  4
    [36] .gnu_debuglink    PROGBITS        0000000000000000 0f99e4 000034 0=
0      0   0  4
    [37] .shstrtab         STRTAB          0000000000000000 0f9a18 0001ab 0=
0      0   0  1
  Key to Flags:
    W (write), A (alloc), X (execute), M (merge), S (strings), I (info),
    L (link order), O (extra OS processing required), G (group), T (TLS),
    C (compressed), x (unknown), o (OS specific), E (exclude),
    l (large), p (processor specific)

  Program Headers:
    Type           Offset   VirtAddr           PhysAddr           FileSiz  =
MemSiz   Flg Align
    LOAD           0x000000 0x0000000000000000 0x0000000000000000 0x0f1ee8 =
0x0f1ee8 R E 0x200000
    LOAD           0x0f2838 0x00000000002f2838 0x00000000002f2838 0x005ce0 =
0x0075a0 RW  0x200000
    DYNAMIC        0x0f5d48 0x00000000002f5d48 0x00000000002f5d48 0x0001a0 =
0x0001a0 RW  0x8
    NOTE           0x000200 0x0000000000000200 0x0000000000000200 0x000044 =
0x000044 R   0x4
    TLS            0x0f2838 0x00000000002f2838 0x00000000002f2838 0x000028 =
0x000068 R   0x8
    GNU_EH_FRAME   0x0e38ec 0x00000000000e38ec 0x00000000000e38ec 0x001f94 =
0x001f94 R   0x4
    GNU_STACK      0x000000 0x0000000000000000 0x0000000000000000 0x000000 =
0x000000 RW  0x10
    GNU_RELRO      0x0f2838 0x00000000002f2838 0x00000000002f2838 0x0037c8 =
0x0037c8 R   0x1

   Section to Segment mapping:
    Segment Sections...
     00     .note.ABI-tag .note.gnu.build-id .gnu.hash .dynsym .dynstr .rel=
a.dyn .rela.plt .init .plt .plt.got .text __libc_freeres_fn __libc_thread_f=
reeres_fn .fini .rodata .stapsdt.base .eh_frame_hdr .eh_frame .gcc_except_t=
able =

     01     .tdata .init_array .fini_array .data.rel.ro .dynamic .got .got.=
plt .data __libc_subfreeres __libc_IO_vtables __libc_atexit __libc_thread_s=
ubfreeres .bss __libc_freeres_ptrs =

     02     .dynamic =

     03     .note.ABI-tag .note.gnu.build-id =

     04     .tdata .tbss =

     05     .eh_frame_hdr =

     06     =

     07     .tdata .init_array .fini_array .data.rel.ro .dynamic .got =


  Dynamic section at offset 0xf5d48 contains 22 entries:
    Tag        Type                         Name/Value
   0x000000000000000c (INIT)               0x8ce8
   0x000000000000000d (FINI)               0xc89c0
   0x0000000000000019 (INIT_ARRAY)         0x2f2860
   0x000000000000001b (INIT_ARRAYSZ)       16 (bytes)
   0x000000000000001a (FINI_ARRAY)         0x2f2870
   0x000000000000001c (FINI_ARRAYSZ)       16 (bytes)
   0x000000006ffffef5 (GNU_HASH)           0x248
   0x0000000000000005 (STRTAB)             0x280
   0x0000000000000006 (SYMTAB)             0x268
   0x000000000000000a (STRSZ)              1 (bytes)
   0x000000000000000b (SYMENT)             24 (bytes)
   0x0000000000000015 (DEBUG)              0x0
   0x0000000000000003 (PLTGOT)             0x2f6000
   0x0000000000000002 (PLTRELSZ)           792 (bytes)
   0x0000000000000014 (PLTREL)             RELA
   0x0000000000000017 (JMPREL)             0x89d0
   0x0000000000000007 (RELA)               0x288
   0x0000000000000008 (RELASZ)             34632 (bytes)
   0x0000000000000009 (RELAENT)            24 (bytes)
   0x000000006ffffffb (FLAGS_1)            Flags: PIE
   0x000000006ffffff9 (RELACOUNT)          1443
   0x0000000000000000 (NULL)               0x0

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1814128/+subscriptions

