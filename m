Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CE4C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 14:04:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE02A206A1
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 14:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE02A206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIZ3I-0004Ll-Sx
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 10:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47857)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iIZ20-00033t-Mv
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 10:03:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iIZ1z-0006Vi-FN
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 10:03:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37702)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iIZ1z-0006Up-7Z
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 10:03:03 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EB6D02D0FC7
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 14:03:00 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id o188so2665710wmo.5
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 07:03:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pza58L4QEGWH2MjS2ypNZgLc4mVadvNgZ4IU8EEGPig=;
 b=tJKWEbueeaY3vUA0WRbZZiN0XtUl/VWtxdvrDLyoSFLQBnDqggh+m0OpivNFcUob8t
 iZRuSwXj/DD2hTXano3xVJmHLlwTkjmkrTjT13qU2L8oJ1bjvNQI+oI4X1yDuFJuyfBy
 kIPCEOPiG7ukJuJea1JjHq+bHilRsGFlk9eCtKGaf+U/dXvmr18nIXYshQJ7Gl3Ef0yu
 q7K3opd9/dyG0MP28Iy/c4KA/TeymHZQ02Cm9LcliJhQodtl+xcKe4cBpxGl4SuB9Ex7
 5zdGcU+c4oCzEFY8aBfRt8L8PquphrolNIiQ4FbvAQobiHNut4o35GBy8qjM633fVGgJ
 Gsqw==
X-Gm-Message-State: APjAAAWM2GtVu/86YBVuusW1XJLrhK8wmMKkXJaMVYe77WCdwEUMkG3z
 240Yv9SH4TsOS+QuF2Xh0v30NSUK7a+caYVd6Q+Z/JBLHFjIcOcGCzbNQqzmpkP4O1/hxDKTHEV
 1NgfzpJLkZMKsstI=
X-Received: by 2002:adf:94c5:: with SMTP id 63mr9275540wrr.199.1570716179742; 
 Thu, 10 Oct 2019 07:02:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw6BCwhWAdMk2ZanqsbD1GGw+CI1PEYjG0lMkKf40KA7bQZ9552+Jrov3ZNDQUGPoCoczJubw==
X-Received: by 2002:adf:94c5:: with SMTP id 63mr9275513wrr.199.1570716179521; 
 Thu, 10 Oct 2019 07:02:59 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id t123sm9114500wma.40.2019.10.10.07.02.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Oct 2019 07:02:58 -0700 (PDT)
Subject: Re: [PATCH] trace: avoid "is" with a literal Python 3.8 warnings
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20191010122154.10553-1-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <98d5300a-537e-ff99-f79f-a177f4fd523b@redhat.com>
Date: Thu, 10 Oct 2019 16:02:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191010122154.10553-1-stefanha@redhat.com>
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
Cc: =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/10/19 2:21 PM, Stefan Hajnoczi wrote:
> The following statement produces a SyntaxWarning with Python 3.8:
>=20
>    if len(format) is 0:
>    scripts/tracetool/__init__.py:459: SyntaxWarning: "is" with a litera=
l. Did you mean "=3D=3D"?
>=20
> Use the conventional len(x) =3D=3D 0 syntax instead.

Ah this is a new change from 3.8...
https://docs.python.org/3.9/whatsnew/3.8.html

 From https://bugs.python.org/issue34850

> Reported-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   scripts/tracetool/__init__.py | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__=
.py
> index 04279fa62e..44c118bc2a 100644
> --- a/scripts/tracetool/__init__.py
> +++ b/scripts/tracetool/__init__.py
> @@ -456,12 +456,12 @@ def generate(events, group, format, backends,
>       import tracetool
>  =20
>       format =3D str(format)
> -    if len(format) is 0:
> +    if len(format) =3D=3D 0:
>           raise TracetoolError("format not set")
>       if not tracetool.format.exists(format):
>           raise TracetoolError("unknown format: %s" % format)
>  =20
> -    if len(backends) is 0:
> +    if len(backends) =3D=3D 0:
>           raise TracetoolError("no backends specified")
>       for backend in backends:
>           if not tracetool.backend.exists(backend):
>=20

