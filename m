Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8897C31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 08:07:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82176205ED
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 08:07:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82176205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35754 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdVdH-0004BC-8I
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 04:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39580)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hdVbZ-0002LO-TW
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 04:06:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hdVbY-0006kp-9s
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 04:06:05 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:44689)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hdVbX-0006gO-Sw
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 04:06:04 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MYN3E-1i8ly93XKk-00VM4c; Wed, 19 Jun 2019 10:05:52 +0200
To: Jim Wilson <jimw@sifive.com>, qemu-devel@nongnu.org
References: <20190618223252.10907-1-jimw@sifive.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 mQINBFYFJhkBEAC2me7w2+RizYOKZM+vZCx69GTewOwqzHrrHSG07MUAxJ6AY29/+HYf6EY2
 WoeuLWDmXE7A3oJoIsRecD6BXHTb0OYS20lS608anr3B0xn5g0BX7es9Mw+hV/pL+63EOCVm
 SUVTEQwbGQN62guOKnJJJfphbbv82glIC/Ei4Ky8BwZkUuXd7d5NFJKC9/GDrbWdj75cDNQx
 UZ9XXbXEKY9MHX83Uy7JFoiFDMOVHn55HnncflUncO0zDzY7CxFeQFwYRbsCXOUL9yBtqLer
 Ky8/yjBskIlNrp0uQSt9LMoMsdSjYLYhvk1StsNPg74+s4u0Q6z45+l8RAsgLw5OLtTa+ePM
 JyS7OIGNYxAX6eZk1+91a6tnqfyPcMbduxyBaYXn94HUG162BeuyBkbNoIDkB7pCByed1A7q
 q9/FbuTDwgVGVLYthYSfTtN0Y60OgNkWCMtFwKxRaXt1WFA5ceqinN/XkgA+vf2Ch72zBkJL
 RBIhfOPFv5f2Hkkj0MvsUXpOWaOjatiu0fpPo6Hw14UEpywke1zN4NKubApQOlNKZZC4hu6/
 8pv2t4HRi7s0K88jQYBRPObjrN5+owtI51xMaYzvPitHQ2053LmgsOdN9EKOqZeHAYG2SmRW
 LOxYWKX14YkZI5j/TXfKlTpwSMvXho+efN4kgFvFmP6WT+tPnwARAQABtCJMYXVyZW50IFZp
 dmllciA8bGF1cmVudEB2aXZpZXIuZXU+iQI4BBMBAgAiBQJWBTDeAhsDBgsJCAcDAgYVCAIJ
 CgsEFgIDAQIeAQIXgAAKCRDzDDi9Py++PCEdD/oD8LD5UWxhQrMQCsUgLlXCSM7sxGLkwmmF
 ozqSSljEGRhffxZvO35wMFcdX9Z0QOabVoFTKrT04YmvbjsErh/dP5zeM/4EhUByeOS7s6Yl
 HubMXVQTkak9Wa9Eq6irYC6L41QNzz/oTwNEqL1weV1+XC3TNnht9B76lIaELyrJvRfgsp9M
 rE+PzGPo5h7QHWdL/Cmu8yOtPLa8Y6l/ywEJ040IoiAUfzRoaJs2csMXf0eU6gVBhCJ4bs91
 jtWTXhkzdl4tdV+NOwj3j0ukPy+RjqeL2Ej+bomnPTOW8nAZ32dapmu7Fj7VApuQO/BSIHyO
 NkowMMjB46yohEepJaJZkcgseaus0x960c4ua/SUm/Nm6vioRsxyUmWd2nG0m089pp8LPopq
 WfAk1l4GciiMepp1Cxn7cnn1kmG6fhzedXZ/8FzsKjvx/aVeZwoEmucA42uGJ3Vk9TiVdZes
 lqMITkHqDIpHjC79xzlWkXOsDbA2UY/P18AtgJEZQPXbcrRBtdSifCuXdDfHvI+3exIdTpvj
 BfbgZAar8x+lcsQBugvktlQWPfAXZu4Shobi3/mDYMEDOE92dnNRD2ChNXg2IuvAL4OW40wh
 gXlkHC1ZgToNGoYVvGcZFug1NI+vCeCFchX+L3bXyLMg3rAfWMFPAZLzn42plIDMsBs+x2yP
 +bkCDQRWBSYZARAAvFJBFuX9A6eayxUPFaEczlMbGXugs0mazbOYGlyaWsiyfyc3PStHLFPj
 rSTaeJpPCjBJErwpZUN4BbpkBpaJiMuVO6egrC8Xy8/cnJakHPR2JPEvmj7Gm/L9DphTcE15
 92rxXLesWzGBbuYxKsj8LEnrrvLyi3kNW6B5LY3Id+ZmU8YTQ2zLuGV5tLiWKKxc6s3eMXNq
 wrJTCzdVd6ThXrmUfAHbcFXOycUyf9vD+s+WKpcZzCXwKgm7x1LKsJx3UhuzT8ier1L363RW
 ZaJBZ9CTPiu8R5NCSn9V+BnrP3wlFbtLqXp6imGhazT9nJF86b5BVKpF8Vl3F0/Y+UZ4gUwL
 d9cmDKBcmQU/JaRUSWvvolNu1IewZZu3rFSVgcpdaj7F/1aC0t5vLdx9KQRyEAKvEOtCmP4m
 38kU/6r33t3JuTJnkigda4+Sfu5kYGsogeYG6dNyjX5wpK5GJIJikEhdkwcLM+BUOOTi+I9u
 tX03BGSZo7FW/J7S9y0l5a8nooDs2gBRGmUgYKqQJHCDQyYut+hmcr+BGpUn9/pp2FTWijrP
 inb/Pc96YDQLQA1q2AeAFv3Rx3XoBTGl0RCY4KZ02c0kX/dm3eKfMX40XMegzlXCrqtzUk+N
 8LeipEsnOoAQcEONAWWo1HcgUIgCjhJhBEF0AcELOQzitbJGG5UAEQEAAYkCHwQYAQIACQUC
 VgUmGQIbDAAKCRDzDDi9Py++PCD3D/9VCtydWDdOyMTJvEMRQGbx0GacqpydMEWbE3kUW0ha
 US5jz5gyJZHKR3wuf1En/3z+CEAEfP1M3xNGjZvpaKZXrgWaVWfXtGLoWAVTfE231NMQKGoB
 w2Dzx5ivIqxikXB6AanBSVpRpoaHWb06tPNxDL6SVV9lZpUn03DSR6gZEZvyPheNWkvz7bE6
 FcqszV/PNvwm0C5Ju7NlJA8PBAQjkIorGnvN/vonbVh5GsRbhYPOc/JVwNNr63P76rZL8Gk/
 hb3xtcIEi5CCzab45+URG/lzc6OV2nTj9Lg0SNcRhFZ2ILE3txrmI+aXmAu26+EkxLLfqCVT
 ohb2SffQha5KgGlOSBXustQSGH0yzzZVZb+HZPEvx6d/HjQ+t9sO1bCpEgPdZjyMuuMp9N1H
 ctbwGdQM2Qb5zgXO+8ZSzwC+6rHHIdtcB8PH2j+Nd88dVGYlWFKZ36ELeZxD7iJflsE8E8yg
 OpKgu3nD0ahBDqANU/ZmNNarBJEwvM2vfusmNnWm3QMIwxNuJghRyuFfx694Im1js0ZY3LEU
 JGSHFG4ZynA+ZFUPA6Xf0wHeJOxGKCGIyeKORsteIqgnkINW9fnKJw2pgk8qHkwVc3Vu+wGS
 ZiJK0xFusPQehjWTHn9WjMG1zvQ5TQQHxau/2FkP45+nRPco6vVFQe8JmgtRF8WFJA==
