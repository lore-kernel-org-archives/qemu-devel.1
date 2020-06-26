Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24CCC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:55:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8C4320767
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zuaj2/fn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8C4320767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jofSf-0007Dt-Qj
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 23:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jofPZ-0001nw-5E
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:52:21 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:40154)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jofPW-00058O-Gk
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:52:20 -0400
Received: by mail-pj1-x1042.google.com with SMTP id cm23so4376695pjb.5
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 20:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4mFwf/JqqmC2jbvLacbyB+u7kIIaLwrBcw4P6fOKxd4=;
 b=Zuaj2/fnPxZgWulq6vDZ7xVVoutHF9kk/kl3hQ+HwMc4dtyKF2Y7MeXNN9Y/iqWGP1
 wYa3AFMJlOIth2FXvMcgWl8AkOZdMPALFVNd+AttTGlcWbkdYF8bjsZANMwQ9Yur/4s0
 vSzGCb3mNG2XtpwbFYsMN2kD9xcvrlAameMVLrldehqWF3C5av0ijwj96O6lc7P2UJup
 Ddc0i7rRrGzGKeKyeXxxtOi32dR7jNtYGJY7Zsl7ogeHxz6XpBt4ogsQ+nXavGp2xU/s
 8aqXBQCgdDWSvZoiLYLeagHwnk7Ar6Iii1QpN7iwM2F9Hdu44iylFFuzckBYRgkKtFD2
 swMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4mFwf/JqqmC2jbvLacbyB+u7kIIaLwrBcw4P6fOKxd4=;
 b=bDC0uI/THdJjY490uVMFEHAEdEQyZDP5NqCbcYHEEteCB3CFWeuQu94PRlAPD54uje
 PZp0/5AlkPrYxetEzzL9T/RIFZTgOTTbvnHCSku+V7+NegTzLzICDak6oAA71OZnJp/x
 z1wDmlC/bZdwfcBKTgWUCFgXbKkXu0l+GlB3qQFgXHrM6La6iyIjtOKHT1C2iCw/wbkE
 egfTIbaX3BOwfzu8NbmjffUyT/ytO5+h47udDTHRUX/tWi+OuDVu6OMa8L7sdc/x+PF0
 aPbJyDuHp7RpPIYf59hsHoyFVgGdd5bi0G5AJTH47y2dw5WXpvcjHLYVxGOpS3ZgaJA5
 LdYw==
X-Gm-Message-State: AOAM533rO2CTFbltRXJHzxAZkK+aJbz+yuyysfLGL3z89rP5Q7fNa25M
 V3hOQzbrdmHvshNPJzcSzE2tjw==
X-Google-Smtp-Source: ABdhPJzWU/bZVjEE1WvmS9tPfxJ/pHn11ZxQQVZtl1KxgPznUtPDN7+BiSjPW5xiuT8BIQwOHXPR/w==
X-Received: by 2002:a17:90a:7185:: with SMTP id
 i5mr1229885pjk.175.1593143536702; 
 Thu, 25 Jun 2020 20:52:16 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id s23sm20102195pfs.157.2020.06.25.20.52.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2020 20:52:15 -0700 (PDT)
Subject: Re: [PATCH v3 4/8] target/ppc: add vmulld instruction
To: Lijun Pan <ljp@linux.vnet.ibm.com>
References: <20200625170018.64265-1-ljp@linux.ibm.com>
 <20200625170018.64265-5-ljp@linux.ibm.com>
 <b97971e5-43ea-26e4-bd75-7af8d5ae992b@linaro.org>
 <A788F4B0-3E48-4F55-9816-0387A7C5A24B@linux.vnet.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a3ad445a-616c-d9af-18b6-cfb94f126bfd@linaro.org>
Date: Thu, 25 Jun 2020 20:52:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <A788F4B0-3E48-4F55-9816-0387A7C5A24B@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: qemu-ppc@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Lijun Pan <ljp@linux.ibm.com>, qemu-devel@nongnu.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/25/20 2:13 PM, Lijun Pan wrote:
>>>     case INDEX_op_mul_vec:
>>> -        tcg_debug_assert(vece == MO_32 && have_isa_2_07);
>>> -        insn = VMULUWM;
>>> +        tcg_debug_assert((vece == MO_32 && have_isa_2_07) ||
>>> +                         (vece == MO_64 && have_isa_3_10));
>>> +        insn = mul_op[vece];
>>
>> I think it would be ok to just index mul_op here, since the real isa check is
>> to be done elsewhere.
> 
> Just keep "insn = mul_op[vece];"
> and remove"        tcg_debug_assert((vece == MO_32 && have_isa_2_07) ||
>                          (vece == MO_64 && have_isa_3_10));“?

Yes.

> @@ -3016,6 +3016,8 @@int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type,
> unsigned vece)
>              return -1;
>          case MO_32:
>              return have_isa_2_07 ? 1 : -1;
> +        case MO_64:
> +            return have_isa_3_10 ? 1 : -1;
>          }

Actually, just "return have_isa_3_10".

Returning 1 means that the opcode is supported directly.  Returning -1 means
that the opcode can be expanded by tcg_expand_vec_op.  Returning 0 means that
the tcg backend does not support the opcode at all.

> something like below?
> @@ -3712,6 +3712,11 @@static void tcg_target_init(TCGContext *s)
>          have_isa = tcg_isa_3_00;
>      }
>  #endif
> +#ifdef PPC_FEATURE2_ARCH_3_10
> +    if (hwcap2 & PPC_FEATURE2_ARCH_3_10) {
> +        have_isa = tcg_isa_3_10;
> +    }
> +#endif

Certainly this.

> @@ -554,6 +554,7 @@typedef struct {
>  #define PPC_FEATURE2_HTM_NOSC           0x01000000
>  #define PPC_FEATURE2_ARCH_3_00          0x00800000
>  #define PPC_FEATURE2_HAS_IEEE128        0x00400000
> +#define PPC_FEATURE2_ARCH_3_10          0x00200000

Of this I'm not sure.  I didn't even realize these defines were here in
include/elf.h.  For other tcg backends we get the defines from <sys/auxv.h>.

If we do want to update include/elf.h, it should be a separate patch.  CC'ing
Laurent for this.


r~

