Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D832C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:54:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E850420776
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p828qJp1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E850420776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdcqQ-00060M-4g
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 12:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jdcjZ-0003Uj-TZ; Tue, 26 May 2020 12:47:21 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:37492)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jdcjY-00069K-FW; Tue, 26 May 2020 12:47:21 -0400
Received: by mail-il1-x143.google.com with SMTP id r2so9945188ila.4;
 Tue, 26 May 2020 09:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=US/6pi8OtL/tZoq7LUrwfxAw/HJhGUy2KOFK+AJwJY0=;
 b=p828qJp1PNv27RqFu1RwVggVVqpacLEuw/lKMbQd1CL4tB8R8ryd3T7o1O8X5e1RBI
 omBXyriaK2xOdZF+NYC0vscjxestICNIhAChN/AXtUz9g6ViFvDeARzpjI60+pf43V0S
 Nmj7WblBIrhJ4kZn6eWE/gV4JPWx3J1asYwjJcf5abmbGyP580rb1upWMPTrjTd0wrVq
 ruHsFdGoPt8ZBoQPGP7zvKFBKxGAOkBgqOC838Nhpn2zZPyINYEib5Xam5SvOYcaAikc
 q1HZatM4NqR1mdVOZS8Vqa1ICysa0ftxkO7QDghAA5Przydkj/7KqS+FnTf7ldFDNlMl
 UvAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=US/6pi8OtL/tZoq7LUrwfxAw/HJhGUy2KOFK+AJwJY0=;
 b=hS7vOsGOgY/uhP+RgeQ4aIA2M+jmSxjxO4opEfYIOfsAY814Km+MlFXH0nvAuuZKKU
 Hf0SorPREonwTIMTu+o5qhdf6Dv3zCtOP7/RlRixNm6fpHpKSMYki3fNqjWW7Ev8vlsL
 UNriZ+QczJEjAMkjkNMEy2ezyrjxqx5Kd1e6dDUsGhcU/NHJmTlgIj3uFbOz7vu4qjfg
 9L8/KKa5/dWdawwmSe+83ChDKAJ+7TrLvMxPklPneH3Rd0A1BH+D4FeSHayaNI/9lguk
 NUhf/an4qafTumEWq+UV22t+/LJSq/cioPyFQuFuomRCNczEd+fn+FW8u5f+95DlFMuS
 lV2w==
X-Gm-Message-State: AOAM532QK4NlR7azKowbkWGWiSIkllbDTPgx9gJMVKQqOytAiP/c+aAY
 jbknP3CsFZ7+Wh9a1SGW1FeN5KX9Sc7sRU4fu38=
X-Google-Smtp-Source: ABdhPJykVOmpJRtoRxrqWUlBSe3yceU0HCLXUa7JW88QWl6Q1q0umRDzFTpSLRCs51S6c+XG2dmUpHpOczmLP+qCkfI=
X-Received: by 2002:a92:de02:: with SMTP id x2mr2048228ilm.267.1590511638212; 
 Tue, 26 May 2020 09:47:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200525034459.28535-1-f4bug@amsat.org>
 <20200525034459.28535-3-f4bug@amsat.org>
In-Reply-To: <20200525034459.28535-3-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 26 May 2020 09:38:18 -0700
Message-ID: <CAKmqyKNAf4KKdGM=_s5AWa4-G6YYH2CLOnTd-E0cvQtVa6+sCA@mail.gmail.com>
Subject: Re: [PATCH 2/4] hw/display/dpcd: Fix memory region size
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Trivial <qemu-trivial@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, May 24, 2020 at 8:48 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> The memory region size is 512K.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/display/dpcd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/display/dpcd.c b/hw/display/dpcd.c
> index 170545c605..0c1b7b35fb 100644
> --- a/hw/display/dpcd.c
> +++ b/hw/display/dpcd.c
> @@ -1,5 +1,5 @@
>  /*
> - * dpcd.c
> + * Xilinx Display Port Control Data
>   *
>   *  Copyright (C) 2015 : GreenSocs Ltd
>   *      http://www.greensocs.com/ , email: info@greensocs.com
> @@ -137,7 +137,7 @@ static void dpcd_init(Object *obj)
>  {
>      DPCDState *s =3D DPCD(obj);
>
> -    memory_region_init_io(&s->iomem, obj, &aux_ops, s, TYPE_DPCD, 0x7FFF=
F);
> +    memory_region_init_io(&s->iomem, obj, &aux_ops, s, TYPE_DPCD, 0x8000=
0);
>      aux_init_mmio(AUX_SLAVE(obj), &s->iomem);
>  }
>
> --
> 2.21.3
>
>

