Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3A7C10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 19:22:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8474C217D9
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 19:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WHbWFl1x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8474C217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58550 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ0za-0007Jx-B9
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 15:22:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ0yj-0006zF-Os
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 15:21:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ0yi-0002Iu-1P
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 15:21:17 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:43117)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJ0ye-0002Dd-31
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 15:21:14 -0400
Received: by mail-pg1-x541.google.com with SMTP id z9so8074735pgu.10
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 12:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=KrmZtnmb0AuCVHIup+SZzUx6tbAYpkzxu1Zi85Zjyu0=;
	b=WHbWFl1xeHlXJzppei0+cR0kgU882RSX6VQcw9nlZRsyVZp+Fa8XggMywrpFJLGp6Z
	Dv5sTdg81ISPStIfZJ8NvVbU84FaKTOqpx8VM9CdK0uQj95uIGCL+3y9mxmicYkqpiIJ
	Ey8MAFkGmZbhXd0bYoMINy20pQ4sE/3dP4FOBWClz1aWzsnVbchD27wVwy9uAHpQN8Mh
	/flf4CWQZvQkT4R6+RV2bY6B7ZcM/rU+RGdValPzl/wKnXUeNaRqmrOSPyghxMphgjWa
	ejDZGFPLzi0HkrrYsC5Mb6Cbsd4qryjFS/zNnGeJgz7OXfYBSbMJPd73jQ3lUcjUbnoC
	N9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=KrmZtnmb0AuCVHIup+SZzUx6tbAYpkzxu1Zi85Zjyu0=;
	b=fTa+cRlR+RwuyaROgFiSPLIsBPvoG4JmtL3qyFlKw7VBYnh+A9fB5Om8sRSq/qiIXV
	krVWUnN7A3YyIDHRZ0V9i0NNZKFk2tf5vSE5r6C+WSNzuBGIBxhCy6pt0+VG4aylWWbh
	OikJR3V7bpJjfCxZjYU91omm85Hb7HNJ6KtYOTqhJEyS424hyLXY559U9TjgoAlgSHlq
	KLkoqHM7hDUFHa2q5VDfcVcK+3LtyranaELcw54ndkaSemkHy6grnn0vNqsIkpAdntJb
	sCF1SMOa9ZSiLy1BE70tPnNqdLRtCzRURCv1cQAJtfrjlEd8Jvs7GJlw2neYCNX7Z4Td
	PAhg==
X-Gm-Message-State: APjAAAW7vxQOkx7wuyVLRVYYaiNyRT+qwcXx8rZWRaTwijpxPcEA8Ea0
	JZdffZwCIvBOaKELkln+Yyr6SDTP+hY=
X-Google-Smtp-Source: APXvYqx1q8FmULxuhyJCHYZhK6px9eF70dnGjR0AELz7aTvoredDMdyD2u9S94ad5EFHeNjcsH7yEA==
X-Received: by 2002:a63:6e09:: with SMTP id j9mr26570435pgc.416.1556047269097; 
	Tue, 23 Apr 2019 12:21:09 -0700 (PDT)
Received: from [192.168.1.11] (97-113-179-147.tukw.qwest.net. [97.113.179.147])
	by smtp.gmail.com with ESMTPSA id
	t21sm22405175pfe.22.2019.04.23.12.21.07
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 12:21:08 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190420073442.7488-1-richard.henderson@linaro.org>
	<20190420073442.7488-18-richard.henderson@linaro.org>
	<0d4f60b4-84b7-6d36-b8d6-8107675200ff@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <6824abca-a913-540d-55fe-c05823cc8c06@linaro.org>
Date: Tue, 23 Apr 2019 12:21:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <0d4f60b4-84b7-6d36-b8d6-8107675200ff@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: Re: [Qemu-devel] [PATCH 17/38] tcg: Add gvec expanders for vector
 shift by scalar
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
Message-ID: <20190423192101.Cu9Ng0StlqrH9NHbtjvLm-rozHSkojgvgRoDHbIHjGY@z>

On 4/23/19 11:58 AM, David Hildenbrand wrote:
>> +void tcg_gen_gvec_shls(unsigned vece, uint32_t dofs, uint32_t aofs,
>> +                       TCGv_i32 shift, uint32_t oprsz, uint32_t maxsz);
>> +void tcg_gen_gvec_shrs(unsigned vece, uint32_t dofs, uint32_t aofs,
>> +                       TCGv_i32 shift, uint32_t oprsz, uint32_t maxsz);
>> +void tcg_gen_gvec_sars(unsigned vece, uint32_t dofs, uint32_t aofs,
>> +                       TCGv_i32 shift, uint32_t oprsz, uint32_t maxsz);
> 
> I assume all irrelevant bits of the shift have to be masked off by the
> caller, right?

Correct, just like for integers.

> 
> On s390x, I would use it for (one variant of) VECTOR ELEMENT SHIFT like
> this:
> 
> 
> +static DisasJumpType op_ves(DisasContext *s, DisasOps *o)
> +{
> +    const uint8_t es = get_field(s->fields, m4);
> +    const uint8_t d2 = get_field(s->fields, d2) &
> +                       (NUM_VEC_ELEMENT_BITS(es) - 1);
> +    const uint8_t v1 = get_field(s->fields, v1);
> +    const uint8_t v3 = get_field(s->fields, v3);
> +    TCGv_i32 shift;
> +
> +    if (es > ES_64) {
> +        gen_program_exception(s, PGM_SPECIFICATION);
> +        return DISAS_NORETURN;
> +    }
> +
> +    shift = tcg_temp_new_i32();
> +    tcg_gen_extrl_i64_i32(shift, o->addr1);
> +    tcg_gen_andi_i32(shift, shift, NUM_VEC_ELEMENT_BITS(es) - 1);
> +
> +    switch (s->fields->op2) {
> +    case 0x30:
> +        if (likely(!get_field(s->fields, b2))) {
> +            gen_gvec_fn_2i(shli, es, v1, v3, d2);
> +        } else {
> +            gen_gvec_fn_2s(shls, es, v1, v3, shift);
> +        }
> +        break;
> +    case 0x3a:
> +        if (likely(!get_field(s->fields, b2))) {
> +            gen_gvec_fn_2i(sari, es, v1, v3, d2);
> +        } else {
> +            gen_gvec_fn_2s(sars, es, v1, v3, shift);
> +        }
> +        break;
> +    case 0x38:
> +        if (likely(!get_field(s->fields, b2))) {
> +            gen_gvec_fn_2i(shri, es, v1, v3, d2);
> +        } else {
> +            gen_gvec_fn_2s(shrs, es, v1, v3, shift);
> +        }
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +    tcg_temp_free_i32(shift);
> +    return DISAS_NEXT;
> +}

Looks plausible.  I might have hoisted the b2 == 0 check,
and avoid the other tcg arithmetic when unused.

> Does it still make sense to special-case the const immediate case?

Yes.  We cannot turn non-constant scalar shift into immediate shift, when it
can be shown that the scalar is constant.

x86 (and s390, obviously) has all 3 forms of shift.
aarch64 and powerpc are missing the scalar form, having
only the immediate and vector forms.

The expansion that we do when a form is missing may make it
very difficult to undo via constant propagation.


r~

