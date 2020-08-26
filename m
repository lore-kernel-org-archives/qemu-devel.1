Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B550EC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 02:07:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7881620737
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 02:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ifHrLuPW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7881620737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAkq9-0000MZ-Kz
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 22:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAkpZ-0008JO-8w
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 22:06:29 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:37904)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAkpX-0005sl-DI
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 22:06:28 -0400
Received: by mail-pj1-x1043.google.com with SMTP id ls14so155990pjb.3
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 19:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9iLvhxQPtlA8qnrd/AlF+ZjMI8MFldT0iKdfB1StMeo=;
 b=ifHrLuPWO5u4bEdpANvhq4/9FD5g6HqD/vDtcYvUneWYZP2vjJm+3WapWaeqD2hPdP
 pIDwROWQm9v4ix14SCU/W80ArcI1W8k+Ju7vRWZfzbhILigTVCwev+wXhdt0pWAC+luM
 rGCmjeM8hoTgEuUAbN7INbgbN8dv58tthDWJSHXf3aAX70W5TOOrZc/vDL4uR/4FzgXQ
 ktyoO5C4jOlh6wZhDhBKPpRAjmPhhguFcsE59vDly9xN+qlkJjmTr2DQ+QIYZ/UiiF5M
 xXi9EFqq4WgzGPAdsM7wXmlpxgPSnLpN9WTYpiG911gNMnRGVbvQ/cKQdcntOe73Zve0
 hMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9iLvhxQPtlA8qnrd/AlF+ZjMI8MFldT0iKdfB1StMeo=;
 b=O+CSkYjCctVie/n30LZ2zuGEl8fDMZ6l/eoMNE5zNLANZIO6XNawrZtilsvfsk3+F2
 unXI3k5N+1cD7+x0GDAwtUW/aga2+WrYHlBbMTW7eXTpXZDL6MFzbGhfft9RdB/3KKoL
 Odu6jqhm4+Uiv/gytCpnuqU3bOs1BJory4nghvBUlQT5l2eYuT97drpLOy7DUwqlKZbo
 lOS5HHvLmBCTmg59Yq3SgMAICYbjrUiMPfIWMbgNLjQSp57yksiIK6cFKAuflU7Cq9hG
 wOPKpyIcJgEB8PEvXZDwXloWjb7aHcvVtihhKNf1wcarWez9T8wFAco2n6DJ1Q7ayVbi
 i8nQ==
X-Gm-Message-State: AOAM530WNxiq2sqxvYjmOF1ihoLgxN9X2rvn4Ph/6OD+m4SulVS08wDV
 BKeLjR3dmVj21xOnOZz3/SJtqA==
X-Google-Smtp-Source: ABdhPJwdmIcj2ERc3JmwUF5yKcIeeikYY+LzWPzAnyS0CIIhWwk3VR3Z82PngryP7asVWlotxJYCUA==
X-Received: by 2002:a17:902:850b:: with SMTP id
 bj11mr10172295plb.81.1598407584693; 
 Tue, 25 Aug 2020 19:06:24 -0700 (PDT)
Received: from [192.168.81.79]
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id 135sm602014pfy.61.2020.08.25.19.06.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2020 19:06:23 -0700 (PDT)
Subject: Re: [RFC PATCH v3 02/34] Hexagon (target/hexagon) README
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-3-git-send-email-tsimpson@quicinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <75909d12-0e9e-f10e-389b-60c26f268c9d@linaro.org>
Date: Tue, 25 Aug 2020 19:06:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1597765847-16637-3-git-send-email-tsimpson@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.602,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: ale@rev.ng, riku.voipio@iki.fi, philmd@redhat.com, laurent@vivier.eu,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/18/20 8:50 AM, Taylor Simpson wrote:
> +    #ifdef fGEN_TCG_A2_add
> +    fGEN_TCG_A2_add({ RdV=RsV+RtV;});
> +    #else
> +    do {
> +    gen_helper_A2_add(RdV, cpu_env, RsV, RtV);
> +    } while (0);

I don't understand the benefit of passing the SHORTCODE to fGEN_TCG_*.  Is this
file included for helper generation?

It seems to contradict what you have a few lines lower


> +The gen_tcg.h file has any overrides. For example,
> +    #define fGEN_TCG_A2_add(GENHLPR, SHORTCODE) \
> +        tcg_gen_add_tl(RdV, RsV, RtV)

which has two arguments not one.

Is this README out of date?


r~

