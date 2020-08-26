Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34E9C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 01:39:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CAB72072D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 01:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tbgNj3Iy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CAB72072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAkPN-0007Le-Vs
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 21:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kAkOk-0006vW-AN; Tue, 25 Aug 2020 21:38:46 -0400
Received: from mail-oo1-xc44.google.com ([2607:f8b0:4864:20::c44]:46592)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kAkOh-00024z-UK; Tue, 25 Aug 2020 21:38:45 -0400
Received: by mail-oo1-xc44.google.com with SMTP id r6so78725oon.13;
 Tue, 25 Aug 2020 18:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=mwWExfqR1cZ+WdH+CcHQFPtm0abNw0zaCrpDyZHD8Hk=;
 b=tbgNj3IyhKgqtl6FFhy6yTWCHuxaT1WlPdHL0uePEdOYNBpeVJTJOcUMR3nmLAlKbU
 WhBz0iVNFGwc+8WQ4sThKd9RXnVaL8d3vGRXwftGs7TRMjHYxdb4G66ndVSIzVOU3MLj
 DEv3DXmGn6/9CMskgWQH6Zq7Kn6CnFOk/apw6wMJ50mPhHw2CMTHc6TIfz86fp4yhdli
 pL6LAW646V/01MAuZpWeAyMcq5hWLQ6toGU40xM2SFwEJe8tOM8lsjbYwOiPG1OKhYDQ
 FbEsbnOn/JuMPY5x6YGYqMMixeVIxWpjJtZSHVXBJjJAFXcjWin/HjCvKToNj3OStskO
 Zs8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=mwWExfqR1cZ+WdH+CcHQFPtm0abNw0zaCrpDyZHD8Hk=;
 b=aO06cly6Nr3BKydQMtpsI45jsFZRF542AZ8i490nhNt3TB71soWR6B9SlgaDrLbc1B
 cRkH36xMLzc+2tHQoKSXyI89QR9DuTldq+EpelddSmjCfIjxjugyzlST32UFZDFfTBIl
 6xL4Ltd/7Mh18iz7rRqUYqyccEK7mCHZDJwzuUjQB6ZTSQ29sBaxyDsSWq4SLKG3U3oL
 0vk/uMAuFDGvJqz6M0bUCOvXkjsa9yeBf5pNSbsQ1d5QG6sPuCam7SjvDBzqk2LlLdjg
 Swq3CvicG2ci+oOMRo/gJ3o/UiM/6FnrbiJYQPweCkqe/m/qyc3XEfvv3X+qVrTWyagy
 bysA==
X-Gm-Message-State: AOAM531m6y9VuRFh0o1oS1maRsg/thMmi0bHh94UANbezWrNUrDTtDf6
 1Akt3XcZZY4mc9PsniHISVsfcBpPKzhERK18RVg=
X-Google-Smtp-Source: ABdhPJw+A6teYU152k068AY15I+EevRooMFjQcGN0weScmqWXNbFOs+qe6wOcjN409eDYJ1cAZIWEGC1+WDeNXhU824=
X-Received: by 2002:a4a:be0c:: with SMTP id l12mr8963853oop.22.1598405922478; 
 Tue, 25 Aug 2020 18:38:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200825112447.126308-1-kuhn.chenqun@huawei.com>
 <20200825112447.126308-8-kuhn.chenqun@huawei.com>
In-Reply-To: <20200825112447.126308-8-kuhn.chenqun@huawei.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 26 Aug 2020 09:38:06 +0800
Message-ID: <CAKXe6S+BBKztHmBG0TLRTJH6bDntyz4=mWpgccctaZgYWn_TdA@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] vfio/platform: Remove dead assignment in
 vfio_intp_interrupt()
To: Chen Qun <kuhn.chenqun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c44;
 envelope-from=liq3ea@gmail.com; helo=mail-oo1-xc44.google.com
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
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, qemu-trivial@nongnu.org,
 Pan Nengyuan <pannengyuan@huawei.com>, Qemu Developers <qemu-devel@nongnu.org>,
 Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Chen Qun <kuhn.chenqun@huawei.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8825=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=887:31=E5=86=99=E9=81=93=EF=BC=9A
>
> Clang static code analyzer show warning:
> hw/vfio/platform.c:239:9: warning: Value stored to 'ret' is never read
>         ret =3D event_notifier_test_and_clear(intp->interrupt);
>         ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> ---
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hw/vfio/platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
> index ac2cefc9b1..869ed2c39d 100644
> --- a/hw/vfio/platform.c
> +++ b/hw/vfio/platform.c
> @@ -236,7 +236,7 @@ static void vfio_intp_interrupt(VFIOINTp *intp)
>          trace_vfio_intp_interrupt_set_pending(intp->pin);
>          QSIMPLEQ_INSERT_TAIL(&vdev->pending_intp_queue,
>                               intp, pqnext);
> -        ret =3D event_notifier_test_and_clear(intp->interrupt);

Shouldn't we check the 'ret' like the other place in this function?

Thanks,
Li Qiang

> +        event_notifier_test_and_clear(intp->interrupt);
>          return;
>      }
>
> --
> 2.23.0
>
>

