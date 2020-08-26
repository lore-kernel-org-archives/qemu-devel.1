Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A6BC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 01:26:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22A7420737
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 01:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EObYDINO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22A7420737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAkCl-0000mO-9N
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 21:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kAkCE-0000F5-Go; Tue, 25 Aug 2020 21:25:50 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:43509)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kAkCC-0000eP-OY; Tue, 25 Aug 2020 21:25:50 -0400
Received: by mail-oi1-x242.google.com with SMTP id j21so114456oii.10;
 Tue, 25 Aug 2020 18:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=PyEcmIQJtRJ5Wh85UWdGlRCg+EVUGQ1qqz6mWEzpTpg=;
 b=EObYDINOTB51juo2YgM85CvGoXDSjCFc/HyCMsWnSHuXweJQJazJvU9wKkO4ye2UBe
 9hFxWxci8p/xt+P4n8Zg5vouvhXCrh8AaZGpF0HLlZ4BtN347R2FhJGi75+l7ATWYp40
 M12BEh8x+U1J0+p/kwlFsP6Skv5Boux4MVee29b1GqXEX08RIJ3Oa2uXTXELT+cQLBhs
 07V3p5xgXGb38adbT3iJazXZeefqBcDoewv76H6Cecknv/M50KVZTWpaohBqJxr4cZx5
 laVo7hpsGLSQN9dWu7sF3a8q1DgoBIuuH3t0EYds97+M16+QNzmj7a+ZWhZsIq0Ou7YW
 YZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=PyEcmIQJtRJ5Wh85UWdGlRCg+EVUGQ1qqz6mWEzpTpg=;
 b=gMImJemMilkl3SyKvIRs6V8XfsL4XFvQ1ldo75ffDIpXaV4yLUPx9UO9dpkFR82NZw
 6wIZCwdFTzVc0Hagc4jKhAI16cOJmQOKehedED2tuoDU22jzvcFFARuM36aCsgYo6eO9
 4HmFEO8GFjWJfO4jAacXaoFBctYB+YlwJDvTifgw0zygmLbr1cCT9ygmwJAU5N7s3FJJ
 G+cpUmwYc9uuB/bDmKZFcvqA4o4RGLGWUL+NBUNEu1oNG/MfaWzmqmGwGcJECaf4BohS
 sUP6V7dqUzA3btxDRiEVJFU/lOl2x8izdFeascyYpf5ZOVgIsKCaG21s/K89jiThwdKT
 xSqg==
X-Gm-Message-State: AOAM5301wBlPWhkoDbHLeJ/B8xqdVYo8K0A9FYUfCt1lxGH4azfW0OeH
 yKd/yXYDeY3/mTkLZofFJ8Rokh4drhf2rk6jijA=
X-Google-Smtp-Source: ABdhPJy4LQSMWncaAgbT63OQECpK++T3sIjNEdKpu0Oymz9ffcn1CETulBx7epIAAaOYMwALk7tWhYloJFrziEqo9ic=
X-Received: by 2002:aca:c0c1:: with SMTP id q184mr2768943oif.56.1598405146929; 
 Tue, 25 Aug 2020 18:25:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200825112447.126308-1-kuhn.chenqun@huawei.com>
 <20200825112447.126308-2-kuhn.chenqun@huawei.com>
In-Reply-To: <20200825112447.126308-2-kuhn.chenqun@huawei.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 26 Aug 2020 09:25:10 +0800
Message-ID: <CAKXe6SLQ2AxeW-eK3Mc+Z81LYM0qPhUXorrytZ54=S7GQgrjhQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] hw/arm/virt-acpi-build:Remove dead assignment in
 build_madt()
To: Chen Qun <kuhn.chenqun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x242.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 Pan Nengyuan <pannengyuan@huawei.com>, Qemu Developers <qemu-devel@nongnu.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Euler Robot <euler.robot@huawei.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Chen Qun <kuhn.chenqun@huawei.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8825=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=887:26=E5=86=99=E9=81=93=EF=BC=9A
>
> Clang static code analyzer show warning:
> hw/arm/virt-acpi-build.c:641:5: warning: Value stored to 'madt' is never =
read
>     madt =3D acpi_data_push(table_data, sizeof *madt);
>     ^      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
> Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: qemu-arm@nongnu.org
> ---
>  hw/arm/virt-acpi-build.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 91f0df7b13..f830f9b779 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -633,12 +633,11 @@ build_madt(GArray *table_data, BIOSLinker *linker, =
VirtMachineState *vms)
>      int madt_start =3D table_data->len;
>      const MemMapEntry *memmap =3D vms->memmap;
>      const int *irqmap =3D vms->irqmap;
> -    AcpiMultipleApicTable *madt;
>      AcpiMadtGenericDistributor *gicd;
>      AcpiMadtGenericMsiFrame *gic_msi;
>      int i;
>
> -    madt =3D acpi_data_push(table_data, sizeof *madt);
> +    acpi_data_push(table_data, sizeof(AcpiMultipleApicTable));
>
>      gicd =3D acpi_data_push(table_data, sizeof *gicd);
>      gicd->type =3D ACPI_APIC_GENERIC_DISTRIBUTOR;
> --
> 2.23.0
>
>

