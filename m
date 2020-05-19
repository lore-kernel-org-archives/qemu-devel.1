Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA03C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:29:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D8352075F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mM0V5zU3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D8352075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb4Bg-0008VN-CJ
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 11:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb43Y-0005bZ-OD
 for qemu-devel@nongnu.org; Tue, 19 May 2020 11:21:24 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:38855)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb43X-0001Hw-2b
 for qemu-devel@nongnu.org; Tue, 19 May 2020 11:21:24 -0400
Received: by mail-pj1-x1044.google.com with SMTP id t40so1582052pjb.3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 08:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=ekV9LOn45uEl+E8BDFIUMuZv1J5gOmEIjpzRNluTkUM=;
 b=mM0V5zU36vLlfLmcpkZSffXhm86r6jXSSlN2a8wXn1wqbvHrs/+k6f3iCvZkOqCUPh
 Ianv1NwcmIc+3m8aIwzzpqxorJcBEr3F+Ntyatkp4/z+3mSfH1psaJ9wem65ITxyIvDU
 gVaUNzbl+KYoqQENLv5Cj9jKX7WsdjvAl+bTChSykecpkekKHJUCV+ZCgghZ7GkF5+V0
 iRhVi6TzKAZyz9cWuCsHEFANYUzzj195PgRe4ts6QqerzIL/pTAZVmB8aGAPCIWzAY80
 ptudNhEsZjvcFlBDr0WQTpJdnRuj4On74Bnd/ErP8qM1VMwab1hWwMvzK60857APxc3h
 BZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ekV9LOn45uEl+E8BDFIUMuZv1J5gOmEIjpzRNluTkUM=;
 b=Aw7gr099HdPOrV6zCMK9po/+fIa+AQg4Zv5eBjlpJtbPq6aRYjwFnYLEmehGXjGdNl
 umYx8yy0DAuGsL2vhy0S+Y9XqFo932FFflfUFAGMKgn2zMgl7wmaquVyUyGXPk2lW6xm
 PqCKEEnnB17kqavA/qzxeUQoSFkc4yhfG9y50KFg4B1oZzkliXjUxiTAH+T5NLSTKMr2
 gfDKZEoxZzzQ21j+NLm+3Q7lHqfuN55WMeSy/ewWEV/x0X3U4wCVhgPZ7Py/NgmnheMW
 aN8fNSYjR9vkSBmVoeTMCaPcQDbTJQjfzPk04qm5YXCLhwBWxy0OUuczGIMdrXkF+0bI
 /IKg==
X-Gm-Message-State: AOAM532X34AM8wVMWyjQKcxwe8U3ra9PBIPWK85nHiAg3qUHqXaujZkL
 2DCPpkatEKqe7dNh6+AXwoY3XEo+2RE=
X-Google-Smtp-Source: ABdhPJxURQFVbxV5E4/D1W9nFEl9P0IDrZb/T4b7z0sKgFJ77WHlpk829sjMlKAVatOL547GvOcRww==
X-Received: by 2002:a17:90a:4497:: with SMTP id t23mr97534pjg.88.1589901679045; 
 Tue, 19 May 2020 08:21:19 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id i2sm10352158pgb.14.2020.05.19.08.21.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2020 08:21:18 -0700 (PDT)
Subject: Re: [PATCH RISU] arm.risu, thumb.risu: Add v8.2 DP and FHM insns
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200518154719.18562-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8d939086-a431-0922-4623-88cb517993f1@linaro.org>
Date: Tue, 19 May 2020 08:21:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200518154719.18562-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/18/20 8:47 AM, Peter Maydell wrote:
> Add coverage for the v8.2 DP and v8.2 FHM insns in the Neon extension
> space.  (We already had the v8.1 VQRDMLAH/VQRDLSH and the v8.3
> VCADD/VCMLA, so this brings the risu coverage into line with what
> QEMU has implemented so far.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I added these patterns as part of testing for the first part
> of the Neon decodetree conversion and forgot I'd never sent out the
> risu patch for review.
> 
>  arm.risu   | 18 ++++++++++++++++++
>  thumb.risu | 18 ++++++++++++++++++
>  2 files changed, 36 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Sorry I didn't submit these myself February last year.  I still have them
sitting in a separate .risu file that I used for testing originally.


t~

