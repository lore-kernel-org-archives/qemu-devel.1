Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD391C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 19:56:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 948F82070A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 19:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTMTX0X3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 948F82070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jalrk-0006Zs-PT
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 15:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jalli-0004jb-05
 for qemu-devel@nongnu.org; Mon, 18 May 2020 15:49:46 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40505)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jallh-0006AW-5U
 for qemu-devel@nongnu.org; Mon, 18 May 2020 15:49:45 -0400
Received: by mail-wm1-x343.google.com with SMTP id n18so828442wmj.5
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 12:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Ipzj20sx2kFB62u6f1HeUGWmBEWRAXVMZx2qZpWNk6o=;
 b=eTMTX0X3URrPesADAgFkkhd8emTwhLHq5oZPL3AmYvYeH61a93CUb+I/SelTlIQarw
 b0DTgzI5uRxwhWgPvCCB6667qW4WIDGNspnOXKsIbva2CeFKrBGXDplXDkFlOI9LwSuj
 CLVnYKtnFC6+k+mmWplyM2owOYNzqdqdI1KrY37VsLKq2pxynO20POykRyIQNCxjMg/o
 r1w5p+UF1+ctbDOEbyMOpYV8QcSRQfeqFm/KctQhAdJbnswxaOMu3OLzB3lzHUs1hoYA
 Gi6MhAdmvtnD0Mhm3y7eFYLEC2soezzvQwXHTXfvkAvWTG9R3MJf8lyp5FCfnOnzGWo2
 DfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Ipzj20sx2kFB62u6f1HeUGWmBEWRAXVMZx2qZpWNk6o=;
 b=ok/yaXy2VRjT48ZVpG1uDrvfcew5XYadip/hdNwW+wE7aNvmXUvgnir5uYUAgqGBYt
 zf7Tl/8l2Bj4mLVqxVqGDeZ2smibAV3oCaEC8smoyJFPE68xFGnhnTHr8csWhLfejMdd
 2jqxlLjuJ7XHzzH3mG7zu+9GZ12imCXF5TpU0FAz4xen9eOfRaHq76kmV/6QFnPgYJI5
 DfprhnhF9VGGm7g1eL9BltkaEBix0KKjjL7/Oztuam7sfTfzQ5Ok71TXzkZEI0Ph/8aY
 rlRhfLMqpaXQ0mhyaNUy+14IdLtzZoMdQG/vSUL40oS5pt4UozH00eO8YVTRHxBxmQJP
 T7Vw==
X-Gm-Message-State: AOAM531r+5vg3MG9N8aXpeHBdZavrfUOURUvpuByxPeFCGIVk9Rm6JXy
 3DVJzF1u3lAI7EwID2zmybF3xsbUIsJKvYPj7UbHrDio
X-Google-Smtp-Source: ABdhPJxLVWpG7ECIsoQXonKpD7XwiLX0mjF6rz1S4RwXXE2EhK90mtSlEB3Vmnwz96NdS0ljznKgpYJU6vLpG+efDqA=
X-Received: by 2002:a1c:f211:: with SMTP id s17mr1132578wmc.168.1589831383456; 
 Mon, 18 May 2020 12:49:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200518194149.16281-1-aleksandar.qemu.devel@gmail.com>
 <20200518194149.16281-2-aleksandar.qemu.devel@gmail.com>
In-Reply-To: <20200518194149.16281-2-aleksandar.qemu.devel@gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Mon, 18 May 2020 21:49:25 +0200
Message-ID: <CAHiYmc5SQjhsJUXMkf0_w=4JmSk66rzgJtSjmAHxT7cBsdp4cA@mail.gmail.com>
Subject: Re: [PATCH v5 01/22] hw/tpm: fix usage of bool in tpm-tis.c
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: aleksandar.rikalo@syrmia.com, Jafar Abdi <cafer.abdi@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D0=BF=D0=BE=D0=BD, 18. =D0=BC=D0=B0=D1=98 2020. =D1=83 21:42 Aleksandar Ma=
rkovic
<aleksandar.qemu.devel@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> From: Jafar Abdi <cafer.abdi@gmail.com>
>

This patch was selected by mistake to be included in this series. A ne
version of this series will be sent without this patch.

Sorry about this.

Aleksnadar

> Clean up wrong usage of FALSE and TRUE in places that use "bool" from std=
bool.h.
>
> FALSE and TRUE (with capital letters) are the constants defined by glib f=
or
> being used with the "gboolean" type of glib. But some parts of the code a=
lso use
> TRUE and FALSE for variables that are declared as "bool" (the type from <=
stdbool.h>).
>
> Signed-off-by: Jafar Abdi <cafer.abdi@gmail.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  hw/tpm/tpm_tis_common.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/tpm/tpm_tis_common.c b/hw/tpm/tpm_tis_common.c
> index 9ce64d4836..1af4bce139 100644
> --- a/hw/tpm/tpm_tis_common.c
> +++ b/hw/tpm/tpm_tis_common.c
> @@ -536,7 +536,7 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr a=
ddr,
>              while ((TPM_TIS_IS_VALID_LOCTY(s->active_locty) &&
>                      locty > s->active_locty) ||
>                      !TPM_TIS_IS_VALID_LOCTY(s->active_locty)) {
> -                bool higher_seize =3D FALSE;
> +                bool higher_seize =3D false;
>
>                  /* already a pending SEIZE ? */
>                  if ((s->loc[locty].access & TPM_TIS_ACCESS_SEIZE)) {
> @@ -546,7 +546,7 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr a=
ddr,
>                  /* check for ongoing seize by a higher locality */
>                  for (l =3D locty + 1; l < TPM_TIS_NUM_LOCALITIES; l++) {
>                      if ((s->loc[l].access & TPM_TIS_ACCESS_SEIZE)) {
> -                        higher_seize =3D TRUE;
> +                        higher_seize =3D true;
>                          break;
>                      }
>                  }
> --
> 2.20.1
>

