Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC7FC10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 22:43:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CCEC218D3
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 22:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JIOGjNyQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CCEC218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60556 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ48Y-00079v-5o
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 18:43:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ45t-0005Ez-5d
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:40:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ3uU-00061Z-3P
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:29:07 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:35089)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJ3uT-0005z4-IO
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:29:06 -0400
Received: by mail-pl1-x643.google.com with SMTP id w24so8212717plp.2
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 15:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=8rj3JOUwXZAX2IMOURsfO+5gQodyIoAh31uqXPbMz84=;
	b=JIOGjNyQRv3lpuPttGXzI5tMqKa/Czgii4Di3xWlItudA7BmN/JuI0yo3+gZRf5SNQ
	HDMBeyPIdT/7d2QSrvwHd7JTlmciX/y+0ooWFw9QfJFA0pR+O25xRTbAHBS+5uP3Hc1s
	z13miUCy2wVsbpLz+Dx70O0JSHHheP0r8CR2RuGIOCedgDXU+PO1qq1ASiyIhB5/xBY7
	MCGc11FY70wPIhcppW+EClpQCk7jcDdXg6KIDqLix01AarvHs+TO/E/VwNhTWrti/VOq
	H8csjQfImBvirRuw/u/F/+Vei7w5G3U9oEe79Av7jqs0YqyLMz0vrT/ftbTbwNQmYczD
	km/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=8rj3JOUwXZAX2IMOURsfO+5gQodyIoAh31uqXPbMz84=;
	b=ILR53tJRemCdbQ79bKzk0BgXF9j1Z76urPYcorf+N/6yPJLMLGT9/cHhV4hzsUjGn1
	uGZoTLHvT0c0dAkHYJK4BdfqzUQYvi5nf5/NrqQTkZpYLNQdhmD6/Io2RxuuwG4wHsUp
	6XOOb+OKG7pOgFzfGrPOPkdBYqNW8hfSuMehoh+4Xoelc4d9S7PzrkWFzibl+HXMQKwB
	x6fsZI/UmaF48Kr2rs0fvtc/YZw3TgLS5JxIAoupu9llT9svsBEDOsrmrfxcXuHGcaYM
	mgkbnjYd/FuVXK1e1OuJ+uZ8ob2EgT4A0NYYLH4hsWnfGDVQVrU/KQEbexUz4ZVz/OJH
	J4Lg==
X-Gm-Message-State: APjAAAVnaEIsMfaY6lMn0gK0ZMRHZHGjgKq9mR8VytwYFitgEpfNwtko
	9T5l4pF4/FNGG/CMCDiYScnpyocoSEY=
X-Google-Smtp-Source: APXvYqyyXkpLgMkiHQr30glC0d2G7ZYtEqNz4lcZVv1afGswhwPmUYQe0ecKR7pHhnC7wxqqxNv76Q==
X-Received: by 2002:a17:902:8c97:: with SMTP id
	t23mr28767423plo.110.1556058544439; 
	Tue, 23 Apr 2019 15:29:04 -0700 (PDT)
Received: from [192.168.1.11] (97-113-179-147.tukw.qwest.net. [97.113.179.147])
	by smtp.gmail.com with ESMTPSA id
	l15sm19214173pfi.79.2019.04.23.15.29.03
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 15:29:03 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20190420073442.7488-1-richard.henderson@linaro.org>
	<20190420073442.7488-20-richard.henderson@linaro.org>
	<e10e5627-25b2-0563-e971-2864256727d6@redhat.com>
	<0bd7fd6a-1fcb-ac0c-b4bf-7b04ada4443c@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <eebc0218-4334-2b68-9081-a3a4d2d12172@linaro.org>
Date: Tue, 23 Apr 2019 15:29:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <0bd7fd6a-1fcb-ac0c-b4bf-7b04ada4443c@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: Re: [Qemu-devel] [PATCH 19/38] tcg: Add support for integer
 absolute value
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423222901.a4sBsFjbpmLTkIgxVDbHyuObJAjx2Q-89IlKrg1PY9E@z>

