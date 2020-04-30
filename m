Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268CEC83001
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 07:04:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E48E0214D8
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 07:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SIlBN0ph"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E48E0214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU3F2-0002JW-0X
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 03:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60766)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jU3Db-0001Mp-Sl
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 03:02:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jU3DZ-0001ly-Ix
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 03:02:47 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47866
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jU3DZ-0001Mo-0S
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 03:02:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588230160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yv0S0OuhWnk2aRbINtuM1cD9URxc7oIzXrTBxYwIIro=;
 b=SIlBN0ph8nV8G2uXIyuZhGyZcooeHFrPQi+iuWHsgWAdI34VmGb2cZEmUtfZmRcemWCHcy
 1emRGnZsjz8w84TFb0czoIe97SZ+NJI1x7C3ZZiwKMWtDwGKhj4cWim7zdl/9sQQxx5Dc/
 EBrMUwmlp8/PNV0SaXrgz8+LXnTslNQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-U0gx6OhxPeKyCYrVYCQP0w-1; Thu, 30 Apr 2020 03:02:39 -0400
X-MC-Unique: U0gx6OhxPeKyCYrVYCQP0w-1
Received: by mail-wm1-f72.google.com with SMTP id 71so187175wmb.8
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 00:02:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WI09xRu4MG/i/3E2L2i9lXl3LcBHHyWdgW1pJAwRA7g=;
 b=TjI2N+8PiRyFz2PS/Lv+y5C8Qf5Sh2Nfat2FCFik5gn7EYgjP7uOVE3q5qmBq2fDQW
 g1FSVMxcL8Awa3GOTI31p4uSlLCUxs7gp0CnSd+ABtj8uj/mAJvY+TZU8aJjc/5GVlvL
 35k3jq7IZETHYJJTMQS80xMhXkSaIPBBgcIvPE/babjwE4fP3pFHEO6WuuJ65XlSsNl4
 qzuKmCK+/wrB4kMM/dzXgNfaspdAhUdiPGwGRTRZtIQIIdthWd6AvKyOy7zx+7pDS4ll
 g1pvqfkLvjueZAvTjVXFX3zeevUheXFRwMcF2phUkn4vwZub82D9Hr9GjFrDz3VhShab
 j3LA==
X-Gm-Message-State: AGi0PuYQ72Qx0Xg8EsP7Lqe8BbnX1NptbayOGfrSnWSyE9KjlfBBoCRm
 zULkqMA369Wefkv9GnlTB32PannM9YOc/jaYUrMgAMsHr4vzKc0i4ImAG6qNN1PAPugcBnCoD6O
 RKVBjvkEf3ypqRu4=
X-Received: by 2002:a05:6000:10c4:: with SMTP id
 b4mr2167220wrx.203.1588230158017; 
 Thu, 30 Apr 2020 00:02:38 -0700 (PDT)
X-Google-Smtp-Source: APiQypI17D6vuLLedKmdVEsSrJ3FIUoaVppsGE3Tky8Z0nJaufp+CP2vLiIphDwC1iDm7K/KZXoHIg==
X-Received: by 2002:a05:6000:10c4:: with SMTP id
 b4mr2167195wrx.203.1588230157733; 
 Thu, 30 Apr 2020 00:02:37 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id f23sm10591007wml.4.2020.04.30.00.02.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2020 00:02:37 -0700 (PDT)
Subject: Re: [PATCH v5 2/3] hw/vfio: drop guest writes to ro regions
To: Yan Zhao <yan.y.zhao@intel.com>, pbonzini@redhat.com,
 alex.williamson@redhat.com
References: <20200430051558.28991-1-yan.y.zhao@intel.com>
 <20200430052307.29235-1-yan.y.zhao@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d78ed9ed-f78d-4aa5-efcc-77cb33fb1c76@redhat.com>
Date: Thu, 30 Apr 2020 09:02:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200430052307.29235-1-yan.y.zhao@intel.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:04:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: xin.zeng@intel.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/30/20 7:23 AM, Yan Zhao wrote:
> for vfio regions that are without write permission,
> drop guest writes to those regions.
>=20
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co>

The full domain name is redhat.com.

> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> Signed-off-by: Xin Zeng <xin.zeng@intel.com>
> ---
>   hw/vfio/common.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 0b3593b3c0..2a4fedfeaa 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -38,6 +38,7 @@
>   #include "sysemu/reset.h"
>   #include "trace.h"
>   #include "qapi/error.h"
> +#include "qemu/log.h"
>  =20
>   VFIOGroupList vfio_group_list =3D
>       QLIST_HEAD_INITIALIZER(vfio_group_list);
> @@ -190,6 +191,16 @@ void vfio_region_write(void *opaque, hwaddr addr,
>           uint64_t qword;
>       } buf;
>  =20
> +    trace_vfio_region_write(vbasedev->name, region->nr, addr, data, size=
);
> +    if (!(region->flags & VFIO_REGION_INFO_FLAG_WRITE)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "Invalid write to read only vfio region (%s:region=
%d"
> +                      "+0x%"HWADDR_PRIx" size %d)\n", vbasedev->name,
> +                      region->nr, addr, size);
> +
> +        return;
> +    }
> +
>       switch (size) {
>       case 1:
>           buf.byte =3D data;
> @@ -215,8 +226,6 @@ void vfio_region_write(void *opaque, hwaddr addr,
>                        addr, data, size);
>       }
>  =20
> -    trace_vfio_region_write(vbasedev->name, region->nr, addr, data, size=
);
> -
>       /*
>        * A read or write to a BAR always signals an INTx EOI.  This will
>        * do nothing if not pending (including not in INTx mode).  We assu=
me
>=20


