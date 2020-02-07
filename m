Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FABEC352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 11:30:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2272B20726
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 11:30:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2272B20726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j01py-0005RI-8n
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 06:30:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33633)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j01oB-0002mo-QH
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:28:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j01oA-0002rU-N1
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:28:27 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:56121)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1j01o8-0002f5-5a; Fri, 07 Feb 2020 06:28:24 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N0FE1-1jlgsF0k4d-00xGxG; Fri, 07 Feb 2020 12:28:20 +0100
Subject: Re: [PATCH] vl: Abort if multiple machines are registered as default
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200207110259.12544-1-philmd@redhat.com>
 <24bddc77-801e-ae63-dd1d-e06e3ac1cc03@vivier.eu>
 <078fbde9-3c93-b00a-2d53-34e65c7f56d9@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <c552dea1-821f-08bc-5f08-5bf6b5a70aa6@vivier.eu>
Date: Fri, 7 Feb 2020 12:28:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <078fbde9-3c93-b00a-2d53-34e65c7f56d9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:m/sVrcwrowOKmWjJpZjyTLHuMx41SR1LUBpMupkM36EPpHfin17
 /M3lLgTrWcnb3N29zZ1ImnmRmqbOpcpM3sF2EjHy52bXOP7O2q/1Xyh2oxhWZDsmCNcLoMo
 JmE69Qmu0nG2eNmXULYsoWRSWOrt4k037LGIL1aTQNT3axZ8FqU6f11PBLXF2r1nue1TDcW
 n8VxI7T2mcH/F5buWmhRg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XKUN1AvPv7E=:du3ZTQD7UBQ+JnzzAZ2PlW
 JMCUkzx2OybZRfomN0JzCYGRCSR+Vp19Mb18b9uCxHBjd9NIukBH9/EzuPg4HRc1w+ZbOfPNt
 WCO1CMBGeNXO9U0X2/sxilbtRZ8QEQBZpQYyvrCc5ats8EoUB58SWzPYsJcr7ji8+cE91KSeU
 mrfDxDx9zHHTPmxhHr1lYyhP/T75V8gHoGxg4e93DFs67Y2UN+hBaBQiPOJLIEme89aP7se9P
 JIeW23zf+om579TSWSSCp1HhXKL85/i/CbkCC0Clxsxm18XqwqVJjaKXKbSj452Oaw4BzLmk3
 3UW6anzRsQUxmfbAurf6flpYy6BzhBg8Dg8RW9yd2u7APgElwWYPTFmZBnr6QYH3ipUW+clvT
 WR56eocYvif1RT7sq341QG7o0hrkobDbBd31mFS7J6dk6IF6AuolzzToDfEpyJkrKPnE3MhVy
 RYcZ7tyergg4NobjN4pivfHgMxAtrmMF2cGKBvaH4XGO+ygiQlJps2R0qqrrfuDB6ioj3lTy+
 ILXx0wbO3JEOsNJjSVZWWmBq8gmZOHBpVqHoAR/Re6K6/NMxt/Xw4c5r7oinxvdbAGOuh3mKb
 zqgPX8TOC22VIq2JQQctBpkqFLuJkvyDTjx7v1DI59XVHiD2nGzajIE3t2pbFLQPzia8/yOn3
 LnxsXj4gtJUgDHnC3RAL7poW/HafcZBRbbTlOsTEmA+ZwsgnExi5IuR/OmorlIQCskaTIIGZi
 /JH32BJuVjui/b81XRILw/U0LBzkAXILpQQm3a5i+3zDqiY4GU/rwNa//OZUZUwdlNTrDuASh
 lnkNJUPIgYXfPgj4QdqICT/HPMEZnIHfrhVGYRUMR5Vg5KQu1kU1ZC/DOTDVG2gehClhUFA
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 07/02/2020 à 12:25, Philippe Mathieu-Daudé a écrit :
> On 2/7/20 12:08 PM, Laurent Vivier wrote:
>> Le 07/02/2020 à 12:02, Philippe Mathieu-Daudé a écrit :
>>> It would be confusing to have multiple default machines.
>>> Abort if this ever occurs.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>> ---
>>>   vl.c | 7 +++++++
>>>   1 file changed, 7 insertions(+)
>>>
>>> diff --git a/vl.c b/vl.c
>>> index 7dcb0879c4..da828188eb 100644
>>> --- a/vl.c
>>> +++ b/vl.c
>>> @@ -2354,6 +2354,8 @@ static MachineClass *machine_parse(const char
>>> *name, GSList *machines)
>>>       GSList *el;
>>>         if (is_help_option(name)) {
>>> +        int default_count = 0;
>>> +
>>>           printf("Supported machines are:\n");
>>>           machines = g_slist_sort(machines, machine_class_cmp);
>>>           for (el = machines; el; el = el->next) {
>>> @@ -2364,6 +2366,11 @@ static MachineClass *machine_parse(const char
>>> *name, GSList *machines)
>>>               printf("%-20s %s%s%s\n", mc->name, mc->desc,
>>>                      mc->is_default ? " (default)" : "",
>>>                      mc->deprecation_reason ? " (deprecated)" : "");
>>> +            default_count += !!mc->is_default;
>>> +        }
>>> +        if (default_count > 1) {
>>> +            error_printf("Multiple default machines available\n");
>>> +            abort();
>>>           }
>>>           exit(0);
>>>       }
>>>
>>
>> Does it really deserve an abort?
>> Ideal solution would be to be able to check this at build or in the unit
>> tests.
> 
> This is for developers, not for users. I'll use Marc-André suggestion
> and use an assertion.

I agree, but it's why it would be better if it is detected before it
comes to the user.

Perhaps you can add a test to run "qemu -h" to trigger the abort() early
in the develompment process (if it doesn't already exist).

Thanks,
Laurent
Thanks,
LAurent


