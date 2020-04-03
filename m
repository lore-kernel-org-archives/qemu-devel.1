Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC9EC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 13:24:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A8FA2077D
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 13:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O1m9GLKr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A8FA2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKMIl-0001BU-6f
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 09:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32962)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jKMI2-0000e2-Ly
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 09:23:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jKMI1-0004U0-8z
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 09:23:18 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51436
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jKMI1-0004T4-5q
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 09:23:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585920196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nOI41YyfRXPM/02G5+DP8/D60BlR8sG4s4ju+htuYgE=;
 b=O1m9GLKr4xyS0HBqUsIyEPOdjMm3KUsF/you3Z+Vyxg52acitYs6f9wuZzi6RJnWqlsPhf
 q4fbuDngxuJjSai3SCJ91FX6dT7Nb+KL3PzlMp/BmZg3CXUnpyl7chfqugQm7iyN1rtPN0
 m/eYo9kS/dIqP+Rbm+KPyPkHISzoRJQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-M3I02ly8P56WC6H7gqhAwA-1; Fri, 03 Apr 2020 09:23:10 -0400
X-MC-Unique: M3I02ly8P56WC6H7gqhAwA-1
Received: by mail-ed1-f70.google.com with SMTP id h12so4049085edv.11
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 06:23:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7URV7jlHSDOLfeFGIdz3M4FEJCLRLZhAbtcOyF+OQH8=;
 b=O61Ip/hKMx2U0sSSQX5Xw47AVEsOGY1k0EA2ob1uxFkWZvPq7RVdxLBFRO1arLLLMs
 ve/S8IY6IkoaAESn2Qf8dm+iYTUZfcTU+4Xow5RbeGF2uJZm5l3L1q6XZT8Qey3Vsk3l
 4jF2yg4R/jQNy1r2ZkBmlFkbu6uXVsAOlh/IsR5Yf6rkmnT7hhGPBdO3VI5GEGo3Dyt/
 PguD8uT3Ne6wUbf/SvnZIFQrRC4uYazwIDWhHq6jWOvz9nQifrNjIWBmmz9uTapnZQoX
 OzjkUX8Z58kFFPh2LGY0MJ5exJ/gs4RmndKE+njmqXH///tRgBfHypdYzDcZ1GjLjCU2
 UWNw==
X-Gm-Message-State: AGi0PuYPqPxbyzjji/S5JQ3udQS+x/n71+7+MdGYL5E1aJtW9358uXFJ
 1wZausrE3Vm1uq5476MCewW05X+i59LCXpsMx4HsqKrn/fzfW2BYmNGfgsAGh0L5X5jZ2unw+Px
 qDbOrHYWQ4M2xOpY=
X-Received: by 2002:a05:6402:1619:: with SMTP id
 f25mr6821474edv.201.1585920189572; 
 Fri, 03 Apr 2020 06:23:09 -0700 (PDT)
X-Google-Smtp-Source: APiQypLJXJj1cTQE3pUNcTcaf4LcbawJ14fXePRX3b4I9n2a6/hUSuz6yMdkgCm1Zpd39BL77hrJTQ==
X-Received: by 2002:a05:6402:1619:: with SMTP id
 f25mr6821457edv.201.1585920189353; 
 Fri, 03 Apr 2020 06:23:09 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id ar26sm1625920ejc.52.2020.04.03.06.23.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Apr 2020 06:23:08 -0700 (PDT)
Subject: Re: [PATCH for-5.0] hw/gpio/aspeed_gpio.c: Don't directly include
 assert.h
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200403124712.24826-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <35265256-15e5-a206-dc7c-8f495d71ff68@redhat.com>
Date: Fri, 3 Apr 2020 15:23:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200403124712.24826-1-peter.maydell@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/3/20 2:47 PM, Peter Maydell wrote:
> Remove a direct include of assert.h -- this is already
> provided by qemu/osdep.h, and it breaks our rule that the
> first include must always be osdep.h.

Seems a leftover for debugging added between v3:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg634251.html
and v4:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg637329.html
since not commented in v4 cover:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg637328.html

>=20
> In particular we must get the assert() macro via osdep.h
> to avoid compile failures on mingw (see the comment in
> osdep.h where we redefine assert() for that platform).
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Reported via a random comment on our github mirror...
> we should probably do a proper clean-includes run post-5.0.

Yes... Or schedule/include a pre-soft-freeze tasklist in the wiki=20
"things to do 1month before soft-freeze".

- refresh MAINTAINERS entries
- look at what we can deprecate
- run cocci cleanup scripts

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>=20
>   hw/gpio/aspeed_gpio.c | 2 --
>   1 file changed, 2 deletions(-)
>=20
> diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c
> index 41e11ea9b04..e52fcfd9a03 100644
> --- a/hw/gpio/aspeed_gpio.c
> +++ b/hw/gpio/aspeed_gpio.c
> @@ -6,8 +6,6 @@
>    * SPDX-License-Identifier: GPL-2.0-or-later
>    */
>  =20
> -#include <assert.h>
> -
>   #include "qemu/osdep.h"
>   #include "qemu/host-utils.h"
>   #include "qemu/log.h"
>=20


