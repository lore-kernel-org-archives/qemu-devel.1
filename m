Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E142EC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 21:41:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB825206F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 21:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dz1KY6qz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB825206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwv5i-0008Vv-TO
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 16:41:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33922)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iwuvw-0000tD-Q0
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:31:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iwuvu-0001x0-Pi
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:31:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58207
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iwuvu-0001tp-Ks
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:31:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580333494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Db73u84YwdHYyRgxLCI/quwLfFlG3vr6SrzoAtdp9A=;
 b=Dz1KY6qzn1uvHxK/fSCAGH652z1UFkoGd6dfL7js4AwSK6IApb/Vlicn9qy2PHup+FiYPQ
 ZTvH1vhqHXAwlJEQcbEfg4JKgGbhz7YHcFpaQc5AxDrMGEMfn5lmZL5J+OTYYm/7P+FCqM
 BevJkHtuAK981RGB3MT5fS83ln1E7P4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-Nm5Cw2FuNGOI_Nt-RZ4o9A-1; Wed, 29 Jan 2020 16:31:31 -0500
Received: by mail-wm1-f70.google.com with SMTP id a10so462254wme.9
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 13:31:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1S3x2POV8ff/p3FhhBUytk3RBVAkQ493hPXh/1g/5IE=;
 b=tAhOM7QXEQuU8hwWiJ73VTM7sUZ/ccZEmgNGprLZTEpnU+z6gxR5Xp0AgXHtgEYFFt
 tB4FajXpTpZM21CNqYmogsGO5R/6h31HBlJGn/bPZ6fFxAHnR323c/E/efRPGq6oLPo1
 32ic7QiqPRoMb+PhxTh84evDPT0omDtJ8LzhSMjoIGd16ArpFgoswsmjGtqwFuSuzHDm
 BKG6Q+eVzzlnVkFmyGtcypjz7Xr/83ijsqPhEgNh/ta0974bHwyPz4IJVnz0YgsXH+cM
 PJQ4pCZGr83dfaFaXEWifbpgIxv4S/GRHOGk2icakXuSXavV0PDdX5HUBgzDOkyoWGEu
 Htow==
X-Gm-Message-State: APjAAAVupWEu+TCZoAaRj7I6mOfQwwhRPq80dVLnBvgs0/PpwQkEKxT0
 sRndmUJ6Sk19tLIDstlgUf9KKW7noUR2hidJVUaZTkkPHjYU/jFDvQ+cNjC9HoPvQYMVuiwEh4p
 bzBXEQG//EyUJE94=
X-Received: by 2002:adf:f052:: with SMTP id t18mr872214wro.192.1580333490530; 
 Wed, 29 Jan 2020 13:31:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqyndojNaxKQ9tFRFENK/8baspiysMMPgm96bOsjYQgD04lL1tdEzRxg7Gv8RNuBQ78camV4WA==
X-Received: by 2002:adf:f052:: with SMTP id t18mr872195wro.192.1580333490261; 
 Wed, 29 Jan 2020 13:31:30 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id g79sm3608491wme.17.2020.01.29.13.31.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jan 2020 13:31:29 -0800 (PST)
Subject: Re: [PATCH v2 02/29] accel/accel: Make TYPE_ACCEL abstract
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20200129212345.20547-1-philmd@redhat.com>
 <20200129212345.20547-3-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <72530f19-889d-6ba5-3465-b3a5c1c8080e@redhat.com>
Date: Wed, 29 Jan 2020 22:31:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200129212345.20547-3-philmd@redhat.com>
Content-Language: en-US
X-MC-Unique: Nm5Cw2FuNGOI_Nt-RZ4o9A-1
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
Cc: Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since this file isn't covered in MAINTAINERS, manually Cc'ing Paolo.

On 1/29/20 10:23 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> There is no generic acceleration, we have to use specific
> implementations. Make the base class abstract.
>=20
> Fixes: b14a0b7469f
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   accel/accel.c | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/accel/accel.c b/accel/accel.c
> index cb555e3b06..a0169b4e69 100644
> --- a/accel/accel.c
> +++ b/accel/accel.c
> @@ -33,6 +33,7 @@
>   static const TypeInfo accel_type =3D {
>       .name =3D TYPE_ACCEL,
>       .parent =3D TYPE_OBJECT,
> +    .abstract =3D true,
>       .class_size =3D sizeof(AccelClass),
>       .instance_size =3D sizeof(AccelState),
>   };
>=20


