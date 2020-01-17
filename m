Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D455C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 16:56:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BD392082F
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 16:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WX4yiDJW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BD392082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isUv5-0005xC-OJ
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 11:56:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49060)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1isUuH-0005BW-Q8
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 11:55:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1isUuE-0004lQ-C2
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 11:55:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33935
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1isUuE-0004l7-87
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 11:55:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579280133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nd0bXqos5it2fsYYHTou3mK1Mjt3pFhpidQ/WPuFGaA=;
 b=WX4yiDJWB/ivtv9EGQEb0Olc5tFlL0s0K2sv9wGaJOcDNAhG/4xDq71E3tJGAblnPnk55m
 djYiHREYGJfYJZ+fCLcaXxoobwww7clmDMBP13Ke4kt8NNZzlaqZLM5HyIRtlAisY23qrX
 gozq9BfrRNmxHo3TuEf5y55XONDcr5E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48--Yp5WEIoNYqm6okZq3_jsw-1; Fri, 17 Jan 2020 11:55:32 -0500
Received: by mail-wr1-f69.google.com with SMTP id k18so10772398wrw.9
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 08:55:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fyzRTIOREV58jx4vZ8G3KluoMzSIgrPRzuLoPsJGsrM=;
 b=XAtkOYG4uhHgRh+dyKTFFJiURNQ7F5nmGaUvsBxdCED5M+5EMy9XarndhjpA4y2LrR
 f0ib5H3HUH8h7CTzZELn+okRuQskNM2Va4vPozjxpUTvsCuiT+qWygkA2B9+h9jOJaTT
 rKMW9BG9Xbni+lxCl+5t4/tG0VkxU4uKYhxecGCyjc30nybrmutrf/qeZKzWTuJZcFCK
 LDvnQm5h9TBQ0KRGsb4t/qwX1MXlEAz95DMMALyBHP/k807e6a18WtXC6t5o0h1v/OfM
 LucLrhXn0Z9PvvHLEE+tmU8K3p7LHy70dJU7q75ZVxuax0js6zcCzyJD72ablnooYVYj
 AZxg==
X-Gm-Message-State: APjAAAVLt3cC7XrhLldGQU45N4MVDZ7jUiJT6m9tzzcLia+/SxlH3Jjq
 jLGOqgyAqAeBYfMfkewAREoZXbGrMTRYiQCazcAnTUqXh/FgGapH19Nu0QzgMqfFuB8h98+DRol
 dUgKT/EW59voVUTE=
X-Received: by 2002:a1c:66d6:: with SMTP id a205mr5741988wmc.171.1579280131417; 
 Fri, 17 Jan 2020 08:55:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqxwx7nOl6UUhTKNBw8l8IrVVx64aDd5IKkeOwfNbfiQu/J+NlayTvdjMRyJVdNddPB2Ehkbgg==
X-Received: by 2002:a1c:66d6:: with SMTP id a205mr5741958wmc.171.1579280131208; 
 Fri, 17 Jan 2020 08:55:31 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id 16sm9951251wmi.0.2020.01.17.08.55.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2020 08:55:30 -0800 (PST)
Subject: Re: [PATCH v2 0/6] Fix more GCC9 -O3 warnings
To: qemu-devel@nongnu.org
References: <20191218192526.13845-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a6eaee52-52fb-3541-fc67-fd2af35ae655@redhat.com>
Date: Fri, 17 Jan 2020 17:55:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191218192526.13845-1-philmd@redhat.com>
Content-Language: en-US
X-MC-Unique: -Yp5WEIoNYqm6okZq3_jsw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Olivier Danet <odanet@caramail.com>, Andrew Jeffery <andrew@aj.id.au>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Joel Stanley <joel@jms.id.au>, Markus Armbruster <armbru@redhat.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing qemu-trivial as this series is fully reviewed.

On 12/18/19 8:25 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Fix some trivial warnings when building with -O3.
>=20
> v2:
> - addressed Thomas and Aleksandar comments
> - dropped 'hw/scsi/megasas: Silent GCC9 duplicated-cond warning'
> - dropped 'qemu-io-cmds: Silent GCC9 format-overflow warning'
>=20
> Philippe Mathieu-Daud=C3=A9 (6):
>    audio/audio: Add missing fall through comment
>    hw/display/tcx: Add missing fall through comments
>    hw/timer/aspeed_timer: Add a fall through comment
>    hw/net/imx_fec: Rewrite fall through comments
>    hw/net/imx_fec: Remove unuseful FALLTHROUGH comments
>    hw/pci-host/designware: Remove unuseful FALLTHROUGH comment
>=20
>   audio/audio.c            | 1 +
>   hw/display/tcx.c         | 2 ++
>   hw/net/imx_fec.c         | 7 ++++---
>   hw/pci-host/designware.c | 2 +-
>   hw/timer/aspeed_timer.c  | 2 +-
>   5 files changed, 9 insertions(+), 5 deletions(-)
>=20
> Cc: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: "C=C3=A9dric Le Goater" <clg@kaod.org>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: "K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n" <dirty.ice.hu@gmail.com>
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Olivier Danet <odanet@caramail.com>
> Cc: Peter Chubb <peter.chubb@nicta.com.au>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: qemu-arm@nongnu.org
>=20


