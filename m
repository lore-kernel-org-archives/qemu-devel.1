Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D16C1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 07:19:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64F46206F6
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 07:19:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64F46206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH0KR-0001ds-IC
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 03:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36639)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jH0Jc-000152-Fe
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 03:19:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jH0Jb-0006Pm-ED
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 03:19:04 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:46425)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jH0Jb-0006PP-5k; Wed, 25 Mar 2020 03:19:03 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1M1ZUb-1jDzN92oDj-0038ZC; Wed, 25 Mar 2020 08:18:52 +0100
Subject: Re: [PATCH v5 2/3] display/blizzard: use extract16() for fix clang
 analyzer warning in blizzard_draw_line16_32()
To: Chen Qun <kuhn.chenqun@huawei.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <20200325025919.21316-1-kuhn.chenqun@huawei.com>
 <20200325025919.21316-3-kuhn.chenqun@huawei.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <eee39214-5646-447b-82f3-34fb31f2509c@vivier.eu>
Date: Wed, 25 Mar 2020 08:18:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200325025919.21316-3-kuhn.chenqun@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:DcQGS2Ul1v2pX0QND/Euowuyah1TrmKFAfKkcscRiQiz8TqW5Lx
 6aI8X48NXbpzJ24ZwDDDpZ/bjD9MRPq0I0b8Igx0k6wjog2REaX4UgYyThwivd5IopYbZoB
 igS3veUYevrZD0aDVb3ScP169S+e1htS/6qH44YM3peU9tOSSIw1+SJ7b1kyLogGODu0XAb
 TorjIZfm64oBEZolSEGmw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Qn82CUbOicY=:k/drKffRQejIcxQlS/oBxE
 chR+oRuJo/t5azrD2ybNLwXcdQ3Iank7WsNGRLm0cpOkpF61SNX6m3wkwWnu/r4iZInWcQsBw
 iaTf+1YdJm6HeZ3e7fjVixl7gke7kHZg5zeWsmk2JZpfg/9hIbAn0n53bbBaaGXeJAzQrcQEp
 Y1g6YGSPeBg0YnFFkmdn2V6T3VEOHZvc4XzqudxEz9v7e24pbrSdMUoNVbFOIhP3KB+LbHYHN
 9Z+yonsvfK4XIO1uVmML+sQdbbVJ9S3a+Ol0yOPVyYekAcpU5iFOdHMzX+f6q7OKfbcSdBPtN
 cl5wuvJ+iXiHyo0BGj3ixcZk3JAe95Ab0qUbyXeJ5a0OQwMGZwAkbrxlH1Xwf2BLonQSCQzEk
 zcFtXEuKGt9dZW+aTA8UGBYl0Zou5AV6tD7r5BPysWkHF5ifdOq9KagfXP+JKD9fmCb0h8ozJ
 jw6KHCOPOP5xIqNsmAFaJCMhc2lBmapPWDBlbnw9yrN7MI6oFqBMcAIMDHaMiS5MLGr/JBKgU
 cC933mzRDtg/q433J5SjKuF4GfwqvRpPDX0ZlqqW/lJ4LWRVffw6K4QpMZgSIeeuXZGZVq6OW
 RjNPhVN2TrO/ITHRbqfG6fH4UU1+RqMFrdbQ3CpMgZzo/p1GfiTSAeaF6yVZN8rAkFJQreVA4
 ZjWa6S1o8+S6MpTC4pCyJ/6JMSxVk9l3nSYkqmoL7R1wbJRIe0Ok1/MQ/EJn+TMHiAkkwHwSj
 /LLl04ue3ELXF27ivV8zZ/0eXdvXxf5MNKZ1GBNavaaPld6jcsMPxGZtgiwoiKVKF3qimFE4b
 x0Z5+UGCkezSmpRxnVeIg4/2Kidh/JKfOYnDz+bE1yr4WGaxQC/dYGRAlbGOrkU8qSze6Xw
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
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
Cc: Peter Maydell <peter.maydell@linaro.org>, philmd@redhat.com,
 zhang.zhanghailiang@huawei.com, Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 25/03/2020 à 03:59, Chen Qun a écrit :
> Clang static code analyzer show warning:
>   hw/display/blizzard.c:940:9: warning: Value stored to 'data' is never read
>         data >>= 5;
>         ^        ~
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> ---
> Cc: Andrzej Zaborowski <balrogg@gmail.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> 
> v1->v2: Use extract16() function instead of bit operation(Base on Laurent's comments).
> ---
>  hw/display/blizzard.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/display/blizzard.c b/hw/display/blizzard.c
> index 359e399c2a..105241577d 100644
> --- a/hw/display/blizzard.c
> +++ b/hw/display/blizzard.c
> @@ -19,6 +19,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/bitops.h"
>  #include "ui/console.h"
>  #include "hw/display/blizzard.h"
>  #include "ui/pixel_ops.h"
> @@ -932,12 +933,9 @@ static void blizzard_draw_line16_32(uint32_t *dest,
>      const uint16_t *end = (const void *) src + width;
>      while (src < end) {
>          data = *src ++;
> -        b = (data & 0x1f) << 3;
> -        data >>= 5;
> -        g = (data & 0x3f) << 2;
> -        data >>= 6;
> -        r = (data & 0x1f) << 3;
> -        data >>= 5;
> +        b = extract16(data, 0, 5) << 3;
> +        g = extract16(data, 5, 6) << 2;
> +        r = extract16(data, 11, 5) << 3;
>          *dest++ = rgb_to_pixel32(r, g, b);
>      }
>  }
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

