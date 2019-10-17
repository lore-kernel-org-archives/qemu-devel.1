Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771F9FA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 09:56:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CF2B2089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 09:56:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CF2B2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL2WZ-0000Fy-DO
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 05:56:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54841)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iL2Vh-0007kQ-8W
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 05:55:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iL2Vg-0008BQ-50
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 05:55:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50008)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iL2Vf-0008Ab-Vl
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 05:55:56 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 224DC2D6A0D
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 09:55:55 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id o8so884111wmc.2
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 02:55:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=po95gEQUT9586jzthi0ftrXVak07893o1boEFXjiqzE=;
 b=KoelWJ7PKf7sVhKOJq2lbBWiFtRfT5LMkD33uzBBFYyOzbeV50vFWTmHXhVlHRylxH
 W1dNAMQ1ylirjmNpGkGxi8uq0w2Ni+YyGtBQgjS0PjxLStCIJ/c833H6NdhC6up5x692
 nnlrVbvxxtg47wb+P/mjoYPg+kg64XI0+ivLCEo4R9dzyQxcEtMAh92hneeBcDbiC/BH
 AZzee+cIOzAtHoCkR5VIoo8wPhZaZlzuqHG36C9DmZ5TmvW60T3F/egaY9Qgosl3M0ml
 wWA6SU6wvMXZNOwgg1/KljatK/VpC6KAepQYH+pD91iIxBStGbIjoi1njv/ur7KohKF6
 vyrA==
X-Gm-Message-State: APjAAAVWQ1+zlQDGYsTzgwKV6opJo7h3sJEZvTzRdgsER1D0k30podW7
 T98l4hrXHP/xm4lZ/damG6x7GVr/YFt9sJuJJTtmtc1JQZcK04vVutnLY5Biuo7tM6iFDh1e2B+
 DlPrqZkUUkBDGl6o=
X-Received: by 2002:a5d:6506:: with SMTP id x6mr2191782wru.366.1571306153902; 
 Thu, 17 Oct 2019 02:55:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyrZwv7mq5zh6Y/QcR78vcM6bnq96blAKdQ9DOeanCD6WiX6ZZ7DfyMKqj7OLmt/C1PWpeEiA==
X-Received: by 2002:a5d:6506:: with SMTP id x6mr2191770wru.366.1571306153744; 
 Thu, 17 Oct 2019 02:55:53 -0700 (PDT)
Received: from [192.168.1.36] (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id y11sm1566237wrp.44.2019.10.17.02.55.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2019 02:55:53 -0700 (PDT)
Subject: Re: [PATCH 01/10] image-fuzzer: Open image files in binary mode
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20191016192430.25098-1-ehabkost@redhat.com>
 <20191016192430.25098-2-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b76b52af-c1b7-273e-cfdf-2d061ee37de2@redhat.com>
Date: Thu, 17 Oct 2019 11:55:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191016192430.25098-2-ehabkost@redhat.com>
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
Cc: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/16/19 9:24 PM, Eduardo Habkost wrote:
> This probably never caused problems because on Linux there's no
> actual newline conversion happening, but on Python 3 the
> binary/text distinction is stronger and we must explicitly open
> the image file in binary mode.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>   tests/image-fuzzer/qcow2/layout.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/image-fuzzer/qcow2/layout.py b/tests/image-fuzzer/qc=
ow2/layout.py
> index 675877da96..c57418fa15 100644
> --- a/tests/image-fuzzer/qcow2/layout.py
> +++ b/tests/image-fuzzer/qcow2/layout.py
> @@ -503,7 +503,7 @@ class Image(object):
>  =20
>       def write(self, filename):
>           """Write an entire image to the file."""
> -        image_file =3D open(filename, 'w')
> +        image_file =3D open(filename, 'wb')
>           for field in self:
>               image_file.seek(field.offset)
>               image_file.write(struct.pack(field.fmt, field.value))
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

