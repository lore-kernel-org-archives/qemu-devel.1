Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24CFCA9EBC
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 22:41:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAA2221872
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 22:41:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAA2221872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNPJl-0003fB-RL
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 18:41:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57704)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNPIc-00020D-Fz
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 18:40:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNPIY-0000L9-Nu
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 18:40:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43660)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNPIW-0000HG-Nt
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 18:40:10 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 73A1CB2DC4
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 22:40:07 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id s17so6107951wrp.17
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 15:40:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=y50bH1dlPq4kc/K8E41rdMkHO6I3Jt/+zrd6imb4awE=;
 b=HLBXPUdrJx4ypiXF3jBW9sL5vFM0LrbhkNFy2FG8TlZsq+jHxeay1iXlJXF6KLcbSQ
 4ruRmyEZ/jTUlKM1SI/KSpRFfo5RSi7b1c3jh640LJ/Wwd8Rn2ARVxSLKD0iQO6aFRCv
 9auu8F/hQDjnm4/dFoGKTC9o4DaSJ9hRy8k/bVGTxl1n/0lkMWb8K9J+CBmClLbN8Ooq
 LHaIJJZRCEaSuAsBt97Zdtp7NS1WHdRTOxIfaF6ivO4ZeZN+2ITiYlr4K58LGqLsezRg
 A0x3gI/gVfy5H1FnJyoWXINr/7zm+EIlj3x4kEpk64i8SkNAKV9TK1r1HB8XW6vXCPWB
 Fw6A==
X-Gm-Message-State: APjAAAX+7V14PFrSxSnqrrVZVwdUfmPJDjPy5B5dUVY1hSiRd4lZaDcQ
 ypxkV9dkyOqu1g1jC9Wo2w0Q3HcGqL6RKe873XP0136WnuWZmqZyzKXHSmLXsJgoXpS7K4OXWSY
 stX0FNSzIb96467c=
X-Received: by 2002:a1c:9894:: with SMTP id a142mr1901883wme.70.1571870406104; 
 Wed, 23 Oct 2019 15:40:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzUva7CdhlylCr8YAQBiv5lhffBzFPNS2UiheYF1XPH0m2nFPtLPkBhjZro9Ca69HcrsCJ25w==
X-Received: by 2002:a1c:9894:: with SMTP id a142mr1901868wme.70.1571870405923; 
 Wed, 23 Oct 2019 15:40:05 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id 79sm954560wmb.7.2019.10.23.15.40.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2019 15:40:05 -0700 (PDT)
Subject: Re: [PATCH v3 09/33] serial: add "baudbase" property
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-10-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5e92433d-f9a3-72a1-3792-4bfa7cd16b01@redhat.com>
Date: Thu, 24 Oct 2019 00:40:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191023173154.30051-10-marcandre.lureau@redhat.com>
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
Cc: Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Magnus Damm <magnus.damm@gmail.com>,
 Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fabien Chouteau <chouteau@adacore.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Burton <pburton@wavecomp.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/23/19 7:31 PM, Marc-Andr=C3=A9 Lureau wrote:
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/char/serial.c         | 5 +++--
>   include/hw/char/serial.h | 2 +-
>   2 files changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/char/serial.c b/hw/char/serial.c
> index 09e89727a6..069d8715d0 100644
> --- a/hw/char/serial.c
> +++ b/hw/char/serial.c
> @@ -988,7 +988,7 @@ SerialState *serial_init(int base, qemu_irq irq, in=
t baudbase,
>       SerialState *s =3D SERIAL(dev);
>  =20
>       s->irq =3D irq;
> -    s->baudbase =3D baudbase;
> +    qdev_prop_set_uint32(dev, "baudbase", baudbase);
>       qdev_prop_set_chr(dev, "chardev", chr);
>       serial_realize_core(s, &error_fatal);
>       qdev_set_legacy_instance_id(dev, base, 2);
> @@ -1002,6 +1002,7 @@ SerialState *serial_init(int base, qemu_irq irq, =
int baudbase,
>  =20
>   static Property serial_properties[] =3D {
>       DEFINE_PROP_CHR("chardev", SerialState, chr),
> +    DEFINE_PROP_UINT32("baudbase", SerialState, baudbase, 115200),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>  =20
> @@ -1070,7 +1071,7 @@ SerialState *serial_mm_init(MemoryRegion *address=
_space,
>  =20
>       s->it_shift =3D it_shift;
>       s->irq =3D irq;
> -    s->baudbase =3D baudbase;
> +    qdev_prop_set_uint32(dev, "baudbase", baudbase);
>       qdev_prop_set_chr(dev, "chardev", chr);
>  =20
>       serial_realize_core(s, &error_fatal);
> diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
> index 180cc7c24e..3dc618598e 100644
> --- a/include/hw/char/serial.h
> +++ b/include/hw/char/serial.h
> @@ -58,7 +58,7 @@ typedef struct SerialState {
>       CharBackend chr;
>       int last_break_enable;
>       int it_shift;
> -    int baudbase;
> +    uint32_t baudbase;
>       uint32_t tsr_retry;
>       guint watch_tag;
>       uint32_t wakeup;
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

