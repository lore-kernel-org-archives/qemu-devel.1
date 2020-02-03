Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14412C35249
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 16:29:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D714020CC7
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 16:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TqV8Lco/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D714020CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyebE-00004r-2J
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 11:29:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47615)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iyeZw-00072g-Nz
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 11:28:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iyeZv-0005zd-Mh
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 11:28:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33506
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iyeZv-0005tF-Ik
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 11:28:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580747281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7dJXNaeM/sqgl8NiGZlY/jcuuoz17ROhcoGWI14l0Mk=;
 b=TqV8Lco/Dhzx/4BimBTM2jebl7sVqcLaqcfuPxzwm31b91GCHl9llYytGcvwhHG8SKGX2s
 ae6JrQFbcOeTAy3TiYSG7M+Z+6A/ojrV6/DfbQnBUuOF1pCuTGke/9MQdT4l8y+Yj6ynSz
 P7HQMTLjzASWH7UZUtRAxTLCn0u2m8w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-izUuqDzTOW2SiLVELNTcjg-1; Mon, 03 Feb 2020 11:27:59 -0500
Received: by mail-wm1-f70.google.com with SMTP id m4so4225893wmi.5
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 08:27:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dayF1ugLzQY3wM/H3VSX6J0sehC4Ht2b8PcXS8EjYIA=;
 b=fdtHSnZp8ROWmDOgLf2n1gPO2xR+mYP8Ia4ojEufGP1jf1Rwak2TrMYevc42NHszKp
 G4kotR7uewJzqZJY6QFjTrth+hCKbyJi3TFh8Ap/BDjeNaMSR++1RIvzZehwb4OpSaNS
 C1uLVE1QZ6WjiUo3pi3JBdkmGYLb89s4L6kvxGx4thKuhxOXDA9Tze2yKurU+tXSXakm
 Nm0tvz4X0cGcEIEuzmtCpw1kTzUryzy83pIht71Y5K4v4TH9gHh7WWdlfm50S+7LzgJx
 sZEIHcYUal56fMUb5Pb5sn/qHfUKPml06H7x0kXOfrPhaJLw6Z4gG7bpsTXaSX25sR/x
 khGA==
X-Gm-Message-State: APjAAAVORq5PpO9yKq28QN8Cv7OAlp2TuA3BoSX4zJCcOJZGdTDFRjuV
 TLLu5fA1TSy816dFA4cXtne2a6gTe7mWr3ciOhT0by9V6HWrCPXi0t8GGvxBhqzbf7EwBh/Sgd/
 NiIePjVD7MLFdcZ4=
X-Received: by 2002:a7b:cae9:: with SMTP id t9mr29578325wml.186.1580747277977; 
 Mon, 03 Feb 2020 08:27:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqyJW0NCv5GaZtUgDP6V9LSi0/Zzh0bCEjFZ7OM818+63yr19NBFWJUf8p9pJTdJdMPa8uiVHg==
X-Received: by 2002:a7b:cae9:: with SMTP id t9mr29578312wml.186.1580747277777; 
 Mon, 03 Feb 2020 08:27:57 -0800 (PST)
Received: from [192.168.1.35] (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id v14sm26509162wrm.28.2020.02.03.08.27.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2020 08:27:57 -0800 (PST)
Subject: Re: [PATCH v2 1/2] bcm2835_dma: Fix the ylen loop in TD mode
To: Rene Stange <rsta2@o2online.de>
References: <11456775.FKKu9GnblS@desktop2>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <22289975-5cd7-47e3-6942-cc95dac80572@redhat.com>
Date: Mon, 3 Feb 2020 17:27:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <11456775.FKKu9GnblS@desktop2>
Content-Language: en-US
X-MC-Unique: izUuqDzTOW2SiLVELNTcjg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 qemu-devel <qemu-devel@nongnu.org>,
 Andrew Baumann <andrew.baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/3/20 4:40 PM, Rene Stange wrote:
> In TD (two dimensions) DMA mode ylen has to be increased by one after
> reading it from the TXFR_LEN register, because a value of zero has to
> result in one run through of the ylen loop. This has been tested on a
> real Raspberry Pi 3 Model B+. In the previous implementation the ylen
> loop was not passed at all for a value of zero.
>=20
> Signed-off-by: Rene Stange <rsta2@o2online.de>
> ---
>   hw/dma/bcm2835_dma.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/dma/bcm2835_dma.c b/hw/dma/bcm2835_dma.c
> index 1e458d7fba..667d951a6f 100644
> --- a/hw/dma/bcm2835_dma.c
> +++ b/hw/dma/bcm2835_dma.c
> @@ -70,14 +70,14 @@ static void bcm2835_dma_update(BCM2835DMAState *s, un=
signed c)
>           ch->stride =3D ldl_le_phys(&s->dma_as, ch->conblk_ad + 16);
>           ch->nextconbk =3D ldl_le_phys(&s->dma_as, ch->conblk_ad + 20);
>  =20
> +        ylen =3D 1;
>           if (ch->ti & BCM2708_DMA_TDMODE) {
>               /* 2D transfer mode */
> -            ylen =3D (ch->txfr_len >> 16) & 0x3fff;
> +            ylen +=3D (ch->txfr_len >> 16) & 0x3fff;
>               xlen =3D ch->txfr_len & 0xffff;
>               dst_stride =3D ch->stride >> 16;
>               src_stride =3D ch->stride & 0xffff;
>           } else {
> -            ylen =3D 1;
>               xlen =3D ch->txfr_len;
>               dst_stride =3D 0;
>               src_stride =3D 0;
>=20

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


