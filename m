Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2446EC4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 11:03:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E71F121907
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 11:03:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E71F121907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAXkH-0002wR-P5
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 07:03:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41044)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iAXjU-0002PD-6O
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 07:02:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iAXjS-0008T7-7v
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 07:02:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53816)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iAXjQ-0008Rm-4C
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 07:02:46 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 041C3A76C
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 11:02:42 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id n18so2215507wro.11
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 04:02:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gHdWLwCXa8giKUcaWTpuV9jRKKWtJHijtV9wbrDNHS8=;
 b=gt7RJlL+VYQttehZ0Qphq/sqQ7fUNaovBKGTrpbqgPcaZUGBTRDPztyYFgMoJ1vde+
 OYO6nDPwFemOZGn91s82ZlP7QnvVx/z13H384lXlDlHGBmAiGVj9YicIu+I7K11K4CPx
 yEgsahbhKDXjX/QKgxHraa7yjLXmBpBZ3qWtL+yuolcymalgwyWL85pNBDmeUHptsrDj
 nd3Mw4cuvx0B0TynYdZqTbiXwpRj5BlI9sP++xu288IUe9Q2xvrA7B4UTu2bpLfgThqt
 V3PYwNRN/Vrb6ebJOeycm+brdsPBj2WdIoYsi9848ddXel1cjYtD2/9jrLm+7M+6I/sh
 KDyQ==
X-Gm-Message-State: APjAAAXt6298n3i4c/vXsMGVbLHssypfbf/FkP1LPjM5PegpfxJ69HA6
 jdEqWWBwZWC7tnqjSlq+w5mNogP1Lsy87smgd41qp2v9U/gw7gNNLTu1ZnIHvaLVtIt+cocqvvo
 PtSaxrAlz/Nu3ktw=
X-Received: by 2002:a05:600c:1089:: with SMTP id
 e9mr2416814wmd.176.1568804561513; 
 Wed, 18 Sep 2019 04:02:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzdml/t4E5tYOUnnGk7RXefPdDN5+rfmhEUGw4CQHZ3x8FYEXj9Ym+A+rcTViFoAdeXIpN5fg==
X-Received: by 2002:a05:600c:1089:: with SMTP id
 e9mr2416775wmd.176.1568804561200; 
 Wed, 18 Sep 2019 04:02:41 -0700 (PDT)
Received: from [10.201.33.84] ([195.166.127.210])
 by smtp.gmail.com with ESMTPSA id v7sm5031761wru.87.2019.09.18.04.02.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Sep 2019 04:02:40 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20190916154847.28936-1-philmd@redhat.com>
 <20190916154847.28936-4-philmd@redhat.com>
 <c5caa155-19d3-1b22-ea61-d8c17dca39e7@redhat.com>
 <6f9f0932-5420-c67f-b6f7-2a7ceb4e99a4@redhat.com>
 <24d0eebd-5bb2-8da9-d6e6-4a5938b0f6cc@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <75b7c726-d677-59f9-34d7-2d8f1f5f2f6b@redhat.com>
Date: Wed, 18 Sep 2019 13:02:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <24d0eebd-5bb2-8da9-d6e6-4a5938b0f6cc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 03/13] hw: Move MC146818 device from
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
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
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

On 9/18/19 9:43 AM, Thomas Huth wrote:
> On 17/09/2019 12.03, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 9/17/19 7:07 AM, Thomas Huth wrote:
>>> On 16/09/2019 17.48, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> The MC146818 is a Real Time Clock, not a timer.
>>>> Move it under the hw/rtc/ subdirectory.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> [...]
>>>> diff --git a/include/hw/rtc/mc146818rtc.h b/include/hw/rtc/mc146818r=
tc.h
>>>> new file mode 100644
>>>> index 0000000000..888e04f9ab
>>>> --- /dev/null
>>>> +++ b/include/hw/rtc/mc146818rtc.h
>>>> @@ -0,0 +1,38 @@
>>>> +/*
>>>> + * QEMU MC146818 RTC emulation
>>>> + *
>>>> + * Copyright (c) 2003-2004 Fabrice Bellard
>>>> + *
>>>> + * Permission is hereby granted, free of charge, to any person obta=
ining a copy
>>>> + * of this software and associated documentation files (the "Softwa=
re"), to deal
>>>> + * in the Software without restriction, including without limitatio=
n the rights
>>>> + * to use, copy, modify, merge, publish, distribute, sublicense, an=
d/or sell
>>>> + * copies of the Software, and to permit persons to whom the Softwa=
re is
>>>> + * furnished to do so, subject to the following conditions:
>>>> + *
>>>> + * The above copyright notice and this permission notice shall be i=
ncluded in
>>>> + * all copies or substantial portions of the Software.
>>>> + *
>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, =
EXPRESS OR
>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANT=
ABILITY,
>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVEN=
T SHALL
>>>> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGE=
S OR OTHER
>>>> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, =
ARISING FROM,
>>>> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DE=
ALINGS IN
>>>> + * THE SOFTWARE.
>>>> + */
>>>
>>> If you run "git blame" on the old header file, it does not seem like
>>> Fabrice wrote this header, so I'm not sure whether it makes sense to =
add
>>> his (c) statement here?
>>>
>>> Maybe rather use a one-line "SPDX-License-Identifier: GPL-2.0-or-late=
r"
>>> here?
>>
>> It was first added by Fabrice here:
>>
>> $ git show 80cabfad163
> [...]
>> diff --git a/vl.h b/vl.h
>> index 35962d1985..026a5dee5a 100644
>> --- a/vl.h
>> +++ b/vl.h
>> +/* mc146818rtc.c */
>> +
>> +typedef struct RTCState {
>> +    uint8_t cmos_data[128];
>> +    uint8_t cmos_index;
>> +    int irq;
>> +} RTCState;
>> +
>> +extern RTCState rtc_state;
>> +
>> +void rtc_init(int base, int irq);
>> +void rtc_timer(void);
>=20
> Ok, fair. But vl.h had a slightly different copyright statement than
> vl.c, so I think you should rather use the one from vl.h.
> But IMHO you could at least drop the "THE SOFTWARE IS PROVIDED ..."
> paragraph and add a SPDX tag instead?

I find SPDX tags clearer too, but last time I wanted to use them Peter sa=
id:

  I think we should not do that until/unless
  somebody (probably a corporate somebody) steps forward
  to make the argument for "this is why we should have them,
  we as a contributor to the project think they are worthwhile
  and a useful feature for us, and we will make the effort to
  add them, review that they are correct, update checkpatch to
  insist on tags for new files, etc". In other words, "if it
  ain't broke, don't fix it"; nobody is yet complaining that
  our current setup is broken.

https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg04151.html

At this time we had less:

$ git grep SPDX v3.1.0 | egrep -v linux-headers | wc -l
21

Since we few entered, so we have a mix:

$ git grep SPDX origin/master | egrep -v linux-headers | wc -l
79

