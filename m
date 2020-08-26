Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF8BC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 10:17:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6724820786
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 10:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jjwl6MId"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6724820786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAsUL-0004QS-N3
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 06:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kAsTS-00031l-5D; Wed, 26 Aug 2020 06:16:10 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39939)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kAsTQ-0004zT-8S; Wed, 26 Aug 2020 06:16:09 -0400
Received: by mail-ot1-x343.google.com with SMTP id e23so269789otk.7;
 Wed, 26 Aug 2020 03:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=B8xG5RlJvyOHoSk0yY3k6K12U3qnr4Bcj+P1T+wfO6A=;
 b=Jjwl6MIdGlmSHVbzgI302POMFKYzFQQCPgkn6TPESfWjTbS0v4slr180W+Btkhpxtw
 WDmoAKxdMrZ8gQu+43OBx/xqhuoI2kH4YKcIKu0MG+Yy1hNNlacz4YGwXgU7lTJIfpwb
 wN4SdQWNleMGxUfcK8+HXGSc4TuboK8uXMdEz2f1cHfVrAmsiGvPYcAXyjo4QZRzc/Jy
 I1jss8JWx3qxvMmFUi9Rr7vtH/fmyh4XRvmABBJrU58rNjsgR10Biy3p2OCX+LRaw+9w
 vmnTKtCWID+vzFTtXpLkt0YuIvOeccgmC/G6GgrcWfEOW2gDy5kWPJ0rEWG/D0pAcMBO
 +68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=B8xG5RlJvyOHoSk0yY3k6K12U3qnr4Bcj+P1T+wfO6A=;
 b=jv0KIDuY4jyIIzQXNKe3T4Thp0jTeOf1kTm2DNaXzxBKgzbAM2ZTeqcNmm9kHCF4xz
 1oJ/GXa+JhJ0NuW7DTEd/QFiZx5avIXd2jqMDuS3kdsFYFnKPFGFbRHMuBpL33XfzSq5
 kk3cJxVghlf4iiTCtf3n+JOa65G2eEaJoauoeo1DgFPq1r278uW7qcf5lCImBTJVKMlr
 ZwemnPstIWnpCGYrFGMdtv3f/oU8wtY64y8LrTk86sD1xpnJuV9QYnC7IJ1FYqOLCp/y
 49xTpZoHwhlhiabA5//v1K86rKcxsghcEe+17mnd71jWZAi5+LuQCd7rvJJX22FUzt7c
 /guw==
X-Gm-Message-State: AOAM530MaOFlyEL7fe+IiosOCm1NS5EZI8VH+UkBcXgPkYHukXNeE1IX
 D1+4PAOO1bd5D+HwT+qXuXCyXlHbkquzixzrpfI=
X-Google-Smtp-Source: ABdhPJz8oYkkGpVcqh0wvp/7ZXpCNAZU/exTnnvPQ/YFPtK2pa0/lEsN2zdAaMf01VrKylTWgnIdl01X0F6P3hDQ9EI=
X-Received: by 2002:a9d:788:: with SMTP id 8mr2771347oto.181.1598436958078;
 Wed, 26 Aug 2020 03:15:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200825112447.126308-1-kuhn.chenqun@huawei.com>
 <20200825112447.126308-8-kuhn.chenqun@huawei.com>
 <CAKXe6S+BBKztHmBG0TLRTJH6bDntyz4=mWpgccctaZgYWn_TdA@mail.gmail.com>
 <7412CDE03601674DA8197E2EBD8937E83B8E23ED@dggemm511-mbx.china.huawei.com>
In-Reply-To: <7412CDE03601674DA8197E2EBD8937E83B8E23ED@dggemm511-mbx.china.huawei.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 26 Aug 2020 18:14:59 +0800
Message-ID: <CAKXe6SJFM44vxgY+YDtv9sL1pb1ekmT_L0sDQ1a6iV1diSoeDQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] vfio/platform: Remove dead assignment in
 vfio_intp_interrupt()
To: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x343.google.com
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
Cc: Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Pannengyuan <pannengyuan@huawei.com>, Qemu Developers <qemu-devel@nongnu.org>,
 Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Chenqun (kuhn) <kuhn.chenqun@huawei.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8826=
=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=889:47=E5=86=99=E9=81=93=EF=BC=
=9A
>
>
> > > Clang static code analyzer show warning:
> > > hw/vfio/platform.c:239:9: warning: Value stored to 'ret' is never rea=
d
> > >         ret =3D event_notifier_test_and_clear(intp->interrupt);
> > >         ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >
> > > Reported-by: Euler Robot <euler.robot@huawei.com>
> > > Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> > > Reviewed-by: Eric Auger <eric.auger@redhat.com>
> > > ---
> > > Cc: Alex Williamson <alex.williamson@redhat.com>
> > > Cc: Eric Auger <eric.auger@redhat.com>
> > > Cc: Stefan Hajnoczi <stefanha@redhat.com>
> > > ---
> > >  hw/vfio/platform.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c index
> > > ac2cefc9b1..869ed2c39d 100644
> > > --- a/hw/vfio/platform.c
> > > +++ b/hw/vfio/platform.c
> > > @@ -236,7 +236,7 @@ static void vfio_intp_interrupt(VFIOINTp *intp)
> > >          trace_vfio_intp_interrupt_set_pending(intp->pin);
> > >          QSIMPLEQ_INSERT_TAIL(&vdev->pending_intp_queue,
> > >                               intp, pqnext);
> > > -        ret =3D event_notifier_test_and_clear(intp->interrupt);
> >
> > Shouldn't we check the 'ret' like the other place in this function?
>
> Hi, Li Qiang,
>
> Eric=E3=80=81Alex=E3=80=81Stefan has already discussed this point in the =
V1 version.
> https://patchwork.kernel.org/patch/11711897/

Ok I see, then

Reviewed-by: Li Qiang <liq3ea@gmail.com>

Thanks,
Li Qiang

>
> Thanks.

