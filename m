Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43339C04AA9
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 15:48:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D18B20675
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 15:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q0UyGpEH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D18B20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53394 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMDwL-0006Ze-8B
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 11:48:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMDur-0005w3-Gh
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:46:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMDuq-0001dE-Jj
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:46:33 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:46246)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMDuq-0001cw-Ah
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:46:32 -0400
Received: by mail-pf1-x429.google.com with SMTP id j11so1304624pff.13
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 08:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=31TT8caF/k3/4hWX/eHFb+0fJ/oy+Od2Gs+n119hb4E=;
	b=q0UyGpEHunBQoSXRtUF/DL604AQvOJjgBtN2WAcEkWAeygdM3qrVqMMDC725+Vpgd5
	PkIt8zBM5XoCzJc1rxZ8DF7Qw5QQwckK+Va9TJTVAgB1L/kzIIihIDrsxeIrYiVWOQWr
	M4xHqGZuhARYZlXBeekU5CmTmNzBdZVxx9skpq3gLhGdAYQh8iZBu+29EGV+DeAbhgh/
	ELHsYlT+G0KMMgBPM1Gn58QAQhWTrY0OexCB2QPyPaw3pcGZL8QG01qVdEYkfy+w2xZJ
	WHCrdIfLfLn3oMB5OiDVxYw3jY+kte0ZtFcZwofHr0EbT+LBCaLn4BzBXGgKcl4nO0nl
	ryqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=31TT8caF/k3/4hWX/eHFb+0fJ/oy+Od2Gs+n119hb4E=;
	b=GhyM1MYwJ2Q3pILjd6+4H112Paz5ty0B79znS4WFhBX22gGuiNkaatMf8JJdsRv4lb
	IYETwA9oaTweIlG5KG2wR2lI9hvSSJ2vXKJXXX7KxHA+yeVblMLK6sOm7vO3zlbN/lvc
	5Rn+rtI6MKgtxXFIfPikthq02Ixmd+1Y7csH3lA1aYpulfcDRXudqQ9beYwEKoaqT5x8
	GmNYhhfEXh1n6zwY2bTjOvLo30oBHXV9vZHAu1z96o0hN/VSP2iER+uAuSjwHX2YxWLm
	KQjTFxmDGogDqc6AxEpIXwro5N5gpiVU/h3kQI2hN5jdd0xD/YwlEIp9CcmBw3KZo6wy
	y1NA==
X-Gm-Message-State: APjAAAUuVphMK32FULtmKj62MoYV5SHxMCViCneiGdyld2G5IUwlHSNM
	RG16qODXhWgDBkWtzXBsWYIN92ebFGQ=
X-Google-Smtp-Source: APXvYqyxlNUL8yKvyj7OmHpQAC8AH0xmGZeFc6V8dOxW0PfT6uK/1S4H49Ay3B7i3j7lpAUG0YLX/Q==
X-Received: by 2002:aa7:93bb:: with SMTP id x27mr4879110pff.104.1556811990500; 
	Thu, 02 May 2019 08:46:30 -0700 (PDT)
Received: from [192.168.1.11] (97-113-189-189.tukw.qwest.net. [97.113.189.189])
	by smtp.gmail.com with ESMTPSA id
	s9sm56017435pfe.183.2019.05.02.08.46.29
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 02 May 2019 08:46:29 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
References: <20190501050536.15580-1-richard.henderson@linaro.org>
	<20190501050536.15580-18-richard.henderson@linaro.org>
	<878svo6hxq.fsf@zen.linaroharston>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <018043d5-9c52-31ce-a241-9119fbdf77a2@linaro.org>
Date: Thu, 2 May 2019 08:46:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <878svo6hxq.fsf@zen.linaroharston>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::429
Subject: Re: [Qemu-devel] [PATCH v2 17/29] tcg: Add gvec expanders for
 vector shift by scalar
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
Message-ID: <20190502154627.r30whyZlOpg7dnySWr7cB9m8TgKoH4BFGUqvDmZvph4@z>

On 5/2/19 7:37 AM, Alex Bennée wrote:
>> +void tcg_gen_gvec_shls(unsigned vece, uint32_t dofs, uint32_t aofs,
>> +                       TCGv_i32 shift, uint32_t oprsz, uint32_t maxsz)
>> +{
>> +    static const TCGOpcode scalar_list[] = { INDEX_op_shls_vec, 0 };
>> +    static const TCGOpcode vector_list[] = { INDEX_op_shlv_vec, 0 };
>> +    static gen_helper_gvec_2 * const fno[4] = {
>> +        gen_helper_gvec_shl8i,
>> +        gen_helper_gvec_shl16i,
>> +        gen_helper_gvec_shl32i,
>> +        gen_helper_gvec_shl64i,
>> +    };
>> +
>> +    tcg_debug_assert(vece <= MO_64);
>> +    do_gvec_shifts(vece, dofs, aofs, shift, oprsz, maxsz,
>> +                   vece == MO_32 ? tcg_gen_shl_i32 : NULL,
>> +                   vece == MO_64 ? tcg_gen_shl_i64 : NULL,
>> +                   tcg_gen_shls_vec, tcg_gen_shlv_vec, fno[vece],
>> +                   scalar_list, vector_list);
> 
> Hmm I guess:
> 
>     static GVecGenFoo const ops[4] = {
>         {
>             .fno = gen_helper_gvec_shl8i
>         },
>         {
>             .fno = gen_helper_gvec_shl16i
>         },
>         {
>             .fno = gen_helper_gvec_shl32i,
>             .fni4 = tcg_gen_shl_i32
>         },
>         {
>             .fno = gen_helper_gvec_shl64i,
>             .fni8 = tcg_gen_shl_i64
>         }
>     };
>     tcg_debug_assert(vece <= MO_64);
>     do_gvec_shifts(vece, dofs, aofs, shift, oprsz, maxsz, &ops[vece],
>                    tcg_gen_shls_vec, tcg_gen_shlv_vec,
>                    scalar_list, vector_list);
> 
> gets a little verbose....

That's exactly it.

The GVecGenFoo structures were created so that front ends would be able to
define their own.  For that I wanted full generality.  This case didn't seem to
warrant that.

I suppose I could create a denser GVecGenFoo for this case.
Which actually seems like a good idea now I think about it.

r~

