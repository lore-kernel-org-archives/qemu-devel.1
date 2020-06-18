Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B857EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 16:44:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 828C120707
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 16:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eqsTlena"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 828C120707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlxeo-0002yb-OU
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 12:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlxe9-0002Wb-Fg
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 12:44:13 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:45094)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlxe7-0004bW-Ol
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 12:44:13 -0400
Received: by mail-oi1-x244.google.com with SMTP id p70so5644925oic.12
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 09:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9TzaLt7/ATNrquZixKwZmWlKnXR4wn+F4yf5qAccTTk=;
 b=eqsTlenav6DTuacyOegNsN1s8kw/pTEbVRDU0mxtmie1f5fHOngcOLlS9O7Q5KF3N7
 qnTWADCaUtwNjH3qbefMkLZyDX1r5WwCK0pPOM4TFr9PU/H1NtfSdUMOor9RrAZLax5f
 QvYj/aQUDUPv+snCCReQUlLb2VgaJX/0WwqQRf16vmf1IzawH4Zny0mCuFLlCW8/ZMDD
 G+zHnLct0hcBYcMw+g9IjuZpSWCDjwrIsstK8iPPgidtB8tuGAmMNEtp/dVQTSQAgwSq
 g+ps5Rzr96Z2e8/At/X+HQXYYAHtKioT6gOln60hY2Mexik+HD1O3sY78QbakRW4xL3e
 3czw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9TzaLt7/ATNrquZixKwZmWlKnXR4wn+F4yf5qAccTTk=;
 b=dqaxLHKkah4FzZM43gbgKrEUpAxHsvpMQOYydHwGMjrgbYfvg38poi9w6e3PXr4qzb
 X1PVFhdp53VjJ4Hme0vIAVvn8VkMuS0tlzPSOogCETGd95rOo9/3HyVhQsQFDp8pPzcG
 rvTKR7kE5hr/5ycTNXDvtiwBC5oQ+M8IQ5y4F5rZweE+Jy3YRW+IfdvHEfYxBj7ryfnj
 oJYbwKRPOO/bGyhRDgvzxBm8aLsgeMMxGEPXT02RIRa4c3xw1UJnyCvHOzQC0/z3jDuf
 N3A4TXogO5y8sK+sZ2Mg2J4+wzGYcugYotHNAz5U3A5DhlEF2CviQlfUXqVMtOXg+phh
 i2AQ==
X-Gm-Message-State: AOAM530A+Mws/t3q2ZpQTYqJ6gdJMGZXJ0s0bR+uumQ+YOY+dC3GcaEU
 UtcYNIk+PSfKWWuVylbeFi7NZ1F5g5+Q+km6YMUXqw==
X-Google-Smtp-Source: ABdhPJxLoYtLa69ufqFE4oTkvd7ntNMssh4boo2H32HIYzXUQL7E+9XYYIeCyA+fOMdSAjJWp24j11n8qzRcpjnmVHM=
X-Received: by 2002:aca:1a07:: with SMTP id a7mr3698873oia.163.1592498650622; 
 Thu, 18 Jun 2020 09:44:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1592266950.git.balaton@eik.bme.hu>
 <40f83f54bd3a4aad12212bbcd73d5466451df38a.1592266950.git.balaton@eik.bme.hu>
In-Reply-To: <40f83f54bd3a4aad12212bbcd73d5466451df38a.1592266950.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jun 2020 17:43:59 +0100
Message-ID: <CAFEAcA-AojbSbXW3C4753euWDHcyzU+TBiQzrOEAh4qZFxc_wQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] sm501: Do not allow guest to set invalid format
To: BALATON Zoltan <balaton@eik.bme.hu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x244.google.com
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
Cc: Sebastian Bauer <mail@sebastianbauer.info>,
 Magnus Damm <magnus.damm@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 16 Jun 2020 at 01:35, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> Prevent guest setting invalid format value that might trip checks in
> sm501_2d_operation().
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/display/sm501.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index 6e914d3162..583a0ff6b5 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -1503,6 +1503,9 @@ static void sm501_2d_engine_write(void *opaque, hwaddr addr,
>          s->twoD_background = value;
>          break;
>      case SM501_2D_STRETCH:
> +        if (((value >> 20) & 3) == 3) {
> +            value &= ~BIT(20);
> +        }
>          s->twoD_stretch = value;
>          break;
>      case SM501_2D_COLOR_COMPARE:
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

