Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5977CA9EB9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 23:02:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89BE120659
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 23:02:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89BE120659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNPeH-0001kf-FG
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 19:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60524)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNPcn-0000TO-JC
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 19:01:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNPcm-0008Cf-Cn
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 19:01:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51643)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNPcm-0008Bq-5D
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 19:01:04 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 283A5796E6
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 23:01:03 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id s17so6133662wrp.17
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 16:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/z5VU3YzQev170B56p6VP4gk44LJvSUDSqX+pwTb+/k=;
 b=NRMXHPvllxWFU5aP+dRRGfa3bW6eXrrIE+lEA4vILi5T66jBReeVreG1095QnkQsNg
 ra9xYlOqLHeS/TEezbUIZKCQQ3LPqy1nxwZcvrSggeaZgYU4iBht/tjAdvEKEzRaSrTb
 1kAHI9gez4gkkFIIfELfT7U5+aenwdfQgpEuL3+xPTeswLV6AuqjqzJozClpQSH4Czyx
 nQfY57y6gLMPHGu/3aoc+zyInm4bzhp+LZ5XM0k0RkgwOQO+Ke12wRhzkyCj35r/Sgq+
 n5Gb7QnOe2njID2Em7B+yTo4U/rwMKBoLJubpoR0ezhtoNLKZNdSxcHmxTN+qhKWxQB0
 gjVg==
X-Gm-Message-State: APjAAAU5tANcFZ49xON9XuuMgQUbeT34nlEs48lTffXTgpCDTcJyGgOZ
 dhSpS/6ZHUefYApCPi0RS6aDnZPctwLYMC2Dl2JC1voiIa++rtp9EXJK57l3hZHsBDoy8ln1T6d
 blWys+JN5A9pvNH0=
X-Received: by 2002:a5d:4003:: with SMTP id n3mr856086wrp.95.1571871661615;
 Wed, 23 Oct 2019 16:01:01 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy5UdQGLkJ77bpCsLgzpPPBQHc0VFw/OjP6b33xJ2H0np+HpqC5aOYuRNMTYL/mfqdSOdPwyA==
X-Received: by 2002:a5d:4003:: with SMTP id n3mr856059wrp.95.1571871661288;
 Wed, 23 Oct 2019 16:01:01 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id r65sm604689wmr.9.2019.10.23.16.00.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2019 16:01:00 -0700 (PDT)
Subject: Re: [PATCH v3 21/33] lance: replace PROP_PTR with PROP_LINK
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-22-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2d027692-e178-c1c8-8384-ad70ed345f29@redhat.com>
Date: Thu, 24 Oct 2019 01:00:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191023173154.30051-22-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Magnus Damm <magnus.damm@gmail.com>,
 Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fabien Chouteau <chouteau@adacore.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Burton <pburton@wavecomp.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/23/19 7:31 PM, Marc-Andr=C3=A9 Lureau wrote:
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/dma/sparc32_dma.c | 2 +-
>   hw/net/lance.c       | 5 ++---
>   hw/net/pcnet-pci.c   | 2 +-
>   hw/net/pcnet.h       | 2 +-
>   4 files changed, 5 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
> index 0e5bbcdc7f..3e4da0c47f 100644
> --- a/hw/dma/sparc32_dma.c
> +++ b/hw/dma/sparc32_dma.c
> @@ -346,7 +346,7 @@ static void sparc32_ledma_device_realize(DeviceStat=
e *dev, Error **errp)
>       d =3D qdev_create(NULL, TYPE_LANCE);
>       object_property_add_child(OBJECT(dev), "lance", OBJECT(d), errp);
>       qdev_set_nic_properties(d, nd);
> -    qdev_prop_set_ptr(d, "dma", dev);
> +    object_property_set_link(OBJECT(d), OBJECT(dev), "dma", errp);
>       qdev_init_nofail(d);
>   }
>  =20
> diff --git a/hw/net/lance.c b/hw/net/lance.c
> index 6631e2a4e0..4d96299041 100644
> --- a/hw/net/lance.c
> +++ b/hw/net/lance.c
> @@ -138,7 +138,8 @@ static void lance_instance_init(Object *obj)
>   }
>  =20
>   static Property lance_properties[] =3D {
> -    DEFINE_PROP_PTR("dma", SysBusPCNetState, state.dma_opaque),
> +    DEFINE_PROP_LINK("dma", SysBusPCNetState, state.dma_opaque,
> +                     TYPE_DEVICE, DeviceState *),
>       DEFINE_NIC_PROPERTIES(SysBusPCNetState, state.conf),
>       DEFINE_PROP_END_OF_LIST(),
>   };
> @@ -153,8 +154,6 @@ static void lance_class_init(ObjectClass *klass, vo=
id *data)
>       dc->reset =3D lance_reset;
>       dc->vmsd =3D &vmstate_lance;
>       dc->props =3D lance_properties;
> -    /* Reason: pointer property "dma" */
> -    dc->user_creatable =3D false;

But we still can not start it with the -device option and set the dma,=20
can we?

>   }
>  =20
>   static const TypeInfo lance_info =3D {
> diff --git a/hw/net/pcnet-pci.c b/hw/net/pcnet-pci.c
> index 4723c30c79..d067d21e2c 100644
> --- a/hw/net/pcnet-pci.c
> +++ b/hw/net/pcnet-pci.c
> @@ -231,7 +231,7 @@ static void pci_pcnet_realize(PCIDevice *pci_dev, E=
rror **errp)
>       s->irq =3D pci_allocate_irq(pci_dev);
>       s->phys_mem_read =3D pci_physical_memory_read;
>       s->phys_mem_write =3D pci_physical_memory_write;
> -    s->dma_opaque =3D pci_dev;
> +    s->dma_opaque =3D DEVICE(pci_dev);
>  =20
>       pcnet_common_init(DEVICE(pci_dev), s, &net_pci_pcnet_info);
>   }
> diff --git a/hw/net/pcnet.h b/hw/net/pcnet.h
> index 28d19a5c6f..f49b213c57 100644
> --- a/hw/net/pcnet.h
> +++ b/hw/net/pcnet.h
> @@ -50,7 +50,7 @@ struct PCNetState_st {
>                            uint8_t *buf, int len, int do_bswap);
>       void (*phys_mem_write)(void *dma_opaque, hwaddr addr,
>                             uint8_t *buf, int len, int do_bswap);
> -    void *dma_opaque;
> +    DeviceState *dma_opaque;
>       int tx_busy;
>       int looptest;
>   };
>=20

