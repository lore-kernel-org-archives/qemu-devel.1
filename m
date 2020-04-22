Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9817BC38A30
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 03:31:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FFC5206D5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 03:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GW2USCXI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FFC5206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR671-0004uo-Fd
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 23:31:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53488)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR65M-0003ZG-CO
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 23:30:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR65L-0001iJ-E0
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 23:30:03 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:36138)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jR65K-0001SE-QR
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 23:30:03 -0400
Received: by mail-pf1-x42f.google.com with SMTP id g30so373517pfr.3
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 20:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Pbx9ehobw8ROo+UOJ/SHHbMosUJ2HFpZPPDhmxUmdQE=;
 b=GW2USCXIBwJpo06mFnMWlqOyKXekJpJj3vTQ8VDZfJKjIlNutA0YSruzemHM4416US
 bDtB3Xnox3CswXKXfVjvuVE//e1JFA6RoCr4mloOOEcf9Q0WbUU9teEhhTVfsqFVZQcC
 zUlkiVW+bdmi4dEiIjcBQJbiS73NRsS7RzDWkQ0/m/iBa/YMUtxFcseiF5mDPn5HOSpr
 z0tefYGbri1mnocOB+FPGWXPIdi27vdwCa2WGEisLSKPNWfMw79ikszLaa2Y6j6zNVtk
 5uTCPDHSF+KAiA1iT7j9aROibm/mamgBkMYxkShC65AMKhb7Du/5DJpi97PPuaM7D3e0
 285g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Pbx9ehobw8ROo+UOJ/SHHbMosUJ2HFpZPPDhmxUmdQE=;
 b=GdGsW2VGDzlkVDM9A3uWk7kGveOIIunsCt0Qhp6YRx5Sgj25KBZmfVXAPlar+AYIXZ
 1fMtYRs8WST0doHqhTuQskiMCgwmJDNPE45B8I9nkosQz/aJDtqgmMCWQR9y6WCYLDH0
 II2zs3zMKuOgHnuSoet+4JerwZIRvQBYo4/NxME2fCAUOjtqzSDwQ2CTET62ewAxordd
 U1QLFnHskbhk57c+0QB971luhu02Wke4d1ieJBShBiY6VhkzkwJKosu2Vj/uLzNQFR7d
 86tbuDUtpodq0KkZET9qaZBgtyExBw3aaqsNDgfdPs3dTKV4tH9rQF3HR2cx4ih4m6xU
 07jA==
X-Gm-Message-State: AGi0PuaUHeT1xJPa3bX2ZWG7hFMYdzyrtP9K/aPm0BcLMZRB5ynH+ebf
 GN90zNap0/d1Ntl6CZrd9ioFFg==
X-Google-Smtp-Source: APiQypLrCrRMprPmRFrESK76OOUAoENDq0hhAsbp5Im5z1NfmVc98gM1TUdvENUAR2oERujChVNUwg==
X-Received: by 2002:a63:b256:: with SMTP id t22mr23273348pgo.92.1587526200493; 
 Tue, 21 Apr 2020 20:30:00 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id u188sm3004714pfu.33.2020.04.21.20.29.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2020 20:29:59 -0700 (PDT)
Subject: Re: [PATCH] target/arm: Implement SVE2 scatter store insns
To: Stephen Long <steplong@quicinc.com>, qemu-devel@nongnu.org
References: <20200420204203.13279-1-steplong@quicinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <75ad766b-c687-1b57-03dc-521bed73281a@linaro.org>
Date: Tue, 21 Apr 2020 20:29:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200420204203.13279-1-steplong@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::42f
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
Cc: qemu-arm@nongnu.org, apazos@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/20/20 1:42 PM, Stephen Long wrote:
> +static bool trans_ST1_zprz_sve2(DisasContext *s, arg_ST1_zprz_sve2 *a)
> +{
> +    gen_helper_gvec_mem_scatter *fn;
> +    bool be = s->be_data == MO_BE;
> +    bool mte = s->mte_active[0];
> +
> +    if (!dc_isar_feature(aa64_sve2, s) || a->esz < a->msz
> +            || (a->msz == 0 && a->scale)) {
> +        return false;
> +    }
> +    if (!sve_access_check(s)) {
> +        return true;
> +    }
> +    switch (a->esz) {
> +    case MO_32:
> +        fn = scatter_store_fn32[mte][be][a->xs][a->msz];
> +        break;
> +    case MO_64:
> +        fn = scatter_store_fn64[mte][be][a->xs][a->msz];
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +    do_mem_zpz(s, a->rd, a->pg, a->rm, a->scale * a->msz,
> +               cpu_reg_sp(s, a->rn), a->msz, true, fn);
> +    return true;
> +}

I was thinking of something more along the lines of

static bool STNT1_zprz(DisasContext *s, arg_ST1_zprz *a)
{
    if (!dc_isar_feature(aa64_sve2, s)) {
        return false;
    }
    return trans_ST1_zprz(s, a);
}

The fields should be identical, and so decodetree should pick the same type for
'a', underneath all of the typedefs.

If decodetree cannot find a common argument set for the two insns, we might
need to help it along, like we do with e.g. &rri_esz.  I don't know without
trying if that will be required.


r~

