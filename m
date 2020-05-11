Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280ECC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 05:51:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6FED20735
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 05:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+NRbE0s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6FED20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY1Lk-0005vM-4r
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 01:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jY1Ko-0005I8-ET
 for qemu-devel@nongnu.org; Mon, 11 May 2020 01:50:38 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50466)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jY1Km-0003RB-MZ
 for qemu-devel@nongnu.org; Mon, 11 May 2020 01:50:37 -0400
Received: by mail-wm1-x342.google.com with SMTP id m12so11738341wmc.0
 for <qemu-devel@nongnu.org>; Sun, 10 May 2020 22:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=CfiMNtnSKbijQJ0KkxzXy/juV9gD2av6mGlSiYt8NH4=;
 b=A+NRbE0s4YVSwVP0Z2ZatQhAPXxvN0itpDo7hw9ynCF0pZvYjm6yjXd9+QisTrMS4V
 ycCi+4ZPX72s1sPikVxvGp8Ph/Xw4IvyRM5WprlCSDnibWASLiDS10CNla58sxgBEWR7
 Iwq8Xe/tkv0mpKywSIndHGPVgOoZOX/u1PAKzxywCDgPwkGrY90NIqNGvUTarYqcHslz
 Y0i6cOR12sfp9pPB1DrNdK3ozcAtMcsX4p7NOTAY1RT/lt20ejno2Hz1+bbRZfoxLWFm
 QHsa8++lrmn4Si9IVjUltmXos+MsLub1tE5QF9dWG3SnSbNQUJ9Nfk8WGVYuogmTv0EO
 9ElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=CfiMNtnSKbijQJ0KkxzXy/juV9gD2av6mGlSiYt8NH4=;
 b=ej8ihc2aj+VmFtLQz2HU9FZsAOXZ438CYO9Ijlck7lA4DWbmfUDlm/pknHsQPstty/
 y/QIhYNgIrueEcL0y1g05MHZ9SffRk2hyiNup0ZPpxv8ynjq6qNO8cb2X6CxoVjUzXma
 w1b1DSsp2jNs450S20LSsc/8Q8h1c0Ooo/LBbR8I5c3veq9nB6TpnXHtIfjtUpRscSkJ
 sY5v9DVIQNU27QC/xnDuf3168NYLS73VsNZy+02GQthEm2d8oDJIWHNPM9wwzTkEKCgU
 /cs8vNy6Kd2fd/f2h9cXqHj/RDy/T+nFd9YtOz/q1KJS3ZlhXqdB0Lh+3nO6dleQK+Wu
 jdkQ==
X-Gm-Message-State: AGi0PubR8NFlPG7vwbKWcVvDI0inYLy8MJpIVnQr87PvVYCyWenJ03re
 +xVZ3X+7WJAU+iPZFpff1AbkodNu1R5SMm8jF7wUn5I5hcc=
X-Google-Smtp-Source: APiQypKVf5GMPBwCaFU/hJNYMk+PQOeX035rhbTJMenoaRu5JXtQh6t0rOltPLMvx2hkT7o16qBDBuGi4ZV8bCmqyLg=
X-Received: by 2002:a7b:c74d:: with SMTP id w13mr28499080wmk.36.1589176235090; 
 Sun, 10 May 2020 22:50:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200510210128.18343-1-f4bug@amsat.org>
 <20200510210128.18343-8-f4bug@amsat.org>
In-Reply-To: <20200510210128.18343-8-f4bug@amsat.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Mon, 11 May 2020 07:50:14 +0200
Message-ID: <CAHiYmc5qoL3jkQMb1H2Afw-B1JcBcZVJwmnd7uTwoOjDp+FCEg@mail.gmail.com>
Subject: Re: [PATCH 07/12] hw/pci-host/bonito: Map peripheral using physical
 address
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Huacai Chen <chenhuacai@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D0=BD=D0=B5=D0=B4, 10. =D0=BC=D0=B0=D1=98 2020. =D1=83 23:01 Philippe Math=
ieu-Daud=C3=A9 <f4bug@amsat.org> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> Peripherals are mapped at physical address on busses.
> Only CPU/IOMMU can use virtual addresses.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/pci-host/bonito.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>

> diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
> index 10ead31e4f..7ed462ffb5 100644
> --- a/hw/pci-host/bonito.c
> +++ b/hw/pci-host/bonito.c
> @@ -647,12 +647,12 @@ static void bonito_realize(PCIDevice *dev, Error **=
errp)
>      memory_region_init_io(&s->iomem_ldma, OBJECT(s), &bonito_ldma_ops, s=
,
>                            "ldma", 0x100);
>      sysbus_init_mmio(sysbus, &s->iomem_ldma);
> -    sysbus_mmio_map(sysbus, 3, 0xbfe00200);
> +    sysbus_mmio_map(sysbus, 3, 0x1fe00200);
>
>      memory_region_init_io(&s->iomem_cop, OBJECT(s), &bonito_cop_ops, s,
>                            "cop", 0x100);
>      sysbus_init_mmio(sysbus, &s->iomem_cop);
> -    sysbus_mmio_map(sysbus, 4, 0xbfe00300);
> +    sysbus_mmio_map(sysbus, 4, 0x1fe00300);
>
>      /* Map PCI IO Space  0x1fd0 0000 - 0x1fd1 0000 */
>      memory_region_init_alias(&s->bonito_pciio, OBJECT(s), "isa_mmio",
> --
> 2.21.3
>

