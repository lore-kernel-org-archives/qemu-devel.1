Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09E9C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 12:55:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 893DE23A79
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 12:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 893DE23A79
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51939 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY8yr-0007rL-Jn
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 08:55:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hY8xx-0007Sp-Fa
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 08:55:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hY8xv-0002WN-UT
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 08:55:01 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:56243)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hY8xv-0002TL-Jh; Tue, 04 Jun 2019 08:54:59 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
	1N5UoU-1gVqF812jK-016uXx; Tue, 04 Jun 2019 14:54:16 +0200
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190604093656.23565-1-david@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
	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
Message-ID: <a813de86-33eb-b22e-8d06-054e85e4f074@vivier.eu>
Date: Tue, 4 Jun 2019 14:54:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190604093656.23565-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:U+8TygqZj0tRMADMwaoEIj1EeR1RjTQYJ0pNmFXr2u4SoTJyjWw
	nyeGfqhDzK9OvDoizbYyv9KFNDA9Wp6nQ+d2cQlTXr/eqFAsH8WVjnApWwpaWCVb0q1EB9l
	BUmzVq6FivEysehfO2n2M7CH2399JWWHm+++Y1W7bnxswSKSGyN2fzzQvz/4+NeJPhNVCLX
	Brepbe0JlaNW1BCDJ3IHA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TNvlzzBS7gE=:nUiPm59sP7M3+CivyqTJZa
	WZK8NxQ8vXnm0HySuOy0Dqhy7ShR1Y+k6Ig2Xdytb0GokP/OQYAGhEEzbsi/PcXdCsoCoX98g
	u6LPBPPc5o5Ic3316VFpi2cd6L58ocD2vG4kepTbqwtp+xMbC0AW9ToJasGpsd11knYVqYe0n
	581+1l7jmioVRb4vpG7Q2sTDpVJjuJgeEfRBihuxtNCe9Ei+9jePT2CKvOItX25SjJtjyR4dK
	9BkVWZwrlXH77q4+W3fOlmce8T1WxyKiALW1HpOq/LlgCQl0RfUG0u0E5HZrGnpzn7JfrF9WH
	ewIDDGyz4vY4fDHkxh/jdOj0l6S9o94DMtRawbgm/ecN9YokR0qtg5VnsmrJYicGX2qnlw7f4
	GlUzz1Ure59KLvnfN6d56LG+jNC9B8KQSTiY4IdAIVoG+3Ro7R2UzQSpcF4JYpK6uLV/wOxO1
	ExibTFk3KTzX9ETlkOrI1a/XaPYVTqyfqQSs39O9qtNh8Rh7nycl21Pl9GAR3v8Pe7yIfGzOz
	bSqCVh/+gKYgPyy10PWSHatGCB60OONpWIrbMjLSRhXX8KMbRW5XxVtGKlzMvQZeJYv9E4XC3
	DMNtek0FpoatRTHIowbEdqO+eP6tpJtPErbxxYAxpKAVyy3YnyirnrQdpdR2etuys97oOZlqU
	bO0nDz/imGpyUEo2o5je3e7qjEfJ4PFkHDA62cNUQt5buXcrCm9Mz3Pk27otulChJcX7W7FsY
	Sot6wWWjzR7Zc3QR7OBNtWd1hxjQqxEbWg07ds//8FDTSWWVl+ZPSuSC/Jg=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.133
Subject: Re: [Qemu-devel] [PATCH v1] linux-user: elf: ELF_HWCAP for s390x
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
	Riku Voipio <riku.voipio@iki.fi>,
	Richard Henderson <richard.henderson@linaro.org>,
	qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 04/06/2019 à 11:36, David Hildenbrand a écrit :
> Let's add all HWCAPs that we can support under TCG right now, when the
> respective CPU facilities are enabled.
> 
> Cc: Riku Voipio <riku.voipio@iki.fi>
> Cc: Laurent Vivier <laurent@vivier.eu>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Laurent Vivier <laurent@vivier.eu>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> 
> This patch is based on "[PATCH v2 00/22] s390x/tcg: Vector Instruction
> Support Part 4". I guess it is best if I just include it in my next
> pull request.
Based-on: <20190603090635.10631-1-david@redhat.com>
          [PATCH v2 00/22] s390x/tcg: Vector Instruction Support Part 4

> 
> ---
>  include/elf.h        |  1 +
>  linux-user/elfload.c | 39 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+)
> 
> diff --git a/include/elf.h b/include/elf.h
> index ea7708a4ea..3501e0c8d0 100644
> --- a/include/elf.h
> +++ b/include/elf.h
> @@ -598,6 +598,7 @@ typedef struct {
>  #define HWCAP_S390_ETF3EH       256
>  #define HWCAP_S390_HIGH_GPRS    512
>  #define HWCAP_S390_TE           1024
> +#define HWCAP_S390_VXRS         2048
>  
>  /* M68K specific definitions. */
>  /* We use the top 24 bits to encode information about the
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index a57b7049dd..59b813066c 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -1308,6 +1308,45 @@ static inline void init_thread(struct target_pt_regs *regs,
>  #define ELF_DATA	ELFDATA2MSB
>  #define ELF_ARCH	EM_S390
>  
> +#include "elf.h"
> +
> +#define ELF_HWCAP get_elf_hwcap()
> +
> +static uint32_t get_elf_hwcap(void)
> +{
> +    uint32_t hwcap = 0;
> +
> +    if (s390_has_feat(S390_FEAT_ESAN3)) {
> +        hwcap |= HWCAP_S390_ESAN3;
> +    }
> +    if (s390_has_feat(S390_FEAT_ZARCH)) {
> +        hwcap |= HWCAP_S390_ZARCH;
> +    }
> +    if (s390_has_feat(S390_FEAT_STFLE)) {
> +        hwcap |= HWCAP_S390_STFLE;
> +    }
> +    if (s390_has_feat(S390_FEAT_MSA)) {
> +        hwcap |= HWCAP_S390_MSA;
> +    }
> +    if (s390_has_feat(S390_FEAT_LONG_DISPLACEMENT)) {
> +        hwcap |= HWCAP_S390_LDISP;
> +    }
> +    if (s390_has_feat(S390_FEAT_EXTENDED_IMMEDIATE)) {
> +        hwcap |= HWCAP_S390_EIMM;
> +    }
> +    if (s390_has_feat(S390_FEAT_EXTENDED_TRANSLATION_3) &&
> +        s390_has_feat(S390_FEAT_ETF3_ENH)) {
> +        hwcap |= HWCAP_S390_ETF3EH;
> +    }
> +    /* 31-bit processes can use 64-bit registers */
> +    hwcap |= HWCAP_S390_HIGH_GPRS;
> +    if (s390_has_feat(S390_FEAT_VECTOR)) {
> +        hwcap |= HWCAP_S390_VXRS;
> +    }
> +
> +    return hwcap;
> +}
> +
>  static inline void init_thread(struct target_pt_regs *regs, struct image_info *infop)
>  {
>      regs->psw.addr = infop->entry;
> 

Acked-by: Laurent Vivier <laurent@vivier.eu>

You can also do like the other architectures that use shortcuts like this:

#define GET_FEATURE(feat, hwcap) \
    do { if (s390_has_feat(feat)) { hwcaps |= hwcap; } } while (0)
...
GET_FEATURE(S390_FEAT_VECTOR, HWCAP_S390_VXRS);
...


Thanks,
Laurent

