Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A35C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 11:40:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63FD5206E9
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 11:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IOp7Q2zc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63FD5206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsPTh-0000RZ-4H
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 07:40:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jsPST-00076o-HB
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 07:38:49 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:39460)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jsPSR-0002O7-2c
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 07:38:49 -0400
Received: by mail-il1-x143.google.com with SMTP id k6so32557166ili.6
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 04:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=kAjOy405mdzvOiXwIbBWwCtYghiu1SkzlY2tU/CuGr8=;
 b=IOp7Q2zcU2UXTXBkKne9A6A3vCCTT4/calpX1l6rd/MeiT6WbpxL1D2B4ohKyAwiV2
 XYDWwgNnxeQR43FLRxt7ukDiPKNwwyikW6spovqdw7CFIeoLuoz0mh1sU7uT4HhF7faI
 agwFqoww9dCj1rpuK8AZNgeBfLvBYurkWOYdR88L2322Nt5PHlxZNhg8JeKqOhmhaZyk
 aBe0Bt0Mp4qdsqGHOueOPeT6joGQTeyNDeT3blu6zBzP6MoE5Nxet1NiRY8RDcCVEdWs
 /D8NKwnAoeEcPKK3OcPabRi5FNvKdZlZLA4i4Kp4u46CR/o/F3XFYUvnh0WobFcfoMgG
 lKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=kAjOy405mdzvOiXwIbBWwCtYghiu1SkzlY2tU/CuGr8=;
 b=Y8NF2M9WIdXukXLub/xz0dqwS6iDr+5To4rZPhBttkZEDgl/QBRCNHktV/uUhfZkf5
 VuQIhgtTE5cdqfmrjKgf3en0uj6Tv152R5VfBlU8pHjX7WUXg8Lwxe7/HYubzAtOgYRB
 ZDH/25fzvbUT2T4zRTmU5kHCDq7vjNLatleayf4dGrpoavh08Ca0WwIBtwSqRaWL5R9b
 vBOXTds7/jec0KQoY6WslJJVYqLssTApDOBIWxjSf5vyTOB1ewGVOm6EOhCwZCoseXYA
 KimqRUKfM0Dfp1y9Wh1Sye9/H4207IZR2E3gcAXqtsfa9wRxjxY2dGfyiIsDNMQ1h+/5
 KAgg==
X-Gm-Message-State: AOAM5318hvHxUrc1YQME7uPek1xX3t7pNUw6ysCYlXxtYaFbcHqi1u3J
 xqrdgZvM2b+/++KBGi9KSjQcbTsaUW5j6f8L4xflcg==
X-Google-Smtp-Source: ABdhPJxKtoT4aeLs8U6JypVPenfh4gH1Nfbf7qBR+ljZ743fY/bBeLrVg04lhyox593+8yjpBQmSHyuuf8HUy1QDSMM=
X-Received: by 2002:a92:d3c7:: with SMTP id c7mr30315954ilh.292.1594035525479; 
 Mon, 06 Jul 2020 04:38:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200703200459.23294-1-f4bug@amsat.org>
In-Reply-To: <20200703200459.23294-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Jul 2020 12:38:34 +0100
Message-ID: <CAFEAcA93Ak+OBuUJ_tmevFB+-rsfQTxdXqSKNmvt_Wbg6Hr2fw@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/bcm2836: Remove unused 'cpu_type' field
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=peter.maydell@linaro.org; helo=mail-il1-x143.google.com
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
Cc: qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 3 Jul 2020 at 21:05, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>
> The 'cpu_type' has been moved from BCM283XState to BCM283XClass
> in commit 210f47840d, but we forgot to remove the old variable.
> Do it now.
>
> Fixes: 210f47840d ("hw/arm/bcm2836: Hardcode correct CPU type")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  include/hw/arm/bcm2836.h | 1 -
>  1 file changed, 1 deletion(-)
>



Applied to target-arm.next, thanks.

-- PMM

