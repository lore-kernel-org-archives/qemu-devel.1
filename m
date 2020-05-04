Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612CEC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 18:31:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 299BB20658
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 18:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XwHIGzx9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 299BB20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVfsQ-00064W-C7
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 14:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jVfpg-0003Ws-55
 for qemu-devel@nongnu.org; Mon, 04 May 2020 14:28:48 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:35329)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jVfpe-00059e-UJ
 for qemu-devel@nongnu.org; Mon, 04 May 2020 14:28:47 -0400
Received: by mail-pl1-x644.google.com with SMTP id f8so92593plt.2
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 11:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=FDFaqNjDiTGcZFNI3Tzq7LAj6PmovCGuhIGIkfAy8e8=;
 b=XwHIGzx92vAz9/vIaMaTbAIDkjPXDEHK74e8ssshcmRd1Pn+FIqFxGtgnaZ0sx7dNJ
 PiTXrjKCwvwYGTMF8DqWma1mjoGBsoCWxlw3kx91CazGzR/gipzIAPi+bZTRg+ofNFU2
 vYxLlvRpqLsCuNRtA7Hl1z7FTI6iU7AJaY2jELO89Grg1/kewMKUuJz103m40n+EqyUj
 MA/KEB9O9Q+fiK73lB2WVkestTtWWh96iXjyw6DENz5EMk/L7/arO4C/FcJwOIMpFXEd
 rbhf92aqp+Ue+z2WAiNSUXyfYgfu9oeAJ4InQZvueBdTkvIHsydyBkHI+7cxVXdbROh2
 CCDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FDFaqNjDiTGcZFNI3Tzq7LAj6PmovCGuhIGIkfAy8e8=;
 b=PQsaT+NPeErBpacxDHijU4JmHyLJzLRvOgxvd7t0I03Why2p6oDYpBloHHGUNBK1e+
 qYU/Et3hlHseSTClKs+99fSvPNFZWAIGzZxxMpY1E59XeYsF7FhXDYj0IsSQSUlzxqI5
 yt1psUVvePbGhccfzbTEwP4z+SB3NBoU7OaD2h1ADkJG01ag/EPkDJV1tX8FY6qchm51
 xI9EnNKHzP18d6Qdr79NvbSdeJaMULyp6EHD2R4SL8wtxdA5FoPLds89L9ol6/RJgMIq
 W5hsNJykDvntBWRhPQQhqRHOFU3gzczUVXPTUtovnbxiYX+RKL420vSwrY9BN5CQYhNY
 O0lA==
X-Gm-Message-State: AGi0Pub0Hryrb8dcdy6f/RKbiPzuinzPlRRwNsQlmr9oUVW3f7+96E6A
 wWQiRPyS5vqhXpd8hGCvaJo2QA==
X-Google-Smtp-Source: APiQypLVAahIPHOsrmAFv0w+TnMzWe2gAtaQ+13ljP5lOQRr2ssTNfRMIpS57kppM7wK+enYSHX6gA==
X-Received: by 2002:a17:90a:3ea7:: with SMTP id
 k36mr303844pjc.125.1588616925060; 
 Mon, 04 May 2020 11:28:45 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id b20sm9691272pff.8.2020.05.04.11.28.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2020 11:28:43 -0700 (PDT)
Subject: Re: [PATCH v3 4/5] target/arm/cpu: Restrict v8M IDAU interface to
 Aarch32 CPUs
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200504172448.9402-1-philmd@redhat.com>
 <20200504172448.9402-5-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8fe2ecfd-5c9a-5f52-c312-92592edf3dcf@linaro.org>
Date: Mon, 4 May 2020 11:28:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504172448.9402-5-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/4/20 10:24 AM, Philippe Mathieu-Daudé wrote:
> As IDAU is a v8M feature, restrict it to the Aarch32 CPUs.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  target/arm/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> @@ -2898,6 +2897,7 @@ static void arm_cpu_register_types(void)
>      if (cpu_count) {
>          size_t i;
>  
> +        type_register_static(&idau_interface_type_info);
>          for (i = 0; i < cpu_count; ++i) {
>              arm_cpu_register(&arm_cpus[i]);
>          }

Oh, I see.  I guess you can disregard the suggestion vs the previous patch.


r~

