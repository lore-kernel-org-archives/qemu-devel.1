Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8500C2BB85
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 07:41:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A42B3206D9
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 07:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EDcYo0jW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A42B3206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOcfi-0006Sf-S6
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 03:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48891)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOcf6-0005sD-FD
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:40:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOcf5-0004Hu-6q
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:40:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20004
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOcf5-0004Ha-3I
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:40:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586936442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wXCJh9zccH4VqOOFszYc3qNmMrzOy/PRjv83SIfZ6dc=;
 b=EDcYo0jWb9GjYaG8T76X3PLlli0U+bGgphLeBbMhrwghx9wrwiCnA280vqeMdjlc0moSHP
 SFHvFOCjsZ5a6EQdjRwHdXisBg1US98t5XV26i4vs26hGWNJ5DefRvLl4Fdpc3E3OZ2U6z
 SsKgqned+PdYMXcsRxjBqL4HFhwX8M8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-oUw-vmNYPCeIqGnTtRI5uw-1; Wed, 15 Apr 2020 03:40:40 -0400
X-MC-Unique: oUw-vmNYPCeIqGnTtRI5uw-1
Received: by mail-ed1-f70.google.com with SMTP id b7so2189040edz.9
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 00:40:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=t+Xn2zNT2kUTBfE8KDI0ixi2j93XkfQLlRLlFhHPcVU=;
 b=Y0vuDlT3FSFnnfyXv8ciQX8nvug0+9wxvWGujPbjPTZECCaHP/GK3goedhb+RPOInm
 /L7eGm+/suqwr5qTlIxxk3FCVAjounlE7QVOWbIaaPlNSQ63tUQu/lyprIDflYGqhU5C
 rAKk2NpZCAs6wP+dA7BtGiY4JpyinTDeBk5RUEXTOptsBrzAmZbfClusiyijxARl6sZR
 9IAAUU7EZR3/Q9da5jfVyOZzk/W98386Px7ZbHlV8QPmE7DxUNpEAVt8DQp4uF7mnrAw
 i1/ZXhzdJsO+ZpUuLU6T4oSM0EMFM72smx4FAVjc8mVdyMGkRCVaePIfJ0C6r1p0E4NC
 hB7Q==
X-Gm-Message-State: AGi0PuaRWvUQvF15gccg6E1EsOyb5nm5w6snXqtANmm+r2iPH3VYJQ6W
 wC6jrhu7pcoJh/7fxPAHG7Hzsuvsj8xzZNpmzDVzsskO+u1CyadHzeqL0FdkfH9QrDiLJ34Rwfy
 /VJRihq1mqtkR1zI=
X-Received: by 2002:a50:b412:: with SMTP id b18mr2948126edh.42.1586936439333; 
 Wed, 15 Apr 2020 00:40:39 -0700 (PDT)
X-Google-Smtp-Source: APiQypJmtrtjhgTo798b0S2xUB6klwVo/hvF0L2wXzozG0Oz80dDflsm8pXHaN29b1HE2ro25x5QpA==
X-Received: by 2002:a50:b412:: with SMTP id b18mr2948116edh.42.1586936439114; 
 Wed, 15 Apr 2020 00:40:39 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id b13sm1940545eje.13.2020.04.15.00.40.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2020 00:40:38 -0700 (PDT)
Subject: Re: [PATCH v7 48/48] nvme: make lba data size configurable
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
References: <20200415055140.466900-1-its@irrelevant.dk>
 <20200415055140.466900-49-its@irrelevant.dk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f7da749c-fd4b-7e4a-74d2-f6dab4e000bf@redhat.com>
Date: Wed, 15 Apr 2020 09:40:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200415055140.466900-49-its@irrelevant.dk>
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

On 4/15/20 7:51 AM, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>=20
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Acked-by: Keith Busch <kbusch@kernel.org>
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   hw/block/nvme-ns.c | 7 ++++++-
>   hw/block/nvme-ns.h | 4 +++-
>   hw/block/nvme.c    | 1 +
>   3 files changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
> index bd64d4a94632..d34b6b2439f1 100644
> --- a/hw/block/nvme-ns.c
> +++ b/hw/block/nvme-ns.c
> @@ -18,7 +18,7 @@ static int nvme_ns_init(NvmeNamespace *ns)
>   {
>       NvmeIdNs *id_ns =3D &ns->id_ns;
>  =20
> -    id_ns->lbaf[0].ds =3D BDRV_SECTOR_BITS;
> +    id_ns->lbaf[0].ds =3D ns->params.lbads;
>       id_ns->nsze =3D cpu_to_le64(nvme_ns_nlbas(ns));
>  =20
>       /* no thin provisioning */
> @@ -78,6 +78,11 @@ static int nvme_ns_check_constraints(NvmeNamespace *ns=
, Error **errp)
>           return -1;
>       }
>  =20
> +    if (ns->params.lbads < 9 || ns->params.lbads > 12) {
> +        error_setg(errp, "unsupported lbads (supported: 9-12)");
> +        return 1;
> +    }
> +
>       return 0;
>   }
>  =20
> diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
> index 3c3651d485d0..43b78f8b8d9c 100644
> --- a/hw/block/nvme-ns.h
> +++ b/hw/block/nvme-ns.h
> @@ -7,10 +7,12 @@
>  =20
>   #define DEFINE_NVME_NS_PROPERTIES(_state, _props) \
>       DEFINE_PROP_DRIVE("drive", _state, blk), \
> -    DEFINE_PROP_UINT32("nsid", _state, _props.nsid, 0)
> +    DEFINE_PROP_UINT32("nsid", _state, _props.nsid, 0), \
> +    DEFINE_PROP_UINT8("lbads", _state, _props.lbads, BDRV_SECTOR_BITS)
>  =20
>   typedef struct NvmeNamespaceParams {
>       uint32_t nsid;
> +    uint8_t  lbads;
>   } NvmeNamespaceParams;
>  =20
>   typedef struct NvmeNamespace {
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 40a400333828..dd2759a4ce2e 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -2690,6 +2690,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error =
**errp)
>       if (n->namespace.blk) {
>           ns =3D &n->namespace;
>           ns->params.nsid =3D 1;
> +        ns->params.lbads =3D BDRV_SECTOR_BITS;
>  =20
>           if (nvme_ns_setup(n, ns, errp)) {
>               return;
>=20


