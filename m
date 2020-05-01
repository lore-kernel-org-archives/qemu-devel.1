Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4427C4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 16:18:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CE37208DB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 16:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TQ1KxrsO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CE37208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUYMh-0007WN-Pn
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 12:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUYIi-0005cu-6S
 for qemu-devel@nongnu.org; Fri, 01 May 2020 12:17:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUYHO-0002ZZ-KJ
 for qemu-devel@nongnu.org; Fri, 01 May 2020 12:14:07 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:33307)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUYHO-0002XY-4F
 for qemu-devel@nongnu.org; Fri, 01 May 2020 12:12:46 -0400
Received: by mail-pg1-x544.google.com with SMTP id d17so4750983pgo.0
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 09:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+TooijH//DtWBgQpHCa9Tmeejeo0VI0gowBLeZ0TCyM=;
 b=TQ1KxrsOG7UCm+dfz63hm4npVoJVTcSJ4rP34uihMcm9OGsuiDezBco7KKoIQVzPhW
 PcFymsfJqVQqFVv6BzJDCfX707WTV7baV4Ef1lESbWcI74ZrADHk8q2GCcCPmVWDCjyo
 m/4Vf1uVSAdb9MH31LeLXq5W6BYjNTI69w0hOJj9NWPdGUGbbWfLs62qd1dcNdFkKBvG
 Fjjz3wBhzA2+e+2cpT3HqcrIaz4b0AVjBrFbYxNpeyWlBszIYDL5QWx64980MLG4IhR/
 F5xAFPBdJQKQYle9ftvCPw2FfW8Jx8ARC5ehpPGdc4srwKepQ6aWtvlOylW4VfaTgqkz
 9qWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+TooijH//DtWBgQpHCa9Tmeejeo0VI0gowBLeZ0TCyM=;
 b=UtqqtuRoRF6Qb32vsptna4F5EggXHxyZ0puNzXM8TtyV/93OAZpEa/050dcNFi4abw
 RObmEvZwifsXWd3G8vVgEyr+RP2c12B9lmW+Qsobrgk1kHPcoJ5KQ2u0reIej8gTChFF
 yVLT82UTeX/wUTWSeRlePsYHCMXRO5Y+xyNrPpmW8+tpbed0nrlCnCBeTxg6z9khO0Ca
 LfWxH9Ahamr+zbZy3hvJRhYihgfd57YCTo8JcSSHdTD6ji8Ufyo6knEP2IiB+JRnHFGf
 NLlB1eBLvuBe9OUEiWV1Y1eFqCxoSvlZJziBkjHScrGhmsovxGidS0RbtuEK19DtecZt
 tzsg==
X-Gm-Message-State: AGi0PuZnBFy45dD9mqvQap6df0RgR+/N6gZsB4g6WJ4Jnt2ZIAJ++S97
 DLrdAHKhFwtj0eknn+ngE13BkWGNpFw=
X-Google-Smtp-Source: APiQypIviZYsX6D66mfnY5yKzHL80IuYqzS8B3WNhrGimusreS0ERwOGaVSUze8/dGijLjpMRjdpUA==
X-Received: by 2002:a63:1d11:: with SMTP id d17mr4865641pgd.437.1588349564343; 
 Fri, 01 May 2020 09:12:44 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id 138sm2609402pfz.31.2020.05.01.09.12.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 May 2020 09:12:43 -0700 (PDT)
Subject: Re: [PATCH 23/36] target/arm: Convert Neon 64-bit element 3-reg-same
 insns
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200430181003.21682-1-peter.maydell@linaro.org>
 <20200430181003.21682-24-peter.maydell@linaro.org>
 <366a2e79-d963-bfdc-fcc6-2a63026fa1db@linaro.org>
 <CAFEAcA8M6M7CYg0AsTVbmfX88jzW9MZvRFihQ9cGDJNHhXV+Pw@mail.gmail.com>
 <2050ff9f-1338-2b6e-230f-e07c72ece3e5@linaro.org>
 <CAFEAcA8u=0LED6BQdkDCa-i3ySk986oSnMQzZj4KaBaBQ5tDuw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <40a41c49-3636-d7fd-6b62-689686d83c3c@linaro.org>
Date: Fri, 1 May 2020 09:12:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8u=0LED6BQdkDCa-i3ySk986oSnMQzZj4KaBaBQ5tDuw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/1/20 8:57 AM, Peter Maydell wrote:
> On Fri, 1 May 2020 at 16:50, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> The original intention of the hook is to expand some inline tcg ops.  That it
>> can be used to call a helper is a happy accident.  For a helper that needs env,
>> ideally we would use tcg_gen_gvec_ptr and handle the vector with one call.
> 
> The inconsistency where half the helpers nede to be passed cpu_env
> and the other half don't is really irritating for writing code
> that calls them. Lots of ought-to-be-common code ends up needing
> two versions :-(

Yep.  Lots of room for additional cleanup here.


r~

