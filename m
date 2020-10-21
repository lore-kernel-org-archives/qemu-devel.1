Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C32C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 18:15:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDE9A2225F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 18:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u7iiVA3P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDE9A2225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVIdW-0008Rp-N5
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 14:14:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kVIIp-0005eE-5Y
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:53:35 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:55467)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kVIIn-0000Dv-AB
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:53:34 -0400
Received: by mail-pj1-x1044.google.com with SMTP id c17so705745pjo.5
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 10:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=nemLdIzAbVV3iit21VxFg/RJjcwodeLTGEMO0ahmNv0=;
 b=u7iiVA3PeNNxRs0RVvipfUGVq6r70D0VYylZZAQ7hxnmeNqrpO1khdoMprc7U4IR9F
 gUGt3GjsntJBl8MUhTCdYleRFf5l3U/kMrBeJMHyJNNDsgMG9OLn0IQPRl0kymYFlATl
 foFIOWhGVt0EziDmZ4gu3eXzCjTeTDySJJgugW63bAL9pwW26zFX0L+EtMQa5oPX3kfx
 Z9StJyBWxN6rSu9SVHMKt+qumMHNNKD/GaAtcatMsYSzDr9TTMHploeuXNnq6/i5qlcu
 PUA0JdNpZE9sIYxmjSGjrpwF4r3xCSPo7x8Obw1AVyEsayqEQo4X3vfNrO2ld5dpqa5v
 LrBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nemLdIzAbVV3iit21VxFg/RJjcwodeLTGEMO0ahmNv0=;
 b=QDR2OF0KJ/u+YDVXQYH52UOS26n2zNXZQIetxh7vOpAsCji/zGWn+HGDf1IJ0SI+KT
 cOPJcAZ5mXU8PrbDscvWTr5aCZH8kb+mhhK67VZR/xSuU4cV8SQazZhe1XFM6VoYHnjr
 6+yupWEd6sEn4mG6cbPI6ZSc3PEW/jat+PGy8JA+HcZr02QwV1zGuGeWU1LaKwgqmQMS
 cVp9O8dGYb/ByqHx7XVK99OWeNxYZ+gdfN3SDPqH/VPIKHQ/ADz41J0chmPso5k3XpYY
 oqg0hH68i2PgMGMFbFDmCuU94U5gUUWc5/g69LEIpgspapDujcwsGkZgRNO2KpCcldu7
 OhIg==
X-Gm-Message-State: AOAM5321GPGuMlcXYxwDQNIRIlj3EdM9xqsb2hEWj+zycxbOvuvVF8oj
 mml56efScYY2NcgZmVkrsBWBpcyYK3shCA==
X-Google-Smtp-Source: ABdhPJykPeUMnR5QIYig6No82FXFbXTIDtjpPnRKfF9BCTdsV64hg/AGeLnk39EK5lS9CZFAOxajiw==
X-Received: by 2002:a17:90a:4f0f:: with SMTP id
 p15mr4506239pjh.10.1603302811144; 
 Wed, 21 Oct 2020 10:53:31 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j23sm3023968pgm.76.2020.10.21.10.53.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2020 10:53:30 -0700 (PDT)
Subject: Re: [RFC PATCH 00/15] softfloat: alternate conversion of
 float128_addsub
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20201021045149.1582203-1-richard.henderson@linaro.org>
 <87o8kvv5dv.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3d46934a-924a-4f42-56d6-cb29200ac994@linaro.org>
Date: Wed, 21 Oct 2020 10:53:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87o8kvv5dv.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
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

On 10/21/20 10:46 AM, Alex Bennée wrote:
>> This layout, with the big-endian ordering, means that storage
>> can be shared between them, just by ignoring the least significant
>> words of the fraction as needed.  Which may make muladd more
>> understandable.
> 
> Would the big-endian formatting hamper the compiler on x86 where it can
> do extra wide operations?

Well, you couldn't just use Int128 in the structure.  But you could write the
helpers via int128_make128/getlo/gethi, which would still get the compiler
expansion.


>> However, the big-endian word ordering means that Int128
>> cannot be used directly; so a set of wrappers are needed.
>> If added the Int128 routine just for use here, then it's
>> probably easier to bypass Int128 and just code it here.
> 
> Are you talking about all our operations? Will we still need to#ifdef
> CONFIG_INT128 in the softfloat code?

If we decline to put the operation into qemu/int128.h, because they're not
generally useful, then yes, we may put those ifdefs into our softfloat code.


r~

