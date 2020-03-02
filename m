Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05865C3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 14:40:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD57F21775
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 14:40:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD57F21775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33559 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8mEq-0003gO-1q
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 09:40:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33589)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j8mDt-0002uI-Sf
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 09:39:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j8mDs-0001Pu-Jx
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 09:39:09 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:35093)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1j8mDs-0001Pa-BV; Mon, 02 Mar 2020 09:39:08 -0500
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MV2Sk-1izX6o16Dm-00S7nC; Mon, 02 Mar 2020 15:39:00 +0100
To: Lirong Yuan <yuanzi@google.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <20200221202857.126170-1-yuanzi@google.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH] linux-user: Add AT_EXECFN and AT_EXECFD auxval
Message-ID: <f9ef0046-9d0f-c53d-bf58-417df31705a6@vivier.eu>
Date: Mon, 2 Mar 2020 15:38:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200221202857.126170-1-yuanzi@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:uAGHyEfGJdFoYJRogZfs2+tA1sWmxYl9AlB3A0MvYi632elwJMv
 44HhTXD47GPmC2eydGJebwU0iXEz/3ngRNwgJ/NXFc3xGtJOEC1C/CZaKUAIotKCjeSH4oM
 pdyPVIPJ/RoXmYZSzkNfjIu8QNhtdj4JhP7h0uYIqOT7jW0X3zT0heTYm2F2RZpTDtPOCyj
 ah2+jeVisEkhNoXw8cNHA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yLy5Q6FI6b0=:Kurzv/Hjk4KM+ZVneYB5ke
 m+GH4hQKFPRLMnIK0xLq83dGpIMw1MDGw7EUKSQIHZaeLX2BFu3pCh6cDO91Q5yuC3WIm4xfb
 W8c01MMZl4aMhVPUOCAKrLMljdXWXQWGVW5VkNtyAJcZ+0wh/mvf0NZnWRDmuOJ7QkQHCXV3W
 22M3yewMvCn/o9A9MWTUB/zYP4ze0GQul/8k5XscRtxnHab9EJHg9PsDkAOFggclF3wGoFcYM
 wWeHOvatbZUegye24Wv0C3dGHMIvnK3v1Rci/j85fhVQD+ic6oOCT1IlrejGKxVHG86YMWlgb
 Ru8O23OQIxliKpqaLFLwA/mQBvG/3sg7iJvNJJCHm1diC434V8N39wZMuo2bUej3DfHXVLXnM
 7gvZwo8uUA4/rpdiUMmjZwLkFZv/VhZkB4EviNp1+FL8lE8Ddjz6WApN14nuTPx5oLxExup93
 BQx+hjkkKDhUmvR5fz8EJ61Ya6JcRVuM0zaWyS0nDjITfZq++r1bEPt9JZ4GvQeCj2vfVK4It
 NyyfFrexOdoXUcVhwdCDUOgv+DDZ8VkJV6EYPWjiaGHjPxhghnajXAPkU1xJCaqHUmHDN9gEe
 Qh9tGHFWpdHim72mWoR/UtzF1eAcsK/Wl8jSZKA7vm4Q2UGND/n9wKxfsrFTsLdJwoHOxfM7d
 rwpTVVmxrvJfMN3V6AkqILFRuSqK+I8dyb8RJ/o1YppiR89tI3SBLVO5jlvQSDYz3mYWGy+Qx
 BKi+BM4y99lONPVxvIkx7Ulw+OLfW/LTiEtWcNvRYSISJb04gAwrRIKeut/fw2BNNfqZmPKHx
 f3X+huTcz3f/I3xhkULgvu6tl7kEIAt42SkNjaED7M4hUQYnjeeFklZgqDAdrNWMEarYYvK
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.134
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
Cc: Riku Voipio <riku.voipio@iki.fi>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 21/02/2020 à 21:28, Lirong Yuan a écrit :
> This change adds the support for AT_EXECFN and AT_EXECFD auxval.

Why do we need AT_EXECFD?

AT_EXECFD is normally only used with binfmt_misc so I don't see any use
cases for it with QEMU.

For AT_EXECFN, according to kernel commit

  651910874633 execve filename: document and export via auxiliary vector

It sould be like readlink("/proc/self/exe",), and thus I think we should
use realpath() like we have in syscall.c for TARGET_NR_readlink:

 8843     case TARGET_NR_readlink:
...
 8854                 char real[PATH_MAX], *temp;
 8855                 temp = realpath(exec_path, real);
...

Thanks,
Laurent

> 
> Signed-off-by: Lirong Yuan <yuanzi@google.com>
> ---
>  linux-user/elfload.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index f3080a1635..7e0f3042f1 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -1568,7 +1568,7 @@ struct exec
>                                   ~(abi_ulong)(TARGET_ELF_EXEC_PAGESIZE-1))
>  #define TARGET_ELF_PAGEOFFSET(_v) ((_v) & (TARGET_ELF_EXEC_PAGESIZE-1))
>  
> -#define DLINFO_ITEMS 15
> +#define DLINFO_ITEMS 17
>  
>  static inline void memcpy_fromfs(void * to, const void * from, unsigned long n)
>  {
> @@ -1888,11 +1888,14 @@ static abi_ulong loader_build_fdpic_loadmap(struct image_info *info, abi_ulong s
>      return sp;
>  }
>  
> -static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
> +static abi_ulong create_elf_tables(struct linux_binprm *bprm,
>                                     struct elfhdr *exec,
>                                     struct image_info *info,
>                                     struct image_info *interp_info)
>  {
> +    abi_ulong p = bprm->p;
> +    int argc = bprm->argc;
> +    int envc = bprm->envc;
>      abi_ulong sp;
>      abi_ulong u_argc, u_argv, u_envp, u_auxv;
>      int size;
> @@ -2032,6 +2035,8 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
>      NEW_AUX_ENT(AT_CLKTCK, (abi_ulong) sysconf(_SC_CLK_TCK));
>      NEW_AUX_ENT(AT_RANDOM, (abi_ulong) u_rand_bytes);
>      NEW_AUX_ENT(AT_SECURE, (abi_ulong) qemu_getauxval(AT_SECURE));
> +    NEW_AUX_ENT(AT_EXECFN, info->file_string);
> +    NEW_AUX_ENT(AT_EXECFD, bprm->fd);
>  
>  #ifdef ELF_HWCAP2
>      NEW_AUX_ENT(AT_HWCAP2, (abi_ulong) ELF_HWCAP2);
> @@ -2870,8 +2875,8 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
>  #endif
>      }
>  
> -    bprm->p = create_elf_tables(bprm->p, bprm->argc, bprm->envc, &elf_ex,
> -                                info, (elf_interpreter ? &interp_info : NULL));
> +    bprm->p = create_elf_tables(bprm, &elf_ex, info,
> +                                (elf_interpreter ? &interp_info : NULL));
>      info->start_stack = bprm->p;
>  
>      /* If we have an interpreter, set that as the program's entry point.
> 


