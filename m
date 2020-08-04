Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5464C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 14:54:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA40A21744
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 14:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L6YgYEP8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA40A21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2yKS-0002KZ-UT
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 10:54:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k2yJk-0001m5-1f
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 10:53:28 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:40543)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k2yJg-0001PU-I0
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 10:53:26 -0400
Received: by mail-pl1-x641.google.com with SMTP id u10so13541275plr.7
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 07:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=G8iK6Ss606ZM/B4U+kopOI9YHb2G6ZZxhPAcDenrYw0=;
 b=L6YgYEP8rBrg5lgOmnUQEU4E8dT8N3UFG6D0w3S2dG+E+qg6Q3+SZd9I27MCZfBp8O
 zGxaN2WHE6ZXI6zn84Yu/3UyfhG9fh9P32fUJ1nivXaLaSUl92m5VaXDseuWzvD700Ih
 0f081TUZTa/zrNsPa6J+uOCHorhICBJ1Px3UlKhm2GzmWYQ1uUCEaZMjCW3gVWaqOKvJ
 s4imOtaiCuswq/cl2UF96EYppDf3m9QkppR6lK1pZf1dTkWXeJbK/aaaTnVIP1HwIu/R
 KkhyECx1MZ6Js49HXRhogbPVNje9MQYz01AdPHGDIMXSQ/C3gySNshmY9fiHda7ULNoq
 kOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=G8iK6Ss606ZM/B4U+kopOI9YHb2G6ZZxhPAcDenrYw0=;
 b=g95EVtPOnISmH45vrXN9YtoYaMo9jPCVCJexq8AkJ1gfLZ/25OoGhOCSwWRAufEtux
 m2KjT8f04JBRmYkUo4PArh7Sg1S5ILWQ5Ma7Hts00OuJs6YnK6WTsbh/2XwBZtm2GNnn
 gJQ4Zeo6RPBKKPipUvGeHs+Tp6qpE+jXIV67YrNIARrAuDXsAcYc+SKNTUz8hYveeXAN
 yk/2R71CviokUSlcuVw9HZsPhxQTX21bEHOuH5dFm+8lsDz+kQi48LMRlDIm2SMKBYH5
 G5Qbd0uh20LzkfRWryL/WA2RgX+bHTwMOZ+fu0YrHVnbrq5wJ3bemVTlcTk+KcUWmLoJ
 Yl3Q==
X-Gm-Message-State: AOAM532A3HiAoaXOfGByJRwWUktXEP/q2KPRUyV9kov2aSfVK2o9XRy7
 ZCzde8/NhNi2KcfccyV6rEQpJStLIIw=
X-Google-Smtp-Source: ABdhPJygGaQS5mCh2JdMgQfk0/i/BKnIduGJ9hItKSETb30GkhwyfQWTWDTt8zdbv2y7SR4vID+W5Q==
X-Received: by 2002:a17:90b:1287:: with SMTP id
 fw7mr4662828pjb.218.1596552802173; 
 Tue, 04 Aug 2020 07:53:22 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id v128sm22279409pfc.14.2020.08.04.07.53.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Aug 2020 07:53:21 -0700 (PDT)
Subject: Re: [PATCH 2/7] target/arm: Separate decode from handling of coproc
 insns
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200803111849.13368-1-peter.maydell@linaro.org>
 <20200803111849.13368-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <96aa534f-4892-1084-7899-de9c76f5b8a8@linaro.org>
Date: Tue, 4 Aug 2020 07:53:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200803111849.13368-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/3/20 4:18 AM, Peter Maydell wrote:
> As a prelude to making coproc insns use decodetree, split out the
> part of disas_coproc_insn() which does instruction decoding from the
> part which does the actual work, and make do_coproc_insn() handle the
> UNDEF-on-bad-permissions and similar cases itself rather than
> returning 1 to eventually percolate up to a callsite that calls
> unallocated_encoding() for it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate.c | 76 ++++++++++++++++++++++++------------------
>  1 file changed, 44 insertions(+), 32 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


