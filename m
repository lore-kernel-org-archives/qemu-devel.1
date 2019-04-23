Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81A5C10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 19:29:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 712F521850
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 19:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RaPEMALC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 712F521850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58601 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ16L-0001MI-Lf
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 15:29:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ15Z-00011M-2h
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 15:28:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ15X-000298-Ut
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 15:28:20 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:35317)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJ15W-00026J-Tj
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 15:28:19 -0400
Received: by mail-pl1-x641.google.com with SMTP id w24so8013022plp.2
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 12:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=W3g1Mf+FvK0xJyHE/6keoEN21QOZZ92P+ajrZiGvZEU=;
	b=RaPEMALCnk4imdiJ7Ii6VnOTgq323EOBvmmcJnLqqrxNiIRZdSRt0jhatYrGd5/6lf
	LRrUAx26SNkHfcZIHJoOC+tJrhu8Gy+dYqrZeghZ/JnaiJjPObauHu7gJMmKMkA3XfXu
	R8JeAWRI7ZTIsTNJUNouyzC7vOamC6ykm4d1HhYFSgv+NNY8dpFU8XBzy+2TpBlNJqgm
	HznomUjdcQWzc5h+nTJlmr+CE71Lf/0F0JiveTNdf475thY7XND7lJiBnTgk6T5kMJeU
	uGffdAywHOjOED9s/XZZ4d6FxWQQM/WAwzq/Wj/DSz/YV0f20lZHWJUXIhGL2RMvI5sz
	Olwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=W3g1Mf+FvK0xJyHE/6keoEN21QOZZ92P+ajrZiGvZEU=;
	b=SCLObQm6KgjI994DIEJ+OMipqdrMV6JN9NP6iMaviMMM8HlPoNvRZdsVtnMnBcexhg
	Poo5II5ef/V4533MPW/2dzqtRIsNKac5km5vFjrBhaDN+RvvToWNyduMyXL7sbZ1kW6f
	Xe7l+46A9a+P0YOoJXTX8qqQSjsCpb5zIyISSjMoL4Nq9SSyaNHau+GrW7AzWRNb1DWn
	CHI3YESxWMrakblUOe9MdxPkAGmdC+DOoafC/ym4gNjaKcousW5FzHE6X9/MnMzR9SQ7
	H1Zo/n4vRiwrwNVZuiVJ9QaFWRysiNvyUTmHFzjDiEEmaU/8JMO9+J4cFkghv8qtSK1f
	xkYg==
X-Gm-Message-State: APjAAAXnxXN80EAMOJKab4OiX1PjE00vRmKxHkplTI+fQbstAAEwFqW/
	u60UZzCTUEfRM9KHwylGiiIukxottwM=
X-Google-Smtp-Source: APXvYqwUtrTjCJf0g+wemcgZ8C2oLaw8uJdU5BDaVM6QTQL+R4WioivNHDXQnDT7AQz0POVjRcSS2g==
X-Received: by 2002:a17:902:e305:: with SMTP id
	cg5mr27930793plb.112.1556047694202; 
	Tue, 23 Apr 2019 12:28:14 -0700 (PDT)
Received: from [192.168.1.11] (97-113-179-147.tukw.qwest.net. [97.113.179.147])
	by smtp.gmail.com with ESMTPSA id
	z14sm22560871pfn.161.2019.04.23.12.28.12
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 12:28:13 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190420073442.7488-1-richard.henderson@linaro.org>
	<20190420073442.7488-13-richard.henderson@linaro.org>
	<ab0269a3-c0fd-44c4-f939-e3f073e8e2dd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <a32e78bf-e4e4-a808-0c42-95e3b64ed1cf@linaro.org>
Date: Tue, 23 Apr 2019 12:28:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ab0269a3-c0fd-44c4-f939-e3f073e8e2dd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Message-ID: <20190423192811.MeJJAOZ7M4tSCmfy0QerxDJeGWEjZobUl_9buugd5mQ@z>

On 4/23/19 12:04 PM, David Hildenbrand wrote:
> In order to use this on s390x for VECTOR ELEMENT SHIFT, like
> 
> +static DisasJumpType op_vesv(DisasContext *s, DisasOps *o)
> +{
> +    const uint8_t es = get_field(s->fields, m4);
> +    const uint8_t v1 = get_field(s->fields, v1);
> +    const uint8_t v2 = get_field(s->fields, v2);
> +    const uint8_t v3 = get_field(s->fields, v3);
> +
> +    if (es > ES_64) {
> +        gen_program_exception(s, PGM_SPECIFICATION);
> +        return DISAS_NORETURN;
> +    }
> +
> +    switch (s->fields->op2) {
> +    case 0x70:
> +        gen_gvec_fn_3(shlv, es, v1, v2, v3);
> +        break;
> +    case 0x7a:
> +        gen_gvec_fn_3(sarv, es, v1, v2, v3);
> +        break;
> +    case 0x78:
> +        gen_gvec_fn_3(shrv, es, v1, v2, v3);
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    return DISAS_NEXT;
> +}
> 
> We need to mask of invalid bits from the shift. Can that be added?

Yes, I do exactly this in patch 31 for target/ppc.


r~

