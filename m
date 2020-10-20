Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93ABC388F2
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 20:33:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E33E122247
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 20:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KF9JLbcK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E33E122247
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUyKM-0002l1-QC
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 16:33:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUyJJ-0001u6-Th
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 16:32:45 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:44611)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUyJH-0007wG-SO
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 16:32:45 -0400
Received: by mail-ej1-x643.google.com with SMTP id a3so4700758ejy.11
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 13:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=w6nftQea4QBxC6cEg4nsdSFLiPnljsPKT64/nJzn8Z8=;
 b=KF9JLbcKS/GZgws8pmUT71HNwlp2SJyVyfszAltLBDvd5iRK6kYR0J3Q/R0kPzDRKX
 22zx51m3p9aq7IKgZvzeps8qjfgqfhurqjnzHBGqlqbzDERittcPcRzHfBZiy5eP5JB5
 DUPpXzTGswXPohpdDoX51T//vWVp2h7j9asr+flUaMDJO7E7ONxkb9kI+ArnuvF8dz9Y
 +9ehIAOxOmZ6BrKlVMmy6i8NNxo8Yu0WdiPvPJDBGl3mKOUjups/iGleW12Mh+DirJPN
 7ev1EZxCwT5wzVsIgXAotdrc72fpznNTauT4mj/BJfZp9qXpEYvLLSDHTH7JhoXBSJAm
 G9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=w6nftQea4QBxC6cEg4nsdSFLiPnljsPKT64/nJzn8Z8=;
 b=tX2m/NhUL9DPw/Cw0cn4/aiMod1XBYqBbfWskNVDxmdc12bP8h/Lu6GV9dzp0/FLLX
 Aqga/E4tTyWy98+LW+8ZgHdZNLc9RCYkawHwmEq8CmzbDe4/w7JxwN8GvNd6dXj9qnY9
 pdp/RHI/eEe2upfw2LkBk8JK2UFWp+EQX2x7RvwKKmgIwQBgoGIuGrk1RfknsgXpkk7V
 gyfPfeXoOoWZUSc/277eQaRiSlzTIXOhLfnsctJDH0p1cfWiMLM3Gshru5ZQLynOyBQT
 Qtu36+S4he64lRDB9OvK/FlZMqHYqduf7JnMjNNZaVGK0WZxx3vVOvLu6dLP3aouive5
 HM2A==
X-Gm-Message-State: AOAM5324bt/A8sbGK/vBboNx0vfaOwbzacML/SZzOUvWJvZ2V2z6rxsM
 VgMcaUn+l/NiEBmhcO3dF9XMq3Meikb5y24yeC1fBg==
X-Google-Smtp-Source: ABdhPJylUl2ccUMsiKrAGpi27OWaL7z3ar0Y1k8ynAiFepc5ttE7cfTOGiejlBp//9uz2/JnqYIOHqa2Dh0mHE+Z0JI=
X-Received: by 2002:a17:906:1f42:: with SMTP id
 d2mr4822528ejk.407.1603225961348; 
 Tue, 20 Oct 2020 13:32:41 -0700 (PDT)
MIME-Version: 1.0
References: <20201020182008.2240590-1-f4bug@amsat.org>
 <20201020182008.2240590-2-f4bug@amsat.org>
In-Reply-To: <20201020182008.2240590-2-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Oct 2020 21:32:30 +0100
Message-ID: <CAFEAcA9ibGH9H6W=E4u-29d9Qcdnsv+iUBYawX+B2=7UH09nFw@mail.gmail.com>
Subject: Re: [PATCH 1/4] qdev-monitor: Display frequencies scaled to SI unit
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x643.google.com
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>, Luc Michel <luc@lmichel.fr>,
 Paolo Bonzini <pbonzini@redhat.com>, Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 20 Oct 2020 at 19:20, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Since commit 9f2ff99c7f2 ("qdev-monitor: print the device's clock
> with info qtree") we can display the clock frequencies in the
> monitor. Use the recently introduced freq_to_str() to display
> the frequencies using the closest SI unit (human friendlier).
>
> Before:
>
>   (qemu) info qtree
>   [...]
>   dev: xilinx,zynq_slcr, id ""
>     clock-in "ps_clk" freq_hz=3D3.333333e+07
>     mmio 00000000f8000000/0000000000001000
>
> After:
>
>   dev: xilinx,zynq_slcr, id ""
>     clock-in "ps_clk" freq_hz=3D33.3 MHz
>     mmio 00000000f8000000/0000000000001000
>
> Reviewed-by: Luc Michel <luc@lmichel.fr>
> Reviewed-by: Damien Hedde <damien.hedde@greensocs.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  softmmu/qdev-monitor.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/softmmu/qdev-monitor.c b/softmmu/qdev-monitor.c
> index bcfb90a08f3..1c5b509aea2 100644
> --- a/softmmu/qdev-monitor.c
> +++ b/softmmu/qdev-monitor.c
> @@ -747,11 +747,13 @@ static void qdev_print(Monitor *mon, DeviceState *d=
ev, int indent)
>          }
>      }
>      QLIST_FOREACH(ncl, &dev->clocks, node) {
> -        qdev_printf("clock-%s%s \"%s\" freq_hz=3D%e\n",
> +        g_autofree char *freq =3D NULL;
> +
> +        freq =3D freq_to_str(clock_get_hz(ncl->clock));

I would prefer it if our clock.h API provided a function
for "return a human readable string representing this clock frequency"
(which can use freq_to_str() under the hood, of course).
clock_get_hz() itself is a dangerous API because it may
not be returning a precise result. In particular if the
clock has a period of greater than 1 second (eg 0.5Hz) then
it will unhelpfully return 0.

Having the clock API provide a human-readable representation
for debug purposes means it can internally produce a nice
result regardless of the period, and it's clear to callers
that what they get back is for debug printing and similar
tracing and not suitable for doing arithmetic on. And it
reduces the number of places that call clock_get_hz() which
will make it easier for us to try to delete it entirely.

> +        qdev_printf("clock-%s%s \"%s\" freq_hz=3D%s\n",
>                      ncl->output ? "out" : "in",
>                      ncl->alias ? " (alias)" : "",
> -                    ncl->name,
> -                    CLOCK_PERIOD_TO_HZ(1.0 * clock_get(ncl->clock)));
> +                    ncl->name, freq);
>      }
>      class =3D object_get_class(OBJECT(dev));
>      do {
> --
> 2.26.2

thanks
-- PMM

