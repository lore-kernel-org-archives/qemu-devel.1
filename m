Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6658C76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 07:43:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A29A02084C
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 07:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjVYtrbe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A29A02084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoNYD-0005wA-IM
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 03:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38179)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hoNY3-0005R3-T8
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 03:43:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hoNY2-0001HL-Th
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 03:43:23 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:33544)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hoNY0-0001Ei-NN; Fri, 19 Jul 2019 03:43:20 -0400
Received: by mail-oi1-x242.google.com with SMTP id u15so23619539oiv.0;
 Fri, 19 Jul 2019 00:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=ZEhjQqYWJlC1PXZc+ba2fnfuvQnzfPZPJBfzLHYeKVU=;
 b=EjVYtrbeYjNMRIXoQxqrF8N+6yDhWxLToEY/ctQJFZHl6/PbVvByuWG4c0Nm04kFom
 qqrMYy69K6zkErJb2DTf17XP88v4QpkFz3WtXO5NpF98C8+Cpa2uWyhGzZ2LpMgt2SoX
 +yMAEevHrN3dhmhQFOYmBnryCAZSaMgYkhW1YqtkxoFZcA/x2NH3Hyzi7h+JjXV4ffQl
 lg6nTbH4HGb/afFOseGudVZFiVcrbJSWM9VVD8QgCvKsu0koJKVU6NRNgCcm1nY2AuZr
 Uz1Tn4xpR9rpK/YTWmPW8SqwuBlYYZOgJHf8kW4v+BxLYA4N9HPo2PBYF8fp8xkbRoWp
 oY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=ZEhjQqYWJlC1PXZc+ba2fnfuvQnzfPZPJBfzLHYeKVU=;
 b=K0H+brCFmJ/LsPT9ZcowDoaijApVfpK7ZD2KsVyIJmg/0d5vQkYmXYsiD3mXRxpcQk
 GBMpgJb4injWlz+3O4Z1ixaEhGCsKIMIjnmc80cLVe0R7SSjDFXTrecDKcZ6OeJoq4M8
 nzeWPFukaSB1VBjDCqP7gCm4DU5TkDWqrTYtOD3sKvdubwziXPCj0La9hziMsPtvc0Sb
 8hX28gwPIaCvVMDi4PRuSfHWs4E8JK/dLpR7mGFGkHZtPW7sTqrfVH2T5ckDd9YV7k3c
 wA14Ag/TNoX0pI5KOVw1CgRAUZUreFS3FBVAzMAXaGgky71FJwI2d8g0nw5yHEzqa/L/
 yazg==
X-Gm-Message-State: APjAAAXuqTXPbYZ3kRCCLPAulFYSixO10Pd7TpkGxVc0T7CxvI0KlAmU
 Xf71q7Qmbtdq3rg71PgpWyFTlAZsZhDKdcx/jnM=
X-Google-Smtp-Source: APXvYqyDgIXcyylHtkArMTjKUJCy+I6XVWvIhExG3e4rgXQlPoEWG7yj5hLJj47gxXnlo5V5oGAONTooKSdviXQSbmo=
X-Received: by 2002:aca:4083:: with SMTP id
 n125mr25055633oia.106.1563522199050; 
 Fri, 19 Jul 2019 00:43:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4798:0:0:0:0:0 with HTTP; Fri, 19 Jul 2019 00:43:18
 -0700 (PDT)
Received: by 2002:a9d:4798:0:0:0:0:0 with HTTP; Fri, 19 Jul 2019 00:43:18
 -0700 (PDT)
In-Reply-To: <6241fd95-789f-f560-2170-0544cded1720@redhat.com>
References: <20190718193441.12490-1-sw@weilnetz.de>
 <6241fd95-789f-f560-2170-0544cded1720@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 19 Jul 2019 09:43:18 +0200
Message-ID: <CAL1e-=h01=ouAuTiPK7mGqCJVX4C-WQUEVZngFBG5nthDQ936g@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH] audio: Add missing fall through comments
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
Cc: qemu-trivial@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jul 19, 2019 9:30 AM, "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com> =
wrote:
>
> On 7/18/19 9:34 PM, Stefan Weil wrote:
> > Signed-off-by: Stefan Weil <sw@weilnetz.de>
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>

Philippe, how do you test these comments?

Yours, Aleksandar

> > ---
> >  audio/audio.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/audio/audio.c b/audio/audio.c
> > index 5fd9a58a80..a7a13e900a 100644
> > --- a/audio/audio.c
> > +++ b/audio/audio.c
> > @@ -304,6 +304,7 @@ void audio_pcm_init_info (struct audio_pcm_info
*info, struct audsettings *as)
> >
> >      case AUDIO_FORMAT_S16:
> >          sign =3D 1;
> > +        /* fall through */
> >      case AUDIO_FORMAT_U16:
> >          bits =3D 16;
> >          shift =3D 1;
> > @@ -311,6 +312,7 @@ void audio_pcm_init_info (struct audio_pcm_info
*info, struct audsettings *as)
> >
> >      case AUDIO_FORMAT_S32:
> >          sign =3D 1;
> > +        /* fall through */
> >      case AUDIO_FORMAT_U32:
> >          bits =3D 32;
> >          shift =3D 2;
> >
>
