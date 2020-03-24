Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDB0C4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 13:04:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9751208D5
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 13:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JCXm+6zC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9751208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGjEG-0005yX-S5
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 09:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46407)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jGjDK-0005H9-Mr
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:03:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jGjDJ-0002Xo-M9
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:03:26 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:56087)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jGjDJ-0002XW-He
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:03:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585055005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sbZbS6jMdFpzVELoZhorG5U1g9uT/CyzZus8wsHXgvg=;
 b=JCXm+6zCrm9iGKc2CVy9TQfLfiAqcOGX6gwFGh/DJ6EFxMkq/qL0GLi578jyzN6zEBSeG/
 NYxcl7vCqu+mGR4NikG5S4eOB9qtLarpkSGFcBSUAEbFqe9p4SLBMibH1+YgKv5gUTxu+2
 yQTCQHZQSCuaZYkPv3os8c8UNlBu4GU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-rQYm3KJDOB2cfPsfvWEZHw-1; Tue, 24 Mar 2020 09:03:23 -0400
X-MC-Unique: rQYm3KJDOB2cfPsfvWEZHw-1
Received: by mail-ed1-f72.google.com with SMTP id x1so14763320edv.14
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 06:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cOkw/5BcA4UIJfUP9fylXoL2V0PCmC3z6uyNT4wXkvU=;
 b=WPBQGsT9s+9NLV8HYnxLMvkiTLIgkSsF1w8WaAE77Zo93esEVRbzb5CTvHvTSw+lNU
 dW/Q15JDe1WMH9mwOuaOEeH9l1E5TfL3Y+YjsHnq5CeLCvjaMVU8ColxM0tkhOcQUi2a
 QbHN5yUyhzIzwH7/nkQ1J9D163H4WdxrjgxjW6UCqLRFNF09wSS1jnoXe08BLj9V9ntg
 Q122mBZok+19fT3F2skmzJpEs/gKg9ymYd8LvZ8Vyb7h865FciZMIxvY6v/2nzXv7ywx
 678j6sHG+3XixJbAMsLBvsJ3qTcj6oZtnkUUFjAs4+Bfzv6MJ2U3SS+XPUsom3Uwgih/
 2XJg==
X-Gm-Message-State: ANhLgQ2ICYS8j558v9SgASyrpgdxTx5SpsatPklum0lJpAUVAsuqQH8K
 H9MbOYVS/t3NBd5m1iPjW+MH/CNEoEo13J4aU/OqI1wJZleG/1SN6399Y+ieg0+HrTX5bj9T9tN
 heY1IGH1LhIwTgqc=
X-Received: by 2002:a17:906:5591:: with SMTP id
 y17mr24347375ejp.155.1585055002215; 
 Tue, 24 Mar 2020 06:03:22 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtpwi1RvHhMOV3kerR4UcEuc2WuGA9AdevcjH8Ecz0jXD91/yIeH29CcyPqOgu7FS4gB9fmiA==
X-Received: by 2002:a17:906:5591:: with SMTP id
 y17mr24347344ejp.155.1585055001910; 
 Tue, 24 Mar 2020 06:03:21 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id e4sm416908edu.87.2020.03.24.06.03.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2020 06:03:20 -0700 (PDT)
Subject: Re: [PATCH] qemu: Do not include file if not exists
To: Oleksiy Obitotskyy <oobitots@cisco.com>, qemu-devel@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>
References: <20200324094340.4344-1-oobitots@cisco.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <eda4c24f-2805-67b9-4fa0-931d7b03090c@redhat.com>
Date: Tue, 24 Mar 2020 14:03:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200324094340.4344-1-oobitots@cisco.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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

On 3/24/20 10:43 AM, Oleksiy Obitotskyy wrote:
> Script configure checks for if_alg.h and check failed but
> if_alg.h still included.
>=20
> Upstream-Status: Submitted [<oobitots@cisco.com>]

^ Mainstream doesn't use such tag.

Otherwise:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> Signed-off-by: Oleksiy Obitotskyy <oobitots@cisco.com>
> ---
>   linux-user/syscall.c | 2 ++
>   1 file changed, 2 insertions(+)
>=20
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 35f4146662..819774af0d 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -109,7 +109,9 @@
>   #include <linux/blkpg.h>
>   #include <netpacket/packet.h>
>   #include <linux/netlink.h>
> +#if defined(CONFIG_AF_ALG)
>   #include <linux/if_alg.h>
> +#endif
>   #include <linux/rtc.h>
>   #include <sound/asound.h>
>   #include "linux_loop.h"
>=20


