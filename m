Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9EAC43467
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 20:22:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09B5720EDD
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 20:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HUVMCkNU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09B5720EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSQoh-0001qA-6Y
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 16:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSQmf-0000Ir-5N
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 16:20:33 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:39997)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSQmb-00073U-FB
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 16:20:32 -0400
Received: by mail-pf1-x441.google.com with SMTP id w21so496252pfc.7
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 13:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=nURHcfioospRhlTgHU0RN00GF8JtISXyXYqyC7WLVpw=;
 b=HUVMCkNUNMrXOLdEbjNRAs1auT2PUDcJFGjfJdASQdFwgIQeBVcHcCb99foCwoFAtI
 4RTAc8ppnl7DUg/zoGncYrrc+pm5v+ib8vZoM9COCyepw6CoJR7ldr1dnAZAKB5C0uwR
 Uq82M8jGAiPSk3gnEzEqdTAcXR5PQTz6K9oQnlFIj4IzHPLiV5+Wq/Ofv7GpPYrxEIoI
 eWtUxWw6iHfNZa1nJ0XIeGx6MxT7hGE+iZ8AWcCTO6WweBtpLOG4JHFIKqbLu1qRt8uz
 oxKBXoJfvaElsBd6gV74Yv6Q/eFlQgcrsMPjU6BaUDeIEtJZzqGaFP1Qt+QkWpgimcsM
 7Z2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nURHcfioospRhlTgHU0RN00GF8JtISXyXYqyC7WLVpw=;
 b=mmVfZqvFNo3qhU7rVj5ikw7TI2GKus/jDBrCVV3K9yYTHk/2PX8UrAyaSs1l0mZNku
 Ws+suGapQsHnooiJdsHy6d9fVN5fi7+6eARmyAfwgtOH5qew632JMCc0S104eCbWPr9w
 bFSyPzzjLaEOA37Wk5dFa4pIC5JkC5O2r2GMlXS8DJq76NGFuKYCPEVUQwOr7t74rSkg
 DqgZ2vpLiqXeZOFLypDLzzwL18D9dWe5fpLn0OT7brKMMtaOWCGIORoDfS8Y666fmYQZ
 1JdaqsTYXEt5/k2SV+bdIPaDQ/Im3hgO4cnArUO9mLU4RvVvE+BOONeAAP5tsnVtGIXF
 LQvg==
X-Gm-Message-State: AOAM530RvZVuebzzpZO5WOAozCDOS3YvIaBKvhKMwPyrwUMvSo52na1o
 gl6tUSaXCYLzMxOUqMlhvk1T1LNAyJFQVw==
X-Google-Smtp-Source: ABdhPJz6dmdVvvjiUuSPx+TiqS2lsRoT69L5AERuspIe35eeTRMjX1NJSlfjcwvI48mvl+lf4v5dGQ==
X-Received: by 2002:a05:6a00:224e:b029:152:3cc8:4a84 with SMTP id
 i14-20020a056a00224eb02901523cc84a84mr1376246pfu.26.1602620425768; 
 Tue, 13 Oct 2020 13:20:25 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id fa12sm50635pjb.25.2020.10.13.13.20.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 13:20:24 -0700 (PDT)
Subject: Re: [PATCH] target/arm: AArch32 VCVT fixed-point to float is always
 round-to-nearest
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20201013103532.13391-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ffb2bfed-b48a-e036-3bbb-bf01888a1b61@linaro.org>
Date: Tue, 13 Oct 2020 13:20:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201013103532.13391-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/13/20 3:35 AM, Peter Maydell wrote:
> For AArch32, unlike the VCVT of integer to float, which honours the
> rounding mode specified by the FPSCR, VCVT of fixed-point to float is
> always round-to-nearest. (AArch64 fixed-point-to-float conversions
> always honour the FPCR rounding mode.)
> 
> Implement this by providing _round_to_nearest versions of the
> relevant helpers which set the rounding mode temporarily when making
> the call to the underlying softfloat function.
> 
> We only need to change the VFP VCVT instructions, because the
> standard- FPSCR value used by the Neon VCVT is always set to
> round-to-nearest, so we don't need to do the extra work of saving
> and restoring the rounding mode.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.h            | 13 +++++++++++++
>  target/arm/vfp_helper.c        | 23 ++++++++++++++++++++++-
>  target/arm/translate-vfp.c.inc | 24 ++++++++++++------------
>  3 files changed, 47 insertions(+), 13 deletions(-)

I guess this is ok.  I do wonder whether these extra helpers are really that
much better than using set_rmode.  But some of our existing *_round_to_zero
helpers are similar.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

