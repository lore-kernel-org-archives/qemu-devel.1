Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F87C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:53:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51FAD2067B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:53:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51FAD2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK3ay-0007DV-Ro
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:53:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37579)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iK2r1-0005i1-TD
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iK2r0-0008LR-Pt
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52574)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iK2r0-0008KK-9h
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:50 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6C6E844BCF
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 16:05:49 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id p6so4317219wmc.3
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:05:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HdJ94zX4oy8GaxZqeQPCzhPobj+nrIWTF4qRdELQvNo=;
 b=pjhIqEQEBXLj0BM/X7v17+JWwUKD328/hzWhm3I/zwItd8XpUSYIGnRHR1g5AaONg5
 azRKiy/3kZaiR/zmOrdg+hnCKlMzcCaAvP5b0pa+kzuh5W2o0Xx78MKaJTDvmCpD6BX2
 9nJJFJLUgIsTkRa+E5QZDc1+3opMJBN/fjaqn6nsh2jI++4kBuwxLzX6xCrRzHKnEA8k
 IfuzafQIImmiXKelH9YsSYEm6Kjp5w3QoJBHeinxkaLuP47IwDBxwjFEbfykJAyGzDNW
 VGHiKASqj/I8UkTaQu3ohY8FWayU59Im/mRle4KCZ4ySGfxCkpIA31yJGmMB0KNOZMIc
 ZBKQ==
X-Gm-Message-State: APjAAAW5Ep95Umk/yjtdG2l6cLJMiy18lvRaJcwGSSJq9kcfW+AYY9NX
 OtFoy+fLomCQJbD5K3cQjLDwT2W9eoN83I750zFRIb1JOdYoTgduxoIwJDZPBk0BmxlOBwzUxl9
 /1zohLuMSKzCmWgI=
X-Received: by 2002:a05:600c:34b:: with SMTP id
 u11mr15140204wmd.172.1571069148150; 
 Mon, 14 Oct 2019 09:05:48 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwHinBJX5bl0nkJ6gJ5Xer/2lcmhcuCkCqNTk+fV6coc85MPVDkBBCRe03OMOJMDYmehrnrSg==
X-Received: by 2002:a05:600c:34b:: with SMTP id
 u11mr15140180wmd.172.1571069147963; 
 Mon, 14 Oct 2019 09:05:47 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id n3sm9218434wrr.50.2019.10.14.09.05.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Oct 2019 09:05:47 -0700 (PDT)
Subject: Re: [PATCH 08/19] hw/misc/bcm2835_thermal: Add a dummy BCM2835
 thermal sensor
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20190926173428.10713-1-f4bug@amsat.org>
 <20190926173428.10713-9-f4bug@amsat.org>
 <CAFEAcA-2SCsRepsERqGWD-4AYy=uxb7Y2eW2F_z45tyo0Yx-fw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c76bdafa-c00c-af72-549d-dd3706200401@redhat.com>
Date: Mon, 14 Oct 2019 18:05:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-2SCsRepsERqGWD-4AYy=uxb7Y2eW2F_z45tyo0Yx-fw@mail.gmail.com>
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
Cc: =?UTF-8?Q?Zolt=c3=a1n_Baldaszti?= <bztemail@gmail.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 Clement Deschamps <clement.deschamps@antfield.fr>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>, Pekka Enberg <penberg@iki.fi>,
 Guenter Roeck <linux@roeck-us.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/19 5:37 PM, Peter Maydell wrote:
> On Thu, 26 Sep 2019 at 18:34, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.=
org> wrote:
>>
>> We will soon implement the SYS_timer. This timer is used by Linux
>> in the thermal subsystem, so once available, the subsystem will be
>> enabled and poll the temperature sensors. We need to provide the
>> minimum required to keep Linux booting.
>>
>> Add a dummy thermal sensor returning ~25=C2=B0C based on:
>> https://github.com/raspberrypi/linux/blob/rpi-5.3.y/drivers/thermal/br=
oadcom/bcm2835_thermal.c
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>> checkpatch warning:
>> WARNING: added, moved or deleted file(s), does MAINTAINERS need updati=
ng?
>> This is OK because the regex are:
>>
>>    F: hw/*/bcm283*
>>    F: include/hw/*/bcm283*
>=20
>> +static void bcm2835_thermal_class_init(ObjectClass *klass, void *data=
)
>> +{
>> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>> +
>> +    dc->realize =3D bcm2835_thermal_realize;
>> +}
>=20
> This is missing the vmsd and reset function.

Ah correct, I forgot about the Bcm2835ThermalState::ctl field.

Thanks!

Phil.

