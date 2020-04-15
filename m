Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7D7C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 10:46:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A30C20737
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 10:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zf4apH/c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A30C20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOfYs-0002d4-A7
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 06:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46173)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOfXh-0008WQ-3x
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:45:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOfXf-0004kU-Tu
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:45:17 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52766
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOfXf-0004jt-Qk
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:45:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586947515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PMeokp4kxfMXp1B/fCISiKl2sfNro4rIMuyxgeys9CE=;
 b=Zf4apH/cqPxiLaxPYtWMffUKU0NXVfbJ/ps+Hx/0UMgfdOG43gl7Snxl2WrzYvRCBroRAB
 0jVJK5FI4iqs1pVyRWVFA4Toscf4TdyKD03BriGFMNZyT2RYr+EY9iZjtJ1O7tbxzSeunW
 Cg0aJguU+pcwEqpNWMQZ7XrBB7RcZu0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-oG6levw3OnSqv7k7BV37YA-1; Wed, 15 Apr 2020 06:45:13 -0400
X-MC-Unique: oG6levw3OnSqv7k7BV37YA-1
Received: by mail-ed1-f70.google.com with SMTP id j10so2523177edy.21
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 03:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Qdqev5DF4/rM/Qv0hJYVHmvlZDSOAmHGxT6dLPtHGDY=;
 b=QXDAOXGKnjwOTeh8R0LyW+f1VzADMkaoYlVYIbeSx3Cyl1PqTiVp5e5RRH8gPQqZet
 4Y87NngSH1061Zw6mECS7J71JPRhH6DxdK03nIdNwCmXY8mnMnWuO2Gx5saKRSDVbV/Y
 PL3v69E4AipIY6rg+aP71UMNEJ81QMvzYEmS2N7DWgiZazBXZc7MHYLRTAiYQBQ3ft/Y
 +FuVnfGLXYMaaUYIVDCpaMFnPTZg2oatCsr8qSZ/s6NelcCGHudnUBIQL9dMO9IXG7Qp
 TrxygPEyvFtDQzEgsdkBPJn4eE8TwSACUtJzc6aGhf5NTLUOFXSJlOWQVJpTxdt8eqYx
 eV/A==
X-Gm-Message-State: AGi0PuaPLwYqELmqbKHHN2WQ8HccPB9U4racINGmvlq21QIVHE64YeVl
 bsFxTq3S/YAWEZX87LEcrI0OokycSkBc37q2BO7pwnYtInOLqL0GFF9m++y2VZAxGZ2FlrCE0Rn
 XZ0BSGDI6yXN/w6k=
X-Received: by 2002:aa7:cf16:: with SMTP id a22mr13428632edy.77.1586947511945; 
 Wed, 15 Apr 2020 03:45:11 -0700 (PDT)
X-Google-Smtp-Source: APiQypIZJJ9a6tvBwgbNzht3h3swldo48a6ET0uDDq9i+ft+hw3/STrzUdqqV+9Yb6ZSK/GtRk5PZA==
X-Received: by 2002:aa7:cf16:: with SMTP id a22mr13428619edy.77.1586947511767; 
 Wed, 15 Apr 2020 03:45:11 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id l19sm2575412ejn.31.2020.04.15.03.45.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2020 03:45:11 -0700 (PDT)
Subject: Re: [PATCH 15/16] nvme: factor out cmb setup
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
References: <20200415102445.564803-1-its@irrelevant.dk>
 <20200415102445.564803-16-its@irrelevant.dk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <82e0183c-f2e5-7fba-0de1-79b093b7aff6@redhat.com>
