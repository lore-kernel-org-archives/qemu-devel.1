Return-Path: <SRS0=be0Y=DK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1728C4363D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 05:31:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E81C206C3
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 05:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTkNMBw4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E81C206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOa8q-0001KD-35
	for qemu-devel@archiver.kernel.org; Sat, 03 Oct 2020 01:31:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kOa7z-0000hY-1i; Sat, 03 Oct 2020 01:30:39 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39151)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kOa7x-0000JN-A0; Sat, 03 Oct 2020 01:30:38 -0400
Received: by mail-ot1-x343.google.com with SMTP id u25so3544914otq.6;
 Fri, 02 Oct 2020 22:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=+TBwnHhyO6rYGo/JS6j684wdk4x4F9+47Qp1eAYpAII=;
 b=ZTkNMBw4YyBVO4sSsLaBBhNxIHpvjTAfMVJM9fbpYLcuvuIwWyPIwAciGvtbIdzTl3
 sWSyKiUbFtp3muL4MoA1442ib7tiNtu/ffMQC5CmPtUPhlJ+XZdbRt8wwy7sNkI6XCyJ
 r/NQAkUWB2H+bZf4AWuV/4ulz4hwH7JGPpF48ahdQ4ej29vUAAd+X4WAWKPuxQ9LabNd
 tL+OG1WDKqTx73Z7Yjmg0AB3XGosjDax5SyXZRJcbpVGkjFhmN2IyFU51+BuGSDQFoEd
 buP3gtPAwWqVIzspxWrdsvqYAbfaPmxeVMIdTbDgfE60WRDZdkIbhqvSLAddF2zGEj6b
 69Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+TBwnHhyO6rYGo/JS6j684wdk4x4F9+47Qp1eAYpAII=;
 b=m0vQSHVqGGBgj9HSJgiWuIn3nH226uMyolYNEIziafywcSavfdGD1NiaWfmKDnZnF8
 jRtuWb8nUGV4eQDg1hawJdXleqM4EBzdz3R1KKn/cHb1re7HaLiqjsHq/VzgohwOhvbc
 S4J8Amdw8N3L34QXKwpsMqUOSFml3myneZfSZy3CJ9WEaXYYTQkg2PgYuShqaTgMOubV
 ADnepCrpDKxTQhQJQg9wA1Zt2zD7xHEkmJLP7DxQQORWN43HV9gfHDsWsdskeEVvM52e
 2DgjhV5DVfyPI8I8Jxtgp8tpb/cIzQ0/FHEb2JiwZ3zjgg+PJr0B8HGDEsbTbF7RnQu+
 rbTA==
X-Gm-Message-State: AOAM530looFbdDYGrSg4FK/Hjalzmeq+VtXypzDemlwwljF6Xoy9btQZ
 HeJS3yNDHiScJMTgLc2KWS6O+6XppgWYvs2ArLg=
X-Google-Smtp-Source: ABdhPJyKfJzjlwqI2W8rVRsFf/u1SSrz0OnjiD0qoCmUUEtJKX6gQLIci4JgBxbDalNVSKbnB4gqF7/ai0s+nj7ZSX8=
X-Received: by 2002:a05:6830:1187:: with SMTP id
 u7mr4084711otq.181.1601703035134; 
 Fri, 02 Oct 2020 22:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <160165476743.57452.2128307974125615413.stgit@bahia.lan>
In-Reply-To: <160165476743.57452.2128307974125615413.stgit@bahia.lan>
From: Li Qiang <liq3ea@gmail.com>
Date: Sat, 3 Oct 2020 13:29:59 +0800
Message-ID: <CAKXe6SKC2aBuGUCrqg73VpiMVY3US8tvq9CbOxy71pFKcYok-Q@mail.gmail.com>
Subject: Re: [PATCH] hw/acpi/piix4: Rename piix4_pm_add_propeties() to
 piix4_pm_add_properties()
To: Greg Kurz <groug@kaod.org>
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
Cc: qemu-trivial@nongnu.org, Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Greg Kurz <groug@kaod.org> =E4=BA=8E2020=E5=B9=B410=E6=9C=883=E6=97=A5=E5=
=91=A8=E5=85=AD =E4=B8=8A=E5=8D=8812:07=E5=86=99=E9=81=93=EF=BC=9A
>
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
>  hw/acpi/piix4.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> index 894d357f8c35..67a1ea41914f 100644
> --- a/hw/acpi/piix4.c
> +++ b/hw/acpi/piix4.c
> @@ -437,7 +437,7 @@ static void piix4_pm_machine_ready(Notifier *n, void =
*opaque)
>          (memory_region_present(io_as, 0x2f8) ? 0x90 : 0);
>  }
>
> -static void piix4_pm_add_propeties(PIIX4PMState *s)
> +static void piix4_pm_add_properties(PIIX4PMState *s)
>  {
>      static const uint8_t acpi_enable_cmd =3D ACPI_ENABLE;
>      static const uint8_t acpi_disable_cmd =3D ACPI_DISABLE;
> @@ -509,7 +509,7 @@ static void piix4_pm_realize(PCIDevice *dev, Error **=
errp)
>                                     pci_get_bus(dev), s);
>      qbus_set_hotplug_handler(BUS(pci_get_bus(dev)), OBJECT(s));
>
> -    piix4_pm_add_propeties(s);
> +    piix4_pm_add_properties(s);
>  }
>
>  I2CBus *piix4_pm_init(PCIBus *bus, int devfn, uint32_t smb_io_base,
>
>
>

