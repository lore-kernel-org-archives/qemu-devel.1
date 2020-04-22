Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E91FC5518C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 10:25:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF9E62076B
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 10:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Szwxu1Fz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF9E62076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRCZY-0007Ph-VN
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 06:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53962)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRCYK-0006w6-L7
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 06:24:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRCYH-00046c-Uk
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 06:24:22 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58768
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRCYF-0003Vj-AI
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 06:24:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587551056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A+Wogbxk/VVrJOpIcLw2lf+my99B1s6Taagpl40mLH0=;
 b=Szwxu1FzVHR2PiiL3rtR/j/u4Namak6RxbXp+t2cye7GEZJMzlG0J0eJQok7MKhi93gG+O
 XomeoZBIFNoPDzf2NFzwWtLhChp1zIcowNZObpEQZVtuCaG7U5FDU4tJWVwxchSJQyg1Me
 Rp4N9O8kI5EehrucfFjFDgobt/JEEU4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-NoOySuE2P22udfIhG8sY9A-1; Wed, 22 Apr 2020 06:24:14 -0400
X-MC-Unique: NoOySuE2P22udfIhG8sY9A-1
Received: by mail-wr1-f72.google.com with SMTP id g7so808270wrw.18
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 03:24:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fzOcVI63pForZzMnv1X9WWlF9VyAZA6u7GXEergTrb0=;
 b=LIpcScxMpXhHHo/n1dEB/Y8AK12Za0A8lsUUGuGNkipWh9uiRbvu25KJ8Bi+MrznZs
 zg5HmrEPwqkGb5YrCbrV91WQdIUF60hLOPNchvXVGv/2BjnHAVwbnIG3eFiidKkG/php
 c/gW8sQ/u22HEjWnbnDeK76LKKaW5lXv22639tEY2WYf+eUeIxaVKTKvqWlrnEcN3fnj
 FpNKU1+KhO/h2RCZfidH+hhFtHLyaoztJFsYCkR2ajqwhzVEnfreqpdHZk41+gCAE+Oi
 39QMGm3ZmHJzWAIrYcNPVhxbINimoazIMZj/28gSJqXV9qoXaXkAoVofxRTYDv9NK7OM
 Vk0Q==
X-Gm-Message-State: AGi0PuZRD01y8Nnl9wo465wgfu3Lia4fk3EWNWm5NbEjgaGrh3SJ3JPx
 NUyBQbnvJTYEhJ53n+P8FZjyPmvBw8doMuDAJRiBPGyRjRO6J/ZQC6sOSONe+6RNr89Nho9f7pw
 6fUe3JYOirXvEmqo=
X-Received: by 2002:adf:fd0a:: with SMTP id e10mr28339082wrr.160.1587551053514; 
 Wed, 22 Apr 2020 03:24:13 -0700 (PDT)
X-Google-Smtp-Source: APiQypJZAl6nJONSI+ByWFmWF8DLMpIoX8wPwbeFBceOPuwqInemrFTxE3Xa5ZnfuMS3vDfVotwUVw==
X-Received: by 2002:adf:fd0a:: with SMTP id e10mr28339057wrr.160.1587551053236; 
 Wed, 22 Apr 2020 03:24:13 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id o3sm1460264wru.68.2020.04.22.03.24.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2020 03:24:12 -0700 (PDT)
Subject: Re: [PATCH 3/5] ramfb: don't update RAMFBState on errors
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200422100211.30614-1-kraxel@redhat.com>
 <20200422100211.30614-4-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <dc32383f-af2b-d052-b9fb-fa7ef1622424@redhat.com>
Date: Wed, 22 Apr 2020 12:24:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200422100211.30614-4-kraxel@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 02:57:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, lersek@redhat.com,
 hqm03ster@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/22/20 12:02 PM, Gerd Hoffmann wrote:
> Store width & height & surface in local variables.  Update RAMFBState
> with the new values only in case the ramfb_create_display_surface() call
> succeeds.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   hw/display/ramfb.c | 25 ++++++++++++++++---------
>   1 file changed, 16 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
> index 9d41c2ad2868..fbe959147dc9 100644
> --- a/hw/display/ramfb.c
> +++ b/hw/display/ramfb.c
> @@ -71,20 +71,27 @@ static DisplaySurface *ramfb_create_display_surface(i=
nt width, int height,
>   static void ramfb_fw_cfg_write(void *dev, off_t offset, size_t len)
>   {
>       RAMFBState *s =3D dev;
> -    uint32_t fourcc, format;
> +    DisplaySurface *surface;
> +    uint32_t fourcc, format, width, height;
>       hwaddr stride, addr;
>  =20
> -    s->width  =3D be32_to_cpu(s->cfg.width);
> -    s->height =3D be32_to_cpu(s->cfg.height);
> -    stride    =3D be32_to_cpu(s->cfg.stride);
> -    fourcc    =3D be32_to_cpu(s->cfg.fourcc);
> -    addr      =3D be64_to_cpu(s->cfg.addr);
> -    format    =3D qemu_drm_format_to_pixman(fourcc);
> +    width  =3D be32_to_cpu(s->cfg.width);
> +    height =3D be32_to_cpu(s->cfg.height);
> +    stride =3D be32_to_cpu(s->cfg.stride);
> +    fourcc =3D be32_to_cpu(s->cfg.fourcc);
> +    addr   =3D be64_to_cpu(s->cfg.addr);
> +    format =3D qemu_drm_format_to_pixman(fourcc);
>  =20
>       fprintf(stderr, "%s: %dx%d @ 0x%" PRIx64 "\n", __func__,
>               s->width, s->height, addr);
> -    s->ds =3D ramfb_create_display_surface(s->width, s->height,
> -                                         format, stride, addr);
> +    surface =3D ramfb_create_display_surface(width, height,
> +                                           format, stride, addr);
> +    if (!surface)
> +        return;
> +
> +    s->width =3D width;
> +    s->height =3D height;
> +    s->ds =3D surface;
>   }
>  =20
>   void ramfb_display_update(QemuConsole *con, RAMFBState *s)
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


