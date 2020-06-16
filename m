Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F56CC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:28:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46FBC2074D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HcHM+ccj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46FBC2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl8pK-0001VR-J4
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 06:28:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl8oP-0000Nj-25
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 06:27:25 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:32988)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl8oN-00014g-Cm
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 06:27:24 -0400
Received: by mail-oi1-x244.google.com with SMTP id i74so18806550oib.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 03:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=J0S2DQY2kWysa46WMF2r9WDjMSlrd1zDVgOKE135q88=;
 b=HcHM+ccjwDDnZsiB9TNMAOM27OcVBg2No+yPfuasP1KdGpoQCKhA/3DC2xWdio0mEu
 RhoIdLLxte212lfUO1OMOV1bK4aXr7EyFIpCxCW/lVCF1PHYvLmdIVtg2tItgrTVZdMo
 z1HE/l5sCZ/yOrEON0lF9WztgjMCGkEBtFU7LTSZy3o4ru0JJneGkKRIexW/EwfZTWki
 A+kYl5sHOXS2efl+xVCIbgPZS/P1CGFfQBOMAJ+0ufxIZU/4PO0r0nr028U3dKJB5FuJ
 YLMHth2z4NB6Bu+TbYWrEKZ2GFZruWXVbMC5ES0Pj9T1Nh19ERFWg1IJ5/GIMqOXue/7
 wrvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=J0S2DQY2kWysa46WMF2r9WDjMSlrd1zDVgOKE135q88=;
 b=F0j/aW7zfaGY0093aDCIxvaGh+4OGy0Zh9SE/buyD5YiWqLLMTJxH1Unt6mC1B9Eup
 9hi+NHb4uMW8hvHEAbA5a7segvfa+Bzqvb1v6ngRXFfN2oKKeY7aF4357gpjtPRFW4d3
 xk5fgQhk9fPibk9M3fR26ENYiOGY8qWj2g78lcCin1A2Gi/JonRQ7JsQf+HUysHt46R4
 zAynFUDyhsGQ7a83Sg5xCYoh/VdTjkvkZrsW2MWk2L2wLrgpNkaH8xkYZyayFAKuNVX7
 g6+MuTzzAqsEQZDx6Rqjp/L+/2PTi6WzZz2KpZPjRThx49goh5n4iQTA5BJqqkygue6e
 Syog==
X-Gm-Message-State: AOAM5320J8KSX/MNGpuDSZ4pBzv5P0vgWDm2KxpESPIK3qV1BIzmVfKT
 ncRBsfzE9HuQdP+LeLXDC0DXzzY0tQvCq0MIYpdxgA==
X-Google-Smtp-Source: ABdhPJzwV2p+FMdy+nu4PL0rfMOR/unUpDCi/SEBkxt3d0pmDQv/kP2wbx2KsHBRWo8mfgx/reOyQ5j83BhpPz1AnR0=
X-Received: by 2002:aca:1a07:: with SMTP id a7mr2713469oia.163.1592303242280; 
 Tue, 16 Jun 2020 03:27:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200616063157.16389-1-f4bug@amsat.org>
 <20200616063157.16389-8-f4bug@amsat.org>
In-Reply-To: <20200616063157.16389-8-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2020 11:27:11 +0100
Message-ID: <CAFEAcA8c3QVD=PcfMOXn720E0ExSdV+mb3qoA61AFrFVstFHHw@mail.gmail.com>
Subject: Re: [PATCH 7/7] hw/misc/mps2-fpgaio: Implement push-buttons
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Esteban Bosse <estebanbosse@gmail.com>,
 Joaquin de Andres <me@xcancerberox.com.ar>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 16 Jun 2020 at 07:32, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> The FPGA system control block has 2 push-buttons labelled PB0/PB1.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---

> @@ -249,6 +258,8 @@ static void mps2_fpgaio_init(Object *obj)
>      memory_region_init_io(&s->iomem, obj, &mps2_fpgaio_ops, s,
>                            "mps2-fpgaio", 0x1000);
>      sysbus_init_mmio(sbd, &s->iomem);
> +
> +    qdev_init_gpio_in_named(DEVICE(s), mps2_fpgaio_push_button, "PB", 2)=
;
>  }

This change seems kind of pointless unless these GPIO lines are
actually wired up to something.

thanks
-- PMM

