Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CCF5C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 05:54:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55C7120735
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 05:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWw7oNFn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55C7120735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY1OV-0008Lq-GO
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 01:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jY1Nv-0007g0-Hi
 for qemu-devel@nongnu.org; Mon, 11 May 2020 01:53:51 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39087)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jY1Nu-0005mC-Ph
 for qemu-devel@nongnu.org; Mon, 11 May 2020 01:53:51 -0400
Received: by mail-wm1-x344.google.com with SMTP id y24so17701042wma.4
 for <qemu-devel@nongnu.org>; Sun, 10 May 2020 22:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=CrVvmpxXRoGNLDGtoK9vUDFdyyRUbLuAYhl1PfBLIAc=;
 b=KWw7oNFnX584Jk8fkxrT5e8JDjECGeNcGeaNiNapE9WKCTvhOykEy5+V/G62+s0qo1
 gNdN8L2Wb1s2A77/kKrd27t/O9EqleQwA2fwTz7YVEl88XYxj3JazmkKI/ze+meq6BSV
 TCINlU3xIBCbgdTIxHQ9owpkhz3wtNKfdj/WdMWT/oBZHFffxR/r6uyMFRTrjcM2MMDP
 ytwcGZqOg/7DC1hhF+EeQ2kzbtavK9nR4hGxpSR3i23m0LkeDKYpwxbeUEfS7iBrPUmQ
 lB45xaRb/XFxek4lBjE7FBpWx3kS3qas1wSqq4dSmBk87T8hslbLgkzinOFj9qetRaUr
 yV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=CrVvmpxXRoGNLDGtoK9vUDFdyyRUbLuAYhl1PfBLIAc=;
 b=BtlCL6ZxFUjlOHG1kLSZ5khxSIA6g0t+4aQarnTdTVhuBzyVsmCiMi2b6toupb0aVk
 xaJxhwHYm3cDda2dFFLNzF1dvzSa0KtlCrPylpQjJAcjakTftin2hiyRrsjfOIMpKFbB
 Al+E4KvhtJfY83em9D/CbFigXL4BLrDSZXrZOIPfzQBKgFV1bJFWCig3+lHIKMHmGx2x
 1ETi7CcO4BE3KlHaurGU7Su42RFKuYOMx47kFLm/Qff2IrOLmbhnRv4s7uvtOUquaZ3X
 q1rQxg18Bt5LJRNGC3FqUnp7f5Mzs0nWW4NHBCKf41spBJ3g4v6X5+gqQFlYSoPEJfy9
 51/A==
X-Gm-Message-State: AGi0Pua5S2IO4X1fcNa4vbhy8EHtumtjanInjRGZqX/sdhms84XJpKlT
 csdI/rnDzFTBcErkQ1G6yUJkuIWXdgqX+2EHHhY=
X-Google-Smtp-Source: APiQypJnNnV5+ksljiKAMzqeX9TLS+j/0d/CQf5uBvBd2xJZxmo/3IO18mWW3xOSu9ORSUZkSSv7up9DRmHJmX5MYWc=
X-Received: by 2002:a05:600c:3cd:: with SMTP id
 z13mr10313521wmd.159.1589176429476; 
 Sun, 10 May 2020 22:53:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200510210128.18343-1-f4bug@amsat.org>
 <20200510210128.18343-11-f4bug@amsat.org>
In-Reply-To: <20200510210128.18343-11-f4bug@amsat.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Mon, 11 May 2020 07:53:26 +0200
Message-ID: <CAHiYmc52Vp+yY9=xm05L6uMABtVNq=iS57Hh=onA6ye-b9c1gw@mail.gmail.com>
Subject: Re: [PATCH 10/12] hw/pci-host/bonito: Better describe the I/O CS
 regions
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x344.google.com
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
> Better describe the I/O CS regions, add the ROMCS region.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/pci-host/bonito.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>

Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>

> diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
> index 90a6c52a38..335c7787eb 100644
> --- a/hw/pci-host/bonito.c
> +++ b/hw/pci-host/bonito.c
> @@ -672,6 +672,8 @@ static void bonito_realize(PCIDevice *dev, Error **er=
rp)
>      sysbus_init_mmio(sysbus, &s->iomem_cop);
>      sysbus_mmio_map(sysbus, 4, 0x1fe00300);
>
> +    create_unimplemented_device("ROMCS", 0x1c000000, 60 * MiB);
> +
>      /* Map PCI IO Space  0x1fd0 0000 - 0x1fd1 0000 */
>      memory_region_init_alias(&s->bonito_pciio, OBJECT(s), "isa_mmio",
>                               get_system_io(), 0, BONITO_PCIIO_SIZE);
> @@ -679,10 +681,17 @@ static void bonito_realize(PCIDevice *dev, Error **=
errp)
>      sysbus_mmio_map(sysbus, 5, BONITO_PCIIO_BASE);
>
>      /* add pci local io mapping */
> -    memory_region_init_alias(&s->bonito_localio, OBJECT(s), "isa_mmio",
> -                             get_system_io(), 0, BONITO_DEV_SIZE);
> +
> +    memory_region_init_alias(&s->bonito_localio, OBJECT(s), "IOCS[0]",
> +                             get_system_io(), 0, 256 * KiB);
>      sysbus_init_mmio(sysbus, &s->bonito_localio);
>      sysbus_mmio_map(sysbus, 6, BONITO_DEV_BASE);
> +    create_unimplemented_device("IOCS[1]", BONITO_DEV_BASE + 1 * 256 * K=
iB,
> +                                256 * KiB);
> +    create_unimplemented_device("IOCS[2]", BONITO_DEV_BASE + 2 * 256 * K=
iB,
> +                                256 * KiB);
> +    create_unimplemented_device("IOCS[3]", BONITO_DEV_BASE + 3 * 256 * K=
iB,
> +                                256 * KiB);
>
>      MemoryRegion *pcimem_alias =3D g_new(MemoryRegion, 1);
>      memory_region_init_alias(pcimem_alias, NULL, "pci.mem.alias",
> --
> 2.21.3
>

