Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9C1C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 18:13:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0916E2073E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 18:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nr8KaqPg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0916E2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr3if-0008Mf-Ay
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 14:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jr3hc-00071I-FQ
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 14:12:52 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:44297)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jr3ha-0006ZU-4J
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 14:12:52 -0400
Received: by mail-pg1-x543.google.com with SMTP id j19so6977041pgm.11
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 11:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=52SjRpelGDDZQz+t//MCqquF09vSsud6vEySKialctw=;
 b=Nr8KaqPgERw/vNWZbbe9qxT4T1QunDqtLc6tlE/gJBGahjHpWqMPm39FWrwK5o4ZX6
 OOqLDcJiuxG+zPSqoqwENNaNS2zD89GJZ0Ykz86BoX6Th0jZYwWPe7aLYyBDl+rhw+/J
 BY8Tn1PCFv6jd7Vca8YGEbs1wM9vvk2pUaPUZo9RsjPOABfhMEYJgdWUDM7Wr2M/UUj9
 wROfPXHttOVWPFMj1hCQxhr/FNZ7Vy4yxzugxMHTXun5zwA0NdcIrn3vdrKqkTjoH9BW
 O+H9qBmbyOv2u6s8E7ZOBlGHFmEyaV9BidgpnhO7FCeL2rY37oqhprkvhLckXL/0VBrw
 ZHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=52SjRpelGDDZQz+t//MCqquF09vSsud6vEySKialctw=;
 b=seJHtBPoe5WwqVOa/EdtW/uHK6XJDMaeqXlAh8eORHGPlgXpYx33Ce8CEzMfiMzfB+
 xBanTo0w5c9MpnV168ScG/PeofsF4OjV4PEIFNRc0Uym/9r/hSROf6ynlHi8ImpL08Zb
 MnY2mE417Y4quX9N6BYnRSaGrlw07Sf0UxVrh5Dt9clGXEKgF7c1wG67KYWwKX1EtbZ8
 JS1pNqyKt+8msAze1YcG6jQK5TTePvJFvyLLMz+Fp1jA0v/09DMOJJxuLF4KPSgD30gH
 qUen+zsKrIF8dvR8iiTk0WNm9UHZqWlFjSx00TPpzog93vhhc95zeH6bxUdB5cuCi1Ac
 FzDQ==
X-Gm-Message-State: AOAM533VYJCo9HStQsfedp97IecyT7QcAsGpAP37asQGHLs2RbH4JVdV
 jOOaDdtFaARrNf2uJss+OTLcRA==
X-Google-Smtp-Source: ABdhPJyasbKQat8LmyNeONfDOvDwCxj2fDsPpvSVFWxC9DvCQa5xf3349F5X1X/6oe5arJIwsTPuxQ==
X-Received: by 2002:a63:2241:: with SMTP id t1mr25233366pgm.440.1593713568323; 
 Thu, 02 Jul 2020 11:12:48 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id a17sm8386940pjh.31.2020.07.02.11.12.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2020 11:12:47 -0700 (PDT)
Subject: Re: [PATCH 1/3] target/nios2: add DISAS_NORETURN case for nothing
 more to generate
To: Wentong Wu <wentong.wu@intel.com>, qemu-devel@nongnu.org
References: <20200629160535.3910-1-wentong.wu@intel.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9a87dfee-add3-dda0-829b-87d97a4c3bdd@linaro.org>
Date: Thu, 2 Jul 2020 11:12:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200629160535.3910-1-wentong.wu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, marex@denx.de, crwulff@gmail.com,
 peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/29/20 9:05 AM, Wentong Wu wrote:
> Add DISAS_NORETURN case for nothing more to generate because at runtime
> execution will never return from some helper call. And at the same time
> replace DISAS_UPDATE in t_gen_helper_raise_exception and gen_exception
> with the newly added DISAS_NORETURN.
> 
> Signed-off-by: Wentong Wu <wentong.wu@intel.com>
> ---
>  target/nios2/translate.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

