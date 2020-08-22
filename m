Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECA5C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 09:55:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22551207DA
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 09:55:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22551207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9QF9-000105-98
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 05:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k9QEW-0000am-LU
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 05:54:44 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:56769)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k9QEQ-0000T4-OG
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 05:54:44 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MHG4W-1kMbW52NBw-00DCyY; Sat, 22 Aug 2020 11:54:33 +0200
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
 qemu-devel@nongnu.org, "Maciej W. Rozycki" <macro@linux-mips.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <20200821222830.91463-1-carenas@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH] linux-user: warn if trying to use qemu-mipsn32[el] with
 non n32 ELF
Message-ID: <9cd49239-a7db-c229-8cf4-fd6ac8faaaa4@vivier.eu>
Date: Sat, 22 Aug 2020 11:54:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200821222830.91463-1-carenas@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:yqfn8g0YXNynC63HdhjH2MqVtdA6FbfsgPGTpwyPROfu8fwB9p5
 pA0u8kOjYC+WaO+Rie7PThzEoI29pOEz00Ce/oqkDRSl3iBYGHHapHj5FUthKwtU2aWCfOf
 bif7407SJ+zLhMsfsvqh0i/+ZDbQmionYVTM4MGQEapQyZ8KINVFk4IkB7uJgTwIG5xtQPv
 phkuEL0aSqjpCU9n8W3dw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JPze92d+ujY=:jPsMZDj8gJ4TDruRv+qxES
 2mciEGqOgnj2y7BJJZDW2lsg96s+uaw3girDvem1ix62d4dblhaTALXhdBP2pt6BlC5oUt2Zo
 KcKNMVh++t5l1LOXCozPYifi8yzbT0nSq6ucXOQTL6Y2UAKElTP64G0fJJORkFSxj54vs9y5p
 y1vkzGZj17861cBxa/5MVLYzkg6Gdeflc0pn6vV2V2j+79yAxn1MuId+obcTxLxXJLRcWp6CS
 M2he8QXo4r7oR64zMdnaLPLHjhAUhc1ILjHFQF55RjHfovhE5XRGAV8/P3SWy1b3R5nDNI+E2
 gn37N9wD8NTXZ2qbUNo2zlssE6YvuJ7lK4GwJGcDi1cPS19+ofrcpj2ELNBMv3Qrx8wxayOjC
 lu3PRdbYG/pcznAOlnLZm0dKJOf7ocrHyOjxzQwllo4g+WvnrBnSycq9gzMjKvHSJWMnPKC78
 TjfVCWbKuzcPxJFpoGjrBDdBqLOHcO3OcZ6du8ucbMZYgnwluJz04CBgRieUQk7x12CvPY6Hs
 7owgHXVLBQ9rTg0/VnbMkPm6ffBrVFDEkdLcRQkZgyH0O0iN51gzG5RrgHpemfxSROWgPUoBU
 a2uzM23fYdaLr5z8Xqw6DqdIpXcWXJZgpCjcolidZnH3bGvZMVkvAGnxuoCzsM2waBrP6EJUF
 MwJMLRQNeRibVPJFJznWApQT3uqnpytbHJSqoyNZSSGeeBjR1ORasl7HGAzFUH9Sf+SAxm74f
 zGEy6tvEZGV/AmVo+cCdT+1TMC+ubeMlO3sPcKXZPf7EgyN5vGS6SHYk9Aru7iPBouLVn4o7Q
 IfRN8gYJG3k36jiEsJBSURD+Fn+d/MGXdlJBBxR30SxLmIqckzI0OPitg9Y3gKOZZFFptQJ
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/22 05:54:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Le 22/08/2020 à 00:28, Carlo Marcelo Arenas Belón a écrit :
> While technically compatible will (depending on the CPU) hopefully fail
> later with a cryptic error:
> 
>   qemu: Unexpected FPU mode
> 
> Provide an earlier hint of what the problem might be by detecting if the
> binary might not be using the n32 ABI and print a warning.
> 
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  linux-user/elfload.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index fe9dfe795d..64c3921cd9 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -2390,6 +2390,13 @@ static void load_elf_image(const char *image_name, int image_fd,
>      if (!elf_check_ehdr(ehdr)) {
>          goto exit_errmsg;
>      }
> +#ifdef TARGET_ABI_MIPSN32
> +/* from arch/mips/include/asm/elf.h */
> +#define EF_MIPS_ABI2 0x00000020

This is already defined in include/elf.h

> +    if (!(ehdr->e_flags & EF_MIPS_ABI2)) {
> +        fprintf(stderr, "warning: ELF binary missing n32 flag\n");

I think an exit would be more appropriate:

    errmsg = "warning: ELF binary missing n32 flag";
    goto exit_errmsg;

> +    }
> +#endif
>  
>      i = ehdr->e_phnum * sizeof(struct elf_phdr);
>      if (ehdr->e_phoff + i <= BPRM_BUF_SIZE) {
> 

CC'ing mips maintainers (and Maciej as he sent a patch on the N32 topic
2 years ago...)

Thanks,
Laurent


