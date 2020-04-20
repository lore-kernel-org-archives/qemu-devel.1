Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D962EC3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 13:58:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD3662070B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 13:58:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD3662070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQWwW-0002Pd-Tb
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 09:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37000 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frederic.konrad@adacore.com>) id 1jQWro-000693-2b
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 09:53:50 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <frederic.konrad@adacore.com>) id 1jQWrm-0003h8-Ml
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 09:53:43 -0400
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:53235
 helo=smtp.eu.adacore.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frederic.konrad@adacore.com>)
 id 1jQWrm-0003bi-2I
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 09:53:42 -0400
Received: from localhost (localhost [127.0.0.1])
 by filtered-smtp.eu.adacore.com (Postfix) with ESMTP id 65E87812FD;
 Mon, 20 Apr 2020 15:53:39 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at eu.adacore.com
Received: from smtp.eu.adacore.com ([127.0.0.1])
 by localhost (smtp.eu.adacore.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MtHipk9WoM_L; Mon, 20 Apr 2020 15:53:39 +0200 (CEST)
Received: from localhost.localdomain (lfbn-tou-1-1471-22.w90-89.abo.wanadoo.fr
 [90.89.4.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp.eu.adacore.com (Postfix) with ESMTPSA id EF1E8812EF;
 Mon, 20 Apr 2020 15:53:38 +0200 (CEST)
Subject: Re: m68k: gdbstub crashing setting float register on cfv4e cpu
To: Laurent Vivier <laurent@vivier.eu>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>
References: <3be54f78-cf6d-af3b-6e1f-e91d146c6a3a@amsat.org>
 <87sgh680qb.fsf@linaro.org> <7922d9aa-f849-7774-7f6e-71ce3dacde43@vivier.eu>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <89badc0e-a008-a9a6-3a20-a4d46808809a@adacore.com>
Date: Mon, 20 Apr 2020 15:53:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <7922d9aa-f849-7774-7f6e-71ce3dacde43@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:2ab8:224:1::a0a:d2;
 envelope-from=frederic.konrad@adacore.com; helo=smtp.eu.adacore.com
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a02:2ab8:224:1::a0a:d2
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
Cc: Thomas Huth <huth@tuxfamily.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 pierre@freepascal.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



Le 4/16/20 à 1:18 PM, Laurent Vivier a écrit :
> Le 14/04/2020 à 18:56, Alex Bennée a écrit :
>>
>> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
>>
>>> gdbstub/m68k seems broken with floats, previous to refactor commit
>>> a010bdbe719 ("extend GByteArray to read register helpers").
>>>
>>> HEAD at 6fb1603aa2:
>>>
>>> $ qemu-system-m68k -s -S -cpu cfv4e
>>>
>>> ---[GUEST]---
>>>
>>> (gdb) set architecture m68k:cfv4e
>>> The target architecture is assumed to be m68k:cfv4e
>>> (gdb) target remote 172.17.0.1:1234
>>> Remote debugging using 172.17.0.1:1234
>>> (gdb) info float
>>> fp0            -nan(0xfffffffffff7f) (raw 0xffffffffffffff7f)
>>> fp1            -nan(0xfffffffffff7f) (raw 0xffffffffffffff7f)
>>> fp2            -nan(0xfffffffffff7f) (raw 0xffffffffffffff7f)
>>> fp3            -nan(0xfffffffffff7f) (raw 0xffffffffffffff7f)
>>> fp4            -nan(0xfffffffffff7f) (raw 0xffffffffffffff7f)
>>> fp5            -nan(0xfffffffffff7f) (raw 0xffffffffffffff7f)
>>> fp6            -nan(0xfffffffffff7f) (raw 0xffffffffffffff7f)
>>> fp7            -nan(0xfffffffffff7f) (raw 0xffffffffffffff7f)
>>> fpcontrol      0x0                 0
>>> fpstatus       0x0                 0
>>> fpiaddr        0x0                 0x0
>>> (gdb) set $fp0=1
>>> Remote communication error.  Target disconnected.: Connection reset by
>>> peer.
>>
>> With my sha1 debugging test case I get different results depending on
>> the cpu type:
>>
>>    /home/alex/lsrc/qemu.git/tests/guest-debug/run-test.py --gdb /home/alex/src/tools/binutils-gdb.git/builds/all/install/bin/gdb --qemu /home/alex/lsrc/qemu.git/builds/user.static/m68k-linux-user/qemu-m68k --qargs "" --bin tests/tcg/m68k-linux-user/sha1 --test /home/alex/lsrc/qemu.git/tests/tcg/multiarch/gdbstub/sha1.py
>>    GNU gdb (GDB) 10.0.50.20200414-git
>>    Copyright (C) 2020 Free Software Foundation, Inc.
>>    License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
>>    This is free software: you are free to change and redistribute it.
>>    There is NO WARRANTY, to the extent permitted by law.
>>    Type "show copying" and "show warranty" for details.
>>    This GDB was configured as "x86_64-pc-linux-gnu".
>>    Type "show configuration" for configuration details.
>>    For bug reporting instructions, please see:
>>    <http://www.gnu.org/software/gdb/bugs/>.
>>    Find the GDB manual and other documentation resources online at:
>>        <http://www.gnu.org/software/gdb/documentation/>.
>>
>>    For help, type "help".
>>    Type "apropos word" to search for commands related to "word"...
>>    Executed .gdbinit
>>    Reading symbols from tests/tcg/m68k-linux-user/sha1...
>>    Remote debugging using localhost:1234
>>    warning: Register "fp0" has an unsupported size (96 bits)
>>    warning: Register "fp1" has an unsupported size (96 bits)
>>    warning: Register "fp2" has an unsupported size (96 bits)
>>    warning: Register "fp3" has an unsupported size (96 bits)
>>    warning: Register "fp4" has an unsupported size (96 bits)
>>    warning: Register "fp5" has an unsupported size (96 bits)
>>    warning: Register "fp6" has an unsupported size (96 bits)
>>    warning: Register "fp7" has an unsupported size (96 bits)
>>    Remote 'g' packet reply is too long (expected 148 bytes, got 180 bytes): 000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000408009f000000000800003407fff0000ffffffffffffffff7fff0000ffffffffffffffff7fff0000ffffffffffffffff7fff0000ffffffffffffffff7fff0000ffffffffffffffff7fff0000ffffffffffffffff7fff0000ffffffffffffffff7fff0000ffffffffffffffff000000000000000000000000
> 
> This is a bug in GDB that doesn't support 96bit float registers of 680x0
> but only 64bit registers of coldfire.
> 
> There was a rework of GDB in the past that has broken that and no one
> noticed. I bisected and found the commit but it was really too complex
> and difficult to fix.

We worked on that recently, actually the registers are supported in GDB but QEMU
doesn't send the right register description to GDB.

I've a local patch for that, will send it to the list.

> 
> To be able to debug remotely m68k I use gdb from etch-m68k in a chroot
> (or from real hardware).
> 
> Thanks,
> Laurent
> 

