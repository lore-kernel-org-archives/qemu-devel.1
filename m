Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA30C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 16:03:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B91E62084E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 16:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="It75pTHI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B91E62084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz0fu-0006CP-VF
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 11:03:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35380)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iz0ej-0004rT-B2
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:02:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iz0eh-0000mp-3r
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:02:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35143
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iz0eg-0000h4-Uw
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:02:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580832143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xJBsJM6oHLWYmTdPSMfmjpK6FrcFpRQsjFMj20DGgX0=;
 b=It75pTHI9b0qP8+aZOXEIzmEyc7bcSniNvUGXYemQdXnOVmaLCpe8Nw0txKVsKWS5K6I7u
 GZDe5WN3ZJkdFR2XH/FMtlOfZSLoI2gPVsKV+PL7ehxDunIBtx7hrptL3uO72uEpy+HSpr
 OGB7aywZl6a7XMmYS/Q8xE0mJtFuxL0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-aRT3kdW7PUGuzMSuDewc8w-1; Tue, 04 Feb 2020 11:02:08 -0500
Received: by mail-wr1-f71.google.com with SMTP id t6so7420388wru.3
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 08:02:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QgKCcE2qX5WKdqnHqDNs3FRp14Iys6nLJYdAwojKX/I=;
 b=DQYkaw2KD/HuvbD7OzFPzbHakko0N2VoxuLC7ZOLYyCF8QylC698V3qVnr06IPwqE0
 5x6OpXceUWhCHKv/g3fOXfmJdeV0XrzDZv6/bsO72xRx0y+2aQR4L0n3fs9YA1T5lmQZ
 Kwb00H2eKh7oSJI6E7jlkg+36SlaqDJMEOziZFFHZMRwqLx5GkiNFCINzn39TjC2Ell9
 nelfsVayLP7YXRVtIbLRWVHZGhVChwxwy/tudnrEjcQFvMZK+/hOM1JcRjdzVvD3xn/O
 +8D3ff0T+xM89nE93jbrKG21W0UHAsvMaAjoDuvNFMUByJDvAWI5LB5kREKkYpyyHcOH
 TdDQ==
X-Gm-Message-State: APjAAAVQPo9fHRuoygVb5R9dDfymuCAfU4Hp+mIPfXVBAX5fdRoGqXQ8
 ZfvwEQaKjdh8pevMxiE8FzgtEXLmvOqGIJdwjqHzw48KEod+UulJ9I3AS3Yf7ftgDYgcITNYVjP
 ItpVwDhPQ18jhQjQ=
X-Received: by 2002:a5d:4c89:: with SMTP id z9mr17111737wrs.97.1580832125810; 
 Tue, 04 Feb 2020 08:02:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqwc2TIvVDa9pcW645AemL4ZVKDqvh7C70iAkyJVfK1n1oVrjqlA4j94yS3LivdH3Ir6wG6Rug==
X-Received: by 2002:a5d:4c89:: with SMTP id z9mr17111723wrs.97.1580832125627; 
 Tue, 04 Feb 2020 08:02:05 -0800 (PST)
Received: from [192.168.1.35] (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id e17sm4203105wma.12.2020.02.04.08.02.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2020 08:02:05 -0800 (PST)
Subject: Re: [PATCH] scripts/signrom: remove Python 2 support, add shebang
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200204160028.16211-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a1940860-ff53-ee17-bb28-bfae85bc4b98@redhat.com>
Date: Tue, 4 Feb 2020 17:02:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200204160028.16211-1-pbonzini@redhat.com>
Content-Language: en-US
X-MC-Unique: aRT3kdW7PUGuzMSuDewc8w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/4/20 5:00 PM, Paolo Bonzini wrote:
> Based-on: <20200130163232.10446-1-philmd@redhat.com>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   scripts/signrom.py | 12 ++++--------
>   1 file changed, 4 insertions(+), 8 deletions(-)
>=20
> diff --git a/scripts/signrom.py b/scripts/signrom.py
> index 313ee28a17..9be5dab1cf 100644
> --- a/scripts/signrom.py
> +++ b/scripts/signrom.py
> @@ -1,3 +1,5 @@
> +#!/usr/bin/env python3
> +
>   from __future__ import print_function
>   #
>   # Option ROM signing utility
> @@ -44,14 +46,8 @@ fout.write(data)
>  =20
>   checksum =3D 0
>   for b in data:
> -    # catch Python 2 vs. 3 differences
> -    if isinstance(b, int):
> -        checksum +=3D b
> -    else:
> -        checksum +=3D ord(b)
> -checksum =3D (256 - checksum) % 256
> -
> -# Python 3 no longer allows chr(checksum)
> +    checksum =3D (checksum - b) & 255
> +
>   fout.write(struct.pack('B', checksum))
>  =20
>   fin.close()
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Also, applied to my python-next tree:
https://gitlab.com/philmd/qemu/commits/python-next


