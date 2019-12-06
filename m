Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45598C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 16:03:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11CE62173E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 16:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HyV/X761"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11CE62173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idG4a-000399-8q
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 11:03:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40267)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1idEpY-0005G1-M7
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:43:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1idEpW-0007eD-KY
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:43:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54869
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1idEpQ-0007Z6-Dl
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:43:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575643408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bcJsuN0uc2QQexMT1eYTSvjKbb/lqPwOWAOZ/9a1QjQ=;
 b=HyV/X761YxtZ16fMx3z+ghflA1K9x8LCUN+4791QzH8IMo69iVjDaGA4QQsW6tAHfDeD26
 zxaZAxG+TauN+9yFx8bRU0RXEd8g08MyWq9b7C9OL/Kj8U3svrztvolbI3hGIXYhVpu1HP
 lRdcmgHQJrFHMKVJOR+oPoqo/5Bhx1g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-Z_hNq9acPpySwz1Q-jWDKw-1; Fri, 06 Dec 2019 02:41:27 -0500
Received: by mail-wr1-f70.google.com with SMTP id v17so2753489wrm.17
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 23:41:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7TrjYj1w7NnP1JJuLOJe1mNeJsGC92eImwnNUHEwIGo=;
 b=NhXaYwXgQe/Z/D+f3N3uGmwDdnt+KKNf+hVuGhMOFvBqM+3mxwETOkjx9A3WK9LoRp
 7p7CZcpdWiQ6SCnSjHcJzUDRfBzXHsBNnVv6gQ9CHfd9+5IQ84d9pZbEkbKN7eov3YH4
 WJYqHF8ZruwjnVfibUR7xQCqnA9WLunqwQf1FfF9rKz4kX+25vVbV0/rY2qNUbedNlSV
 2K9gEMsScOd4vz9s0nYu2Hnz5hRB77lxExYVZNwXIXS8foP4fd4ujy9pQCgowoot5IQg
 rsmJYNuvEoTG5oXZNQOjLwxkXzx1PVMSQ9J17IabKvhaTgi1f3fX4RqUl5z30bbAxoAP
 DbWQ==
X-Gm-Message-State: APjAAAWMz529qm5aiXPgwEv2yWCjmUcnA+7Z+kTxYjhnTpGH83hd72EK
 PyyJAg7zxRVl4V6OLllnCL8qyMzwancVgeXxrysEYA5+MDZMv11aOT8CRsDNfdY3IwOCYJ4p/ba
 RxAqLs3z11rGfKz8=
X-Received: by 2002:a1c:20d6:: with SMTP id g205mr9181061wmg.38.1575618085998; 
 Thu, 05 Dec 2019 23:41:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqzstkydDuDYK23e4s2/A84s0JXUfqsOe5mY0HqfljoYynleUANOXCD9k16hfpoDFzYeUmb4Og==
X-Received: by 2002:a1c:20d6:: with SMTP id g205mr9181048wmg.38.1575618085801; 
 Thu, 05 Dec 2019 23:41:25 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id h8sm16265275wrx.63.2019.12.05.23.41.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2019 23:41:25 -0800 (PST)
Subject: Re: [PATCH v8 01/21] hw/core/loader-fit: fix freeing errp in
 fit_load_fdt
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20191205174635.18758-1-vsementsov@virtuozzo.com>
 <20191205174635.18758-2-vsementsov@virtuozzo.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0326f40c-6f07-9910-cb45-73b9c4effd88@redhat.com>
Date: Fri, 6 Dec 2019 08:41:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191205174635.18758-2-vsementsov@virtuozzo.com>
Content-Language: en-US
X-MC-Unique: Z_hNq9acPpySwz1Q-jWDKw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: Paul Burton <pburton@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>, armbru@redhat.com,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/5/19 6:46 PM, Vladimir Sementsov-Ogievskiy wrote:
> fit_load_fdt forget to check that errp is not NULL and to zero it after
> freeing. Fix it.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

> ---
>   hw/core/loader-fit.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/core/loader-fit.c b/hw/core/loader-fit.c
> index 953b16bc82..3ee9fb2f2e 100644
> --- a/hw/core/loader-fit.c
> +++ b/hw/core/loader-fit.c
> @@ -200,7 +200,10 @@ static int fit_load_fdt(const struct fit_loader *ldr=
, const void *itb,
>       err =3D fit_image_addr(itb, img_off, "load", &load_addr, errp);
>       if (err =3D=3D -ENOENT) {
>           load_addr =3D ROUND_UP(kernel_end, 64 * KiB) + (10 * MiB);
> -        error_free(*errp);
> +        if (errp) {
> +            error_free(*errp);
> +            *errp =3D NULL;
> +        }
>       } else if (err) {
>           error_prepend(errp, "unable to read FDT load address from FIT: =
");
>           ret =3D err;
>=20


