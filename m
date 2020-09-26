Return-Path: <SRS0=cZnO=DD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D809EC2D0A8
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 20:37:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FEE020715
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 20:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUianNtc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FEE020715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMGwU-0000ik-Iq
	for qemu-devel@archiver.kernel.org; Sat, 26 Sep 2020 16:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMGvT-0008QW-29; Sat, 26 Sep 2020 16:36:11 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34148)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMGvR-0002Km-7n; Sat, 26 Sep 2020 16:36:10 -0400
Received: by mail-wr1-x444.google.com with SMTP id t10so7618524wrv.1;
 Sat, 26 Sep 2020 13:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=IoycA8sCG/5JeMozMHv0Dmc2yGmLtB9gyHgSajmfEp0=;
 b=GUianNtcE+7jWMG+KuQP1KdSb+5DLAUcCtlEJeVlwfE1JqD4M/lieMaNaqyY3FGWdG
 Jc2V/HB/KcC1Nj0w0tPHRSmlS0cibRNwyxyuo2hb7zZDy6poBmfghtSi6IjtKfR5pESs
 ivcWhqEP/+rD6n7P3D7AA0MTHqyRGpX843bb0yq85KLQ+THfqkosl8zT+iYvlLuX9syh
 /SgbGZJ5wXO8mx1YvwByEHChFAdgM2Hm2Ib5+xMoOZWfsBU/ZPRZsq18tr6O/4LUXzTe
 XS9FSrPHbrymu+zAdhHnyz3saXC2WRspIxynVIelplNgfdPAZZ/QAymukl6lRVSabcEn
 9YPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IoycA8sCG/5JeMozMHv0Dmc2yGmLtB9gyHgSajmfEp0=;
 b=elUTghjD8hW4pbyi3L3ZJHDEirrrTsJM1uRFIwt2xzHnMWiSAyml/4uYY5ZCOJ4/G7
 /uOqTE58n9UTR+obLYiMj2QPh5gXx8Vq4eV/KneMxboJFK0tonUf5qJvri1oWzDqDNTs
 pw849zXAl4Emrop7utlnXgUoK1VQmjNC7TPqSeW+sFcmrpKscuh3encQAvFzrpkUBy7+
 bee4wo90pWjh7aA6Gjgz21VG60e60Hb3CU3/tfdhyKxwxGlysEyNZ4HGuH8/73ZmWaP5
 AAccpFhtJ3ARIbFXrLj88Sx0Ch/Uoojx++iDpajswYw2PvuZrrA57ZovxyxYw1zS3UsP
 Laeg==
X-Gm-Message-State: AOAM533nWWsF4hidyMaMQIgOb7GVo6g/5E1N+S2hDBidGDQNiREMxNAD
 9/sTwMawVbM7F5tnR1tm7iXsMq0SaOo=
X-Google-Smtp-Source: ABdhPJyOUfOq5d+y3X/tfgnofWblzvcItGFt+We8GrxpGi84aYNB65OPy4Sfe7yBSJimAUvJRUAH7g==
X-Received: by 2002:adf:f2d0:: with SMTP id d16mr10459141wrp.332.1601152567413; 
 Sat, 26 Sep 2020 13:36:07 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id j26sm7734294wrc.79.2020.09.26.13.36.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Sep 2020 13:36:06 -0700 (PDT)
Subject: Re: [PATCH 02/14] hw/core/clock: trace clock values in Hz instead of
 ns
To: Luc Michel <luc@lmichel.fr>, qemu-devel@nongnu.org
References: <20200925101731.2159827-1-luc@lmichel.fr>
 <20200925101731.2159827-3-luc@lmichel.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f5f6c8ca-d4f7-d06f-94d9-ded36ebf5753@amsat.org>
Date: Sat, 26 Sep 2020 22:36:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200925101731.2159827-3-luc@lmichel.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.213,
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/25/20 12:17 PM, Luc Michel wrote:
> The nanosecond unit greatly limits the dynamic range we can display in
> clock value traces, for values in the order of 1GHz and more. The
> internal representation can go way beyond this value and it is quite
> common for today's clocks to be within those ranges.
> 
> For example, a frequency between 500MHz+ and 1GHz will be displayed as
> 1ns. Beyond 1GHz, it will show up as 0ns.
> 
> Replace nanosecond periods traces with frequencies in the Hz unit
> to have more dynamic range in the trace output.

I have a similar patch adding the freq but keeping the periods in
case, as it might be a matter of taste (for me too the frequency
is more meaningful).

> 
> Signed-off-by: Luc Michel <luc@lmichel.fr>
> ---
>  hw/core/clock.c      | 6 +++---
>  hw/core/trace-events | 4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/core/clock.c b/hw/core/clock.c
> index 7066282f7b..81184734e0 100644
> --- a/hw/core/clock.c
> +++ b/hw/core/clock.c
> @@ -37,12 +37,12 @@ void clock_clear_callback(Clock *clk)
>  bool clock_set(Clock *clk, uint64_t period)
>  {
>      if (clk->period == period) {
>          return false;
>      }
> -    trace_clock_set(CLOCK_PATH(clk), CLOCK_PERIOD_TO_NS(clk->period),
> -                    CLOCK_PERIOD_TO_NS(period));
> +    trace_clock_set(CLOCK_PATH(clk), CLOCK_PERIOD_TO_HZ(clk->period),
> +                    CLOCK_PERIOD_TO_HZ(period));
>      clk->period = period;
>  
>      return true;
>  }
>  
> @@ -52,11 +52,11 @@ static void clock_propagate_period(Clock *clk, bool call_callbacks)
>  
>      QLIST_FOREACH(child, &clk->children, sibling) {
>          if (child->period != clk->period) {
>              child->period = clk->period;
>              trace_clock_update(CLOCK_PATH(child), CLOCK_PATH(clk),
> -                               CLOCK_PERIOD_TO_NS(clk->period),
> +                               CLOCK_PERIOD_TO_HZ(clk->period),
>                                 call_callbacks);
>              if (call_callbacks && child->callback) {
>                  child->callback(child->callback_opaque);
>              }
>              clock_propagate_period(child, call_callbacks);
> diff --git a/hw/core/trace-events b/hw/core/trace-events
> index 1ac60ede6b..6f96d8bfd0 100644
> --- a/hw/core/trace-events
> +++ b/hw/core/trace-events
> @@ -29,8 +29,8 @@ resettable_phase_exit_end(void *obj, const char *objtype, unsigned count) "obj=%
>  resettable_transitional_function(void *obj, const char *objtype) "obj=%p(%s)"
>  
>  # clock.c
>  clock_set_source(const char *clk, const char *src) "'%s', src='%s'"
>  clock_disconnect(const char *clk) "'%s'"
> -clock_set(const char *clk, uint64_t old, uint64_t new) "'%s', ns=%"PRIu64"->%"PRIu64
> +clock_set(const char *clk, uint64_t old, uint64_t new) "'%s', %"PRIu64"hz->%"PRIu64"hz"

Unit is spell 'Hz'.

>  clock_propagate(const char *clk) "'%s'"
> -clock_update(const char *clk, const char *src, uint64_t val, int cb) "'%s', src='%s', ns=%"PRIu64", cb=%d"
> +clock_update(const char *clk, const char *src, uint64_t hz, int cb) "'%s', src='%s', val=%"PRIu64"hz cb=%d"

Ditto.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

