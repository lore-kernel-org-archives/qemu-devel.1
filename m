Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0308EC4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 10:09:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB2F821852
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 10:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB2F821852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAAQd-00022R-U4
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 06:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41664)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iAAPO-0000tM-MP
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:08:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iAAPN-0005yn-BC
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:08:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34364)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iAAPN-0005yQ-2Z
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:08:29 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 089BA8553D
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 10:08:28 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id t185so662065wmg.4
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 03:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Fd6mmlQAZKPTTxeuK9yalfHsfMzT+EjHiGe/wbHjyA0=;
 b=H/VuSBlEWixraMSPQb+0hAmTt52KtcM9t3xTU08+wCCPcKVfagjikicTkRpSo3Grrg
 zhfheHv7U5XjvexC4rpZjEI6HPVut0qxpZz3J3UayH1IgTx4751uYimH1XYM96haLM9Q
 0l1B19UU/vC2cicnKuz00jYQb2xUTM5DVCkuZcX6v+PlVo9LM0UrrH/pMmI4xGQxw/Iu
 qFLwfgXxhb01NyCE4H9x4Vbxy3v+tGSZJImTMOeDYkc3WRUe9UWfcbxzLYXMihKORLKv
 EroI+wXGJpKTiukzoOEfkv2laf2BpEEWc4Z6Ab6GjI0HKa/tQAgYoSN5IT0Ccl5lWcq+
 sKQw==
X-Gm-Message-State: APjAAAXNWF6IAOxpQQG7TsOJMNZnZqTC+8NeHm+P9rIxv5hGFocq3MNR
 6SBNhz8VyAW3pCF0ZFt2HFO641e1jYErRQ/+rpLrDdPGdZJCvzujSZsOrYer0OA7WpKdPfqXabD
 6Coaxf47QcTsKHLA=
X-Received: by 2002:adf:828d:: with SMTP id 13mr2340452wrc.115.1568714906763; 
 Tue, 17 Sep 2019 03:08:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw0poWG+FDW8vuLaYyiMFGWNQk8uFPGDlQqrk80Yup07b6YWHEKOCBaGvefe5nOHme1s2lP/w==
X-Received: by 2002:adf:828d:: with SMTP id 13mr2340422wrc.115.1568714906540; 
 Tue, 17 Sep 2019 03:08:26 -0700 (PDT)
Received: from [192.168.1.40] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id j1sm2572597wrg.24.2019.09.17.03.08.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Sep 2019 03:08:25 -0700 (PDT)
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190916154847.28936-1-philmd@redhat.com>
 <20190916154847.28936-5-philmd@redhat.com>
 <20190917022510.GD8842@umbus.fritz.box>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <790ba518-e906-6c3b-1280-25f005c9768a@redhat.com>
Date: Tue, 17 Sep 2019 12:08:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190917022510.GD8842@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 04/13] hw: Move M48T59 device from
 hw/timer/ to hw/rtc/ subdirectory
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
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Andrew Jeffery <andrew@aj.id.au>, qemu-ppc@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/17/19 4:25 AM, David Gibson wrote:
> On Mon, Sep 16, 2019 at 05:48:38PM +0200, Philippe Mathieu-Daud=E9 wrot=
e:
>> The M48T59 is a Real Time Clock, not a timer.
>> Move it under the hw/rtc/ subdirectory.
>>
>> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
>> ---
>>  MAINTAINERS                         |  4 +-
>>  hw/ppc/ppc405_boards.c              |  2 +-
>>  hw/ppc/prep.c                       |  2 +-
>>  hw/rtc/Kconfig                      |  3 ++
>>  hw/rtc/Makefile.objs                |  4 ++
>>  hw/{timer =3D> rtc}/m48t59-internal.h |  0
>>  hw/{timer =3D> rtc}/m48t59-isa.c      |  4 +-
>>  hw/{timer =3D> rtc}/m48t59.c          |  2 +-
>>  hw/sparc/sun4m.c                    |  2 +-
>>  hw/sparc64/sun4u.c                  |  2 +-
>>  hw/timer/Kconfig                    |  3 --
>>  hw/timer/Makefile.objs              |  4 --
>>  include/hw/rtc/m48t59.h             | 57 ++++++++++++++++++++++++++++=
+
>=20
> Uh.. this file seems to be coming out of nowhere, which doesn't seem
> right for a code motion.

Good catch!

>=20
>>  13 files changed, 73 insertions(+), 16 deletions(-)
>>  rename hw/{timer =3D> rtc}/m48t59-internal.h (100%)
>>  rename hw/{timer =3D> rtc}/m48t59-isa.c (98%)
>>  rename hw/{timer =3D> rtc}/m48t59.c (99%)
>>  create mode 100644 include/hw/rtc/m48t59.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 481f2318cb..679b026fe0 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1064,9 +1064,9 @@ F: hw/pci-host/prep.[hc]
>>  F: hw/isa/i82378.c
>>  F: hw/isa/pc87312.c
>>  F: hw/dma/i82374.c
>> -F: hw/timer/m48t59-isa.c
>> +F: hw/rtc/m48t59-isa.c
>>  F: include/hw/isa/pc87312.h
>> -F: include/hw/timer/m48t59.h
>> +F: include/hw/rtc/m48t59.h
[...]

Not sure how I ended not removing include/hw/timer/m48t59.h, since I
used 'git mv' in all the series. I might have missed a conflict when
switching between branches...
Ah I now remember, I had to rebase after Markus big header cleanup, this
is probably when I messed with this one :)

