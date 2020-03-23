Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1387FC3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 14:48:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2A7C20753
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 14:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DGnrMSQ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2A7C20753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGONa-0001Bl-Ij
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 10:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43236)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jGOL8-0005uP-34
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 10:46:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jGOL6-0001BC-6G
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 10:46:05 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:40948)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jGOL6-0001AT-2I
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 10:46:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584974763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8rbiNVhEwOTNTE5kCQAB4GuD6vGvYD7Ldckz1YJB6Cc=;
 b=DGnrMSQ79eAW3nk/IAVgMVpJkr4WY/iOAZcLTlXWuszDEupeuoTH/ezstpxArFkQl9C8H0
 5HbUvt45qTpAidranEBqvOoafjGHyqKhjRkBETdGISfHilG+3/cVyc+KstnDqwG/9oDNoY
 OA8PfVnfKTjX+4V+iPnUXW8lLtjo6NM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-cWDwpw5zPACeDh0fkRl6YQ-1; Mon, 23 Mar 2020 10:45:58 -0400
X-MC-Unique: cWDwpw5zPACeDh0fkRl6YQ-1
Received: by mail-wm1-f71.google.com with SMTP id n188so3646522wmf.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 07:45:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=V2ANNl8/EtbHEsvrQEItRdzFbI+QSLZWoQl4H0q+yj8=;
 b=Oayw4IJjcrwecK78dcLJLgT9btDNc+VVNoWm62vxyZoytBKlXSPbqI2IZHWAl/RvJg
 xgquMldNyQT4ULW99PaH7k9emzy5Amtj0mpBTC8tVo2BOzKGVLM7gmMAW7qqtrERsd6U
 gQxemmnI4TJLwzVh2eMACU2I4xvqmERNnQYQyRogjn9qQuYoIU7hGydkaOA68lpS7ahl
 vj+H/LKp7YlTEjw+dFqMMkkJMMaP0moFe0oTIvsUV23g3hVdaSozXazYqEBR52rgu8br
 eym+DeqZKVM6XoPX6NCtn1cc3sIKL5u4JirrTJXITZpx01arw713KdpfeQhnRBbxp3u1
 6pWA==
X-Gm-Message-State: ANhLgQ0E5aq89rnf1czfTvvB08JpHUdmfYpNNELED8nWRo6OtbD8cY1f
 fR04tmcA2feLi4WO52Cyj4eOWT4GeqSU8hn4AekvMxTsEBW81lsNNKX9CNK7rdEZwhVK0a2s3tY
 j4dCufvEd/+Leq3k=
X-Received: by 2002:a1c:4c19:: with SMTP id z25mr3837603wmf.46.1584974757514; 
 Mon, 23 Mar 2020 07:45:57 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsmMyws088pfHXqIv0W5NO5iVC88qGt3tp/WqmTR6UgKsOiFeVz1tOPDxjslsxdjPCaHAb9HA==
X-Received: by 2002:a1c:4c19:: with SMTP id z25mr3837522wmf.46.1584974756932; 
 Mon, 23 Mar 2020 07:45:56 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id k84sm22270879wmk.2.2020.03.23.07.45.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2020 07:45:56 -0700 (PDT)
Subject: Re: [PATCH-for-5.0 v2 00/11] misc: Trivial static code analyzer fixes
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20200321144110.5010-1-philmd@redhat.com>
 <1c711740-6166-c730-ef67-d07511add1e6@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <262f8318-1590-1c48-f4de-a6482fdc3071@redhat.com>
Date: Mon, 23 Mar 2020 15:45:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1c711740-6166-c730-ef67-d07511add1e6@vivier.eu>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, Michael Tokarev <mjt@tls.msk.ru>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>, Max Reitz <mreitz@redhat.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/23/20 3:32 PM, Laurent Vivier wrote:
> Le 21/03/2020 =C3=A0 15:40, Philippe Mathieu-Daud=C3=A9 a =C3=A9crit=C2=
=A0:
>> Fix trivial warnings reported by the Clang static code analyzer.
>>
>> Since v1:
>> - Addressed Markus/Zoltan/Aleksandar review comments
>>
>> Philippe Mathieu-Daud=C3=A9 (11):
>>    block: Avoid dead assignment
>>    blockdev: Remove dead assignment
>>    hw/i2c/pm_smbus: Remove dead assignment
>>    hw/input/adb-kbd: Remove dead assignment
>>    hw/ide/sii3112: Remove dead assignment
>>    hw/isa/i82378: Remove dead assignment
>>    hw/gpio/aspeed_gpio: Remove dead assignment
>>    hw/timer/exynos4210_mct: Remove dead assignments
>>    hw/timer/stm32f2xx_timer: Remove dead assignment
>>    hw/timer/pxa2xx_timer: Add assertion to silent static analyzer warnin=
g
>>    hw/scsi/esp-pci: Remove dead assignment
>>
>>   block.c                    | 2 +-
>>   blockdev.c                 | 2 +-
>>   hw/gpio/aspeed_gpio.c      | 2 +-
>>   hw/i2c/pm_smbus.c          | 1 -
>>   hw/ide/sii3112.c           | 5 +++--
>>   hw/input/adb-kbd.c         | 6 +-----
>>   hw/isa/i82378.c            | 8 ++++----
>>   hw/scsi/esp-pci.c          | 1 -
>>   hw/timer/exynos4210_mct.c  | 3 ---
>>   hw/timer/pxa2xx_timer.c    | 1 +
>>   hw/timer/stm32f2xx_timer.c | 1 -
>>   11 files changed, 12 insertions(+), 20 deletions(-)
>>
>=20
> I think your series covers cases already covered by:
>=20
> [PATCH v3 00/12] redundant code: Fix warnings reported by Clang static
> code analyzer
> https://patchew.org/QEMU/20200302130715.29440-1-kuhn.ch

Unfortunately [for me...] I don't have v3 in my INBOX... *sigh*
This was 3 weeks ago. *sigh*.

I can see the series in the archives:
https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg00219.html
But I can't find the outcome, was it queued in the trivial tree?
Any idea when this will be merged in the master tree?

What a waste of time...

>=20
> Thanks,
> Laurent
>=20


