Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6CAC33C9E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 05:59:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1E9E20661
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 05:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GebbII9V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1E9E20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyUm4-0006zL-PY
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 00:59:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54339)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iyUlR-0006S6-Ad
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 00:59:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iyUlP-0004Tt-LK
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 00:59:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56593
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iyUlP-0004Sb-CY
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 00:59:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580709554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JilRq2G0wITt587+JPxieXy/FJ6wJ4ro9ibefJPSTao=;
 b=GebbII9VJ08NQtj6FwWqrmRY5q6RRPgiBJCujgNWxZx5u6IKbrMQUiQO5Fmu2o+94raycr
 CTtOHe4ktyhoHIN7E+kCUoI5OJWhq5iqV5whusOXoeMmgJrl8TnkFapzEgfXDo5OeDUrsQ
 3qyvrjS25e2ti+96ICmy9opCd6/f/Bk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-i8ZWAv_4NVKEBLZoiQQNJg-1; Mon, 03 Feb 2020 00:59:10 -0500
Received: by mail-wm1-f71.google.com with SMTP id o193so4361780wme.8
 for <qemu-devel@nongnu.org>; Sun, 02 Feb 2020 21:59:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=CCq6igyFtUFryHiJc1GtZp0OM7WgPr9yBIGGvwacZQY=;
 b=Wumhg4nZkLIg7KmwWjpDKw2vbDcPju0WfzOLZqgENO4CIKAVTYjYbAlNoZ8RUGFCiK
 XWbbzkWQEJ4Hw0UJgBu7HvIDa/Pafk0VSHB8cpLD3FtBsU4qNgALZxl2VBClREZgUsQV
 QYVeGPwrtsJomU7p4IWL6W4uHO3VD7AzLTL46tVKuWMbw6u2+zmjXF3+E4bQAIJS6wLe
 zScucS4mI3hqucCi0Dek695fYSwO/EQLZeFtcNLa72rRtfOv1dyEdwUZxtbC1HEHhvHV
 wMDBW5l8luZDa+2CS0gkHSsL/Fzp5eC2xXogVnZWV5qBGjOXPffUvSgvCLqZ9YKsDe1b
 DTmg==
X-Gm-Message-State: APjAAAXPfoKcxMB8sm9+jJBcLWxvWvTgrsLfNgfvuZJRKAUcAqyJevz2
 oh7Bu7UPEROURdflRbxwopcIUsScgYHy0RSFUbCYWkfFeQ3aXzRTptogUX3BKTIEZlv+NjzY1aY
 f/5heITPWEsXoCLI=
X-Received: by 2002:a1c:7717:: with SMTP id t23mr27988157wmi.17.1580709549643; 
 Sun, 02 Feb 2020 21:59:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqxPvQ13PBNzLqRmNMF2hKWFsOmuvGLAck4jAPYSeWnlaAfakWoj01iXMIsfJ+V2xX/oB9qVjQ==
X-Received: by 2002:a1c:7717:: with SMTP id t23mr27988133wmi.17.1580709549404; 
 Sun, 02 Feb 2020 21:59:09 -0800 (PST)
Received: from redhat.com (ip-82-36-244-173.west.us.northamericancoax.com.
 [173.244.36.82])
 by smtp.gmail.com with ESMTPSA id h10sm21912241wre.3.2020.02.02.21.59.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Feb 2020 21:59:08 -0800 (PST)
Date: Mon, 3 Feb 2020 00:59:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heyi Guo <guoheyi@huawei.com>
Subject: Re: [PATCH v2 5/7] arm/acpi: fix duplicated _UID of PCI interrupt
 link devices
Message-ID: <20200203005841-mutt-send-email-mst@kernel.org>
References: <20200203001505.52573-1-guoheyi@huawei.com>
 <20200203001505.52573-6-guoheyi@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200203001505.52573-6-guoheyi@huawei.com>
X-MC-Unique: i8ZWAv_4NVKEBLZoiQQNJg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, wanghaibin.wang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 03, 2020 at 08:15:03AM +0800, Heyi Guo wrote:
> Using _UID of 0 for all PCI interrupt link devices absolutely violates
> the spec. Simply increase one by one.
>=20
> Signed-off-by: Heyi Guo <guoheyi@huawei.com>


Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
> Cc: qemu-arm@nongnu.org
> Cc: qemu-devel@nongnu.org
> ---
>  hw/arm/virt-acpi-build.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 5d157a9dd5..f3e340b172 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -189,7 +189,7 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMa=
pEntry *memmap,
>          uint32_t irqs =3D  irq + i;
>          Aml *dev_gsi =3D aml_device("GSI%d", i);
>          aml_append(dev_gsi, aml_name_decl("_HID", aml_string("PNP0C0F"))=
);
> -        aml_append(dev_gsi, aml_name_decl("_UID", aml_int(0)));
> +        aml_append(dev_gsi, aml_name_decl("_UID", aml_int(i)));
>          crs =3D aml_resource_template();
>          aml_append(crs,
>                     aml_interrupt(AML_CONSUMER, AML_LEVEL, AML_ACTIVE_HIG=
H,
> --=20
> 2.19.1


