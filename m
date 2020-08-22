Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B69C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 20:01:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0EF92072D
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 20:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNd7T7j9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0EF92072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9Zhv-0003Jh-9T
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 16:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9Zh5-0002q3-R0
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 16:00:51 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:41463)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9Zh4-0002R8-D2
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 16:00:51 -0400
Received: by mail-wr1-x430.google.com with SMTP id r2so4960847wrs.8
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2020 13:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=vpB/+pBx/MDiJ6iQHtMpCskZQntkyIsfKEWBmxV6svQ=;
 b=NNd7T7j9bXN+BA0jSoT9BZGxx7Hvklmdi3rSt+jl+9vf/OaO6X5F6Ptd3poejSbJGN
 gxTj7uaNwt1yo6triqxRkpIE/h7TMpLT3cUwKbZecF6GJ2GZaE/ukshtsCqrSvYOmxrv
 +d9odRTilL8PtY10KrZBRih338n1AzkNC0obHCH4sLfNd/CCCRlOHALDUstRvH6yLjb6
 AL3u4BepIgHzC9RtAhCV5r9P+2MJ0w+5Trf3CHTDxyR2kvU251cwgOxx5UuG3bTS+dmJ
 Pdb2JFdwp83p97ClY/zfAtEZJXPZHGC5tdxNCYNWG64d+8uPUGzX8I5FjedpuHi6RXl1
 Rsgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vpB/+pBx/MDiJ6iQHtMpCskZQntkyIsfKEWBmxV6svQ=;
 b=RNRDoVk8KJVzfZQ0OdU/KVehWY16yoe9JB9s3s3V9AdTCvNO20PxzI6Kf7D4zmLOm7
 /DtEC6rbnM1fPqFzAbjbAY3MN3E1rEjD1RJ+iqTsPfFkx3ZWx6znnjz/5+bXtwON7M4/
 DbM2yvLTGWKv6wX2yTLLvIsYc62SHnun3TAKrFM3SkZnGglxxFdXRAAGc0tGR/kVHolh
 nYI+HxO8jzSCNMs/FZ/jO9Yt+rY7bv/rkCvwXt077eIXCmuMxyx2Yw7SrG6P1REF0Xde
 kFm4dXWQxJeO5LMeMX7YOPLTy5xtWEW/IALQsMdfwVGcWiDi1QG/eMB2pwexUaF+v6D+
 dJ+A==
X-Gm-Message-State: AOAM533uWsXe5pjNnFmGbXG2EJCdALHNHKyroHrDANqAXIsGPYTwt2nA
 tsJZvCvMCgd7iuZBLn9Wv0CgcBtLTI8=
X-Google-Smtp-Source: ABdhPJyc/pcfNgiM7e2qPeMtnn3PPOUhWcaBnFAXJrG5jcf2w5YUuYlT316319Hb7J/wYJj+telUzw==
X-Received: by 2002:adf:e290:: with SMTP id v16mr8011593wri.259.1598126448979; 
 Sat, 22 Aug 2020 13:00:48 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id n24sm13140976wmi.36.2020.08.22.13.00.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 22 Aug 2020 13:00:48 -0700 (PDT)
Subject: Re: [PATCH-for-5.2 0/4] hw/char/serial: Use the Clock API to feed the
 UART reference clock
To: qemu-devel@nongnu.org
References: <20200806130340.17316-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <bc283986-6f08-fb1c-2219-9b4af64eaaa0@amsat.org>
Date: Sat, 22 Aug 2020 22:00:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200806130340.17316-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x430.google.com
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
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/6/20 3:03 PM, Philippe Mathieu-Daudé wrote:
> This series improve tracing of multiple UART device in the same
> chipset, and allow to use the Clock API to feed each device with
> an (updatable) input clock.
> 
> Based-on: <20200730165900.7030-1-philmd@redhat.com>
> "hw/char: Remove TYPE_SERIAL_IO"
> 
> Philippe Mathieu-Daudé (4):
>   hw/char/serial: Replace commented DPRINTF() by trace event
>   hw/char/serial: Remove old DEBUG_SERIAL commented code
>   hw/char/serial: Let SerialState have an 'id' field
>   hw/char/serial: Use the Clock API to feed the UART reference clock
> 
>  include/hw/char/serial.h |  4 +++
>  hw/char/serial.c         | 55 +++++++++++++++++++++++-----------------
>  hw/char/trace-events     |  5 ++--
>  3 files changed, 39 insertions(+), 25 deletions(-)
> 

ping? Should I resend with the typo from patch 4 fixed?

