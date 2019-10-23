Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9A0CA9EB9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 22:39:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0349E205F4
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 22:39:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0349E205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNPHP-0007n7-W5
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 18:39:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57187)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNPFa-0005XN-7d
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 18:37:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNPFY-0007ZF-9G
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 18:37:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42254)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNPFY-0007Yp-1D
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 18:37:04 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2584F66C58
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 22:37:03 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id e25so11190859wra.9
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 15:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bgWeqBVMk+gZhXCPpPyJ795Ly2kNdj/BZXQC2iCRw1w=;
 b=j69CyRhlZ4QCT4AyUNPmOAJ1mshR4KyQcXMacSYzcrTNitlo6xjHOwbozNXjGiQZut
 +zaza0JvaYN/b0BVckhx/9rEKzTGmVjApIo+ttZWCu2FrXkSl4swE4FGKXZifwta1P5m
 gGVNq5yz4MjZ15V/fWTjkt85E93Kvhu/Yh++z2RCd7Z3RhzEr3p3AcPZpnsdEqouoDlg
 Ql/8KV67LviiZ5Ck58AQPNPFSttjYLbtl6LvheGcTGAan4mwLZ6bQRuO4svdmyQSSr1g
 IzkZWwoswQ+wk9w+ScvrePbRYuYnQp81S36KgDWBqxeYAjHS5Xn4GmEK7uyFxm+Jrv/+
 yv9g==
X-Gm-Message-State: APjAAAXTqKKxR0Eov17T/xgfkNLg652079/WpijU3C64sauZo3yHroNC
 oTZj/YIawRMevugBc2pOb1U6IpvZ2pSCO+u6xBzJ78aanp9JtUl4zUb8fvMaqDqvem41pRLbIYn
 rGiG2b0dN6WNochQ=
X-Received: by 2002:adf:a4cf:: with SMTP id h15mr879338wrb.222.1571870221920; 
 Wed, 23 Oct 2019 15:37:01 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxFXs5NXWoN1LJu9zHKPJ9RTZRefY+bR1rZyT3eFYfmz+F1qtDVdBpMpZK7uP17701efyrXGw==
X-Received: by 2002:adf:a4cf:: with SMTP id h15mr879301wrb.222.1571870221672; 
 Wed, 23 Oct 2019 15:37:01 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id o11sm470934wmh.28.2019.10.23.15.37.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2019 15:37:01 -0700 (PDT)
Subject: Re: [PATCH v3 03/33] sysbus: remove outdated comment
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-4-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4bc674ec-fed3-1341-80c5-5bf526ef01e1@redhat.com>
Date: Thu, 24 Oct 2019 00:36:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191023173154.30051-4-marcandre.lureau@redhat.com>
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
Cc: Corey Minyard <cminyard@mvista.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Burton <pburton@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Mao Zhongyi <maozhongyi@cmss.chinamobile.com>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-arm@nongnu.org,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-ppc@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/23/19 7:31 PM, Marc-Andr=C3=A9 Lureau wrote:
> The init callback is no more since commit
> 817a17fc60f44e29a1944b60d32f45ea127f0cf9 ("core/sysbus: remove the
> SysBusDeviceClass::init path")
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   include/hw/sysbus.h | 4 ----
>   1 file changed, 4 deletions(-)
>=20
> diff --git a/include/hw/sysbus.h b/include/hw/sysbus.h
> index 2eb0484388..c4a1c0adfa 100644
> --- a/include/hw/sysbus.h
> +++ b/include/hw/sysbus.h
> @@ -24,10 +24,6 @@ typedef struct SysBusDevice SysBusDevice;
>  =20
>   /**
>    * SysBusDeviceClass:
> - * @init: Callback function invoked when the #DeviceState.realized pro=
perty
> - * is changed to %true. Deprecated, new types inheriting directly from
> - * TYPE_SYS_BUS_DEVICE should use #DeviceClass.realize instead, new le=
af
> - * types should consult their respective parent type.
>    *
>    * SysBusDeviceClass is not overriding #DeviceClass.realize, so deriv=
ed
>    * classes overriding it are not required to invoke its implementatio=
n.
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

