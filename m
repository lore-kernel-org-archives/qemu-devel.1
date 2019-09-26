Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA5CC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 16:09:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11357222C3
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 16:09:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11357222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDWKJ-0004yf-TJ
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 12:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34522)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iDWEN-0004hb-Hg
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:03:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iDWEK-0004Nk-MU
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:02:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34702)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iDWEJ-0004K9-KS
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:02:56 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6ED28C04AC69
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 16:02:51 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id 32so1126637wrk.15
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 09:02:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nY6SW94W7LfWTmKSQKoaxwAVsm4QTFIShLMWcD5mqPc=;
 b=Xe8HKp2bgmbT7ivhFlh5965664/kDftj+nJzZWR/X3vl6V0za1gjfwTgVLoxxPQzwg
 RYUGg2uZu13tLFZ6/7VF73eg5y95H4c0v+MTsrQRxi/yELSykqjoEPf0XtzIjrPoFcWK
 I5NXjhC8663Q10iAF4weQvSPnu9N3Ze2TahT9hRmQqNYcKoiOnp9G2aLeGmiWxQ9yBP5
 iL/JUHP8noQ05roywfQ8pAA6dSW9Sz2lUaj6Pd3OTQHF7XK75asOiyGWghGo+u9U74eq
 HLuBKbfTfDxctApDm4ewNlzNdTXEcBAseA3KI8GqC2iX/I52DcXXbLvIDzuE/KzV2GET
 i8RQ==
X-Gm-Message-State: APjAAAXWSHFD9XEIiJx+UV8W4jE8zCiWiZW/3oVrotVQxYyaT+hHuYyk
 63DkAHOZ/k3jlfMAY467ZcrE9++i+49v8ZbrBJa1ZYz29CHDwpH/ORDA/ljt0aVFf3AWSRxsdVB
 4MFB+f8fyVxwBh5Y=
X-Received: by 2002:a1c:1b14:: with SMTP id b20mr3387053wmb.122.1569513770147; 
 Thu, 26 Sep 2019 09:02:50 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyRYyjA9kAY3Uls24l4mar3+9Wkx7/rdUbO0mZNkxewOJlLD+w7PlvDXaFXABVyN5cuMkx5fA==
X-Received: by 2002:a1c:1b14:: with SMTP id b20mr3387017wmb.122.1569513769853; 
 Thu, 26 Sep 2019 09:02:49 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id m18sm4451909wrg.97.2019.09.26.09.02.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Sep 2019 09:02:49 -0700 (PDT)
Subject: Re: [PATCH 11/11] hw/misc/vmcoreinfo: Convert reset handler to
 DeviceReset
To: qemu-devel@nongnu.org
References: <20190926151733.25349-1-philmd@redhat.com>
 <20190926151733.25349-12-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f110c099-7521-95e0-74b9-9c7e53d7d5d8@redhat.com>
Date: Thu, 26 Sep 2019 18:02:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190926151733.25349-12-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/26/19 5:17 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Convert the reset handler into a proper Device reset method.

Marc-Andr=C3=A9 noticed this one is incorrect, because while being QDEV i=
t is
not connected to a QBUS.

Maybe we can add a Device::unconnected property, and when set, the
parent realize() calls 'qemu_register_reset(dev->reset, dev);'?
This might look the same, but at least Devices implementations could
stop to use this function...

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/misc/vmcoreinfo.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/misc/vmcoreinfo.c b/hw/misc/vmcoreinfo.c
> index 326a3ce8f4..a1c4847cdf 100644
> --- a/hw/misc/vmcoreinfo.c
> +++ b/hw/misc/vmcoreinfo.c
> @@ -13,7 +13,6 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "qemu/module.h"
> -#include "sysemu/reset.h"
>  #include "hw/nvram/fw_cfg.h"
>  #include "migration/vmstate.h"
>  #include "hw/misc/vmcoreinfo.h"
> @@ -26,7 +25,7 @@ static void fw_cfg_vmci_write(void *dev, off_t offset=
, size_t len)
>          && s->vmcoreinfo.guest_format !=3D FW_CFG_VMCOREINFO_FORMAT_NO=
NE;
>  }
> =20
> -static void vmcoreinfo_reset(void *dev)
> +static void vmcoreinfo_reset(DeviceState *dev)
>  {
>      VMCoreInfoState *s =3D VMCOREINFO(dev);
> =20
> @@ -61,7 +60,6 @@ static void vmcoreinfo_realize(DeviceState *dev, Erro=
r **errp)
>                               NULL, fw_cfg_vmci_write, s,
>                               &s->vmcoreinfo, sizeof(s->vmcoreinfo), fa=
lse);
> =20
> -    qemu_register_reset(vmcoreinfo_reset, dev);
>      vmcoreinfo_state =3D s;
>  }
> =20
> @@ -84,6 +82,7 @@ static void vmcoreinfo_device_class_init(ObjectClass =
*klass, void *data)
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> =20
>      dc->vmsd =3D &vmstate_vmcoreinfo;
> +    dc->reset =3D vmcoreinfo_reset;
>      dc->realize =3D vmcoreinfo_realize;
>      dc->hotpluggable =3D false;
>      set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>=20

