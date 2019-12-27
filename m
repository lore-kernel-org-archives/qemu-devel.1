Return-Path: <SRS0=GTQb=2R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12D9C2D0C0
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2019 03:16:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 641CA20828
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2019 03:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 641CA20828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ikg7L-00043F-DB
	for qemu-devel@archiver.kernel.org; Thu, 26 Dec 2019 22:16:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36477)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1ikg6L-0003A5-M5
 for qemu-devel@nongnu.org; Thu, 26 Dec 2019 22:15:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1ikg6J-0003wq-D9
 for qemu-devel@nongnu.org; Thu, 26 Dec 2019 22:15:45 -0500
Received: from indium.canonical.com ([91.189.90.7]:54754)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1ikg6J-0003w2-4Y
 for qemu-devel@nongnu.org; Thu, 26 Dec 2019 22:15:43 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1ikg6I-0006JS-8H
 for <qemu-devel@nongnu.org>; Fri, 27 Dec 2019 03:15:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 3C5222E807B
 for <qemu-devel@nongnu.org>; Fri, 27 Dec 2019 03:15:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Dec 2019 03:08:03 -0000
From: Marek Dolata <1686170@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: duanev miki4242 mkdolata vvaltchev
X-Launchpad-Bug-Reporter: Alain Kalker (miki4242)
X-Launchpad-Bug-Modifier: Marek Dolata (mkdolata)
References: <20170425183112.19801.4371.malonedeb@soybean.canonical.com>
Message-Id: <157741608402.15141.5690559276601204396.malone@wampee.canonical.com>
Subject: [Bug 1686170] Re: qemu-system-x86_64+gdb: unable to correctly
 disassemble "real mode" (i8086) instructions after attaching to QEMU started
 with "-S -s" options
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="bceb5ef013b87ef7aafe0755545ceb689ca7ac60";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: e13854666182c47fff74177b3c97e538dc1eebf2
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Reply-To: Bug 1686170 <1686170@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I had the same issue.  My workaround is to force the target description
to be loaded from a local xml file where the architecture tag is i8086.
I took the one that was sent over the network from the server to the
client and changed the architecture tag from i386 to i8086 and also the
size of the i386_efer flags from 8 to 4.

$ gdb -q
(gdb) set tdesc filename ./target.xml
(gdb) target remote :29096
...
(gdb) x/i 0x10*$cs+$pc
   0xffff0:     ljmp   $0xf000,$0xe05b
(gdb) quit

$ cat target.xml
<?xml version=3D"1.0"?>

<!-- Copyright (C) 2010-2017 Free Software Foundation, Inc.

     Copying and distribution of this file, with or without modification,
     are permitted in any medium without royalty provided the copyright
     notice and this notice are preserved.  -->

<!-- I386 with SSE -->

