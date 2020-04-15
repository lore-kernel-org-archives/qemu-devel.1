Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEF8C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 11:09:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9433720775
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 11:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BebcAEfG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9433720775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOfur-0003P6-Jl
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 07:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49073)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOftU-0002kA-K5
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 07:07:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOftT-0007ME-8W
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 07:07:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40814
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOftT-0007Lq-5F
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 07:07:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586948866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vuRjiW6K355m4ZIkGRZbYqOTsoz1eEcin5chNHDC1hA=;
 b=BebcAEfGK0Pb3znzlG6M1vxtNstsoFYyzoeHPb85P3BdTWEVInm/DLw2xRMDr5BR7Vg7C5
 KlKEpXDZzcOGxMiqbjFn+1/HrwQ7sPDwKcG90Io8yvB3v0yDVBzaG4ik1Q7bgnFadPYDXc
 uFKNnFDqQ4O9tWaqG8uiO5MuhMcWr5w=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-4Jdvl7RhMzu5XqXFFU8HRQ-1; Wed, 15 Apr 2020 07:07:45 -0400
X-MC-Unique: 4Jdvl7RhMzu5XqXFFU8HRQ-1
Received: by mail-ed1-f70.google.com with SMTP id p6so2556423edy.22
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 04:07:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HChbPDstOOs+qCl/z4KHH5YCguFcramZEsdfDaJVuSU=;
 b=qqpKI0lrBnYJ910QfiQqBMhydt64HmQAy8o0xuUFNRKS0GEyQxgfz8qfaVlFaoqJPB
 Go5wcrcmR5fipNLcQMSen66mtylEMD3GAz2UPMtJDHjnsNd72ZEN5pBSE0dEI6TJ0rLb
 YXHObCZoHj3ONsooev/YxhHG/6LAS033O175o9yzQ6x20YJvzK6ccZIE2YBd7HgRPdDq
 5TtJa/yoYPb92luDOik5PhggcAQ8CVsFBtbkEMMcdAVjpFj7xD1zy2pet16K8JFdyjnP
 8rb14u4+Rk1QWX/i3I3lfeEzbZNFfwbQIzzkROjgzM7Kw47bhEEOkkC2dkJ131oCPjiR
 YOrg==
X-Gm-Message-State: AGi0PuaKtyU0Q2shx4xDkAfe0Co4YJJd1Z0d4tNnt+tTlBrGDlr5oq94
 wtzYsrpYTeHTw7vDwcMGNw7MHscMGafNDZRImD2qq+ycRjTn92JlE/Nu1JyXmWt+gcNjn1e22cP
 YLXpmkYXcp7QX/gg=
X-Received: by 2002:a50:9346:: with SMTP id n6mr25755536eda.320.1586948864161; 
 Wed, 15 Apr 2020 04:07:44 -0700 (PDT)
X-Google-Smtp-Source: APiQypLWENnYvnUdjpE/5RL781CfTxRtkMtv5IYU80oNrCa4AydFA3cWTLur8edNDTTaqdSI746+Qg==
X-Received: by 2002:a50:9346:: with SMTP id n6mr25755514eda.320.1586948863947; 
 Wed, 15 Apr 2020 04:07:43 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id l20sm328218edr.54.2020.04.15.04.07.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2020 04:07:43 -0700 (PDT)
Subject: Re: [PATCH 16/16] nvme: factor out controller identify setup
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
References: <20200415102445.564803-1-its@irrelevant.dk>
 <20200415102445.564803-17-its@irrelevant.dk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <fa467e86-9c65-5404-9a02-f4fbe6063d30@redhat.com>
Date: Wed, 15 Apr 2020 13:07:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200415102445.564803-17-its@irrelevant.dk>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
>   hw/block/nvme.c | 42 ++++++++++++++++++++++++------------------
>   1 file changed, 24 insertions(+), 18 deletions(-)

The review is trivial using 'git-diff -W'.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>=20
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 7387cf409f96..d1566b56381d 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1428,27 +1428,11 @@ static void nvme_init_pci(NvmeCtrl *n, PCIDevice =
*pci_dev)
>       }
>   }
>  =20
> -static void nvme_realize(PCIDevice *pci_dev, Error **errp)
> +static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
>   {
> -    NvmeCtrl *n =3D NVME(pci_dev);
>       NvmeIdCtrl *id =3D &n->id_ctrl;
> +    uint8_t *pci_conf =3D pci_dev->config;
>  =20
> -    int i;
> -    uint8_t *pci_conf;
> -
> -    if (nvme_check_constraints(n, errp)) {
> -        return;
> -    }
> -
> -    nvme_init_state(n);
> -
> -    if (nvme_init_blk(n, errp)) {
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
> @@ -1482,6 +1466,28 @@ static void nvme_realize(PCIDevice *pci_dev, Error=
 **errp)
>       n->bar.vs =3D 0x00010200;
>       n->bar.intmc =3D n->bar.intms =3D 0;
>  =20
> +
> +}
> +
> +static void nvme_realize(PCIDevice *pci_dev, Error **errp)
> +{
> +    NvmeCtrl *n =3D NVME(pci_dev);
> +
> +    int i;
> +
> +    if (nvme_check_constraints(n, errp)) {
> +        return;
> +    }
> +
> +    nvme_init_state(n);
> +
> +    if (nvme_init_blk(n, errp)) {
> +        return;
> +    }
> +
> +    nvme_init_pci(n, pci_dev);
> +    nvme_init_ctrl(n, pci_dev);
> +
>       for (i =3D 0; i < n->num_namespaces; i++) {
>           if (nvme_init_namespace(n, &n->namespaces[i], errp)) {
>               return;
>=20