On 4/23/19 3:09 PM, Philippe Mathieu-Daudé wrote:
> On 4/23/19 8:37 PM, David Hildenbrand wrote:
>> On 20.04.19 09:34, Richard Henderson wrote:
>>> Remove a function of the same name from target/arm/.
>>> Use a branchless implementation of abs that gcc uses for x86.
>>>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>  tcg/tcg-op.h           |  5 +++++
>>>  target/arm/translate.c | 10 ----------
>>>  tcg/tcg-op.c           | 20 ++++++++++++++++++++
>>>  3 files changed, 25 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
>>> index 472b73cb38..660fe205d0 100644
>>> --- a/tcg/tcg-op.h
>>> +++ b/tcg/tcg-op.h
>>> @@ -335,6 +335,7 @@ void tcg_gen_smin_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
>>>  void tcg_gen_smax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
>>>  void tcg_gen_umin_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
>>>  void tcg_gen_umax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
>>> +void tcg_gen_abs_i32(TCGv_i32, TCGv_i32);
>>>  
>>>  static inline void tcg_gen_discard_i32(TCGv_i32 arg)
>>>  {
>>> @@ -534,6 +535,7 @@ void tcg_gen_smin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
>>>  void tcg_gen_smax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
>>>  void tcg_gen_umin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
>>>  void tcg_gen_umax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
>>> +void tcg_gen_abs_i64(TCGv_i64, TCGv_i64);
>>>  
>>>  #if TCG_TARGET_REG_BITS == 64
>>>  static inline void tcg_gen_discard_i64(TCGv_i64 arg)
>>> @@ -973,6 +975,7 @@ void tcg_gen_nor_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
>>>  void tcg_gen_eqv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
>>>  void tcg_gen_not_vec(unsigned vece, TCGv_vec r, TCGv_vec a);
>>>  void tcg_gen_neg_vec(unsigned vece, TCGv_vec r, TCGv_vec a);
>>> +void tcg_gen_abs_vec(unsigned vece, TCGv_vec r, TCGv_vec a);
>>>  void tcg_gen_ssadd_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
>>>  void tcg_gen_usadd_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
>>>  void tcg_gen_sssub_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
>>> @@ -1019,6 +1022,7 @@ void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset, TCGType t);
>>>  #define tcg_gen_addi_tl tcg_gen_addi_i64
>>>  #define tcg_gen_sub_tl tcg_gen_sub_i64
>>>  #define tcg_gen_neg_tl tcg_gen_neg_i64
>>> +#define tcg_gen_abs_tl tcg_gen_abs_i64
>>>  #define tcg_gen_subfi_tl tcg_gen_subfi_i64
>>>  #define tcg_gen_subi_tl tcg_gen_subi_i64
>>>  #define tcg_gen_and_tl tcg_gen_and_i64
>>> @@ -1131,6 +1135,7 @@ void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset, TCGType t);
>>>  #define tcg_gen_addi_tl tcg_gen_addi_i32
>>>  #define tcg_gen_sub_tl tcg_gen_sub_i32
>>>  #define tcg_gen_neg_tl tcg_gen_neg_i32
>>> +#define tcg_gen_abs_tl tcg_gen_abs_i32
>>>  #define tcg_gen_subfi_tl tcg_gen_subfi_i32
>>>  #define tcg_gen_subi_tl tcg_gen_subi_i32
>>>  #define tcg_gen_and_tl tcg_gen_and_i32
>>> diff --git a/target/arm/translate.c b/target/arm/translate.c
>>> index 83a008e945..721171794d 100644
>>> --- a/target/arm/translate.c
>>> +++ b/target/arm/translate.c
>>> @@ -603,16 +603,6 @@ static void gen_sar(TCGv_i32 dest, TCGv_i32 t0, TCGv_i32 t1)
>>>      tcg_temp_free_i32(tmp1);
>>>  }
>>>  
>>> -static void tcg_gen_abs_i32(TCGv_i32 dest, TCGv_i32 src)
>>> -{
>>> -    TCGv_i32 c0 = tcg_const_i32(0);
>>> -    TCGv_i32 tmp = tcg_temp_new_i32();
>>> -    tcg_gen_neg_i32(tmp, src);
>>> -    tcg_gen_movcond_i32(TCG_COND_GT, dest, src, c0, src, tmp);
>>> -    tcg_temp_free_i32(c0);
>>> -    tcg_temp_free_i32(tmp);
>>> -}
>>> -
>>>  static void shifter_out_im(TCGv_i32 var, int shift)
>>>  {
>>>      if (shift == 0) {
>>> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
>>> index a00d1df37e..0ac291f1c4 100644
>>> --- a/tcg/tcg-op.c
>>> +++ b/tcg/tcg-op.c
>>> @@ -1091,6 +1091,16 @@ void tcg_gen_umax_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
>>>      tcg_gen_movcond_i32(TCG_COND_LTU, ret, a, b, b, a);
>>>  }
>>>  
>>> +void tcg_gen_abs_i32(TCGv_i32 ret, TCGv_i32 a)
>>> +{
>>> +    TCGv_i32 t = tcg_temp_new_i32();
>>> +
>>> +    tcg_gen_sari_i32(t, a, 31);
>>> +    tcg_gen_xor_i32(ret, a, t);
>>> +    tcg_gen_sub_i32(ret, ret, t);
>>> +    tcg_temp_free_i32(t);
>>> +}
>>> +
>>>  /* 64-bit ops */
>>>  
>>>  #if TCG_TARGET_REG_BITS == 32
>>> @@ -2548,6 +2558,16 @@ void tcg_gen_umax_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
>>>      tcg_gen_movcond_i64(TCG_COND_LTU, ret, a, b, b, a);
>>>  }
>>>  
>>> +void tcg_gen_abs_i64(TCGv_i64 ret, TCGv_i64 a)
>>> +{
>>> +    TCGv_i64 t = tcg_temp_new_i64();
>>> +
>>> +    tcg_gen_sari_i64(t, a, 63);
>>> +    tcg_gen_xor_i64(ret, a, t);
>>> +    tcg_gen_sub_i64(ret, ret, t);
>>> +    tcg_temp_free_i64(t);
>>> +}
>>> +
>>>  /* Size changing operations.  */
>>>  
>>>  void tcg_gen_extrl_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
>>>
>>
>> Nice trick
> 
> Per commit 7dcfb0897b99, I think it's worth a:
> 
> Inspired-by: Edgar E. Iglesias <edgar.iglesias@gmail.com>

*shrug* As per the comment, I got the sequence from gcc -O2 -S.


r~

