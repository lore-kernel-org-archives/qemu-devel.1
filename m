Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A6CC2BA2B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 22:19:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EBA320678
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 22:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vs//LplS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EBA320678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jO7Qr-0004me-Bd
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 18:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45677)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jO7PT-0003Aa-3c
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 18:18:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jO7PS-0005LF-46
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 18:18:30 -0400
Received: from mail-vk1-xa43.google.com ([2607:f8b0:4864:20::a43]:35058)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jO7PS-0005L9-0M; Mon, 13 Apr 2020 18:18:30 -0400
Received: by mail-vk1-xa43.google.com with SMTP id u8so2333827vkl.2;
 Mon, 13 Apr 2020 15:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Xqfg2UOfrtjX2QlezANpKbA9eU75rpqm2Ozq/7avSc0=;
 b=Vs//LplSMj0jTGSs5BBPfQYKXoe29gtamnOyzQ4O/v6WMfhH697NVZas1W6B7Bn9ty
 jpuGSfa2f/RoEUv/DB/BZtqU3RszXNBuQ5elO4bjkiUiJWaYQp4eoPKuLFM0IyRcTZLW
 5SENLTIgkOq3ISDdw7Iw5Gf/wo9XHz2x7aIOZEPUZm7BWpRud5nRgrwoCEjIbHVyTn/S
 K8d+ONFaKXvTpgOW/t92TM1A0q31JNhkMAKzbkmUt6UChB1jGRNZNC/9Htx1FCgb4C2G
 9+L/QdbjHZQxNOAAR3n+I75wQ+u+QTRUyJpEm7Iu9PI38FHalHlWgNsXHORsL3IxggVu
 o1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Xqfg2UOfrtjX2QlezANpKbA9eU75rpqm2Ozq/7avSc0=;
 b=ljDH6ZR5ECjFn28Lz/xIXEtsfwrGkd0NhhUL9IaXsK40vJF5jSUxg/mcpVdXqCPYAx
 tEl6UHGx/FoabaUqbW3bUhgfx47l3/a+YbllJqHkWbV/H0sRn4w8bzdudddCIauzgVxP
 en0fSOwY6Lf23Vknl8EhCLYolFI7cXZJ3M+J+x3X0454+GL60utc6etGew0dgoWM6Fb2
 aGjQBmyBqE5TSdedXptZ4wibsvysxVXw3JSqkkV1btzdci3kCCpb4ywJfXL/lF1prclI
 XxMGTimqRLbGpwakVyt7S2dPbd9H429kmYPTPWtqEhyK7cFXV2mWrjc98l/QVpVXtwAp
 32Hw==
X-Gm-Message-State: AGi0PuZrvT4TyzjNo9ATCkUyhCvSwHhkK8fTpGMnjXg0FsOw8VYHjmsh
 kWb4kdH2SszMDUZG7EHyjkh85gtnJ+L1jXnBuDA=
X-Google-Smtp-Source: APiQypLzyDOBZozL608qupMxkepFwn/QSjcZy6zpv0qEom/nVYwT8W3kwfR2k1SkAxdgL4UMznqQlNQeIEYH1doqnpc=
X-Received: by 2002:a1f:2e8c:: with SMTP id u134mr13016321vku.16.1586816309527; 
 Mon, 13 Apr 2020 15:18:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200412223619.11284-1-f4bug@amsat.org>
 <20200412223619.11284-21-f4bug@amsat.org>
In-Reply-To: <20200412223619.11284-21-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 13 Apr 2020 15:10:13 -0700
Message-ID: <CAKmqyKN6uKZkkutqeeMGQBgCq8sg_wfRjOM3RvMfDi13b7RbvA@mail.gmail.com>
Subject: Re: [PATCH-for-5.1 v3 20/24] hw/riscv/sifive_u: Use single type_init()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::a43
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Max Reitz <mreitz@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 "open list:New World" <qemu-ppc@nongnu.org>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>, Andrew Jeffery <andrew@aj.id.au>,
 Wen Congyang <wencongyang2@huawei.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Apr 12, 2020 at 3:48 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> We can use a single type_init() to call multiple type_register*().
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/sifive_u.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 998666c91f..9c90c94c33 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -601,13 +601,6 @@ static const TypeInfo riscv_sifive_u_soc_type_info =
=3D {
>      .class_init =3D riscv_sifive_u_soc_class_init,
>  };
>
> -static void riscv_sifive_u_soc_register_types(void)
> -{
> -    type_register_static(&riscv_sifive_u_soc_type_info);
> -}
> -
> -type_init(riscv_sifive_u_soc_register_types)
> -
>  static void riscv_sifive_u_machine_class_init(ObjectClass *oc, void *dat=
a)
>  {
>      MachineClass *mc =3D MACHINE_CLASS(oc);
> @@ -627,9 +620,10 @@ static const TypeInfo riscv_sifive_u_machine_typeinf=
o =3D {
>      .instance_size =3D sizeof(SiFiveUState),
>  };
>
> -static void riscv_sifive_u_machine_init_register_types(void)
> +static void riscv_sifive_u_register_types(void)
>  {
> +    type_register_static(&riscv_sifive_u_soc_type_info);
>      type_register_static(&riscv_sifive_u_machine_typeinfo);
>  }
>
> -type_init(riscv_sifive_u_machine_init_register_types)
> +type_init(riscv_sifive_u_register_types)
> --
> 2.21.1
>
>

