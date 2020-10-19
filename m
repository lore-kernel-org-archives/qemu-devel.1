Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B09C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 15:14:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98CFB2231B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 15:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KsryDIGe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98CFB2231B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUWrU-0008Lx-Eg
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 11:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kUWe3-0004xj-Kg
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 11:00:20 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430]:46714)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kUWdz-0000vt-UR
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 11:00:17 -0400
Received: by mail-pf1-x430.google.com with SMTP id y14so77713pfp.13
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 08:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Spkcq4TayC4Sg03SiEiSobwtKiAxZIs3buh6QupjT0M=;
 b=KsryDIGeCPbfw6lgDWoJ8CrIT5Dkhauql1cdv6qOyVweC3GlVcBEK1TWu3WU6I2KaM
 XKhGi5Yroicw/IfIG4xBYM0zsP8bYceYHZcbgwc+3thTYN4wF9nQg0J0K5Han8GaD4Jp
 onlYz1HXVQ0ABiP9bK0oJNozo1mVMS39wUBO71fG77pgq7DUDKjhO+V6BfhmYUD85pA5
 oFyCYYaYwpjCkRYajhUK27zIW5F8Ra8qVv6F/HALC652WvkcHPpLTuWDLyodUMCr8SnL
 jXU6SCsyVqFGH9PqI7ZBWF/isCtQQ2HmHqkcK8OejPcySNf50h/qatbd7XNCghVlRoc4
 Lhhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Spkcq4TayC4Sg03SiEiSobwtKiAxZIs3buh6QupjT0M=;
 b=XnXMvMl9jXfcPyHj5MMt1QBoQW1H5E15SoRKZObT9VaHwB6BAwFeOYyWwxgfhnCgD8
 4KW+3jmAHeZbxnuoqHGbIoWORKZjXlle1olIErhG63J0sLfg6q7NdR7A0mxS98f6XGS2
 Nu3Z9QSV4Q/7GH6fpJ9aogdAZv9C8268rusk2ulJP7u21LmG2gfrdNnJFVqMxaqWAB4c
 DDsSJKJkRN0WUohsQ2dp2D635OrM7n7OhPTjAnMlnTCDctUdVueo9mItb1pAL9OWoz2w
 w4roZ+kFKFodbRHhCuOz4VNKbwKzU/WRbh9qGsBT4VtoOGMKiSeyTbd4TPLRwCon54jf
 UlqA==
X-Gm-Message-State: AOAM530H5Pqm77hJ1hH4/0aooiIyv5wpwFHn1Zp6VwxWCS3U1OXzpYV9
 P1nnAKvbn5orHsSu5EWDB2pbQgfV/UwUKg==
X-Google-Smtp-Source: ABdhPJxx3MawlbAYLj5ekcDGNJ7tVMMORzOO5eLVt7YAp2d6Jh/VCnd1ThuLZpfjpnn33aQ6hGkeNw==
X-Received: by 2002:a63:ed50:: with SMTP id m16mr35599pgk.195.1603119613707;
 Mon, 19 Oct 2020 08:00:13 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y65sm167087pfy.57.2020.10.19.08.00.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2020 08:00:12 -0700 (PDT)
Subject: Re: [PATCH v3 0/3] tcg-cpus: split into 3 tcg variants
To: Claudio Fontana <cfontana@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20201015143217.29337-1-cfontana@suse.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <87ba7ac2-9859-74a6-54d7-b17d0560de98@linaro.org>
Date: Mon, 19 Oct 2020 08:00:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201015143217.29337-1-cfontana@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/15/20 7:32 AM, Claudio Fontana wrote:
> Claudio Fontana (3):
>   accel/tcg: split CpusAccel into three TCG variants
>   accel/tcg: split tcg_start_vcpu_thread
>   accel/tcg: rename tcg-cpus functions to match module name

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


