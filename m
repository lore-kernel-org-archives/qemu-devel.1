Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE080CA9EB9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 23:04:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF31120659
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 23:04:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF31120659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNPg9-00046g-TO
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 19:04:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60759)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNPeS-0002SW-Oc
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 19:02:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNPeR-0000TN-Ee
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 19:02:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33004)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNPeR-0000T8-6N
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 19:02:47 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 31E1D4E938
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 23:02:46 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id v8so10888052wrt.16
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 16:02:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NbN8nXL/7OUD5AseCS8Rxjxq6seb8+nEYKYOUhNwpgY=;
 b=lcar0U0iP1FBGcPahZK2CSQjd99rqkHTJqaakbCblEz+qcLH0I8zs2i9MHORGA5ndy
 rr3q7wcuAPufmwt60fU/0KkRJIAkwkje4XSr8cjSBUYnfincKhDFdb4px4qEoVsmcnJU
 Gkrv+k0QjtsSPF7KbWCNN6i1O4b90TqNXI9rtyaZec7DgYo2qKNgKufn8Ok9zXHx5Ent
 3UOHjfPn4yhl6n5kJGOAvVvbT9yhE2ksHDUQKm0vXTybDm1hccksTxaRqkClNWXv9EsM
 IzcMcGnqStCjce2Z8HO2WQQQtsxUAOuZQQEJ1lbpTZ7kDGKtIWdDOu9BoXVf+ehPE9PI
 r8qw==
X-Gm-Message-State: APjAAAWVvSn3BX0BhSjJtnnqzSuNWm1xQ3HI7DDlMeVFpqTyXgYDtcsM
 nR8+Suoy+SvTFwwvQ2VvriCo8ANnoyJLh22SMzLc1lVIutyt2O87pbvp1zVkkm6w/oQIbjf33NQ
 XWpJayvn6lAk/ey8=
X-Received: by 2002:adf:e28f:: with SMTP id v15mr917947wri.130.1571871764874; 
 Wed, 23 Oct 2019 16:02:44 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz3aT+W/ZMy4PwBXoAWniwHmqOR5s78djqw2L18aRQYTNQFH+3sm54d870hyh0BhqrQOdAS+Q==
X-Received: by 2002:adf:e28f:: with SMTP id v15mr917920wri.130.1571871764660; 
 Wed, 23 Oct 2019 16:02:44 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id a4sm521075wmm.10.2019.10.23.16.02.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2019 16:02:44 -0700 (PDT)
Subject: Re: [PATCH v3 23/33] dp8393x: replace PROP_PTR with PROP_LINK
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-24-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <06288994-a5d3-038d-794e-ed63acdadd95@redhat.com>
Date: Thu, 24 Oct 2019 01:02:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191023173154.30051-24-marcandre.lureau@redhat.com>
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
> Link property is the correct way to pass a MemoryRegion to a device
> for DMA purposes.
>=20
> Sidenote: as a sysbus device, this remains non-usercreatable
> even though we can drop the specific flag here.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/mips/mips_jazz.c | 3 ++-
>   hw/net/dp8393x.c    | 7 +++----
>   2 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
> index 8d010a0b6e..878925a963 100644
> --- a/hw/mips/mips_jazz.c
> +++ b/hw/mips/mips_jazz.c
> @@ -284,7 +284,8 @@ static void mips_jazz_init(MachineState *machine,
>               dev =3D qdev_create(NULL, "dp8393x");
>               qdev_set_nic_properties(dev, nd);
>               qdev_prop_set_uint8(dev, "it_shift", 2);
> -            qdev_prop_set_ptr(dev, "dma_mr", rc4030_dma_mr);
> +            object_property_set_link(OBJECT(dev), OBJECT(rc4030_dma_mr=
),
> +                                     "dma_mr", &error_abort);
>               qdev_init_nofail(dev);
>               sysbus =3D SYS_BUS_DEVICE(dev);
>               sysbus_mmio_map(sysbus, 0, 0x80001000);
> diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
> index a5678e11fa..946c7a8f64 100644
> --- a/hw/net/dp8393x.c
> +++ b/hw/net/dp8393x.c
> @@ -173,7 +173,7 @@ typedef struct dp8393xState {
>       int loopback_packet;
>  =20
>       /* Memory access */
> -    void *dma_mr;
> +    MemoryRegion *dma_mr;
>       AddressSpace as;
>   } dp8393xState;
>  =20
> @@ -922,7 +922,8 @@ static const VMStateDescription vmstate_dp8393x =3D=
 {
>  =20
>   static Property dp8393x_properties[] =3D {
>       DEFINE_NIC_PROPERTIES(dp8393xState, conf),
> -    DEFINE_PROP_PTR("dma_mr", dp8393xState, dma_mr),
> +    DEFINE_PROP_LINK("dma_mr", dp8393xState, dma_mr,
> +                     TYPE_MEMORY_REGION, MemoryRegion *),
>       DEFINE_PROP_UINT8("it_shift", dp8393xState, it_shift, 0),
>       DEFINE_PROP_END_OF_LIST(),
>   };
> @@ -936,8 +937,6 @@ static void dp8393x_class_init(ObjectClass *klass, =
void *data)
>       dc->reset =3D dp8393x_reset;
>       dc->vmsd =3D &vmstate_dp8393x;
>       dc->props =3D dp8393x_properties;
> -    /* Reason: dma_mr property can't be set */
> -    dc->user_creatable =3D false;

Patch is OK except this user_creatable change I don't understand.

>   }
>  =20
>   static const TypeInfo dp8393x_info =3D {
>=20

