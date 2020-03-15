Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272C0C10F29
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 18:15:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEED8206B1
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 18:15:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEED8206B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDXnl-0006RA-QV
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 14:15:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55138)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jDXim-0004Em-Ls
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 14:10:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jDXik-0003zW-P9
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 14:10:44 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:58249)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jDXig-0003Rg-1c; Sun, 15 Mar 2020 14:10:38 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1Mz9EL-1jZLgh0GAd-00wFSO; Sun, 15 Mar 2020 19:10:24 +0100
To: Vincent Fazio <vfazio@xes-inc.com>, qemu-devel@nongnu.org
References: <20200315155202.13107-1-vfazio@xes-inc.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH 1/1] target/ppc: fix ELFv2 signal handler endianness
Message-ID: <346e47c8-4a80-860c-ec55-e38d2021d63d@vivier.eu>
Date: Sun, 15 Mar 2020 19:10:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200315155202.13107-1-vfazio@xes-inc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:HSAkNgkNWHKumEPR4fAtVKdapgxR6zXKplH3ToLX1Ig3qg1Bzki
 BCLgZgT4JA334hpNjVN+pWPKz41gKdUUhpLMZQPzzagv9tLlz0Y96ke7QIaICnV5096qkrF
 w30HkZT/2UsXJzmJukBhjwKx2pJqaYlE7pF3VO55nzUXDbsVjK2I5TLYCJdNxWJKi/RiIo5
 dS/Of+8kGqx/P7avKTf/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EUhjz1IhIH0=:8441MSP/+OgMs6dQraSSG7
 glkae+SSssFwOdymFArZCW7avDEWEzmI1lurpR0QWOFhtsA+d1eFCsjoBatDPYQdi7uhlLIe+
 IvmUukaefU7SF91dcdpfUjBy8tJnd7Mu81JSxBmXZoRApUDmS1PdW09zRntp0i8VMAaN//Xe+
 P4u6saUvxCG/6h2heb6rOfAYeuiyfrvoSrrE8yiAqc8pA6kNPpY7p4BFdxGma3J1zQtwLIUSC
 m4vWidCngQXNO5qjvMZ68ywTOWf8myeaFY+0itn04wS8p29ps5/wfTNp0tiiD3by3k4KYSFVJ
 dLhd59Ec13TCJethpBFGFdPpAbREKRfvQrMp8BeIASQSyn83N7MOv4u5Q0fNDslJhUZC0CLSY
 32MFaiJxHwb4sLlg2Lxgqfgao2mi85msBzkpI2ClBmeMrdw73OemVOpfIFIUMaR2dQCNWzv/g
 EaoXy530KBcwrbGuIC8+vWN6UaZKlZRMCw59onaIHr7SMZcIRwuTkstraAcAy6LlbOWqvxf8P
 +yU8gk1D9CV61Vpg+Drt9BhgZrycSOiJXkt3Rp/wFZDjNiVq7ya8ysi/IOIDLIGcojCCOmJrY
 SlbTiLvzthVaJz3qFRhxfoneG1bBb3e5h8Pw+OWThgj4xXlpsKBTr68uK3BhN83WK7R1FAJds
 aaypP7VKETYMIeA56abyvSlgLhE9SQ7/h98gaGV8WZR71/uo3RE79EJbHWOpsBqjD6FvDdL6e
 1hUH9CqT0koK1G18Xd/wakJ6xk8oTtP67v1unSDndDco3fhNQ1fPA/DJvhNqGK4/+Sfay865S
 1LpFBmFCTFy7wlfUHcFGwiElTswBMAONADfFp83wTjd8wcuA6e6xJ1S05H7auo3YJqXu+z1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
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
Cc: qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>,
 qemu-ppc@nongnu.org, Vincent Fazio <vfazio@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 15/03/2020 à 16:52, Vincent Fazio a écrit :
> From: Vincent Fazio <vfazio@gmail.com>
> 
> In ELFv2, function pointers are entry points and are in host endianness.

"host endianness" is misleading here. "target endianness" is better.

> 
> Previously, the signal handler would be swapped if the target CPU was a
> different endianness than the host. This would cause a SIGSEGV when
> attempting to translate the opcode pointed to by the swapped address.

This is correct.

>  Thread 1 "qemu-ppc64" received signal SIGSEGV, Segmentation fault.
>  0x00000000600a9257 in ldl_he_p (ptr=0x4c2c061000000000) at qemu/include/qemu/bswap.h:351
>  351        __builtin_memcpy(&r, ptr, sizeof(r));
> 
>  #0  0x00000000600a9257 in ldl_he_p (ptr=0x4c2c061000000000) at qemu/include/qemu/bswap.h:351
>  #1  0x00000000600a92fe in ldl_be_p (ptr=0x4c2c061000000000) at qemu/include/qemu/bswap.h:449
>  #2  0x00000000600c0790 in translator_ldl_swap at qemu/include/exec/translator.h:201
>  #3  0x000000006011c1ab in ppc_tr_translate_insn at qemu/target/ppc/translate.c:7856
>  #4  0x000000006005ae70 in translator_loop at qemu/accel/tcg/translator.c:102
> 
> Now, no swap is performed and execution continues properly.
> 
> Signed-off-by: Vincent Fazio <vfazio@gmail.com>
> ---
>  linux-user/ppc/signal.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/linux-user/ppc/signal.c b/linux-user/ppc/signal.c
> index 5b82af6cb6..c7f6455170 100644
> --- a/linux-user/ppc/signal.c
> +++ b/linux-user/ppc/signal.c
> @@ -567,9 +567,13 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
>          env->nip = tswapl(handler->entry);
>          env->gpr[2] = tswapl(handler->toc);
>      } else {
> -        /* ELFv2 PPC64 function pointers are entry points, but R12
> -         * must also be set */
> -        env->nip = tswapl((target_ulong) ka->_sa_handler);
> +        /*
> +         * ELFv2 PPC64 function pointers are entry points and are in host
> +         * endianness so should not to be swapped.

"target endianness"

> +         *
> +         * Note: R12 must also be set.
> +         */
> +        env->nip = (target_ulong) ka->_sa_handler;

The cast is not needed: nip and _sa_handler are abi_ulong.

>          env->gpr[12] = env->nip;
>      }
>  #else
> 

If you repost with the fix I've reported above you can add my:

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Thanks,
Laurent

