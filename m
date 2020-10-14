Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC18C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 19:48:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31C97214D8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 19:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FA7Q3e6G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31C97214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSmlc-0005Vk-UC
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 15:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSmk8-0004z2-6y
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 15:47:27 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:42247)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSmk5-0004q2-R1
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 15:47:23 -0400
Received: by mail-pl1-x642.google.com with SMTP id c6so252875plr.9
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 12:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=8ePLNG1GGX2WA5+Lf2MFQW1uunfFLZ1kHQ0fuywXhhU=;
 b=FA7Q3e6G3NRFN9V0TJ4SqPud4rUkPS+x9mbwSn8lIdSHuUtz9B8myh/rCMq/XqXTU3
 yuUdAZSqNEgySQaMQaiIeL+7fwj8i+E9031twetNZyWK6ttJPDbDTZG9/gg9gQWL9JBn
 6+2ZsBoCMFcobsprbVCZhnUZnkgjhd1xHRXOIMWTwRvEmZ3aadHRQ74KuzbY0aSztuTr
 AiWetO6Mj5cvCiWnQY0LvKf7DQF7YM+9bqOJNGexdqRoj7nSyVp6D/5DOBSv9W+gVVRD
 leU70Gc2xIVeKZ6XQjqFIuOiy+FiRjJicfuwsBzr9qE+C6fCaQoT9BrmzhU4gqKFcjE8
 b9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8ePLNG1GGX2WA5+Lf2MFQW1uunfFLZ1kHQ0fuywXhhU=;
 b=cr2NLRuKeXs5G6pnLxGQPjvzdt7vH/UWgA8THKhNFdyuIPnhAsbRiJc6BnS8cdB9eR
 5byJ/EjfQGfbKWcWsQ2DBhoZpfM3/bXEssQPW2K7dhbYNjFFAR58ErASWuljigw7UatO
 xQX2v6Oxq36HIacaDuD3mNtI54e7bzX+QtOVP7/eVTQY7jWJZVuRlRJknt82oRkSIQUY
 PqBo9BObZXOsnJgftYNUZGpM6pkfuyoMdvta3X9e8xFBDMqAlJXS1FlUgENr646QP7Db
 W83WdTy3cN3IK9ADkzuYJAOmi+wrsVMW0OM9pIQcBMP9HpFAcz8lj0BH8D4gOZEvUP3T
 epPA==
X-Gm-Message-State: AOAM533hqFF125itYjMcEOFcI7ea6182Xx//ml3AUjt0k6VR3BMWMbGR
 k0TculaFxm7U2SJRD5P7IF/JjcIM+9QNKA==
X-Google-Smtp-Source: ABdhPJy/y/cJnqcibW9u1kmUErYEyfWVaULcDRF2KMkDzguzUhZhVLIATV/IE4qhGKDlrLnJiUD/Og==
X-Received: by 2002:a17:90b:50a:: with SMTP id
 r10mr727448pjz.231.1602704839467; 
 Wed, 14 Oct 2020 12:47:19 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id q16sm384706pfu.206.2020.10.14.12.47.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2020 12:47:18 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] accel/tcg: split CpusAccel into three TCG variants
To: Claudio Fontana <cfontana@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20201014192324.6390-1-cfontana@suse.de>
 <20201014192324.6390-2-cfontana@suse.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <21a20694-05df-4cf6-24a3-6e90db09c3a0@linaro.org>
Date: Wed, 14 Oct 2020 12:47:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201014192324.6390-2-cfontana@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
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

On 10/14/20 12:23 PM, Claudio Fontana wrote:
> split up the CpusAccel tcg_cpus into three TCG variants:
> 
> tcg_cpus_rr (single threaded, round robin cpus)
> tcg_cpus_icount (same as rr, but with instruction counting enabled)
> tcg_cpus_mttcg (multi-threaded cpus)
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Claudio Fontana <cfontana@suse.de>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

