Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144CCC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:16:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D564E21582
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Im6DJy+j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D564E21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr2pW-0001Ol-2n
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 13:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jr2oP-0007tr-Uy
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 13:15:49 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:41531)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jr2oO-0002Rz-8L
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 13:15:49 -0400
Received: by mail-pg1-x543.google.com with SMTP id g67so12876029pgc.8
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 10:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6vG7jpWndOAy1UZCZIPUDV2h1TOyEUA78r/89wM+Nis=;
 b=Im6DJy+j8H3c5TVp0z/clSnRtH3+0Ihzf/nMLRZ8ZGxMQMfNYJGF4sdlsBVqDXI3e3
 a+1/+nOG5qX+f5re8F2ajCj+oUlseULUxmrE3zleD/l1cLqbirvdKNttK18kPeZI59Tq
 KcVps8cpxMtIcbpGnDKc7tLABydyFgqnUlUAwKVyrErM7teVDdT0prOJBTKAraQtIdt1
 1gFtFQleD3QDY7b/i6+qH0aaZ1KneFkrKkKW4iGK/1wQrN6sRu5e1v4qQcDo2bpS7jEO
 3PqLyZ9T6qa0J8N/0OyBEA/iUzFYdLyvqGVqp9L+ApgB0tfkDgboh0qRc8RGpf5Yls93
 Gf0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6vG7jpWndOAy1UZCZIPUDV2h1TOyEUA78r/89wM+Nis=;
 b=n9w7HNXa/k+0elx2QYQ+urZQ8mQ1mfcYD3Rpk5S9eZ/EbZnGwPETPCzG1ZBL0KLlz0
 9uh9POMxwuHW/gc3F+wegsHoIj2piplqazIifLSdl7klvbEVn/8/f1T5SLMGRpuh9dZk
 nWRxblFIUJC2K6IapuW9DItsjoJhZfj6m51RiGAlwKKi7GkVJNIEqjqRGRTO+JSKv225
 3HTnRgW26kwzhpwiBhxMemVOiba3hMpUZj6DULBhwM2huPT2ylyRZzFH3w7x/KGGgwoC
 og6zVmr93DP6GuG9W5ufezTeFpj3JuQaUwD+yCtpOrc7tTz18L+bh1QjPFAsDQ81lDUG
 arjA==
X-Gm-Message-State: AOAM531+x62NADKmRKimv8rm5i/4CPiicViq0MiPhwJh7yb6ywM6v/Hg
 AQV+sg0IJ4qM0yOSxK2iH5QImA==
X-Google-Smtp-Source: ABdhPJxQ2niQ6E4JbnO2vRFZOWUrN2fnibu8Bl4rVUWR4Z2A/3EdjQbHuVeJ7WMuSAyjl3nfZP2fng==
X-Received: by 2002:a63:ce41:: with SMTP id r1mr1712942pgi.203.1593710146855; 
 Thu, 02 Jul 2020 10:15:46 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id 186sm3047176pfe.1.2020.07.02.10.15.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2020 10:15:46 -0700 (PDT)
Subject: Re: [PATCH 2/6] target/riscv: NaN-boxing compute, sign-injection and
 convert instructions.
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <20200626205917.4545-1-zhiwei_liu@c-sky.com>
 <20200626205917.4545-3-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <704bff99-8ece-ae9b-cf28-8fdddf17e0d5@linaro.org>
Date: Thu, 2 Jul 2020 10:15:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200626205917.4545-3-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: palmer@dabbelt.com, wenmeng_zhang@c-sky.com, Alistair.Francis@wdc.com,
 ianjiang.ict@gmail.com, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/26/20 1:59 PM, LIU Zhiwei wrote:
> An n-bit foating-point result is written to the n least-significant bits
> of the destination f register, with all 1s written to the uppermost
> FLEN - n bits to yield a legal NaN-boxed value
> 
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> ---
>  target/riscv/insn_trans/trans_rvd.inc.c |  1 +
>  target/riscv/insn_trans/trans_rvf.inc.c | 19 +++++++++++++++++++
>  2 files changed, 20 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


