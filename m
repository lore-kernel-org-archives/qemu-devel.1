Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A23C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 14:57:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4E3920644
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 14:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zvJLd0vp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4E3920644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkqXs-0000lY-Vr
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 10:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jkqX4-0008Jw-W3
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 10:56:19 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:34627)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jkqX3-0003NV-AW
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 10:56:18 -0400
Received: by mail-oi1-x244.google.com with SMTP id b8so16174902oic.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 07:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YgzdpVm/2eXpwErT7aSgjwYh2pWwvfLxy1ZTrm52rcM=;
 b=zvJLd0vpsRL+eBWjEjcJ0Pv6xrc6132JKWZXbiVd3EefmuHoeJ8w4Xj2qEpqn1XlZv
 SUC23Vnstw3vxE9jJza887UAJN6Viab3W5iiXYWlyacB6PKb0vsxlToGHYCy09Y4qAUk
 0gGdYmz+0vO16vBkOvBJ4oEmsLeIULBUVTkkIqE+zd8n1R1BkGpdZB9WMbdxzjNVglo+
 IxH4j98UA5H0+xO1uKJt/i1xT6pixMO/SA84MPvosvXjPa30w3oqa7Kn+Jus2jTm7lF0
 /VASvlcF/I4UChLJnNW0UKxJIY4afRgeVTR/0fiGbcMcaZoeBuQ97+uirShlp8TESTMJ
 8Qzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YgzdpVm/2eXpwErT7aSgjwYh2pWwvfLxy1ZTrm52rcM=;
 b=hB/Z+hwQ9agHlX9SlU+DcNIqdo7Tl6nO/qv4RKLxD9BXLRCyrWK2XQlTUJ0DWXQWUp
 IUYakASPn0T/FvZolhKTJfoMZWWNLtpGWBtYXxfNzVJCHcrDI8US5itrT7110LHmiqhH
 lqSNsD9F+2JmJRnwKZNddgO5hYZaSJmZFjKXL/nOJsy1BV1Glpik2MvScufmAi/OISoE
 SdLDRFmkeM026O1w0L/otwoZpRu/b7xorOzCkypc1clCw8oFobHnxlgkSPZ23Fp9q6QD
 7pBJBfPO1RSF6bDNqcmumWw92HZ6TsoAObd8cOLDb+kba5OtBMzey/dGKgfNB00gfZQf
 cD0g==
X-Gm-Message-State: AOAM5311kPMyYdjWKA0CSCSDA/gelv2jInrWqCkqRNGal0EiqbIDZaBp
 T1xRguFvqhy5QWAb1covgCDgCNpSnpLtmerfMOD0Bg==
X-Google-Smtp-Source: ABdhPJykiHZw2O1MZ/DshEq7L/SvFe8U5EJ+t61AspdNEWQtOrfbzolOauHwEJqhExirbOMBoHLUHVK1AW4gOQoMYAM=
X-Received: by 2002:aca:5152:: with SMTP id f79mr8895471oib.146.1592232975940; 
 Mon, 15 Jun 2020 07:56:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1591471056.git.balaton@eik.bme.hu>
 <b62681e58108651b2ca0d2fdbde8281e87185dbb.1591471056.git.balaton@eik.bme.hu>
In-Reply-To: <b62681e58108651b2ca0d2fdbde8281e87185dbb.1591471056.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jun 2020 15:56:05 +0100
Message-ID: <CAFEAcA_PoKT3RxidPuSoUy9=3-yUC82bn1dJpEpkqVq0VS06Cw@mail.gmail.com>
Subject: Re: [PATCH 3/4] sm501: Ignore no-op blits
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
> Some guests seem to try source copy blits with same source and dest
> which are no-op so avoid calling pixman for these.

Are they doing actual source copy blits, or one of the other
currently-unimplemented op types which we currently fall
back to doing as source-copy ?

> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

