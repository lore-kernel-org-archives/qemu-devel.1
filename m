Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3FEC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 16:16:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EFA82225F
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 16:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e5aMnY2g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EFA82225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUXq8-0005vW-3v
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 12:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUXf2-0002Bv-BL
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 12:05:24 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:43622)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUXex-0001ZJ-FA
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 12:05:23 -0400
Received: by mail-ed1-x541.google.com with SMTP id dn5so10805358edb.10
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 09:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Y0F4Dy8wjAXlmgJZ42mM6NFtPD4hAKyMvW1OqoNDMjk=;
 b=e5aMnY2gEaBbZ3GYOIHoFFb2TR+Rm31g44bw+rdcon5qM/ZxLTuJpGIPbJUNWPaOUi
 fqJFW8nD//4/hhExFZ2TTNyrnvHflUhJVjMMBXlxSHMwKxYct2DF9qJHeQlrXl699s2E
 sLqTXe36kM7NOYb9hc9YFoKpH/cmDAVWroojiCC5WzpW6qYBpmgQBlEqaitJy9FdSDbb
 gBlNroqlYm7clQiqv9XLV9W9VkoTvDsjfEi3xDCO3dwds1Obye41czazF4vWNZbIZDA2
 nhKzyxmj3oMBHxZ/fBoOpsjRwUOVplbiIgDzwj5PPR+Sk5jokTtN3vAnpMoU3iEpYehw
 FmhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Y0F4Dy8wjAXlmgJZ42mM6NFtPD4hAKyMvW1OqoNDMjk=;
 b=Nkt1AjHSuvgcz0zIk7g3V4dencW6g1h4KgmCvB7K42wBrFeHEnVsHRdLiMUdfBeqgk
 Q5dYX6UUG4+EPFh+GZjTx3+5D3uzqYqeAfcLpN2LGk5xPgEfd79gwFhFCIfRLV5hScNN
 maZFs//m6f5jKo6PePNH2lWX9kNZbIwojiu3fAZDv+DgeX2Ij3nHYHztCuNlxDADU7ky
 9sGrqfuhaG68KLnSeClLfJlo0aKzOfCoTpneQSDun06Nzhy4nsj2L1qKu2o3ieE66Ifk
 OWMYRNH9zi9XWZG66NjhJFU03Pf3/9KQrfIB8j4cuHd1IlpoSN831ocArUV50yCxnJdh
 zeew==
X-Gm-Message-State: AOAM5303OOSQH7eiJNjjVotQoUL2y2hYOYHuHSEwMQZEISPibEggNtla
 LwYyg7XaAQOGyoQftdKCqzsgvwP7ZgeJ0Cqm6QrxKw==
X-Google-Smtp-Source: ABdhPJzZwD2zoGapJC0ZFIwbSsbjXm+6CJ4arHDW5bCC4KPf9DDJeMR1D4yvCekPmRKOFPCXL/SpeUvzDCKYHVSTqW8=
X-Received: by 2002:aa7:c7d7:: with SMTP id o23mr537553eds.44.1603123516553;
 Mon, 19 Oct 2020 09:05:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200915171639.1355800-1-f4bug@amsat.org>
In-Reply-To: <20200915171639.1355800-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Oct 2020 17:05:05 +0100
Message-ID: <CAFEAcA-YEYbLiDpx37cPF40giyr340Gx+V+Vbx+mdxiDZC_qxA@mail.gmail.com>
Subject: Re: [PATCH v2] hw/block/nand: Decommission the NAND museum
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x541.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 15 Sep 2020 at 18:52, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> This is the QEMU equivalent of this Linux commit (but 7 years later):
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Df7025a43a9da2
>
>     The MTD subsystem has its own small museum of ancient NANDs
>     in a form of the CONFIG_MTD_NAND_MUSEUM_IDS configuration option.
>     The museum contains stone age NANDs with 256 bytes pages, as well
>     as iron age NANDs with 512 bytes per page and up to 8MiB page size.
>
>     It is with great sorrow that I inform you that the museum is being
>     decommissioned. The MTD subsystem is out of budget for Kconfig
>     options and already has too many of them, and there is a general
>     kernel trend to simplify the configuration menu.
>
>     We remove the stone age exhibits along with closing the museum,
>     but some of the iron age ones are transferred to the regular NAND
>     depot. Namely, only those which have unique device IDs are
>     transferred, and the ones which have conflicting device IDs are
>     removed.
>
> The machine using this device are:
> - axis-dev88
> - tosa (via tc6393xb_init)
> - spitz based (akita, borzoi, terrier)
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> Peter, as 4 of the 5 machines are ARM-based, can this go via your tree?
> ---
>  hw/block/nand.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/hw/block/nand.c b/hw/block/nand.c
> index 5c8112ed5a4..5f01ba2bc44 100644
> --- a/hw/block/nand.c
> +++ b/hw/block/nand.c
> @@ -138,7 +138,7 @@ static void mem_and(uint8_t *dest, const uint8_t *src=
, size_t n)
>  # define ADDR_SHIFT            16
>  # include "nand.c"
>
> -/* Information based on Linux drivers/mtd/nand/nand_ids.c */
> +/* Information based on Linux drivers/mtd/nand/raw/nand_ids.c */
>  static const struct {
>      int size;
>      int width;
> @@ -154,15 +154,14 @@ static const struct {
>      [0xe8] =3D { 1,      8,      8, 4, 0 },
>      [0xec] =3D { 1,      8,      8, 4, 0 },
>      [0xea] =3D { 2,      8,      8, 4, 0 },
> -    [0xd5] =3D { 4,      8,      9, 4, 0 },
>      [0xe3] =3D { 4,      8,      9, 4, 0 },
>      [0xe5] =3D { 4,      8,      9, 4, 0 },
> -    [0xd6] =3D { 8,      8,      9, 4, 0 },
>
> -    [0x39] =3D { 8,      8,      9, 4, 0 },
> -    [0xe6] =3D { 8,      8,      9, 4, 0 },
> -    [0x49] =3D { 8,      16,     9, 4, NAND_BUSWIDTH_16 },
> -    [0x59] =3D { 8,      16,     9, 4, NAND_BUSWIDTH_16 },
> +    [0x6b] =3D { 4,        8,        9, 4, 0 },
> +    [0xe3] =3D { 4,        8,        9, 4, 0 },
> +    [0xe5] =3D { 4,        8,        9, 4, 0 },

This line adds an entry for 0xe5, but there is already one
further up in the array (you can see it in this hunk).

More generally, it doesn't seem to match the referenced
kernel commit, which deletes 14 lines and adds 5
(which are a subset of the 14 deleted, really, so
they probably show up for us as "9 deletions" since
we don't have the #ifdef...#endif the kernel does).

> +    [0xd6] =3D { 8,        8,        9, 4, 0 },
> +    [0xe6] =3D { 8,        8,        9, 4, 0 },
>
>      [0x33] =3D { 16,     8,      9, 5, 0 },
>      [0x73] =3D { 16,     8,      9, 5, 0 },

thanks
-- PMM

