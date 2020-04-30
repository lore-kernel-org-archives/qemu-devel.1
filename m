Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8EEC83003
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 02:23:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E728C20787
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 02:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FtvjsTEW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E728C20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTyqp-0005K7-4H
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 22:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38986)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jTyna-0003sL-77
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 22:22:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jTymv-0002aa-J3
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 22:19:37 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e]:46236)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jTymv-0002OT-3p
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 22:18:57 -0400
Received: by mail-pf1-x42e.google.com with SMTP id 145so2112603pfw.13
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 19:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=twoExpS4ocZ6juaajIgOBNECgpi7S7qKtK1d8Rwr6MA=;
 b=FtvjsTEW5mJSme3O/c/bmV+UgHDTf0333rjk2eSTfNj+VKAtNwCVyam55I+P5mYHVl
 k0/yOBGDpQVxCc0RL44JvGeQ3zdgqBhv4TXaDDMRVSBWdfKkrRbTqIKzY+u/y4c72Cbi
 O9uIm4S8XK4B3d33o++7plCCZlWHbNuR9F90cZnVy5ZKhfLpuvY9Ug5IyifrW7GFjmE6
 +MMwuMfDylLZ1QdkI8LuKJ1ba0sTSolcB7wOAa7wfhQo6RewGzIebfgjVKrSYYDbSxZE
 Ix/QWRpIWHxlhmNPiZt9MuMo5dJleprIE9hMQ5OarzTVohx32H6V4XUWeVS72x6G+iQ5
 VjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=twoExpS4ocZ6juaajIgOBNECgpi7S7qKtK1d8Rwr6MA=;
 b=B71nxtf1scpLjoHSGVdBCK1dpiLcVcPjBbVdlwj8lauBZPLwsqZUQ9S2VhFkLjCBYc
 sBAXlXjHLPpXAkeAWrjeOz+BoEDKsuOjR53NacKLylZgwfG9/BkeddbW8zxDPHp2nRa7
 Zfuwgw/KxSD0E8VdxLxRKAnxJUqWryYv9zTGe7H2Snj2NSdf2QVvTZ0UTjFKlLRaCp3g
 uqa4j8vnLyGH4OtYMCx542oozr4VYCWAJCgSVxmxOcuF23r6f8xHXxV+dYqIXpcoz+5q
 G8065Ks9FXN8w58RRiiBc9CJnk1dBUEDMPmBEIcGdUjDJj8S6TXaenXyuWqL+q9flmXa
 URRA==
X-Gm-Message-State: AGi0PubPe9SrjpH78CGvnctYZYe3pw8vMDC3SKwwhJTX8kBhC5tsvjyl
 ad1sk8DV45hyS7RZKcEqQKSZRg==
X-Google-Smtp-Source: APiQypK0sdI29skL0sgmo2t7rlhk9TvvZIoKmKNjnd254EpJW1TvRqb9PaYoXAv2bNKbJPZn66/9wg==
X-Received: by 2002:a62:fccf:: with SMTP id e198mr1155862pfh.119.1588213135411; 
 Wed, 29 Apr 2020 19:18:55 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id w9sm2156864pff.101.2020.04.29.19.18.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2020 19:18:54 -0700 (PDT)
Subject: Re: R: R: About hardfloat in ppc
To: luoyonggang@gmail.com, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <CAE2XoE-ZSgtceSe5wYDm3cXf8+hTvJhD5PqZSrrFW5625LcSWg@mail.gmail.com>
 <87lfmhl0xa.fsf@linaro.org>
 <alpine.BSF.2.22.395.2004271212520.94232@zero.eik.bme.hu>
 <87imhlkwun.fsf@linaro.org>
 <CAE2XoE9hiw-ri66_xp3qNa5_Wx8ZfsQB9mqJdYR8VRm-KW830g@mail.gmail.com>
 <87ftcoknvu.fsf@linaro.org>
 <AM4PR07MB350653D5961DFCE441646131CAAD0@AM4PR07MB3506.eurprd07.prod.outlook.com>
 <871ro6ld2f.fsf@linaro.org>
 <AM4PR07MB350673696C7DE2CA16C9C685CAAD0@AM4PR07MB3506.eurprd07.prod.outlook.com>
 <87sggmjgit.fsf@linaro.org>
 <CAE2XoE8wFK1nOq3YXhB=iqTvqSDQk7Zzd35Tjzdd==v8ouMijA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <43ac337c-752a-7151-1e88-de01949571de@linaro.org>
Date: Wed, 29 Apr 2020 19:18:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAE2XoE8wFK1nOq3YXhB=iqTvqSDQk7Zzd35Tjzdd==v8ouMijA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::42e
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Programmingkid <programmingkidx@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>, Dino Papararo <skizzato73@msn.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/29/20 5:20 PM, 罗勇刚(Yonggang Luo) wrote:
> Question, in hard-float, if we don't want to read the fp register.
> for example: If we wanna compute c = a + b in fp32
> if c = a + b In hard float
> and if b1 = c - a in hard float
> if b1 != b at bitwise level, the we se the inexat to 1, otherwsie 
> we set inexat bit to 0? are this valid?
> 
> we can also do it for a * b, a - b, a / b. 
> 

That does seem plausible, for all of the normal values for which we would apply
the hard-float optimization anyway.  But we already check for the exceptional
cases:

    if (unlikely(f32_is_inf(ur))) {
        s->float_exception_flags |= float_flag_overflow;
    } else if (unlikely(fabsf(ur.h) <= FLT_MIN)) {
        if (post == NULL || post(ua, ub)) {
            goto soft;
        }
    }


r~

