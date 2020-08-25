Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2145EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 18:19:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E650E2076C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 18:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xJdZPUQI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E650E2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAdXD-00050A-4j
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 14:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAdWU-0004QV-MZ
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:18:18 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:51164)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAdWP-0006GL-P6
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:18:18 -0400
Received: by mail-pj1-x1042.google.com with SMTP id i13so1679374pjv.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 11:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=fuTc2zBh9rwXdECeGPaGAqn4nm98x6JdAAQA/2oE9MA=;
 b=xJdZPUQIrunrKfVhmctP1vt4YqIav7O0Wf+KFPPO1AEewdM/pEPJ5HOeC6tFMDoonc
 RQsKYfRxiBRqrv7yw2h8FJlfzYau2t6Y0vM39XWSH+yztOcnvhWp1JzY+34Yu0cy+Gz/
 sBALu82s2CSsweZ+FPtYj/yI4B23Rp7oio49wSbbCw8+RYHeginkS50vTRJRCtowZUtP
 gUujAAu6eZV8wTgShjqyVzOjq+bE9A6HQerkDPql53xxc/T2Yye8mqoK9lodTT//ACBW
 5lihIdaHNBWuLDs6lsmOxLWKRLRwP2jf1BMdpzdpjeJjJJWfA/WxeXmcMEUySfCDvfMo
 IC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fuTc2zBh9rwXdECeGPaGAqn4nm98x6JdAAQA/2oE9MA=;
 b=Ebb8pUPLFVswITGgr0KPQanYSJuydXRO8wU21PIJtPt7HXqLIMBLZyhvkD0ics/e85
 JTM3hONlygy5x3W3I3J9S08tjkeFas5JpO8GNbspqYAnv3qecALdhhdCFASf4LT/16Jq
 Y+vuR2noU90R/kihhO0AkDVCCBVppSM/mVGKvbiBcPpN3XRowXA8QcnssZ1F0aWrKq8L
 iw+NhAcNBFYT8boBGGx0xQA4EKCpoDueHFwq3zUY/DnMonZsZuB+NhXdSMEy9mUPtQZB
 VnxyGVdJnjKXWLINvTQhcNv0+ahMEcwczAy+WqEl22jFa4p1opSO7bAeWzXfvb9+QkVU
 HpKA==
X-Gm-Message-State: AOAM53047A3sefDhmGTduxiJPjxcnBC7aIvGoxhq3bfIaYdHwsTcK0FL
 Q6Iau6T8wSwZ4DKesF5XUW8w9XHWFwfBxQ==
X-Google-Smtp-Source: ABdhPJwaGEyjjn/+ojnXmDj7ctZ80C0SNR5P/gYSHNxLQ/N56vHCHijnDud1rtUWMLmNHCIpW3c5vw==
X-Received: by 2002:a17:90a:a61:: with SMTP id
 o88mr2638707pjo.201.1598379492045; 
 Tue, 25 Aug 2020 11:18:12 -0700 (PDT)
Received: from [192.168.81.79]
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id s129sm9817343pfb.39.2020.08.25.11.18.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2020 11:18:11 -0700 (PDT)
Subject: Re: [PATCH 04/22] target/arm: Implement VFP fp16 VMLA, VMLS, VNMLS,
 VNMLA, VNMUL
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200824142934.20850-1-peter.maydell@linaro.org>
 <20200824142934.20850-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5e45bef6-ff33-7d65-5af1-fce55cad7e80@linaro.org>
Date: Tue, 25 Aug 2020 11:18:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200824142934.20850-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.602,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/24/20 7:29 AM, Peter Maydell wrote:
> Implement fp16 versions of the VFP VMLA, VMLS, VNMLS, VNMLA, VNMUL
> instructions. (These are all the remaining ones which we implement
> via do_vfp_3op_[hsd]p().)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.h            |  1 +
>  target/arm/vfp.decode          |  5 ++
>  target/arm/vfp_helper.c        |  5 ++
>  target/arm/translate-vfp.c.inc | 84 ++++++++++++++++++++++++++++++++++
>  4 files changed, 95 insertions(+)

Same comments re the helper types.  Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


PS: At some point we really ought to inline all of the fp neg/abs helpers.



