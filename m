Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37938C10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 10:56:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 047C42086A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 10:56:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 047C42086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFyme-0000mP-80
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 06:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58865)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iFyld-00008X-PO
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 06:55:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iFylb-0000jd-Dg
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 06:55:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60392)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iFylb-0000j1-1h
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 06:55:27 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B096D90C99
 for <qemu-devel@nongnu.org>; Thu,  3 Oct 2019 10:55:25 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id a189so1415235wma.1
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2019 03:55:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YyjoSAkKKcGPpRZ2A6DWybBIf2MKlZgCm7Qq/j/nfMQ=;
 b=JayiZHUFjFVk85Nlxs1qnlVSPUyCstmbmhZwM/eZpkGrcFQXtewHbdjvNSmpCCWGGG
 qcx8HSWDCg8O+DVK8Fe3d6AzSgnD9N6JhApt7LWiHxKihHFgSP79oX/8tG35TlyWgtwj
 n64lPIQTO1PpX9KpVHe9IYxOq56B9BC/BzEiQS7Rv8XkUTEU88R+EA0rosv7TJDqEhBE
 Pu1cOoMng95gccuGRAlJfH6CS6FVoKYZW22AzTgStLflA9RHfUd9mm7S7Fnm4t3uJLDP
 yhJkxwcr6ae85QphOwY2taHeIalrbPK0uWyWrQBahjhbJyuDiOUV9UWoAVpAZev6Dx9H
 xAWQ==
X-Gm-Message-State: APjAAAWVkBqm5wLgLQ1sXrG5UXoTp5kLguCUwDrxN9ZU6SIGSG7lwzXs
 iQ14Tsqz7GJpqJbbEu5ww/phM8WGdWmNod66LlF1JZSa3f5soKvN6Dmm5RSlIJWIWxi+xVrQpf5
 dHEoqBqTzTo+Tb6g=
X-Received: by 2002:adf:8444:: with SMTP id 62mr6497615wrf.202.1570100124542; 
 Thu, 03 Oct 2019 03:55:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyNulw0K0xIqVTyG9m/6HKEFXC5LahxGv7cORcBI5fT8bphgpc+H9JgDkDAFygHBdTe0sYKbw==
X-Received: by 2002:adf:8444:: with SMTP id 62mr6497582wrf.202.1570100124328; 
 Thu, 03 Oct 2019 03:55:24 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id h10sm2534347wrq.95.2019.10.03.03.55.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2019 03:55:23 -0700 (PDT)
Subject: Re: [PATCH 11/13] hw: Move Aspeed RTC from hw/timer/ to hw/rtc/
 subdirectory
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
References: <20190916154847.28936-1-philmd@redhat.com>
 <20190916154847.28936-12-philmd@redhat.com>
 <20ec7d30-a8da-9e11-acfc-b8d773a5527d@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <29282e84-e8f9-feda-21a4-d8dd202a5638@redhat.com>
Date: Thu, 3 Oct 2019 12:55:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20ec7d30-a8da-9e11-acfc-b8d773a5527d@kaod.org>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Andrew Jeffery <andrew@aj.id.au>, qemu-ppc@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/16/19 7:21 PM, C=C3=A9dric Le Goater wrote:
> On 16/09/2019 17:48, Philippe Mathieu-Daud=C3=A9 wrote:
>> Move RTC devices under the hw/rtc/ subdirectory.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
> I suppose the removal of the header files in "aspeed_rtc.h" is OK.

They are not used. It is probably cleaner to do this change in a=20
separate patch.

>=20
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks!

[...]
>> diff --git a/include/hw/timer/aspeed_rtc.h b/include/hw/rtc/aspeed_rtc=
.h
>> similarity index 92%
>> rename from include/hw/timer/aspeed_rtc.h
>> rename to include/hw/rtc/aspeed_rtc.h
>> index 15ba42912b..156c8faee3 100644
>> --- a/include/hw/timer/aspeed_rtc.h
>> +++ b/include/hw/rtc/aspeed_rtc.h
>> @@ -8,9 +8,6 @@
>>   #ifndef ASPEED_RTC_H
>>   #define ASPEED_RTC_H
>>  =20
>> -#include <stdint.h>
>> -
>> -#include "hw/irq.h"
>>   #include "hw/sysbus.h"
>>  =20
>>   typedef struct AspeedRtcState {
>>