<!DOCTYPE target SYSTEM "gdb-target.dtd">
<target>
<architecture>i8086</architecture>
<feature name=3D"org.gnu.gdb.i386.core">
  <flags id=3D"i386_eflags" size=3D"4">
	<field name=3D"" start=3D"22" end=3D"31"/>
	<field name=3D"ID" start=3D"21" end=3D"21"/>
	<field name=3D"VIP" start=3D"20" end=3D"20"/>
	<field name=3D"VIF" start=3D"19" end=3D"19"/>
	<field name=3D"AC" start=3D"18" end=3D"18"/>
	<field name=3D"VM" start=3D"17" end=3D"17"/>
	<field name=3D"RF" start=3D"16" end=3D"16"/>
	<field name=3D"" start=3D"15" end=3D"15"/>
	<field name=3D"NT" start=3D"14" end=3D"14"/>
	<field name=3D"IOPL" start=3D"12" end=3D"13"/>
	<field name=3D"OF" start=3D"11" end=3D"11"/>
	<field name=3D"DF" start=3D"10" end=3D"10"/>
	<field name=3D"IF" start=3D"9" end=3D"9"/>
	<field name=3D"TF" start=3D"8" end=3D"8"/>
	<field name=3D"SF" start=3D"7" end=3D"7"/>
	<field name=3D"ZF" start=3D"6" end=3D"6"/>
	<field name=3D"" start=3D"5" end=3D"5"/>
	<field name=3D"AF" start=3D"4" end=3D"4"/>
	<field name=3D"" start=3D"3" end=3D"3"/>
	<field name=3D"PF" start=3D"2" end=3D"2"/>
	<field name=3D"" start=3D"1" end=3D"1"/>
	<field name=3D"CF" start=3D"0" end=3D"0"/>
  </flags>

  <reg name=3D"eax" bitsize=3D"32" type=3D"int32" regnum=3D"0"/>
  <reg name=3D"ecx" bitsize=3D"32" type=3D"int32"/>
  <reg name=3D"edx" bitsize=3D"32" type=3D"int32"/>
  <reg name=3D"ebx" bitsize=3D"32" type=3D"int32"/>
  <reg name=3D"esp" bitsize=3D"32" type=3D"data_ptr"/>
  <reg name=3D"ebp" bitsize=3D"32" type=3D"data_ptr"/>
  <reg name=3D"esi" bitsize=3D"32" type=3D"int32"/>
  <reg name=3D"edi" bitsize=3D"32" type=3D"int32"/>

  <reg name=3D"eip" bitsize=3D"32" type=3D"code_ptr"/>
  <reg name=3D"eflags" bitsize=3D"32" type=3D"i386_eflags"/>

  <reg name=3D"cs" bitsize=3D"32" type=3D"int32"/>
  <reg name=3D"ss" bitsize=3D"32" type=3D"int32"/>
  <reg name=3D"ds" bitsize=3D"32" type=3D"int32"/>
  <reg name=3D"es" bitsize=3D"32" type=3D"int32"/>
  <reg name=3D"fs" bitsize=3D"32" type=3D"int32"/>
  <reg name=3D"gs" bitsize=3D"32" type=3D"int32"/>

  <!--reg name=3D"cs_base" bitsize=3D"32" type=3D"int32"/>
  <reg name=3D"ss_base" bitsize=3D"32" type=3D"int32"/>
  <reg name=3D"ds_base" bitsize=3D"32" type=3D"int32"/>
  <reg name=3D"es_base" bitsize=3D"32" type=3D"int32"/-->
  <reg name=3D"fs_base" bitsize=3D"32" type=3D"int32"/>
  <reg name=3D"gs_base" bitsize=3D"32" type=3D"int32"/>
  <reg name=3D"k_gs_base" bitsize=3D"32" type=3D"int32"/>

  <flags id=3D"i386_cr0" size=3D"4">
	<field name=3D"PG" start=3D"31" end=3D"31"/>
	<field name=3D"CD" start=3D"30" end=3D"30"/>
	<field name=3D"NW" start=3D"29" end=3D"29"/>
	<field name=3D"AM" start=3D"18" end=3D"18"/>
	<field name=3D"WP" start=3D"16" end=3D"16"/>
	<field name=3D"NE" start=3D"5" end=3D"5"/>
	<field name=3D"ET" start=3D"4" end=3D"4"/>
	<field name=3D"TS" start=3D"3" end=3D"3"/>
	<field name=3D"EM" start=3D"2" end=3D"2"/>
	<field name=3D"MP" start=3D"1" end=3D"1"/>
	<field name=3D"PE" start=3D"0" end=3D"0"/>
  </flags>

  <flags id=3D"i386_cr3" size=3D"4">
	<field name=3D"PDBR" start=3D"12" end=3D"31"/>
	<!--field name=3D"" start=3D"3" end=3D"11"/>
	<field name=3D"WT" start=3D"2" end=3D"2"/>
	<field name=3D"CD" start=3D"1" end=3D"1"/>
	<field name=3D"" start=3D"0" end=3D"0"/-->
	<field name=3D"PCID" start=3D"0" end=3D"11"/>
  </flags>

  <flags id=3D"i386_cr4" size=3D"4">
	<field name=3D"VME" start=3D"0" end=3D"0"/>
	<field name=3D"PVI" start=3D"1" end=3D"1"/>
	<field name=3D"TSD" start=3D"2" end=3D"2"/>
	<field name=3D"DE" start=3D"3" end=3D"3"/>
	<field name=3D"PSE" start=3D"4" end=3D"4"/>
	<field name=3D"PAE" start=3D"5" end=3D"5"/>
	<field name=3D"MCE" start=3D"6" end=3D"6"/>
	<field name=3D"PGE" start=3D"7" end=3D"7"/>
	<field name=3D"PCE" start=3D"8" end=3D"8"/>
	<field name=3D"OSFXSR" start=3D"9" end=3D"9"/>
	<field name=3D"OSXMMEXCPT" start=3D"10" end=3D"10"/>
	<field name=3D"UMIP" start=3D"11" end=3D"11"/>
	<field name=3D"LA57" start=3D"12" end=3D"12"/>
	<field name=3D"VMXE" start=3D"13" end=3D"13"/>
	<field name=3D"SMXE" start=3D"14" end=3D"14"/>
	<field name=3D"FSGSBASE" start=3D"16" end=3D"16"/>
	<field name=3D"PCIDE" start=3D"17" end=3D"17"/>
	<field name=3D"OSXSAVE" start=3D"18" end=3D"18"/>
	<field name=3D"SMEP" start=3D"20" end=3D"20"/>
	<field name=3D"SMAP" start=3D"21" end=3D"21"/>
	<field name=3D"PKE" start=3D"22" end=3D"22"/>
  </flags>

  <flags id=3D"i386_efer" size=3D"4">
	<field name=3D"TCE" start=3D"15" end=3D"15"/>
	<field name=3D"FFXSR" start=3D"14" end=3D"14"/>
	<field name=3D"LMSLE" start=3D"13" end=3D"13"/>
	<field name=3D"SVME" start=3D"12" end=3D"12"/>
	<field name=3D"NXE" start=3D"11" end=3D"11"/>
	<field name=3D"LMA" start=3D"10" end=3D"10"/>
	<field name=3D"LME" start=3D"8" end=3D"8"/>
	<field name=3D"SCE" start=3D"0" end=3D"0"/>
  </flags>

  <reg name=3D"cr0" bitsize=3D"32" type=3D"i386_cr0"/>
  <reg name=3D"cr2" bitsize=3D"32" type=3D"int32"/>
  <reg name=3D"cr3" bitsize=3D"32" type=3D"i386_cr3"/>
  <reg name=3D"cr4" bitsize=3D"32" type=3D"i386_cr4"/>
  <reg name=3D"cr8" bitsize=3D"32" type=3D"int32"/>
  <reg name=3D"efer" bitsize=3D"32" type=3D"i386_efer"/>

  <reg name=3D"st0" bitsize=3D"80" type=3D"i387_ext"/>
  <reg name=3D"st1" bitsize=3D"80" type=3D"i387_ext"/>
  <reg name=3D"st2" bitsize=3D"80" type=3D"i387_ext"/>
  <reg name=3D"st3" bitsize=3D"80" type=3D"i387_ext"/>
  <reg name=3D"st4" bitsize=3D"80" type=3D"i387_ext"/>
  <reg name=3D"st5" bitsize=3D"80" type=3D"i387_ext"/>
  <reg name=3D"st6" bitsize=3D"80" type=3D"i387_ext"/>
  <reg name=3D"st7" bitsize=3D"80" type=3D"i387_ext"/>

  <reg name=3D"fctrl" bitsize=3D"32" type=3D"int" group=3D"float"/>
  <reg name=3D"fstat" bitsize=3D"32" type=3D"int" group=3D"float"/>
  <reg name=3D"ftag" bitsize=3D"32" type=3D"int" group=3D"float"/>
  <reg name=3D"fiseg" bitsize=3D"32" type=3D"int" group=3D"float"/>
  <reg name=3D"fioff" bitsize=3D"32" type=3D"int" group=3D"float"/>
  <reg name=3D"foseg" bitsize=3D"32" type=3D"int" group=3D"float"/>
  <reg name=3D"fooff" bitsize=3D"32" type=3D"int" group=3D"float"/>
  <reg name=3D"fop" bitsize=3D"32" type=3D"int" group=3D"float"/>
