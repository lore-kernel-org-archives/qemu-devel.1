Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F27C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:53:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D61022070B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dPqfyvzr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D61022070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFMKm-0007H6-3S
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 13:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36949)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iFMK3-0006mL-N4
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:52:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iFMK2-0002Dy-MW
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:52:27 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:41608)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iFMK2-0002DP-Hg
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:52:26 -0400
Received: by mail-pf1-x443.google.com with SMTP id q7so8559094pfh.8
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 10:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=IamS+0u8k2KB8OrUkHc8+dAuTrF8fBqWKyndWEEqrOo=;
 b=dPqfyvzrh3a7uxqWuSxWN+VJy1GbNgTk7CU8m/eYN25DRIhxj5038QzyI73yyM7N1M
 qHwVBr6lwAQkw5PpYPNcIGjL9BX2YdtzYTXsTquRAe7g1oCAK3NVKis+2+zSKVKTUzfi
 RQ4moYvIlXNIN8NH7YV7pPrzmFCCLlMH8IuETmRyddUIO34foSrFEF9mq8TI2KxBAbUj
 pd2UDAgJYIJsVxhCrSfvZhEXlrGb4yAgsSH/01cjEWnn2McO/4F036Fvn1NsYiXfWqXg
 fDkR2fV02r3FCWkDQ9vc0Gqpzj6nxgcQBWmU+xIGxtD+4RPuycLT9GHlCXyD1DYjoUzA
 uLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IamS+0u8k2KB8OrUkHc8+dAuTrF8fBqWKyndWEEqrOo=;
 b=P24zrFyKcbpHyHX/m4GgMYVaRWclifvLlJwVbmWbGeI2h4l+HECeyHapFMeyU+EVaN
 Pn/75+t4sh2Lv7SkTZGc37/OCnj3gaz36XIMTrsaPSi33C6a0qReFG2Ueo5yFm+Z/Ev3
 wHuUb/drHjuPDgaU0zvKrvOqv6LV6fOQh7m+tlL8vp3YN2yT1j0I9313gwbJkG47vSzP
 h/MgWoNu50/gmIbJtGXwtn0L/dsT/yvLEKezq6oh4lg35eK7W0mbuoFOug7xF4VIBhtp
 noW+awiMINxn/OJMSuOtYi+9bl+Qr8IwqtkSHSi5ZE4ZxA7UwwBoIGQ7DGuqeKcsRdZB
 3b6w==
X-Gm-Message-State: APjAAAUbwShj8wY/uNMZ8P8vOVfYCnK30QIv2rzOOcGArJEDEFBeSyUJ
 r/uNooGa6x1LggcRRWu6tl2ESA==
X-Google-Smtp-Source: APXvYqyUdGXUSQpbOyELCIMlgZN1jCNn37UT+braM2Vl9kkDthbvSGTcqUvnsE5RmpDGMGaznr76cA==
X-Received: by 2002:a17:90a:5886:: with SMTP id
 j6mr6701868pji.137.1569952344168; 
 Tue, 01 Oct 2019 10:52:24 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id r11sm23427490pgn.67.2019.10.01.10.52.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 01 Oct 2019 10:52:23 -0700 (PDT)
Subject: Re: [PATCH v5 5/9] target/arm/kvm64: Add kvm_arch_get/put_sve
To: Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20191001125845.8793-1-drjones@redhat.com>
 <20191001125845.8793-6-drjones@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <5d79e6bf-2b16-b7c9-726d-226d149f7e4e@linaro.org>
Date: Tue, 1 Oct 2019 10:52:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191001125845.8793-6-drjones@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: peter.maydell@linaro.org, armbru@redhat.com, eric.auger@redhat.com,
 imammedo@redhat.com, alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/1/19 5:58 AM, Andrew Jones wrote:
> These are the SVE equivalents to kvm_arch_get/put_fpsimd. Note, the
> swabbing is different than it is for fpsmid because the vector format
> is a little-endian stream of words.
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  target/arm/kvm64.c | 183 ++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 155 insertions(+), 28 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


