Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BECEC4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 13:31:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C72D4206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 13:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fau.de header.i=@fau.de header.b="cswJ1LKk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C72D4206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iADZm-00075e-IA
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 09:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41710)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andreas.konopik@fau.de>) id 1iADBa-0007xQ-Qp
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 09:06:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andreas.konopik@fau.de>) id 1iADBX-0002Dl-Ie
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 09:06:26 -0400
Received: from mx-rz-2.rrze.uni-erlangen.de ([131.188.11.21]:40323)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andreas.konopik@fau.de>)
 id 1iADBW-0002AT-UM; Tue, 17 Sep 2019 09:06:23 -0400
Received: from mx-rz-smart.rrze.uni-erlangen.de
 (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 46Xjzc2wQnzPnK9;
 Tue, 17 Sep 2019 15:06:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
 t=1568725580; bh=+dxqkxRSK3oqr1+oIdiKBqxz4YNPLF/nQmx6MndBlPQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From:To:CC:
 Subject;
 b=cswJ1LKk2hhfwdylraRNPkGRzOPiKeM1PrDu92DC/ymqdJ9mijDnQ++4bxHOM3exU
 buY6lk111B07Obd0XJXr8f7G28ynLBFEp8t3RsCNPFbkIgXP1TDRGblNCWDXv4hmAW
 Jnfl3vjahGSxJafKllj7e3nGVj6QUPGJ60lYyPEddzMo4LzRW7/d763DWr9wqJnze4
 3cxOXxaVrQfXYOr6t1xh+4ZhI4ZxfE9h01h/c3SJSqknIHOCSXvrAH+DJ7CGSLYKRv
 rH1C7ZqL28EvyO/dHntsFvqILmHwL6e2cSH1gC+2cWaIEYPeIEUJde8EIgGL2oLcoi
 AZN++mqlXUuzA==
X-Virus-Scanned: amavisd-new at boeck5.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 131.188.11.37
Received: from faumail.fau.de (smtp-auth.fau.de [131.188.11.37])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: U2FsdGVkX19kqBELjgQqzUxaOdP147V72N6dzKEy3ls=)
 by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 46XjzX0zbdzPkfS;
 Tue, 17 Sep 2019 15:06:16 +0200 (CEST)
Received: from JqnuTaqrV/hqxjKnOY3zlIp58VOes0D6Ihl08lDGJxw=
 by faumail.uni-erlangen.de
 with HTTP (HTTP/1.1 POST); Tue, 17 Sep 2019 15:06:16 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 17 Sep 2019 15:06:16 +0200
From: "Konopik, Andreas" <andreas.konopik@fau.de>
To: Peter Maydell <peter.maydell@linaro.org>
In-Reply-To: <CAFEAcA-oP9QkYnQr1SQUvTks+9ySjDCn0G5yuULdOBepQi-PSw@mail.gmail.com>
References: <9cf47438fa943b28ee987cea7b76a459@fau.de>
 <CAFEAcA-oP9QkYnQr1SQUvTks+9ySjDCn0G5yuULdOBepQi-PSw@mail.gmail.com>
Message-ID: <75c41dce4fe333c0304f5e80e3ea6f34@fau.de>
X-Sender: andreas.konopik@fau.de
User-Agent: Roundcube Webmail/1.2.9
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 131.188.11.21
X-Mailman-Approved-At: Tue, 17 Sep 2019 09:26:56 -0400
Subject: Re: [Qemu-devel] [Qemu-discuss] Segmentation fault on target tricore
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, qemu-discuss@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

>> Using gdb and valgrind I found out that:
>> - 'gen_mtcr()' and 'gen_mfcr()' access uninitialized values, i.e. 
>> CSFRs,
>> which leads to the Segfault
>> - The uninitialised values were created by stack allocation of
>> DisasContext in 'gen_intermediate_code()'
> 
> This definitely sounds like a bug: do you have a stack
> backtrace from valgrind or gdb of the bad access and the
> segfault?
> 

GDB:

