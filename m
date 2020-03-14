Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14ADC0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 07:53:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A04D62074B
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 07:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EbmN94eP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A04D62074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD1bp-0001Jj-KX
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 03:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60279)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jD1bD-0000nV-Qf
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 03:52:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jD1bC-0008CQ-MY
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 03:52:47 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:41493)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jD1bC-00083J-EH
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 03:52:46 -0400
Received: by mail-pf1-x441.google.com with SMTP id z65so6685915pfz.8
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 00:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WFe7DR/lnqsPXYVJ5niqxwU/ERf64ikxyq6h0nS9UaI=;
 b=EbmN94eP7MLe2BzF63ffLVhyvyFh9ajs/OzlgsPmyQ8RWPaVLfS30Dg1uwyLRYRSvk
 SM1SVEPod2I8RRLtfyfYcpGoBNy+j8fmovA81302oqPm4wrdI4MJQpofcisHlxa5rD3L
 BiwCuoZnEVYDl5RO/i18ZbET+uvhhDzV1+bPKtebHVX7ZKW7whys169BcMBxIBL9ik2w
 CXHXwhiX7KvQZGpRBiLvM8IhgJR3kxmO384O9StOf6Tx/zw2dgNktbwi1EQb9pdKx9tc
 rBUtgN0VCUCUgwcqkDSzfJrf1LqLvXsgP1xApOVBaV3UylgHNxP6HeAX91YZ8eGlTAgp
 W+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WFe7DR/lnqsPXYVJ5niqxwU/ERf64ikxyq6h0nS9UaI=;
 b=lFF/rtiwwZrAjEnZWbnGp6e9RjOPMGnfFMMD1xS1TYywO9oVW4d28dLV+xD6DKq9aw
 FWZHthjC5lwzLsvZ7fs3UjE3oDgiHq6tG4BWGRtK65DsmKQ5iXjzo/gzWiW2QTePfR7s
 NmGVqHLlrOxUoKwr0Ji+ztoF6h1zxyVrRpGnRczh6Cc5o1kzb1AZolg9vitsBsUORwd5
 ATRgWGNVUb8t0174RJAgDXLzpz7uwvdbmPHNts7PpotAxlR5ZGXH06EqXXqgk85LqneI
 cv8ijJRRt1XHq93bDVsVbeUNIIrAvYrA18qUPgFzLQzW+y4wPY4zW0caQgeN4X+7Akwa
 LgzQ==
X-Gm-Message-State: ANhLgQ3yfgRpZheolJPgfPOmNCYqASZlnW+rjMTN4T+nG1grXpIeItmp
 HQZy5ze6fE6d5lvpFReXU2nRog==
X-Google-Smtp-Source: ADFU+vvxteoYMtgxAPSg3IpljBhCrqnK/lbilaktgbcOkVEjNK2NFiQyw2uNNN4RNkqrB9EyFqyXxA==
X-Received: by 2002:a62:7d4e:: with SMTP id y75mr7913569pfc.32.1584172365105; 
 Sat, 14 Mar 2020 00:52:45 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 d206sm1751809pfd.160.2020.03.14.00.52.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 00:52:44 -0700 (PDT)
Subject: Re: [PATCH v5 23/60] target/riscv: vector single-width saturating add
 and subtract
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-24-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <be948e99-0c65-9f0a-c641-fdf9dec257c6@linaro.org>
Date: Sat, 14 Mar 2020 00:52:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312145900.2054-24-zhiwei_liu@c-sky.com>
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
Cc: guoren@linux.alibaba.com, wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/12/20 7:58 AM, LIU Zhiwei wrote:
> +/* Vector Single-Width Saturating Add and Subtract */
> +GEN_OPIVV_GVEC_TRANS(vsaddu_vv, usadd)
> +GEN_OPIVV_GVEC_TRANS(vsadd_vv,  ssadd)
> +GEN_OPIVV_GVEC_TRANS(vssubu_vv, ussub)
> +GEN_OPIVV_GVEC_TRANS(vssub_vv,  sssub)
> +GEN_OPIVX_TRANS(vsaddu_vx,  opivx_check)
> +GEN_OPIVX_TRANS(vsadd_vx,  opivx_check)
> +GEN_OPIVX_TRANS(vssubu_vx,  opivx_check)
> +GEN_OPIVX_TRANS(vssub_vx,  opivx_check)
> +GEN_OPIVI_TRANS(vsaddu_vi, 1, vsaddu_vx, opivx_check)
> +GEN_OPIVI_TRANS(vsadd_vi, 0, vsadd_vx, opivx_check)

The vxsat bit can't be set by the gvec routines, at least on its own.

For ppc I compute the saturation bit by doing the vector saturating add, the
vector normal add, and comparing the two.  See uses of vscr_sat.

But for now, you can just use your own current out-of-line functions.


r~

