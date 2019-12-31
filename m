Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FF5C2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 16:11:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD04F205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 16:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NQp+q5to"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD04F205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imK6x-0004AJ-SM
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 11:11:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47197)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1imK60-00037i-Qe
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 11:10:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1imK5z-0007CV-Mf
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 11:10:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22975
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1imK5z-00079v-GX
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 11:10:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577808611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m+jw2JHIwXfCvKla+0tuwl8pgqmuRaDtkXM7/m/Wu5k=;
 b=NQp+q5toWeRFPhgIxXfJLCETitW+PZWgi6rBtqIRzpas7K18K6Fy15zqVse46V4Ken/ANl
 5VADvOePg0SixrrqXOYFs0umTVPqP/jNgrx7hJ9C3GGVqgpBqi3ncJPWpBkmJxU+INc3ih
 PipdXuz/odPI1ipfO+Db3IDpRv4PCHE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-1SkJkKrwOWW1_XF0s1-Y9g-1; Tue, 31 Dec 2019 11:10:09 -0500
Received: by mail-wm1-f71.google.com with SMTP id t16so274736wmt.4
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 08:10:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CVUQt7hBjodBpPZy3wpW1lRSCqrs8uvHlN5n3Sz5FyQ=;
 b=H4Jw+FzOs3Vgk//AqS3wz4CEi7X0ubm8Hh9911xQ1x8dHXrJzM9PrKCcb65p92hjWk
 ivcHVY5ezTx/bSkqMLDdxQVmUrd17CvDv/cG6EpxXWKYjbHmlell/nJO5TLv0BXLGaOQ
 xtAyL3wKLC6oDcG0qWIWpBaJrZv0UiFA9LC9lBWaHC0BpKuEZfy3nVyR6ZJ3Fx984CHT
 4T1RfUBXNFm7YiYmt5776b1vUfyU602MLi5htkBcSDcNAG1iETBpp7qpNDcLoJqWlwnu
 f/7t9JnlsbpUssIx9WflR9r3b7X1ECdhpqPnkNgm9MUMzLF06KFTyhH4LxaossO2mbWd
 tYTw==
X-Gm-Message-State: APjAAAX6j/fcrgwIXJ/tXcFBnrIJZ5V8m9l5FXQzfNYvi2qQk2uQgyRT
 yaqx9VFiC2awSPcJFJ4CygVoVLj8FLx4i8eoMbismdcxU81K8CFOGFD62Wydwa7tEoQdOfkjXvR
 VFepFgjJXAiea6Jw=
X-Received: by 2002:a05:600c:2c13:: with SMTP id
 q19mr4924762wmg.144.1577808607921; 
 Tue, 31 Dec 2019 08:10:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqzm0r+Gl+NLD3642MtV6oJR8h67NjB74wkwENZ3dw7S0W0o/4r7ADO1hmnC1T7UDMZgwJtnLg==
X-Received: by 2002:a05:600c:2c13:: with SMTP id
 q19mr4924736wmg.144.1577808607719; 
 Tue, 31 Dec 2019 08:10:07 -0800 (PST)
Received: from ?IPv6:2a01:cb18:8372:6b00:691b:aac5:8837:d4da?
 ([2a01:cb18:8372:6b00:691b:aac5:8837:d4da])
 by smtp.gmail.com with ESMTPSA id d8sm48790626wrx.71.2019.12.31.08.10.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Dec 2019 08:10:07 -0800 (PST)
Subject: Re: [PATCH 21/86] arm:kzm: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
 <1577797450-88458-22-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ed80928b-2c0a-fa1f-6563-70c203d08d3c@redhat.com>
Date: Tue, 31 Dec 2019 17:10:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1577797450-88458-22-git-send-email-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: 1SkJkKrwOWW1_XF0s1-Y9g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/31/19 2:03 PM, Igor Mammedov wrote:
> memory_region_allocate_system_memory() API is going away, so
> replace it with memdev allocated MemoryRegion. The later is
> initialized by generic code, so board only needs to opt in
> to memdev scheme by providing
>    MachineClass::default_ram_id
> and using MachineState::ram instead of manually initializing
> RAM memory region.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   hw/arm/kzm.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
> index 27800c5..f63902e 100644
> --- a/hw/arm/kzm.c
> +++ b/hw/arm/kzm.c
> @@ -51,7 +51,6 @@
>  =20
>   typedef struct IMX31KZM {
>       FslIMX31State soc;
> -    MemoryRegion ram;
>       MemoryRegion ram_alias;
>   } IMX31KZM;
>  =20
> @@ -84,10 +83,8 @@ static void kzm_init(MachineState *machine)
>           exit(EXIT_FAILURE);
>       }
>  =20
> -    memory_region_allocate_system_memory(&s->ram, NULL, "kzm.ram",
> -                                         machine->ram_size);
>       memory_region_add_subregion(get_system_memory(), FSL_IMX31_SDRAM0_A=
DDR,
> -                                &s->ram);
> +                                machine->ram);
>  =20
>       /* initialize the alias memory if any */
>       for (i =3D 0, ram_size =3D machine->ram_size, alias_offset =3D 0;
> @@ -107,7 +104,8 @@ static void kzm_init(MachineState *machine)
>  =20
>           if (size < ram[i].size) {
>               memory_region_init_alias(&s->ram_alias, NULL, "ram.alias",
> -                                     &s->ram, alias_offset, ram[i].size =
- size);
> +                                     machine->ram,
> +                                     alias_offset, ram[i].size - size);
>               memory_region_add_subregion(get_system_memory(),
>                                           ram[i].addr + size, &s->ram_ali=
as);
>           }
> @@ -139,6 +137,7 @@ static void kzm_machine_init(MachineClass *mc)
>       mc->desc =3D "ARM KZM Emulation Baseboard (ARM1136)";
>       mc->init =3D kzm_init;
>       mc->ignore_memory_transaction_failures =3D true;
> +    mc->default_ram_id =3D "kzm.ram";
>   }
>  =20
>   DEFINE_MACHINE("kzm", kzm_machine_init)
>=20


