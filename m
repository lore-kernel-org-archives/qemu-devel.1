Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEEEC33CB3
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 18:24:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B14032073A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 18:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EOXx0fFm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B14032073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is9pA-0003Cc-M4
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 13:24:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36407)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1is9mc-0000h1-Qm
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 13:22:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1is9mZ-00013p-Bu
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 13:22:18 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22348
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1is9mZ-000138-7c
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 13:22:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579198934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rhWoR3Ih7/md/kmjJ9inJ8JlkIrkEedEevUNAczPh9M=;
 b=EOXx0fFmigb+RrCdY9qUNesx0J7B198DPF4/OOVjOJ8WyWkSHdaAl7t9xXjN6MLhp1n72D
 ehHK+kMWA1jr9FHjS0bg4bGe1Uay46rcG64fy00piZC7xDReQI7CNrmeMJ1Zc2tNI7EoMv
 3AXwldSok1CByeZ9CWG7wIT7Dbl5Qjs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-gFAVKRTDNdCSVax0UdXVWQ-1; Thu, 16 Jan 2020 13:22:13 -0500
Received: by mail-wr1-f71.google.com with SMTP id z10so9473159wrt.21
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 10:22:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qtCklIdwpPVYr8Ly0ddeLirsK2OiFfS7Z5uBy8Fp7LM=;
 b=BDexyzF59SKixWs1UsClq0BN7Gcz/INL0C7q5XduPj5ebdk1hYK9PaH8+2SyIOixG0
 xQNosC+qVVcDN9np4ZPhbwQiFASWrVqWY4CCfdU4rSGdwpQ6rdOubpKQSTCuPiiid/rE
 NgGMwhlqcV9AgK+YuI3M3Bfti3lznXOb0RzxpS0JKYtoMnkBvw/b+TrtKMb40+LgTVvq
 3p1eQsH6kS3HXNHjNWmbqQi4PRIghHoZ6/vAw0oiO53j7twShYTYXngjOIV90FgeUJ76
 qThISaou5kp32mGm+4W6oJ1IIRF+X6QYNQLkiccVqvXLwGh8ObGZvagrkqq7c57L9Btv
 uD8g==
X-Gm-Message-State: APjAAAWCIB+fZVeosjZ5e3pKjH5ox8ot3C2oQ3nn3CHZn4an1TTT2c1V
 HePCpEqQI7aySJMaqGu4fMu9ZjGZNtspgI94dfQHx/nopquNF6nVSrpFkJ/WMArRxr6Uv5XdaDB
 zxx88rAYZZj1qVAc=
X-Received: by 2002:a05:600c:248:: with SMTP id 8mr300044wmj.175.1579198932402; 
 Thu, 16 Jan 2020 10:22:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqzVf7cf9OViQS7i2j1VE5qIOsxIEk2vSX+ypOQLB9IrOb3Fhjbt9cRvzcfSrQmTU7l5qu2OoA==
X-Received: by 2002:a05:600c:248:: with SMTP id 8mr300030wmj.175.1579198932228; 
 Thu, 16 Jan 2020 10:22:12 -0800 (PST)
Received: from [10.101.1.81] ([176.12.107.132])
 by smtp.gmail.com with ESMTPSA id 2sm29598142wrq.31.2020.01.16.10.22.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2020 10:22:11 -0800 (PST)
Subject: Re: [PATCH v3 18/86] arm:kzm: drop RAM size fixup
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <87sgkgv6dh.wl-Peter.Chubb@data61.csiro.au>
 <1579195564-95459-1-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <dc8d8594-0bf8-e6c2-9ce8-94bf5361bca3@redhat.com>
Date: Thu, 16 Jan 2020 19:22:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1579195564-95459-1-git-send-email-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: gFAVKRTDNdCSVax0UdXVWQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Peter.Chubb@data61.csiro.au, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 peter.chubb@nicta.com.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/16/20 6:26 PM, Igor Mammedov wrote:
> If the user provided too large a RAM size, the code used to
> complain and trim it to the max size.  Now tht RAM is allocated by
> generic code, that's no longer possible, so generate an error and
> exit instead.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v3:
>   * rephrase commit message in nicer way
>     ("Chubb, Peter (Data61, Kensington NSW)" <Peter.Chubb@data61.csiro.au=
>)
>   * reword error message and use size_to_str() to pretty print suggested =
size
>     ("Chubb, Peter (Data61, Kensington NSW)" <Peter.Chubb@data61.csiro.au=
>)
>=20
> CC: peter.chubb@nicta.com.au
> CC: peter.maydell@linaro.org
> CC: qemu-arm@nongnu.org
> ---
>   hw/arm/kzm.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
> index 1d5ef28..94cbac1 100644
> --- a/hw/arm/kzm.c
> +++ b/hw/arm/kzm.c
> @@ -25,6 +25,7 @@
>   #include "hw/char/serial.h"
>   #include "sysemu/qtest.h"
>   #include "sysemu/sysemu.h"
> +#include "qemu/cutils.h"
>  =20
>   /* Memory map for Kzm Emulation Baseboard:
>    * 0x00000000-0x7fffffff See i.MX31 SOC for support
> @@ -78,10 +79,10 @@ static void kzm_init(MachineState *machine)
>  =20
>       /* Check the amount of memory is compatible with the SOC */
>       if (machine->ram_size > (FSL_IMX31_SDRAM0_SIZE + FSL_IMX31_SDRAM1_S=
IZE)) {
> -        warn_report("RAM size " RAM_ADDR_FMT " above max supported, "
> -                    "reduced to %x", machine->ram_size,
> -                    FSL_IMX31_SDRAM0_SIZE + FSL_IMX31_SDRAM1_SIZE);
> -        machine->ram_size =3D FSL_IMX31_SDRAM0_SIZE + FSL_IMX31_SDRAM1_S=
IZE;
> +        char *sz =3D size_to_str(FSL_IMX31_SDRAM0_SIZE + FSL_IMX31_SDRAM=
1_SIZE);
> +        error_report("RAM size more than %s is not supported", sz);

Yay! Can you use this pattern the other patches too?

You might want to add:

#define FSL_IMX31_SDRAM_SIZE_MAX \
   (FSL_IMX31_SDRAM0_SIZE + FSL_IMX31_SDRAM1_SIZE)

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +        g_free(sz);
> +        exit(EXIT_FAILURE);
>       }
>  =20
>       memory_region_allocate_system_memory(&s->ram, NULL, "kzm.ram",
>=20


