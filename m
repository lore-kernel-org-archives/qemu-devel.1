Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD39EC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 20:39:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 926C0206C0
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 20:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DhIZJC0U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 926C0206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6gUP-00071D-T7
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 16:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6gTq-0006Wq-0O
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 16:39:14 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:43597)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6gTo-0004GY-Am
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 16:39:13 -0400
Received: by mail-pf1-x443.google.com with SMTP id y206so5096907pfb.10
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 13:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5AObkuhBoLSOwJqxwMC6AbWIw5XxFA7OUt/BitLFIDY=;
 b=DhIZJC0UudeUd6/Wj2WjAq9boTzSB2aD4UQdizRSsb2SU9unPkOrgcY3L5Bgt433Rr
 hOPEJe0bqhQr8KFx9s2i+dt//mV9nOHrEzFca61B8mK+hZ71eYjcnQN9V1Skbpizcc+7
 t5Al0ERNwtuGp9Xf92GXh3KA5mO6He/JcWcUYbXCFNtWNz51KxuHwjlAc6QGOBluP65x
 uiAGowiEShvQ11/nWA6ESMSnm34wJ1cZBlIh3uu+mWSAQvNhoKG9B978zB6DLzhvAH3b
 1tMriGMD7BMNVlrvZ5TCUWxs00IhUEVs6aYCguh0xrl1Mx1NE9bwkYMH9g5IN1SvOP/F
 Pf7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5AObkuhBoLSOwJqxwMC6AbWIw5XxFA7OUt/BitLFIDY=;
 b=YaDZUA1U4BsmfmaTCk7bCby5Thx1la1OJhQvpeEqJV/KVMxUGU6MGW+rbxLrbiHyL3
 C+fimN3u7ZKrHCR5r4GDlMyh7qA5k1nORArLIzl947QQta7M8nzYUreL5w8qu2tjWS6Z
 nAL+ucwWzj5Uc+Xl2MNtsZzI3GLXoIzasMpiCI2RKL8WKC9SjublWmse9g4jCSJv8+LW
 7o828lvoiRCM56A1Ek72/6yqQ+SD3+HWYRsLy/O9Qmp+qDmAzWq//ZmMSepsVin18bCq
 1ypXyrrAFEu6lRngHC5h26P6g9Wi6aPdUUml6oAGdOFJFUA7V6k7nUmYtRkj9aI6Kn+4
 YFJg==
X-Gm-Message-State: AOAM531VERkKP//uofY8llhR8FJ97117V87oKiPB97zDZTWu+4kU1+B2
 LHpdkcG+3s6VGlWhAmUa/ITuuw==
X-Google-Smtp-Source: ABdhPJzu3+gVCyXtNfDyvTIq6KhAD/OPAA/R17qzxRxMdEOUQUS2Ds7G1WPJXjaizpEU5mFe+qX4kA==
X-Received: by 2002:a63:304:: with SMTP id 4mr2682154pgd.296.1597437550785;
 Fri, 14 Aug 2020 13:39:10 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 30sm9119942pjz.24.2020.08.14.13.39.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 13:39:09 -0700 (PDT)
Subject: Re: [PATCH v5 03/14] cpus: extract out TCG-specific code to accel/tcg
To: Claudio Fontana <cfontana@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>
References: <20200812183250.9221-1-cfontana@suse.de>
 <20200812183250.9221-4-cfontana@suse.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6d14d386-231a-f3b5-8802-167c8979aa03@linaro.org>
Date: Fri, 14 Aug 2020 13:39:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200812183250.9221-4-cfontana@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Wenchao Wang <wenchao.wang@intel.com>,
 haxm-team@intel.com, Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <rth@twiddle.net>, Colin Xu <colin.xu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/12/20 11:32 AM, Claudio Fontana wrote:
> +static int64_t tcg_get_virtual_clock(void)
> +{
> +    if (icount_enabled()) {
> +        return icount_get();
> +    }
> +    return cpu_get_clock();
> +}
> +
> +static int64_t tcg_get_elapsed_ticks(void)
> +{
> +    if (icount_enabled()) {
> +        return icount_get();
> +    }
> +    return cpu_get_ticks();
> +}
> +
> +CpusAccel tcg_cpus = {
> +    .create_vcpu_thread = tcg_start_vcpu_thread,
> +    .kick_vcpu_thread = tcg_kick_vcpu_thread,
> +    .get_virtual_clock = tcg_get_virtual_clock,
> +    .get_elapsed_ticks = tcg_get_elapsed_ticks,
> +};

I think this variable should be const.  Which of course means that the previous
patch needs to add const annotations.

I think you should actually have multiple dispatch variables: with icount and
without, with mttcg and without.  That way these methods don't have to check
icount_enabled() or qemu_tcg_mttcg_enabled() at runtime, only at startup.


r~