> [...]
> Thread 3 "qemu-system-tri" received signal SIGSEGV, Segmentation fault.
> [Switching to Thread 0x7ffff10a4700 (LWP 146730)]
> 0x00005555556edb67 in gen_mfcr (ret=0xab0, offset=<optimized out>,
>    ctx=<optimized out>)
>    at /home/akonopik/qemu_src/target/tricore/cpu.h:274
> 274	    return (env->features & (1ULL << feature)) != 0;
> (gdb) bt
> #0  0x00005555556edb67 in gen_mfcr
>    (ret=0xab0, offset=<optimized out>, ctx=<optimized out>)
>    at /home/akonopik/qemu_src/target/tricore/cpu.h:274
> #1  0x000055555570bc30 in decode_rlc_opc (op1=<optimized out>, 
> ctx=0x7ffff10a3540)
>    at /home/akonopik/qemu_src/target/tricore/translate.c:6020
> #2  0x000055555570bc30 in decode_32Bit_opc 
> (ctx=ctx@entry=0x7ffff10a3540)
>    at /home/akonopik/qemu_src/target/tricore/translate.c:8680
> #3  0x000055555570bf77 in tricore_tr_translate_insn
>    (dcbase=0x7ffff10a3540, cpu=<optimized out>)
>    at /home/akonopik/qemu_src/target/tricore/translate.c:8856
> #4  0x00005555556e15c9 in translator_loop (ops=
>    0x555555c2b340 <tricore_tr_ops>, db=0x7ffff10a3540, 
> cpu=0x555555dc0480, tb=<optimized out>, max_insns=<optimized out>)
>    at /home/akonopik/qemu_src/accel/tcg/translator.c:94
> #5  0x000055555570d96c in gen_intermediate_code
>    (cs=cs@entry=0x555555dc0480, tb=tb@entry=0x7fffea000280 
> <code_gen_buffer+595>, max_insns=max_insns@entry=512)
>    at /home/akonopik/qemu_src/target/tricore/translate.c:8907
> #6  0x00005555556e01f4 in tb_gen_code
>    (cpu=cpu@entry=0x555555dc0480, pc=pc@entry=2147485022, 
> cs_base=cs_base@entry=0, flags=flags@entry=0, cflags=-16777216, 
> cflags@entry=0)
>    at /home/akonopik/qemu_src/accel/tcg/translate-all.c:1738
> #7  0x00005555556de474 in tb_find
>    (cf_mask=0, tb_exit=0, last_tb=0x7fffea000140 <code_gen_buffer+275>, 
> cpu=0x555555dc0758) at /home/akonopik/qemu_src/accel/tcg/cpu-exec.c:408
> #8  0x00005555556de474 in cpu_exec (cpu=cpu@entry=0x555555dc0480)
>    at /home/akonopik/qemu_src/accel/tcg/cpu-exec.c:730
> #9  0x00005555556a59c0 in tcg_cpu_exec (cpu=0x555555dc0480)
>    at /home/akonopik/qemu_src/cpus.c:1445
> #10 0x00005555556a7831 in qemu_tcg_rr_cpu_thread_fn 
> (arg=arg@entry=0x555555dc0480)
>    at /home/akonopik/qemu_src/cpus.c:1547
> #11 0x00005555558d540b in qemu_thread_start (args=<optimized out>)
>    at /home/akonopik/qemu_src/util/qemu-thread-posix.c:502
> #12 0x00007ffff5a1657f in start_thread () at /usr/lib/libpthread.so.0
> #13 0x00007ffff59460e3 in clone () at /usr/lib/libc.so.6

VALGRIND:

