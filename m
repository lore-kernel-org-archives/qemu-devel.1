Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8210CC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 18:15:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54C1320738
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 18:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q5MP74EL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54C1320738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAdTI-0002Oo-GU
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 14:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAdSc-0001qp-Uh
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:14:19 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:34283)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAdSZ-0005hc-Qr
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:14:18 -0400
Received: by mail-pg1-x541.google.com with SMTP id i10so7396557pgk.1
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 11:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=PxDrQLK7k7N4OKzB4Gfo/YC5NEnyiMSTznWDpyd82VY=;
 b=q5MP74ELhOayaiT5nKh2mKeey9pV0QscKq668cw48cZ+PiPGZ0mLL85K0BLkE6ZQGY
 q7DjenlZ/tHZuZpH6pYNvGVY2hL2j39As1H9h5j6ku+bjNAvGqvV3jQilM4g4MElSTcw
 ftuq/BMUkn9NxHIbzmU3ygxXuusW2owW+4miG3iWgTN/aOjseyeyhtYHPgRrNTE1CZ/t
 hlVzjzejEMvyi32sQ22DFWGJDdDxlWjSPYoXnXJJsze7bdm98yJERPMD+2tS/6UsGtwK
 WcMH6apnbyv0ypGamzp7LD71uriSht0ujpwSDpaUvNq3YCoasLcYA0aEOAbNimsJPlEI
 NRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PxDrQLK7k7N4OKzB4Gfo/YC5NEnyiMSTznWDpyd82VY=;
 b=sLAnnSPbNJxTZBP8ZGJjK0DKw5eHmZaZLR067Pn5HfPM3blwKE4ufNtEOOA2+s2dlQ
 xw1JOsJ2rGJC0am05vsIg+AcPPLTGGE1LVEXGQsLo0+g7bmMiTMh2OkSwq0bb5jX++Dn
 vKLoaTxlHrt+/bSFOjmnwWWK3giA9st4E7/FCy6XTIz+yRm2ek0uPphm0FHNo4bhivM4
 3d6R3CJbKHyL5R89QA5SvCDNBVm9D9Uj1nc6wnoiyMPy5Fg6VNhnBmO3p1zgUKVDdpZs
 Mfh3o4YHKm0Igmg5YUEs90IF6CntZYittWIOHalA9MwQn/WJCMc1wFZGT+Wwyv9251NC
 HGxA==
X-Gm-Message-State: AOAM531WClUZy3hFZg+daY/Oz4hxZMRdYu3qeSQ9W5hTvgAguG3TSnxe
 RdNNYX7WmrJpDDaNG+KsN2niVmbQJL1HYA==
X-Google-Smtp-Source: ABdhPJxpHgiJFtWscBuENFESG0yRsdQFKwEyaa8wphdrETlMnSANl6s6oFFueuUUwMKPF2h3pDGkqQ==
X-Received: by 2002:a63:593:: with SMTP id 141mr6265680pgf.302.1598379253763; 
 Tue, 25 Aug 2020 11:14:13 -0700 (PDT)
Received: from [192.168.81.79]
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id p20sm2151106pfn.130.2020.08.25.11.14.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2020 11:14:12 -0700 (PDT)
Subject: Re: [PATCH 03/22] target/arm: Implement VFP fp16 for VFP_BINOP
 operations
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200824142934.20850-1-peter.maydell@linaro.org>
 <20200824142934.20850-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6dee2bdb-f585-ffec-e57f-47517e278baa@linaro.org>
Date: Tue, 25 Aug 2020 11:14:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200824142934.20850-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.602,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/24/20 7:29 AM, Peter Maydell wrote:
> +DEF_HELPER_3(vfp_addh, f32, f32, f32, ptr)

We do have an f16 entry in helper-head.h, for documentation purposes.  It
expands to the same uint32_t, so it doesn't make any practical difference.


> +float32 VFP_HELPER(name, h)(float32 a, float32 b, void *fpstp) \

And here it would be better to use uint32_t explicitly, because we're
definitely not returning float32.

I guess you could see if dh_ctype_f16 works here?  But that looks a bit ugly to
me.  Perhaps we should have introduced a better typedef somewhere...

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

