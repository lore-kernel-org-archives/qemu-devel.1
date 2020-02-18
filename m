Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AC8C34031
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 07:06:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFDB4206E2
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 07:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="POa9Prf6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFDB4206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3wxZ-0004HS-6U
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 02:06:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52779)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3wwf-0003AF-5q
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 02:05:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3wwd-0000ZX-PI
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 02:05:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47615
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3wwd-0000Z2-LP
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 02:05:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582009523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xxkagkYJNDntQ8Y65/19NvgzKBsnFlE6A6JYwhXc3/o=;
 b=POa9Prf624uw4s5Z/4fs0Oh4VDomTUFPafqXy4zGahNVITMRMxvSV8bUQIwXpjh0Ivp3dD
 SMNJ2LY+9C4xhb9ZHEkdOkAsB2DaBmUeTi3KrEu3l2kZ5wgW5WhzlCFECTKq7b1/d4Zhlf
 8mprOkyLyDtis3vzLCBZ427RUh06PMc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-0JmVPaAlMfWLlyo8Mp8lFQ-1; Tue, 18 Feb 2020 02:05:19 -0500
Received: by mail-wm1-f71.google.com with SMTP id y7so722229wmd.4
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 23:05:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=p1wLLSRktDVD3pbrqykm70jh35IGn5e7x7zvJMbklZ8=;
 b=ADEYXcHc9RBHkcA/G2p6l3134kdjXcpkyZZyxIZNxdJCrGwwFCn67spqnDUQ9KtzVJ
 EnkmxCsNA/n0RTxIa46HdYOf4M88fBxxRbZ+orAGaq+ZQT3V1DxRH97tDN0fBLfopWiQ
 67Zydp7ZiWy5PE4sVIG8Caler6+mrGxETNEDVaYNAeCnBcBDRnuFR11QyiucwFlxKlDk
 KGp4nzegDn7noX/cF5cVSmvMqahnluqin5NrsMMUu549d7tUiAJCtq39h5htMQvuGNbF
 zyLjnqmU+rO5gk6UcVs9SSVJgih3J+ZL9UsMARG6E6O4Y8wLuQlIvf/DADv/Otp7L8ea
 FObg==
X-Gm-Message-State: APjAAAUxf84aNVh56swN6aTpCoW/R8cGsA3oVXheI1vX1SgrL0RjlUwe
 YuoGIv/YdDrzuDyLw8Fy4yruwrSO6BqST29Smhxqrfb88V+nP1IjMzhTU+2xKaOQL9JHWtgB7NV
 I3lccWaM9EvUvZdI=
X-Received: by 2002:a1c:67c3:: with SMTP id b186mr1292029wmc.36.1582009518119; 
 Mon, 17 Feb 2020 23:05:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqyov8lT3i7CTxe6+fAACq4dSP7cwbcKlJAgvqwGdN0qN/0ujYs4hS9ZhIzCf4Oi0h5QazOr+A==
X-Received: by 2002:a1c:67c3:: with SMTP id b186mr1291992wmc.36.1582009517811; 
 Mon, 17 Feb 2020 23:05:17 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id q130sm2465733wme.19.2020.02.17.23.05.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 23:05:17 -0800 (PST)
Subject: Re: [PATCH v5 47/79] m68k/q800: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-48-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e1eedb8c-9a05-72f8-bdd3-7b9303e58898@redhat.com>
Date: Tue, 18 Feb 2020 08:05:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-48-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: 0JmVPaAlMfWLlyo8Mp8lFQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 6:34 PM, Igor Mammedov wrote:
> Switch to using generic main RAM allocation. To do this set
> MachineClass::default_ram_id to m68k_mac.ram and use
> MachineState::ram instead of manually initializing
> RAM memory region.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Acked-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   hw/m68k/q800.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index 1e32363688..a4c4bc14cb 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -160,7 +160,6 @@ static void q800_init(MachineState *machine)
>       ram_addr_t initrd_base;
>       int32_t initrd_size;
>       MemoryRegion *rom;
> -    MemoryRegion *ram;
>       MemoryRegion *io;
>       const int io_slice_nb =3D (IO_SIZE / IO_SLICE) - 1;
>       int i;
> @@ -194,9 +193,7 @@ static void q800_init(MachineState *machine)
>       qemu_register_reset(main_cpu_reset, cpu);
>  =20
>       /* RAM */
> -    ram =3D g_malloc(sizeof(*ram));
> -    memory_region_init_ram(ram, NULL, "m68k_mac.ram", ram_size, &error_a=
bort);
> -    memory_region_add_subregion(get_system_memory(), 0, ram);
> +    memory_region_add_subregion(get_system_memory(), 0, machine->ram);
>  =20
>       /*
>        * Memory from IO_BASE to IO_BASE + IO_SLICE is repeated
> @@ -443,6 +440,7 @@ static void q800_machine_class_init(ObjectClass *oc, =
void *data)
>       mc->max_cpus =3D 1;
>       mc->is_default =3D 0;
>       mc->block_default_type =3D IF_SCSI;
> +    mc->default_ram_id =3D "m68k_mac.ram";
>   }
>  =20
>   static const TypeInfo q800_machine_typeinfo =3D {
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


