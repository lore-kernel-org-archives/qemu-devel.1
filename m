Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718DAC43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 01:38:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D90420708
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 01:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s8vN1r3s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D90420708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kF671-0002dQ-8S
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 21:38:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kF66P-0001nh-KB
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 21:37:49 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:46943)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kF66O-0005Xk-4A
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 21:37:49 -0400
Received: by mail-oi1-x243.google.com with SMTP id u126so12227399oif.13
 for <qemu-devel@nongnu.org>; Sun, 06 Sep 2020 18:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=KMqFlgvLIYEjgTpdNvETa0bzYJVsFSDhNYnkFR8oZcs=;
 b=s8vN1r3s079qSSNVf2UOeEoZCXtNpXGVlmlYeoczxIkWJtdyfXDJV0ra5us2a5fiiU
 ejQewCLxRaDUQKQWuOCiAuVf/5BDZ6q00CDGf5Gkm6/hHsEdyOwg1PgPfmNsLyBF6J/d
 b5uWe/hS7r5irTXv4ZsW4FZJLeMniejxlc9p6mQ39wPZEr041FmwI4ZhmMbsjq6i6bFx
 GMkTRtgSJWC9mbACfJ2uoSmdsZSLGoxJwzh+6eCsTyz++8UWl9Fr5yFvGkf57+1uRuLy
 k+4eRMh4Ibv6rJSaP4vNiHQZHwH58VuMf4MefsxFKWGD+z7CSL+40OzlqBPVacQWQR+n
 3jOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=KMqFlgvLIYEjgTpdNvETa0bzYJVsFSDhNYnkFR8oZcs=;
 b=cCv6L+VX0ViN7Q3hu9H5vwWzROvbKblqQhOLgvvZxl32PfWsE3L8UobLIqdJ1RKUU7
 1cTFI9hBlCJ+FCYObIGDwJlw7VlezAHqGf6XOVULDX1pH/lBrko50JzJ1j/wk3NHY1YJ
 m2Ugecviw/zjM219WogzSrujNdl5cny07PpP+0kVW0zzroBu44mM3ea4tNQb14ox3DiL
 cFulDBGLxaYq6ZhgofM4urNMj1nZZw9fdA4bonekPAT/Qh6VoDxakzSwESDBjXPkIzNW
 o0ceIh2vkYvalH+Erxs2uUw67QtQsAvOhDauyAcaL6h1xbTC7cXKG0fBOWF33lmssTVJ
 06pA==
X-Gm-Message-State: AOAM532utPYI08OoSEhQXwtrpcGAz87nUTJBUaZzd9Myf+hJ5mvqvDLv
 0Qk6+ANOG102hDHaq8wP8tX34KO591MIILD6haw=
X-Google-Smtp-Source: ABdhPJz5k6Pi4JZXeR+Lob/EGUAjdlhPUwR9JZfVvLtdzi4gnOdg6thGzDyu2xrBwIXIl4K57rx34M9JIcN1qnmx+/A=
X-Received: by 2002:aca:904:: with SMTP id 4mr2941434oij.97.1599442667230;
 Sun, 06 Sep 2020 18:37:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200813165125.59928-1-liq3ea@163.com>
 <CAKXe6SL3myrx1XcoOVxkD6RxpDMRiOOVorXQrfPnShC0+Y6WUg@mail.gmail.com>
In-Reply-To: <CAKXe6SL3myrx1XcoOVxkD6RxpDMRiOOVorXQrfPnShC0+Y6WUg@mail.gmail.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 7 Sep 2020 09:37:11 +0800
Message-ID: <CAKXe6S+r1SNCBm_daBRqX-m50rNPwRHR_ZmuxdBoU_Mum-oesQ@mail.gmail.com>
Subject: Re: [PATCH] hw: virtio-pmem: detach the element fromt the virtqueue
 when error occurs
To: Li Qiang <liq3ea@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x243.google.com
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
Cc: Qemu Developers <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping!

Li Qiang <liq3ea@gmail.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8828=E6=97=A5=E5=
=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=889:21=E5=86=99=E9=81=93=EF=BC=9A
>
> Kindly ping.
>
> Li Qiang <liq3ea@163.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8814=E6=97=A5=E5=
=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=8812:52=E5=86=99=E9=81=93=EF=BC=9A
> >
> > If error occurs while processing the virtio request we should call
> > 'virtqueue_detach_element' to detach the element from the virtqueue
> > before free the elem.
> >
> > Signed-off-by: Li Qiang <liq3ea@163.com>
> > ---
> >  hw/virtio/virtio-pmem.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/hw/virtio/virtio-pmem.c b/hw/virtio/virtio-pmem.c
> > index 1e0c137497..ddb0125901 100644
> > --- a/hw/virtio/virtio-pmem.c
> > +++ b/hw/virtio/virtio-pmem.c
> > @@ -77,6 +77,7 @@ static void virtio_pmem_flush(VirtIODevice *vdev, Vir=
tQueue *vq)
> >
> >      if (req_data->elem.out_num < 1 || req_data->elem.in_num < 1) {
> >          virtio_error(vdev, "virtio-pmem request not proper");
> > +        virtqueue_detach_element(vq, (VirtQueueElement *)req_data, 0);
> >          g_free(req_data);
> >          return;
> >      }
> > --
> > 2.17.1
> >
> >

