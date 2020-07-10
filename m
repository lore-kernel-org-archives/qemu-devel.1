Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CC2C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 01:43:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D8AE20725
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 01:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+oQlOAk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D8AE20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jti4O-0005N3-Ah
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 21:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jti3s-0004wx-Ex
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 21:42:48 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:45509)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jti3q-0005aJ-UC
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 21:42:48 -0400
Received: by mail-oi1-x244.google.com with SMTP id j11so3498479oiw.12
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 18:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=2TE4peOVWul/YTuw0DycxeKO2DnWH5uCH0QQgszSp5Q=;
 b=h+oQlOAkrnF8nHFBMofwifPEFshswEvGyAmi3NGYo3XvVTM/tQaEP3pE3gLgOVeYu0
 cdZ2Q9ILt4y3QYZ8e2+boDEtl6ER2kCmXnbRvUhWcZ8uO0F5W2uU0kiQsSErNfwtWIc4
 P2g6bg8hQhenDV43mGHO3bJSriDMifAPzI2y9+lD6DM2c1girVksIxJ0CVXyDxuccD6g
 Olqh2Gjd5luPxOgwkXBkkn9NrSOf9q82sBAiT+qnDhRGUV0GL5pB0gEkTb6ZD6NO2EB5
 xYOtwEyJTinO2BJU6u4xouA+GHdhVzwaccpj/TDSFORiRZBYl4R44iaufb2RClTf3oO0
 0FSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=2TE4peOVWul/YTuw0DycxeKO2DnWH5uCH0QQgszSp5Q=;
 b=gZQCpJr3Sv+DialJp7ye1Z9R92+oMyIbxqbssQbiH/tgIgMuKp1QM11Hhi+iJHGzSQ
 hFs1zKq3iIohCaoZTmAdSR/Mx2PwUyjqzPI1FW0bArP9I38Dma3+0sf/0QUwET+9kwLJ
 Oce4a7npteIKv7B5GFEJRm+DTl4u4EcjUq1IW8ilEu8/GjpH2bxjshk3WBhSTnuTQlpD
 lLTyc5C5r8X9Kzpg02/oYvdsjnQf5uBHk3bPYrDnT/QJNnoQKoL1HCdxdw56ZddMNREA
 A5VWoDvm1MZbXIRkH8gvCSAyh8TxlIDCFZM1gfaey7aCMAYb2PP4emOZhwOWU/Xx8m02
 8JOA==
X-Gm-Message-State: AOAM5323/xlmEkpSf99Sr96reu8ai8vIAesMzf5taMgqpuszVjzEGNWo
 7zWcZyjaKmPUJp+VhvDnE8ZW+SdoyfY5lWOEJAA=
X-Google-Smtp-Source: ABdhPJzBDZeUJuWDi16jAlUjbraU/nAL/3XQwEtJFtCEk/LkEil6HodE1IoWJysRWlVryBpDtxSINKMjKYHhGFrX/z8=
X-Received: by 2002:aca:494d:: with SMTP id w74mr2533124oia.97.1594345365399; 
 Thu, 09 Jul 2020 18:42:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200709175848.650400-1-ppandit@redhat.com>
In-Reply-To: <20200709175848.650400-1-ppandit@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Fri, 10 Jul 2020 09:42:09 +0800
Message-ID: <CAKXe6S+=uvPGAFO7DSdfmvtQp9vtHn1p9djhwZiwiMXkaTiCMA@mail.gmail.com>
Subject: Re: [PATCH] 9p: null terminate fs driver options list
To: P J P <ppandit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>, Greg Kurz <groug@kaod.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

P J P <ppandit@redhat.com> =E4=BA=8E2020=E5=B9=B47=E6=9C=8810=E6=97=A5=E5=
=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=882:01=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> NULL terminate fs driver options' list, validate_opt() looks for
> a null entry to terminate the loop.
>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
>  fsdev/qemu-fsdev.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fsdev/qemu-fsdev.c b/fsdev/qemu-fsdev.c
> index a9e069c0c7..3da64e9f72 100644
> --- a/fsdev/qemu-fsdev.c
> +++ b/fsdev/qemu-fsdev.c
> @@ -78,6 +78,7 @@ static FsDriverTable FsDrivers[] =3D {
>              "throttling.iops-read-max-length",
>              "throttling.iops-write-max-length",
>              "throttling.iops-size",
> +            NULL
>          },
>      },
>      {
> @@ -85,6 +86,7 @@ static FsDriverTable FsDrivers[] =3D {
>          .ops =3D &synth_ops,
>          .opts =3D (const char * []) {
>              COMMON_FS_DRIVER_OPTIONS,
> +            NULL
>          },
>      },
>      {
> @@ -95,6 +97,7 @@ static FsDriverTable FsDrivers[] =3D {
>              "socket",
>              "sock_fd",
>              "writeout",
> +            NULL
>          },
>      },
>  };
> --
> 2.26.2
>
>