Message-ID: <02b2cb91-2944-4eac-947b-e88067a020dd@vivier.eu>
Date: Wed, 19 Jun 2019 10:05:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190618223252.10907-1-jimw@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:yEuFlY8yBE76f9LtA8do2lqruMB5Oo78nPMCpd5kJMVCZtuEf4Q
 pE/BkPpTeDf7HAkgGlSzqLhiTN1KBul3Kq6IuMixOe8xfCfwuky1sYfzWFlr4+5wHYoLCVa
 B6jYwBgXknKQpzLEv1hCvf4eVX0qEaYeUVUYutWfrOVIDxhhXClMlm3pDhEdOcFyh+/VEhB
 2oQ1wJxeqlsmJVUUOP9XQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dN2B6L5X7dA=:uwzkl+igZXpmVIlsODSWwZ
 9nnQxvZLD3k9DW7MqXl8PmzW82sPhaLqo6dP20m5tfgX026F1+54aFjI74YetCtWbLO65T3VF
 7fi7oX9gbOXFtShMSXzfPaMCzvBeLIQMUCGYSS6qVM+yADsG426YSXk8rwTFXEn+EMXwFE4ZW
 YcYH2L9aflzcHhKyiv5J6BMDEaHndXyeCRJ1gBlDZGx58cywP61P3UZt5+YcRpf7wdPs1xgPX
 dtHuvYANGixT/AZACSnKRoWIM9ggv5DGyl/yBH+eC5zFPbtWptMDaNCY7t5hD0OQ46vXg76iM
 yhWR3VtC2B43/tRnsBOlh4HNICw6nVa/h7DAJ3lsXyZdyItoUSPShHJkPxE9KBXP/NTBAjxrA
 UmvCMpRA2dAlVAlQCAvONOpBmYNWZlxYpXMM/AEBDzSls9f6hP2p2Xsu5zcwafGtRl+5j89uW
 VvKd2usv+aFghKpBXVqV3uBHIxQ7Lmq/Xqt1zsnaE76JdOLVHvdaNfPzFFabUO+Rtt2diRTt0
 30fC9qrfNXABi0pStrGO2UPXhww5SEP9eZo4wUCYEeHegRSKGgzp8MjjuiiR+s3y6h2+Sdg6R
 LphmMixBWBUe4O9EY/A0jnvHlSHYu08BVEPJUS9of1iWWfUzPWcGFcJBx7bk4wru+EZP/u3/t
 TrGKyXEDONhUEB/6yzxF/Rq+62HaysFxPMKqfIQUvY4ftWmQc4lEMtInXEDCTjygIqbH9QkUJ
 LQPpkb8d+KU7zXPOcvvhbVYQxdWuC/6YKsznEf+ES7h6+SOGESz9M/IbzKk=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
