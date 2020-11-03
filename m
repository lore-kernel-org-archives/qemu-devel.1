Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4111FC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 16:39:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BD652072C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 16:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B79xc1Qq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BD652072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZzLE-0004Cf-KK
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 11:39:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kZzKK-0003Vf-SJ
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 11:38:32 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:39656)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kZzKJ-0007yh-7x
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 11:38:32 -0500
Received: by mail-pf1-x444.google.com with SMTP id z3so8308512pfz.6
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 08:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=FQfyNYKw3s3KbpdNAbop7Y3DNBRmNlEUc42AuKxdeE8=;
 b=B79xc1Qq7dIJ8WGWxxcAir6QZ2k/3vMslMfrrHftK/qR7tPxwwhCi8KqXjDIy2IV8u
 gMP4SU82W6m/qHMXDw1ux6iYzLkkBBF0pv7L9C+CtPpwvjrrN1ce5t+k7jSfHfshSKDL
 qpuT1vMqEEV/LB3a9PphmivATnpHya0iGjekuiaZ5q02dg7PvY3SQow+qNxRTitITqIV
 4X4rq6072Z8r9SaBfJbYNG4Vc7ciDS9hNcUOC2fAQQmeAtjLFT08y+9gKreKPbAC3WR6
 PGGhXgf9RJaPMsNRyeY2GsJ6Bq2FaKQ7R56e4y9rvT/CFGeH+QC5B6XDduSgSWyT4bWx
 Jg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FQfyNYKw3s3KbpdNAbop7Y3DNBRmNlEUc42AuKxdeE8=;
 b=MWcp+XhOAJ+0gPKM9eqTh4uj7fHWRCm/oYfzlL9URFtwwyx58lMuZEk2xGvrnX9wiN
 +oRNGN9A+tNoejjwgagYer/l/mUtJ835JNTv19G+PfBFLoJAvyFKVVySkzV7f7ptpkic
 dgzIXDGTzbebxKyXmmNK9spGkreRv6M44lWnRHSgmEf22RWQPS87f8eO3Q3i9KvqTzaR
 5HEe6+NOGhNKEo9YiI5CVIDkaTTAmda2tY3t5JUBfeNIl7zmLlWu7nDiogCAFH+vhSn9
 WxC7Jh5BWosWgD3W6ZRZhS/FKkdBYtTKYTatGb86GZuYY3G0eMcIQqppQKlIQiRJQmBF
 G0IQ==
X-Gm-Message-State: AOAM530QPmr8mSu6Gew+SpvT4TrMhjZUDiXdYCLZvNvCr/eji/c3qITu
 QbmvTIusOPmt0JN8xOHdA+sOP3szHTsubw==
X-Google-Smtp-Source: ABdhPJzN101k/v1x0z77zpl2Il1nHSre/LqPxss3mCEkWc6NmsvAeTHCczsXqg1BfowFyeXdh49UAA==
X-Received: by 2002:a63:d946:: with SMTP id e6mr18093228pgj.113.1604421508903; 
 Tue, 03 Nov 2020 08:38:28 -0800 (PST)
Received: from [172.16.1.221] (76-14-210-194.or.wavecable.com. [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id ca5sm4178124pjb.27.2020.11.03.08.38.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 08:38:27 -0800 (PST)
Subject: Re: [PATCH 14/14] target/arm: enable Secure EL2 in max CPU
To: =?UTF-8?Q?R=c3=a9mi_Denis-Courmont?= <remi@remlab.net>, qemu-arm@nongnu.org
References: <2172054.ElGaqSPkdT@basile.remlab.net>
 <20201102105802.39332-14-remi.denis.courmont@huawei.com>
 <4572030.GXAFRqVoOG@basile.remlab.net>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6f32973b-ec84-51c7-0809-95e931ee432a@linaro.org>
Date: Tue, 3 Nov 2020 08:38:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4572030.GXAFRqVoOG@basile.remlab.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/2/20 11:38 PM, Rémi Denis-Courmont wrote:
> Answering my own patch as I have a policy question here...
> 
> This exposes SEL2 without TTST (small translation tables). On a logical level, 
> the two extensions are orthogonal. But per DDI0487, SEL2 implies TTST, so I am 
> not sure if this is considered an acceptable deviation in QEMU, or if 
> implementing TTST is deemed necessary.

We should implement TTST, yes.  I don't think we need to be 100% strict on the
ordering, so long as they are both done for the next qemu release in the
spring.  I don't think it should be difficult.

FWIW, we left aarch32 fp16 unimplemented for quite some time, even though that
was required for full compliance with aarch64 fp16.

> Note that there's what seems like an editorial error in the spec: VSTCR 
> documentation covers the scenario that TTST is not supported by the CPU, even 
> though then VSTCR should not exist.

Indeed.  ;-)


r~


