Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1DCC47404
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 08:58:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62D4A2070B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 08:58:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62D4A2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGJPU-0003hO-Dj
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 04:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46128)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iGJOp-0003HB-9j
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 04:57:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iGJOo-0000DY-44
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 04:57:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58926)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iGJOn-0000DO-VH
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 04:57:18 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0FAB787642
 for <qemu-devel@nongnu.org>; Fri,  4 Oct 2019 08:57:17 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id m6so1348116wmf.2
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2019 01:57:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+B1ULy5eSn5gYCYWwpAYpEM18a+PeV2OSkv+Ptq3lqc=;
 b=b8+wzmF7QuLdXvtDvoCYwE94XGWWoqIP65kXWgrUjExQBQFq16Hpz3Mhs3hqU9poe5
 6uKReO9r5sWGC+3+VV3/oCD/3nP0f57skPntV76YGDPi0uFoQGhPqnHZIrslHt8qU7zE
 WFHvB7KEo/81aBnv7uy14m3u2OfGwIXc/18/EurO3S7kHbW9EnG90+QrLMxDXKGG4ZKx
 fcTt3z0ak7Y/stLbBjJX64AgaYOjrJZ+vOgo25t2kqRcqy/hpLmyVLPAP2wv8S91hNal
 59cQLiL+jTgA22QvqGBC7JMCO2mkIdWM70Fx2gp5PSR/T+4+TH5oLmjD8QHpYwfXevD+
 UJhQ==
X-Gm-Message-State: APjAAAWdKrkbpoMVgGnr5XC1/3m07HMErIY3Ezd3z7xeRsDYMCdagMH/
 TO1L68sHKfEIJHvXAiCRcXGwIuHe/ubDYAi/RcKSF4XSjyN1jE9rmy06Ae6o4m37iZrOdSCiedA
 hhBprLHEW5sF82OU=
X-Received: by 2002:a7b:c112:: with SMTP id w18mr10436061wmi.88.1570179435835; 
 Fri, 04 Oct 2019 01:57:15 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyl2+mxkc74MJwQTtFio425WONKGEw5RyKhEQjRNJvla+Idcm+hanYC5j4FpyTNleO7jxk1CQ==
X-Received: by 2002:a7b:c112:: with SMTP id w18mr10436051wmi.88.1570179435659; 
 Fri, 04 Oct 2019 01:57:15 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id r2sm4360355wrm.3.2019.10.04.01.57.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2019 01:57:15 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] curses: use the bit mask constants provided by
 curses
To: Matthew Kilgore <mattkilgore12@gmail.com>, qemu-devel@nongnu.org
References: <20191004035338.25601-1-mattkilgore12@gmail.com>
 <20191004035338.25601-2-mattkilgore12@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <56d01d33-c9ed-be85-cce8-3119961b2bf9@redhat.com>
Date: Fri, 4 Oct 2019 10:57:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191004035338.25601-2-mattkilgore12@gmail.com>
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
Cc: samuel.thibault@ens-lyon.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/4/19 5:53 AM, Matthew Kilgore wrote:
> The curses API provides the A_ATTRIBUTES and A_CHARTEXT bit masks for
> getting the attributes and character parts of a chtype, respectively. W=
e
> should use provided constants instead of using 0xff.
>=20
> Signed-off-by: Matthew Kilgore <mattkilgore12@gmail.com>

Thanks for splitting your previous patch!

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   ui/curses.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/ui/curses.c b/ui/curses.c
> index ec281125acbd..84003f56a323 100644
> --- a/ui/curses.c
> +++ b/ui/curses.c
> @@ -75,8 +75,8 @@ static void curses_update(DisplayChangeListener *dcl,
>       line =3D screen + y * width;
>       for (h +=3D y; y < h; y ++, line +=3D width) {
>           for (x =3D 0; x < width; x++) {
> -            chtype ch =3D line[x] & 0xff;
> -            chtype at =3D line[x] & ~0xff;
> +            chtype ch =3D line[x] & A_CHARTEXT;
> +            chtype at =3D line[x] & A_ATTRIBUTES;
>               ret =3D getcchar(&vga_to_curses[ch], wch, &attrs, &colors=
, NULL);
>               if (ret =3D=3D ERR || wch[0] =3D=3D 0) {
>                   wch[0] =3D ch;
>=20