<!--/feature>
<feature name=3D"org.gnu.gdb.i386.32bit.sse"-->
  <vector id=3D"v4f" type=3D"ieee_single" count=3D"4"/>
  <vector id=3D"v2d" type=3D"ieee_double" count=3D"2"/>
  <vector id=3D"v16i8" type=3D"int8" count=3D"16"/>
  <vector id=3D"v8i16" type=3D"int16" count=3D"8"/>
  <vector id=3D"v4i32" type=3D"int32" count=3D"4"/>
  <vector id=3D"v2i64" type=3D"int64" count=3D"2"/>
  <union id=3D"vec128">
	<field name=3D"v4_float" type=3D"v4f"/>
	<field name=3D"v2_double" type=3D"v2d"/>
	<field name=3D"v16_int8" type=3D"v16i8"/>
	<field name=3D"v8_int16" type=3D"v8i16"/>
	<field name=3D"v4_int32" type=3D"v4i32"/>
	<field name=3D"v2_int64" type=3D"v2i64"/>
	<field name=3D"uint128" type=3D"uint128"/>
  </union>
  <flags id=3D"i386_mxcsr" size=3D"4">
	<field name=3D"IE" start=3D"0" end=3D"0"/>
	<field name=3D"DE" start=3D"1" end=3D"1"/>
	<field name=3D"ZE" start=3D"2" end=3D"2"/>
	<field name=3D"OE" start=3D"3" end=3D"3"/>
	<field name=3D"UE" start=3D"4" end=3D"4"/>
	<field name=3D"PE" start=3D"5" end=3D"5"/>
	<field name=3D"DAZ" start=3D"6" end=3D"6"/>
	<field name=3D"IM" start=3D"7" end=3D"7"/>
	<field name=3D"DM" start=3D"8" end=3D"8"/>
	<field name=3D"ZM" start=3D"9" end=3D"9"/>
	<field name=3D"OM" start=3D"10" end=3D"10"/>
	<field name=3D"UM" start=3D"11" end=3D"11"/>
	<field name=3D"PM" start=3D"12" end=3D"12"/>
	<field name=3D"FZ" start=3D"15" end=3D"15"/>
  </flags>

  <reg name=3D"xmm0" bitsize=3D"128" type=3D"vec128"/>
  <reg name=3D"xmm1" bitsize=3D"128" type=3D"vec128"/>
  <reg name=3D"xmm2" bitsize=3D"128" type=3D"vec128"/>
  <reg name=3D"xmm3" bitsize=3D"128" type=3D"vec128"/>
  <reg name=3D"xmm4" bitsize=3D"128" type=3D"vec128"/>
  <reg name=3D"xmm5" bitsize=3D"128" type=3D"vec128"/>
  <reg name=3D"xmm6" bitsize=3D"128" type=3D"vec128"/>
  <reg name=3D"xmm7" bitsize=3D"128" type=3D"vec128"/>

  <reg name=3D"mxcsr" bitsize=3D"32" type=3D"i386_mxcsr" group=3D"vector"/>
