Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DBFC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 16:23:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF208206B8
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 16:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OvbV2zVB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF208206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG2sX-0003RI-3N
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 12:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kG2nd-0005i5-H4
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 12:18:21 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:41028)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kG2na-0006z2-Dz
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 12:18:21 -0400
Received: by mail-pg1-x542.google.com with SMTP id w186so2415267pgb.8
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 09:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=99UZ288H5ij2iEAl6q76lCUPqn1VoDCLJI1C3EIgH/g=;
 b=OvbV2zVBsqF8cQWEGp2fl+MU1DvQuZ6EiRE+ExORl9/282fShzgwkO4ZV03wm1LY2w
 ijAIjsSXgoI2n0DzoLp9+4Xya5OpR2YfomW6BONbraubfCL3/ktcHf0HDmvx4V4CLxmo
 S06GqzR7147l8ok9IrCy3YKklO4ai9nGrBS0oAFKqBeiddkM21Fmi70C9gTtF+OfDTdS
 MTs+0GLvPKH3bdbBDnGs01duUO9mKVzPBA5wTZEGmQJo/kz7b0jzQPbic1/Hc/dmjsRO
 QGR/X5vokK8QRbB0+mOVW0ExELn1JTawHRVyrkNqH08AGlk1iFs4B5wAS5dASXO73XEL
 0a8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=99UZ288H5ij2iEAl6q76lCUPqn1VoDCLJI1C3EIgH/g=;
 b=FJC3pu17mKGFJCPnYKF7bYGYwWZv9M0rv3SdInDz7Mr8CXMd3dtAUnonAykTIqHuPA
 l/e4A17z9t6B85kw+e+xvFFMHsfWhnHjXX6ZoxfyzdBUHQQioEaAL3hgS/Um7A5c5g70
 S31hfHG7Pq7XITvgHRy8Kb33oQrQgiL1/ExX5+6D9Otj6gAJA4k2wAC/QxFFzaUV31oD
 sJsN3hFCzVd5Q8IBIQ760G+8Q1LSQT372GFqCc7fuPabosVTN6Q+/a8d+JlHnspJMuMw
 OLYJLSWciMjAL31Y4e2DA0u/r/MxLI2wXIzuQCxnPlyHqmNeYR9Z8KuomkJZoLXBuI6B
 dlgA==
X-Gm-Message-State: AOAM533QSeF/T2Wv3t3kwUzctR+V3FBEfq0Np9Y0w7K4vk744TqwPc6S
 /s9v0vqHDeLxHAXSFVZ9fk7Kfg==
X-Google-Smtp-Source: ABdhPJw7zmLYBci0+yhisFi2NSLwYjdshwai+ECZRO/NumecFg/c6zL7hLPbdz/4QCLsFf0LjyreQQ==
X-Received: by 2002:a63:4559:: with SMTP id u25mr1131732pgk.162.1599668296857; 
 Wed, 09 Sep 2020 09:18:16 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id a1sm3199142pfr.12.2020.09.09.09.18.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2020 09:18:15 -0700 (PDT)
Subject: Re: [PATCH v5 2/2] hw: hyperv: vmbus: Fix 32bit compilation
To: Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Jon Doron <arilou@gmail.com>, qemu-devel@nongnu.org
References: <20200715084326.678715-1-arilou@gmail.com>
 <20200715084326.678715-3-arilou@gmail.com>
 <87028ae2-f31e-a6ee-a4ba-c147837fc52d@amsat.org>
 <fb8f1744-4c28-4171-2ffb-61d3ad39be88@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <05bf1564-636a-5022-357b-73725a754e59@linaro.org>
Date: Wed, 9 Sep 2020 09:18:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <fb8f1744-4c28-4171-2ffb-61d3ad39be88@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.576,
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
Cc: mail@maciej.szmigiero.name, QEMU Trivial <qemu-trivial@nongnu.org>,
 rvkagan@yandex-team.ru, pbonzini@redhat.com, imammedo@redhat.com,
 vkuznets@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/9/20 6:56 AM, Laurent Vivier wrote:
> Le 06/09/2020 à 12:14, Philippe Mathieu-Daudé a écrit :
>> Cc'ing qemu-trivial@
>>
>> Can we add the commit description Richard wrote?
> 
> I have no message from Richard regarding this patch.

https://lists.nongnu.org/archive/html/qemu-devel/2020-09/msg02283.html

Different thread, same problem.


r~

