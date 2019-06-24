Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2A4C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 20:23:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88DBE20663
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 20:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88DBE20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54514 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfVVE-0003x3-Qu
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 16:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33041)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hfVTO-000360-RF
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 16:21:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hfVTN-0000G0-R6
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 16:21:54 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:34427)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hfVTN-0000Cz-IC
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 16:21:53 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MD9CZ-1hnzvm3vUH-0097FK; Mon, 24 Jun 2019 22:21:48 +0200
To: qemu-devel@nongnu.org
References: <20190609143521.19374-1-laurent@vivier.eu>
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
Message-ID: <cff853e2-0044-f75c-575c-2626dd6188db@vivier.eu>
Date: Mon, 24 Jun 2019 22:21:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190609143521.19374-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:4ypRsBMACuk3rNxjDNFDb+I8PFMyYeAqdZztQbd2Og6B4geyK/w
 4Mg4P+i68ur4sbznOvmTDLqgifTclzIXdqYo/DFT4xl+sbpGu3v3vG9VSzPiH87iwImrI36
 5M4QqB0OayPtp+CLY+ce48+CHX8Qnp4wJ7o9+lvG/OxPzaE+Sp9g9WWz4oIOSwIkVknEEG1
 Usl4EJfi4rf5qFJehDXrg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6JuT+ME3s0Q=:rzuHk2vXvum1dyl5LQ7a23
 2D8syGWVTL/gHimPD/+vw0V/OAE2Uh4ik4FikB19pA+LRJKIKLGF/4O+j+UcMELfd0a+wuJz5
 O0AIXZ0DWd2gnlUqgBJQ2PVUWqmzY54fn7WKyNM59CLGxf8CzmTJp0q/2/mYUrlKs2AQukvLa
 qcXw7M8tYowADF8Nbr9c/RKqT/kWSl9aHFdSEX1OZJgaBUunZKtni7bP/qw9DHFFgGqFV8D7o
 LEDkoxR1MKmnyR+J7GkTltL55BeHmqgScJa8mxy3sb+XYmRBTzVREBVZ7uQFl+Wf3u9rLDGJc
 /JCfZYoWm9oB5BDKIOKvN/e/tBKTou7q7aE7R1bnPVc6MW8r5Svnwm+6XZz/cgK6MVet3+Dnb
 0UM7maVzRNVhWWgQHNaCADhUSz+MZoyiciX9YR1hVGjSsV/MqvUvqBlYkQIpX1qHUNMZKJFAK
 Ycn52KA+B6KpS459+WPBZJud8uG8LMB2c/o8YdMRd2B3kZ617ZJlLQzEaWrSeDt44AXLT5lsR
 kFq8JKiDAoKJAUeT7kpWwipg1aqq0P1YXBIoof5fjvV5BbgWYhzr532S9MGE/IQX02J7tgcXZ
 fYX0iTZYhY0dPFOaCDT86SqtExNTtDdiTdH5cGstKbGSq6hQ0FQAzOu9JDfJrv67eNIrI0ssK
 19w0lTb31J/YZI/EcnaKxs9Gl4CjCp67JUF7zG6xf8j90eFgJ7Zs7cI6GCAJRPeD8+A4Lb+EU
 3YDlZ9ey1HsSIrBPUXpvcJbKE07GZ8ANTBzNKXVCi8MmKoHmetbILHQ0oWg=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
Subject: Re: [Qemu-devel] [PATCH 1/2] linux-user: update PPC64 HWCAP2
 feature list
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

Ping?

Le 09/06/2019 à 16:35, Laurent Vivier a écrit :
> QEMU_PPC_FEATURE2_VEC_CRYPTO enables the use
> of VSX instructions in libcrypto that are accelerated
> by the TCG vector instructions now.
> 
> QEMU_PPC_FEATURE2_DARN allows to use the new builtin
> qemu_guest_getrandom() function.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/elfload.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 5451d262ec8e..5751beff1b64 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -768,7 +768,13 @@ enum {
>      QEMU_PPC_FEATURE2_HAS_EBB = 0x10000000, /* Event Base Branching */
>      QEMU_PPC_FEATURE2_HAS_ISEL = 0x08000000, /* Integer Select */
>      QEMU_PPC_FEATURE2_HAS_TAR = 0x04000000, /* Target Address Register */
> +    QEMU_PPC_FEATURE2_VEC_CRYPTO = 0x02000000,
> +    QEMU_PPC_FEATURE2_HTM_NOSC = 0x01000000,
>      QEMU_PPC_FEATURE2_ARCH_3_00 = 0x00800000, /* ISA 3.00 */
> +    QEMU_PPC_FEATURE2_HAS_IEEE128 = 0x00400000, /* VSX IEEE Bin Float 128-bit */
> +    QEMU_PPC_FEATURE2_DARN = 0x00200000, /* darn random number insn */
> +    QEMU_PPC_FEATURE2_SCV = 0x00100000, /* scv syscall */
> +    QEMU_PPC_FEATURE2_HTM_NO_SUSPEND = 0x00080000, /* TM w/o suspended state */
>  };
>  
>  #define ELF_HWCAP get_elf_hwcap()
> @@ -822,8 +828,10 @@ static uint32_t get_elf_hwcap2(void)
>      GET_FEATURE(PPC_ISEL, QEMU_PPC_FEATURE2_HAS_ISEL);
>      GET_FEATURE2(PPC2_BCTAR_ISA207, QEMU_PPC_FEATURE2_HAS_TAR);
>      GET_FEATURE2((PPC2_BCTAR_ISA207 | PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 |
> -                  PPC2_ISA207S), QEMU_PPC_FEATURE2_ARCH_2_07);
> -    GET_FEATURE2(PPC2_ISA300, QEMU_PPC_FEATURE2_ARCH_3_00);
> +                  PPC2_ISA207S), QEMU_PPC_FEATURE2_ARCH_2_07 |
> +                  QEMU_PPC_FEATURE2_VEC_CRYPTO);
> +    GET_FEATURE2(PPC2_ISA300, QEMU_PPC_FEATURE2_ARCH_3_00 |
> +                 QEMU_PPC_FEATURE2_DARN);
>  
>  #undef GET_FEATURE
>  #undef GET_FEATURE2
> 


