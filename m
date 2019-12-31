Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A7DC2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 16:09:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F657205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 16:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IgjDYUvR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F657205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imK5e-0002Fe-LG
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 11:09:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39978)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1imK3G-0007ly-8Z
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 11:07:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1imK3F-0002sS-2r
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 11:07:22 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23377
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1imK3E-0002pg-TF
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 11:07:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577808440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jj3bdqvkofHV9cEURiV6DQYLMnUPtfz/3+UuqT32CLA=;
 b=IgjDYUvRuyN9+qapOdWlEO7cUvQxaGrkkR8BtDSXRExx6zPlopbr8pxL9JTiyoLUPOpI+y
 ficGqTNglKzOUcFBRIBw/9SRzFDisDDcm6ReFWN4sZVu7/dVcbqGQx8E7Arazlku2yRGlv
 YK9EdIlh2hd2eTZDCr2blZ9+yXC0ecY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-oCT3wasIPd-G2AcjcVHx0g-1; Tue, 31 Dec 2019 11:07:17 -0500
Received: by mail-wr1-f71.google.com with SMTP id f15so4921488wrr.2
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 08:07:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/zwQ0S/+8FuCzNvYra0M+gYuDWlfnN4yZjxvU7PyRrw=;
 b=HS5yIzA5H0WKKmT6jiQA/5yufq5sNS/3Fyo3r1ZC21ZkMMlcl5cwBbua/ylaI1rlrp
 Xvmk/+iy3O+eRMO50qHPpHgNSU3X5evzZhHAuhD3ewaXn1/RwKsOQ+Agopudy0aZBq7Z
 En0IH8U7wARojIYiPp7mY76b4NKrmDm42IXl65b3jPoUggUvo/pZSijgx1FAQF+ljkrM
 9v9pvMnd8l9NXDiqftQe1YwVutSrCFhpDSlQzeIkT69YYAnssr6SckRiCq+vQo8Vsqxj
 8r4/OImp4BtVaBY7giOc7PRdOPCnVfVh5Gb6fWtN3nV9DX+fQuENpW42/5yXsDs2rKi5
 L6SA==
X-Gm-Message-State: APjAAAVqCCqrbBqFOCuZhgsgvfUYQmqwyzOprEUHASr+tavUsdHguNnH
 clTgIJ9Q7wYzrVxGoQLnvoYBraz6lpOmc8Fl2sODRm8JaaPTRMGY8gQS4adEmLJNFBBEpqqsH7z
 tK6V08hlkzggVUvU=
X-Received: by 2002:adf:b605:: with SMTP id f5mr70723746wre.383.1577808435372; 
 Tue, 31 Dec 2019 08:07:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqwMPPrLSF4wqL73/zDYhsOIEDaMj6Wakde5VboM0poSurzMIIoF/zenRrQfmOc124cvZQJBxg==
X-Received: by 2002:adf:b605:: with SMTP id f5mr70723734wre.383.1577808435203; 
 Tue, 31 Dec 2019 08:07:15 -0800 (PST)
Received: from ?IPv6:2a01:cb18:8372:6b00:691b:aac5:8837:d4da?
 ([2a01:cb18:8372:6b00:691b:aac5:8837:d4da])
 by smtp.gmail.com with ESMTPSA id z123sm2977640wme.18.2019.12.31.08.07.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Dec 2019 08:07:14 -0800 (PST)
Subject: Re: [PATCH 56/86] mips:mips_malta: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
 <1577797450-88458-57-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <12cc39b2-705f-cc58-991d-df6d6d97369d@redhat.com>
Date: Tue, 31 Dec 2019 17:07:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1577797450-88458-57-git-send-email-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: oCT3wasIPd-G2AcjcVHx0g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   hw/mips/mips_malta.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 783cd99..adffa3a 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -1223,7 +1223,6 @@ void mips_malta_init(MachineState *machine)
>       char *filename;
>       PFlashCFI01 *fl;
>       MemoryRegion *system_memory =3D get_system_memory();
> -    MemoryRegion *ram_high =3D g_new(MemoryRegion, 1);
>       MemoryRegion *ram_low_preio =3D g_new(MemoryRegion, 1);
>       MemoryRegion *ram_low_postio;
>       MemoryRegion *bios, *bios_copy =3D g_new(MemoryRegion, 1);
> @@ -1261,13 +1260,11 @@ void mips_malta_init(MachineState *machine)
>       }
>  =20
>       /* register RAM at high address where it is undisturbed by IO */
> -    memory_region_allocate_system_memory(ram_high, NULL, "mips_malta.ram=
",
> -                                         ram_size);
> -    memory_region_add_subregion(system_memory, 0x80000000, ram_high);
> +    memory_region_add_subregion(system_memory, 0x80000000, machine->ram)=
;
>  =20
>       /* alias for pre IO hole access */
>       memory_region_init_alias(ram_low_preio, NULL, "mips_malta_low_preio=
.ram",
> -                             ram_high, 0, MIN(ram_size, 256 * MiB));
> +                             machine->ram, 0, MIN(ram_size, 256 * MiB));
>       memory_region_add_subregion(system_memory, 0, ram_low_preio);
>  =20
>       /* alias for post IO hole access, if there is enough RAM */
> @@ -1275,7 +1272,7 @@ void mips_malta_init(MachineState *machine)
>           ram_low_postio =3D g_new(MemoryRegion, 1);
>           memory_region_init_alias(ram_low_postio, NULL,
>                                    "mips_malta_low_postio.ram",
> -                                 ram_high, 512 * MiB,
> +                                 machine->ram, 512 * MiB,
>                                    ram_size - 512 * MiB);
>           memory_region_add_subregion(system_memory, 512 * MiB,
>                                       ram_low_postio);
> @@ -1447,6 +1444,7 @@ static void mips_malta_machine_init(MachineClass *m=
c)
>   #else
>       mc->default_cpu_type =3D MIPS_CPU_TYPE_NAME("24Kf");
>   #endif
> +    mc->default_ram_id =3D "mips_malta.ram";
>   }
>  =20
>   DEFINE_MACHINE("malta", mips_malta_machine_init)
>=20


