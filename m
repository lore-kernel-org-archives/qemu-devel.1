Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCDCC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 02:10:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4655B208C3
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 02:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gZScW/0Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4655B208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifDvY-00028u-GP
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 21:10:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46553)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ifDuo-0001YY-Ll
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 21:09:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ifDun-00056k-CS
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 21:09:18 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:40601)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ifDun-00054G-42
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 21:09:17 -0500
Received: by mail-pf1-x441.google.com with SMTP id q8so260542pfh.7
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 18:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=vyX7QreLgESGZBkcNOCy4sl/B66hsQvvZY/2+o5GCOI=;
 b=gZScW/0Yfu+Fl9zkya/fv/1Lxf0899+RDyoqhPM5HRs5PjHVaYY4Z4BjFw40brIdPQ
 rM1MvfuBJEuHawPAQ/NrMubFrvS/tVZxk5mV1+bMcbvYTUtBcluO0EIjquQ7yabWTEfw
 YqyKY02/y5lmlAq8SVfr0heEvtanZKcfEVQEA6SzJd+cBmlzaXKwMhnK6s/OX1cQYh2l
 xlSWN5ZP4so/raL8NiDezH3sbQmrlu2xJ6S1iGjYJZqosrjELnhfzps52IbZy+br/aaC
 8eG2px1mXoBfaI/MwY9aKVFv4/09Rsie7/1IjaeBQHshhynrc6FowrVOQiMlvTCoQHlN
 8SWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vyX7QreLgESGZBkcNOCy4sl/B66hsQvvZY/2+o5GCOI=;
 b=ZgDBur8M2u3m8DbEPx1XzLJxFEJzX3IkfqEJOBNSzAw4pfm9J7KvaC1YrZHeBmL/Z2
 P8LC8WUhygci1Iymunxvji/zmIiI7z6VSwVd9rtoynldbQzStribbCPYhoIaRs8WZehd
 cj0mIecZIzGQWv3XWmcVDpdp3rkxWUdO1bC+Q1uW51M5x6wXNYgJCIHg4G99zWNIuuRw
 wJsb/POvp9TejeH5etUh3+Wie8bEx3zDLNh8+Yk97M9Rv6bhUIjYbVECdalAvCwh/6Vb
 Paxv8ea9IKzQDhnugdE3Y8WIX7sAzUCvmobYUbHxlvKd+owvyKcJD1e24Dgs7C+rtreM
 1xcQ==
X-Gm-Message-State: APjAAAXE1w2Ds1benILxK+nDO44TZHN/1wipLJOALvmViRK5ZSize9Lf
 X1eUWM7qM/a8W48u1n/Lf+uCxg==
X-Google-Smtp-Source: APXvYqzt4r+JYIP3LxkcoEM74229wKgfDcGlQJIX2BV09qVmfK4Kj+FNn1ehdPwApYD0K0uYiQiwBw==
X-Received: by 2002:a62:4ec7:: with SMTP id c190mr6968035pfb.68.1576116555710; 
 Wed, 11 Dec 2019 18:09:15 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id s130sm4368967pgc.82.2019.12.11.18.09.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2019 18:09:15 -0800 (PST)
Subject: Re: [PATCH v3 11/20] target/arm: default SVE length to 64 bytes for
 linux-user
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191211170520.7747-1-alex.bennee@linaro.org>
 <20191211170520.7747-12-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cd38b591-f9e8-2d62-2381-9bcccabbbf8e@linaro.org>
Date: Wed, 11 Dec 2019 18:09:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191211170520.7747-12-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: damien.hedde@greensocs.com, Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, luis.machado@linaro.org,
 alan.hayward@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/11/19 9:05 AM, Alex Bennée wrote:
> The Linux kernel chooses the default of 64 bytes for SVE registers on
> the basis that it is the largest size on known hardware that won't
> grow the signal frame. We still honour the sve-max-vq property and
> userspace can expand the number of lanes by calling PR_SVE_SET_VL.
> 
> This should not make any difference to SVE enabled software as the SVE
> is of course vector length agnostic.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>   - tweak zcr_el[1] instead
> ---
>  target/arm/cpu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 7a4ac9339bf..d42b88c9b73 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -199,9 +199,9 @@ static void arm_cpu_reset(CPUState *s)
>          /* and to the SVE instructions */
>          env->cp15.cpacr_el1 = deposit64(env->cp15.cpacr_el1, 16, 2, 3);
>          env->cp15.cptr_el[3] |= CPTR_EZ;
> -        /* with maximum vector length */
> +        /* with reasonable vector length */

I think this comment should mention the kernel as well.  Otherwise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

