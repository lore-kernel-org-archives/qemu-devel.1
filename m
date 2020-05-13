Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9775CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 16:50:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D32D3205CB
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 16:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KC7GsqKP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D32D3205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYua9-0001rM-Ft
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 12:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYuY5-0007xz-Vi
 for qemu-devel@nongnu.org; Wed, 13 May 2020 12:48:03 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:42670)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYuY4-0006gB-FQ
 for qemu-devel@nongnu.org; Wed, 13 May 2020 12:48:01 -0400
Received: by mail-pg1-x542.google.com with SMTP id n11so8017804pgl.9
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 09:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=ek99VLquqOipsgCVqisrz2WkESdNRkc14+h08yoE2uo=;
 b=KC7GsqKPm9BhoqoEov2Oi64xVNuyRm6NHwVcj7HHqQ1qEFcvDsm6mRMqle8xU+Y8f1
 HKloXfwogzE/o/sIcDCdEX8qRZVE6fsNu7v8VqQX+ySjuyjBe2PV+Pbtiz9KXP1YO8H7
 4mrHdJ9asofZLRufR/gpw0dP3gHhFnj/O15w2x5+dN5qK7ChRqeU20KUyRSVl1sQl6n8
 YFpqyDYeXpuh5ZS5qO/EbSQQtNR/+s8IJx345otkQogXLs7ItjvOBOB4YlAPlvsO9Wr8
 dOYg72vprcGE5x/uhMnrP/Ti9VB8mR0txhsAA9fwHiaEnW4UEd3EF8tNdST8OaHoXLjZ
 VYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ek99VLquqOipsgCVqisrz2WkESdNRkc14+h08yoE2uo=;
 b=YxMrb3FgJ1X+vwd7Q5207DLZ+cMGRQmBBTcN0MKBfbZKe0PIuIDU6CZ7xCQ4NwAlD2
 BSBKDyocwHbYhX+9Ad7Id9ZPTMtI3t6Avb0iPM/7sJsUiKXDuTm6GBsaonmgSxQVJWdP
 xAJwTq6CEfUyany/l7ZHDFbPCh53k1NN0Nr8dkVo7HY6NTqYYw3HPK9OYJDiJZiu2ik3
 qyPCpq3o2DY982EfMADjSFInrFfMQnGeVwud7cCrJf/IuLxO9Ts+D4bbntsfsJBmEg0P
 UJMzJMcBAc1AoOWNe8fs+U72deQESt1moposOvHJLxDP4NrsNDvfWouDfPcqk/tHHQZ2
 3NIg==
X-Gm-Message-State: AOAM533+3TRoemSZXXo8CYA8iDh5ozDW88Ia+f1agx4iHmf2JhqvOh1m
 xYCF+jrfjH/prp2Fx5SHXpVetxWzZfA=
X-Google-Smtp-Source: ABdhPJxUMhxT9xIfuQYgkq0vTkW8grlagbOxcZLz5KEDJcV6spnCADH8XTWQFrqgVg1Mq+aHcpinKw==
X-Received: by 2002:a62:c1c4:: with SMTP id i187mr172635pfg.319.1589388478602; 
 Wed, 13 May 2020 09:47:58 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id u69sm2242712pjb.40.2020.05.13.09.47.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2020 09:47:57 -0700 (PDT)
Subject: Re: [PATCH v2 04/17] target/arm: Convert Neon VHADD 3-reg-same insns
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200512163904.10918-1-peter.maydell@linaro.org>
 <20200512163904.10918-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4317bc5a-9100-8c84-c3bc-ec98e94dbfbf@linaro.org>
Date: Wed, 13 May 2020 09:47:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200512163904.10918-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
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

On 5/12/20 9:38 AM, Peter Maydell wrote:
> Convert the Neon VHADD insns in the 3-reg-same group to decodetree.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/neon-dp.decode       |  2 ++
>  target/arm/translate-neon.inc.c | 24 ++++++++++++++++++++++++
>  target/arm/translate.c          |  4 +---
>  3 files changed, 27 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

