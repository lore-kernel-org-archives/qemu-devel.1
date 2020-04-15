Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1BCC2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 13:10:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAB6920737
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 13:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LMzbdmGG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAB6920737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOhnj-0003Nh-W9
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 09:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34408)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOhkZ-000435-NH
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 09:06:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOhkY-0005qj-Ib
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 09:06:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44737
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOhkY-0005qK-EY
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 09:06:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586956001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aYZmNReGK1pSGRRWpxTqQ83lTYAgY8/zZkrOB9knXOE=;
 b=LMzbdmGG3L7WcCxz/SpI1G6c34y9Auc2SHwX5a41tEuSTOt7aDkO19y9zaMw4oVkZVEXl3
 R3UBpEzvAhj6fgbVAgTVFlR5CVOyu69ST+OQIQcbXcuWmfnxbiFEj58RF+OWHRGzuxZHLa
 cuM5lfdrEB33i9CMCqk+38pUd/aGF+Q=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-bzlWLfcIOB6V1R1XGhHPAg-1; Wed, 15 Apr 2020 09:06:39 -0400
X-MC-Unique: bzlWLfcIOB6V1R1XGhHPAg-1
Received: by mail-ed1-f72.google.com with SMTP id y66so2837190ede.19
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 06:06:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KmWDByMW8BYvtmDOuU0rsLeDFfuOTOokEoaxud6LCCo=;
 b=pZRRaLoBvukqFNSx0pzI1fijk/8MD4bXQg+d6jTMz0VPVhOoBjx2yTC/oQYEO84Ily
 CC7/zs43tXml5B4g/rMBxATIfeiWaP8X2mWGFw+c/WXKqZJ+sj4vQbAggzX6+oEIDkPn
 p8fneuivgBo0pzr6QubJTvzAHLyvCfZ9UH8lAbkSvZLRSEgwR0GG0og60U6jrneF5icR
 ebHrsNG7RzKgdbLQLgQJLA/qBY4wBFqdU/DZUEdWxmmq40kT4ywG0XBROpcMH+PJoTHt
 IUkJcqwpoB0+WO4ytQkc6l6su3234okw4lz6LtbymuafNlCp3tO9n5h8KmOFT7p3VnjE
 Y/7Q==
X-Gm-Message-State: AGi0PuYTM+WX6rBSpVVzYRoTT7Rcwno3gJM+2HfrZ07QXFbwWL2fD6zk
 RvIgboW2KqDrfOCt29qLEXb57vDHy35Ghcs42LPzAPpBdbAZW+/S1gNh+deByVHasc/BzIMNrvo
 vq6N9p6w69lhzEFI=
X-Received: by 2002:a17:907:210d:: with SMTP id
 qn13mr5047915ejb.376.1586955998282; 
 Wed, 15 Apr 2020 06:06:38 -0700 (PDT)
X-Google-Smtp-Source: APiQypIh4VEoy/rVQAbilep7/r2eTOZsqH2WeB3Mt+U1p3r7qb8VVHkzq9UyhpeSnp58Xw6Xxg4p5A==
X-Received: by 2002:a17:907:210d:: with SMTP id
 qn13mr5047880ejb.376.1586955997998; 
 Wed, 15 Apr 2020 06:06:37 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id ga1sm2609400ejb.65.2020.04.15.06.06.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2020 06:06:37 -0700 (PDT)
Subject: Re: [PATCH v2 16/16] nvme: factor out controller identify setup
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
References: <20200415130159.611361-1-its@irrelevant.dk>
 <20200415130159.611361-17-its@irrelevant.dk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0bc8ad32-7c58-9c29-f15b-68d7c8615bf8@redhat.com>
Date: Wed, 15 Apr 2020 15:06:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200415130159.611361-17-its@irrelevant.dk>
Content-Language: en-US
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/15/20 3:01 PM, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>=20
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   hw/block/nvme.c | 52 +++++++++++++++++++++++++++----------------------
>   1 file changed, 29 insertions(+), 23 deletions(-)
>=20
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 4c28d75e0fc8..804f24719dce 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1422,32 +1422,11 @@ static void nvme_init_pci(NvmeCtrl *n, PCIDevice =
*pci_dev)
>       }
>   }
>  =20
> -static void nvme_realize(PCIDevice *pci_dev, Error **errp)
> +static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
>   {
> -    NvmeCtrl *n =3D NVME(pci_dev);
>       NvmeIdCtrl *id =3D &n->id_ctrl;
> -    Error *err =3D NULL;
> +    uint8_t *pci_conf =3D pci_dev->config;
>  =20
> -    int i;
> -    uint8_t *pci_conf;
> -
> -    nvme_check_constraints(n, &err);
> -    if (err) {
> -        error_propagate(errp, err);
> -        return;
> -    }
> -
> -    nvme_init_state(n);
> -
> -    nvme_init_blk(n, &err);
> -    if (err) {
> -        error_propagate(errp, err);
> -        return;
> -    }
> -
> -    nvme_init_pci(n, pci_dev);
> -
> -    pci_conf =3D pci_dev->config;
>       id->vid =3D cpu_to_le16(pci_get_word(pci_conf + PCI_VENDOR_ID));
>       id->ssvid =3D cpu_to_le16(pci_get_word(pci_conf + PCI_SUBSYSTEM_VEN=
DOR_ID));
>       strpadcpy((char *)id->mn, sizeof(id->mn), "QEMU NVMe Ctrl", ' ');
> @@ -1481,6 +1460,33 @@ static void nvme_realize(PCIDevice *pci_dev, Error=
 **errp)
>       n->bar.vs =3D 0x00010200;
>       n->bar.intmc =3D n->bar.intms =3D 0;
>  =20
> +

Spurious empty lines (no need to repost!).

To other reviewer, patch trivial to review with 'git-diff -W'.

> +}
> +
> +static void nvme_realize(PCIDevice *pci_dev, Error **errp)
> +{
> +    NvmeCtrl *n =3D NVME(pci_dev);
> +    Error *err =3D NULL;
> +
> +    int i;
> +
> +    nvme_check_constraints(n, &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +
> +
> +    nvme_init_state(n);
> +    nvme_init_blk(n, &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +
> +    nvme_init_pci(n, pci_dev);
> +    nvme_init_ctrl(n, pci_dev);
> +
>       for (i =3D 0; i < n->num_namespaces; i++) {
>           nvme_init_namespace(n, &n->namespaces[i], &err);
>           if (err) {
>=20


