Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A826C11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 19:50:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C10CC24699
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 19:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eU6LFt04"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C10CC24699
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7PAV-0006Ww-Tq
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 14:49:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49866)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j7P9e-0005vW-Sg
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 14:49:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j7P9d-00005X-MO
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 14:49:06 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:41720)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j7P9d-00005K-Eg
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 14:49:05 -0500
Received: by mail-pf1-x441.google.com with SMTP id j9so360856pfa.8
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 11:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5yN6sH6PQyT2zWxZQXjM0a62AyWsU4lD3wudwbpMNcQ=;
 b=eU6LFt042wGzY4/cSfnJuWAHQ/73aMWgnM3j6qj9gbXp8h5qwvtb+GzG5cHrPMmX+n
 U3YKJiLN8eV0d7MRizBN5JJx/xhOv+KwtqR6nxljZBvCh2kS4/OMMSwJgPS+E7j37ahw
 F8JkgjTj+nZjeuqefmqxvy7lQmPRUL5CIEnRJoMHjoirIdUFOi54iZUJKJ6Oe6yPb8Kk
 hpg4qY9myI9DGpl+sYk0RXlJL5gsywsves8g0oEuG54S2l7OyOgYaozW8gFNRkd4Oa9E
 /EPw0T4fQtHNeTYr39kf0eHYb4EXem94o0vSyuJ9MaSvmfUo93ibHNYPlzf15nljgk0Y
 8NhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5yN6sH6PQyT2zWxZQXjM0a62AyWsU4lD3wudwbpMNcQ=;
 b=Xtz3QZXckbNQCdJsvHyAnn8jLL/Plox8/qjGyziN5kA4yWlZLjMGc6QQ3/lvm4JSJ8
 MFMa40SjZYMKWkObkHH9ADkV2Bn1UcBQ+TkHf01wJlTmJefo+AxHS5nC/HTtf64aeuBW
 KwY+/FEV128pn/jdSTwKnFk8sSrLk6l8OFzU30gc9xHo8na8Aep/9qPKypr7C3VP6IOT
 Z6QnzGU9XJ80bFUpbyIR2Cx6tMLFR41sang9kyVHwUdbvdRYLPwj8UtlXqFPbeBTzZfq
 iM2Lzt+OMy6mYTAZpRwuAPwOrSN4TVaORPjTJnhuzOttIOUQeXM7iVmV/MlGK5yZPk7F
 Ye2g==
X-Gm-Message-State: APjAAAWdDHW5wZ8HH95CmPJgzCOpe+ax4qQ61PAQjyAyWm839E0vaLIa
 1zTseodKgLTwTIcQB2t5/l+BGg==
X-Google-Smtp-Source: APXvYqyomvcL6FS7utxlqRTE2UGXlv3vGzIut3Nt363K04DlCt7BPoo0beMALHABzUs3iTPCXExQDQ==
X-Received: by 2002:a63:e509:: with SMTP id r9mr990070pgh.274.1582832944247;
 Thu, 27 Feb 2020 11:49:04 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 k9sm7332755pjo.19.2020.02.27.11.49.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2020 11:49:03 -0800 (PST)
Subject: Re: [PATCH v4 3/5] target/riscv: add vector index load and store
 instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200225103508.7651-1-zhiwei_liu@c-sky.com>
 <20200225103508.7651-4-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <30ac8dcd-a6d4-b4d6-212c-6819f914bd21@linaro.org>
Date: Thu, 27 Feb 2020 11:49:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200225103508.7651-4-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org, linux-csky@vger.kernel.org,
 wxy194768@alibaba-inc.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/25/20 2:35 AM, LIU Zhiwei wrote:
> +vsxb_v     ... 011 . ..... ..... 000 ..... 0100111 @r_nfvm
> +vsxh_v     ... 011 . ..... ..... 101 ..... 0100111 @r_nfvm
> +vsxw_v     ... 011 . ..... ..... 110 ..... 0100111 @r_nfvm
> +vsxe_v     ... 011 . ..... ..... 111 ..... 0100111 @r_nfvm
> +vsuxb_v    ... 111 . ..... ..... 000 ..... 0100111 @r_nfvm
> +vsuxh_v    ... 111 . ..... ..... 101 ..... 0100111 @r_nfvm
> +vsuxw_v    ... 111 . ..... ..... 110 ..... 0100111 @r_nfvm
> +vsuxe_v    ... 111 . ..... ..... 111 ..... 0100111 @r_nfvm

These can be merged, with a comment, like

# Vector ordered-indexed and unordered-indexed store insns.
vsxb_v     ... -11 . ..... ..... 000 ..... 0100111 @r_nfvm

which means you don't need these:

> +static bool trans_vsuxb_v(DisasContext *s, arg_rnfvm* a)
> +{
> +    return trans_vsxb_v(s, a);
> +}
> +
> +static bool trans_vsuxh_v(DisasContext *s, arg_rnfvm* a)
> +{
> +    return trans_vsxh_v(s, a);
> +}
> +
> +static bool trans_vsuxw_v(DisasContext *s, arg_rnfvm* a)
> +{
> +    return trans_vsxw_v(s, a);
> +}
> +
> +static bool trans_vsuxe_v(DisasContext *s, arg_rnfvm* a)
> +{
> +    return trans_vsxe_v(s, a);
> +}

> +static inline void vext_ld_index(void *vd, void *v0, target_ulong base,
> +        void *vs2, CPURISCVState *env, uint32_t desc,
> +        vext_get_index_addr get_index_addr,
> +        vext_ld_elem_fn ld_elem,
> +        vext_ld_clear_elem clear_elem,
> +        uint32_t esz, uint32_t msz, uintptr_t ra)

Similar comment about merging vext_ld_index and vext_st_index.


r~

