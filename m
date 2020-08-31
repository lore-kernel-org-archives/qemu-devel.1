Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787F8C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:38:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A6522083E
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YLqmHzLp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A6522083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCrVq-0007mk-B4
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 17:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCrDa-0004L0-AK
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:19:58 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:40905)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCrDY-0001YI-FQ
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:19:57 -0400
Received: by mail-pj1-x1043.google.com with SMTP id kx11so547058pjb.5
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 14:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1BwTVD6X4hEAzrEYONfujXAn5wRXQaDQdFnvOyy2+C0=;
 b=YLqmHzLpEepN+bV6V8MuiH8rKdrlDTIdXqqRpgjtj3l1UzS2JOUfWTl583gR1CvGfD
 KOX7MVqgeQLF2O13121XkvFkTRvW7oB8gCX19xnCl+MPDhHOR91OlPnIDSlF+XpSOOlM
 qIbjLOhL8Fft6yqCsCsBXC9lWcXfEPgLRbPBd2j9sv4+kGb4ywMqA9OXplwlskIErlZJ
 zw7w/Pla6JDYbxkK6FBV2dyaCGBUAEQhKoy0MaXyPnkzcVDQrRuWSrPNnvS+Fu6opJds
 KE7MlFVoUhnM4am2/OCN06OTu5r0cmAAxOogbU4bCUTpnGRtB4NcDB56B/Ns/bg/jW6e
 VohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1BwTVD6X4hEAzrEYONfujXAn5wRXQaDQdFnvOyy2+C0=;
 b=pZ5xtzTcx3Fimsmcznh3ALMWXDYzKtmWc2hr4J/7hSB8yZTssiOI3jBE2xnFsB0Iyh
 Tny50TSzbl7NjXqkrGv0btFHBMA0j4bGL7VpbZYY0fHH4cRgaSTtohXyzOzMMo1b/ar2
 r2qn/UaLGXDa899act3Odz6xX3dO8zPp0OKOy8FFeTQoGDi2QtK6mV911QBokTHTRnTW
 +Lu6fRsxqp5i2GIBF10nRQqRzWwqs8mYYDzMIgOhcqCHj9L0cHM44oISd7RZjBRg348t
 EOtHjiDbC7VBEBR4keh2XTD4I1qt6fNdmBFmzaPy12R/XCCm3qIc77VK1PtP45phWl92
 LIqg==
X-Gm-Message-State: AOAM531g/crcp0vzGL8TUKzgNj5vxHTfGkg2/SVoBVdJtytNPdCGB0aY
 lLVS3gKx9vJlkj51O5fxTtaZxw==
X-Google-Smtp-Source: ABdhPJwaZLXkvH7WkUffFCfBkAaaPb3u5ouadWEORzAajOlTxkbfGjedq5he9OlY3NyzILM/Osf4Mg==
X-Received: by 2002:a17:902:c24b:: with SMTP id
 11mr2489937plg.64.1598908794963; 
 Mon, 31 Aug 2020 14:19:54 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j19sm4475978pfi.51.2020.08.31.14.19.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2020 14:19:54 -0700 (PDT)
Subject: Re: [PATCH v2 3/7] target/cris: add CRISCPUClass->do_interrupt_locked
To: Robert Foley <robert.foley@linaro.org>, qemu-devel@nongnu.org
References: <20200819182856.4893-1-robert.foley@linaro.org>
 <20200819182856.4893-4-robert.foley@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4259ab85-888d-83b4-ea48-d1a93a3f8951@linaro.org>
Date: Mon, 31 Aug 2020 14:19:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200819182856.4893-4-robert.foley@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.13,
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, peter.puhov@linaro.org,
 alex.bennee@linaro.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/19/20 11:28 AM, Robert Foley wrote:
> Adding ->do_interrupt_locked to CRISCPUClass is preparation for
> pushing the BQL down into the per-arch implementation of ->do_interrupt.
> 
> This is needed since Cris's *_cpu_exec_interrupt calls to *_do_interrupt.
> With the push down of the BQL into *_cpu_exec_interrupt and
> *_do_interrupt, *_cpu_exec_interrupt will call to ->do_interrupt
> with lock held.  Since ->do_interrupt also has the lock, we need a way
> to allow cpu_exec_interrupt to call do_interrupt with lock held.
> This patch solves the issue of *_cpu_exec_interrupt needing
> to call do_interrupt with lock held.
> 
> This patch is part of a series of transitions to move the
> BQL down into the do_interrupt per arch functions.  This set of
> transitions is needed to maintain bisectability.
> 
> This approach was suggested by Paolo Bonzini.
> For reference, here are two key posts in the discussion, explaining
> the reasoning/benefits of this approach.
> https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg00784.html
> https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg01517.html
> https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg08731.html
> https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg00044.html
> 
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> ---
>  target/cris/cpu-qom.h | 3 +++
>  target/cris/cpu.c     | 6 ++++++
>  target/cris/helper.c  | 6 +++---
>  3 files changed, 12 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

