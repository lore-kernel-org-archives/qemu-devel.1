Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED05C433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 12:04:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FD4620772
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 12:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iApAfUaX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FD4620772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg5er-0005xk-PV
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 08:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jg5ds-0004gM-93
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 08:03:40 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:35990)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jg5dr-0002E7-1l
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 08:03:39 -0400
Received: by mail-lj1-x243.google.com with SMTP id a25so12266128ljp.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 05:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=j5XdDYRRw8K1y6ZywUeRYaNKnFznjuHAv/+VVbq/JQE=;
 b=iApAfUaXuoQeZu/V7HxEi7M4bhiOPV/ckIH8tdqZntybbdEoVz9+HIasMIbQYLpAji
 V/YuwiGaMdk7zd2zB0PdfTmiYSi3h6rGgRQpkxOw+vEQcGuPgvaWOhWDdIHaiVxc7+pY
 tVh/J5B1ru0oeU/z1dJhO7VpK1oVX9Dsah4F/SWtcshzu2mxm30dqjkzNvIyV+xdHI9h
 wK0d2H58O48uZZAO7AyByKLlorfi4eQmfSJ24gtNcmAnXqASjytb9efv77dzR4Q1sAJ5
 Htd1tWiIKJ7P7FBUWI8KfgtksoQgRz3A9+tF8kCkul0vnpSKAbBSfSyT2haW+mefnHXd
 YXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=j5XdDYRRw8K1y6ZywUeRYaNKnFznjuHAv/+VVbq/JQE=;
 b=scZQEeQJDkLYCJRdZg2u4uN6ecoLk10dCPxhcySZcW8lxsiGqOLa6RLQYeHnfGOmmh
 +y1p07ptdQJTwuIejTaB6W1hMCyCl4l8i2cswzzHEypi9p9OheOKs377Wxh8aEVx5Kx0
 nyBFmqvlW1KLHg4ay580EqKLzcPermoduDBy5S2BV5VzGAPmnHUbl/4wh4/VTtHqLGkP
 20znKoqIhhOcegJ+ostdYT8Q/6T3zxe2+BFgP9cRfm5B5SgoOupKNwsqrc4nQ6Xo+oB4
 0/NtYvpl8zwzFffpJqTJ4N7YzIydEeigZyOZQWx/pdyajIGZtiw2dqsFRjeicx+Nrkyb
 C81A==
X-Gm-Message-State: AOAM5327kavF0IrEwJndAaGJ8+TRbz8aF8obP6cfPJPUCKXFa41oxbTA
 YiWRKNSBkqbn7rF2TS54YLyJpETYoo00BYIkN8E=
X-Google-Smtp-Source: ABdhPJwJTzXghyTdbcjGxSw8bUSpyTaQgKl5AjA2nFXWskELrH9vugEy7cbqh7jwjt3UBATu9coN3eMi3BBG6jdnB5Q=
X-Received: by 2002:a05:651c:1103:: with SMTP id
 d3mr3422984ljo.110.1591099417001; 
 Tue, 02 Jun 2020 05:03:37 -0700 (PDT)
MIME-Version: 1.0
References: <1591065557-9174-1-git-send-email-chenhc@lemote.com>
 <1591065557-9174-5-git-send-email-chenhc@lemote.com>
 <740b3c2e-926e-27f2-e334-abed9aa87575@amsat.org>
In-Reply-To: <740b3c2e-926e-27f2-e334-abed9aa87575@amsat.org>
From: chen huacai <zltjiangshi@gmail.com>
Date: Tue, 2 Jun 2020 08:03:21 -0400
Message-ID: <CABDp7VpjFidHJsKkcPBLLiHXm0DS4P0PkvN6t9PFrPiJOwu3XA@mail.gmail.com>
Subject: Re: [PATCH for-5.1 V4 4/4] MAINTAINERS: Add myself as Loongson-3
 maintainer
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=zltjiangshi@gmail.com; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Huacai Chen <chenhuacai@gmail.com>, qemu-level <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 2, 2020 at 4:12 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> On 6/2/20 4:39 AM, Huacai Chen wrote:
> > Signed-off-by: Huacai Chen <chenhc@lemote.com>
> > Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > ---
> >  MAINTAINERS | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 0944d9c..c42a218 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1092,6 +1092,11 @@ F: hw/isa/vt82c686.c
> >  F: hw/pci-host/bonito.c
> >  F: include/hw/isa/vt82c686.h
> >
> > +Loongson-3
> > +M: Huacai Chen <chenhc@lemote.com>
>
> Jiaxun Yang, do you mind being listed as reviewer here?
>
> R: Jiaxun Yang <jiaxun.yang@flygoat.com>
>
> At any rate:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>

Replying on behalf of Jiaxun as he had some difficulties on receiving this =
mail:

I'm very glad to become a reviewer of loongson3 machine.
I'll continue to work on Loongson-3 TCG support soon.

Thanks.

> > +S: Maintained
> > +F: hw/mips/mips_loongson3.c
> > +
> >  Boston
> >  M: Paul Burton <pburton@wavecomp.com>
> >  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
> >



--=20
Huacai Chen

