Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2842C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 14:53:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B77221941
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 14:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gL62vsCw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B77221941
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIYnz-0003Wv-6q
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 10:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kIYnT-00034n-Do
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 10:52:35 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:43309)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kIYnR-0000VC-PR
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 10:52:35 -0400
Received: by mail-oi1-x241.google.com with SMTP id i17so8389014oig.10
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 07:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=nNBE75ohZA67vAGi/2O1+PoVlyoMMJEPgiuI0+uR2u4=;
 b=gL62vsCwYBw6slJk+UlGFwYb8mw5YUp9XQQqdbhraUTvEvKKF5zwAPsYKX5t7mhpAq
 v40h/QreSkdEB8EKQTefRIL/QfXjMAxCE50C/iw+5UJPBMgFeAQzdb2LHX0YRewNyDiw
 +CKREZ9ArWbf9oNznB88oi275jacX6K7q2JlZFM+N1Hu2Xj/MvpvhUt0CjE4ie98QjO3
 QBupm0bjIqMcMvJyu06UzZwdaDU/M8lSLc4ok6UJjIq4Y11MAJNCzwBnvMOdv5uMlxMK
 W3XMuul5gNdriqO9XG0ZoD+FLWVuEYp2rZv8vliGpqtLdiNgJE8sboe718CGOk432lfX
 lxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=nNBE75ohZA67vAGi/2O1+PoVlyoMMJEPgiuI0+uR2u4=;
 b=CZB6/JpR1ku2VJ1GPSuBTrHHZ2l3ShfSEfeeocv0luzyWvfxGR02EvH7QINLO5o9QJ
 PCfCu1wNW0V/RpfoMtGakk1hWmOEZF5JIZPsuTzhBsiRfT70i7Niuz6oyuseTbLS/L12
 ike17z5anS2KDjJQVD35aoqcnJB/HxqTFiQd3/GvCKq37oMeDfnHKbiHFU7I9xa7LJgP
 050/oQzDlB+p6aU5GS2tSp3sFiHgB7kt9ycY8TSpXmrrBolY27PGh/Hg7tjYbuM4x5S3
 vZwl5s/DQK26x/1fZLFdNdCUBEAxLjT3VgHRIA1BZizxrYu8OlwwjbMY+4JlurXxeOHA
 iogw==
X-Gm-Message-State: AOAM531Em6gC62g2Ts+8GqDioC+KgZrFW8yIm+vx6JI1IZIeTP1iQLVM
 rkeC6a0R88jJPyAW5VdJk5ym2kDUrDB2g3VtB5k=
X-Google-Smtp-Source: ABdhPJwgW6bfzSi/I8S2Pz4AnyaFd245pAP5NNt/0IvWm5eDzaTW/gsJ9HG8JdDwviu9qe4FFErQ7HHNHPSzx25Rk+c=
X-Received: by 2002:aca:904:: with SMTP id 4mr3501477oij.97.1600267952554;
 Wed, 16 Sep 2020 07:52:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200915182259.68522-1-ppandit@redhat.com>
 <20200915182259.68522-3-ppandit@redhat.com>
In-Reply-To: <20200915182259.68522-3-ppandit@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 16 Sep 2020 22:51:56 +0800
Message-ID: <CAKXe6SJOtqiegYRCF6pPbVcWU_Fq0mSBG=iHbvkei47J+6UPXA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] hw: usb: hcd-ohci: check for processed TD before
 retire
To: P J P <ppandit@redhat.com>
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Yi Ren <yunye.ry@alibaba-inc.com>,
 Yongkang Jia <j_kangel@163.com>, Gaoning Pan <pgn@zju.edu.cn>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

P J P <ppandit@redhat.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=8816=E6=97=A5=E5=
=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=882:25=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Prasad J Pandit <pjp@fedoraproject.org>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

>
> While servicing OHCI transfer descriptors(TD), ohci_service_iso_td
> retires a TD if it has passed its time frame. It does not check if
> the TD was already processed once and holds an error code in TD_CC.
> It may happen if the TD list has a loop. Add check to avoid an
> infinite loop condition.
>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/usb/hcd-ohci.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> Update v2: one patch for loop issue
>   -> https://lists.nongnu.org/archive/html/qemu-devel/2020-09/msg05145.ht=
ml
>
> diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
> index 9dc59101f9..8b912e95d3 100644
> --- a/hw/usb/hcd-ohci.c
> +++ b/hw/usb/hcd-ohci.c
> @@ -691,6 +691,10 @@ static int ohci_service_iso_td(OHCIState *ohci, stru=
ct ohci_ed *ed,
>             the next ISO TD of the same ED */
>          trace_usb_ohci_iso_td_relative_frame_number_big(relative_frame_n=
umber,
>                                                          frame_count);
> +        if (OHCI_CC_DATAOVERRUN =3D=3D OHCI_BM(iso_td.flags, TD_CC)) {
> +            /* avoid infinite loop */
> +            return 1;
> +        }
>          OHCI_SET_BM(iso_td.flags, TD_CC, OHCI_CC_DATAOVERRUN);
>          ed->head &=3D ~OHCI_DPTR_MASK;
>          ed->head |=3D (iso_td.next & OHCI_DPTR_MASK);
> --
> 2.26.2
>

