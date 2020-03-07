Return-Path: <SRS0=oVW3=4Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13337C10F00
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 17:27:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3B4320674
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 17:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TNkm5Vej"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3B4320674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAdER-0002XY-2j
	for qemu-devel@archiver.kernel.org; Sat, 07 Mar 2020 12:27:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52481)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jAdCJ-0000kN-CK
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 12:25:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jAdCE-00025t-FX
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 12:25:11 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60368
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jAdCE-00023N-Bg
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 12:25:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583601905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lh90gGYAk8QvLVzs07G5jCYn3W9yhXmJTVrVdNb9rfI=;
 b=TNkm5VejIbs4dsY/AuxHPsZT4qBE3HnQMDrvuaEhmeDrhypv2ihxUjWyt+Ch3td8MqtjK9
 eeLgIJw3NCCUNC1bprjo226f7VkBMGGVeENPCKkMURcNe0lTEr5HUPa9h3/qLJO9A7h/fA
 dQsJ8FGZAlkCA95FgQaBrlqSsGqf0w8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-zXN1k5wWM6u-HqFLjd1C3A-1; Sat, 07 Mar 2020 12:25:03 -0500
X-MC-Unique: zXN1k5wWM6u-HqFLjd1C3A-1
Received: by mail-wm1-f72.google.com with SMTP id r19so1732464wmh.1
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2020 09:25:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=r+5XvISQl2TUgvJevlL7U7XQgfRJIcGJswdM8a1m8l4=;
 b=qyE1q57KshfVQfy8/9DZP/+CZS3CaJzL1qs9z7shiPunoTFuKIZ6Gl/P3BvpOPCTG3
 KBI2+LcJxgkhAVTSmQE/wYK/6qHXoiJpPRv6gea2YG0bY7A+vLd+R8ouUy7O22Gx/0lX
 GEpCtAK1JMYrTeU+xK41hs64FBWw32pT4I4qLU6Vt3uK/2gthD1RDcWOuM5gARxZS+NJ
 YvgN8OrV27sUkVxt/9+Ow1FMmxkruqi/zz9MZ9C+sgWuQXHO/TGWzGd/E1jv0GKTSE3s
 tl49Y3hLfIRkxr6AM034u1vkn1lJEHGifvIYTE1HzeLQ8yhb5/Orjxj3Wpo8+8Tr2wmT
 79tA==
X-Gm-Message-State: ANhLgQ2GouVc9M+rmsw5AAkjZwBqru6kU4dq1FJF2nRHFHUhAy9e7e7z
 YVL6lHUEBte5gxnkEAItO+h7LwxoEJLi2r6oEmIiCkZ0EHwu1JIcQ2tZjK3F8VhAIEV7YlDcyRM
 DldQqkEwtD3b4iW8=
X-Received: by 2002:a1c:7419:: with SMTP id p25mr10152973wmc.129.1583601901950; 
 Sat, 07 Mar 2020 09:25:01 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvWxxKhmYL2Y+1ED5eaVil7p2rZuumjdO42sE+4uEFZ/I6qFJQdNelbrCK/nvZh0Qll5W+hlw==
X-Received: by 2002:a1c:7419:: with SMTP id p25mr10152956wmc.129.1583601901704; 
 Sat, 07 Mar 2020 09:25:01 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id m3sm34956351wrx.9.2020.03.07.09.25.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Mar 2020 09:25:01 -0800 (PST)
Subject: Re: [PATCH 1/2] cmd646: register cmd646_reset() function in
 DeviceClass
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, jsnow@redhat.com
References: <20200307151536.32709-1-mark.cave-ayland@ilande.co.uk>
 <20200307151536.32709-2-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <caafe241-c7ee-7b8b-685b-9c03a3da02cb@redhat.com>
Date: Sat, 7 Mar 2020 18:25:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200307151536.32709-2-mark.cave-ayland@ilande.co.uk>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/7/20 4:15 PM, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/ide/cmd646.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
> index 335c060673..2f11d8de24 100644
> --- a/hw/ide/cmd646.c
> +++ b/hw/ide/cmd646.c
> @@ -207,9 +207,9 @@ static void cmd646_set_irq(void *opaque, int channel,=
 int level)
>       cmd646_update_irq(pd);
>   }
>  =20
> -static void cmd646_reset(void *opaque)
> +static void cmd646_reset(DeviceState *dev)
>   {
> -    PCIIDEState *d =3D opaque;
> +    PCIIDEState *d =3D PCI_IDE(dev);
>       unsigned int i;
>  =20
>       for (i =3D 0; i < 2; i++) {
> @@ -303,7 +303,6 @@ static void pci_cmd646_ide_realize(PCIDevice *dev, Er=
ror **errp)
>       g_free(irq);
>  =20
>       vmstate_register(VMSTATE_IF(dev), 0, &vmstate_ide_pci, d);
> -    qemu_register_reset(cmd646_reset, d);
>   }
>  =20
>   static void pci_cmd646_ide_exitfn(PCIDevice *dev)
> @@ -339,6 +338,7 @@ static void cmd646_ide_class_init(ObjectClass *klass,=
 void *data)
>       DeviceClass *dc =3D DEVICE_CLASS(klass);
>       PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
>  =20
> +    dc->reset =3D cmd646_reset;
>       k->realize =3D pci_cmd646_ide_realize;
>       k->exit =3D pci_cmd646_ide_exitfn;
>       k->vendor_id =3D PCI_VENDOR_ID_CMD;
>=20

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


