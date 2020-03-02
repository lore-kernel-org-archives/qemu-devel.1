Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB6DC3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 13:39:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57D6C2187F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 13:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UPFiqzbQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57D6C2187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8lIc-0006GK-Ju
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 08:39:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54100)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j8lHt-0005O7-P7
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 08:39:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j8lHs-0005xp-KC
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 08:39:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26128
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j8lHs-0005xi-Gi
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 08:39:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583156352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L9Cs50exC0abJzqi9OVqYdjap0FPa+go1iUxdr9/ksg=;
 b=UPFiqzbQ2vb/iUMYL7LMzzgH9WPUQZlOJoRR8vmaYRK+RAqTpxr6SMCrW8GuAZU1t5KgVD
 U5k9JlKgEwKE0BhBJsqzQtwz9cS2miVv+a2J8V93BUTHQo+GNL+rzyRyLAMa4UYn5z6VpO
 DA9J1aT8dzSl/nOatXvYyBI8k7s+U+g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-WmCjEf2ONP2n0RKMjllIcQ-1; Mon, 02 Mar 2020 08:39:10 -0500
X-MC-Unique: WmCjEf2ONP2n0RKMjllIcQ-1
Received: by mail-wm1-f69.google.com with SMTP id f207so2905994wme.6
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 05:39:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ig5eFtJ9p0MBNtGS1Befy7D81dyzNS6Kd/gUFfvs7Hs=;
 b=jjwEfCMnzRC6aFx+wlaSTmnNCXalj1Fp8faTQ4njTZNg9IbRfy5RSqmpzlkjCBiWUM
 rRbN4LIyqGgAhk10Op4K3CrY3tSmdW8eyUTC9Ca34ZkwdjI8mtV1NfMrp93pELQwUTjZ
 erkGmsb0dvrPD+iS+ubXE+lEKyN5a+tJpfPRMvLYCHMEUePjon/R1ZoOwLs7emh//HRQ
 K0+/q0mLcVZGX5/ZVOcBmfhNO1M434fSBnUMiKBs0XvpX1ibPjFOf33ZTOHH+yUDY8uP
 E8zZISjLWhezD1QIMRP48eEf1Cz5yMqaNumv295HaLeuqPseWAESN4yrdJUbkuW0WrT5
 xJcA==
X-Gm-Message-State: APjAAAWg9RcCGaT6DVLZ+cRGbVBlagsH4pmUHGPAbcDUFbI+8Erenxft
 o+FOJgXn0GmT3R2Rfivpr0gnGpWC5s5wB8/9Hkpsi+E5AmSAlJLoMDLCYAR6nHJnNUM1zBBXHaf
 88uHzUw2ufEb/EzU=
X-Received: by 2002:adf:e506:: with SMTP id j6mr22039365wrm.309.1583156349316; 
 Mon, 02 Mar 2020 05:39:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqyZC1LgEXa5NMdK0zFcq1iyU3g2lWPU4gfQPbWSF5+/P4ztEKSVcse5kfxI2KaXz8Ve3cxmBg==
X-Received: by 2002:adf:e506:: with SMTP id j6mr22039350wrm.309.1583156349053; 
 Mon, 02 Mar 2020 05:39:09 -0800 (PST)
Received: from ?IPv6:2a01:e35:2fb0:49e0:3f7b:4b69:b9c:cdc0?
 ([2a01:e35:2fb0:49e0:3f7b:4b69:b9c:cdc0])
 by smtp.gmail.com with ESMTPSA id g14sm29199457wrv.58.2020.03.02.05.39.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2020 05:39:08 -0800 (PST)
Subject: Re: [PATCH v2 1/2] dp264: use pci_create() to initialise the cmd646
 device
To: BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20200301190520.18520-1-mark.cave-ayland@ilande.co.uk>
 <20200301190520.18520-2-mark.cave-ayland@ilande.co.uk>
 <alpine.BSF.2.22.395.2003012232020.79908@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <84bf52cc-4a29-e814-9193-67b96497fe74@redhat.com>
Date: Mon, 2 Mar 2020 14:39:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.22.395.2003012232020.79908@zero.eik.bme.hu>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: jsnow@redhat.com, qemu-devel@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/1/20 10:34 PM, BALATON Zoltan wrote:
> On Sun, 1 Mar 2020, Mark Cave-Ayland wrote:
>> Remove the call to pci_cmd646_ide_init() since global device init=20
>> functions
>> are deprecated in preference of using qdev directly.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>> hw/alpha/dp264.c | 7 ++++++-
>> 1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
>> index 8d71a30617..50e75aeee3 100644
>> --- a/hw/alpha/dp264.c
>> +++ b/hw/alpha/dp264.c
>> @@ -16,6 +16,7 @@
>> #include "sysemu/sysemu.h"
>> #include "hw/rtc/mc146818rtc.h"
>> #include "hw/ide.h"
>> +#include "hw/ide/pci.h"
>> #include "hw/timer/i8254.h"
>> #include "hw/isa/superio.h"
>> #include "hw/dma/i8257.h"
>> @@ -100,9 +101,13 @@ static void clipper_init(MachineState *machine)
>> =A0=A0=A0 /* IDE disk setup.=A0 */
>> =A0=A0=A0 {
>> =A0=A0=A0=A0=A0=A0=A0 DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
>> +=A0=A0=A0=A0=A0=A0=A0 PCIDevice *pci_dev;
>> +
>> =A0=A0=A0=A0=A0=A0=A0 ide_drive_get(hd, ARRAY_SIZE(hd));
>>
>> -=A0=A0=A0=A0=A0=A0=A0 pci_cmd646_ide_init(pci_bus, hd, 0);
>> +=A0=A0=A0=A0=A0=A0=A0 pci_dev =3D pci_create(pci_bus, -1, "cmd646-ide")=
;
>> +=A0=A0=A0=A0=A0=A0=A0 qdev_init_nofail(DEVICE(pci_dev));
>=20
> You could just use pci_create_simple here now that you don't set=20
> properties.

Can be added as a patch on top, either ways:

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

>=20
> Regards,
> BALATON Zoltan
>=20
>> +=A0=A0=A0=A0=A0=A0=A0 pci_ide_create_devs(pci_dev, hd);
>> =A0=A0=A0 }
>>
>> =A0=A0=A0 /* Load PALcode.=A0 Given that this is not "real" cpu palcode,
>>
>=20


