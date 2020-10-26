Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E74C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:11:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C37CA206F7
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lf9aqAdX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C37CA206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX61O-0005v2-SC
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 13:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kX5xs-0001qc-TE; Mon, 26 Oct 2020 13:07:25 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:37687)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kX5xr-0006lo-1a; Mon, 26 Oct 2020 13:07:24 -0400
Received: by mail-ej1-x643.google.com with SMTP id p9so14698896eji.4;
 Mon, 26 Oct 2020 10:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=W74jO11sL6GXJK3TlAFoJoRz9TpGE9MwskoCF/al+BI=;
 b=Lf9aqAdXvOckYao+02WJGGxpPbE48kBE1cmcj8Ih/jgZihGj/TBEp7YIBmdsA2si25
 GBioLbb9RLfDtUY9Kj8e2i/5FoujsU0U5gSOVEvJqHHgn0k+APykJtbCehsxKLUZqjxz
 AOlnDzdoK1nIgrDdusXEauBHO9/ZyKA8Sjoh1PcHCLnVs/keD+Evp3ZwgesdkSnbJQrb
 Q2NB+k6ryhC7hib+jCpp9BmZUeFUNAtslM0Ek1DCjVscNyMS/uCtg18aUCzdrYfVk9WX
 TIBJnX2A9y5uE7PenrfXfyTugppBoFNMDaFfRxYvQUksN8SwTc9nD4ErpzfxMebBhgxx
 dofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=W74jO11sL6GXJK3TlAFoJoRz9TpGE9MwskoCF/al+BI=;
 b=RZhR2L6aU13XQI+7R2XizFueKSHGGkLGL++B0y4OcptRzSOdjSkasY9mO43RXg/Bh9
 yxjotE1LgMbxm+6x7zTr1ZpmEL1DTH/rDmbjXboG1h28TmG6wUbn8Oov2vmaTilAhiej
 H2hk4QV4+X+cp0wtgt2kkqJdLG8TRK8OVYzyKgqT6US7afxSqyYSxcy73NkqLDo+sMWl
 sgzerzBneKt//G00BQ16pXujUMKshnGP1zxEMXc+lYgNuVIWhIi+z55zNec8qjc0Mc3S
 HvY68c3g4d0CH2tsmBlVfR1s+jv7XD/OL2EWc5b+5u6y5G0yu2Gb7tkU3srcRasFYGaf
 BMTg==
X-Gm-Message-State: AOAM531fEm6M//kX4uxssMT1n/5QXfXN7pMHmKpLfASp8qfFug4OI6E9
 dHFmrDqyJo9jCNLuphjiXtg=
X-Google-Smtp-Source: ABdhPJw/zuKTW/KoezFKPCWSlj1r5vFI1rmHF6DQ5bmlljvSsNNjvZawDVy8KGe/qschcMDUdz1DiQ==
X-Received: by 2002:a17:906:bc91:: with SMTP id
 lv17mr17147783ejb.249.1603732041200; 
 Mon, 26 Oct 2020 10:07:21 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id bw25sm6337943ejb.119.2020.10.26.10.07.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2020 10:07:20 -0700 (PDT)
Subject: Re: [PATCH 0/2] hw/intc/bcm283x: Trivial tracing cleanup
To: qemu-devel@nongnu.org
References: <20201017180731.1165871-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f87cc670-a1c4-62ea-c4f2-5706a9af1a18@amsat.org>
Date: Mon, 26 Oct 2020 18:07:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201017180731.1165871-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-2.167,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Luc Michel <luc@lmichel.fr>, Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping?

On 10/17/20 8:07 PM, Philippe Mathieu-Daudé wrote:
> Add trace event for IRQ from CPU/GPU,
> use definitions for IRQ numbers.
> 
> Philippe Mathieu-Daudé (2):
>    hw/intc/bcm2835_ic: Trace GPU/CPU IRQ handlers
>    hw/intc/bcm2836_control: Use IRQ definitions instead of magic numbers
> 
>   hw/intc/bcm2835_ic.c      | 4 +++-
>   hw/intc/bcm2836_control.c | 8 ++++----
>   hw/intc/trace-events      | 4 ++++
>   3 files changed, 11 insertions(+), 5 deletions(-)
> 

