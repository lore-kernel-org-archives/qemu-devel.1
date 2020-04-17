Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18B8C2BB85
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 08:50:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9015E221EA
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 08:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MrjvnMJs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9015E221EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPMhp-0000Wz-NA
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 04:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53248)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jPMgz-00083H-C2
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 04:49:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jPMgy-00070W-35
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 04:49:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58256
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jPMgx-0006zV-U6
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 04:49:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587113383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6cfTpxT7u1HvAdJB2IIirAM5L5tzIJOxhlH0ubzs5JE=;
 b=MrjvnMJsA6vk59/12lOZnO3wyuHxexEPzjg3Q3wYUAivNCxI8qKuSf8DwSEpHkc1GOu7cI
 ZjwxMxGJ08DOu4UrsU7DhF59EaTS5v+wIq0K61j+u87U29hGq8m91KeMORKeSdSfyK8DMn
 xNJtynz/nPZP8VQmhNDeRXgjyqjnr+g=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-7EFKfvBpPoGZpZ2zlfp_WQ-1; Fri, 17 Apr 2020 04:49:42 -0400
X-MC-Unique: 7EFKfvBpPoGZpZ2zlfp_WQ-1
Received: by mail-ej1-f72.google.com with SMTP id rp12so736873ejb.11
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 01:49:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lOQ/XG3CpWlq+iLafa03KdE3I7egUGVYZYWxfMTlqYg=;
 b=IobbwCZFOhntoZHq09HDWETNLk3bSJpQBQROyl8VURUTBrAK2+fjgwlzjqN9ZsT2yJ
 v+0IYimH6F6iLD8rN5kRvpfJ8oyzyGMJstg2J74fXEd8+kU1xNuThAweL7zIoe4+901J
 VNICTeO6TZoGwMqQhEy8T7Au+W+Wrlri/0z2irqW0B5NIGQdVOiQhwolaaossITu1xkb
 LzdzPH1wN403ryk8O/tI6FVm7HKd5RZb7+K6B3b+ivo5GlkQ3UbXo4cnqTUXiSZADxkE
 qVdF9TTqZRjLqprtwFrFplwxX5AglDfHBCzaRwL8qS14R1cKJsiGCcxiOBxA6SPO5+n+
 6lmA==
X-Gm-Message-State: AGi0PubuBIvbhBwGUrK2WrS6f+582uH0Pjj6Sc4fJ92H8QRrrrUajcVk
 +yiQUSNgI87jOyJRk9bX7Ko6efy2gEuffphnSEcx5wYl9HUrSoRw9XDe/mUmOBvrRkqzk8le+ts
 fiAE03Sb7JQsVv3s=
X-Received: by 2002:a50:af02:: with SMTP id g2mr1934686edd.69.1587113380162;
 Fri, 17 Apr 2020 01:49:40 -0700 (PDT)
X-Google-Smtp-Source: APiQypJRuZ/+cTtj5KI1GNOCFYDFMdghf2IJ7SVDlC166DxLOig37ZPbc5jvui6l4KSXTXDfJFZxzw==
X-Received: by 2002:a50:af02:: with SMTP id g2mr1934677edd.69.1587113379955;
 Fri, 17 Apr 2020 01:49:39 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id n2sm337172edy.75.2020.04.17.01.49.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2020 01:49:39 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] hw/vfio: drop guest writes to ro regions
To: Yan Zhao <yan.y.zhao@intel.com>, pbonzini@redhat.com,
 alex.williamson@redhat.com
References: <20200417074446.28573-1-yan.y.zhao@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e37889d5-fdf1-c0a0-b651-aeaff8eaafd1@redhat.com>
Date: Fri, 17 Apr 2020 10:49:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200417074446.28573-1-yan.y.zhao@intel.com>
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
Cc: xin.zeng@intel.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/17/20 9:44 AM, Yan Zhao wrote:
> for vfio regions that are without write permission,
> drop guest writes to those regions.
>=20
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> Signed-off-by: Xin Zeng <xin.zeng@intel.com>
> ---
>   hw/vfio/common.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 0b3593b3c0..b6956a8098 100644
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
> @@ -190,6 +191,15 @@ void vfio_region_write(void *opaque, hwaddr addr,
>           uint64_t qword;
>       } buf;
>  =20
> +    trace_vfio_region_write(vbasedev->name, region->nr, addr, data, size=
);
> +    if (!(region->flags & VFIO_REGION_INFO_FLAG_WRITE)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "Invalid write to read only vfio region 0x%"
> +                      HWADDR_PRIx" size %u\n", addr, size);
> +
> +        return;
> +    }
> +
>       switch (size) {
>       case 1:
>           buf.byte =3D data;
> @@ -215,8 +225,6 @@ void vfio_region_write(void *opaque, hwaddr addr,
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

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


