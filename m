Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84374C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 14:32:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F0F02071A
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 14:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZdzwUmiz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F0F02071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJHwC-0003t9-DJ
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 10:32:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51331)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jJHvD-0002t0-JW
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:31:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jJHvC-0007Lr-9J
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:31:19 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37277
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jJHvC-0007Lf-5Y
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:31:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585665077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fgY48dg01KG7Pafy5ec+BoHRH1Y0sg8r7NO9nhiwmV8=;
 b=ZdzwUmizCcUWKFNR++yPHYMhaNSra+Z1X8VdA4EWF1U3DT9991/iOTy4kul3oFosLQmF8w
 4+wcH98dDmMhTPHn6rZ6vd67+mSvRwI4LFw3srZDGHhpESneS7OpgRPwRQRhY4gGtHAkFd
 sqCumuZZyFqg8owzWEsC8JSxhdVgicE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220--95dNBXMMFybGXjrAvH5ig-1; Tue, 31 Mar 2020 10:31:15 -0400
X-MC-Unique: -95dNBXMMFybGXjrAvH5ig-1
Received: by mail-ed1-f70.google.com with SMTP id n15so14582551edq.6
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 07:31:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/eofzI4Ve9ebR4BFWOwfxGY/r8UvDa0Q8l1G7zoC/MU=;
 b=a+2rg3scXv9k27LUf2SPjBavkE3s1GpyDzN3nZj4fRsHGYF9Y4AOQJgFL1kREpXr3N
 kAd+yYE1/ni0rvMe+dNTTi/9ZE90AhcfazpDKeCybUufOPac8tS1iO8LdEjGJn67ARPh
 oYp4QOkocNnRot3cv44MvocWlHHBwNojZ6YmThbAImlzs45yyUDWhjmD274+S6WT+7Mi
 KT/RcOuCZQ8AiYQV4VLwnnkyE/Kmx6mJgFscppK3IoPPa4ygMDrN+J3rTNuYvtZIO0bC
 cSMhqRgpuOIT5uW8F24fADwUXGB3wEaF+APiajXVpbVK9B9CyJUx5/LL78K25GogxrWi
 UFGg==
X-Gm-Message-State: ANhLgQ3YfhLn3SjRRWv/+RRB9XtbMdyXdivJsSgTGFpUhIpppcJuNVR1
 pRWOWwee/G+2SfJVFkzcBSghnSf6QZ0md74ZEIJJhUqxcAsyAeWZ4QHNn7jAtsHL5oIt3fNFl6S
 QeXSxjss5slAhI0A=
X-Received: by 2002:a50:fa88:: with SMTP id w8mr15446300edr.183.1585665074172; 
 Tue, 31 Mar 2020 07:31:14 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtTJBP8Cuwzh4mc/d0DGX3+sH3xGpp3fgo0+3v6f0eeHdLPpN/R+rSKNmQAZVfJDzuFwa9KJg==
X-Received: by 2002:a50:fa88:: with SMTP id w8mr15446285edr.183.1585665073984; 
 Tue, 31 Mar 2020 07:31:13 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id b11sm2314991edj.20.2020.03.31.07.31.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2020 07:31:13 -0700 (PDT)
Subject: Re: [PATCH-for-5.0] ui/input-linux: Do not ignore ioctl() return value
To: qemu-devel@nongnu.org
References: <20200322161219.17757-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7fdbae5b-3692-a59d-e9ad-eef05869ad3c@redhat.com>
Date: Tue, 31 Mar 2020 16:31:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200322161219.17757-1-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/22/20 5:12 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Fix warnings reported by Clang static code analyzer:
>=20
>      CC      ui/input-linux.o
>        ui/input-linux.c:343:9: warning: Value stored to 'rc' is never rea=
d
>            rc =3D ioctl(il->fd, EVIOCGBIT(EV_REL, sizeof(relmap)), &relma=
p);
>            ^    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>        ui/input-linux.c:351:9: warning: Value stored to 'rc' is never rea=
d
>            rc =3D ioctl(il->fd, EVIOCGBIT(EV_ABS, sizeof(absmap)), &absma=
p);
>            ^    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>        ui/input-linux.c:354:13: warning: Value stored to 'rc' is never re=
ad
>                rc =3D ioctl(il->fd, EVIOCGABS(ABS_X), &absinfo);
>                ^    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>        ui/input-linux.c:357:13: warning: Value stored to 'rc' is never re=
ad
>                rc =3D ioctl(il->fd, EVIOCGABS(ABS_Y), &absinfo);
>                ^    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>        ui/input-linux.c:365:9: warning: Value stored to 'rc' is never rea=
d
>            rc =3D ioctl(il->fd, EVIOCGBIT(EV_KEY, sizeof(keymap)), keymap=
);
>            ^    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>        ui/input-linux.c:366:9: warning: Value stored to 'rc' is never rea=
d
>            rc =3D ioctl(il->fd, EVIOCGKEY(sizeof(keystate)), keystate);
>            ^    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> Reported-by: Clang Static Analyzer
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   ui/input-linux.c | 29 +++++++++++++++++++++++++++--
>   1 file changed, 27 insertions(+), 2 deletions(-)
>=20
> diff --git a/ui/input-linux.c b/ui/input-linux.c
> index a7b280b25b..ef37b14d6f 100644
> --- a/ui/input-linux.c
> +++ b/ui/input-linux.c
> @@ -334,13 +334,15 @@ static void input_linux_complete(UserCreatable *uc,=
 Error **errp)
