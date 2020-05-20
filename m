Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF26C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 12:06:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE05E20758
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 12:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TpKT5vL7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE05E20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbNUp-0005Pe-6r
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 08:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbNUG-0004w5-Pt
 for qemu-devel@nongnu.org; Wed, 20 May 2020 08:06:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36308
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbNUD-0002W4-WC
 for qemu-devel@nongnu.org; Wed, 20 May 2020 08:06:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589976372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y73ZsonVLj46QonL5x/FDL0r3D3uvmgRecYaKaseYAA=;
 b=TpKT5vL727qgbyFWc1UC7wNSFPeQa+62C+8DeEiY1fZtFcjcs7IOuzHg1/pi9w1DeaQObo
 KohmIvppkfDHS/vz0cLMY5VXil9Rs+m6Et1vYjiv687lPzZnWl8kcdugihcPwWsOwZ+V3R
 JU7k7guxi/56E/nEJRZnxjqAjhruKgM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-u1cana7PPZuYd1wLfuIBcw-1; Wed, 20 May 2020 08:06:11 -0400
X-MC-Unique: u1cana7PPZuYd1wLfuIBcw-1
Received: by mail-wr1-f72.google.com with SMTP id r7so1318294wrc.13
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 05:06:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=y73ZsonVLj46QonL5x/FDL0r3D3uvmgRecYaKaseYAA=;
 b=Sbh8o48ExhIZc1IKGHysrOQ4msq/wJBEUlMlhANYuX8ocRvuP697UGJbYFAz3OQfSP
 qz9vU81YZwQDYPCUeJ1SfiW2wEtZePZFadqBK0MPoEWQ97Z6dqMACS9NLBF0codGRpQS
 OOc23QaydciB3jFR0g8ff2vN3v+YBWLERL2WZd3ye+mwWrLfOhE7JX3AveGf9gdofUiW
 l98PzVxvA1sBrxs3m3haAXDxs+seZPWZrJAfuipmbvCAIeFQgxcrrfFa87m4XnGyxro0
 iEni7WAawm7STXoOVDyH0JlLeM0pNEc19i+d0yGRryIYiuUfW2cpUyFO8V+QGqc2VO43
 Y8qA==
X-Gm-Message-State: AOAM533nsyFq7DdDFNfBtJAqpg40HW5frSSid/Jxsw8ZfZEC45lwazEq
 jGQqKasKdUCfhXRpFUwlim9DTynTGzCl5HWcBbZp0eiZLfskGfhWDk8dCGxD6LIBxYkbImjsFMp
 ppUla/HesKBgtw3I=
X-Received: by 2002:a5d:40c2:: with SMTP id b2mr3733829wrq.13.1589976367195;
 Wed, 20 May 2020 05:06:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4CX5HNpZ2iuV+zu8f1l05h6uCCx8UFXbcD98DdZdb2inzMYE2yGHwi2Y0r+T+0pOH9bZQ0Q==
X-Received: by 2002:a5d:40c2:: with SMTP id b2mr3733816wrq.13.1589976367018;
 Wed, 20 May 2020 05:06:07 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id a10sm2888629wmf.46.2020.05.20.05.06.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2020 05:06:06 -0700 (PDT)
Subject: Re: [PATCH 38/55] microbit: Tidy up sysbus_init_child_obj() @child
 argument
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200519145551.22836-1-armbru@redhat.com>
 <20200519145551.22836-39-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3bb39878-b422-954b-5c78-49e61b4fee7a@redhat.com>
Date: Wed, 20 May 2020 14:06:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200519145551.22836-39-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 01:34:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/19/20 4:55 PM, Markus Armbruster wrote:
> The callers of sysbus_init_child_obj() commonly pass either &child,
> sizeof(child), or pchild, sizeof(*pchild).  Tidy up two that don't,
> mostly to keep future commits simpler.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   hw/arm/microbit.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/microbit.c b/hw/arm/microbit.c
> index ef213695bd..72fab429c4 100644
> --- a/hw/arm/microbit.c
> +++ b/hw/arm/microbit.c
> @@ -39,7 +39,7 @@ static void microbit_init(MachineState *machine)
>       Object *soc = OBJECT(&s->nrf51);
>       Object *i2c = OBJECT(&s->i2c);
>   
> -    sysbus_init_child_obj(OBJECT(machine), "nrf51", soc, sizeof(s->nrf51),
> +    sysbus_init_child_obj(OBJECT(machine), "nrf51", &s->nrf51, sizeof(s->nrf51),
>                             TYPE_NRF51_SOC);
>       qdev_prop_set_chr(DEVICE(&s->nrf51), "serial0", serial_hd(0));
>       object_property_set_link(soc, OBJECT(system_memory), "memory",
> @@ -51,7 +51,7 @@ static void microbit_init(MachineState *machine)
>        * hack until we implement the nRF51 TWI controller properly and the
>        * magnetometer/accelerometer devices.
>        */
> -    sysbus_init_child_obj(OBJECT(machine), "microbit.twi", i2c,
> +    sysbus_init_child_obj(OBJECT(machine), "microbit.twi", &s->i2c,
>                             sizeof(s->i2c), TYPE_MICROBIT_I2C);
>       object_property_set_bool(i2c, true, "realized", &error_fatal);

i2c is only used once now, maybe you can remove it and directly use 
in-place. Regardless:

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>       mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(i2c), 0);
> 


