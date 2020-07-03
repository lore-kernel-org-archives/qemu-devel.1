Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBB7C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:09:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15DC3208E4
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H++d+Ac+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15DC3208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrLRu-0001Jh-C0
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 09:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrLR1-0000NJ-BD
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 09:08:55 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:38469)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrLQz-0006ff-Hj
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 09:08:55 -0400
Received: by mail-ot1-x343.google.com with SMTP id t18so13839883otq.5
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 06:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=VSPHyoydK/XhSF/ZAzYjAjwuX6r6YDYv9ULbuEgiHHA=;
 b=H++d+Ac+gR5H9qbd9bcJ2dtHlCKArpXB8ASVssgf+lO/OM/ALRy8xL9j4lnfElF4Th
 IYEAz2WVJex7Flw5tx8RlfGXWQrkQL3W1OtcCEk/lKi62it1m3PVvCw+1XGgdNPllxYV
 2Craf+EFt/0p2jv51Wo9huWEbIBmDFC6drTBoVEE+R5O/0rSIF/Q25sQ+6imhCHau6z8
 V2B4mX7rgmtxQgjXwBm6/CXoEHc5k++6KG9zpZbfWMjd06+TcMM/KuU58wJ1U/5DUC1l
 jwovbeEdJrTb01h5cYybqoj6kHNqq9sd0EiVJoOmDnxJDIiEUCoAENVbL1dk6nO2Yx3x
 kddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VSPHyoydK/XhSF/ZAzYjAjwuX6r6YDYv9ULbuEgiHHA=;
 b=VIIDjQ/crLwGeUWUPYFzFvXYPUc9RLMn/XvCsOWwKkTa/u1o9nd8qUEOhsLWhWjHCV
 ZjuVTqrdDQrIQVupwSgquIjCw4xgUERt65VZRlgrI1x96+sULmpdZm2ooSUp1q2fPIFJ
 22jOf/ulLM07AJtIIfEoG58L/Hy7Xx3c9alaWhy4Ex2cJROjqSTBZIB3DDShHEP25AYM
 nXLq4sqX+z1O/ERubjZByYDy6WQ5gjrv6a6aij2oQi830ZvClw2qZ3ulE9LlTs/r5j7A
 8FBkuVCUMSqvMvsedBrnrSE+sTjYSkU1WKvR94q/JEhGmml5UejI0U7sONzOkKAaN9d0
 IB2Q==
X-Gm-Message-State: AOAM532AYYjDL3RECAuiUABHwh0BevaAgbLEvZxIDXgCttzma/NZBrU9
 VSeW3/ZC/BkODK90d/Y/VZHKcKPsCGB/8OZ0322eMA==
X-Google-Smtp-Source: ABdhPJwlR1zLPZjeXcBU3VrpSz9oO6XQfwSI3ws08tB88HEDC4KBgQwXLvLGNfxjDqkzgw+q9IV+d4zWZ5VchK051+I=
X-Received: by 2002:a9d:7303:: with SMTP id e3mr24406645otk.221.1593781731676; 
 Fri, 03 Jul 2020 06:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200630133912.9428-1-f4bug@amsat.org>
 <20200630133912.9428-4-f4bug@amsat.org>
In-Reply-To: <20200630133912.9428-4-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2020 14:08:40 +0100
Message-ID: <CAFEAcA-oivTRmK8tkYPa2FjJXbq2t7dBEnxfmfxRjZeddq2ktA@mail.gmail.com>
Subject: Re: [PATCH v7 03/17] hw/sd/sdcard: Move some definitions to use them
 earlier
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 30 Jun 2020 at 14:39, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Move some definitions to use them earlier.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

