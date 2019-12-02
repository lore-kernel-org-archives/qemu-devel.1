Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0927C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 15:23:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A96B32073C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 15:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kso3PZ6Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A96B32073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibnY1-0003S4-Tf
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 10:23:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45636)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ibnXO-00030v-EV
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 10:22:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ibnXN-00005B-AM
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 10:22:58 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:41693)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ibnXN-0008WN-3Y
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 10:22:57 -0500
Received: by mail-pj1-x1042.google.com with SMTP id ca19so7450295pjb.8
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 07:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ldcnmnooKILtDx94So09EDIGm9UD4WSVWcIJ2KkcoWY=;
 b=kso3PZ6QOqgPPWy19VBduikUfsO0OwOXqex0XEGSzCDHmerQGHcvxHijOjqS2yOaxI
 pKMnFxy/K3jKZG2yKHGttNpcBKphxTik//M5ttZSk+6R0+5gmqY+zP+6JOOXPod+Qwir
 0ribSVkhVY2ZUQIBsfwYYM3TJBnetkubaQjcsYxcLdG9tcPFb2zLWmz1AQKGlUf0lZYb
 D0UU7YVLJoK4neCl3BSQq54pRj0YQ7zFpuAd7H4Se0s1AA24qJVgE+tCF+i8xAFNWJV5
 7xrbKVn73VNJm47Y6jfQ7gMWxn45GwNSbkPtq1uCSPuC8zswKknDufkwIkynLE2oUc6k
 BX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ldcnmnooKILtDx94So09EDIGm9UD4WSVWcIJ2KkcoWY=;
 b=eVJ3zdPwXjEUO66LP6/+AhNsUAl7OSaRq1+zkCK6biJE+PB1ANQznvgUduwDDGNy1I
 5LArymX6+WpEtQLH+HZdUVlgS6s4IeObWBl6W4uyGj8EAbzB1OvTbrCY9lde5kc5yvpF
 /jFq99gxjUkoJ5tzGN5ZPIaT1a/Z2SjaYhFK4TfbgQi6KZQY1leHH46jjt8iWqnkYR1i
 +dAbaL25VhBTCmvb24L/8+cM2Z6x668XIDOtD3rB06IUXIP4akC9tU3w/dsQWsOquVrq
 UtoFwfLrrwlAxMitMgaXXlvNjIf9R/PXk8xaBb2xkaKfvO9+ZVOE/tIi3yIhGrWs4vfQ
 hHjg==
X-Gm-Message-State: APjAAAX96TxRNSPZiiXL5qDSQgscBOtbuRcn2mMHNY4xx6ENFh2tl4rB
 tUS7iEmLVqcxdLWnyBlxbdDPpw==
X-Google-Smtp-Source: APXvYqxnH+PBf5it+wzYONc/94C4UzYEocuz275/VrRDVchl/OTFzUEjp+7NsTjQjuH4Co7JEzmgwg==
X-Received: by 2002:a17:902:bb8c:: with SMTP id
 m12mr5261981pls.320.1575300175851; 
 Mon, 02 Dec 2019 07:22:55 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id e4sm6810026pfj.125.2019.12.02.07.22.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2019 07:22:55 -0800 (PST)
Subject: Re: [PATCH v2 2/5] target/arm: Honor HCR_EL2.TID1 trapping
 requirements
To: Marc Zyngier <maz@kernel.org>, qemu-devel@nongnu.org
References: <20191201122018.25808-1-maz@kernel.org>
 <20191201122018.25808-3-maz@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <091eee4b-dd8f-477d-438e-699dc3c587af@linaro.org>
Date: Mon, 2 Dec 2019 07:22:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191201122018.25808-3-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>, kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/1/19 12:20 PM, Marc Zyngier wrote:
> HCR_EL2.TID1 mandates that access from EL1 to REVIDR_EL1, AIDR_EL1
> (and their 32bit equivalents) as well as TCMTR, TLBTR are trapped
> to EL2. QEMU ignores it, making it harder for a hypervisor to
> virtualize the HW (though to be fair, no known hypervisor actually
> cares).
> 
> Do the right thing by trapping to EL2 if HCR_EL2.TID1 is set.
> 
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  target/arm/helper.c | 36 ++++++++++++++++++++++++++++++++----
>  1 file changed, 32 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


