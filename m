Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7531FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 06:37:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B9DB20773
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 06:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZQmUoxOV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B9DB20773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joLWB-0002xW-HL
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 02:37:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joLV9-0002PX-Of
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 02:36:47 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49760
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joLV7-0007df-HJ
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 02:36:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593067004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QmH+NW8J4Q/k869yyAgGEAX9RLYu7D/XEt84UnQ7PR0=;
 b=ZQmUoxOVH32iRQ+Y1lFKPNChSgY6gbSgafFiIuTl0Baq11m63iEfMf0KCm22ccE6yPkKro
 fSfHU0yBS9Eqz8klPKq+tyOlRDCMW0UaXDog1MQmk618i3TdFMGY8cBYLucurpWMe7pXj+
 V9oQC41SCxc+laL193J0Q230ii3O4jc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-rZ2BjViiNQC7ImspGAa1JA-1; Thu, 25 Jun 2020 02:36:42 -0400
X-MC-Unique: rZ2BjViiNQC7ImspGAa1JA-1
Received: by mail-wm1-f69.google.com with SMTP id b13so4171163wme.9
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 23:36:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=QmH+NW8J4Q/k869yyAgGEAX9RLYu7D/XEt84UnQ7PR0=;
 b=F3iCTywzSvMJJzwIZfkexr8kocniFHP7rdOZos/pUbKw+3vH1L3GOfFuNCFy1Li8z3
 zH+1JNzNIL3J4brZ1VuLZe+ovf1t265cIUkNCyf8Q9dY/Bl0lukHGejRWHEI6FGhDc4c
 GgDWaH8bIxq/nMLMEGrLao7GesCXUTLFno9/lgFySo5rXPNk1ZJgmMCgWmO27p8fYcy+
 tXg8kVnWAXgeZ7B37tHf1PAHA4O6DKHiSNRJhcIE62QOXEzykC9ViUfbjRIUvGTZJz+n
 fL3ATu1xEP/gS3lWrzaJV+7yfoHmefwYm0RxqftC/Rue+UHUKZBGpQ1vpBrpD9jQEsyZ
 oerg==
X-Gm-Message-State: AOAM531BoCSVofRYeCEKmzqVbjfYgaN+5za+l7s6hRwTYI8ih5obeo3I
 Fg58AgeE/G4n9sSEF3/bhX2/rptAJNYoxjFqElAI9Wd6yk8R/alYwhIj6GooTNxqeQEf1P6sWXK
 wENdvyijSusSh6Fo=
X-Received: by 2002:a1c:9acf:: with SMTP id c198mr1655082wme.172.1593067001500; 
 Wed, 24 Jun 2020 23:36:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmsAk9FwrMArRZ7sHdBWAMyko7/dtW3E6W1l0vAR8dQaZaWv96RqNpgdSve6ej3v7TFmMC+g==
X-Received: by 2002:a1c:9acf:: with SMTP id c198mr1655058wme.172.1593067001301; 
 Wed, 24 Jun 2020 23:36:41 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id y196sm12055130wmd.11.2020.06.24.23.36.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2020 23:36:40 -0700 (PDT)
Subject: Re: [PATCH 34/46] qom: Don't handle impossible
 object_property_get_link() failure
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-35-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <4c1644b4-4d30-9831-9484-dc32081f41db@redhat.com>
Date: Thu, 25 Jun 2020 08:36:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200624164344.3778251-35-armbru@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 00:45:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, berrange@redhat.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/24/20 6:43 PM, Markus Armbruster wrote:
> Don't handle object_property_get_link() failure that can't happen
> unless the programmer screwed up, pass &error_abort.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/arm/bcm2835_peripherals.c |  7 +------
>  hw/arm/bcm2836.c             |  7 +------
>  hw/display/bcm2835_fb.c      |  8 +-------
>  hw/dma/bcm2835_dma.c         |  9 +--------
>  hw/gpio/bcm2835_gpio.c       | 15 ++-------------
>  hw/intc/nios2_iic.c          |  8 +-------
>  hw/misc/bcm2835_mbox.c       |  9 +--------
>  hw/misc/bcm2835_property.c   | 17 ++---------------
>  hw/usb/hcd-dwc2.c            |  9 +--------
>  9 files changed, 11 insertions(+), 78 deletions(-)
> 
> diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
> index 8313410ffe..3c40bda91e 100644
> --- a/hw/arm/bcm2835_peripherals.c
> +++ b/hw/arm/bcm2835_peripherals.c
> @@ -134,12 +134,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
>      uint64_t ram_size, vcram_size;
>      int n;
>  
> -    obj = object_property_get_link(OBJECT(dev), "ram", &err);
> -    if (obj == NULL) {
> -        error_setg(errp, "%s: required ram link not found: %s",
> -                   __func__, error_get_pretty(err));
> -        return;
> -    }
> +    obj = object_property_get_link(OBJECT(dev), "ram", &error_abort);
[...]

Should we now add an assert(errp) in object_property_get_link()?
Basically this would force forks to adapt their code when
rebasing.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


