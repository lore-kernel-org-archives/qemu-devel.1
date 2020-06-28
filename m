Return-Path: <SRS0=WNoQ=AJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D3CC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 16:34:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B11AF20772
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 16:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B11AF20772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tribudubois.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpaGB-0004hP-L3
	for qemu-devel@archiver.kernel.org; Sun, 28 Jun 2020 12:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcd@tribudubois.net>)
 id 1jpaFR-0004FB-7c
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 12:33:41 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:45983)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcd@tribudubois.net>)
 id 1jpaFN-0000II-Uj
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 12:33:40 -0400
X-Originating-IP: 185.189.22.94
Received: from [192.168.43.86] (unknown [185.189.22.94])
 (Authenticated sender: jcd@tribudubois.net)
 by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 991CB20003
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2020 16:33:25 +0000 (UTC)
Subject: Re: Crash when running Qemu.
From: Jean-Christophe DUBOIS <jcd@tribudubois.net>
To: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
References: <20d398f5-729e-57a7-db92-2243c106d832@tribudubois.net>
 <bf691b10-c8ba-f92a-24dd-57f90382390c@tribudubois.net>
Message-ID: <b8d836b0-4e26-5c24-7ab9-c43bd6f92710@tribudubois.net>
Date: Sun, 28 Jun 2020 18:32:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <bf691b10-c8ba-f92a-24dd-57f90382390c@tribudubois.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=217.70.183.200; envelope-from=jcd@tribudubois.net;
 helo=relay7-d.mail.gandi.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/28 12:33:34
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

By reverting the recent (june 23) commit series on PCA9552 I can run 
Qemu again.

Here is the git revert command I did.

jcd@jcd-UX305CA:~/Projects/qemu/qemu$ git revert 
8208335b9539e7b5aa4702b36e2f9a8abd704079..586f495b1e78c27e141ff432dd971eb41866fb80

Regards

JC

