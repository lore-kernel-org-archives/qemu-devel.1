Return-Path: <SRS0=WNoQ=AJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD5AC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 10:56:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 824B920768
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 10:56:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 824B920768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tribudubois.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpUyv-0004cz-NX
	for qemu-devel@archiver.kernel.org; Sun, 28 Jun 2020 06:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcd@tribudubois.net>)
 id 1jpUyM-0004CR-VP
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 06:55:42 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:38775)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcd@tribudubois.net>)
 id 1jpUyK-0007bb-9h
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 06:55:42 -0400
X-Originating-IP: 89.158.232.227
Received: from [192.168.0.13] (89-158-232-227.rev.numericable.fr
 [89.158.232.227]) (Authenticated sender: jcd@tribudubois.net)
 by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id D708E240009
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2020 10:55:34 +0000 (UTC)
To: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
From: Jean-Christophe DUBOIS <jcd@tribudubois.net>
Subject: Crash when running Qemu.
Message-ID: <20d398f5-729e-57a7-db92-2243c106d832@tribudubois.net>
Date: Sun, 28 Jun 2020 12:55:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=217.70.183.193; envelope-from=jcd@tribudubois.net;
 helo=relay1-d.mail.gandi.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/28 06:55:35
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

Hi,

Since the last pull I did this week end on the qemu git tree (master 
branch) I am unable to "start" qemu anymore (It was working OK from git 
master previously).

Traces are provided bellow.

Am I the only one to get this behavior?

JC

jcd@jcd-UX305CA:~/Projects/µCOS/work$ 
../../qemu/qemu/arm-softmmu/qemu-system-arm -machine mcimx6ul-evk -m 
128M -display none -serial stdio -kernel ./OS.elf
double free or corruption (!prev)
Abandon (core dumped)

Running the same command from "gdb" provides the following backtrace.

jcd@jcd-UX305CA:~/Projects/µCOS/work$ gdb 
../../qemu/qemu/arm-softmmu/qemu-system-arm
GNU gdb (Ubuntu 9.1-0ubuntu1) 9.1
Copyright (C) 2020 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later 
<http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Type "show copying" and "show warranty" for details.
This GDB was configured as "x86_64-linux-gnu".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
     <http://www.gnu.org/software/gdb/documentation/>.

For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from ../../qemu/qemu/arm-softmmu/qemu-system-arm...
(gdb) run -machine mcimx6ul-evk -m 128M -display none -serial stdio 
-kernel ./OS.elf
Starting program: ../../qemu/qemu/arm-softmmu/qemu-system-arm -machine 
mcimx6ul-evk -m 128M -display none -serial stdio -kernel ./OS.elf
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
[New Thread 0x7ffff738e700 (LWP 71630)]
double free or corruption (!prev)

Thread 1 "qemu-system-arm" received signal SIGABRT, Aborted.
__GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:50
50    ../sysdeps/unix/sysv/linux/raise.c: Aucun fichier ou dossier de ce 
type.
(gdb) where
#0  __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:50
#1  0x00007ffff75d8859 in __GI_abort () at abort.c:79
#2  0x00007ffff76433ee in __libc_message
     (action=action@entry=do_abort, fmt=fmt@entry=0x7ffff776d285 "%s\n")
     at ../sysdeps/posix/libc_fatal.c:155
#3  0x00007ffff764b47c in malloc_printerr
     (str=str@entry=0x7ffff776f690 "double free or corruption (!prev)")
     at malloc.c:5347
#4  0x00007ffff764d12c in _int_free
     (av=0x7ffff779eb80 <main_arena>, p=0x5555567a3990, 
have_lock=<optimized out>) at malloc.c:4317
#5  0x0000555555c906c3 in type_initialize_interface
     (ti=ti@entry=0x5555565b8f40, interface_type=0x555556597ad0, 
parent_type=0x55555662ca10) at qom/object.c:259
#6  0x0000555555c902da in type_initialize (ti=ti@entry=0x5555565b8f40)
     at qom/object.c:323
#7  0x0000555555c90d20 in type_initialize (ti=0x5555565b8f40)
     at qom/object.c:1028
#8  object_class_foreach_tramp
     (key=<optimized out>, value=0x5555565b8f40, opaque=0x7fffffffdc20)
     at qom/object.c:1016
#9  0x00007ffff7c89058 in g_hash_table_foreach ()
     at /lib/x86_64-linux-gnu/libglib-2.0.so.0
#10 0x0000555555c913a5 in object_class_foreach
     (opaque=0x7fffffffdc18, include_abstract=false, 
implements_type=<optimized out>, fn=0x555555c8f270 
<object_class_get_list_tramp>) at qom/object.c:84
#11 object_class_get_list
     (implements_type=implements_type@entry=0x555555fd5e0c "machine", 
include_abstract=include_abstract@entry=false) at qom/object.c:1095
#12 0x00005555559a2195 in select_machine ()
     at /home/jcd/Projects/qemu/qemu/softmmu/vl.c:3828
#13 qemu_init (argc=<optimized out>, argv=0x7fffffffdef8, 
envp=<optimized out>)
     at /home/jcd/Projects/qemu/qemu/softmmu/vl.c:3828
#14 0x0000555555856f9d in main
     (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>)
     at /home/jcd/Projects/qemu/qemu/softmmu/main.c:48
(gdb)


