Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31433C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 01:36:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D0E620870
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 01:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nG2A0R3W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D0E620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS9ET-0001Gs-KO
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 21:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kS9DY-0000Y8-3n; Mon, 12 Oct 2020 21:35:08 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:33136)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kS9DW-00043K-Et; Mon, 12 Oct 2020 21:35:07 -0400
Received: by mail-oi1-x241.google.com with SMTP id s21so2939408oij.0;
 Mon, 12 Oct 2020 18:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=NOFing49imywzzhVPhtIgDX26Ol2Ld3+DP3zmaUkJig=;
 b=nG2A0R3WHHvU3sEN3LrUJ8dCGW82aBshBlysSuIasVh5mh3ZM/RLcAG7mCeiowy900
 2AvL1RthJ1aSWLwUETFG6jVxm8f5NAvgK/LvpfvBMndl9hledOdH0i0FPY9g98SMerT9
 Op8SFVKmRdffg+oBICNBeTHnkeXT1Z1HtZqb0JyLXmabPycNdCateimm0aOeX2I73PKa
 bxIytxXu7EK8N4NfBu1hd0k64yZmM6FGkFcfGagNmznNMe2S95iUCp0stNAe3BWkYz/8
 3WeAaTZ9aCssihDk/E6Jt9xrvUkIUWpU7sGnaYhNC0K7PRq8pRM+dKeMDW74dSm585gJ
 nwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=NOFing49imywzzhVPhtIgDX26Ol2Ld3+DP3zmaUkJig=;
 b=nfAxCsKRmXxSIVV8807yXk9wk9e2eMyZ9dDf6ES9le2GxP06NT8Cxbdvk/K/cqDBzr
 ib/TxbbyF1LWexY4axiWwXJyDKOuBMZWF85cIyCvn037MOdMwZo+6ln53IC33JSqF6Ha
 75I/7fPb0u63GED+lM2MzwRk0IoC/7OP0xovMZlcXItChJfUaLeYf1fhFprSLjLxrRtP
 YG1y3HudPsq4otsjRHeT8ky005okLWlKAlewlfEXD7qIgR6efG+b4DOV3+YZeRj+nkw+
 7WzNrsJZYfDJCTfvuUFGpbvCYGAb0bbu8mhYVn9KJvUMVykV2Ku/WTmgCSjCODc3T444
 KT3g==
X-Gm-Message-State: AOAM531ajhQOLiR4D1wPijWt4Ulj5Ryb99c87i8nIXOQuhwtTJBNj7yt
 TJlrR3g/GEE41pAMb37yZGehwztY8v85E0H7Un0=
X-Google-Smtp-Source: ABdhPJzyRyHh7bvHV1qwUUQLGBltWmEI+wAff88eUQQxgnzojFULx1WWr/wfsRKkZjYG85O9nY7/bAS/mKMr7+NlT+s=
X-Received: by 2002:aca:6183:: with SMTP id v125mr1341693oib.97.1602552904224; 
 Mon, 12 Oct 2020 18:35:04 -0700 (PDT)
MIME-Version: 1.0
References: <20201010110730.1575180-1-kuhn.chenqun@huawei.com>
 <2b2bc826-0785-66e2-3515-b98abfac26ca@vivier.eu>
In-Reply-To: <2b2bc826-0785-66e2-3515-b98abfac26ca@vivier.eu>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 13 Oct 2020 09:34:28 +0800
Message-ID: <CAKXe6SL8fRN=-iqFEiHeWqZm0F+T+8vkc7qJeUz6izQcZQ2Q-A@mail.gmail.com>
Subject: Re: [PATCH] migration/block-dirty-bitmap: fix uninitialized variable
 warning
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x241.google.com
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
Cc: Fam Zheng <fam@euphon.net>, ganqixin@huawei.com, vsementsov@virtuozzo.com,
 zhanghailiang <zhang.zhanghailiang@huawei.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, qemu-trivial@nongnu.org,
 Qemu Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Euler Robot <euler.robot@huawei.com>,
 Chen Qun <kuhn.chenqun@huawei.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Laurent Vivier <laurent@vivier.eu> =E4=BA=8E2020=E5=B9=B410=E6=9C=8812=E6=
=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8811:33=E5=86=99=E9=81=93=EF=BC=9A
>
> Le 10/10/2020 =C3=A0 13:07, Chen Qun a =C3=A9crit :
> > This if statement judgment is redundant and it will cause a warning:
> >
> > migration/block-dirty-bitmap.c:1090:13: warning: =E2=80=98bitmap_name=
=E2=80=99 may be used
> >  uninitialized in this function [-Wmaybe-uninitialized]
> >              g_strlcpy(s->bitmap_name, bitmap_name, sizeof(s->bitmap_na=
me));
> >              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
> >
> > Reported-by: Euler Robot <euler.robot@huawei.com>
> > Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> > ---
> >  migration/block-dirty-bitmap.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bit=
map.c
> > index 5bef793ac0..e09ea4f22b 100644
> > --- a/migration/block-dirty-bitmap.c
> > +++ b/migration/block-dirty-bitmap.c
> > @@ -1084,9 +1084,7 @@ static int dirty_bitmap_load_header(QEMUFile *f, =
DBMLoadState *s,
> >              } else {
> >                  bitmap_name =3D s->bitmap_alias;
> >              }
> > -        }
> >
> > -        if (!s->cancelled) {
> >              g_strlcpy(s->bitmap_name, bitmap_name, sizeof(s->bitmap_na=
me));
> >              s->bitmap =3D bdrv_find_dirty_bitmap(s->bs, s->bitmap_name=
);
> >
> >
>
> I don't think it's correct as "cancel_incoming_locked(s)" can change the
> value of "s->cancelled".
>

Hi Laurent,

You're right. So I think this can simply assign 'bitmap_name' to NULL
to make compiler happy.

Thanks,
Li Qiang



> Thanks,
> Laurent
>

