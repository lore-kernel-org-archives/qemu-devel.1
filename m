Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5113C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:38:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB05721726
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:38:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB05721726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1Bdr-0007Vy-Sb
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 11:38:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33731)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i1BaG-0003rV-Qi
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:34:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i1BaF-0005RH-KG
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:34:36 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:42793)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i1BaF-0005QB-BM
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:34:35 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1Mv2gw-1iIzTz0tKC-00r0ek; Fri, 23 Aug 2019 17:34:31 +0200
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190809171156.3476-1-richard.henderson@linaro.org>
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
Message-ID: <12d0963e-9574-1548-4ce2-b12a4a8b8889@vivier.eu>
Date: Fri, 23 Aug 2019 17:34:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190809171156.3476-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ODvRifHXcw+kOyE73qZRdeqYM/dOTIgU+A8df+kaDsv6IUOR5uR
 QFbq4vU21Uz5aOCp8TsngMTPTeo61b8D1COlMJPF/b4xBlQYMgFLCGZL8HQTBs0WaNfge+f
 Eq1pgHrVzB6qSBlauLWE7IMyfg/8/Y6d1/u6xcu55LZzPV+OYWRu5CWWB5HncJulOvkJgQB
 fbOHXEt2ztA/95T8doa/Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UermVlx0XGQ=:oTNmdugJTbJGDgS0q2oMIB
 dhVKLsBbeqTziSGtN3tQru5acHb70daStk7G8bXOYHYu+5OJV2r6/r2gX1DxqB/60yZ1rsI/I
 k1fa2JgocdPAbKhFuIlnSRgc9VBp3SP96YIY1mpC1EJxNJf6orV0/3f+FSgFEyOfBofigVkWf
 MlxnzXqu0SnSlMS8nwzWLbove1B2qkaOcZ/6Y6AIW/QUhIYSmZbWguxczyPUxmx4zZtzombTH
 KGsUYUengCGEGIIRGAwY79ASjYMZ5G/Zk4aycT8Ir/ecutjrtlM/CaggI217bu9aJ3Qqhg2ET
 CINaKO7P2dGoM5XI60hIEiDblkIytDaAYh4NOCRa22zFoU713hMzp5MwcsccoVJ7hvruT9g56
 ja2N7xkkV9xcgayV7FHK7pzZ/1A1eHHHpRcur2SYTUpqUJzfnPK8u7ZxjqMw6WyH0iAOJBtwC
 dPzTbKpJf/vlbaSh8pIHUJipxyV52A0maeoL5lNUtT3aWT/xfkXBscVShq5LrheG/Zs6ZTTgM
 scaPNgn/B++UdK2TZxHJg3PUqMMIlzsVe9ORa1wKdCek40Az+Yt+JnKUeIBiSm5vitQYgtKxU
 duQnfdrPOCd0yiGSH5mAzrLWoyzqcy0VfMQUZrQ98dneRvVNNPQEd8QQ0WXtmzooPRiXuXmlH
 fT2hxXzPvpGDGRzSJpzF0dKWAiWSnlZ1c1f9E48+W/ehoqVFUFI6nc5oXHCCV76zxgefw1u3t
 Zhs/IN1tSPfjZ/FZ2aOQfOkxKyXygOqjl8/ho2uOFzPP8q1xGgapfa5BDOI=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
Subject: Re: [Qemu-devel] [PATCH] linux-user: Add AT_HWCAP2 for
 aarch64-linux-user
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 09/08/2019 à 19:11, Richard Henderson a écrit :
> Add the HWCAP2_* bits from kernel version v5.3-rc3.
> Enable the bits corresponding to ARMv8.5-CondM and ARMv8.5-FRINT.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c | 31 +++++++++++++++++++++++++++----
>  1 file changed, 27 insertions(+), 4 deletions(-)
> ---
> 
> The HWCAP2_FLAGM2 and HWCAP2_FRINT bits came in during the 
> last merge window and will be in the upcoming v5.3 release.
> We don't yet implement any of the other extensions that make
> up the rest of the HWCAP2 bits.
> 
> 
> r~
> 
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index bd43c4817d..4fd2f46f18 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -606,9 +606,23 @@ enum {
>      ARM_HWCAP_A64_SB            = 1 << 29,
>      ARM_HWCAP_A64_PACA          = 1 << 30,
>      ARM_HWCAP_A64_PACG          = 1UL << 31,
> +
> +    ARM_HWCAP2_A64_DCPODP       = 1 << 0,
> +    ARM_HWCAP2_A64_SVE2         = 1 << 1,
> +    ARM_HWCAP2_A64_SVEAES       = 1 << 2,
> +    ARM_HWCAP2_A64_SVEPMULL     = 1 << 3,
> +    ARM_HWCAP2_A64_SVEBITPERM   = 1 << 4,
> +    ARM_HWCAP2_A64_SVESHA3      = 1 << 5,
> +    ARM_HWCAP2_A64_SVESM4       = 1 << 6,
> +    ARM_HWCAP2_A64_FLAGM2       = 1 << 7,
> +    ARM_HWCAP2_A64_FRINT        = 1 << 8,
>  };
>  
> -#define ELF_HWCAP get_elf_hwcap()
> +#define ELF_HWCAP   get_elf_hwcap()
> +#define ELF_HWCAP2  get_elf_hwcap2()
> +
> +#define GET_FEATURE_ID(feat, hwcap) \
> +    do { if (cpu_isar_feature(feat, cpu)) { hwcaps |= hwcap; } } while (0)
>  
>  static uint32_t get_elf_hwcap(void)
>  {
> @@ -620,8 +634,6 @@ static uint32_t get_elf_hwcap(void)
>      hwcaps |= ARM_HWCAP_A64_CPUID;
>  
>      /* probe for the extra features */
> -#define GET_FEATURE_ID(feat, hwcap) \
> -    do { if (cpu_isar_feature(feat, cpu)) { hwcaps |= hwcap; } } while (0)
>  
>      GET_FEATURE_ID(aa64_aes, ARM_HWCAP_A64_AES);
>      GET_FEATURE_ID(aa64_pmull, ARM_HWCAP_A64_PMULL);
> @@ -644,11 +656,22 @@ static uint32_t get_elf_hwcap(void)
>      GET_FEATURE_ID(aa64_sb, ARM_HWCAP_A64_SB);
>      GET_FEATURE_ID(aa64_condm_4, ARM_HWCAP_A64_FLAGM);
>  
> -#undef GET_FEATURE_ID
> +    return hwcaps;
> +}
> +
> +static uint32_t get_elf_hwcap2(void)
> +{
> +    ARMCPU *cpu = ARM_CPU(thread_cpu);
> +    uint32_t hwcaps = 0;
> +
> +    GET_FEATURE_ID(aa64_condm_5, ARM_HWCAP2_A64_FLAGM2);
> +    GET_FEATURE_ID(aa64_frint, ARM_HWCAP2_A64_FRINT);
>  
>      return hwcaps;
>  }
>  
> +#undef GET_FEATURE_ID
> +
>  #endif /* not TARGET_AARCH64 */
>  #endif /* TARGET_ARM */
>  
> 

Applied to my linux-user branch.

Thanks,
Laurent