>  =20
>       rc =3D ioctl(il->fd, EVIOCGBIT(0, sizeof(evtmap)), &evtmap);
>       if (rc < 0) {
> -        error_setg(errp, "%s: failed to read event bits", il->evdev);
> -        goto err_close;
> +        goto err_read_event_bits;
>       }
>  =20
>       if (evtmap & (1 << EV_REL)) {
>           relmap =3D 0;
>           rc =3D ioctl(il->fd, EVIOCGBIT(EV_REL, sizeof(relmap)), &relmap=
);
> +        if (rc < 0) {
> +            goto err_read_event_bits;
> +        }
>           if (relmap & (1 << REL_X)) {
>               il->has_rel_x =3D true;
>           }
> @@ -349,12 +351,25 @@ static void input_linux_complete(UserCreatable *uc,=
 Error **errp)
>       if (evtmap & (1 << EV_ABS)) {
>           absmap =3D 0;
>           rc =3D ioctl(il->fd, EVIOCGBIT(EV_ABS, sizeof(absmap)), &absmap=
);
> +        if (rc < 0) {
> +            goto err_read_event_bits;
> +        }
>           if (absmap & (1 << ABS_X)) {
>               il->has_abs_x =3D true;
>               rc =3D ioctl(il->fd, EVIOCGABS(ABS_X), &absinfo);
> +            if (rc < 0) {
> +                error_setg(errp, "%s: failed to get get absolute X value=
",
> +                           il->evdev);
> +                goto err_close;
> +            }
>               il->abs_x_min =3D absinfo.minimum;
>               il->abs_x_max =3D absinfo.maximum;
>               rc =3D ioctl(il->fd, EVIOCGABS(ABS_Y), &absinfo);
> +            if (rc < 0) {
> +                error_setg(errp, "%s: failed to get get absolute Y value=
",
> +                           il->evdev);
> +                goto err_close;
> +            }
>               il->abs_y_min =3D absinfo.minimum;
>               il->abs_y_max =3D absinfo.maximum;
>           }
> @@ -363,7 +378,14 @@ static void input_linux_complete(UserCreatable *uc, =
Error **errp)
>       if (evtmap & (1 << EV_KEY)) {
>           memset(keymap, 0, sizeof(keymap));
>           rc =3D ioctl(il->fd, EVIOCGBIT(EV_KEY, sizeof(keymap)), keymap)=
;
> +        if (rc < 0) {
> +            goto err_read_event_bits;
> +        }
>           rc =3D ioctl(il->fd, EVIOCGKEY(sizeof(keystate)), keystate);
> +        if (rc < 0) {
> +            error_setg(errp, "%s: failed to get global key state", il->e=
vdev);
> +            goto err_close;
> +        }
>           for (i =3D 0; i < KEY_CNT; i++) {
>               if (keymap[i / 8] & (1 << (i % 8))) {
>                   if (linux_is_button(i)) {
> @@ -390,6 +412,9 @@ static void input_linux_complete(UserCreatable *uc, E=
rror **errp)
>       il->initialized =3D true;
>       return;
>  =20
> +err_read_event_bits:
> +    error_setg(errp, "%s: failed to read event bits", il->evdev);
> +
>   err_close:
>       close(il->fd);
>       return;
>=20

I see this patch as been merged as commit 112c37a6a6e4, thanks!


