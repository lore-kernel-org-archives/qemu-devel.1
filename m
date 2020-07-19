Return-Path: <SRS0=x6dg=A6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3F6C433E3
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2020 17:35:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4770120B1F
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2020 17:35:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4770120B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stackframe.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxDDR-0001ic-AM
	for qemu-devel@archiver.kernel.org; Sun, 19 Jul 2020 13:35:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1jxDAK-00012z-SO
 for qemu-devel@nongnu.org; Sun, 19 Jul 2020 13:31:57 -0400
Received: from smtp.duncanthrax.net ([178.63.180.169]:56504)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1jxDAG-00025B-BF
 for qemu-devel@nongnu.org; Sun, 19 Jul 2020 13:31:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=duncanthrax.net; s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References
 :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2kjDwBLi2v8gGqDOQ1dBSu/xLqQ4iBlQlbJuVW5OfOg=; b=OboWt+5UjSBc4X6s44UXzdXriP
 Hti551xtdgi7OksKoa3jOH94zPltl/IM/qjQLlSWbjxeAWd9mGpbTt50sEp035VAIsgBClwP961bM
 ePoU4inz2plCgALkY4MdpDBCF6mhVJ+tmdPzsXUMWAoIKQ96Tzod4e8oeNzatszOxS5o=;
Received: from hsi-kbw-091-089-248-125.hsi2.kabel-badenwuerttemberg.de
 ([91.89.248.125] helo=t470p.stackframe.org)
 by smtp.duncanthrax.net with esmtpa (Exim 4.90_1)
 (envelope-from <svens@stackframe.org>)
 id 1jxDAC-0004q7-6Z; Sun, 19 Jul 2020 19:31:48 +0200
Date: Sun, 19 Jul 2020 19:31:47 +0200
From: svens@stackframe.org
To: Bug 1880287 <1880287@bugs.launchpad.net>
Subject: Re: [Bug 1880287] Re: gcc crashes in hppa emulation
Message-ID: <20200719173147.GB14403@t470p.stackframe.org>
References: <159022297856.20775.958724179871171148.malonedeb@soybean.canonical.com>
 <159502121068.13621.18184835876951101397.malone@gac.canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159502121068.13621.18184835876951101397.malone@gac.canonical.com>
Received-SPF: none client-ip=178.63.180.169; envelope-from=svens@stackframe.org;
 helo=smtp.duncanthrax.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/19 13:31:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 17, 2020 at 09:26:50PM -0000, Helge Deller wrote:
> Test still crashes the VM and chroot with up-to-date debian chroot,
> including updated gcc-9.3.0-14.
> 
> -- 
> You received this bug notification because you are a member of qemu-
> devel-ml, which is subscribed to QEMU.
> https://bugs.launchpad.net/bugs/1880287
> 
> Title:
>   gcc crashes in hppa emulation
> 
> Status in QEMU:
>   New
> 
> Bug description:
>   There seems to be a translation bug in the qemu-hppa (qemu v5.0.0) emulation:
>   A stripped down testcase (taken from Linux kernel build) is attached.
> 
>   In there is "a.sh", a shell script which calls gcc-9 (fails with both
>   debian gcc-9.3.0-11 or gcc-9.3.0-12). and "a.iii", the preprocessed
>   source.
> 
>   When starting a.sh, in the emulation gcc crashes with segfault.
>   On real hardware gcc succeeds to compile the source.
> 
>   In a hppa-user chroot running "apt update && apt install gcc-9" should
>   be sufficient to get the needed reproducer environment.
> 
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1880287/+subscriptions
> 

I reproduced this here and it looks like we're running out of TCG temps:

hread 3 "qemu-system-hpp" received signal SIGABRT, Aborted.
[Switching to Thread 0x7fcb5ffff700 (LWP 3208)]
__GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:50
50	../sysdeps/unix/sysv/linux/raise.c: No such file or directory.
(gdb) bt
#0  __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:50
#1  0x00007fcb680a455b in __GI_abort () at abort.c:79
#2  0x00007fcb680a442f in __assert_fail_base
    (fmt=0x7fcb6820ab48 "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n", assertion=0x55cc6120e68c "n < 512", file=0x55cc6120c569 "/home/svens/qemu/tcg/tcg.c", line=1156, function=<optimized out>) at assert.c:92
