Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D18CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 10:25:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 458B72084C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 10:25:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 458B72084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMUs7-0002QO-7i
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 06:25:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42230)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iMUrM-0001oy-PP
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 06:24:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iMUrK-00087V-Bz
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 06:24:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60170)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iMUrK-000879-3K
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 06:24:18 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 850328665D
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 10:24:16 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id 92so1671173wro.14
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 03:24:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Y6lgkEMeo/P5YqhO22xBujs9RBLH4RZsExzcJGqQ9hg=;
 b=AgrmLG4lSlnLvpVq1A9mrdEJb4bpyv6zIRFUliYIilr2WFLvLcSqcXaW0avQ0VwcOC
 xJc+tSR30RYakzDBp9/GTwlPLay+fn/pie7GAtgtXhfk6edWyKzrG/i4lGHIkZr0gAT8
 zn3KMqAHKc4qmtl4rZ/Zi4T1QPosDWHO+2x+LhxbNv7GOc60VBD8C1TU5UraNrfMwp7G
 IEi5sW0sXOABAQ+GjJGol21xhAQ03GKniLNbpkAUVyBm4VEKqGDWlYfqzNH0Gxx++Aks
 EHqtYTjTOwzv2qQ2rbylIWbHmuwbiQE3HXwkw1ZY50h+mA8/B2SqfVbTU/yZbW1bmQtH
 digg==
X-Gm-Message-State: APjAAAXHHJeFWnGzcWpyTJharrs9hkjyyu1nn4gkzrtFR/x9p1iKCgeZ
 lZmb+RY8d9SYXAyXEhXoqLB1q4bIWP5Y7k8gXsxHnSJVTKy928uQv00Vyr4pDVn6IBgTcKvspvF
 Mqov2Wtfir1bdXFA=
X-Received: by 2002:adf:b1d1:: with SMTP id r17mr4572330wra.201.1571653455242; 
 Mon, 21 Oct 2019 03:24:15 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwJTPwc4mpVM+xxgKThg7eNCojrx8MRcIVimkqN/hF39WrM8mYrjjIIRc9pP4pm4WYLBK4GyA==
X-Received: by 2002:adf:b1d1:: with SMTP id r17mr4572271wra.201.1571653454929; 
 Mon, 21 Oct 2019 03:24:14 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id n205sm1642696wmf.22.2019.10.21.03.24.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2019 03:24:14 -0700 (PDT)
Subject: Re: [PATCH 12/21] hw/arm: Let the machine be the owner of the system
 memory
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20191020225650.3671-1-philmd@redhat.com>
 <20191020225650.3671-13-philmd@redhat.com>
 <CAFEAcA8bhP9X-2AaTus9=GtEAqmnNA9me6hv8U=vXYwjQp_CnA@mail.gmail.com>
 <42944bea-4b15-7bdf-61a7-f1c73f5f7c2b@redhat.com>
 <CAFEAcA8hJ7bQeQNdWB6Rg4P7RzYmcXZmQKm7pnDAOutADHe9jA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <20804096-7b34-9d79-1d93-fa9a31bbfd66@redhat.com>
Date: Mon, 21 Oct 2019 12:24:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8hJ7bQeQNdWB6Rg4P7RzYmcXZmQKm7pnDAOutADHe9jA@mail.gmail.com>
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
Cc: Paul Burton <pburton@wavecomp.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Leif Lindholm <leif.lindholm@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring <robh@kernel.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Helge Deller <deller@gmx.de>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Antony Pavlov <antonynpavlov@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Fabien Chouteau <chouteau@adacore.com>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Igor Mammedov <imammedo@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, patchew-devel@redhat.com,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, Andrew Jeffery <andrew@aj.id.au>,
 Michael Walle <michael@walle.cc>, qemu-ppc <qemu-ppc@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Peter Chubb <peter.chubb@nicta.com.au>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Paolo/David.

On 10/21/19 11:39 AM, Peter Maydell wrote:
> On Mon, 21 Oct 2019 at 10:34, Philippe Mathieu-Daud=C3=A9 <philmd@redha=
t.com> wrote:
>>
>> On 10/21/19 11:22 AM, Peter Maydell wrote:
>>> On Mon, 21 Oct 2019 at 00:01, Philippe Mathieu-Daud=C3=A9 <philmd@red=
hat.com> wrote:
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>> ---
>>>
>>>>    hw/arm/virt.c             | 2 +-
>>>
>>> I think from a quick code scan that this is ok, but did
>>> you test that migration compat from old to new still works?
>>> I vaguely recall that there are some cases when adding an
>>> owner to a memory region changes the name string used for
>>> identifying the ramblock in migration.
>>
>> It seems to still works:
>>
>> $ make check-qtest-aarch64 V=3D1
>=20
>> This test migrate the virt machine.
>>
>> Is this enough?
>=20
> No, you need to test migration from a QEMU binary without
> this patchset to a QEMU binary that has it. Otherwise you're
> only checking that the new version can migrate from itself
> to itself. I find the easiest way to test this is just to
> use the 'savevm' command to save a state snapshot to a
> qcow2 disk image while running the old binary, and then run
> 'loadvm' with the new binary and check it restored OK.

I did not think if this case.

I followed your blog post [*] and tested the migration works OK.

Paolo, now thinking about regular testing, we should add this testing to=20
patchew too. Something like:

- when mainstream/master is updated, patchew build QEMU (it should be=20
already mostly ccached) and generate some vm dumps with 'savevm'.

- build/test the series

- if series succeeded testing, run 'loadvm' tests

[*]=20
https://translatedcode.wordpress.com/2015/07/06/tricks-for-debugging-qemu=
-savevm-snapshots/

