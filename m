Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2310BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 08:37:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5E932177B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 08:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XwrtDKoU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5E932177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA7z5-0000Vk-8p
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 04:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kA7yR-0008Cf-Rk
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 04:37:03 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633]:40054)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kA7yP-0004TV-Vv
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 04:37:03 -0400
Received: by mail-ej1-x633.google.com with SMTP id o18so10789645eje.7
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 01:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jc6NaVM19xN9+ux52ByDJ/zbCTsSU8iQx9lfrlnTC2A=;
 b=XwrtDKoUyCUiGe3dLjDzyPZaDPS9LQ4ezlbzcGIKJIoKS9njN5AMZaKPCCNo7vP2Ue
 oly8jQ6k4Cw1/6mftjJ+jsdkGy/HS0Nn/ajawCc0BUHP7Hu5+dXcu7sSaEWN3z+L+qhd
 oOhkJgU25sLH+PvPZJrVj3l3XbWiqyupJHD3TMCVutoUs/TvOYFjhwZImlS6Yr1B74lr
 kLonXQu8Qldlk1VrG3xbjUgnAJZy5RXMlB4w6+77sxWaDq44amIXsgnG0CJ+IbTAv6+M
 0tGM6VjJiSGK3W2MmDrSf5QjEvcT977owI2AtBPrtA4D8uZ14E7/0G3I0j0vNXmRNq8a
 Mvug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jc6NaVM19xN9+ux52ByDJ/zbCTsSU8iQx9lfrlnTC2A=;
 b=riLvPsdU6gJLl52lE4tEnZ15d9zAzOOHOB+adxDuTEaASwwh5eMIAPFsIUXkQdvPES
 P4kbIDYMmTonNIkW9Uhmc4NqaiK8SHPJDrK697kFpkXeeP9Lt3P4431kEtypsKmfg2UQ
 Z31rw9M+HQ2XhHu/9kejXRBoJwZMJ+YlbnH45OoUoQdAd8i5Y9ah51o6K5k1pLDg9x5Y
 DbsHINvDtAQIQyl22reMpCUbCL3f3sx0VMvCEZpg4xsucDcaxDHhRNlWFwnzCzLB06dw
 L7md9BoRCaBFnkkXmG29c6GYeJvBj6K+Carv2A8gz/W6KirGLXDXSKMo8TTMr8+a9TNm
 zmWg==
X-Gm-Message-State: AOAM533fHV1KsdXLGTwrlFljCfTPFphKhRb75oR5bphoOeqq2J1nmGk4
 JD3ZrPBUFhIDVoG4f5Lc2vFdfHokMRlpV1ipif9fSg==
X-Google-Smtp-Source: ABdhPJxU9R9RPU263uwGg4kwNRrz8AleR9tAoPOPwqBt+LT/pfSIsjydvm3ji0rLLB1IZ+7RUugyS29aEgLDnmJ9wuU=
X-Received: by 2002:a17:906:b814:: with SMTP id
 dv20mr4516063ejb.4.1598258219778; 
 Mon, 24 Aug 2020 01:36:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200818041922.251708-1-david@gibson.dropbear.id.au>
 <CAFEAcA_=qV+B17Z=XZhaPK_dvhBOkGutNmCHYEP4xTYKnzukZw@mail.gmail.com>
 <20200823232101.GD4734@yekko.fritz.box>
In-Reply-To: <20200823232101.GD4734@yekko.fritz.box>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Aug 2020 09:36:48 +0100
Message-ID: <CAFEAcA-CFQ9Uw_exsasfm+cOY0ODov+APMY_M1VFQKXv84KnpQ@mail.gmail.com>
Subject: Re: [PULL 00/40] ppc-for-5.2 queue 20200818
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x633.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-ppc <qemu-ppc@nongnu.org>, Greg Kurz <groug@kaod.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 24 Aug 2020 at 00:21, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> On Sun, Aug 23, 2020 at 02:54:26PM +0100, Peter Maydell wrote:
> > Hi -- it looks like you've updated the tag but I haven't seen
> > a new cover letter. Do you want me to apply it?
>
> Um.. I've updated the branch, but the tag should still be the same.
> I'd suggest merging the tag, since that's what I did my testing run
> on.

Ah, I was confused because git is smart enough to apply
the changes to foo.inc.c files in the pullreq to the
renamed foo.c.inc files in master; I mistakenly assumed
that you'd done a respin to handle the renaming. Anyway,
I'll run the tag through the merge process.

thanks
-- PMM

