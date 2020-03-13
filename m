Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC81C4CECE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 19:54:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EE00206E2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 19:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JoQwZcLj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EE00206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCqOJ-0008U5-8b
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 15:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55357)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jCqNg-00085X-1k
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 15:54:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jCqNf-0003QU-1G
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 15:54:03 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51795
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jCqNe-0003NL-TU
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 15:54:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584129242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Aole5ATUICGy1kpQYP5RyE4+J7Xp3XXuCpCTO6rvFOA=;
 b=JoQwZcLjYfoOpw/PKiIgdos+KGNLxn/5+senzAaCLvFlzqwGFpJpG/YjGKsKgIjfE8pIqi
 mWgHHw7vUq5EKXKPBH8NGzMkcXVZ+riLpA0eJwjvLjaQhPrOCWKMDhfAiVa03FSJ0J0N1U
 U3TOEs/ZzOSR8L2EfNy3bjq704JlfhY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-w5CmKz3eNAeUI_ZmxqAf-A-1; Fri, 13 Mar 2020 15:54:00 -0400
X-MC-Unique: w5CmKz3eNAeUI_ZmxqAf-A-1
Received: by mail-wr1-f70.google.com with SMTP id w11so4797400wrp.20
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 12:54:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4SgjQfgqSnd9YeziXu7OqIiJxz3Zf032H/KPDxQ/X7E=;
 b=EYO9WVaPBXMDklSbCyT3UXgmuYzSNIVfqPl2jmfrWy1o1MSGD5WX6BMwgr1HIWkVn6
 2qEEmzvey0EcO0ydxDj+pXRkhGK9AtbaLaoneAqENKD66WIAfxqPmmrpWxnLyhOZJLAH
 6A4KsrDOOK/8GpnZGjthmT8xyVPHn8VkYBprmPzCj/SkW5e9x9ipwuiMuk7USQwKso5n
 56NN3LCG2HCOoiHG7DJGlba5ZS9hFPPaqfJU8FIAukovmX00ONKneAD6P+/zLfeZQPj/
 eXqk9Bmu8Z/ux2O7dDAoBZrw9yWmg00V0hFpKQoQQnfZctJ8UGKFtUWkho7tQvuxN9AZ
 MAdA==
X-Gm-Message-State: ANhLgQ1WjDfX6GGzqCmf5tAQb8IXlBtyIZQ9XC/3IUMb75InVhgQ2FB2
 s1h0w/VGvv5vvoiw1TD/zMLRWiz3LH+7vh0xQXHh/SJX9HPRPnrTNJS3a6OErcSW0R5XRiLo/vO
 8Cm/WgCgRHaTgE/0=
X-Received: by 2002:a05:600c:2c4a:: with SMTP id
 r10mr12753418wmg.32.1584129239212; 
 Fri, 13 Mar 2020 12:53:59 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vttX+ufkNFzcTYG+N4ZntV2CjGf7W+ivU6Uv8wrSUuMJVGqaxaOjNBDOQbBGMiQw3oIIUzKWg==
X-Received: by 2002:a05:600c:2c4a:: with SMTP id
 r10mr12753404wmg.32.1584129238970; 
 Fri, 13 Mar 2020 12:53:58 -0700 (PDT)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id l18sm11256808wrr.17.2020.03.13.12.53.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2020 12:53:58 -0700 (PDT)
Subject: Re: [PATCH v3 02/16] hw/i386/vmport: Add device properties
To: Liran Alon <liran.alon@oracle.com>, qemu-devel@nongnu.org
References: <20200312165431.82118-1-liran.alon@oracle.com>
 <20200312165431.82118-3-liran.alon@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <dd3c8a15-871e-018c-b71d-dbe83f02346a@redhat.com>
Date: Fri, 13 Mar 2020 20:53:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312165431.82118-3-liran.alon@oracle.com>
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
Cc: pbonzini@redhat.com, Nikita Leshenko <nikita.leshchenko@oracle.com>,
 rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/12/20 5:54 PM, Liran Alon wrote:
> No functional change.
>=20
> This is done as a preparation for the following patches that will
> introduce several device properties.
>=20
> Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
> Signed-off-by: Liran Alon <liran.alon@oracle.com>
> ---
>   hw/i386/vmport.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>=20
> diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
> index b4c5a57bb0e9..6ed110ef71a6 100644
> --- a/hw/i386/vmport.c
> +++ b/hw/i386/vmport.c
> @@ -32,6 +32,7 @@
>   #include "hw/isa/isa.h"
>   #include "hw/i386/pc.h"
>   #include "hw/input/i8042.h"
> +#include "hw/qdev-properties.h"
>   #include "sysemu/hw_accel.h"
>   #include "qemu/log.h"
>   #include "trace.h"
> @@ -161,6 +162,10 @@ static void vmport_realizefn(DeviceState *dev, Error=
 **errp)
>       vmport_register(VMPORT_CMD_GETRAMSIZE, vmport_cmd_ram_size, NULL);
>   }
>  =20
> +static Property vmport_properties[] =3D {
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>   static void vmport_class_initfn(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc =3D DEVICE_CLASS(klass);
> @@ -168,6 +173,7 @@ static void vmport_class_initfn(ObjectClass *klass, v=
oid *data)
>       dc->realize =3D vmport_realizefn;
>       /* Reason: realize sets global port_state */
>       dc->user_creatable =3D false;
> +    device_class_set_props(dc, vmport_properties);
>   }
>  =20
>   static const TypeInfo vmport_info =3D {
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


