Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DB4C10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 21:41:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AE1B218D3
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 21:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mZE0Y6Vl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AE1B218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59884 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ3AK-0003Mb-Bu
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 17:41:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ39Y-0002yb-MN
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 17:40:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ39X-0001ka-Ly
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 17:40:36 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:43000)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJ39X-0001h8-DX
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 17:40:35 -0400
Received: by mail-pl1-x642.google.com with SMTP id x15so3801511pln.9
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 14:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=y2BKPxn1lpqjUk/Bl0BtndT7nfcu8b4tSIz3rsMttwc=;
	b=mZE0Y6VlSBEC6SI7Iy3+a7RULxidioXYE5Jm4dVdHoOs0fxIplU8jdyC5iz9u/sGsF
	n/4ou9Xdk0Wocbbh6cYZ2rthacpGzo1d5bab1wVYZKS6e8Gqrat53mNAYnvRfD9wPPdg
	BR8B5yjylyWW4E1eczn4c7GSX9CKDiIPOsWlIiyj2bUF4dF2XbfdTGTy8ZqD+2wxmKCX
	OjiSxkrlR/9m16Sa2rix6Biq/7+eQi59aXiKA4JNT+jy4RqN1xWV+OOQS7xtor76HCJc
	6iaIgc/gf812M0SAekFFg5dUNE2VHA4/6rUt5ATpzHXZUY0szQLLuJBqFxEKhfAt7MQW
	O2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=y2BKPxn1lpqjUk/Bl0BtndT7nfcu8b4tSIz3rsMttwc=;
	b=O+PldnEMvVXVDW3ZSrcm/9/0fSGdg4GOyo1Qvrdwr6ff4SqvLPY2t6VEg19LdAKOQ7
	RoU5Mz7NMZyGpNdowSylwa2CJeDmnum5+144KFzCboRu71NkAnfqNfoFzwHa9CYIRYsU
	AMiRspwd6aPDOwgmsMko9LQplx2JrfNsfxCXy4xcnYO7qD4jeJ5aai8ozNltZfBJ2SQ0
	lEJLGa6h/hp9t+wxsNCQB3wZ2KS+lCfmbKsuba4WM1D3wsmmoMni5RsdjI7RreQnfoeb
	NQmGKaWwPbNQGGs2ccKrYUu5+BaCKipd3nlKtYWHl+o+9wD6sNFkEfTz5vnBaVIYwTmx
	jBjA==
X-Gm-Message-State: APjAAAUKpdbCgJx427MKmUaCMRKS5YKrjIhNvUYtSEGZoeoMK5LMnZA5
	Yf6GmoAcp+SlJZvyN5E1GwqrsmRIGqA=
X-Google-Smtp-Source: APXvYqyx+WZyWiW+eNni9P9jr81nXtMGol8j41oY/tVqpvKrbFeDEfyIwP5drrhEIFqci159ICVgdg==
X-Received: by 2002:a17:902:7e05:: with SMTP id
	b5mr29274415plm.127.1556055629952; 
	Tue, 23 Apr 2019 14:40:29 -0700 (PDT)
Received: from [192.168.1.11] (97-113-179-147.tukw.qwest.net. [97.113.179.147])
	by smtp.gmail.com with ESMTPSA id
	v9sm20545049pgf.73.2019.04.23.14.40.28
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 14:40:29 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190420073442.7488-1-richard.henderson@linaro.org>
	<20190420073442.7488-13-richard.henderson@linaro.org>
	<ab0269a3-c0fd-44c4-f939-e3f073e8e2dd@redhat.com>
	<a32e78bf-e4e4-a808-0c42-95e3b64ed1cf@linaro.org>
	<a2cca8a8-24ca-679e-22ce-500bf111ac8f@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <952ddc67-8012-eb87-3f1f-8ef1f27b93da@linaro.org>
Date: Tue, 23 Apr 2019 14:40:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <a2cca8a8-24ca-679e-22ce-500bf111ac8f@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [PATCH 12/38] tcg: Add gvec expanders for variable
 shift
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
Message-ID: <20190423214027.tO_v6ngl_4wlI_AVDGPqYkH2WMT5i2w-7rz2TbaB6ns@z>

On 4/23/19 2:02 PM, David Hildenbrand wrote:
> On 23.04.19 21:28, Richard Henderson wrote:
>> On 4/23/19 12:04 PM, David Hildenbrand wrote:
>>> In order to use this on s390x for VECTOR ELEMENT SHIFT, like
>>>
>>> +static DisasJumpType op_vesv(DisasContext *s, DisasOps *o)
>>> +{
>>> +    const uint8_t es = get_field(s->fields, m4);
>>> +    const uint8_t v1 = get_field(s->fields, v1);
>>> +    const uint8_t v2 = get_field(s->fields, v2);
>>> +    const uint8_t v3 = get_field(s->fields, v3);
>>> +
>>> +    if (es > ES_64) {
>>> +        gen_program_exception(s, PGM_SPECIFICATION);
>>> +        return DISAS_NORETURN;
>>> +    }
>>> +
>>> +    switch (s->fields->op2) {
>>> +    case 0x70:
>>> +        gen_gvec_fn_3(shlv, es, v1, v2, v3);
>>> +        break;
>>> +    case 0x7a:
>>> +        gen_gvec_fn_3(sarv, es, v1, v2, v3);
>>> +        break;
>>> +    case 0x78:
>>> +        gen_gvec_fn_3(shrv, es, v1, v2, v3);
>>> +        break;
>>> +    default:
>>> +        g_assert_not_reached();
>>> +    }
>>> +
>>> +    return DISAS_NEXT;
>>> +}
>>>
>>> We need to mask of invalid bits from the shift. Can that be added?
>>
>> Yes, I do exactly this in patch 31 for target/ppc.
>>
>>
>> r~
>>
> 
> Got it, so not via a generic gvec expansion. Thanks!

I do wonder if I *should* make the truncating expansion the
generic gvec expansion.  It would be usable from two targets
at least...

Because the one's that *don't* truncate in hardware will
still have to have their own custom expansion code.

Thoughts?


r~

