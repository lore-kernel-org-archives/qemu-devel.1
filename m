Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B862C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 15:11:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E96220781
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 15:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M945kNsQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E96220781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5sPm-0000hy-JQ
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 11:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k5sP0-0000GC-15
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 11:10:54 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:41825)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k5sOy-0000r5-AD
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 11:10:53 -0400
Received: by mail-pf1-x441.google.com with SMTP id a79so1167994pfa.8
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 08:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ph3yn6NSHab5GEJht0sxVWjuqL19952d1xRJxAkl8V8=;
 b=M945kNsQyniAaUMS1ZHwaYkxrhBUCHL0Cl8yKBG1U/NM+jjzEqe89dpJBHxFHDiX67
 JSpbcmxd+c6VsBl78AKPqPK4GqCge0g21pjGlWoWF/b++bd84Cz/Hpx1fd9kE1zl4MAj
 V15HYdBPRp50i9F/M95/JmG3eLstX0H8ZhcFEAfVjleL3zYeKEKREaIujAPzy98IZD4n
 eQ1zuwl3yaO4/LiG9Dh2/VJe6PTIXLqJNzVF2QiqNkxO3ZpZtrAtuVCwA9xGSghIQ4Y+
 WnIhZvfRaJMClORT0JXmOYAxtFeGLANnib4Zl4gqQjRl796Ty7xw3rqWnnzK4BlrLgJE
 PGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ph3yn6NSHab5GEJht0sxVWjuqL19952d1xRJxAkl8V8=;
 b=J6gPjGR8ZpTdmmH6HAw+SPKoW8a356/FneMMPcaOq9lSQAW+nYRnqXkZRhW/gFBge+
 IPEkC6g097xO/1VwfC6aJVwb6s7/SX0drb8+FA9VKi01WVlN1BVfvE3RSZPjrO26iMQ2
 E2Yn1pfPEtk86XycwdrgHx1zT97dLpOtfweKnJv9NyqIVLPsUR4Yzks/8/5InAcWd29l
 37Q4GxkILJ9RRfJ823eFUsIYYX6XvUrETv67RuAb6jeYdFZvJVXiZoVXIiS6H31Euk9X
 RUtad2YGwNdZCV70AOZfxRI6GGMKo24z6k61IVEGJbR1s0wxj0Fhmu9dtCb4yvfSpbAC
 fzJw==
X-Gm-Message-State: AOAM531KhyVlk4LPNxcIVZ6sycfuGdV8Z5ODkt2supjK1iDIiNHad6vm
 gm9sqrhPqqrI+kzRrq8Ub3Zgjg==
X-Google-Smtp-Source: ABdhPJw/pxQmeUUHnZGnJiBpIwIPRM6LZbL51oFTmTkOVU09a6RhjeHrWSV9QgyYzr2gLoRTpdj7+A==
X-Received: by 2002:a65:6119:: with SMTP id z25mr5746737pgu.52.1597245050488; 
 Wed, 12 Aug 2020 08:10:50 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id il13sm2652920pjb.0.2020.08.12.08.10.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2020 08:10:49 -0700 (PDT)
Subject: Re: [PATCH 1/2] target/arm: Add cpu property to control pauth
To: Andrew Jones <drjones@redhat.com>
References: <20200812065339.2030527-1-richard.henderson@linaro.org>
 <20200812065339.2030527-2-richard.henderson@linaro.org>
 <20200812110049.ghtvl7dmtspkfdor@kamzik.brq.redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2219f3f9-7894-f898-0cad-43eccaa2a70d@linaro.org>
Date: Wed, 12 Aug 2020 08:10:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200812110049.ghtvl7dmtspkfdor@kamzik.brq.redhat.com>
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
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: mark.rutland@arm.com, peter.maydell@linaro.org, alex.bennee@linaro.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/12/20 4:00 AM, Andrew Jones wrote:
> On Tue, Aug 11, 2020 at 11:53:38PM -0700, Richard Henderson wrote:
>> The crypto overhead of emulating pauth can be significant for
>> some workloads.  Add an enumeration property that allows the
>> feature to be turned off, on with the architected algorithm,
>> or on with an implementation defined algorithm.
>>
>> The architected algorithm is quite expensive to emulate;
>> using another algorithm may allow hardware acceleration.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/arm/cpu64.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 64 insertions(+)
>>
>> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
>> index dd696183df..3181d0e2f8 100644
>> --- a/target/arm/cpu64.c
>> +++ b/target/arm/cpu64.c
>> @@ -572,6 +572,69 @@ void aarch64_add_sve_properties(Object *obj)
>>      }
>>  }
>>  
>> +static const char * const pauth_names[] = {
>> +    "off", "impdef", "arch"
>> +};
> 
> Hi Richard,
> 
> Please add three boolean properties, rather than one enum:
> 
> pauth:            enable support of the pauth feature
> pauth-fast:       enable QEMU's fast non-cryptographic hash for pauth
>                   (pauth must be enabled)
> pauth-arch:       enable the architected algorithm for pauth
>                   (pauth must be enabled)
> 
> These booleans can then be added to the cpu feature probing list used by
> qmp_query_cpu_model_expansion()

Why are 3 booleans better than one enum?

I'd forgotten about qmp_query_cpu_model_expansion(); can it not take anything
but booleans?


r~

