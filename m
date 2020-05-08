Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A50C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 19:23:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26913206D6
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 19:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z5rcMHU+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26913206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX8au-0002CL-94
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 15:23:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX8Zy-000185-EY
 for qemu-devel@nongnu.org; Fri, 08 May 2020 15:22:38 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:54156)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX8Zw-0003Z5-Ms
 for qemu-devel@nongnu.org; Fri, 08 May 2020 15:22:37 -0400
Received: by mail-pj1-x1041.google.com with SMTP id hi11so4730908pjb.3
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 12:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dTaPL7EUY9h2b3Oj/r/SDfrlCBmgyEuw/n/cKsFZOSc=;
 b=Z5rcMHU+TcT71lBOKgktvTdGqtNw72WeCCBpOORXvwdBgPJgx0xy9brHwLI/frsqp/
 nAoWO93O1SODv8M5UGUrnamsdZ3yFlBITdvSCfXljhV1VdJB5oXllk+BYRor8CV/2+DZ
 eBsQSRZmi/TmCnB+46dpwwk0QoX3DXKN1kbWcCvH/hrLmFbrVgw2fUgzSazVe6HgUqQT
 c6tgn1ZpI4zKDpHOjlr2AIxcWmEO8/5m9OMnM6ePVIJeVccIrEjQwrKYme6p49HdnWFG
 SLmMai5LID3TMKmjV3pgFe9yc0EvyC0G5EYBoU0LQ8jspfWVkqWVGNGiNnyOSNxJhn7n
 Wgqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dTaPL7EUY9h2b3Oj/r/SDfrlCBmgyEuw/n/cKsFZOSc=;
 b=BTV4YJkaHB9VvYq5Y1wb0SZUjEUw5gFf1c5rvtHbqwpy08Aw1nlJIyGmSorQDUQYUh
 sIzy1dFqL3n+s9a9sdM3OP/XkcZjzGwofK4Jgy/OEwcAnS5VLUqkwNZBS4wZFlblNAxR
 st7/8kLxsRP2/foi9hH/YUQsoKxwt0roiChwbMMI/ydpzrF+Ar/kcEauG4zE1xgm0iJH
 PTlY0tOFo+4TIPOUphXJH+K2nTvHonOV+D4juz+S6KLQbaRo4/b5KyVypks5HYkqQr8h
 VjU2wCRKgqwdiHdUHU9vQtpkcWILfZznopNRtjsOghutO0OMT2LU+Jl1WMA+go8hnEfz
 XS5g==
X-Gm-Message-State: AGi0Puauxbc0ufmfgVXocBcRp81rEbyYXHb6sRQwQCnOrWeqzM8Ha0LR
 cVEhmeQwx+Rc8lwfW7L4RrE8zA==
X-Google-Smtp-Source: APiQypIom7VFJQdDC5avl25wTV9dHyDkC8UakYFCkXca66PrN67u6WiyDKXdml/oO8RoPff+7v/ipw==
X-Received: by 2002:a17:902:a511:: with SMTP id
 s17mr3867776plq.33.1588965754848; 
 Fri, 08 May 2020 12:22:34 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id x195sm2511694pfc.0.2020.05.08.12.22.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2020 12:22:34 -0700 (PDT)
Subject: Re: [PATCH v4 07/19] tcg: Use tcg_constant_{i32,i64,vec} with tcg
 gvec expanders
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20200508182616.18318-1-richard.henderson@linaro.org>
 <20200508182616.18318-8-richard.henderson@linaro.org>
Message-ID: <e6b1c5cb-22cd-d1ec-6aef-98654b22de81@linaro.org>
Date: Fri, 8 May 2020 12:22:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200508182616.18318-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/8/20 11:26 AM, Richard Henderson wrote:
> @@ -1647,16 +1632,14 @@ static void gen_addv_mask(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b, TCGv_i64 m)
>  
>  void tcg_gen_vec_add8_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
>  {
> -    TCGv_i64 m = tcg_const_i64(dup_const(MO_8, 0x80));
> +    TCGv_i64 m = tcg_constant_i64(dup_const(MO_8, 0x80));
>      gen_addv_mask(d, a, b, m);
> -    tcg_temp_free_i64(m);
>  }
>  

These unconditional uses of tcg_constant_i64 break 32-bit builds.
I'll have to find another way to handle these.

For now I am dropping this patch.


r~

