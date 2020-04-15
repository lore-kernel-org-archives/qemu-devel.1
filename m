Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693C9C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 10:54:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30B0320737
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 10:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HUHiZH1Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30B0320737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOfh0-0002SO-9w
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 06:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47251)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOfgL-0001gk-Ic
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:54:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOfgK-00078D-BP
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:54:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25738
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOfgK-00077m-8K
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586948051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vj80duoML+OQ/QTPbceCzS4qvxV//FtgalmUsGw+Fxk=;
 b=HUHiZH1ZmS9GPlEj+6lH3vy8LTM5Lnga3K3ecof29xqa3KuqNP4YMFM3khbdwIm8OoEeki
 1jtTYrU9UqbkOi/XzatQvZGscosGsCWpZpN5TEQpmkBW34gmYqxxnglGV3oH0YcU2QDjfE
 KK8nMzd+vUFK6c3Vx9QA80wzBHA5v7E=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-NoEjxIhRMHa48g2AFkZRXA-1; Wed, 15 Apr 2020 06:54:08 -0400
X-MC-Unique: NoEjxIhRMHa48g2AFkZRXA-1
Received: by mail-ed1-f69.google.com with SMTP id p6so2530377edy.22
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 03:54:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=M0OYUw4ByIqnV03u/dlJkEFKVwvzMbXaaJGKi3dFKIw=;
 b=swBulue2anehxmy9wZ03CZJb/xaW6fHNbg/S2s8gkfGgrG5zQsB++mObtNCvRKpaa3
 yBkRC2dk2ZOx8M1RNHRHL8q5J3zMb/GCbeS3wbl9rmbAlFk9xxbfZOqFfT56aPu4Dt+W
 spzTiAvqGH4EqQwltbNuzgJKzIY9zy7EQCNo9JGRezudCTCL48Q1uR2g6Den2z9DaaOq
 n2kF44OO1nvdv0vrOkoeER+K91HTU+z6qW/agj1laCeV40CxzMN9qbFZkmB38G6GAfud
 iOfkrJD/n5cNQGSkK7JeBKVfDgJ2nNdA37loLJVQu1CmWHqr4ZbNA7EbVu3it4hDFx86
 vcTg==
X-Gm-Message-State: AGi0PuZ7v1PM5YLKKJprksg3u8owAPDcFd8pZmq7jwuZAwrhiwJ9ICQY
 gHNBoTcwDew/X/LOiqpvvwCuQscRiPgTrAeK1pHDa0YXpz0RiV90Qx+Xpit1hZFnlWHgv8Z0gmv
 D6Iz35mkI1+OWIOQ=
X-Received: by 2002:a05:6402:31b6:: with SMTP id
 dj22mr12470613edb.258.1586948047057; 
 Wed, 15 Apr 2020 03:54:07 -0700 (PDT)
X-Google-Smtp-Source: APiQypJUX/yeWra1xIIznxwj+zOnakBE1ib9AHBhB4p7JT2pNeyuJMwxo/bCaoIf/YjCKQAkIELXww==
X-Received: by 2002:a05:6402:31b6:: with SMTP id
 dj22mr12470607edb.258.1586948046898; 
 Wed, 15 Apr 2020 03:54:06 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id h22sm2104720edw.34.2020.04.15.03.54.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2020 03:54:06 -0700 (PDT)
Subject: Re: [PATCH 10/16] nvme: factor out device state setup
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
References: <20200415102445.564803-1-its@irrelevant.dk>
 <20200415102445.564803-11-its@irrelevant.dk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a57b5a83-4464-bcd5-99f3-d682496c995c@redhat.com>
Date: Wed, 15 Apr 2020 12:54:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200415102445.564803-11-its@irrelevant.dk>
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

On 4/15/20 12:24 PM, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>=20
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>   hw/block/nvme.c | 17 +++++++++++------
>   1 file changed, 11 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 635292d6fac4..e67f578fbf79 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1339,6 +1339,15 @@ static int nvme_check_constraints(NvmeCtrl *n, Err=
or **errp)
>       return 0;
>   }
>  =20
> +static void nvme_init_state(NvmeCtrl *n)
> +{
> +    n->num_namespaces =3D 1;
> +    n->reg_size =3D pow2ceil(0x1008 + 2 * (n->params.max_ioqpairs) * 4);
> +    n->namespaces =3D g_new0(NvmeNamespace, n->num_namespaces);
> +    n->sq =3D g_new0(NvmeSQueue *, n->params.max_ioqpairs + 1);
> +    n->cq =3D g_new0(NvmeCQueue *, n->params.max_ioqpairs + 1);
> +}
> +
>   static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>   {
>       NvmeCtrl *n =3D NVME(pci_dev);
> @@ -1352,6 +1361,8 @@ static void nvme_realize(PCIDevice *pci_dev, Error =
**errp)
>           return;
>       }
>  =20
> +    nvme_init_state(n);
> +
>       bs_size =3D blk_getlength(n->conf.blk);
>       if (bs_size < 0) {
>           error_setg(errp, "could not get backing file size");
> @@ -1370,14 +1381,8 @@ static void nvme_realize(PCIDevice *pci_dev, Error=
 **errp)
>       pci_config_set_class(pci_dev->config, PCI_CLASS_STORAGE_EXPRESS);
>       pcie_endpoint_cap_init(pci_dev, 0x80);
>  =20
> -    n->num_namespaces =3D 1;
> -    n->reg_size =3D pow2ceil(0x1008 + 2 * (n->params.max_ioqpairs) * 4);
>       n->ns_size =3D bs_size / (uint64_t)n->num_namespaces;
>  =20
> -    n->namespaces =3D g_new0(NvmeNamespace, n->num_namespaces);
> -    n->sq =3D g_new0(NvmeSQueue *, n->params.max_ioqpairs + 1);
> -    n->cq =3D g_new0(NvmeCQueue *, n->params.max_ioqpairs + 1);
> -
>       memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n,
>                             "nvme", n->reg_size);
>       pci_register_bar(pci_dev, 0,
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


