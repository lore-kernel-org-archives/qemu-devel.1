Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DB5C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 18:20:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F58323D6C
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 18:20:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F58323D6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tribudubois.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpyO0-0005ai-MT
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 14:20:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcd@tribudubois.net>)
 id 1jpyNP-00052P-PT; Mon, 29 Jun 2020 14:19:31 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:60615)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcd@tribudubois.net>)
 id 1jpyNN-0007bg-58; Mon, 29 Jun 2020 14:19:31 -0400
X-Originating-IP: 82.252.130.88
Received: from [192.168.1.155] (lns-bzn-59-82-252-130-88.adsl.proxad.net
 [82.252.130.88]) (Authenticated sender: jcd@tribudubois.net)
 by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 8F17A6000A;
 Mon, 29 Jun 2020 18:19:19 +0000 (UTC)
Subject: Re: [PATCH] hw/misc/pca9552: Add missing TypeInfo::class_size field
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200629074704.23028-1-f4bug@amsat.org>
From: Jean-Christophe DUBOIS <jcd@tribudubois.net>
Message-ID: <302e63b8-6bd4-00c0-d7e1-7d938902bb7e@tribudubois.net>
Date: Mon, 29 Jun 2020 20:19:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200629074704.23028-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=217.70.183.195; envelope-from=jcd@tribudubois.net;
 helo=relay3-d.mail.gandi.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 14:19:23
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 29/06/2020 à 09:47, Philippe Mathieu-Daudé a écrit :
> When adding the generic PCA955xClass in commit 736132e455, we
> forgot to set the class_size field. Fill it now to avoid:
>
>    (gdb) run -machine mcimx6ul-evk -m 128M -display none -serial stdio -kernel ./OS.elf
>    Starting program: ../../qemu/qemu/arm-softmmu/qemu-system-arm -machine mcimx6ul-evk -m 128M -display none -serial stdio -kernel ./OS.elf
>    double free or corruption (!prev)
>    Thread 1 "qemu-system-arm" received signal SIGABRT, Aborted.
>    __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:50
>    (gdb) where
>    #0  __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:50
>    #1  0x00007ffff75d8859 in __GI_abort () at abort.c:79
>    #2  0x00007ffff76433ee in __libc_message
>        (action=action@entry=do_abort, fmt=fmt@entry=0x7ffff776d285 "%s\n")
>        at ../sysdeps/posix/libc_fatal.c:155
>    #3  0x00007ffff764b47c in malloc_printerr
>        (str=str@entry=0x7ffff776f690 "double free or corruption (!prev)")
>        at malloc.c:5347
>    #4  0x00007ffff764d12c in _int_free
>        (av=0x7ffff779eb80 <main_arena>, p=0x5555567a3990, have_lock=<optimized out>) at malloc.c:4317
>    #5  0x0000555555c906c3 in type_initialize_interface
>        (ti=ti@entry=0x5555565b8f40, interface_type=0x555556597ad0, parent_type=0x55555662ca10) at qom/object.c:259
>    #6  0x0000555555c902da in type_initialize (ti=ti@entry=0x5555565b8f40)
>        at qom/object.c:323
>    #7  0x0000555555c90d20 in type_initialize (ti=0x5555565b8f40)
>        at qom/object.c:1028
>
>    $ valgrind --track-origins=yes qemu-system-arm -M mcimx6ul-evk -m 128M -display none -serial stdio -kernel ./OS.elf
>    ==77479== Memcheck, a memory error detector
>    ==77479== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
>    ==77479== Using Valgrind-3.15.0 and LibVEX; rerun with -h for copyright info
>    ==77479== Command: qemu-system-arm -M mcimx6ul-evk -m 128M -display none -serial stdio -kernel ./OS.elf
>    ==77479==
>    ==77479== Invalid write of size 2
>    ==77479==    at 0x6D8322: pca9552_class_init (pca9552.c:424)
>    ==77479==    by 0x844D1F: type_initialize (object.c:1029)
>    ==77479==    by 0x844D1F: object_class_foreach_tramp (object.c:1016)
>    ==77479==    by 0x4AE1057: g_hash_table_foreach (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.2)
>    ==77479==    by 0x8453A4: object_class_foreach (object.c:1038)
>    ==77479==    by 0x8453A4: object_class_get_list (object.c:1095)
>    ==77479==    by 0x556194: select_machine (vl.c:2416)
>    ==77479==    by 0x556194: qemu_init (vl.c:3828)
>    ==77479==    by 0x40AF9C: main (main.c:48)
>    ==77479==  Address 0x583f108 is 0 bytes after a block of size 200 alloc'd
>    ==77479==    at 0x483DD99: calloc (in /usr/lib/x86_64-linux-gnu/valgrind/vgpreload_memcheck-amd64-linux.so)
>    ==77479==    by 0x4AF8D30: g_malloc0 (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.2)
>    ==77479==    by 0x844258: type_initialize.part.0 (object.c:306)
>    ==77479==    by 0x844D1F: type_initialize (object.c:1029)
>    ==77479==    by 0x844D1F: object_class_foreach_tramp (object.c:1016)
>    ==77479==    by 0x4AE1057: g_hash_table_foreach (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.2)
>    ==77479==    by 0x8453A4: object_class_foreach (object.c:1038)
>    ==77479==    by 0x8453A4: object_class_get_list (object.c:1095)
>    ==77479==    by 0x556194: select_machine (vl.c:2416)
>    ==77479==    by 0x556194: qemu_init (vl.c:3828)
>    ==77479==    by 0x40AF9C: main (main.c:48)
>
> Fixes: 736132e455 ("hw/misc/pca9552: Add generic PCA955xClass")
> Reported-by: Jean-Christophe DUBOIS <jcd@tribudubois.net>

Tested-by: Jean-Christophe DUBOIS <jcd@tribudubois.net>

> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>   hw/misc/pca9552.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
> index 80caa9ec8f..68b574d084 100644
> --- a/hw/misc/pca9552.c
> +++ b/hw/misc/pca9552.c
> @@ -410,6 +410,7 @@ static const TypeInfo pca955x_info = {
>       .instance_init = pca955x_initfn,
>       .instance_size = sizeof(PCA955xState),
>       .class_init    = pca955x_class_init,
> +    .class_size    = sizeof(PCA955xClass),
>       .abstract      = true,
>   };
>   



