Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788E2C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 09:18:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 403EE233A2
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 09:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6CdPRDB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 403EE233A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jppvf-0006MK-7Y
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 05:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jppuc-0005PW-PZ; Mon, 29 Jun 2020 05:17:16 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53032)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jppua-0005Tw-Ir; Mon, 29 Jun 2020 05:17:13 -0400
Received: by mail-wm1-x342.google.com with SMTP id q15so14651302wmj.2;
 Mon, 29 Jun 2020 02:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=De32tOa44wWJK+6QZams9i4WwY0Bm0bGrUY1JCdKVvY=;
 b=F6CdPRDBSKkMxgJ9pBzreSsHubfRLlD8sSEqcl8qbTYqBf2g/2iFPvubAzmmb3aKrG
 hGbrJdU/DxquSMTwRv6pEXrx60DOZAifs068YTFnRbdLKLC5Q+uO5W8FwdA0qLeXt3rc
 vNjCGZo0SFCdb7BFgfh2RMbbv/w86FxXh1PgVrzicXN2zfSV9xAk4BAIvVYgR8rf0Huu
 ZCHDc7IV5flbTGyTo646/aDGFzR2oi2pWuFG18dd2vDTsG0zwBG6PHtqmdbWXF5O/0Tv
 S2qpqO4YZYDvLdJ1sqgOKA3dLYUMiehTVrRyzF3IXR7viZ7GxEWwCyoLOsizpq3xQM8O
 8ylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=De32tOa44wWJK+6QZams9i4WwY0Bm0bGrUY1JCdKVvY=;
 b=JKBo5CK0nUfZYaB1TrrkTRFNRfYBtuvFp/0c9Tn33FJRpLH/eCWpRnduNZRaE9hSas
 Qt0m5egiR5GESPRZZ1+gh69QZeD3QSl1nwL/85dYn1ulOkB/de2Ae6GjOD9TVi8Mk+df
 HKY7ETQIj0UylJzRPoO3er4tUSxDnnWTtiRr4uAojm5omKNypaqcrvJFjelkEpF+HhBM
 uPD8J1FanIWddLTtSs8C92vhGM+0SQHdjb704CF9WmmdW7kjgup6TStlldgtZqapnQL9
 f0UMO+HmHG/A4pqPxQCHbgGVUGdItdb7154d/alnek+D9khPEaTFYT7CyPEgx5KB5coN
 x9Ig==
X-Gm-Message-State: AOAM53099OwzmQUu9xfniTOzOmYDE/GTBErHE3dmGPC4caBhHzV4ysvr
 QlZfIp0Y66LjGGev3iJzVnw=
X-Google-Smtp-Source: ABdhPJzzOHVGp625qwXfpKvQRA0Ut5yODZlKAt6sBBI8gHumejy0j93UsP5eeqnQNiFRq2vJbRXoqw==
X-Received: by 2002:a1c:a7c4:: with SMTP id q187mr15372881wme.0.1593422230140; 
 Mon, 29 Jun 2020 02:17:10 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id f12sm18299887wrj.48.2020.06.29.02.17.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2020 02:17:09 -0700 (PDT)
Subject: Re: [PATCH 16/17] hw/arm/spitz: Provide usual QOM macros for
 corgi-ssp and spitz-lcdtg
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200628142429.17111-1-peter.maydell@linaro.org>
 <20200628142429.17111-17-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1962ab16-5548-674a-1f76-7b3c265dd09a@amsat.org>
Date: Mon, 29 Jun 2020 11:17:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200628142429.17111-17-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Alistair Francis <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/28/20 4:24 PM, Peter Maydell wrote:
> The QOM types "spitz-lcdtg" and "corgi-ssp" are missing the
> usual QOM TYPE and casting macros; provide and use them.
> 
> In particular, we can safely use the QOM cast macros instead of
> FROM_SSI_SLAVE() because in both cases the 'ssidev' field of
> the instance state struct is the first field in it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/spitz.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

