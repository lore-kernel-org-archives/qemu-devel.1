Return-Path: <SRS0=IrLN=YF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D14C4360C
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 06:09:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C762120650
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 06:09:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C762120650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJAae-0006sU-0u
	for qemu-devel@archiver.kernel.org; Sat, 12 Oct 2019 02:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43877)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iJAZs-0006Ds-9M
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 02:08:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iJAZr-00072c-8j
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 02:08:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46240)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iJAZr-00072O-3j
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 02:08:31 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 42A32C06513B
 for <qemu-devel@nongnu.org>; Sat, 12 Oct 2019 06:08:30 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id f4so1710287wrj.12
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 23:08:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0vnpcsrU0I2Pe6Mkan6uKknulM/dk2vQZizhIQox5tI=;
 b=BVjtFOkF0xJZQls31k1sLa0PJr5tfJSxbom+kKemfb/2moNz+K9bcmXKacJCD2g3jo
 0OtDJ7Ooe4KTCMGgcR+/ZrxDMzvU+pO0/CS6curGLjeY+U0x5sKrdJ3Apltktq9Gn3Hv
 wXb4CXCgDXphK11OScsMS9U1i5oSU/HEJA818jY2y2qBIXv5ZQKx3w+r5wLbeaeENPem
 oxz9fTu7Ho7a5vulIMIp9+zfUylroyFHjRMEPF+K5BATDCIKgpp7lAyQN5BbNhuzdHFW
 SPxpdvhNyqvIzcXeLgDl3k7ePPtY1bXDgfdjI5Hh9YTm+0BoJwY0PhWdMr2yJwCWpzVT
 xIOQ==
X-Gm-Message-State: APjAAAVmojC9FbvfJJY12HQkyccLWMqJGYQBA9vtNFy3hKWELlf3XsRe
 zwj431C5hdsJVTjEH/S9gTP8I8u+NYxYAH3qOhxOLgsi+xfGFRSMtIhLzwWtnDIIw65i9HxbWk2
 PU2r6xdtGzvDuB4o=
X-Received: by 2002:adf:f48c:: with SMTP id l12mr15364795wro.99.1570860509071; 
 Fri, 11 Oct 2019 23:08:29 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw/6dcSdA6Wn90amI6/2MYBQXYL4l+rLx9et5wZwfH4Z8jJGdvHoersE1ueYnwpI7cMgNf7ag==
X-Received: by 2002:adf:f48c:: with SMTP id l12mr15364783wro.99.1570860508902; 
 Fri, 11 Oct 2019 23:08:28 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id e6sm13947086wre.29.2019.10.11.23.08.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Oct 2019 23:08:28 -0700 (PDT)
Subject: Re: [RFC v5 022/126] backends/cryptodev: drop local_err from
 cryptodev_backend_complete()
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20191011160552.22907-1-vsementsov@virtuozzo.com>
 <20191011160552.22907-23-vsementsov@virtuozzo.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f4ba75f7-3f2a-74fb-af16-21d81af30149@redhat.com>
Date: Sat, 12 Oct 2019 08:08:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191011160552.22907-23-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: "Gonglei \(Arei\)" <arei.gonglei@huawei.com>, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/11/19 6:04 PM, Vladimir Sementsov-Ogievskiy wrote:
> No reason for local_err here, use errp directly instead.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   backends/cryptodev.c | 11 +----------
>   1 file changed, 1 insertion(+), 10 deletions(-)
>=20
> diff --git a/backends/cryptodev.c b/backends/cryptodev.c
> index 3c071eab95..5a9735684e 100644
> --- a/backends/cryptodev.c
> +++ b/backends/cryptodev.c
> @@ -176,19 +176,10 @@ cryptodev_backend_complete(UserCreatable *uc, Err=
or **errp)
>   {
>       CryptoDevBackend *backend =3D CRYPTODEV_BACKEND(uc);
>       CryptoDevBackendClass *bc =3D CRYPTODEV_BACKEND_GET_CLASS(uc);
> -    Error *local_err =3D NULL;
>  =20
>       if (bc->init) {
> -        bc->init(backend, &local_err);
> -        if (local_err) {
> -            goto out;
> -        }
> +        bc->init(backend, errp);
>       }
> -
> -    return;
> -
> -out:
> -    error_propagate(errp, local_err);
>   }
>  =20
>   void cryptodev_backend_set_used(CryptoDevBackend *backend, bool used)
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