</feature>
</target>

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1686170

Title:
  qemu-system-x86_64+gdb: unable to correctly disassemble "real mode"
  (i8086) instructions after attaching to QEMU started with "-S -s"
  options

Status in QEMU:
  New

Bug description:
  OS: Void Linux x86_64 (glibc)
  QEMU version: 2.9.0
  GDB version: 7.12.1

  Problem description:

  After I updated QEMU from version 2.8.1 to 2.9.0, I found that when I try=
 to connect GDB to a running QEMU and try to debug Real mode machine code, =
I can no longer set architecture to 'i8086'.
  To be able to connect to QEMU from GDB at all, I have to specify one of t=
he 64 bit architectures, which among other things leads to incorrect disass=
embly listings. This makes debugging Real mode bootloaders, bootsectors and=
 BIOS code much more difficult.

  Steps to reproduce:

  - Run QEMU
  - In another terminal, run GDB
  - In GDB, connect to QEMU
  - In GDB, disassemble some Real mode machine code.

  Expected results (from QEMU version 2.8.1):

      [terminal #1]
      $ qemu-system-x86_64 -S -s

      [terminal #2]
      (gdb) set architecture i8086
      warning: A handler for the OS ABI "GNU/Linux" is not built =

      into this configuration
      of GDB.  Attempting to continue with the default i8086 settings.

      The target architecture is assumed to be i8086
      (gdb) target remote :1234
      Remote debugging using :1234
      warning: No executable has been specified and target does not support
      determining executable automatically.  Try using the "file" command.
      0x0000fff0 in ?? ()
      (gdb) x/i $cs*16+$eip
         0xffff0:	ljmp   $0xf000,$0xe05b

  Actual results:

      [terminal #1]
      $ qemu-system-x86_64 -S -s

      [terminal #2]
      $ gdb -q
      (gdb) set architecture i8086 =

      warning: A handler for the OS ABI "GNU/Linux" is not built into this =
configuration
      of GDB.  Attempting to continue with the default i8086 settings.

      The target architecture is assumed to be i8086
      (gdb) target remote :1234
      Remote debugging using :1234
      warning: No executable has been specified and target does not support
      determining executable automatically.  Try using the "file" command.
      Remote 'g' packet reply is too long: =

      [..snip..]

  Workarounds tried:

    - Try different architecures
      (gdb) set architecture i386:intel
      The target architecture is assumed to be i386:intel
      (gdb) target remote :1234
      Remote debugging using :1234
      warning: No executable has been specified and target does not support
      determining executable automatically.  Try using the "file" command.
      Remote 'g' packet reply is too long: =

      [..snip..]
      (gdb) set architecture i386:x86-64
      The target architecture is assumed to be i386:x86-64
      (gdb) target remote :1234
      Remote debugging using :1234
      warning: No executable has been specified and target does not support
      determining executable automatically.  Try using the "file" command.
      0x000000000000fff0 in ?? ()

  The last try finally allowed me to connect to QEMU, but as can be
  expected from using an incorrect architecture setting, disassembly
  output is complete gibberish:

      (gdb) x/10i $cs*16+$rip
         0xffff0:	(bad)  =

         0xffff1:	pop    %rbx
         0xffff2:	loopne 0xffff4
         0xffff4:	lock xor %dh,(%rsi)
         0xffff7:	(bad)  =

         0xffff8:	xor    (%rbx),%dh
         0xffffa:	(bad)  =

         0xffffb:	cmp    %edi,(%rcx)
         0xffffd:	add    %bh,%ah
         0xfffff:	add    %al,(%rax)

  Discussion:

  I think I've traced the problem to the following commit: "x86: Fix x86_64=
 'g' packet response to gdb from 32-bit mode."[1].
  While I admire the effort to make life for people using GDB to debug QEMU=
 VMs, I think the problem here is with GDB and can't be fixed entirely from=
 the side of QEMU without breaking other features.

  In fact, there is a well-known workaround to this problem published on
  OSDev Wiki (Workaround #1)[2] which doesn't require patching either
  QEMU or GDB. This workaround has worked for me using several previous
  versions of QEMU.

      $ gdb -q
      (gdb) set architecture i8086
      (gdb) target remote :1234
      (gdb) break some_breakpoint_in_32_bit_or_64_bit_code
      (gdb) continue
      [...]
      Remote 'g' packet reply is too long: [...]
      (gdb) disconnect # IMPORTANT STEP #1
      (gdb) set architecture i386:x86-64
      (gdb) target remote :1234 # IMPORTANT STEP #2
      (gdb) continue

  [1]: http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3De3592bc9d841c397eed=
a87f0019fab94ff71004b
  [2]: http://wiki.osdev.org/QEMU_and_GDB_in_long_mode#Workaround_1:_Reconn=
ecting

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1686170/+subscriptions

