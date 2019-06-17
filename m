Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DB6C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 16:36:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7EA5208C4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 16:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qgxkfuyo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7EA5208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49206 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcucY-00085Y-Vn
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 12:36:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47085)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hcuEV-0005Mj-G3
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:11:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hcuES-0005lO-NI
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:11:46 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:33746)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hcuER-0005ih-2C
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:11:43 -0400
Received: by mail-pl1-x641.google.com with SMTP id c14so4296254plo.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 09:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=NrXQ/g+kH6kDE8GNapi+Qezba5CFxcsZxa5IDntq334=;
 b=QgxkfuyoEAMvjOdPk3e+AuEvvh16enWaBVHEjfkNE49tj+5cyaCu80nSwREORgy3MQ
 08qn6Mi06zwZ+RdKH/r0Gbdz/JsXNw3VaBxGArghzmkgvsZZFyqnkcgkObw0G4WRzC8m
 5YIHIdhB1KOouF4q9Q5qYU0+E/UR6ekHbiMrWQ1XwrI73G/E5jYjfow+Io08FRmEeP9k
 MbYIKA4W5BmE4l2OCk10RI6u6uhoPnzbPOgoN4NkNaeI2KMJ2iWvOCycnrkAzTTNXGEI
 Oqnr6m55oOIrvuzXCro9NiZlj+kTQrCA9PQGjUoaLtD2lFUhsg1nK0HUWf5WEcfKB8t3
 nZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NrXQ/g+kH6kDE8GNapi+Qezba5CFxcsZxa5IDntq334=;
 b=skVZwZuEf6ZTxPgTwUrWD2p3kk+uJYwWVHcaWX4eh/JYihB+ioKoklXIi2cAKhuJpG
 WSsTKySPMC/FDvGQnEg7Z7GtSVPDFCozY9ar0j70WA+U/wW9ZVPf6T4tC8CdgTHBAkqm
 dcW9Tk3BNbf8BBcf+0v1cXkvJyD9QOvKTzQCUx6mHgP6Iyu3Sgn9KrWypzUOL0lNJ7u4
 2IrAQk16hIDjXKNEz+PdR88pnmBwqwds8orJOr8SAlykcJuGamOjfH6UzbFoWlqsuwl4
 Uxp5zh9aIYqj+AJnnw+Pse0/m/fSyS57PQwZdCerFOC/aOTIw2iPso6Tm4pucN/Evj/6
 nwHw==
X-Gm-Message-State: APjAAAXCfqWmh7zjJIK4BKpGcZeB5sVe1gB5ugAzHsQM9LbJcWEQufDx
 gOBKhgJRuZltdwb9EbSfNytClw==
X-Google-Smtp-Source: APXvYqw4hmHCZnGsi8nUSBKNnqUJNMJiQO7BlGlEHnnYe0AzGhHwf8Jo3V2xjXZlMTZSldZ4YpKxGg==
X-Received: by 2002:a17:902:2983:: with SMTP id
 h3mr65035428plb.45.1560787901248; 
 Mon, 17 Jun 2019 09:11:41 -0700 (PDT)
Received: from [192.168.1.11] (97-113-2-33.tukw.qwest.net. [97.113.2.33])
 by smtp.gmail.com with ESMTPSA id t25sm11448589pgv.30.2019.06.17.09.11.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 09:11:40 -0700 (PDT)
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
References: <20190617143533.15013-1-kbastian@mail.uni-paderborn.de>
 <20190617143533.15013-3-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <ac78df7d-f59e-c3c9-8fc4-b044a941f528@linaro.org>
Date: Mon, 17 Jun 2019 09:11:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190617143533.15013-3-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: Re: [Qemu-devel] [PATCH 2/3] target-tricore: Make env a member of
 DisasContext
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
Cc: david.brenken@efs-auto.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/17/19 7:35 AM, Bastian Koppelmann wrote:
> otherwise we have to pass env down through all functions which blocks
> the usage of translator_loop.
> 
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> ---
>  target/tricore/translate.c | 340 ++++++++++++++++++-------------------
>  1 file changed, 168 insertions(+), 172 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

