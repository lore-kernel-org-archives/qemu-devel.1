Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40B5C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 20:12:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C047620855
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 20:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gp7jP+y4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C047620855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9ZsS-0000ZC-3m
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 16:12:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9Zrp-0008Sv-8d; Sat, 22 Aug 2020 16:11:57 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:50274)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9Zrn-0003f4-Q0; Sat, 22 Aug 2020 16:11:56 -0400
Received: by mail-wm1-x32a.google.com with SMTP id t2so4646127wma.0;
 Sat, 22 Aug 2020 13:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=FGrHTi+rXKQ8gTjyG+Q9tPRB04Bdg9e5XS9XpP1Ub18=;
 b=Gp7jP+y40ARESv4g481WL3tfsxGIBJawXsXeuTCivbM/3HumnrbTi2DsYkj1P3MTvM
 yjMcnG4rare9dfomG9ayLL1xKiJcRZrhPpK9myzo3jxcMqjHHxVjqTEkelL0jv3whcri
 V0xXeXpcWXccPYLc1dWeeIu/QDx5xkBRCSCz53ex+v8/kqrSSO/JjUvGkAh0OdNnvT0U
 fsLNkWJjRV14CMEvNfDDtD96qK1PEZBmS13AIUDkAXGtdCSvrqw2L8MOgMb478tj1R4S
 QKtrJV1I2wzam6T9A10y9sHP+tF0BjRLYjZrdG2aAQRFqjLFQrh9eaXLHYP7y6C2eXYZ
 cL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FGrHTi+rXKQ8gTjyG+Q9tPRB04Bdg9e5XS9XpP1Ub18=;
 b=JVkJTGjx5Xh2C1CWn4VMogd2fVAfuFzy2LS+lA2iCzdVi1LHZsCKT18NUQyJZI6l4A
 JwlhPhHYoGiTcS24Be8oYDpAonLqIJbjtTZR+p88a64DbGmgfrgnd0kBbs3CdD4QUftP
 pdiF5we1F24pe/KJWsNOfGhNigJxEOU10lXxZvyUytuvIwukMP59HTDBH21VxMU9Bp6X
 NGoyeyAnZ++3BDLk1/Nas85n8AdAwaqokxiOt4LPFnJuUfaXSIyEsrZkhwsLUQvTaNbK
 jQ5K6KbRv3YrG1VFyl0ZyUkajJQKlyEHxOiK2fo75W5XnRD8G6bcREVOamiFWDVMB2gJ
 iQJQ==
X-Gm-Message-State: AOAM533ybim/AYVCh6YwfVAA038mDLeRrFU9qs93T4QjZ+4eaw9g5KOB
 mLGjxIzQIKwmzy5nTxjP299OMloOshk=
X-Google-Smtp-Source: ABdhPJzxfpsXBN69nMQt9EZlPY6+r1ysLEhOLH4IZr4PsbKc1s1pMftUzhEbXSO+8+GJppOBYIKqsQ==
X-Received: by 2002:a7b:cb47:: with SMTP id v7mr8611027wmj.36.1598127114019;
 Sat, 22 Aug 2020 13:11:54 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id o66sm14847831wmb.27.2020.08.22.13.11.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 22 Aug 2020 13:11:53 -0700 (PDT)
Subject: Re: [PATCH-for-5.1? 0/4] hw/arm/xilinx_zynq: Call
 qdev_connect_clock_in() before DeviceRealize
To: qemu-devel@nongnu.org
References: <20200803105647.22223-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1876dc76-567b-fe59-852a-d5a429b7a131@amsat.org>
Date: Sat, 22 Aug 2020 22:11:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200803105647.22223-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32a.google.com
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping now that 5.2 is opened :)

On 8/3/20 12:56 PM, Philippe Mathieu-Daudé wrote:
> This is not a critical issue, but still annoying if you use tracing.
> 
> Maybe it is worth fixing for forks that are based on release tags,
> else consider it 5.2 material.
> 
> Anyway we can still discuss if qdev_connect_clock_in() is supposed to
> be callable *after* DeviceRealize.
> 
> Philippe Mathieu-Daudé (4):
>   hw/arm/xilinx_zynq: Uninline cadence_uart_create()
>   hw/arm/xilinx_zynq: Call qdev_connect_clock_in() before DeviceRealize
>   hw/qdev-clock: Uninline qdev_connect_clock_in()
>   hw/qdev-clock: Avoid calling qdev_connect_clock_in after DeviceRealize
> 
>  include/hw/char/cadence_uart.h | 17 -----------------
>  include/hw/qdev-clock.h        |  8 +++-----
>  hw/arm/xilinx_zynq.c           | 24 +++++++++++++++++-------
>  hw/core/qdev-clock.c           |  6 ++++++
>  4 files changed, 26 insertions(+), 29 deletions(-)
> 

