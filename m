Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75238C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 16:19:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4206C20724
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 16:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LFj0uLrc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4206C20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFKNK-0005Jo-BY
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 12:19:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43977)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jFKM3-00044K-24
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:18:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jFKM1-0002gg-OS
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:18:38 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036]:40667)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jFKM1-0002g8-EO
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:18:37 -0400
Received: by mail-pj1-x1036.google.com with SMTP id bo3so2672103pjb.5
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 09:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=flsAJn4eGczSRX1xDLpePjSqCc4E7CYRaCeGTQZS1kU=;
 b=LFj0uLrcuAiVsgBZ2OsBWfSuSvAq2NGe1uu/JCONTKgD0+8QgcUHV+qqm/s9Z7UWct
 PFO8GPoxiSTTznhGO1BqFR8B5p0/bz2YWfndLGzVJn5o3OwQw4WIcEX+m3jsT2HcmlXF
 YuTAwg7MkShmlANpZEYLnnyx8Nf1SJVcsVxw/KnQqNntbysBdc6uWYvP8sDwOjam0EiI
 CUhhZn0Blsviaeko61fsKtfwG0VNDnvaeeEU7H+aHnUnMOpdSFya8pHglj6SRax3WKnr
 zEpkhz5hfOT41fI/qToO8NYC/xAWnv+ejGxvxAOLF39tYoWmB93JwTtR1tp5sgSOZ7p0
 qTFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=flsAJn4eGczSRX1xDLpePjSqCc4E7CYRaCeGTQZS1kU=;
 b=hMPlI/YejsT2NiiaG/elFk4sS3xk/taQxXO1nsslfm5RiDZDM4g3ddNAkskoUMu259
 /XZDWKn/K4kkgRDNtLa/DPWjZhhwFuB0gUh8G+TgKia6U2sX/r5NKIxnjFtsByYrJ1xD
 b0Ym/wSKuZ7uVPvk7OjCK6Nd4hi8RM6yMWfMgQeSPu/XnJy3mw3Igf+IVoNUywGHuwK7
 bfWtNCtusv43c875wmRAxw+tjRQrnHSYp9l1L8c6+bXMUYq7vNfaER0k8MFUwKAJxCzh
 bdPOR/7+8oFLr7kSt1QQVwBCwJmet03m641NJc+DgRp219RPTV8FxTAWqKOJso1tzG+Y
 QRgw==
X-Gm-Message-State: ANhLgQ3qzlQdLcZCVgzaJHgMAh23Qii0ap/yCUQFuCoau1bA0vzB3ryI
 bAMM8rXiFqFCd+YsgCCJ15m0xQ==
X-Google-Smtp-Source: ADFU+vtXrQoJKUiOx7AEup1iyJnp+fXu5lqOnvCCX1Mg7nONFrO85aiv4ZjxqJm8WRjVKjH9lQHrEw==
X-Received: by 2002:a17:90a:8806:: with SMTP id
 s6mr10496050pjn.141.1584721115441; 
 Fri, 20 Mar 2020 09:18:35 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 x3sm5848571pfp.167.2020.03.20.09.18.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Mar 2020 09:18:34 -0700 (PDT)
Subject: Re: [PULL v2 05/13] target/rx: CPU definitions
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200320103551.29246-1-f4bug@amsat.org>
 <20200320103551.29246-2-f4bug@amsat.org>
 <c7cf4bab-b9ac-4387-0709-a02c04b24061@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e4bc22f6-128d-99e9-9359-3253f666c065@linaro.org>
Date: Fri, 20 Mar 2020 09:18:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <c7cf4bab-b9ac-4387-0709-a02c04b24061@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1036
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/20/20 9:04 AM, Philippe Mathieu-Daudé wrote:
> Not related to this patch, but this line generates a warning with Clang:
> 
>   CC      rx-softmmu/target/rx/cpu.o
> target/rx/cpu.c:158:33: warning: The result of the left shift is undefined
> because the left operand is negative
>     address = physical = addr & TARGET_PAGE_MASK;
>                                 ^~~~~~~~~~~~~~~~
> include/exec/cpu-all.h:234:45: note: expanded from macro 'TARGET_PAGE_MASK'
> #define TARGET_PAGE_MASK   ((target_long)-1 << TARGET_PAGE_BITS)
>                             ~~~~~~~~~~~~~~~ ^
> 1 warning generated.

>From configure:

> # We use -fwrapv to tell the compiler that we require a C dialect where
> # left shift of signed integers is well defined and has the expected
> # 2s-complement style results. (Both clang and gcc agree that it
> # provides these semantics.)

Clang is *supposed* to be not generating those warnings.


r~

