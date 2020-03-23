Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D6DC3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 15:02:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 634122076A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 15:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hbs3r9vN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 634122076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGOb9-0002L1-Gi
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 11:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46697)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jGOZl-0000wz-6c
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 11:01:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jGOZj-0008IM-KS
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 11:01:13 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:43147)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jGOZj-0008G9-FV
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 11:01:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584975671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KKeE6h7tq0L0aScGIdzsCho9ssli9lSjPim6mqvxRxM=;
 b=Hbs3r9vNL7BOMZP9gPPgpJdr6km7WTEtQZRqV5FVxRNhajgCG0O/MaAvFIrwu21wrnXYjq
 aBNl2bEUQ0R57MJQqvuqfNknx02ojLjfPHLFLekuFMkhr0ZTprK/TEfrIvKK2KGk/+CSSB
 0c+WKLpuzkgShZ7mwENUEcZEYOrx480=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-k94KlYssNNC0eF-Ghj8GBA-1; Mon, 23 Mar 2020 11:01:08 -0400
X-MC-Unique: k94KlYssNNC0eF-Ghj8GBA-1
Received: by mail-wr1-f71.google.com with SMTP id h14so1342764wrr.12
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 08:01:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=B6se+74uq8IigJ1DNxLJ6QpeoObvmc8ZqUW9UUwi4Q0=;
 b=jehAnD4gyx7dltO1m1bYxBnJTn12bGIJZ3+cjnk08G1BiBTQ2Ojdij8M/ZnfWNdAIT
 zNrMcQn3sfz1BKaYU9xn76QFOsVeOgax1/pn3sfZ93CKBts3WRj9hBoy7DAg7oEJzYVc
 DI1T7uMsmrza272f99Xuzd0cMJFZsdoLP5YQl7sJPwk8WB6oMvFLk+vQ9PioZPkUK+FF
 DotiRKWd+w7ymh8dl4rRCOzvpd6EJFFayKnS1gjw6Jw7UgkPkztjb3VxnycvaJV9URnI
 bnomJlbi+IpqZ8CpVsEsVK67xHtC/Zd96Zik1FRFdduS2XlFPmjh41VGqXOEEijxOv+h
 xVYQ==
X-Gm-Message-State: ANhLgQ2GHuLzHJwVuTBWDTdC64a2aAmrMi1EBGRIIKYkfmVAyFvR5X2T
 Zg91kiEM6jk04g9DHPul49m7k70HCsrxZ3W8XgK6WkivneN9KmlHpc7pljbg51EV1uvtjommbkL
 j83mcQG27KXjoLbw=
X-Received: by 2002:adf:8187:: with SMTP id 7mr17180826wra.358.1584975667297; 
 Mon, 23 Mar 2020 08:01:07 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsqbZz7XS24jPIEitY/s+pboxe+xe1aAHnfRZBsn+CWsdJyJn151SubRHkXg56MfNDCQw9PTg==
X-Received: by 2002:adf:8187:: with SMTP id 7mr17180780wra.358.1584975666830; 
 Mon, 23 Mar 2020 08:01:06 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id f14sm21834164wmb.3.2020.03.23.08.01.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2020 08:01:06 -0700 (PDT)
Subject: Re: [PATCH-for-5.0 v2 00/11] misc: Trivial static code analyzer fixes
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20200321144110.5010-1-philmd@redhat.com>
 <1c711740-6166-c730-ef67-d07511add1e6@vivier.eu>
 <262f8318-1590-1c48-f4de-a6482fdc3071@redhat.com>
 <10431e44-880a-cbec-c35e-1d425064c40b@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1016a691-244d-9890-01bb-894e62414963@redhat.com>
Date: Mon, 23 Mar 2020 16:01:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <10431e44-880a-cbec-c35e-1d425064c40b@vivier.eu>
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

