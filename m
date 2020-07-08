Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0281C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 23:37:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68AF220720
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 23:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rgh45eAc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68AF220720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtJdK-0008SL-OV
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 19:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtJck-0007sG-Hp
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 19:37:10 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:43047)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtJch-0002Lx-O7
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 19:37:10 -0400
Received: by mail-pf1-x443.google.com with SMTP id u18so158665pfk.10
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 16:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WceBtQWSpGLTKnkZN5L7rcXzyOV0jJpQGsWGP7upb1c=;
 b=Rgh45eAczmk8THU3qInwYBRNdnG0PqDKJkOiTlJSesM0w4usRXwVVeTOS9Yfdv12JE
 EJi2h/uXPskS9AFHT4IS8MYdVf2NF38IXC2brDe7WwccbODCVgFHV8KFuwBazSYqq+r6
 lFDtkgeuYjsiDGTeFHvFyXYquK901mddzpIrxak0Six0Ic0QNaXTe42tpMxQlTYq80vk
 12cA+4rSgBK/AJCSVE7eiUhWaF+ja/pNWX3xncqRP34pibgOIfQmxL0/kU2N00oxY+l1
 lQjW1P0sj1pAOSsrHLvuDtSOrTkKIguY2nChXrXO+NPgMDWlcPWHohH8P6tClUJW+lnc
 TEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WceBtQWSpGLTKnkZN5L7rcXzyOV0jJpQGsWGP7upb1c=;
 b=BBOssrjGPv9wPkf885CLWFrCdxz/Mgj8HmjmZK8ZqHypm8DU76p4iRzjgUuUGWtO5M
 JEh//fMn2Lx4qkubWKqjef/0jY7r0MwzZXdSwCSVxmCLvcDsVmnmCuplHhSmTCgm2M34
 0Gng8zi4kCq/6RqocXtzY1L4vOLrg6B4BQWIVSwJtA4vn069v1mjir4wLVdBtJny6gFq
 HF9ojitX7sOk3j0Vbcg0kol8SsZnY67o1s7+nb1VRGTIMrwHA9+cEaP00X1X+A20R0lL
 GjNFDz7x+vMbkM7VMu1q4JpbGSpeEY4AjyZ6SeGegStRK0eUPpWrWrvscAo9MU1AXSsS
 iztQ==
X-Gm-Message-State: AOAM532fVRbJOajC0R9VoAAe9qYN0jQjhGkv5XE5DDx0tv7Q8K/ySNFO
 1rkx29tJb4Mkz7o/qVIN4HGU9Q==
X-Google-Smtp-Source: ABdhPJwHp88cJ9XaoE4Llw0mtcO963vJKkEoWx+d+iB891VGl+tIlFvQ3s0/UWl+nbBVnvF2ZLLgSg==
X-Received: by 2002:a63:371c:: with SMTP id e28mr50934365pga.114.1594251426167; 
 Wed, 08 Jul 2020 16:37:06 -0700 (PDT)
Received: from [192.168.7.121] (24-113-145-216.wavecable.com. [24.113.145.216])
 by smtp.gmail.com with ESMTPSA id gx23sm532481pjb.39.2020.07.08.16.37.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2020 16:37:05 -0700 (PDT)
Subject: Re: [PATCH 0/7] misc: Reduce QEMUTimer pressure by using lower
 precision when possible
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200616075121.12837-1-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fd72928d-04ce-6562-39cd-6f3902b49ee6@linaro.org>
Date: Wed, 8 Jul 2020 16:37:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200616075121.12837-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Corey Minyard <minyard@acm.org>,
 David Hildenbrand <david@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/16/20 12:51 AM, Philippe Mathieu-Daudé wrote:
> This series contains few patches resulting from the notes I
> took while reviewing Mark ADB series last Sunday, in particular:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg712078.html
> 
> I have another patch for hw/input/hid.c but I prefer to hold it
> to test it more.

How does this reduce pressure?  The resolution of the timer doesn't seem to be
affected by these patches, only the precision of the inputs.

It seems like standardizing on nanoseconds makes some things easier, and allows
the resolution of the implementation to vary to a much larger degree.


r~

