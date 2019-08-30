Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543A5C3A59F
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 01:23:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AC7020828
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 01:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XTvBHoyg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AC7020828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3Vdd-0008UY-6S
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 21:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33098)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i3VbR-0007w4-Np
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 21:21:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i3VbN-0007Q8-4G
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 21:21:22 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:40413)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i3VbM-0007Kv-R6
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 21:21:21 -0400
Received: by mail-pf1-x442.google.com with SMTP id w16so3390692pfn.7
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 18:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=FVWuW2MnNVHQR5OGIIC5mr8clQWfjfFdWjqJZ4zDacY=;
 b=XTvBHoygdgU+EwTIWk8p4ZvZogsVlKnkP4M7g2Lq7Je1cNpRXvss0ugyeNMqbXaWYM
 WEFdAlElI8eBO6yTqMhR9XnLBWKrbH7moOV2E1kzMWbGlPdXEAyb22DH9WdcuNa454Zp
 1H1/6YvHO3Vq803cIOrDsuWTiNJRBW5Fe9zwINTyfY+OYsDJWrZx6aurD5sbAfytt09W
 tMmwwQxNSzcpf496YdaKGJdxBDbcSihGsHHAtAxERM7CkWagkNHY1ctvP4EvW1tkhcFJ
 uAUtFB/DlYe2rsIqKna3qry0FIBI8byroWVWp1qDXq3OfyCvjNd2F2jVxkTTmxtuu8J+
 KXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FVWuW2MnNVHQR5OGIIC5mr8clQWfjfFdWjqJZ4zDacY=;
 b=i6ais4DNBehVi9gKk/omndujciih4a5tJ8OZmcU8mvW9Cjb87a03v0x+j95kfDrM9G
 g5xS1cJH+BPfKyWaB9TDoZ+oDerH/cP6pEcVdGWGFQLxFPMRpSItWzNx3DxjCyZSe89c
 PyzzxLGlPVs27XbXllAFmivtlFaoh/J0zwHVVHkZki7fY354rwvIV1+y4Bu0Xx9jOqlH
 xqHz0ycR9CzJFjGNU4RuN1h8dtXtttnofzn8LUhMY4ijvuk2dQSMXpvx6iItkDGti/9B
 DCwXCkimktHDbeVHt645Lb38uojOXO3MXdMmIBa5CAfqeNDS6IhXwRTGFox9NDWvexDZ
 A+6w==
X-Gm-Message-State: APjAAAVR6JPVqywk151s8nUpjBY0zT5nTaLW818zTkakMqObv1YjGrXC
 GwIus5L/FLbhVNAs8x+X6v3PfDsoRWs=
X-Google-Smtp-Source: APXvYqwzWWMscInqEjQIPK1XuTvM+XHFNKmE41GQSUOpEtuFqMa30FnhL+odJaiUA33whDGHeiv+9w==
X-Received: by 2002:a17:90a:8083:: with SMTP id
 c3mr12891294pjn.50.1567128079063; 
 Thu, 29 Aug 2019 18:21:19 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id c5sm4440778pfo.175.2019.08.29.18.21.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Aug 2019 18:21:17 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20190828231651.17176-1-richard.henderson@linaro.org>
 <20190828231651.17176-3-richard.henderson@linaro.org>
 <a7cf962f-eeb3-3628-4f33-c02292d4f07a@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <50debd18-518a-ab16-2084-8848bd5f39e7@linaro.org>
Date: Thu, 29 Aug 2019 18:21:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a7cf962f-eeb3-3628-4f33-c02292d4f07a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v2 2/8] exec: Factor out core logic of
 check_watchpoint()
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
Cc: david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/29/19 10:26 AM, Philippe Mathieu-Daudé wrote:
>> -            wp->hitaddr = vaddr;
>> +            wp->hitaddr = MAX(addr, wp->vaddr);
> 
> When is addr > wp->vaddr?

Both the watchpoint and the access are arbitrary ranges.

  wp:    [ 1000               - 1008 ]
  store:     [ 1002 - 1004 ]

  wp:               [ 1004    - 1008 ]
  store: [ 1000               - 1008 ]

The old code would, for the first case, return 1002 and not the 1000 of the
watch point, which seems reasonable.  For the second case, we would set 1000,
an address outside of the watchpoint.

David's change makes sure that the address signaled is inside the watchpoint.
I.e. leaving the first case unchanged and making the second  set 1004.

It seems very reasonable to me.


r~

