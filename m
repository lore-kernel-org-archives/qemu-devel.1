Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232C4C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 13:57:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9F4321855
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 13:57:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9F4321855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFIf8-0002CW-02
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 09:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33555)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iFIdp-0001LN-Sr
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:56:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iFIdo-0002GC-Kt
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:56:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49288)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iFIdo-0002FD-CU
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:56:36 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8161EC04B302
 for <qemu-devel@nongnu.org>; Tue,  1 Oct 2019 13:56:35 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id t11so6026152wro.10
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 06:56:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=K11xyvxmRyqi82uBzE0RFiXCmoELuqSlU8VBgESVRUE=;
 b=hPZ1kgPZ9dBkJlaTkakp59bdCWMg3MTCIi1IqD2MABbhDAEeERB6QNSMehbwqYMbvK
 gp5dkXd5JVKl7V9RDA0ojR8Zpaf76PFcYwT5AK94xlGodoJnYb/Mi4QPNooIizIypjyM
 5Ve7A4hJUYOdFey61/GvJn0q4Q67or1rIgtBV7Ibr4or9i8U6t0CFJa9eCm6ta87i1t4
 Mvl7ZOMhyc9X0YwpXZye3TUR5f/45zXG1kvLX6fl4sF6H/r2wlgzK/9hrEBFNsNdMeaj
 sK7eZUMuxjBirAcFpao0PUyZmMV15ve8m2H7wOadMNXsZuNtQdOcLnbw49wdtwO2V3ls
 w6Qw==
X-Gm-Message-State: APjAAAWdbcJ09ToaT/2jgrA1Pn63qtFsJMFYXfRISMhc4tPzOVp8H8T1
 jCorZCLWadI3E3k3adQRQwudXPAf6qihmQmAlIhX3nL9JDuqjGIU9RlyOIYXXFWZuWhe0bAbhN+
 p3S2fl5QIO8802Bs=
X-Received: by 2002:a1c:4d4:: with SMTP id 203mr4172455wme.150.1569938194320; 
 Tue, 01 Oct 2019 06:56:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqytdQ/pBu4MkxYdC3kBfjiIcBxKkv/vaZZGMnsKTf7YDLekXIy52inGRxrMh6jT98480iPDQw==
X-Received: by 2002:a1c:4d4:: with SMTP id 203mr4172443wme.150.1569938194143; 
 Tue, 01 Oct 2019 06:56:34 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id a71sm3292369wme.11.2019.10.01.06.56.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Oct 2019 06:56:33 -0700 (PDT)
Subject: Re: [PATCH 1/3] util: WSAEWOULDBLOCK on connect should map to
 EINPROGRESS
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20191001132609.23184-1-marcandre.lureau@redhat.com>
 <20191001132609.23184-2-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6c3dc15d-565f-03fe-5eca-154ed1193807@redhat.com>
Date: Tue, 1 Oct 2019 15:56:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191001132609.23184-2-marcandre.lureau@redhat.com>
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
Cc: pbonzini@redhat.com, berrange@redhat.com, sw@weilnetz.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/1/19 3:26 PM, Marc-Andr=C3=A9 Lureau wrote:
> In general, WSAEWOULDBLOCK can be mapped to EAGAIN as done by
> socket_error() (or EWOULDBLOCK). But for connect() with non-blocking
> sockets, it actually means the operation is in progress:
>=20
> https://docs.microsoft.com/en-us/windows/win32/api/winsock2/nf-winsock2=
-connect
> "The socket is marked as nonblocking and the connection cannot be compl=
eted immediately."
>=20
> (this is also the behaviour implemented by GLib GSocket)
>=20
> This fixes socket_can_bind_connect() test on win32.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   util/oslib-win32.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/util/oslib-win32.c b/util/oslib-win32.c
> index c62cd4328c..886e400d6a 100644
> --- a/util/oslib-win32.c
> +++ b/util/oslib-win32.c
> @@ -585,7 +585,11 @@ int qemu_connect_wrap(int sockfd, const struct soc=
kaddr *addr,
>       int ret;
>       ret =3D connect(sockfd, addr, addrlen);
>       if (ret < 0) {
> -        errno =3D socket_error();
> +        if (WSAGetLastError() =3D=3D WSAEWOULDBLOCK) {
> +            errno =3D EINPROGRESS;
> +        } else {
> +            errno =3D socket_error();
> +        }
>       }
>       return ret;
>   }
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

