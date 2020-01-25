Return-Path: <SRS0=4gpF=3O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5EBC2D0DB
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2020 11:42:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5E1920704
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2020 11:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ARr/5GcE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5E1920704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ivJpf-0003mF-U0
	for qemu-devel@archiver.kernel.org; Sat, 25 Jan 2020 06:42:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38012)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ivJom-0003Hp-IJ
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 06:41:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ivJoj-0002FU-RF
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 06:41:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43107
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ivJoi-0002Et-7s
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 06:41:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579952491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NBCE0qHxOHV+K+c1qdN1ilL9bRBWFVrH/agqd53OwnA=;
 b=ARr/5GcEN/BqpycSxGhPJDtS1Sq0+pMQ2AJO3/k921jJFXHeCuD3tQ1EqSi1sYJ6jEzO6O
 WBho6nQ2TGAZMhWi1legUvk5V4azW6BnulXQIK2Bv077bJ5PPjMVxDrt3CelwiYlYlDofu
 LKVET3/0boc7Ap/kwVTC3cJewzTFH14=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-MMUuBsNoMSaoW06M-ArBMA-1; Sat, 25 Jan 2020 06:41:26 -0500
Received: by mail-wr1-f69.google.com with SMTP id f17so2870097wrt.19
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2020 03:41:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Y14rjtHFKuA6vTOF7YNJNB7hhvbjBFL6kau3aTrVa+Y=;
 b=SaHovFT7JkX5ZcBrOXRPLVUsIfyU7Tq7zHNf47MVklO+qaxlZHBUYOdp5Dk+A5Fo9Y
 n2OiSUTD5aVJ75g6R5a/GbjFiH+7KtQmoQni5im8FHNtehCW2ja/JwqDTXcxrM6dvaP1
 txYpeV/BnL4kw83vfDlEsgibfWRj0MIblfmpUbSn8V5iJ8jINatO253w3oXB+zSQK1tL
 GXv50mEQnAd+pHjrpcwlQdxhxBcqdApRDm3B9NHrkCqoIbfeS2hVCl11hNi2sfc1aqqs
 o5QTbf5VEVs0W0ZtV/Xis7f6h5eqgQqq2cX/TVVq/pvqmgHXEgsKAtfdwc3hb2j0oIqp
 z81g==
X-Gm-Message-State: APjAAAX4/OJhE7e5cH3EsB+m5p4HUTVV/ge+VLlPsByEiACvPCfz/Pp3
 HyyQKvyb5hmCA6cgImysYDUN46j8CCmfGNQsFixXf+KJnF8wn4dAIdggT96y3R2+FM/iAKMTUQQ
 rmTKX5vGpu5VB+t4=
X-Received: by 2002:adf:fe90:: with SMTP id l16mr10032562wrr.265.1579952485185; 
 Sat, 25 Jan 2020 03:41:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqzN7P/+t7B+VB2dYPfbOML80LykAuTC/BydrlY4oqWhyTC+79p/BMmxGhjmOUNfnW4729wu2g==
X-Received: by 2002:adf:fe90:: with SMTP id l16mr10032532wrr.265.1579952484918; 
 Sat, 25 Jan 2020 03:41:24 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:784d:f09c:63f4:b9cb?
 ([2001:b07:6468:f312:784d:f09c:63f4:b9cb])
 by smtp.gmail.com with ESMTPSA id c5sm10840053wmb.9.2020.01.25.03.41.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Jan 2020 03:41:24 -0800 (PST)
Subject: Re: Making QEMU easier for management tools and applications
To: Stefan Hajnoczi <stefanha@gmail.com>,
 Kashyap Chamarthy <kchamart@redhat.com>
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <87h81unja8.fsf@dusky.pond.sub.org>
 <20200102144722.GL121208@stefanha-x1.localdomain>
 <20200116110314.GA24159@paraplu>
 <20200120095554.GA345995@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <89636ffa-712d-a163-538f-c1db8ad1467c@redhat.com>
Date: Sat, 25 Jan 2020 12:41:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200120095554.GA345995@stefanha-x1.localdomain>
Content-Language: en-US
X-MC-Unique: MMUuBsNoMSaoW06M-ArBMA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>, John Snow <jsnow@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/01/20 10:55, Stefan Hajnoczi wrote:
>>
>> [1] https://qemu.readthedocs.io/en/latest/interop/live-block-operations.=
html
> John and I discussed async events in the past.  qmp-shell currently uses
> the input() built-in function.  If we modify it with a
> select(2)/poll(2)-style function that monitors both stdin and the QMP
> socket then it could print QMP events as soon as they are received.

I think it should be rewritten using async/await.  A simple example:

    import asyncio
    import sys
    from concurrent.futures import ThreadPoolExecutor

    async def ainput(prompt: str =3D ""):
        with ThreadPoolExecutor(1, "ainput") as executor:
            return (await asyncio.get_event_loop().run_in_executor(
                executor, sys.stdin.readline
            )).rstrip()

    async def numbers():
        i =3D 1
        while True:
            print(i)
            i =3D i + 1
            await asyncio.sleep(1)

    async def main():
        name =3D await ainput("What's your name? ")
        print("Hello, {}!".format(name))

    asyncio.get_event_loop().create_task(numbers())
    asyncio.get_event_loop().run_until_complete(main())

This would be a great Summer of Code project.  Even an autocompletion
interface using readline should be possible.

Paolo


