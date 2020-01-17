Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AC5C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 07:44:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 247C120728
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 07:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eyfpENoF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 247C120728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isMJL-0005Hz-99
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 02:44:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33297)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1isMIi-0004tE-Pc
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 02:44:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1isMIg-0005GW-6h
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 02:44:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60362
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1isMIg-0005Fw-2u
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 02:44:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579247053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e/HmA3SefVHUh7JmnFjYDZ3fzyjMTjsb9PKSBXqjml8=;
 b=eyfpENoFkCtesSh9rYxfTSVg46iYfZ++uBDxgWuLg6SzM3CPMgHcZzpRGtPXTDV6VGgAvA
 FYtvk3HSfUguk942XWFeuQVY69jlH/evAW86w3HPV1PIKpBme6rgEIyZfVHM2WyrFoSRFg
 T9t+r8qneavZ3SG9Eq5eYtXKH15nvr0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-f8pF2WFROjqs-zdI92FMXg-1; Fri, 17 Jan 2020 02:44:09 -0500
Received: by mail-wr1-f70.google.com with SMTP id f15so10305198wrr.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 23:44:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BaQw8QBrwD0sf6D087e6fT9PrJms/hMHlTVeKpKQhLs=;
 b=sQzwrZuDsbmfLA3j5pK3KQIbFL5YEDn9qPsf81ShyuX1q8PkirKmSX0RGUaadEndVm
 3MfYyHG1U8Zpk+5y4FKgKnjKKb8y+DPG9G0yQB9xwPZVfSYlZWUmP5IEcSh+pEZdLKdM
 MtpwL7wQMs+GMSmOI659R5XEB6zaOrWDkOx4g3cOCpjsr/65RfOLxTvE3aaSt/EDjFiw
 yiysuT1LEAYeQsp/HEWV8dcy54gM3+JgS9aXACxtbHnh/J/dFn0+0J4AnI5WOkqp1556
 b4T7YzSu9iQJs1Eb3mrjZIEqdiimXRdLr5PnXk6PXjDkw/uxoG6jzb72/P1YUrkDqT/6
 6T/A==
X-Gm-Message-State: APjAAAWdT8p9czbsoEdQUxdY+eB56cJspX4EV1X08vR6njAdZkn40uz0
 JiKW8gx01im0t/xhD1Urwwkim2eUb0XBYspoP6uzsxJ3hwuIAPRVP2ItuDJRI/Ruyps2zEe0QUU
 7M/kLaEr/+daSwbw=
X-Received: by 2002:a05:600c:2254:: with SMTP id
 a20mr3030107wmm.97.1579247048552; 
 Thu, 16 Jan 2020 23:44:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqz6lMQuy3UEHW/YhoYaVFu+kgkSu+9nfD7Tq/yYfxDpHpy2wUrYVasqFOWUZDv2jhRw7CAL6w==
X-Received: by 2002:a05:600c:2254:: with SMTP id
 a20mr3030095wmm.97.1579247048387; 
 Thu, 16 Jan 2020 23:44:08 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id g9sm33096328wro.67.2020.01.16.23.44.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2020 23:44:07 -0800 (PST)
Subject: Re: [PATCH v2] uas: fix super speed bMaxPacketSize0
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200117073716.31335-1-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8528f463-2bfc-d148-022d-a769b129cc03@redhat.com>
Date: Fri, 17 Jan 2020 08:44:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200117073716.31335-1-kraxel@redhat.com>
Content-Language: en-US
X-MC-Unique: f8pF2WFROjqs-zdI92FMXg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: fys@fysnet.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/17/20 8:37 AM, Gerd Hoffmann wrote:
> For usb2 bMaxPacketSize0 is "n", for usb3 it is "1 << n",
> so it must be 9 not 64 ...
>=20
> rom "Universal Serial Bus 3.1 Specification":

Oops typo "From" ;) You can obviously fix that directly on your tree, no=20
need for v3.

Thanks for the v2!

>=20
>     If the device is operating at Gen X speed, the bMaxPacketSize0
>     field shall be set to 09H indicating a 512-byte maximum packet.
>     An Enhanced SuperSpeed device shall not support any other maximum
>     packet sizes for the default control pipe (endpoint 0) control
>     endpoint.
>=20
> We now announce a 512-byte maximum packet.
>=20
> Fixes: 89a453d4a5c ("uas-uas: usb3 streams")
> Reported-by: Benjamin David Lunt <fys@fysnet.net>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   hw/usb/dev-uas.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/usb/dev-uas.c b/hw/usb/dev-uas.c
> index 6d6d1073b907..1bc4dd4fafb8 100644
> --- a/hw/usb/dev-uas.c
> +++ b/hw/usb/dev-uas.c
> @@ -303,7 +303,7 @@ static const USBDescDevice desc_device_high =3D {
>  =20
>   static const USBDescDevice desc_device_super =3D {
>       .bcdUSB                        =3D 0x0300,
> -    .bMaxPacketSize0               =3D 64,
> +    .bMaxPacketSize0               =3D 9,
>       .bNumConfigurations            =3D 1,
>       .confs =3D (USBDescConfig[]) {
>           {
>=20


