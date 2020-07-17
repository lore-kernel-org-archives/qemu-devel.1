Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDF1C433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 07:54:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCF0320704
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 07:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Go8xSrwX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCF0320704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwLBv-0000tf-6X
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 03:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jwLB3-0008Uz-MJ; Fri, 17 Jul 2020 03:53:05 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:35022)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jwLB1-0003Uq-T8; Fri, 17 Jul 2020 03:53:05 -0400
Received: by mail-ej1-x641.google.com with SMTP id rk21so9809846ejb.2;
 Fri, 17 Jul 2020 00:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ngVNlIsRGEt8KuXd4hbJl5Z7VDX/cN8grYXz4lx8FpY=;
 b=Go8xSrwXtpnEh6h8qUQc4iF/CppjAarW9FRy6cZ7OaWa5e9RCRdRPXtKSdAg2orNGr
 GZq0wLPhIUOvw74ptlOG3+JhsERUfbK8nItYNRPGAT8oEU3gP8pmK5YPzk97Sx238l/3
 KoC0D8or6JZJtUtYAK3gj1AaUB02EG14chM7lsXVwlHEH6tves6CgHGJ2mLl3HfjVVdS
 M94X0zsjL9GzPJMyB++DWjoMdgB+RqtIulxPh6csy7t7TrhtGE4w0rbPvlJLk0mdRxCS
 aR+a2jkivpa8/Tp5LHg++qhqT8aJb1DV/wDNfnNg2RovgTXN3XelrbB59dMT+beL6l5O
 uJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ngVNlIsRGEt8KuXd4hbJl5Z7VDX/cN8grYXz4lx8FpY=;
 b=jF7qn6QBrRBPuYV9YNqh8zJcQXF17Kzwfh+5r0pr01NN9LWL/cNpgMMALlXS/FmkgE
 jmgJKLmyFqxHVAEq2rNfiQL5IXW1kGvOsKhSL0Hnt/RmiJpLtpO1ou5dVVce1R5OiwVF
 T/XBm1NOxUSU9BGxugbXyuHtoZDHz5y4a7qWhYSsctCYHRFZEsbKzKT6LfBNujXU9DO0
 JtV+hyDMPw10P+ZcGFPPM7/xaT4cvVrTK5g9F+RKB4MgDUKHhnPcUyg8vw6W/qNEzYOD
 czljwhahuC0O8j2LcpGeNJ5lGI/2WSwjcqTlG9+0KhjmqMTiqTndk2z5H2ggQMNljO4E
 FqOw==
X-Gm-Message-State: AOAM533egFz9C7C2m0AOx2N7ZxNaqlsF/t+1CTEun+PEIY2o8v9CYJ1K
 O0QZlo2c1Oxm+qdpX/3jjL7XikLNzUU=
X-Google-Smtp-Source: ABdhPJxOZY+4cd1DFK2H9c9fdTRvFO41YqhEHKutFx/9SiSzP/6/c+NsT3WpawoEFr0iGc2gz54plg==
X-Received: by 2002:a17:907:20af:: with SMTP id
 pw15mr7782239ejb.204.1594972381944; 
 Fri, 17 Jul 2020 00:53:01 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id x4sm7167936eju.2.2020.07.17.00.53.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jul 2020 00:53:01 -0700 (PDT)
Subject: Re: [RFC PATCH-for-5.1] hw/ide: Cancel pending DMA requests before
 setting as inactive
To: qemu-devel@nongnu.org
References: <20200717074748.2528-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d8ec0444-6b46-f0bd-2931-d817962d5f93@amsat.org>
Date: Fri, 17 Jul 2020 09:53:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200717074748.2528-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Alexander Bulekov <alxndr@bu.edu>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/17/20 9:47 AM, Philippe Mathieu-Daudé wrote:
> libFuzzer found a case where requests are queued for later in the
> AIO context, but a command set the bus inactive, then when finally
> the requests are processed by the DMA it aborts because it is
> inactive:
> 
>  include/hw/ide/pci.h:59: IDEState *bmdma_active_if(BMDMAState *): Assertion `bmdma->bus->retry_unit != (uint8_t)-1' failed.
> 
> Reproducer available on the BugLink.
> 
> Fix by draining the pending DMA requests before inactivating the bus.
> 
> BugLink: https://bugs.launchpad.net/qemu/+bug/1887303
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> RFC because I don't have much clue about block drive and IDE,
> so block-team please be very careful while reviewing this bug.
> ---
>  hw/ide/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index d997a78e47..b21d28f99c 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -804,11 +804,11 @@ void dma_buf_commit(IDEState *s, uint32_t tx_bytes)
>  
>  void ide_set_inactive(IDEState *s, bool more)
>  {
> -    s->bus->dma->aiocb = NULL;
> -    ide_clear_retry(s);
>      if (s->bus->dma->ops->set_inactive) {
>          s->bus->dma->ops->set_inactive(s->bus->dma, more);
>      }
> +    ide_cancel_dma_sync(s);
> +    ide_clear_retry(s);

Oops this is not the one I wanted to send. I'll send v2 shortly =)

>      ide_cmd_done(s);
>  }
>  
> 

