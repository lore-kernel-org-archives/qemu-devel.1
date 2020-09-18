Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4473C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 12:42:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59EB4208B8
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 12:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tBZmxHmm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59EB4208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJFin-0005Km-AZ
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 08:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kJFhj-0004Bm-Va; Fri, 18 Sep 2020 08:41:33 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:37315)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kJFhf-0004ix-Jt; Fri, 18 Sep 2020 08:41:31 -0400
Received: by mail-ot1-x343.google.com with SMTP id o8so5239079otl.4;
 Fri, 18 Sep 2020 05:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=RfoFIQ3BH7e/fWVNyiH8kKGPwrQpt0OuogqTRvvAgyM=;
 b=tBZmxHmm46WmPOihaZWHR0HeH+GmN3ADektpvyXJmo2o+cF1Y2FIrxHqLCREe9HBCJ
 aG9faTBQsIciHqr9VT/h4k+1mES0EZBNi83ICX6h5D/nSjUpUaXCnLJp48qWjtpkSv5C
 B+1NdT5RHWaYxU4YUIhBy2+v3UIHBj+bYuIQ9wRitNwIwBY6nQXinnY94BCN/jskHMGS
 135/bH7ZYOG8iB0dE0QQW2Z909PFrvT7/NSLY6ZbV02pJum8ha0jj6wUmk+N86FOR9ia
 D00w50zKb9/W636N7Un7kGYNoY1A5NZKOWNVhmpUKhBwAs2wJwsUYhBsxAfRwrNSAWmv
 ceMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=RfoFIQ3BH7e/fWVNyiH8kKGPwrQpt0OuogqTRvvAgyM=;
 b=oca8kuf8ABZyVjjwaXcMnp1pxaCvo3dyOQR4AXid9wv9yVDiHSjYAX0oeNtbLQ5194
 o0MSCr6N0tZERhR51k7YHIQhUvorW6a9+RDlZf7IoYpJn5WCgajLTxYD/TvgzCaUziKl
 N9FvWl3EzAgnlypoHmbkuKur5WiFrSa+U0jtfGF8C5xvvK9Idw0ghKhd8EZGmAxRwvY+
 34Ptwg7N1QjCN5n7MhBpuoSKC/aVzO8sMch191QgfVNLVJ3bDm6ZtMGMdEKR5elV+7pU
 UC573tpdcEFwgEkoHsGXTEZ5UmHa4jF7QPJhiw6jAmE/yU4HJ0foL+uV71OPnhZjBuY4
 yuMQ==
X-Gm-Message-State: AOAM533dKffPJn4HWP4SjyOk58AO71nKWrThAYfcZBfw8/EdvY4MPog2
 lYcQdM6gQlG3BHPVMGeKEJ/7zdAUbWRZqJ2yhuM=
X-Google-Smtp-Source: ABdhPJwPc/dycmkXje87kFh8Ztd035U6VocrjFCCix4m65lWld1tS3rcxq9M39f2UbvZgu7f2Un2AbTOtmHePl5Y79c=
X-Received: by 2002:a9d:5e11:: with SMTP id d17mr22026428oti.333.1600432885481; 
 Fri, 18 Sep 2020 05:41:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200918120301.729794-1-lvivier@redhat.com>
In-Reply-To: <20200918120301.729794-1-lvivier@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Fri, 18 Sep 2020 20:40:49 +0800
Message-ID: <CAKXe6SJFGWHq6j8bdQ3JtRisL2zQHLf8ctipEM+TtRRuZdCC9Q@mail.gmail.com>
Subject: Re: [PATCH] vhost-vdpa: don't check g_malloc() return value
To: Laurent Vivier <lvivier@redhat.com>
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
Cc: qemu-trivial@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>, Cindy Lu <lulu@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Laurent Vivier <lvivier@redhat.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=8818=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=888:04=E5=86=99=E9=81=93=EF=BC=9A
>
> On failure, g_malloc() aborts the program, we don't need to check the
> return value
>

In fact, I have sent this one month agon.
-->https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg04444.html

If you use this you can add my R-b tag:

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  hw/virtio/vhost-vdpa.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 4580f3efd8a2..23a4a957ef77 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -321,9 +321,6 @@ static int vhost_vdpa_set_config(struct vhost_dev *de=
v, const uint8_t *data,
>      int ret;
>      unsigned long config_size =3D offsetof(struct vhost_vdpa_config, buf=
);
>      config =3D g_malloc(size + config_size);
> -    if (config =3D=3D NULL) {
> -        return -1;
> -    }
>      config->off =3D offset;
>      config->len =3D size;
>      memcpy(config->buf, data, size);
> @@ -340,9 +337,6 @@ static int vhost_vdpa_get_config(struct vhost_dev *de=
v, uint8_t *config,
>      int ret;
>
>      v_config =3D g_malloc(config_len + config_size);
> -    if (v_config =3D=3D NULL) {
> -        return -1;
> -    }
>      v_config->len =3D config_len;
>      v_config->off =3D 0;
>      ret =3D vhost_vdpa_call(dev, VHOST_VDPA_GET_CONFIG, v_config);
> --
> 2.26.2
>
>