Le 28/06/2020 à 17:57, Jean-Christophe DUBOIS a écrit :
> When ran from valgrind, qemu does not crash but the following output 
> is returned.
>
> valgrind --track-origins=yes 
> ../../qemu/qemu/arm-softmmu/qemu-system-arm -machine mcimx6ul-evk -m 
> 128M -display none -serial stdio -kernel ./OS.elf
> ==77479== Memcheck, a memory error detector
> ==77479== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
> ==77479== Using Valgrind-3.15.0 and LibVEX; rerun with -h for 
> copyright info
> ==77479== Command: ../../qemu/qemu/arm-softmmu/qemu-system-arm 
> -machine mcimx6ul-evk -m 128M -display none -serial stdio -kernel 
> ./OS.elf
> ==77479==
> ==77479== Invalid write of size 2
> ==77479==    at 0x6D8322: pca9552_class_init (pca9552.c:424)
> ==77479==    by 0x844D1F: type_initialize (object.c:1029)
> ==77479==    by 0x844D1F: object_class_foreach_tramp (object.c:1016)
> ==77479==    by 0x4AE1057: g_hash_table_foreach (in 
> /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.2)
> ==77479==    by 0x8453A4: object_class_foreach (object.c:1038)
> ==77479==    by 0x8453A4: object_class_get_list (object.c:1095)
> ==77479==    by 0x556194: select_machine (vl.c:2416)
> ==77479==    by 0x556194: qemu_init (vl.c:3828)
> ==77479==    by 0x40AF9C: main (main.c:48)
> ==77479==  Address 0x583f108 is 0 bytes after a block of size 200 alloc'd
> ==77479==    at 0x483DD99: calloc (in 
> /usr/lib/x86_64-linux-gnu/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==77479==    by 0x4AF8D30: g_malloc0 (in 
> /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.2)
> ==77479==    by 0x844258: type_initialize.part.0 (object.c:306)
> ==77479==    by 0x844D1F: type_initialize (object.c:1029)
> ==77479==    by 0x844D1F: object_class_foreach_tramp (object.c:1016)
> ==77479==    by 0x4AE1057: g_hash_table_foreach (in 
> /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.2)
> ==77479==    by 0x8453A4: object_class_foreach (object.c:1038)
> ==77479==    by 0x8453A4: object_class_get_list (object.c:1095)
> ==77479==    by 0x556194: select_machine (vl.c:2416)
> ==77479==    by 0x556194: qemu_init (vl.c:3828)
> ==77479==    by 0x40AF9C: main (main.c:48)
> ==77479==
> ==77479== Conditional jump or move depends on uninitialised value(s)
> ==77479==    at 0x41D944: tcg_target_init (tcg-target.inc.c:3867)
> ==77479==    by 0x41D944: tcg_context_init (tcg.c:983)
> ==77479==    by 0x48E60D: cpu_gen_init (translate-all.c:246)
> ==77479==    by 0x48E60D: tcg_exec_init (translate-all.c:1152)
> ==77479==    by 0x46FE7B: tcg_init (tcg-all.c:129)
> ==77479==    by 0x5E15A5: accel_init_machine (accel.c:55)
> ==77479==    by 0x55402F: do_configure_accelerator (vl.c:2708)
> ==77479==    by 0x94F1D1: qemu_opts_foreach (qemu-option.c:1163)
> ==77479==    by 0x5598B3: configure_accelerators (vl.c:2775)
> ==77479==    by 0x5598B3: qemu_init (vl.c:4152)
> ==77479==    by 0x40AF9C: main (main.c:48)
> ==77479==  Uninitialised value was created by a stack allocation
> ==77479==    at 0x4ADFE5F: ??? (in 
> /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.2)
> ==77479==
> ==77479== Warning: set address range perms: large range [0x6483000, 
> 0x46483000) (defined)
>
> ===================================================================
> =                       TCPIP INITIALIZATION =
> ===================================================================
> Initializing TCPIP...
>
> ------- i.MX6UL-EVK BOARD NETWORK CONFIG --------
>
>
>
> Starting ENET1...
>
> NetIF_LinkStateWaitUntilUp() failed w/ err = 30
>
>
> Starting ENET2...
>
> NetIF_LinkStateWaitUntilUp() failed w/ err = 30
>
> Network Configuration:
> qemu-system-arm: terminating on signal 2
> ==77479==
> ==77479== HEAP SUMMARY:
> ==77479==     in use at exit: 8,452,515 bytes in 57,040 blocks
> ==77479==   total heap usage: 97,248 allocs, 40,208 frees, 21,279,482 
> bytes allocated
> ==77479==
> ==77479== LEAK SUMMARY:
> ==77479==    definitely lost: 0 bytes in 0 blocks
> ==77479==    indirectly lost: 0 bytes in 0 blocks
> ==77479==      possibly lost: 3,474 bytes in 45 blocks
> ==77479==    still reachable: 8,449,041 bytes in 56,995 blocks
> ==77479==                       of which reachable via heuristic:
> ==77479==                         newarray           : 1,536 bytes in 
> 16 blocks
> ==77479==         suppressed: 0 bytes in 0 blocks
> ==77479== Rerun with --leak-check=full to see details of leaked memory
> ==77479==
> ==77479== For lists of detected and suppressed errors, rerun with: -s
> ==77479== ERROR SUMMARY: 3 errors from 2 contexts (suppressed: 0 from 0)
>
> Le 28/06/2020 à 12:55, Jean-Christophe DUBOIS a écrit :
>> Hi,
>>
>> Since the last pull I did this week end on the qemu git tree (master 
>> branch) I am unable to "start" qemu anymore (It was working OK from 
>> git master previously).
>>
>> Traces are provided bellow.
>>
>> Am I the only one to get this behavior?
>>
>> JC
>>
>> jcd@jcd-UX305CA:~/Projects/µCOS/work$ 
>> ../../qemu/qemu/arm-softmmu/qemu-system-arm -machine mcimx6ul-evk -m 
>> 128M -display none -serial stdio -kernel ./OS.elf
>> double free or corruption (!prev)
>> Abandon (core dumped)
>>
>> Running the same command from "gdb" provides the following backtrace.
>>
>> jcd@jcd-UX305CA:~/Projects/µCOS/work$ gdb 
>> ../../qemu/qemu/arm-softmmu/qemu-system-arm
>> GNU gdb (Ubuntu 9.1-0ubuntu1) 9.1
>> Copyright (C) 2020 Free Software Foundation, Inc.
>> License GPLv3+: GNU GPL version 3 or later 
>> <http://gnu.org/licenses/gpl.html>
>> This is free software: you are free to change and redistribute it.
>> There is NO WARRANTY, to the extent permitted by law.
>> Type "show copying" and "show warranty" for details.
>> This GDB was configured as "x86_64-linux-gnu".
>> Type "show configuration" for configuration details.
>> For bug reporting instructions, please see:
>> <http://www.gnu.org/software/gdb/bugs/>.
>> Find the GDB manual and other documentation resources online at:
>>     <http://www.gnu.org/software/gdb/documentation/>.
>>
>> For help, type "help".
>> Type "apropos word" to search for commands related to "word"...
>> Reading symbols from ../../qemu/qemu/arm-softmmu/qemu-system-arm...
>> (gdb) run -machine mcimx6ul-evk -m 128M -display none -serial stdio 
>> -kernel ./OS.elf
>> Starting program: ../../qemu/qemu/arm-softmmu/qemu-system-arm 
>> -machine mcimx6ul-evk -m 128M -display none -serial stdio -kernel 
>> ./OS.elf
>> [Thread debugging using libthread_db enabled]
>> Using host libthread_db library 
>> "/lib/x86_64-linux-gnu/libthread_db.so.1".
>> [New Thread 0x7ffff738e700 (LWP 71630)]
>> double free or corruption (!prev)
>>
>> Thread 1 "qemu-system-arm" received signal SIGABRT, Aborted.
>> __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:50
>> 50    ../sysdeps/unix/sysv/linux/raise.c: Aucun fichier ou dossier de 
>> ce type.
>> (gdb) where
>> #0  __GI_raise (sig=sig@entry=6) at 
>> ../sysdeps/unix/sysv/linux/raise.c:50
>> #1  0x00007ffff75d8859 in __GI_abort () at abort.c:79
>> #2  0x00007ffff76433ee in __libc_message
>>     (action=action@entry=do_abort, fmt=fmt@entry=0x7ffff776d285 "%s\n")
>>     at ../sysdeps/posix/libc_fatal.c:155
>> #3  0x00007ffff764b47c in malloc_printerr
>>     (str=str@entry=0x7ffff776f690 "double free or corruption (!prev)")
>>     at malloc.c:5347
>> #4  0x00007ffff764d12c in _int_free
>>     (av=0x7ffff779eb80 <main_arena>, p=0x5555567a3990, 
>> have_lock=<optimized out>) at malloc.c:4317
>> #5  0x0000555555c906c3 in type_initialize_interface
>>     (ti=ti@entry=0x5555565b8f40, interface_type=0x555556597ad0, 
>> parent_type=0x55555662ca10) at qom/object.c:259
>> #6  0x0000555555c902da in type_initialize (ti=ti@entry=0x5555565b8f40)
>>     at qom/object.c:323
>> #7  0x0000555555c90d20 in type_initialize (ti=0x5555565b8f40)
>>     at qom/object.c:1028
>> #8  object_class_foreach_tramp
>>     (key=<optimized out>, value=0x5555565b8f40, opaque=0x7fffffffdc20)
>>     at qom/object.c:1016
>> #9  0x00007ffff7c89058 in g_hash_table_foreach ()
>>     at /lib/x86_64-linux-gnu/libglib-2.0.so.0
>> #10 0x0000555555c913a5 in object_class_foreach
>>     (opaque=0x7fffffffdc18, include_abstract=false, 
>> implements_type=<optimized out>, fn=0x555555c8f270 
>> <object_class_get_list_tramp>) at qom/object.c:84
>> #11 object_class_get_list
>>     (implements_type=implements_type@entry=0x555555fd5e0c "machine", 
>> include_abstract=include_abstract@entry=false) at qom/object.c:1095
>> #12 0x00005555559a2195 in select_machine ()
>>     at /home/jcd/Projects/qemu/qemu/softmmu/vl.c:3828
>> #13 qemu_init (argc=<optimized out>, argv=0x7fffffffdef8, 
>> envp=<optimized out>)
>>     at /home/jcd/Projects/qemu/qemu/softmmu/vl.c:3828
>> #14 0x0000555555856f9d in main
>>     (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>)
>>     at /home/jcd/Projects/qemu/qemu/softmmu/main.c:48
>> (gdb)
>>
>>
>
>


