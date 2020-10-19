Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57535C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 15:54:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9545222282
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 15:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T+sudBLu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9545222282
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUXUb-0003AO-Iz
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 11:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUXTL-0002Oo-45
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 11:53:19 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:38327)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUXTI-0008CY-Mr
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 11:53:18 -0400
Received: by mail-ed1-x542.google.com with SMTP id i5so10772105edr.5
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 08:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=95O/YztrrfmXurKw31pxwsR5r0M1r8oBwrgqkEDQGh0=;
 b=T+sudBLus23otzQIWoLnmQQeBQu4IYrcFV8glbKNYE4N8JHo7wTOUQ9N+d4nRNcnYc
 CHvj2ckQ+Rcyru4Fg3OoKEjdF2vOtBtiGGcoE5RqoVQVD61hRSeiy1FWophPwgkVR8mE
 0vjznLlsjL3SY2BfLOqiI+mpJ7wU+HX2dXjtNzdSxjroMwVLGgvTJm3jgIOPw3VpTH7v
 rFDaAd7Of4gUxs2xP5W+TYpyZ5N3lODZLg7pJrL601s0GR7VogkF0HdLhT4BnRnBlbLq
 iGg8iOaA+qpnVV61Q35QJxBCRX/g+vhFPa43KkQPcoZCHG4VlO+FBKtJlkUV6fka+Mho
 lxcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=95O/YztrrfmXurKw31pxwsR5r0M1r8oBwrgqkEDQGh0=;
 b=P6bjzsO+SF2kh4bKNhNj/ALZ96X1J6ehyYAJINsE8xbdw0v45Oe8ENRmKIM0Z9mfHy
 N8GsVJYL9DTod4c7VRq8qN3pEy4rZ9pm+/PZ2Y9JN9bpBRH2rFdKn3IkMQgjDTkrIAjT
 Oh25mFPlWygQdQBPhYvbL0lsvwudlkwcy40ROZsfLMEziu6GE76Yhx92gzGNxKERGeka
 NQTPxyJJpS/CcaJ3S/KVu9ZrcbXqaYHuDmjl1lMx57tv/UpR5hRCmegKYHwDs2vlaqKY
 31Ng0gGe5Qm5AFwLvjqYDPfGiySWv+VQjyTnZv+0aEbMf3iCy5a9y+fzAii/uT6dG2zU
 cblw==
X-Gm-Message-State: AOAM532KJvYr5K3HcB5cjCncDK9flZEApMVm1fXQ8usChF4zL+jVPelB
 ClQy4Vf+602UBF0ISaI3H52dscMP6ImZSxBx/JDVhA==
X-Google-Smtp-Source: ABdhPJzOP6/Gjc/EQb/TXEgZA8Pa5NxPcu2U0w7Z/D0pgKX2/BO7wz85Z1S4VvFWFDOu3oKpykz1D3PVwA3h7tsgY0k=
X-Received: by 2002:a50:c34a:: with SMTP id q10mr511987edb.36.1603122794935;
 Mon, 19 Oct 2020 08:53:14 -0700 (PDT)
MIME-Version: 1.0
References: <20201019112628.1653550-1-f4bug@amsat.org>
In-Reply-To: <20201019112628.1653550-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Oct 2020 16:53:03 +0100
Message-ID: <CAFEAcA92ah6O3uTESb98GF2F98ASmiQy9UqyNMOOLZPZaX40zg@mail.gmail.com>
Subject: Re: [PATCH] hw/misc/bcm2835_cprman: Make cprman_internals an included
 source file
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-arm <qemu-arm@nongnu.org>, Luc Michel <luc@lmichel.fr>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 19 Oct 2020 at 12:26, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> bcm2835_cprman_internals.h is only include by bcm2835_cprman.c
> and contains various static array definitions. Make it an
> included source file (using the .c.inc extension).
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> I'm sending this on top of:
> [PATCH v3 00/15] raspi: add the bcm2835 cprman clock manager
> to avoid a respin before soft freeze.
>
> This patch can be queued or squashed on top of patch #08/15:
> "bcm2835_cprman: add a PLL channel skeleton implementation"
>
> Based-on: <20201010135759.437903-1-luc@lmichel.fr>
> ---
>  hw/misc/bcm2835_cprman.c                                        | 2 +-
>  .../misc/bcm2835_cprman_internals.c.inc                         | 0
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename include/hw/misc/bcm2835_cprman_internals.h =3D> hw/misc/bcm2835_c=
prman_internals.c.inc (100%)
>
> diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
> index 7e415a017c9..9d4c0ee6c73 100644
> --- a/hw/misc/bcm2835_cprman.c
> +++ b/hw/misc/bcm2835_cprman.c
> @@ -48,7 +48,7 @@
>  #include "migration/vmstate.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/misc/bcm2835_cprman.h"
> -#include "hw/misc/bcm2835_cprman_internals.h"
> +#include "bcm2835_cprman_internals.c.inc"
>  #include "trace.h"

I guess so, though usually we only use .c.inc files
where we actually need to multiply-include them (eg
with different #defines to control how they expand).
I suppose there's softfloat-specialize.c.inc which
only gets included once.

Applied to target-arm.next (not going to try to
squash it as it would make applying the following
patches in the series a bit awkward).

I am going to move the #include line down so it's
not in with all the includes for the .h files.

thanks
-- PMM

