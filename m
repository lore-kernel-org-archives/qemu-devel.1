Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498DDC34031
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 21:35:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E9442173E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 21:35:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E9442173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4AWG-0007qW-Ab
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 16:35:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60913)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j4AUO-00065f-Q9
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 16:33:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j4AUN-0002cf-ON
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 16:33:08 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:52829)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1j4AUN-0002aD-FF
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 16:33:07 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MDygG-1jBuGT0jYq-009wXB; Tue, 18 Feb 2020 22:33:05 +0100
Subject: Re: [Qemu-devel] [PATCH] linux-user: Implement membarrier syscall
To: Andreas Schwab <schwab@suse.de>, qemu-devel@nongnu.org
References: <mvmpnomohfm.fsf@suse.de>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <4b3658b0-bcff-d08e-9952-eb3bd636ef6e@vivier.eu>
Date: Tue, 18 Feb 2020 22:33:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <mvmpnomohfm.fsf@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:BwdyeK8JA4TmNT/7dKlI3J7uzJHCxEsPWQwuerukleM1NMkyfXA
 933sDKicGsgfK5+wLKPEVhDyBfzdNIKJGOF3K9N9e0Q4RmcxfZ97UOrSWShJAbiMerE6auD
 0dPEuBpepFVrPkcqsXUvRWC0LjiON/BWj+6h2ZNEezuStT50Kavug2667Q6x9dmNJusC3Wg
 M28yCGVio+6ehZlcFo/kA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0l0kx60rzm8=:x2AsJ6YSqpoWj2ZGLLoqlX
 yxIASoR6pm2sgxkPltIIcDVtVKjwkBrW0Gb1VatYs4P4RlHcFApr6kQcuVL02fOLfei2XOGHN
 SgDHRqI+J9pcvdV6E5Rx61kfbbJ+ZRSrtX8sw3qt7Ew1iN5suzBIkkqiHXaJEgr++aA9dPI5V
 WAV2ad1JzClH+oKqwKWArRXEfvwyWvtVDenYBNetdUYTnJ6cBZXsdyxsYdh5NIjXIIuTB+CQL
 pu6u415fGuz2lB4rfrmLDtS5REMT64IWfADLNdhjXpS6gbZ+9giOEyXa3pPpDzRmOhbPn3jFA
 My7h0Yf/9qcNceKDJqZ3+gkZ7Wu7KPoDeWdZcYv5v7cW0kv56Sbm/Vnbg4aiivm74/KKBT7LI
 UHT7rQrx3gT5uNv/6AJ5Mww1GRIorLEKQZtaNv1qdMQYNEC9ySDVdcmw9FTKt7fF9nx6cSQek
 jSPtHPXLZnfBrOWv6Jh3igfj70VdphQG/VX90PP4rAwyElwSskMYUYh5TdHrGUCuuW7/ymSRy
 CjwrtZ+d5kwqf4wBtPLZYdZXmE0rCGU++wQv5I/pIfEWOWlKUFL6+P3Tot92WvPkuPIy1/vhv
 YOhDPHP0ryX9MkumNTNo8MvHZQN1Nrg9LogyxuvAW2DxlJtBDWXJVTD/Tmyhj4tCPztSQbr8U
 O6LToy3b/3K+X/Lh1Uj0zDW4WtNNJWafFTztYR8W8qBWzUGrovvsB5jCizD0wyzBPBGm4V/d7
 4K7wHpUlkEZu5fOxmraqXLwfmxontDnD/K9Cl91uTeHyKdUZcGDeZ4j+Vw08biqO8HvXgEkg6
 Gaf5WD/GvuLYvqdCr1yaYJTj0aoZT+gi6EqLdszBYlUJq0S6xtl4NSzbmMFX9dqD4d4ParD
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
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

Le 13/05/2019 à 11:02, Andreas Schwab a écrit :
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> ---
>  linux-user/syscall.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index f5ff6f5dc8..80399f4eb0 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -313,6 +313,9 @@ _syscall3(int, getrandom, void *, buf, size_t, buflen, unsigned int, flags)
>  _syscall5(int, kcmp, pid_t, pid1, pid_t, pid2, int, type,
>            unsigned long, idx1, unsigned long, idx2)
>  #endif
> +#if defined(TARGET_NR_membarrier) && defined(__NR_membarrier)
> +_syscall2(int, membarrier, int, cmd, int, flags)
> +#endif
>  
>  static bitmask_transtbl fcntl_flags_tbl[] = {
>    { TARGET_O_ACCMODE,   TARGET_O_WRONLY,    O_ACCMODE,   O_WRONLY,    },
> @@ -11620,6 +11623,10 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>          /* PowerPC specific.  */
>          return do_swapcontext(cpu_env, arg1, arg2, arg3);
>  #endif
> +#if defined TARGET_NR_membarrier && defined __NR_membarrier
> +    case TARGET_NR_membarrier:
> +        return get_errno(membarrier(arg1, arg2));
> +#endif
>  
>      default:
>          qemu_log_mask(LOG_UNIMP, "Unsupported syscall: %d\n", num);
> 

Applied to my linux-user branch.

Thanks,
Laurent

