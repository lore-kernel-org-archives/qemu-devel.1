Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B8AC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:40:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F60B2081E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ii2kvMAY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F60B2081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioqxx-0007fZ-BY
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 10:40:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38806)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ioqhQ-0005Ku-D3
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:23:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ioqhO-0007dQ-QK
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:23:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55411
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ioqhO-0007d5-MV
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:23:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578410594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vEZl/neS+NROZ3mdO1oRodcW72dgDNfEVAbmZRX2WOo=;
 b=Ii2kvMAY5e0uf7Ik7+2z2orRKnlQHFASSNY84i7Ng5vrVIStowlIbSQzKvNRaK992cIvIT
 IJC70oQXdde3okO/sRQ5seT8KsNi98ZvZOBS+zescXLKdli/XeMcyCwt+rUHO3cbeUdaFB
 6nS/lJJG1tN1s9ShG2PzMVDV/fTE01M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-aD7seDmpMxiHpmmk6xFplA-1; Tue, 07 Jan 2020 10:23:13 -0500
Received: by mail-wr1-f72.google.com with SMTP id j13so62699wrr.20
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 07:23:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/wc1xxXSPNaCZ+dYdazVsN00S+wbJbcYuMJ74BKeA2g=;
 b=bvdC0P7OMbmmPLWlbTaukkrkXueXN2H7njmFY0n9sfxZ/rhzuT5oT9SNt/ZXUnoxRP
 ZDiHw2BfY1yo2arG4Rw3q7L1ED8M4gDa7Bx/6hDCzBT1ZQQXZiTTxG0OMROFg7PCzaIF
 UZehBr8e48BLZhyYqJ5A2J9Ji1sVX3iV7s63FVgpYwnGxAaLzYW5qSwFXwW4RrdqvwSj
 XgFonWnXO6hF8Qs7AoozCFTHe7cYvD9ZeXku5Fw40/5DQTcYNa03MSKutd/X5tlBfcez
 rZqmM3dGdEQzCSjVNiov0uKoVADcMA0ahK/y1eEMlRYwNjxivCkz5yB2KqoVD5EwxpTC
 ssAQ==
X-Gm-Message-State: APjAAAXwqkL52i8Tpfk2pZGgoiyYeuDvq3iZ1WU9LQ0rN9PmYzj5tY+2
 qsXcZ8opYzA86/ThogPVt6zyrx4h9lZyOaIXcvSDvmIRk2XINQxzXnaO1sy5CF4knwvN4ex48N8
 pMAtn44DJJqU+pYs=
X-Received: by 2002:adf:f308:: with SMTP id i8mr49579816wro.42.1578410591988; 
 Tue, 07 Jan 2020 07:23:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqyoAFGs2BOpjY0uBeuBN7Yc7/c6alEMV8/94B6n+mL/HLVDW5sduo9VmBSvBDk/vaL1rnBQXA==
X-Received: by 2002:adf:f308:: with SMTP id i8mr49579799wro.42.1578410591769; 
 Tue, 07 Jan 2020 07:23:11 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c6d:4079:b74c:e329?
 ([2001:b07:6468:f312:c6d:4079:b74c:e329])
 by smtp.gmail.com with ESMTPSA id d10sm182760wrw.64.2020.01.07.07.23.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2020 07:23:11 -0800 (PST)
Subject: Re: [PATCH v2 00/14] chardev: Use QEMUChrEvent enum in IOEventHandler
 typedef
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20191218172009.8868-1-philmd@redhat.com>
 <CAMxuvayWibPU6_mEcYEqsWUhSRra33MvwPrbAYr254ZYaYKBgg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5b35d7f9-4590-2764-b48f-8d841c86fe3e@redhat.com>
Date: Tue, 7 Jan 2020 16:23:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAMxuvayWibPU6_mEcYEqsWUhSRra33MvwPrbAYr254ZYaYKBgg@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: aD7seDmpMxiHpmmk6xFplA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Burton <pburton@wavecomp.com>, Alberto Garcia <berto@igalia.com>,
 Li Zhijian <lizhijian@cn.fujitsu.com>, qemu-block <qemu-block@nongnu.org>,
 Zhang Chen <chen.zhang@intel.com>, Markus Armbruster <armbru@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>, Joel Stanley <joel@jms.id.au>,
 Laurent Vivier <lvivier@redhat.com>, Corey Minyard <minyard@acm.org>,
 Amit Shah <amit@kernel.org>, Alistair Francis <alistair@alistair23.me>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-s390x@nongnu.org,
 qemu-arm <qemu-arm@nongnu.org>, Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, qemu-riscv@nongnu.org,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>, Michael Walle <michael@walle.cc>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/12/19 14:32, Marc-Andr=C3=A9 Lureau wrote:
> On Wed, Dec 18, 2019 at 9:20 PM Philippe Mathieu-Daud=C3=A9
> <philmd@redhat.com> wrote:
>>
>> Hi,
>>
>> After this chat on #qemu IRC:
>> 13:20 <stsquad> so what is the difference between a IOReadHandler and IO=
EventHandler?
>> 13:25 <f4bug> stsquad: one is in-band and the other out-of-band?
>> 13:26 <stsquad> f4bug: ahh yes it seems so - connect/disconnect etc...
>> 13:27 <f4bug> see QEMUChrEvent for IOEventHandler
>>
>> I thought it might be a good opportunity to make the IOEventHandler
>> typedef meaning more obvious, by using the QEMUChrEvent enum.
>>
>> To be able to build I had to explicit all enums ignored in the
>> switch(event) statement by these frontends.
>>
>> Then I used a coccinelle spatch to change the various IOEventHandler.
>> I don't think the last patch can be split, but suggestions are welcome!
>>
>> Regards,
>>
>> Phil.
>>
>> v2:
>> - do blindly ignore all events using a 'default' case.
>>
>> Philippe Mathieu-Daud=C3=A9 (14):
>>   hw/ipmi: Remove unnecessary declarations
>>   hw/ipmi: Explicit we ignore some QEMUChrEvent in IOEventHandler
>>   hw/char/terminal3270: Explicit ignored QEMUChrEvent in IOEventHandler
>>   hw/usb/dev-serial: Explicit we ignore few QEMUChrEvent in IOEventHandl=
er
>>   hw/usb/redirect: Explicit we ignore few QEMUChrEvent in IOEventHandler
>>   ccid-card-passthru: Explicit we ignore QEMUChrEvent in IOEventHandler
>>   vhost-user-crypto: Explicit we ignore some QEMUChrEvent in IOEventHand=
ler
>>   vhost-user-net: Explicit we ignore few QEMUChrEvent in IOEventHandler
>>   vhost-user-blk: Explicit we ignore few QEMUChrEvent in IOEventHandler
>>   virtio-console: Explicit we ignore some QEMUChrEvent in IOEventHandler
>>   monitor/qmp: Explicit we ignore few QEMUChrEvent in IOEventHandler
>>   monitor/hmp: Explicit we ignore a QEMUChrEvent in IOEventHandler
>>   chardev/char: Explicit we ignore some QEMUChrEvent in IOEventHandler
>>   chardev: Use QEMUChrEvent enum in IOEventHandler typedef
>=20
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> (I guess Paolo will take the series for next PR?)

Yes, I'm queuing it.  I'll check Richard's remark before sending out the
pull request.

Paolo


