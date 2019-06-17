Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA73C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 20:20:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B008E2085A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 20:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DvjeqCdB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B008E2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51738 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcy7I-0003Af-1P
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 16:20:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34174)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hcy6b-0002SR-IC
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 16:19:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hcy6a-0001vA-A0
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 16:19:53 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:36743)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hcy6a-0001td-2Y
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 16:19:52 -0400
Received: by mail-pg1-x544.google.com with SMTP id f21so6410143pgi.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 13:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=xDpUoqigv2bkFBBEjFylS/0TRDj24AHWnb7NRhB/AQU=;
 b=DvjeqCdBXFnYHmPWkZjd37URbura6kg/uTF3YQ3pTEWRkqBfyK1UfFNF6R1hWkc0zC
 L1IkyBvXvve2PIXmHtHzUHtXR5gYo7bmtROu3B74Cu7LiGazaFUqs+ThtMagAZaGE4rA
 R0uVU8O31eNPyDI5bgXor8+jmzzvUZMU1itbrlreQek/FN0tA89pOEX2PvrdjhOxdO/r
 aah8ztEYG02/kI9wy3q8M78Ob4B3U1qO0uPMkKm2b85et6MYhOHXKF/cVKDM2JxWY7Sm
 dqOxSAyJKW7/wi6Gci+K6Z43LP5it9Zhevq91akThtqoyvuWvEXFzaih58p4Sd/AyOSp
 5FVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xDpUoqigv2bkFBBEjFylS/0TRDj24AHWnb7NRhB/AQU=;
 b=YQwayknE/a3fOKywleCUSLeuM8vhCBI4bXix1Rc8HX+vJ8xQru0Sey3ximquYrUUwM
 VSM5Yr/J3a5bSDvfLA80yQYvahqs+V4mCdx/Y47fDrAFM5dgcWsUdZHs+aAJPA26uKct
 1NHKerURWBydxcVCvB3lLQvz1JoJEohTCf/Db6MdMxOyc1v13fv3CcC+dOae3zpp5yEn
 0xF0FFycF8ZSIkCn6I0PDezSRm8v6ndZSBaav1WjpNkevvSs/6PQ3lF88BqH5XfH78Q7
 rFey+cfI52FHMhqsk68t2A2NDmxI5sXMGlx9hTjLC4fIkikyhYtwRlexgX4xsDY6MLa/
 hNOA==
X-Gm-Message-State: APjAAAVkcDyetTrEBEQOWKXiyahkKFwOAu5XXd1eAkRaHeqL3OtF8pTd
 wMKvNe/PM5W7jntyGLGJtHR1sw==
X-Google-Smtp-Source: APXvYqxg/1FkSA4n52Ggkqil7tnmRAKsofFnFl5GPmjyWHXJ8E/2JTmHKRNV2RA1rs6b5sGQX10t+g==
X-Received: by 2002:a17:90b:d8b:: with SMTP id
 bg11mr832516pjb.30.1560802790788; 
 Mon, 17 Jun 2019 13:19:50 -0700 (PDT)
Received: from [192.168.1.11] (97-113-2-33.tukw.qwest.net. [97.113.2.33])
 by smtp.gmail.com with ESMTPSA id y23sm15448927pfm.117.2019.06.17.13.19.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 13:19:49 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190614171200.21078-1-alex.bennee@linaro.org>
 <20190614171200.21078-15-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <0d494e87-553e-7003-a4ae-4c3ac21c2730@linaro.org>
Date: Mon, 17 Jun 2019 13:19:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614171200.21078-15-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: Re: [Qemu-devel] [PATCH v3 14/50] tcg: add tcg_gen_st_ptr
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
Cc: "Emilio G. Cota" <cota@braap.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/14/19 10:11 AM, Alex Bennée wrote:
> From: "Emilio G. Cota" <cota@braap.org>
> 
> Will gain a user soon.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  tcg/tcg-op.h | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