#3  0x00007fcb680b3092 in __GI___assert_fail
    (assertion=0x55cc6120e68c "n < 512", file=0x55cc6120c569 "/home/svens/qemu/tcg/tcg.c", line=1156, function=0x55cc6120f768 <__PRETTY_FUNCTION__.37440> "tcg_temp_alloc") at assert.c:101
#4  0x000055cc60cd57ae in tcg_temp_alloc (s=0x7fcad0000b60) at /home/svens/qemu/tcg/tcg.c:1156
#5  0x000055cc60cd5bd6 in tcg_temp_new_internal (type=TCG_TYPE_I32, temp_local=false) at /home/svens/qemu/tcg/tcg.c:1273
#6  0x000055cc60dda222 in tcg_temp_new_i32 () at /home/svens/qemu/include/tcg/tcg.h:899
#7  0x000055cc60de760c in do_sub (ctx=0x7fcb5fffe2e0, rt=2, in1=0x430, in2=0x9e0, is_tsv=false, is_b=false, is_tc=false, cf=0) at /home/svens/qemu/target/hppa/translate.c:1247
#8  0x000055cc60de7a04 in do_sub_reg (ctx=0x7fcb5fffe2e0, a=0x7fcb5fffe1d0, is_tsv=false, is_b=false, is_tc=false) at /home/svens/qemu/target/hppa/translate.c:1313
#9  0x000055cc60deaca9 in trans_sub (ctx=0x7fcb5fffe2e0, a=0x7fcb5fffe1d0) at /home/svens/qemu/target/hppa/translate.c:2647
#10 0x000055cc60de18aa in decode (ctx=0x7fcb5fffe2e0, insn=193070082) at target/hppa/decode.inc.c:1699
#11 0x000055cc60def6db in hppa_tr_translate_insn (dcbase=0x7fcb5fffe2e0, cs=0x55cc62065bf0) at /home/svens/qemu/target/hppa/translate.c:4255
#12 0x000055cc60d47d6f in translator_loop (ops=0x55cc614789c0 <hppa_tr_ops>, db=0x7fcb5fffe2e0, cpu=0x55cc62065bf0, tb=0x7fcb2f02e180 <code_gen_buffer+386064723>, max_insns=512)
    at /home/svens/qemu/accel/tcg/translator.c:102
#13 0x000055cc60defb9d in gen_intermediate_code (cs=0x55cc62065bf0, tb=0x7fcb2f02e180 <code_gen_buffer+386064723>, max_insns=512) at /home/svens/qemu/target/hppa/translate.c:4389
#14 0x000055cc60d45eeb in tb_gen_code (cpu=0x55cc62065bf0, pc=3161101733888, cs_base=3161095929860, flags=262915, cflags=-16777216) at /home/svens/qemu/accel/tcg/translate-all.c:1738
#15 0x000055cc60d42452 in tb_find (cpu=0x55cc62065bf0, last_tb=0x0, tb_exit=0, cf_mask=0) at /home/svens/qemu/accel/tcg/cpu-exec.c:407
#16 0x000055cc60d42d30 in cpu_exec (cpu=0x55cc62065bf0) at /home/svens/qemu/accel/tcg/cpu-exec.c:731
#17 0x000055cc60dbe7d1 in tcg_cpu_exec (cpu=0x55cc62065bf0) at /home/svens/qemu/softmmu/cpus.c:1356
#18 0x000055cc60dbeade in qemu_tcg_rr_cpu_thread_fn (arg=0x55cc62065bf0) at /home/svens/qemu/softmmu/cpus.c:1458
#19 0x000055cc611c98f0 in qemu_thread_start (args=0x55cc6207f6b0) at util/qemu-thread-posix.c:521
#20 0x00007fcb6824cf27 in start_thread (arg=<optimized out>) at pthread_create.c:479
#21 0x00007fcb6817c31f in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95
(gdb)

TCG_MAX_INSN is 512, and TCG_MAX_TEMPS also. Given the complexity of emulating the
parisc conditions and nullifications, i guess a 1:1 ratio is just not sufficient.
Increasing TCG_MAX_TEMPS to 1024 solves the issue. I haven't checked how big
the TB is, and how much temps it allocates then.

Regards
Sven


