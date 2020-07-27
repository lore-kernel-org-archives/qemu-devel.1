Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D385C433F2
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:39:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03BF4206E7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1aEADQ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03BF4206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k04HO-0003uJ-9O
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 10:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1k04GY-0002ce-AS; Mon, 27 Jul 2020 10:38:10 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:36097)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1k04GW-0001wC-V8; Mon, 27 Jul 2020 10:38:10 -0400
Received: by mail-oi1-x244.google.com with SMTP id s144so4584208oie.3;
 Mon, 27 Jul 2020 07:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=NqnmO5m4f6KLp7y2Sqo4eQ7ncsiIIY83YKWr8V6ikSo=;
 b=K1aEADQ03rrQyFaaUQyQIxBysSGblWgAO3rEkmx1I9RIag/GqkeKdIqzU6aCJfyETa
 kILGV82UgJkhcM0Cg7GnSDt6UZXQacaEnDFVQPGnS96if/RD5iMY/SPTJgcdfP5UulBy
 O92k27UzpMwqTptK3aoFcn1ihcRFw6xmDXH9qyFy4cEWsnrcbuo9/vAGz49yyVi0ZGf6
 tpoDj56SgGoVjNarbNPi08cRFIuPhUfVwy8SzQ90PN42kPZmkJd1mggjEQe7C/tBQdiD
 BSI+tldaVXltlIR35GIqNWygUhdBSidK0iM748OfbSscgKdT2hBYd/BVrvOGZBgP5nZA
 xUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=NqnmO5m4f6KLp7y2Sqo4eQ7ncsiIIY83YKWr8V6ikSo=;
 b=Y/8LXNkmshmJmSjbyjrcNmVayRpvK79VA8uun7q1E3QV7v7PGx6ikjWZ07RIjvDDGu
 0jCb1wnUPdmAWS/YxFeZoD8QRc2hT9/ThDdscqMk9Rk7QxgyZKGaH4tJ/7i0ehXK3+r6
 +YPUcQg5KuPjdk/Tzcsq15ViqiXeqhMYmw6NNwO5q/KyGWvurennwaK6bC2qy/cEBb2G
 NooN205p6/XdvyLMPDSrcAP23u+FRQeF5Fl7qfM8gCcNPXYCmZxt43/JhBfYgSw1Fu/U
 WvmwcGwbEOpw8Di7wShyu9aWklDyHsr364humN0NrPrX+wTlqpqIt7cFFOkjkuE08erh
 4vEw==
X-Gm-Message-State: AOAM531n+Nzi48YBHcZbQM5VGfIzFLAUjOTyGzFrlJFFj19Bwjk8hjCz
 p46lAdHnvBLdWPb6Zn56YBAAt3Jlc3Js88DtMIk=
X-Google-Smtp-Source: ABdhPJxxAGb4t7/S3SJMP+8QsFekHMVOJT1yVR2dLBt8eT6hcHVew8L1KuUWP8hMkbArZCvDqsL1nTewpH1ZMsdT27Q=
X-Received: by 2002:aca:494d:: with SMTP id w74mr18790305oia.97.1595860687436; 
 Mon, 27 Jul 2020 07:38:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200727130225.32640-1-zhukeqian1@huawei.com>
In-Reply-To: <20200727130225.32640-1-zhukeqian1@huawei.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 27 Jul 2020 22:37:31 +0800
Message-ID: <CAKXe6S+L=Uze9Eo8jmPgpCDob_S_fXzvquHw2D974_5+haKdsw@mail.gmail.com>
Subject: Re: [PATCH] bugfix: irq: Avoid covering object refcount of qemu_irq
To: Keqian Zhu <zhukeqian1@huawei.com>
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
Cc: Thomas Huth <thuth@redhat.com>, Esteban Bosse <estebanbosse@gmail.com>,
 Qemu Developers <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, yezengruan@huawei.com,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 wanghaibin.wang@huawei.com,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Keqian Zhu <zhukeqian1@huawei.com> =E4=BA=8E2020=E5=B9=B47=E6=9C=8827=E6=97=
=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=889:03=E5=86=99=E9=81=93=EF=BC=9A
>
> Avoid covering object refcount of qemu_irq, otherwise it may causes
> memory leak.

Any reproducer?

Thanks,
Li Qiang

>
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> ---
>  hw/core/irq.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/core/irq.c b/hw/core/irq.c
> index fb3045b912..59af4dfc74 100644
> --- a/hw/core/irq.c
> +++ b/hw/core/irq.c
> @@ -125,7 +125,9 @@ void qemu_irq_intercept_in(qemu_irq *gpio_in, qemu_ir=
q_handler handler, int n)
>      int i;
>      qemu_irq *old_irqs =3D qemu_allocate_irqs(NULL, NULL, n);
>      for (i =3D 0; i < n; i++) {
> -        *old_irqs[i] =3D *gpio_in[i];
> +        old_irqs[i]->handler =3D gpio_in[i]->handler;
> +        old_irqs[i]->opaque =3D gpio_in[i]->opaque;
> +
>          gpio_in[i]->handler =3D handler;
>          gpio_in[i]->opaque =3D &old_irqs[i];
>      }
> --
> 2.19.1
>

