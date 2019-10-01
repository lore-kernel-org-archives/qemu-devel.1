Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C967FECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 13:54:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 976ED20815
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 13:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 976ED20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFIc6-0007BQ-MD
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 09:54:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60383)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iFIVl-00010T-Ix
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:48:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iFIVk-0003tB-5V
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:48:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35633)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iFIVk-0003sF-08
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:48:16 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1B3E32F366A
 for <qemu-devel@nongnu.org>; Tue,  1 Oct 2019 13:48:14 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id k9so1469965wmb.0
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 06:48:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bD+TnKwvCVSI6M1P1XwRT+OotgQsScs2BkiNGisGaSM=;
 b=T9Fwvg9B/VTqNIgv9+yZkZy8eWCvkxsdrkGZGjqqE1mxHyHUuWzfc6LGSZKJsEZeDl
 ZkICEFLjpeiZK9Uq79wfchVZjPFvLpxeqQQo7pkKr8o6vSrvxB6B0q5KcnUnNLSna+zE
 nzbbqljaavnHCeBGnQ7IpJbC6qtFpMqx9QG18wVpyg1GK24XObgSYd8Tch+DvGySJhwe
 SU/o3G7qtKQceqAgPrx/98OI6HLLB4pMLVaXjnB+NlhLXU91X4wp7AJocQNWgkBx+u9G
 7cr5rppr3N6yWUHJBxJZkFOLzXRBVZEJwYYgLF8pcJpYXjFAYuA5RbRq+/YOymw+M17j
 ycAA==
X-Gm-Message-State: APjAAAVZuLk1Ixo6rZ0rYNhED77id9ZuBHBdRZuoB4inHJFXcsYvSVa/
 Mj2PC6ijjZHvXMVM3DnetQHlJ5TJ84Ii5N7hDVGdzA6q86Ck7+OH28MPrRmbSgRZeHwp4vqNkD6
 ojQWWa/9ZVsGoyk8=
X-Received: by 2002:a1c:b745:: with SMTP id h66mr3723881wmf.70.1569937692853; 
 Tue, 01 Oct 2019 06:48:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy9Z7qjC5Q/19S7tUqTfUB9tLpwBR/+4grVTi8BlHwJPRKINDjoeeVckIfWB6Uq9w9cjOAS2A==
X-Received: by 2002:a1c:b745:: with SMTP id h66mr3723865wmf.70.1569937692666; 
 Tue, 01 Oct 2019 06:48:12 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id q22sm2972345wmj.31.2019.10.01.06.48.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Oct 2019 06:48:12 -0700 (PDT)
Subject: Re: [PATCH 2/3] tests: skip serial test on windows
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20191001132609.23184-1-marcandre.lureau@redhat.com>
 <20191001132609.23184-3-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2de63324-7f31-2268-9cee-808c960e7ecc@redhat.com>
Date: Tue, 1 Oct 2019 15:48:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191001132609.23184-3-marcandre.lureau@redhat.com>
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
> Serial test is currently hard-coded to /dev/null.
>=20
> On Windows, serial chardev expect a COM: device, which may not be
> availble.

"available"

>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   tests/test-char.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/test-char.c b/tests/test-char.c
> index d62de1b088..45e42af290 100644
> --- a/tests/test-char.c
> +++ b/tests/test-char.c
> @@ -1103,7 +1103,7 @@ static void char_socket_server_two_clients_test(g=
constpointer opaque)
>   }
>  =20
>  =20
> -#ifdef HAVE_CHARDEV_SERIAL
> +#if defined(HAVE_CHARDEV_SERIAL) && !defined(WIN32)
>   static void char_serial_test(void)
>   {
>       QemuOpts *opts;
> @@ -1460,7 +1460,7 @@ int main(int argc, char **argv)
>   #endif
>  =20
>       g_test_add_func("/char/udp", char_udp_test);
> -#ifdef HAVE_CHARDEV_SERIAL
> +#if defined(HAVE_CHARDEV_SERIAL) && !defined(WIN32)
>       g_test_add_func("/char/serial", char_serial_test);
>   #endif
>       g_test_add_func("/char/hotswap", char_hotswap_test);
>=20