Date: Wed, 15 Apr 2020 12:45:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200415102445.564803-16-its@irrelevant.dk>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/15/20 12:24 PM, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>=20
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>   hw/block/nvme.c | 50 +++++++++++++++++++++++++++----------------------
>   1 file changed, 28 insertions(+), 22 deletions(-)
>=20
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 16d01af53a07..7387cf409f96 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -44,6 +44,8 @@
>   #include "trace.h"
>   #include "nvme.h"
>  =20
> +#define NVME_CMB_BIR 2
> +
>   #define NVME_GUEST_ERR(trace, fmt, ...) \
>       do { \
>           (trace_##trace)(__VA_ARGS__); \
> @@ -1382,6 +1384,28 @@ static int nvme_init_namespace(NvmeCtrl *n, NvmeNa=
mespace *ns, Error **errp)
>       return 0;
>   }
>  =20
> +static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *pci_dev)
> +{
> +    NVME_CMBLOC_SET_BIR(n->bar.cmbloc, NVME_CMB_BIR);
> +    NVME_CMBLOC_SET_OFST(n->bar.cmbloc, 0);
> +
> +    NVME_CMBSZ_SET_SQS(n->bar.cmbsz, 1);
> +    NVME_CMBSZ_SET_CQS(n->bar.cmbsz, 0);
> +    NVME_CMBSZ_SET_LISTS(n->bar.cmbsz, 0);
> +    NVME_CMBSZ_SET_RDS(n->bar.cmbsz, 1);
> +    NVME_CMBSZ_SET_WDS(n->bar.cmbsz, 1);
> +    NVME_CMBSZ_SET_SZU(n->bar.cmbsz, 2);

We lost the /* MBs */ comment, otherwise:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +    NVME_CMBSZ_SET_SZ(n->bar.cmbsz, n->params.cmb_size_mb);
> +
> +    n->cmbuf =3D g_malloc0(NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
> +    memory_region_init_io(&n->ctrl_mem, OBJECT(n), &nvme_cmb_ops, n,
> +                          "nvme-cmb", NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
> +    pci_register_bar(pci_dev, NVME_CMBLOC_BIR(n->bar.cmbloc),
> +                     PCI_BASE_ADDRESS_SPACE_MEMORY |
> +                     PCI_BASE_ADDRESS_MEM_TYPE_64 |
> +                     PCI_BASE_ADDRESS_MEM_PREFETCH, &n->ctrl_mem);
> +}
> +
>   static void nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev)
>   {
>       uint8_t *pci_conf =3D pci_dev->config;
> @@ -1398,6 +1422,10 @@ static void nvme_init_pci(NvmeCtrl *n, PCIDevice *=
pci_dev)
>       pci_register_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
>                        PCI_BASE_ADDRESS_MEM_TYPE_64, &n->iomem);
>       msix_init_exclusive_bar(pci_dev, n->params.max_ioqpairs + 1, 4, NUL=
L);
> +
> +    if (n->params.cmb_size_mb) {
> +        nvme_init_cmb(n, pci_dev);
> +    }
>   }
>  =20
>   static void nvme_realize(PCIDevice *pci_dev, Error **errp)
> @@ -1454,28 +1482,6 @@ static void nvme_realize(PCIDevice *pci_dev, Error=
 **errp)
>       n->bar.vs =3D 0x00010200;
>       n->bar.intmc =3D n->bar.intms =3D 0;
>  =20
> -    if (n->params.cmb_size_mb) {
> -
> -        NVME_CMBLOC_SET_BIR(n->bar.cmbloc, 2);
> -        NVME_CMBLOC_SET_OFST(n->bar.cmbloc, 0);
> -
> -        NVME_CMBSZ_SET_SQS(n->bar.cmbsz, 1);
> -        NVME_CMBSZ_SET_CQS(n->bar.cmbsz, 0);
> -        NVME_CMBSZ_SET_LISTS(n->bar.cmbsz, 0);
> -        NVME_CMBSZ_SET_RDS(n->bar.cmbsz, 1);
> -        NVME_CMBSZ_SET_WDS(n->bar.cmbsz, 1);
> -        NVME_CMBSZ_SET_SZU(n->bar.cmbsz, 2); /* MBs */
> -        NVME_CMBSZ_SET_SZ(n->bar.cmbsz, n->params.cmb_size_mb);
> -
> -        n->cmbuf =3D g_malloc0(NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
> -        memory_region_init_io(&n->ctrl_mem, OBJECT(n), &nvme_cmb_ops, n,
> -                              "nvme-cmb", NVME_CMBSZ_GETSIZE(n->bar.cmbs=
z));
> -        pci_register_bar(pci_dev, NVME_CMBLOC_BIR(n->bar.cmbloc),
> -            PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64=
 |
> -            PCI_BASE_ADDRESS_MEM_PREFETCH, &n->ctrl_mem);
> -
> -    }
> -
>       for (i =3D 0; i < n->num_namespaces; i++) {
>           if (nvme_init_namespace(n, &n->namespaces[i], errp)) {
>               return;
>=20