> ==146846== Memcheck, a memory error detector
> ==146846== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et 
> al.
> ==146846== Using Valgrind-3.14.0 and LibVEX; rerun with -h for 
> copyright info
> ==146846== Command:
> /home/akonopik/qemu_src/build/tricore-softmmu/qemu-system-tricore 
> -nographic -M
> tricore_testboard -cpu tc1796 -kernel /home/akonopik/hello.elf
> ==146846==
> --146846-- WARNING: unhandled amd64-linux syscall: 317
> --146846-- You may be able to write your own handler.
> --146846-- Read the file README_MISSING_SYSCALL_OR_IOCTL.
> --146846-- Nevertheless we consider this a bug.  Please report
> --146846-- it at http://valgrind.org/support/bug_reports.html.
> ==146846== Conditional jump or move depends on uninitialised value(s)
> ==146846==    at 0x223D94: tcg_target_init (tcg-target.inc.c:3776)
> ==146846==    by 0x223D94: tcg_context_init (tcg.c:961)
> ==146846==    by 0x293E29: cpu_gen_init (translate-all.c:240)
> ==146846==    by 0x293E29: tcg_exec_init (translate-all.c:1148)
> ==146846==    by 0x275333: tcg_init (tcg-all.c:63)
> ==146846==    by 0x274DE3: accel_init_machine (accel.c:63)
> ==146846==    by 0x274DE3: configure_accelerator (accel.c:110)
> ==146846==    by 0x210236: main (vl.c:4185)
> ==146846==  Uninitialised value was created by a stack allocation
> ==146846==    at 0x5E3E117: ??? (in /usr/lib/libglib-2.0.so.0.6200.0)
> ==146846==
> QEMU 4.1.50 monitor - type 'help' for more information
> (qemu) ==146846== Thread 3:
> ==146846== Use of uninitialised value of size 8
> ==146846==    at 0x2A1B67: gen_mfcr.isra.0 (csfr.def:9)
> ==146846==    by 0x2BFC2F: decode_rlc_opc (translate.c:6020)
> ==146846==    by 0x2BFC2F: decode_32Bit_opc (translate.c:8680)
> ==146846==    by 0x2BFF76: tricore_tr_translate_insn (translate.c:8856)
> ==146846==    by 0x2955C8: translator_loop (translator.c:94)
> ==146846==    by 0x2C196B: gen_intermediate_code (translate.c:8907)
> ==146846==    by 0x2941F3: tb_gen_code (translate-all.c:1738)
> ==146846==    by 0x292473: tb_find (cpu-exec.c:408)
> ==146846==    by 0x292473: cpu_exec (cpu-exec.c:730)
> ==146846==    by 0x2599BF: tcg_cpu_exec (cpus.c:1445)
> ==146846==    by 0x25B830: qemu_tcg_rr_cpu_thread_fn (cpus.c:1547)
> ==146846==    by 0x48940A: qemu_thread_start (qemu-thread-posix.c:502)
> ==146846==    by 0x6DEE57E: start_thread (in 
> /usr/lib/libpthread-2.29.so)
> ==146846==    by 0x6F040E2: clone (in /usr/lib/libc-2.29.so)
> ==146846==  Uninitialised value was created by a stack allocation
> ==146846==    at 0x2C1940: gen_intermediate_code (translate.c:8905)
> ==146846==
> ==146846== Use of uninitialised value of size 8
> ==146846==    at 0x2A302C: gen_mtcr.isra.0 (csfr.def:9)
> ==146846==    by 0x2BFC9C: decode_rlc_opc (translate.c:6046)
> ==146846==    by 0x2BFC9C: decode_32Bit_opc (translate.c:8680)
> ==146846==    by 0x2BFF76: tricore_tr_translate_insn (translate.c:8856)
> ==146846==    by 0x2955C8: translator_loop (translator.c:94)
> ==146846==    by 0x2C196B: gen_intermediate_code (translate.c:8907)
> ==146846==    by 0x2941F3: tb_gen_code (translate-all.c:1738)
> ==146846==    by 0x292473: tb_find (cpu-exec.c:408)
> ==146846==    by 0x292473: cpu_exec (cpu-exec.c:730)
> ==146846==    by 0x2599BF: tcg_cpu_exec (cpus.c:1445)
> ==146846==    by 0x25B830: qemu_tcg_rr_cpu_thread_fn (cpus.c:1547)
> ==146846==    by 0x48940A: qemu_thread_start (qemu-thread-posix.c:502)
> ==146846==    by 0x6DEE57E: start_thread (in 
> /usr/lib/libpthread-2.29.so)
> ==146846==    by 0x6F040E2: clone (in /usr/lib/libc-2.29.so)
> ==146846==  Uninitialised value was created by a stack allocation
> ==146846==    at 0x2C1940: gen_intermediate_code (translate.c:8905)
> [...]


Regards,

Andreas

