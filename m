Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09B6CA9EB9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 22:37:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E50020640
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 22:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E50020640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNPFc-00056O-41
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 18:37:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57012)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNPEC-0003br-GH
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 18:35:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNPEA-0006qI-8I
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 18:35:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55346)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNPEA-0006ou-01
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 18:35:38 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9F15B2A09CC
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 22:35:36 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id 4so7606740wrf.19
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 15:35:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=skER8DWj/5m3rWcxNc2lt8HUy5SqgDXCVpMXUsNwevU=;
 b=rTuqnE1rFOnXhAR12+c+GXbN99jC74h45/2gWAV6n+WTZlDmDgqLBLR6SoPMhOgYY4
 rmXy9esZiC7CLGFnnT/uWht4qWhiV0stwRoUtnqYIjoc3P/nfAa2WD3xLcqGTvZgmeRf
 L2oH/e6DXDrkq1Z/VoJ3ssvf1uUnJcGlV2otUlPyidRBJOPRFx5HZip0NXj/4K8zowKQ
 zNf57aY+TCPM3ChZpa+AOirWz28HVRyP/xg+nD/0Y4o0HKHC6864sNB3lPFjE60st3Hx
 bAuF8jBsYutJaLGo5IDvHcOQOL6lK38QXCJ3TmB+sYitoi0fdSa7Y4mNeMxBoqlSdv4X
 CaYw==
X-Gm-Message-State: APjAAAWmd0fL+laoY7EtEWiZEVcloZnEajxTgqYw+awKYLw0Yn3Wh2e0
 9X0SlBrqquKphteJHzvmFt7MprCLgrrcrWLIxGrul2rcBjhapxqo4/HFMmyvFFF9KrRZihYDCW1
 ceV92lkv+o1xmMjE=
X-Received: by 2002:a1c:b4c2:: with SMTP id d185mr1739507wmf.159.1571870135286; 
 Wed, 23 Oct 2019 15:35:35 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzrzJSd1+IzvAoBmCX/6jVAUFaOe0/KTyld8INHBgwT40oRfnCOZv7JAND7gH+MCAB95WQ+Cg==
X-Received: by 2002:a1c:b4c2:: with SMTP id d185mr1739479wmf.159.1571870135067; 
 Wed, 23 Oct 2019 15:35:35 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id g5sm743360wmg.12.2019.10.23.15.35.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2019 15:35:33 -0700 (PDT)
Subject: Re: [PATCH v3 02/33] sysbus: remove unused sysbus_try_create*
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-3-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e605fd4a-8414-99a7-0b2a-99a259da9e13@redhat.com>
Date: Thu, 24 Oct 2019 00:35:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191023173154.30051-3-marcandre.lureau@redhat.com>
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

"Last user removed in commit 7a10ef51c (2013)."

On 10/23/19 7:31 PM, Marc-Andr=C3=A9 Lureau wrote:
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   hw/core/sysbus.c    | 32 --------------------------------
>   hw/i386/pc.c        |  1 -
>   include/hw/sysbus.h |  9 +--------
>   3 files changed, 1 insertion(+), 41 deletions(-)
>=20
> diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
> index 9e69c83aed..08b0311c5f 100644
> --- a/hw/core/sysbus.c
> +++ b/hw/core/sysbus.c
> @@ -250,38 +250,6 @@ DeviceState *sysbus_create_varargs(const char *nam=
e,
>       return dev;
>   }
>  =20
> -DeviceState *sysbus_try_create_varargs(const char *name,
> -                                       hwaddr addr, ...)
> -{
> -    DeviceState *dev;
> -    SysBusDevice *s;
> -    va_list va;
> -    qemu_irq irq;
> -    int n;
> -
> -    dev =3D qdev_try_create(NULL, name);
> -    if (!dev) {
> -        return NULL;
> -    }
> -    s =3D SYS_BUS_DEVICE(dev);
> -    qdev_init_nofail(dev);
> -    if (addr !=3D (hwaddr)-1) {
> -        sysbus_mmio_map(s, 0, addr);
> -    }
> -    va_start(va, addr);
> -    n =3D 0;
> -    while (1) {
> -        irq =3D va_arg(va, qemu_irq);
> -        if (!irq) {
> -            break;
> -        }
> -        sysbus_connect_irq(s, n, irq);
> -        n++;
> -    }
> -    va_end(va);
> -    return dev;
> -}
> -
>   static void sysbus_dev_print(Monitor *mon, DeviceState *dev, int inde=
nt)
>   {
>       SysBusDevice *s =3D SYS_BUS_DEVICE(dev);
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 4b1904237e..00ee16ccab 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1902,7 +1902,6 @@ void pc_basic_device_init(ISABus *isa_bus, qemu_i=
rq *gsi,
>        * when the HPET wants to take over. Thus we have to disable the =
latter.
>        */
>       if (!no_hpet && (!kvm_irqchip_in_kernel() || kvm_has_pit_state2()=
)) {
> -        /* In order to set property, here not using sysbus_try_create_=
simple */
>           hpet =3D qdev_try_create(NULL, TYPE_HPET);
>           if (hpet) {
>               /* For pc-piix-*, hpet's intcap is always IRQ2. For pc-q3=
5-1.7
> diff --git a/include/hw/sysbus.h b/include/hw/sysbus.h
> index 27e80881da..2eb0484388 100644
> --- a/include/hw/sysbus.h
> +++ b/include/hw/sysbus.h
> @@ -117,8 +117,7 @@ void foreach_dynamic_sysbus_device(FindSysbusDevice=
Func *func, void *opaque);
>   /* Legacy helper function for creating devices.  */
>   DeviceState *sysbus_create_varargs(const char *name,
>                                    hwaddr addr, ...);
> -DeviceState *sysbus_try_create_varargs(const char *name,
> -                                       hwaddr addr, ...);
> +
>   static inline DeviceState *sysbus_create_simple(const char *name,
>                                                 hwaddr addr,
>                                                 qemu_irq irq)
> @@ -126,11 +125,5 @@ static inline DeviceState *sysbus_create_simple(co=
nst char *name,
>       return sysbus_create_varargs(name, addr, irq, NULL);
>   }
>  =20
> -static inline DeviceState *sysbus_try_create_simple(const char *name,
> -                                                    hwaddr addr,
> -                                                    qemu_irq irq)
> -{
> -    return sysbus_try_create_varargs(name, addr, irq, NULL);
> -}
>  =20
>   #endif /* HW_SYSBUS_H */
>=20

