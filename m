Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8C9C2BB85
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 22:29:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D54E206E5
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 22:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSCKizLV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D54E206E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNl6x-0002mS-EY
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 18:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46579)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNl65-0001w8-8y
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:29:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNl64-0006s9-BZ
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:29:01 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36661)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNl62-0006r5-2X; Sun, 12 Apr 2020 18:28:58 -0400
Received: by mail-wr1-x442.google.com with SMTP id u13so8035087wrp.3;
 Sun, 12 Apr 2020 15:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tYOyvpY04MQytp/PzUIeQIoO+hm2K7ukKlxR4Ob5jog=;
 b=GSCKizLVdfNtqpHraeuTW98sCWlvDaanoZN8nPD00NuHtKHBgwwB2c5lU1qQg7MaVh
 luN/1TnsDiT2BZtg3l0MI7P3sZhMLitqjrBKOFe5NM5YHd5XmDQe+/4Qq2j99O8JoerS
 IQAr8OSX1E3rY/m6GnTe2ou/DUOTnv9FJ/ndsaH94kWiXw1seJXEDXRdbynKQDMG9IPi
 5/AXbB84RjDM9bi3fee/dX77xiDU5LR0JuPb3EG111mrwH4cySJf/aAmfpH3b+AbH32Q
 GGuWb7FfvG2+0j0jzTlCqWEzMKaqPxz5Up6r3aEnj1qNzhbVUFZVDMIu/qs/FIkjXz9U
 +wfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=tYOyvpY04MQytp/PzUIeQIoO+hm2K7ukKlxR4Ob5jog=;
 b=AxIgNhKDARuG3cd6Z0YHU6I5Lb0BX7Y53WVxNeQnHsitzPghb8s4T+PzGFM0bc/1P8
 JB0JQPk3T4U7bOSvuQAwufhebH9yP/DR5OyTb9e8P5Tl9pPk2kgapzkEH23g4FwAh+sF
 a9tDpXj1p6ZW6wqJ/4+iKU9tYtnNWMKvrG4gGUgF4PncM4tUkRtAncCgBkrwY2ZBzGDu
 ictA1FNuvnb6OudDmsUXo516dNf63v9QzTnhi56N5vtFjtSi+COWhG+68bIjVsR4rZSm
 7tarY9JnquoMlgRtTMiG2WG5plxz0odWtpKZzgKgZxmMx/pF3gId9SwDL7HgvKroYv2/
 um3Q==
X-Gm-Message-State: AGi0PubV+BvUXAd/HPWGPE3h9l72bASTZYYMumpc5+DRkIBv6NOn66u/
 TCwXRLQ/2A8QNf8KLWNIfPYgo6d0Z+g=
X-Google-Smtp-Source: APiQypJ0Hw0KN6u1o0Qyg+qNNw1QKxAx8aaEiaytyQlzx84xdLX7w0LqR97fckYs26Gy6UjpBpE8dw==
X-Received: by 2002:adf:f88b:: with SMTP id u11mr15492253wrp.84.1586730536833; 
 Sun, 12 Apr 2020 15:28:56 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id 5sm12020700wmg.34.2020.04.12.15.28.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Apr 2020 15:28:56 -0700 (PDT)
Subject: Re: [PATCH-for-5.1 v2 03/54] hw/arm/allwinner-a10: Move some code
 from realize() to init()
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
References: <20200406174743.16956-1-f4bug@amsat.org>
 <20200406174743.16956-4-f4bug@amsat.org>
 <e9eb76ff-b81b-91ad-55c1-62da93ca8cf4@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <ce641aca-062f-b765-d1ac-e176c0c2cdb2@amsat.org>
Date: Mon, 13 Apr 2020 00:28:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <e9eb76ff-b81b-91ad-55c1-62da93ca8cf4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Allwinner-a10" <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/6/20 8:00 PM, Eric Blake wrote:
> On 4/6/20 12:46 PM, Philippe Mathieu-Daudé wrote:
>> Coccinelle reported:
>>
>>    $ spatch ... --timeout 60 --sp-file \
>>      scripts/coccinelle/simplify-init-realize-error_propagate.cocci
>>    HANDLING: ./hw/arm/allwinner-a10.c
>>    >>> possible moves from aw_a10_init() to aw_a10_realize() in
>> ./hw/arm/allwinner-a10.c:77
>>
>> Move the calls using &error_fatal which don't depend of input
> 
> s/of/on/ (here, and in many subsequent messages in the series)

Thanks!

> 
>> updated before realize() to init().
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>   hw/arm/allwinner-a10.c | 26 +++++++++++++-------------
>>   1 file changed, 13 insertions(+), 13 deletions(-)
>>
> 

