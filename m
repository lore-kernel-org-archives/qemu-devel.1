Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6032AC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 17:41:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CBA820663
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 17:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NLLp1hG0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CBA820663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVf5U-00053b-5z
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 13:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jVf45-0003rr-W3
 for qemu-devel@nongnu.org; Mon, 04 May 2020 13:39:38 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:38385)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jVf44-0004UK-UQ
 for qemu-devel@nongnu.org; Mon, 04 May 2020 13:39:37 -0400
Received: by mail-pj1-x1042.google.com with SMTP id t40so206277pjb.3
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 10:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=gMKRgDXoKJ+3AJDIwL0Efw5GmPXpBh0fZvIx+HT67iY=;
 b=NLLp1hG0WNiiT9aDOz7wxKXT95VF2F0QyhsUo2HkE49+aHalGzjggeJO7PPyKJAjeh
 7vdnr0eFYsLLk/UiyOXnP+78CUH/tA7wk/eTHaKGlTVKoAcHBMSf1YRsyG0k2mxmWMyf
 C5i1Kgy0y3Xc6sH2g7e/hnMFwvtgoI4Y8yDk1X+n8B7yqJ6FYkc46hKUFAcyDD+8Hu4g
 4HEDWw4p+AhyKjPzZK+XX+coQ6nJKUMAoXBBLU/Njt34Ct4huKkj7/3pvJQAUmZ7zu+7
 Wj62gmqUfqbY8NS1whk912pv73m2xe2ETVp7/gCYxM2wvjoPe7yzJ8YsTFc7XhvlPI7x
 cSWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gMKRgDXoKJ+3AJDIwL0Efw5GmPXpBh0fZvIx+HT67iY=;
 b=Cp5arYeG0I8QwoZCirQpy6tRPrf7gr9QowqBX58zjlIUGrrY1EEkKdlBzFGPRVf7qE
 oloV37qBlZs3wjzFEb04dD6Ldycs6StsOzc0DnF3zkZw5mI3/I+LFKNYT6Dv2cPptlCW
 j4nuxlPZ6EYAsC0pD8wkMAuv2CazwuquIUx7vyD2Qvy1nbGGoMkF80rDdY36YGs7RegO
 2hUPBlkUpf/WLsLv68U4zxdZsA6NeS1zc5MXyFD+dg9XZExn6egMdyayb9JP6SUYt3ZA
 FF6Ygm2XB8OCN6w5LxlpDiyw7zs1lgaiogXIu9tk7VtIoGAfZvRSY8BqWUD5/yavSIV3
 Wbew==
X-Gm-Message-State: AGi0PubX8K7Xy+RJxih5qXikP/2/TeJ+Ij0VVapggdnfE4MICV+v+POl
 rT8TQ0VPb+jfI+gGSTZjprJIBQbo1+8=
X-Google-Smtp-Source: APiQypIio31KrJ5Nw9clsg4wvYhDQ8/2EeN6Nr2pY7/7LSMOR5JHZhQrN7LyWaocnKoLTNKIO7gw1A==
X-Received: by 2002:a17:90a:8b:: with SMTP id a11mr59140pja.163.1588613974732; 
 Mon, 04 May 2020 10:39:34 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id m14sm8037530pgk.56.2020.05.04.10.39.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2020 10:39:34 -0700 (PDT)
Subject: Re: [PATCH v1 4/4] .travis.yml: reduce the load on [ppc64] GCC
 check-tcg
To: David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200501111505.4225-1-alex.bennee@linaro.org>
 <20200501111505.4225-5-alex.bennee@linaro.org>
 <ad941829-a2f3-6ef3-6251-0681b36be24a@redhat.com> <877dxvke0o.fsf@linaro.org>
 <20200504021047.GA13695@umbus.fritz.box>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bfdd7881-c9e8-d058-52a8-1c88518b90fb@linaro.org>
Date: Mon, 4 May 2020 10:39:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504021047.GA13695@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/3/20 7:10 PM, David Gibson wrote:
>>>>           - TEST_CMD="make check check-tcg V=1"
>>>> -        - CONFIG="--disable-containers --target-list=${MAIN_SOFTMMU_TARGETS},ppc64le-linux-user"
>>>> +        - CONFIG="--disable-containers --target-list=ppc64-softmmu,ppc64le-linux-user"
>>>
>>> Cc'ing David, since I'm not sure about this one... Maybe split as we
>>> did with other jobs?
...
> Hrm.  I'd prefer not to drop this coverage if we can avoid it.  What
> we're not testing with the proposed patch is TCG generation for a ppc
> host but a non-ppc target.  e.g. if the x86 or ARM target side generates
> some pattern of TCG ops that's very rare for the ppc target, and is
> buggy in the ppc host side.

Are we actually testing those here?  As far as I can see, we're not installing
any cross-compilers here, so we're not building any non-ppc binaries.  Nor are
we running check-acceptance which would download pre-built foreign binaries.


r~