Subject: Re: [Qemu-devel] [PATCH] RISC-V: Update syscall list for 32-bit
 support.
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

Le 19/06/2019 à 00:32, Jim Wilson a écrit :
> 32-bit RISC-V uses _llseek instead of lseek as syscall number 62.
> Update syscall list from open-embedded build, primarily because
> 32-bit RISC-V requires statx support.
> 
> Tested with cross gcc testsuite runs for rv32 and rv64, with the
> pending statx patch also applied.
> 
> Signed-off-by: Jim Wilson <jimw@sifive.com>
> ---
>  linux-user/riscv/syscall_nr.h | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/riscv/syscall_nr.h b/linux-user/riscv/syscall_nr.h
> index dab6509..5c87282 100644
> --- a/linux-user/riscv/syscall_nr.h
> +++ b/linux-user/riscv/syscall_nr.h
> @@ -72,7 +72,11 @@
>  #define TARGET_NR_pipe2 59
>  #define TARGET_NR_quotactl 60
>  #define TARGET_NR_getdents64 61
> +#ifdef TARGET_RISCV32
> +#define TARGET_NR__llseek 62
> +#else
>  #define TARGET_NR_lseek 62
> +#endif
>  #define TARGET_NR_read 63
>  #define TARGET_NR_write 64
>  #define TARGET_NR_readv 65
> @@ -286,7 +290,16 @@
>  #define TARGET_NR_membarrier 283
>  #define TARGET_NR_mlock2 284
>  #define TARGET_NR_copy_file_range 285
> +#define TARGET_NR_preadv2 286
> +#define TARGET_NR_pwritev2 287
> +#define TARGET_NR_pkey_mprotect 288
> +#define TARGET_NR_pkey_alloc 289
> +#define TARGET_NR_pkey_free 290
> +#define TARGET_NR_statx 291
> +#define TARGET_NR_io_pgetevents 292
> +#define TARGET_NR_rseq 293
> +#define TARGET_NR_kexec_file_load 294
>  
> -#define TARGET_NR_syscalls (TARGET_NR_copy_file_range + 1)
> +#define TARGET_NR_syscalls (TARGET_NR_kexec_file_load + 1)
>  
>  #endif
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

