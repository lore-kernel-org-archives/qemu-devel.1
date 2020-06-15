Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7BBC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 15:24:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 107D02071A
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 15:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oc47d7vH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 107D02071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkqyJ-0006N1-Co
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 11:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jkqxV-0005aw-Mj
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 11:23:37 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:43554)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jkqxT-0001hK-Ne
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 11:23:37 -0400
Received: by mail-oi1-x244.google.com with SMTP id j189so16179305oih.10
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 08:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UXeRwxsN9VMVrO10b0Rps17TPQVmQA1XEK+lg2Tb28k=;
 b=oc47d7vHg1Q8dkPdm7gGcFwUkudFZz95J2TW7bkNEB2t05W+1KBW9iL/fgxh2P34t3
 BlIE3z+gpxvtjbm/jBLytJkAaatAyTX5O5OTKJCJBYJUUmpAYkhnWkv2u/wMa3zPm8b7
 NNpolbQEUpq4pcvhZsKFhCWeDkcZ/NHv+f3sX8oT8Uxo7okmCfTYwCYUPfsnKQBSw9SY
 g21wfN98TRRxOb33fudUN0TGY5ekcJaGhTFTle++cPK1K6aJUCr4XWJGzkU1ogHM4k0Z
 qzRdQREED3dtxHJ7RIjaoyro9LYyyVvRmQPAaOFZK6yj0PO+XlYUMkUDMrmcULabA6eG
 VnGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UXeRwxsN9VMVrO10b0Rps17TPQVmQA1XEK+lg2Tb28k=;
 b=fMXiiNa9C86fTKwsR9vEuiB12965Xf/SeNLuJWc8D0+tI8ALUlHGYTz+UNYwPY4Nag
 e3Yw2u/3M1KvbeQiCto2hWUg4Ddzr0CzCLwL6ojNFmhxWHEKwVPjA1U9vjeQ9yTmX+06
 o8y1PD/Zd6+L/15+VoRMN2+kcuWuMoHHO85GZ3KiyjTziTZe81FSSsYTxsC6zRLY9wB4
 I/jTXpXeay5yrtp44PVO/yK5zg7QpO8KbRdKLXpS95PlgL9I2Mve2x5PQB+SnS6k7nt+
 ezmkBtPCUf8weeAk5/kBJP2LZZNQcoxS785CyQLZtiAYvVxbBtsOrlyrwryyeOuwJ0WQ
 ENYA==
X-Gm-Message-State: AOAM5323q1odCb5MiyB//LVeRv//FU842IP5ud97usYVSMjjOXOs+QHA
 Fe9wZ+XweWENW6zg6TpHp9/RZZrjhX80Zyw1O1dVYw==
X-Google-Smtp-Source: ABdhPJyBRu3Fp3FTVBwOtEJrTD2MZjdiV8gyw0C4BuneH5i7QXgHd/gJtcoIcBP+4JwMBEH+Le9BpR8TbvlatSP0z0s=
X-Received: by 2002:aca:1a07:: with SMTP id a7mr9278125oia.163.1592234614507; 
 Mon, 15 Jun 2020 08:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1591471056.git.balaton@eik.bme.hu>
 <acb431de2d9c7a497d54a548dfc7592eb2b9fe1c.1591471056.git.balaton@eik.bme.hu>
In-Reply-To: <acb431de2d9c7a497d54a548dfc7592eb2b9fe1c.1591471056.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jun 2020 16:23:23 +0100
Message-ID: <CAFEAcA_WemGUp0YTitXvChsFPzZjOts04zTp2-aPgmFxTC5NXA@mail.gmail.com>
Subject: Re: [PATCH 1/4] sm501: Fix bounds checks
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

On Sat, 6 Jun 2020 at 20:22, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> We don't need to add width to pitch when calculating last point, that
> would reject valid ops within the card's local_mem.
>
> Fixes: b15a22bbcbe6a78dc3d88fe3134985e4cdd87de4
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/display/sm501.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

The calculations for sb/se/db/de all have a term which
multiplies by (width + pitch), which makes me suspect
they also need a similar fix ?

thanks
-- PMM

