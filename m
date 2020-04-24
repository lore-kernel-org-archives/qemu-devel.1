Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E387C2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 08:25:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14CE120736
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 08:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="boYdAWax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14CE120736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRteE-0000ec-4y
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 04:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43916)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRtdL-0008Uy-Pp
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 04:24:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRtdJ-0001lQ-Lm
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 04:24:27 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26689
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRtdJ-0001fK-65
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 04:24:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587716663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZKwwfgztOZu0TpITaXSqAaMd/k/o6R01R49VXIO2M4g=;
 b=boYdAWaxuZ41cvPiItKgGe7lDjVO5AmJt64dSOtpWw+esPKst8XWtzHsBsmE6LIXtAjoRq
 RtxCzauZ1QYOOuF21iGImE0vRn/ccuGafGUBGLdouRdEfW+HDb6RAluCNLMxzmwz7cJvjf
 LXUZ0yLI6nF85UssB97HiQkl/xd4B+s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-zgID_D_iMm-I2bRzTEYf_A-1; Fri, 24 Apr 2020 04:24:21 -0400
X-MC-Unique: zgID_D_iMm-I2bRzTEYf_A-1
Received: by mail-wr1-f71.google.com with SMTP id f15so4432483wrj.2
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2020 01:24:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2tOqYdW7Z2Rn2ZyKqLrND76kYouqfpNyOjU+7VxCA+s=;
 b=dkbe5F+FKywVeQTKxBeLgPZfsgCnzVVlH8swmm7twnSwpR4vVSf12CkYJQIEcPozmi
 qHfZS+90wuBxjDJcV72pjg7eoN5V1XM7Slpgw14Ga2HuLYky/fo/U6HJXtnh8SUQAq3N
 OqowIS/OWctosYDASrpcXOkcBcHBxo6N9rQvvdsL3G6O2UgzgVnykZQbHJ3ZEX+/Ndu+
 +aWIf3CkXEiQQxctZzwa6QLN9NLNDckOQD7wniwRopNAif2/ghbgPojY3qViWmjyWlZq
 UDZhVcUBJr4oZu1j6PCYopsGZvMrWGh0FlTgaQIi1R47cFW1930oeQJ1qaFbT+yJCpUB
 4w6w==
X-Gm-Message-State: AGi0Pub1ekBxr88GF+RqMUYGMp+DpO4rLniVK2165GKF0L9swktqWbHu
 mOK8Jmj2BcC82YRjAtyDpOyaqJ+8hMaqw3wNqMMZ8rpmpq/fm3/zYlbARi4AKjwSZo6cqHp5Mry
 4UJEuSCzR2F86KBE=
X-Received: by 2002:a1c:3884:: with SMTP id f126mr9165904wma.91.1587716660505; 
 Fri, 24 Apr 2020 01:24:20 -0700 (PDT)
X-Google-Smtp-Source: APiQypImlYFr7iBfm5CkuWiuCMjrHM7lei64WhnMf0c35q7ABRGfmWCGk5mNDawr3Mc6xraUkXpTMA==
X-Received: by 2002:a1c:3884:: with SMTP id f126mr9165882wma.91.1587716660246; 
 Fri, 24 Apr 2020 01:24:20 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id 1sm1846198wmz.13.2020.04.24.01.24.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2020 01:24:19 -0700 (PDT)
Subject: Re: [PATCH 3/3] libqos: Give get_machine_allocator() internal linkage
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200424071142.3525-1-armbru@redhat.com>
 <20200424071142.3525-4-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a8e5352f-88f8-ae99-5044-6d768056add5@redhat.com>
Date: Fri, 24 Apr 2020 10:24:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200424071142.3525-4-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 03:11:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: lvivier@redhat.com, thuth@redhat.com, alxndr@bu.edu, bsd@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/24/20 9:11 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   tests/qtest/libqos/qos_external.h | 2 --
>   tests/qtest/libqos/qos_external.c | 2 +-
>   2 files changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/tests/qtest/libqos/qos_external.h b/tests/qtest/libqos/qos_e=
xternal.h
> index f63388cb30..72d7f91707 100644
> --- a/tests/qtest/libqos/qos_external.h
> +++ b/tests/qtest/libqos/qos_external.h
> @@ -18,7 +18,6 @@
>  =20
>   #ifndef QOS_EXTERNAL_H
>   #define QOS_EXTERNAL_H
> -#include "libqos/qgraph.h"
>  =20
>   #include "libqos/malloc.h"
>   #include "qapi/qapi-types-machine.h"
> @@ -26,7 +25,6 @@
>  =20
>   void machines_apply_to_node(MachineInfoList *mach_info);
>   void types_apply_to_node(ObjectTypeInfoList *type_info);
> -QGuestAllocator *get_machine_allocator(QOSGraphObject *obj);
>   void *allocate_objects(QTestState *qts, char **path, QGuestAllocator **=
p_alloc);
>  =20
>   #endif
> diff --git a/tests/qtest/libqos/qos_external.c b/tests/qtest/libqos/qos_e=
xternal.c
> index c707dac3b9..9f5180e18d 100644
> --- a/tests/qtest/libqos/qos_external.c
> +++ b/tests/qtest/libqos/qos_external.c
> @@ -66,7 +66,7 @@ void types_apply_to_node(ObjectTypeInfoList *type_info)
>       }
>   }
>  =20
> -QGuestAllocator *get_machine_allocator(QOSGraphObject *obj)
> +static QGuestAllocator *get_machine_allocator(QOSGraphObject *obj)
>   {
>       return obj->get_driver(obj, "memory");
>   }
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