On 3/23/20 3:55 PM, Laurent Vivier wrote:
> Le 23/03/2020 =C3=A0 15:45, Philippe Mathieu-Daud=C3=A9 a =C3=A9crit=C2=
=A0:
>> On 3/23/20 3:32 PM, Laurent Vivier wrote:
>>> Le 21/03/2020 =C3=A0 15:40, Philippe Mathieu-Daud=C3=A9 a =C3=A9crit=C2=
=A0:
>>>> Fix trivial warnings reported by the Clang static code analyzer.
>>>>
>>>> Since v1:
>>>> - Addressed Markus/Zoltan/Aleksandar review comments
>>>>
>>>> Philippe Mathieu-Daud=C3=A9 (11):
>>>>  =C2=A0=C2=A0 block: Avoid dead assignment
>>>>  =C2=A0=C2=A0 blockdev: Remove dead assignment
>>>>  =C2=A0=C2=A0 hw/i2c/pm_smbus: Remove dead assignment
>>>>  =C2=A0=C2=A0 hw/input/adb-kbd: Remove dead assignment
>>>>  =C2=A0=C2=A0 hw/ide/sii3112: Remove dead assignment
>>>>  =C2=A0=C2=A0 hw/isa/i82378: Remove dead assignment
>>>>  =C2=A0=C2=A0 hw/gpio/aspeed_gpio: Remove dead assignment
>>>>  =C2=A0=C2=A0 hw/timer/exynos4210_mct: Remove dead assignments
>>>>  =C2=A0=C2=A0 hw/timer/stm32f2xx_timer: Remove dead assignment
>>>>  =C2=A0=C2=A0 hw/timer/pxa2xx_timer: Add assertion to silent static an=
alyzer
>>>> warning
>>>>  =C2=A0=C2=A0 hw/scsi/esp-pci: Remove dead assignment
>>>>
>>>>  =C2=A0 block.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
>>>>  =C2=A0 blockdev.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
>>>>  =C2=A0 hw/gpio/aspeed_gpio.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
>>>>  =C2=A0 hw/i2c/pm_smbus.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 1 -
>>>>  =C2=A0 hw/ide/sii3112.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 5 +++--
>>>>  =C2=A0 hw/input/adb-kbd.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 6 +-----
>>>>  =C2=A0 hw/isa/i82378.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 8 ++++----
>>>>  =C2=A0 hw/scsi/esp-pci.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 1 -
>>>>  =C2=A0 hw/timer/exynos4210_mct.c=C2=A0 | 3 ---
>>>>  =C2=A0 hw/timer/pxa2xx_timer.c=C2=A0=C2=A0=C2=A0 | 1 +
>>>>  =C2=A0 hw/timer/stm32f2xx_timer.c | 1 -
>>>>  =C2=A0 11 files changed, 12 insertions(+), 20 deletions(-)
>>>>
>>>
>>> I think your series covers cases already covered by:
>>>
>>> [PATCH v3 00/12] redundant code: Fix warnings reported by Clang static
>>> code analyzer
>>> https://patchew.org/QEMU/20200302130715.29440-1-kuhn.ch
>>
>> Unfortunately [for me...] I don't have v3 in my INBOX... *sigh*
>> This was 3 weeks ago. *sigh*.
>>
>> I can see the series in the archives:
>> https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg00219.html
>> But I can't find the outcome, was it queued in the trivial tree?
>> Any idea when this will be merged in the master tree?
>=20
> Some patches are already merged via trivial (1, 2 (should go by SCSI
> queue) 3, 5, 6, 7, 9, 11 (by USB queue), 12).
>=20
> But others needed R-b tags or new version. I didn't check which of your
> patches are already covered by this series.
>=20
> I'm sorry to not have checked your series earlier...

Don't be sorry, the problem is my INBOX that is unreliable.

I was using NNTP last month until I heard it was working properly again,=20
which is not the case apparently. I'll try to find them on NNTP and=20
review them.

>=20
> Thanks,
> Laurent
>=20


