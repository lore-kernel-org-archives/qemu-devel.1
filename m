Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AAEFC2BB55
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 13:31:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A0BE20775
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 13:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MZISFk0+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A0BE20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOi8k-0002A1-BK
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 09:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35879)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lee.jones@linaro.org>) id 1jOeHO-0001P5-EC
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 05:24:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lee.jones@linaro.org>) id 1jOeHN-0006Bq-13
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 05:24:22 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54349)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lee.jones@linaro.org>)
 id 1jOeHM-0006BE-2I
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 05:24:20 -0400
Received: by mail-wm1-x341.google.com with SMTP id h2so16527400wmb.4
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 02:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=25hsR70J4xkR7QjWib9TX4C/RIJl6X5HgsLKdDMfcIM=;
 b=MZISFk0+SGdYrIGleUjYyNyFlKlBZtpvcsFKyJMVxKBrgMGYtPYkcBrS4bRdkEp/7t
 IW0OdNkkEzJjOHq32c8nyyFfVBOA0CWrvJjsIloNh7+9VO5CUroLlbNB3EdfC+VubzHW
 RKiPdet4ElIC56WiuMenvtixe2coFc0mPjdD569+2OT9S+0GbYhuHmAMDdAJ2/wquaHH
 afuwBSmcYlb9MymeQAxl6jMcXisGmnphb0nXiXzgHpPoKvx7ynmkS1jh5aDHDA3xUcag
 t1mwgvkRTAPwn/Ml63NOIpJfKAurHTPzOMenfettsfMf8meyF+86UE6hMxa9KMhNgPe7
 /dqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=25hsR70J4xkR7QjWib9TX4C/RIJl6X5HgsLKdDMfcIM=;
 b=bNQRMG5EOtAko2Tp5iHDmdi9rPIKJ59ceh5S0G/hYwdKa81cOtsRp49QssyZqClnpx
 qairPkU2lqGvd9TdRnj8oEiSs3CWYurZSJ8VLiyriR1sABCB+n/s0HEnB90lgAnJTYNr
 j+uRFOQQHcWT/n0Hgf2wzQGrGL/9tpj1v6HIRXNLQ2GuPKYo4fdUT2NwEZw4oEJLZEOi
 43dVsLgJ9JFkI4Kn23GOQmLMLBNIgVSGFelBAEI/LdNzL6up7gbs+x5SBq9TGFOQOyCJ
 zTbc2CJeaiqIt+E5whSKFmg0UBuj/gUED2il3H1OFjZMv7ho1OGldVkRD7poy1guy1Nj
 Dm1w==
X-Gm-Message-State: AGi0Pua02zQ+xTZPh8S8gXCulz5un4SuWT63YH8/pdYPbuOyM+d1VN2H
 Hea0L2/IQ4IR/Q47UnlVi5pekA==
X-Google-Smtp-Source: APiQypI1L9Xj03pMeY/s2kTnKETE0bYjImrIZAgEBCHLd+qOzGsuktY5U9KyEtfeFWAbhU8Q4g0UeA==
X-Received: by 2002:a7b:c10d:: with SMTP id w13mr4131241wmi.78.1586942657950; 
 Wed, 15 Apr 2020 02:24:17 -0700 (PDT)
Received: from dell ([95.149.164.124])
 by smtp.gmail.com with ESMTPSA id e1sm12258399wrc.12.2020.04.15.02.24.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2020 02:24:17 -0700 (PDT)
Date: Wed, 15 Apr 2020 10:25:17 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v6 3/8] mfd: sm501: Use GPIO_LOOKUP_IDX() helper macro
Message-ID: <20200415092517.GF2167633@dell>
References: <20200324135328.5796-1-geert+renesas@glider.be>
 <20200324135653.6676-1-geert+renesas@glider.be>
 <20200324135653.6676-3-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200324135653.6676-3-geert+renesas@glider.be>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
X-Mailman-Approved-At: Wed, 15 Apr 2020 09:30:42 -0400
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Phil Reid <preid@electromag.com.au>, Jonathan Corbet <corbet@lwn.net>,
 Marc Zyngier <marc.zyngier@arm.com>, Linus Walleij <linus.walleij@linaro.org>,
 linux-doc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
 Christoffer Dall <christoffer.dall@arm.com>, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Rob Herring <robh+dt@kernel.org>, Harish Jenny K N <harish_kandiga@mentor.com>,
 linux-gpio@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <graf@amazon.com>, Eugeniu Rosca <erosca@de.adit-jv.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 24 Mar 2020, Geert Uytterhoeven wrote:

> i801_add_mux() fills in the GPIO lookup table by manually populating an
> array of gpiod_lookup structures.  Use the existing GPIO_LOOKUP_IDX()
> helper macro instead, to relax a dependency on the gpiod_lookup
> structure's member names.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lee Jones <lee.jones@linaro.org>
> ---
> While this patch is a dependency for "[PATCH v6 4/8] gpiolib: Add
> support for GPIO lookup by line name", it can be applied independently.
> But an Acked-by would be nice, too.
> 
> Cover letter and full series at
> https://lore.kernel.org/r/20200324135328.5796-1-geert+renesas@glider.be/
> 
> v6:
>   - New.
> ---
>  drivers/mfd/sm501.c | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

