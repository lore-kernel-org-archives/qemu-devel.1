Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71823C0044D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 17:40:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDF4B2077F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 17:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iMGELOrR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDF4B2077F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC5L7-0006Hn-9d
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 13:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33749)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jC5KB-0005P9-6Y
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:39:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jC5K9-0001fb-Vo
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:39:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36862
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jC5K9-0001ek-S2
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:39:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583948357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BcYsJu+SoG3YyrDsK088+O0VNg23O7uq9i1NKj3jViA=;
 b=iMGELOrRQSVxC9s9W10EH4HZAW+n6ArM0/CYbQGRrYg4yg8MmLhcxT1WBBg1lLff82O0jI
 5+jCmpbTN7EiaxQZU3bKQQuNSdjJY6jyPRSpb+4pOXJ+Gb0iHKgTiYVwKe71ohr/zseTuy
 xE9GypBTX0bU0qvazbZ+hol/7WMFE+w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-CMPx2etVMWSYidhIFSQ6QQ-1; Wed, 11 Mar 2020 13:39:15 -0400
X-MC-Unique: CMPx2etVMWSYidhIFSQ6QQ-1
Received: by mail-wr1-f71.google.com with SMTP id o9so1275118wrw.14
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 10:39:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HSh9Sv0bpZMJWv7PR1t3w0IRg3idxaiHXOzqeoUODzI=;
 b=Ub6djPt7xd841k3kFpu7Pf+mqHus0lticLYu9Kpw5i/hXHdqR51fyuN29KlZq7nxf6
 R5ITIiEdSV5v1/khW7yjKxJQZTdI+kKd23d+nnOHcQfXafRQXp6zcqbRmg4SMakJFM0G
 GbzAygp7n3EEZPWef1c9KfjVV8ZsaW0LZ4NBPSq+4kDm7gyPiekiAY/+dMljR37idiJR
 rnQDDw3BEDh4D7qf2LLwEIZBD0F6zb0ewS5t4dbl8H/MFv7JkbO3XETz2yPWjhHCypoe
 YpZYSG4g5IZH7uScs/yQUK2iCvuwwuVdnaAbcc9O6tjwNBYpOr9St86xloT51MBzyAhY
 D5JQ==
X-Gm-Message-State: ANhLgQ0qwFHLxg6NDpeIJ6RN3GO5jsKRcIZOcuvMlakQjqfbggPNzAve
 TL+iCpI+w8SoZ3Poy70fxkEcQVZzxExnA87mW1tTOFoTIcYWWOmJujyCQRPBmY/rdDnaAvFabm8
 OlzzoIjTfwRedu+8=
X-Received: by 2002:a7b:cb88:: with SMTP id m8mr4728830wmi.92.1583948353924;
 Wed, 11 Mar 2020 10:39:13 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vv0byq8irT9cF1aikl7nL5+jE3U+SxpVvZsMJqpZZsOB8rGFEtZoyFkwWR6/n+vb98UBqEUsw==
X-Received: by 2002:a7b:cb88:: with SMTP id m8mr4728810wmi.92.1583948353639;
 Wed, 11 Mar 2020 10:39:13 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4887:2313:c0bc:e3a8?
 ([2001:b07:6468:f312:4887:2313:c0bc:e3a8])
 by smtp.gmail.com with ESMTPSA id g7sm71820750wrq.21.2020.03.11.10.39.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Mar 2020 10:39:13 -0700 (PDT)
Subject: Re: [PATCH] build-sys: do not make qemu-ga link with pixman
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20200311160923.882474-1-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5c118a1b-74bf-87dd-c775-0bdd8f3c64c4@redhat.com>
Date: Wed, 11 Mar 2020 18:39:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200311160923.882474-1-marcandre.lureau@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/03/20 17:09, Marc-Andr=C3=A9 Lureau wrote:
> Since commit d52c454aadcdae74506f315ebf8b58bb79a05573 ("contrib: add
> vhost-user-gpu"), qemu-ga is linking with pixman.
>=20
> This is because the Make-based build-system use a global namespace for
> variables, and we rely on "main.o-libs" for different linking targets.
>=20
> Note: this kind of variable clashing is hard to fix or prevent
> currently.  meson should help, as declarations have a linear
> dependency and doesn't rely so much on variables and clever tricks.
>=20
> Note2: we have a lot of main.c (or other duplicated names!) in
> tree. Imho, it would be annoying and a bad workaroud to rename all
> those to avoid conflicts like I did here.
>=20
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1811670
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  contrib/vhost-user-gpu/{main.c =3D> vhost-user-gpu.c} | 0
>  contrib/vhost-user-gpu/Makefile.objs                | 6 +++---
>  2 files changed, 3 insertions(+), 3 deletions(-)
>  rename contrib/vhost-user-gpu/{main.c =3D> vhost-user-gpu.c} (100%)
>=20
> diff --git a/contrib/vhost-user-gpu/main.c b/contrib/vhost-user-gpu/vhost=
-user-gpu.c
> similarity index 100%
> rename from contrib/vhost-user-gpu/main.c
> rename to contrib/vhost-user-gpu/vhost-user-gpu.c
> diff --git a/contrib/vhost-user-gpu/Makefile.objs b/contrib/vhost-user-gp=
u/Makefile.objs
> index 6170c919e4..09296091be 100644
> --- a/contrib/vhost-user-gpu/Makefile.objs
> +++ b/contrib/vhost-user-gpu/Makefile.objs
> @@ -1,7 +1,7 @@
> -vhost-user-gpu-obj-y =3D main.o virgl.o vugbm.o
> +vhost-user-gpu-obj-y =3D vhost-user-gpu.o virgl.o vugbm.o
> =20
> -main.o-cflags :=3D $(PIXMAN_CFLAGS) $(GBM_CFLAGS)
> -main.o-libs :=3D $(PIXMAN_LIBS)
> +vhost-user-gpu.o-cflags :=3D $(PIXMAN_CFLAGS) $(GBM_CFLAGS)
> +vhost-user-gpu.o-libs :=3D $(PIXMAN_LIBS)
> =20
>  virgl.o-cflags :=3D $(VIRGL_CFLAGS) $(GBM_CFLAGS)
>  virgl.o-libs :=3D $(VIRGL_LIBS)
>=20

Queued, thanks.

Paolo


