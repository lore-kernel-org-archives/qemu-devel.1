Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE5FC83001
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 06:42:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8582B20784
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 06:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c29OW/tI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8582B20784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU2ty-0003U8-N4
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 02:42:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57982)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jU2pP-0006YT-54
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 02:37:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jU2nY-0005pn-Uu
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 02:37:46 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54026
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jU2nY-0005pE-HO
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 02:35:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588228551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0nMjE+aLRUSJNSYFb39TIbTyyPb6/y9CzNaOGWiHnMU=;
 b=c29OW/tIKxaQ/uq0A88YLMVTQh+oBGUq77ajXWszU4xZ1gI0WUGuk9iZsOQpmgtG33te+t
 SM/x/oQMtY/sETDeTbpAaWYkFoAoHBgCSTUSj0ngeKH/qdd0DAJSTuKl6hlQTz/4iBvihJ
 EyvTvGhlWVJvFEjxbWEwsqXy0b9sa6U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-jVERA8jkNXGW0jw4l_Q9cA-1; Thu, 30 Apr 2020 02:35:49 -0400
X-MC-Unique: jVERA8jkNXGW0jw4l_Q9cA-1
Received: by mail-wm1-f72.google.com with SMTP id j5so363077wmi.4
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 23:35:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pFTQMUW1kZq+dqLHK5AsXBKY8F6IG36S0DL6z98+eZA=;
 b=CIQJDRRg9HBM8Als25gtn+/liMFkIzAlKYoRfX2gNAkyR4dVMNNZUE7M3WY0vCsB1m
 mR2fej5a/Ob6wVaAyFDF28OBkBUAc1JAAy3bgYlM/X4UyIYjxjg3a+ejxMwK+wX9vT9h
 TLbtpln0r8CEEWZ/95EB7LoMWzXsX4XfpMN0Mf4MlRaEvDhJOX5Q2QrmaQQyxtxIa7dE
 G4oCBQ6jQR0YHR0hbrs8+kVqW8cXfIMLNlAxphpe38y1jSOFUeat2rFi21TxvOFfwnE7
 muxZx4fRZL8xov0xZey5Gani6O/UjwU/1Oyc49WHEsYJPSeUk5vafVlD+MhDOKE3+Mhj
 fi1g==
X-Gm-Message-State: AGi0PuZekVrT/36yMFNLBYeOj7q4puBIxhpcLzkuHmKkq2uJc/VLPUI/
 Yvub4LpsfW5bKFVZu8gzUwBLl5HJ+DOpwP9PKJouL44qdh51WhgWmqhOng5tuChO9xROVXWg64d
 vCbgHHmMthIega9I=
X-Received: by 2002:a7b:c10d:: with SMTP id w13mr1183409wmi.78.1588228548465; 
 Wed, 29 Apr 2020 23:35:48 -0700 (PDT)
X-Google-Smtp-Source: APiQypLo7Z4CAFMwInmwsbjCtUwvUCtrexMLvEgOvDE4/BUqDH+opwS4ZMZJWibMju8r3dyumyoh3A==
X-Received: by 2002:a7b:c10d:: with SMTP id w13mr1183391wmi.78.1588228548269; 
 Wed, 29 Apr 2020 23:35:48 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id x18sm2479606wrv.12.2020.04.29.23.35.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2020 23:35:47 -0700 (PDT)
Subject: Re: [PATCH v3 06/15] rtc: add RTC_ISA_BASE
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200429140003.7336-1-kraxel@redhat.com>
 <20200429140003.7336-7-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <51047ae4-55ef-8a93-723d-d5a03f83b649@redhat.com>
Date: Thu, 30 Apr 2020 08:35:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200429140003.7336-7-kraxel@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:04:40
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/29/20 3:59 PM, Gerd Hoffmann wrote:
> Add and use RTC_ISA_BASE define instead of hardcoding 0x70.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   include/hw/rtc/mc146818rtc.h | 1 +
>   hw/rtc/mc146818rtc.c         | 5 ++---
>   2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/hw/rtc/mc146818rtc.h b/include/hw/rtc/mc146818rtc.h
> index 10c93a096a1d..3713181b56fe 100644
> --- a/include/hw/rtc/mc146818rtc.h
> +++ b/include/hw/rtc/mc146818rtc.h
> @@ -47,6 +47,7 @@ typedef struct RTCState {
>   } RTCState;
>  =20
>   #define RTC_ISA_IRQ 8
> +#define RTC_ISA_BASE 0x70

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>  =20
>   ISADevice *mc146818_rtc_init(ISABus *bus, int base_year,
>                                qemu_irq intercept_irq);
> diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
> index dc4269cc55cb..d18c09911be2 100644
> --- a/hw/rtc/mc146818rtc.c
> +++ b/hw/rtc/mc146818rtc.c
> @@ -908,7 +908,6 @@ static void rtc_realizefn(DeviceState *dev, Error **e=
rrp)
>   {
>       ISADevice *isadev =3D ISA_DEVICE(dev);
>       RTCState *s =3D MC146818_RTC(dev);
> -    int base =3D 0x70;
>  =20
>       s->cmos_data[RTC_REG_A] =3D 0x26;
>       s->cmos_data[RTC_REG_B] =3D 0x02;
> @@ -951,7 +950,7 @@ static void rtc_realizefn(DeviceState *dev, Error **e=
rrp)
>       qemu_register_suspend_notifier(&s->suspend_notifier);
>  =20
>       memory_region_init_io(&s->io, OBJECT(s), &cmos_ops, s, "rtc", 2);
> -    isa_register_ioport(isadev, &s->io, base);
> +    isa_register_ioport(isadev, &s->io, RTC_ISA_BASE);
>  =20
>       /* register rtc 0x70 port for coalesced_pio */
>       memory_region_set_flush_coalesced(&s->io);
> @@ -960,7 +959,7 @@ static void rtc_realizefn(DeviceState *dev, Error **e=
rrp)
>       memory_region_add_subregion(&s->io, 0, &s->coalesced_io);
>       memory_region_add_coalescing(&s->coalesced_io, 0, 1);
>  =20
> -    qdev_set_legacy_instance_id(dev, base, 3);
> +    qdev_set_legacy_instance_id(dev, RTC_ISA_BASE, 3);
>       qemu_register_reset(rtc_reset, s);
>  =20
>       object_property_add_tm(OBJECT(s), "date", rtc_get_date, NULL);
>=20


