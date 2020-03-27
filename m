Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55221C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 10:47:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F50920578
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 10:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MnpNuCdE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F50920578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHmWU-0002Gb-9b
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 06:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40677)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jHmVm-0001kP-IE
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 06:46:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jHmVk-0002J1-OR
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 06:46:49 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:24173)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jHmVk-0002DX-G7
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 06:46:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585306007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KhTFMgo8h1+QdoBuKedKfKX3ontpLPiejdIY0Iz/hfs=;
 b=MnpNuCdErp6HoRzsMiYRGvqDiAbfxWgWLkMJUxK7IeIo5r+DWlmUy3WACnkKYzsmcHLcbZ
 9IJhAEqfn8TJPHYh58BfmZw1GL19MBwvPpPqbzfC8jWn/OXd8HBVDD2/LNHEz1B+/tgtD3
 QI3IGEyUOL7XgcGdVkh88RKfounhUC8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-ol5I4TBwPiafxHI5JexWIg-1; Fri, 27 Mar 2020 06:46:46 -0400
X-MC-Unique: ol5I4TBwPiafxHI5JexWIg-1
Received: by mail-ed1-f71.google.com with SMTP id bm26so7924959edb.4
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 03:46:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LSu3w7xHAQvUU4bmCQ0WTdiAhq7MmDp55Kt/G+XHoA0=;
 b=P1UVjAXIi+p2WS7xl9oenWI8T0DfGE6aCM5ZT/SDXDNGiN5lcpAdatlxWxonLm7SEA
 MlweyEYcNVvmjqLpE24DlsdbOHDtMXMTY0v3qwBQy32AVr3d2iM4n+wBoqMKM+wvISGK
 Yigdko475gBy70yYMiUDtIb0FhMM9AADRzXxHIekBR6W2zAHlU+VrKAbP5LHSvbIsQe9
 YVUrgl7caAfXkWo0//YMffWlY9yOFcDgWMLn5UKkA9avQk9OS1rVfZE7AKyUVUwz4vrX
 WmjS3pmpM4AgZO4gSiZg2FymqehkUkgHxYj1cBEk5Ldt3kjPfZ61Vx2iBWD1CwG/fsyr
 WPeQ==
X-Gm-Message-State: ANhLgQ2+7w8eO8bKrOHZcIqbZbSHcLWM0BRnqmNfsyVEkjTVMO3cXPO9
 lvdsJDmt0CeE1zjse+n3/Jo74waB/BATzbWis/cZr4+k5ttPWoW3x9SMtkT68J/3rVmHdLNZFQl
 tGW9mCADNwwpjK5E=
X-Received: by 2002:a17:906:d1c4:: with SMTP id
 bs4mr12057971ejb.109.1585306004546; 
 Fri, 27 Mar 2020 03:46:44 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtkfyucY19a/YIqfDbK/DDuv5G1J/Ot4qNlYvHvS2ORm13IxyISdY33gBGD2U1u/mK2aGnC7A==
X-Received: by 2002:a17:906:d1c4:: with SMTP id
 bs4mr12057942ejb.109.1585306004071; 
 Fri, 27 Mar 2020 03:46:44 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id y10sm692587ejm.3.2020.03.27.03.46.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2020 03:46:43 -0700 (PDT)
Subject: Re: [PATCH v2] hw/arm/collie: Put StrongARMState* into a
 CollieMachineState struct
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200326204919.22006-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6ed008aa-552c-6341-b0ee-79054bdc86ab@redhat.com>
Date: Fri, 27 Mar 2020 11:46:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200326204919.22006-1-peter.maydell@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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

On 3/26/20 9:49 PM, Peter Maydell wrote:
> Coverity complains that the collie_init() function leaks the memory
> allocated in sa1110_init().  This is true but not significant since
> the function is called only once on machine init and the memory must
> remain in existence until QEMU exits anyway.
>=20
> Still, we can avoid the technical memory leak by keeping the pointer
> to the StrongARMState inside the machine state struct.  Switch from
> the simple DEFINE_MACHINE() style to defining a subclass of
> TYPE_MACHINE which extends the MachineState struct, and keep the
> pointer there.
>=20
> Fixes: CID 1421921
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> v1->v2: folded in the uncommitted change that fixes the
> arm_load_kernel() first argument.
>=20
>   hw/arm/collie.c | 33 ++++++++++++++++++++++++++++-----
>   1 file changed, 28 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/arm/collie.c b/hw/arm/collie.c
> index 4992084a3f6..4b35ef4bed6 100644
> --- a/hw/arm/collie.c
> +++ b/hw/arm/collie.c
> @@ -19,6 +19,16 @@
>   #include "exec/address-spaces.h"
>   #include "cpu.h"
>  =20
> +typedef struct {
> +    MachineState parent;
> +
> +    StrongARMState *sa1110;
> +} CollieMachineState;
> +
> +#define TYPE_COLLIE_MACHINE MACHINE_TYPE_NAME("collie")
> +#define COLLIE_MACHINE(obj) \
> +    OBJECT_CHECK(CollieMachineState, obj, TYPE_COLLIE_MACHINE)
> +
>   static struct arm_boot_info collie_binfo =3D {
>       .loader_start =3D SA_SDCS0,
>       .ram_size =3D 0x20000000,
> @@ -26,9 +36,9 @@ static struct arm_boot_info collie_binfo =3D {
>  =20
>   static void collie_init(MachineState *machine)
>   {
> -    StrongARMState *s;
>       DriveInfo *dinfo;
>       MachineClass *mc =3D MACHINE_GET_CLASS(machine);
> +    CollieMachineState *cms =3D COLLIE_MACHINE(machine);
>  =20
>       if (machine->ram_size !=3D mc->default_ram_size) {
>           char *sz =3D size_to_str(mc->default_ram_size);
> @@ -37,7 +47,7 @@ static void collie_init(MachineState *machine)
>           exit(EXIT_FAILURE);
>       }
>  =20
> -    s =3D sa1110_init(machine->cpu_type);
> +    cms->sa1110 =3D sa1110_init(machine->cpu_type);
>  =20
>       memory_region_add_subregion(get_system_memory(), SA_SDCS0, machine-=
>ram);
>  =20
> @@ -54,11 +64,13 @@ static void collie_init(MachineState *machine)
>       sysbus_create_simple("scoop", 0x40800000, NULL);
>  =20
>       collie_binfo.board_id =3D 0x208;
> -    arm_load_kernel(s->cpu, machine, &collie_binfo);
> +    arm_load_kernel(cms->sa1110->cpu, machine, &collie_binfo);
>   }
>  =20
> -static void collie_machine_init(MachineClass *mc)
> +static void collie_machine_class_init(ObjectClass *oc, void *data)
>   {
> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> +
>       mc->desc =3D "Sharp SL-5500 (Collie) PDA (SA-1110)";
>       mc->init =3D collie_init;
>       mc->ignore_memory_transaction_failures =3D true;
> @@ -67,4 +79,15 @@ static void collie_machine_init(MachineClass *mc)
>       mc->default_ram_id =3D "strongarm.sdram";
>   }
>  =20
> -DEFINE_MACHINE("collie", collie_machine_init)
> +static const TypeInfo collie_machine_typeinfo =3D {
> +    .name =3D TYPE_COLLIE_MACHINE,
> +    .parent =3D TYPE_MACHINE,
> +    .class_init =3D collie_machine_class_init,
> +    .instance_size =3D sizeof(CollieMachineState),
> +};
> +
> +static void collie_machine_register_types(void)
> +{
> +    type_register_static(&collie_machine_typeinfo);
> +}
> +type_init(collie_machine_register_types);
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


