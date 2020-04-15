Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F57C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 13:18:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 012EF20575
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 13:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bAWrvwVy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 012EF20575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOhvk-0008FX-3F
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 09:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOhuc-0006cD-JK
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 09:17:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOhub-0001Vh-CV
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 09:17:06 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47209
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOhub-0001VX-9W
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 09:17:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586956625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ezGOSjRBDdZNTydU70FNJ11qo6iDj5/jX3I/nUlIsHA=;
 b=bAWrvwVy6PkvvrXSs1KJuTt2PI+bEYZLnInzzg2niKebMajzXnAwVsZZygeBYV9Wy5647K
 8ALMy+AaiVME2aXd34ioEX0qH6T/DhW9WOB1vv5iRXJWC/2Soo3WPulXHFX/hGCe8/EWGn
 yEX4yu+0ahW1C8CJe2aywbGRO8+WADc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-B-yUtzI_MBmLhL6n2yDPdg-1; Wed, 15 Apr 2020 09:17:03 -0400
X-MC-Unique: B-yUtzI_MBmLhL6n2yDPdg-1
Received: by mail-ed1-f71.google.com with SMTP id y6so2876444edo.18
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 06:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nzoBjtHh/HGZpYAXZt6YkHxCX6Ujn/3Ekx7EQ1jOE7M=;
 b=PnpjedR/cRS9kDgB7rGtoXQaSqIpMhRaBj1phjs36Q9y7hShbMNonWqr38oSEdbZMq
 Dgi2mFRccPvkWG4j6GlpHx0eRObKbq5XaSOxoFxSF5zZxFqKqE1flfTxNdQHXdG6Ae5B
 qx5ZH3WyfpgrqqcocVtFF7PXTxIMm0NkSPr5APfu71c3m6SWlhgcEjoYOlrOqMh2+Vza
 zu/XP23k3VbhQfD4VeKdOsi37ljNactKF4TPa+i8MtsbuNwuj7WU8aRoyZVSfKBJGVwy
 ciSn6aM0OZ0eexIJ5nEz9mtf4NGvOUA58ZBkHX2I0InU4R0+sVp8qzWAxuhtTjbM16mv
 3e0w==
X-Gm-Message-State: AGi0PuZu08MuseIdb5eCip5G+oanCXkvYZctdczM3i8/3dmwNDkJwxY+
 B8F06Q6IyCSFisGJ1BCpO871H7166FOfJ/a/Uwb9gSrhBqy8iXxE8IlMG5gIpOVUeCQdgixId0f
 38nb770rAcgdOib4=
X-Received: by 2002:a17:906:855a:: with SMTP id
 h26mr5208764ejy.56.1586956620997; 
 Wed, 15 Apr 2020 06:17:00 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ2b2Qt8Ehr63xvRdWBzJyS9s5KRdylNP0V4jpQFVd7lUFUnHKgAVGf98IGNlAnRSZUyD7sng==
X-Received: by 2002:a17:906:855a:: with SMTP id
 h26mr5208741ejy.56.1586956620750; 
 Wed, 15 Apr 2020 06:17:00 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id p22sm2621290ejd.24.2020.04.15.06.16.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2020 06:17:00 -0700 (PDT)
Subject: Re: [PATCH v2 13/16] nvme: factor out namespace setup
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
References: <20200415130159.611361-1-its@irrelevant.dk>
 <20200415130159.611361-14-its@irrelevant.dk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b05fdbb7-2f74-be05-e108-36b14abce0be@redhat.com>
Date: Wed, 15 Apr 2020 15:16:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200415130159.611361-14-its@irrelevant.dk>
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

On 4/15/20 3:01 PM, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>=20
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>   hw/block/nvme.c | 46 ++++++++++++++++++++++++++--------------------
>   1 file changed, 26 insertions(+), 20 deletions(-)
>=20
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index d5244102252c..2b007115c302 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1358,6 +1358,27 @@ static void nvme_init_blk(NvmeCtrl *n, Error **err=
p)
>                                     false, errp);
>   }
>  =20
> +static void nvme_init_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **=
errp)
> +{
> +    int64_t bs_size;
> +    NvmeIdNs *id_ns =3D &ns->id_ns;
> +
> +    bs_size =3D blk_getlength(n->conf.blk);
> +    if (bs_size < 0) {
> +        error_setg_errno(errp, -bs_size, "could not get backing file siz=
e");
> +        return;
> +    }
> +
> +    n->ns_size =3D bs_size;
> +
> +    id_ns->lbaf[0].ds =3D BDRV_SECTOR_BITS;
> +    id_ns->nsze =3D cpu_to_le64(nvme_ns_nlbas(n, ns));
> +
> +    /* no thin provisioning */
> +    id_ns->ncap =3D id_ns->nsze;
> +    id_ns->nuse =3D id_ns->ncap;
> +}
> +
>   static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>   {
>       NvmeCtrl *n =3D NVME(pci_dev);
> @@ -1365,7 +1386,6 @@ static void nvme_realize(PCIDevice *pci_dev, Error =
**errp)
>       Error *err =3D NULL;
>  =20
>       int i;
> -    int64_t bs_size;
>       uint8_t *pci_conf;
>  =20
>       nvme_check_constraints(n, &err);
> @@ -1376,12 +1396,6 @@ static void nvme_realize(PCIDevice *pci_dev, Error=
 **errp)
>  =20
>       nvme_init_state(n);
>  =20
> -    bs_size =3D blk_getlength(n->conf.blk);
> -    if (bs_size < 0) {
> -        error_setg(errp, "could not get backing file size");
> -        return;
> -    }
> -
>       nvme_init_blk(n, &err);
>       if (err) {
>           error_propagate(errp, err);
> @@ -1394,8 +1408,6 @@ static void nvme_realize(PCIDevice *pci_dev, Error =
**errp)
>       pci_config_set_class(pci_dev->config, PCI_CLASS_STORAGE_EXPRESS);
>       pcie_endpoint_cap_init(pci_dev, 0x80);
>  =20
> -    n->ns_size =3D bs_size / (uint64_t)n->num_namespaces;

Valid because currently 'n->num_namespaces' =3D 1, OK.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>       memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n,
>                             "nvme", n->reg_size);
>       pci_register_bar(pci_dev, 0,
> @@ -1459,17 +1471,11 @@ static void nvme_realize(PCIDevice *pci_dev, Erro=
r **errp)
>       }
>  =20
>       for (i =3D 0; i < n->num_namespaces; i++) {
> -        NvmeNamespace *ns =3D &n->namespaces[i];
> -        NvmeIdNs *id_ns =3D &ns->id_ns;
> -        id_ns->nsfeat =3D 0;
> -        id_ns->nlbaf =3D 0;
> -        id_ns->flbas =3D 0;
> -        id_ns->mc =3D 0;
> -        id_ns->dpc =3D 0;
> -        id_ns->dps =3D 0;
> -        id_ns->lbaf[0].ds =3D BDRV_SECTOR_BITS;
> -        id_ns->ncap  =3D id_ns->nuse =3D id_ns->nsze =3D
> -            cpu_to_le64(nvme_ns_nlbas(n, ns));
> +        nvme_init_namespace(n, &n->namespaces[i], &err);
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
>       }
>   }
>  =20
>=20


