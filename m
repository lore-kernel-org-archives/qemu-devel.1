Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279C8C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 17:34:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE71520659
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 17:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lm7lldzV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE71520659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIcKD-0000T2-7m
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 13:34:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50561)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iIcJJ-0008M1-3G
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 13:33:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iIcJI-0000P4-0t
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 13:33:09 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:40346)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iIcJH-0000Np-Rx
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 13:33:07 -0400
Received: by mail-yb1-xb42.google.com with SMTP id s7so2202728ybq.7
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 10:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=gcW3IYs5nfyJdOZj8TvbqqqMdLvirZp+fSU6XHQ36Mc=;
 b=lm7lldzVqgE434ug4IKW6hpD71Zp1cVFKHP5XZYo4Vn7D/w0fvmjCg0Dz9fOBELX1E
 RaQYVfKEUh+c1JcD+6bATtqsZhgfDzR7f8AfRgRZmNJeqtg47Yj1/+gwG4NpD1EwxEas
 gy7OGndYdla1+Lr+7r39yUiFkhMFhGE8O4I/4zn2/KbD6pCedU1R8/JoPKJKjf/bKUMu
 Z6rWO9UrEfVFPFlsCjxVHuPgHGvK26+3xcPtASxzioNyJ8TRoh8XIr8GeANFtsA+SHtI
 IwpERCQpthY7Htq6oVxHE9iLQ/5uvodOYNGK+m0DrhyG4q1XI/R1Mvqe6D/AayMq2O99
 DEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gcW3IYs5nfyJdOZj8TvbqqqMdLvirZp+fSU6XHQ36Mc=;
 b=eaQh7Wqw/T/6KeAu9V0zJUzx6+JMltBC6DdWCOfPWU81EDKUP7NBfX+1s+GGvz4CC3
 jo98G1ImwW9dLtK3FCzYVWOrckHYWVxgDrfcHpcOxVDfmgZdBXgArZnQiz9LahvGgkKM
 NWPn03eX/AK5YDJf0MleLF7rxjy2Aw7nCFVPfjfU7EDqtrshpo3uw/51enNzB/fWEiIY
 F0fv+qps0r4gr59UqVgYdy2itUh6b4j7bbYTWLS594oIdRGfYh3X4Qmb0+lo1tIGxts7
 HlHRMu4QhttxqpK315dWQwkzc68y5PmLhnn6ixjOXdDTqRQrvkMcUGykeDZk3KhJeO06
 XMuw==
X-Gm-Message-State: APjAAAW6NM5PbCtBeJTSGFlFmB6/wiAI0v1LQRBG0KdznmtlB6HA6V/A
 JqNEZZ8YZJUX6PhZSqfzRyHRuA==
X-Google-Smtp-Source: APXvYqx0V9RfI1qkmPr8Jnoj3MepiHPZnhY0bh/qnsvv3yarYgxqrzRRNSggl3N/sZhxSUqBJrnA8g==
X-Received: by 2002:a25:204:: with SMTP id 4mr7084230ybc.242.1570728786739;
 Thu, 10 Oct 2019 10:33:06 -0700 (PDT)
Received: from [192.168.1.44] (67.216.151.25.pool.hargray.net. [67.216.151.25])
 by smtp.gmail.com with ESMTPSA id w123sm1688740yww.22.2019.10.10.10.33.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 10 Oct 2019 10:33:05 -0700 (PDT)
Subject: Re: [PATCH v2] target/arm/arch_dump: Add SVE notes
To: Andrew Jones <drjones@redhat.com>
References: <20191004120313.5347-1-drjones@redhat.com>
 <f23153f2-35be-f74d-ad7b-d9c324cba1cf@linaro.org>
 <20191010061600.pwhos4huazbsv6kn@kamzik.brq.redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <6451070f-9488-cc8f-2f4b-a7577e11f447@linaro.org>
Date: Thu, 10 Oct 2019 13:33:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191010061600.pwhos4huazbsv6kn@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b42
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, eric.auger@redhat.com,
 qemu-arm@nongnu.org, alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/10/19 2:16 AM, Andrew Jones wrote:
>> It might be best to avoid the ifdef altogether:
>>
>>     for (i = 0; i < 32; ++i) {
>>         uint64_t *d = (uint64_t *)&buf[sve_zreg_offset(vq, i)];
>>         for (j = 0; j < vq * 2; ++j) {
>>             d[j] = cpu_to_le64(env->vfp.zregs[i].d[j]);
>>         }
>>     }
>>
>> The compiler may well transform the inner loop to memcpy for little-endian
>> host, but even if it doesn't core dumping is hardly performance sensitive.
> 
> True. I even had something like the above at first, but then
> overcomplicated it with the #ifdef-ing.

Ah, I wonder if you changed things around with the ifdefs due to the pregs.
There's no trivial solution for those.  It'd be nice to share the bswapping
subroutine that you add in the SVE KVM patch set, and size the temporary array
using ARM_MAX_VQ.


r~

