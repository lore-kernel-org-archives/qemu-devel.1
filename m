Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B27C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 10:55:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DD2A2078D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 10:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caPSsegC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DD2A2078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmEfw-0005nJ-O0
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 06:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmEfE-0004x0-M8
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 06:54:28 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39039)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmEfD-0003Jw-99
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 06:54:28 -0400
Received: by mail-wm1-x341.google.com with SMTP id t194so8694088wmt.4
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 03:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ra/tssGqhuNa2RfJmIpkfXGJinVR4n49uBBiqIHkC+g=;
 b=caPSsegC/c/dQNMfqmU/IemDcSu5SQj4rQA7oBsCd3UVlRSqKDH42/8dOb4c2IvT/E
 jkXf2FI6t1Qw+ZC/jZG5BHuNUcJgFVqYZpHv6yffKKy2Nl3oDUVvDaOl6xxviIKePmzy
 /VrCrtZrre8PqBNC1hD+Q5++MFukRny7wlZ4yH9LlP4TsIuuJjsAJoHXSOYd3NLeI2QJ
 tdHHkwaF3qaIIJHGNg7OkUUL6rBH1d8fR79+X08pOpft9xz0Prn8a4C+YNJTmk43vliY
 qMksKM1jxAX8lavzx1rtkZ0UPrXQ8Jo48sYCTcFvKnoHqRdX8mjN25tu//CIKzwkZPsi
 XWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ra/tssGqhuNa2RfJmIpkfXGJinVR4n49uBBiqIHkC+g=;
 b=h9xFMdU1SnM+vKoI3LBB17lYvyEWP58QSUej71BcUYUCpTO0+TqKFTIHkXpuuwjog5
 PACN4rjNtMut2J9FfzLMbsELH3D73LCXtWl9qneeR8y60BTgX04MK4UNJEdj/GGD70pI
 +VlcfBdIz9mCrOPtgTXCWPGq1dI5Bvns5SEZHd74Kme1w1ctI+BKt5C/4gxDHzt6oRV9
 5bfRIoVk+yv5Efqa6tyH3uty8vlzDvPONjisE1a9Ifjl+fB+v+EBjFDYAkxaPUG7DWPY
 VfLPTdIXO621h7e7tbCfAkx1Xu9Im7Du2FCDaqsGCiBLbiH8ytQyAti/CLTBk+KdVHTg
 Z8vQ==
X-Gm-Message-State: AOAM532j1Yz95i99Qd9NSj9jxKkuoSPe8BLom7fG6r7gqnKynAILlmyi
 F4OroN08Rb0ut7P6OE5U3Oo=
X-Google-Smtp-Source: ABdhPJwj4OUlBU1GoIj6wdf3IOS9SUXDWDq8rlX7K4npQHesukvicYl7xFa9LLA8s9S8GTHnRJSoKw==
X-Received: by 2002:a1c:a906:: with SMTP id s6mr3277795wme.171.1592564065695; 
 Fri, 19 Jun 2020 03:54:25 -0700 (PDT)
Received: from [192.168.1.37] (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id g25sm6344064wmh.18.2020.06.19.03.54.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2020 03:54:25 -0700 (PDT)
Subject: Re: [PATCH v2 6/8] sm501: Use stn_he_p/ldn_he_p instead of switch/case
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
References: <cover.1592266950.git.balaton@eik.bme.hu>
 <59fd9656e72cd56e6dcd3c9ffc04ff91f8b3d907.1592266950.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <dfe12894-a7b0-65f3-0b38-82d72d01f9c7@amsat.org>
Date: Fri, 19 Jun 2020 12:54:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <59fd9656e72cd56e6dcd3c9ffc04ff91f8b3d907.1592266950.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sebastian Bauer <mail@sebastianbauer.info>,
 Magnus Damm <magnus.damm@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/16/20 2:22 AM, BALATON Zoltan wrote:
> Instead of open coding op with different sizes using a switch and type
> casting it can be written more compactly using stn_he_p/ldn_he_p.
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/display/sm501.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index b6356ea1ee..6e914d3162 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -766,17 +766,7 @@ static void sm501_2d_operation(SM501State *s)
>              for (y = 0; y < height; y++) {
>                  i = (dst_x + (dst_y + y) * dst_pitch) * bypp;
>                  for (x = 0; x < width; x++, i += bypp) {
> -                    switch (format) {
> -                    case 0:
> -                        d[i] = ~d[i];
> -                        break;
> -                    case 1:
> -                        *(uint16_t *)&d[i] = ~*(uint16_t *)&d[i];
> -                        break;
> -                    case 2:
> -                        *(uint32_t *)&d[i] = ~*(uint32_t *)&d[i];
> -                        break;
> -                    }
> +                    stn_he_p(&d[i], bypp, ~ldn_he_p(&d[i], bypp));
>                  }
>              }
>          } else {
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

