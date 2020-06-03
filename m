Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A328C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 05:07:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 261A420679
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 05:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+643GlT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 261A420679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgLcp-00066s-Dm
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 01:07:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jgLc7-0005CT-6T; Wed, 03 Jun 2020 01:06:55 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:39833)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jgLc5-0007Iw-8q; Wed, 03 Jun 2020 01:06:54 -0400
Received: by mail-wm1-x334.google.com with SMTP id k26so557621wmi.4;
 Tue, 02 Jun 2020 22:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=bdgiK1WTnW8StDTPRcwjrZ9J0we35lDohHcS4+aaIII=;
 b=S+643GlTKr1Qzkf1gz9CKmRRVGJYyX9CNghAHFHIFkT1b9US0xSobbtrrkPdF4LKig
 NzA0mBX9N5xXw9A6hmldoXD1247RzE1XfYCSLabM+5mDKbtcQXtYyThFcCIQajPiXEnc
 3rr7CDVg5etHi0kfVWP3YRscqSi3LP/T8oPdQA0f+EZALgaNCPSUGLThAJ2qAKnL+vjk
 1rxhW/uOaEM0XLKTZ3wXxRRM5q97L+tRUwA39zY2BbVnatuGtOkhbe1vbKk+ecc+AlYs
 rr+LjOs7MkWJgOUgVyVktSgaWfmkkC+3ZuJcMrpGk35TyAprEN1rbcooMwDOnEMMnb4R
 vmhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bdgiK1WTnW8StDTPRcwjrZ9J0we35lDohHcS4+aaIII=;
 b=nowVSwWPHb/eUOX7Xy4Krnmvn+jXK+4xfgE+SqL+Ux0bC5of/YF5CbMi/i0wEFnhJ+
 37f/Y2EoGS57z4pu7UI9VgBjvFIatc/ws0p00hsN+8FUi8X9+ePTC4edOJZQBAF7+Ofj
 SV3U+q/5HaMfUEqgzATFD5Znzx1oNyK5pPXBd98vOcy20HWaX1o/p35Mrz9WwLwZp14q
 cKMp9kA4IVnEQDjKAR/rZ0FJQrtbPCM5Te4IiWvItfuDuuCDKaaZzLMEeglltm784FY6
 kTL48LDIXb/DUjfhEtgwsny27CeRZhn7OnKwobIuRmaE/gmh5K8bzh3l8BthoplvKWM/
 rYTg==
X-Gm-Message-State: AOAM533VeYDGx+V/XtEh9h4DsG10sQZC/IipO48gsFh950AegMxYIJnp
 7vXTEy6xnHs9Jp2mzgrgn/Dd6BW+
X-Google-Smtp-Source: ABdhPJy5OMELDmTTitMLjoYUJUjWI1/gbYPR1yuFWTPXsZaaaNGRaLYdmYpm2eKYa/NjXCFT5m2dfQ==
X-Received: by 2002:a1c:2e4d:: with SMTP id u74mr7232001wmu.145.1591160811304; 
 Tue, 02 Jun 2020 22:06:51 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id b19sm2841313wmj.0.2020.06.02.22.06.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2020 22:06:50 -0700 (PDT)
Subject: Re: [PATCH] .mailmap: Update Fred Konrad email address
To: qemu-devel@nongnu.org
References: <20200518103920.10699-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <79e305ce-2442-16f1-559d-b776d42c4e8d@amsat.org>
Date: Wed, 3 Jun 2020 07:06:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200518103920.10699-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x334.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Frederic Konrad <konrad@adacore.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping?

On 5/18/20 12:39 PM, Philippe Mathieu-Daudé wrote:
> Update Fred Konrad email address to avoid emails bouncing.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/.mailmap b/.mailmap
> index 6412067bde..4c7f4b7d03 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -44,6 +44,7 @@ Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> <aleksandar.markovic@imgte
>  Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> <amarkovic@wavecomp.com>
>  Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com> <arikalo@wavecomp.com>
>  Anthony Liguori <anthony@codemonkey.ws> Anthony Liguori <aliguori@us.ibm.com>
> +Frederic Konrad <konrad@adacore.com> <fred.konrad@greensocs.com>
>  James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
>  Leif Lindholm <leif@nuviainc.com> <leif.lindholm@linaro.org>
>  Paul Burton <pburton@wavecomp.com> <paul.burton@mips.com>
> 

