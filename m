Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CF9C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:47:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0E70206B1
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="lSyiNKB/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E70206B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC2da-0000F7-8w
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 10:47:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49159)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jC2cq-0007Sp-Vl
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 10:46:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jC2cp-00010B-OF
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 10:46:24 -0400
Received: from mail-db8eur05on2124.outbound.protection.outlook.com
 ([40.107.20.124]:1441 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jC2cj-0000we-Lv; Wed, 11 Mar 2020 10:46:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cly4sW/UavUu6zX/E6LdneGvvGT4X3GRCZxdhMQv5f2t5WqwG2UHz6BBmRDVtmIwq7olCJxgdy+n8GOHxjP1I3LRV7s6CxAtL1MIS3+uIsswYrp+BOjHBXvjESY+Lm3nDbXayd/PT0ygWjbbl5bdTSRndhQULOzvmkpmdxIrTZO8ww8O71mWuaNRI624qBKO9jQPODoCyBgKVGo2Mo/9EYSzfFDqEKvA0WEmBe8moIa7B2HWqeL+uzSwr6trAE6YajH38/0rFa+pg6w49yJOQ2yMkevSKkasjXbVFsB7dhBpxKJ9tTUOiil/0sDd1SIAmltYiboBiuvtggRd1eSAsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzSVwZC4T7EmlDuBOo+cCzHoP3zUSdHBA1XijoS2cBs=;
 b=DVMwxc2zrYXekN3dXIuwYysFPW1khmFwC1MjXlUXlABbT6TbI28zFVbKwFlj8b3sKvKUet8S+/3YEN0e5fINmWKjCopCGmWRfwCTfBeBlgEBQAiRT9+Iah4kcALnTszkTfVP00BMrKusYj6abZrreLQxWPk0YYyjulPf77fqUIatstmHF8Pod5lkAUxwZzByb4HDqLeOyLl4mfJAS9E7BPi0fuKvIWnEJMLvRUZ3v4yBT5M9kpGRMUdf49/wpWeuGrHgtnVXpBaH7D9X40Q01TTDfOASAitLJdK+HSEDYRRudxkXoMtmV9RVfwBEHiLY5IOmM34UboAWB3iXjFbBLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzSVwZC4T7EmlDuBOo+cCzHoP3zUSdHBA1XijoS2cBs=;
 b=lSyiNKB/trOfLFPIWO/miRIcuuQypRd1/HLf5Zo4b5ywc/e/8sWRLEYQq3b+XhFQzcpyCjxCbDNx0poRu++tzoJQdGjnpU4PzEr7ntoH3FW9qhHNgz6JC2m+XfiHYpqMIFTRkNRYEnjZXspkoVgqApiEXOMTo6hzkbyeJ1KWzXs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4214.eurprd08.prod.outlook.com (20.178.91.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Wed, 11 Mar 2020 14:46:14 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2814.007; Wed, 11 Mar 2020
 14:46:14 +0000
Subject: Re: [PATCH v8 02/10] scripts: add coccinelle script to use auto
 propagated errp
To: Markus Armbruster <armbru@redhat.com>
References: <20200306051536.27803-1-vsementsov@virtuozzo.com>
 <20200306051536.27803-3-vsementsov@virtuozzo.com>
 <87lfo997hs.fsf@dusky.pond.sub.org>
 <fda76f8a-bb62-d867-d7b4-7cf8caf0489e@virtuozzo.com>
 <87a74ngriw.fsf@dusky.pond.sub.org>
 <71ada30b-c72b-6251-cc38-877ddd4156a8@virtuozzo.com>
 <87h7yvx8ce.fsf@dusky.pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200311174610793
Message-ID: <a16e5dee-7f2b-236d-1e71-f40c75cb5902@virtuozzo.com>
Date: Wed, 11 Mar 2020 17:46:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <87h7yvx8ce.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0701CA0054.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::22) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0701CA0054.eurprd07.prod.outlook.com (2603:10a6:3:9e::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.9 via Frontend Transport; Wed, 11 Mar 2020 14:46:12 +0000
X-Tagtoolbar-Keys: D20200311174610793
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5f4e7e4-c8ce-474d-94c0-08d7c5caf2a6
X-MS-TrafficTypeDiagnostic: AM6PR08MB4214:
X-Microsoft-Antispam-PRVS: <AM6PR08MB4214DD13A05AF2526FA4F2B9C1FC0@AM6PR08MB4214.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(39850400004)(396003)(346002)(136003)(366004)(376002)(199004)(36756003)(186003)(7416002)(6916009)(66476007)(16526019)(31686004)(66556008)(6486002)(52116002)(478600001)(86362001)(5660300002)(316002)(8676002)(81156014)(16576012)(81166006)(4326008)(8936002)(31696002)(66946007)(54906003)(2906002)(26005)(2616005)(956004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4214;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J2zTuep/AHJIOjfHrqer4fxCsWxiQ7YOHUrYGyPHrhqlOc8TCwPnexfa8/WdSx18co9yz/DD2z/UHBS1CvXWXyZcS4ARMRUXcnAPMu/wibI0riKmv/fRZ192BtqTsoK6g6K/CkOf5sU4CBAJg3bA7vwXDadnIXZjlbDuSSELsZhVfb0OkuSZDHPTKrkuu5cRUSgI4tOMXwooUDU30VQj8hw/KX89nc6DrP5n1Mwgs+XHKDyNSOZeqWQLgeea9Vhf9L4i5ePMYp+BUKkIiDGKdTXmhuYBKjxeoulnpHG7WcgDv3OYalQiPNIi8/8DLbrbFNlcDObbRPCqzULL8OiBLEJwL1+Vn4DeePIfSPoOFKiY4gkuO5PBLX0+XEQIHmql8JiNSVvYeSfMWNzkuoAxyWOV+YivQ364SsuAeluKt5uhemS3/YbaELj3qr4zCe3d
X-MS-Exchange-AntiSpam-MessageData: S8dVByeqhjFM3z/2VGfKa4JS4WWy/kBaP0rOVzDZIENZpVyXtTnoyEzfpyjr5gsCFGiqz2KEQpdHYZ1IvWVc+jR2y06eqDoeYj8VZO9UUo+xauqwd2NowVxuDG8OHhqX/CyIgvOW1jtinEHWo7Erkw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f4e7e4-c8ce-474d-94c0-08d7c5caf2a6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 14:46:14.6270 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VIKVCGpz21JajaEgVDqpXdbU9ee5DzzdXR9txbo49z72IUtz/KR44HK4XNK0FP46RN1mgeKgg3HFsYKwHnijxbHkRIyXN411CmKMfCIn8Uw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4214
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.20.124
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 qemu-block@nongnu.org, Paul Durrant <paul@xen.org>,
 Laszlo Ersek <lersek@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

11.03.2020 17:41, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
> 
>> 11.03.2020 12:38, Markus Armbruster wrote:
>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>>
>>>> 09.03.2020 12:56, Markus Armbruster wrote:
>>>>> Suggest
>>>>>
>>>>>        scripts: Coccinelle script to use auto-propagated errp
>>>>>
>>>>> or
>>>>>
>>>>>        scripts: Coccinelle script to use ERRP_AUTO_PROPAGATE()
>>>>>
>>>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>> [...]
>>>>>> +// Note, that we update everything related to matched by rule1 function name
>>>>>> +// and local_err name. We may match something not related to the pattern
>>>>>> +// matched by rule1. For example, local_err may be defined with the same name
>>>>>> +// in different blocks inside one function, and in one block follow the
>>>>>> +// propagation pattern and in other block doesn't. Or we may have several
>>>>>> +// functions with the same name (for different configurations).
>>>>>
>>>>> Context: rule1 matches functions that have all three of
>>>>>
>>>>> * an Error **errp parameter
>>>>>
>>>>> * an Error *local_err = NULL variable declaration
>>>>>
>>>>> * an error_propagate(errp, local_err) or error_propagate_prepend(errp,
>>>>>      local_err, ...) expression, where @errp is the parameter and
>>>>>      @local_err is the variable.
>>>>>
>>>>> If I understand you correctly, you're pointing out two potential issues:
>>>>>
>>>>> 1. This rule can match functions rule1 does not match if there is
>>>>> another function with the same name that rule1 does match.
>>>>>
>>>>> 2. This rule matches in the entire function matched by rule1, even when
>>>>> parts of that function use a different @errp or @local_err.
>>>>>
>>>>> I figure these apply to all rules with identifier rule1.fn, not just
>>>>> this one.  Correct?
>>>>>
>>>>> Regarding 1.  There must be a better way to chain rules together, but I
>>>>> don't know it.
>>>>
>>>> Hmm, what about something like this:
>>>>
>>>> @rule1 disable optional_qualifier exists@
>>>> identifier fn, local_err;
>>>> symbol errp;
>>>> @@
>>>>
>>>>    fn(..., Error **
>>>> - errp
>>>> + ___errp_coccinelle_updating___
>>>>       , ...)
>>>>    {
>>>>        ...
>>>>        Error *local_err = NULL;
>>>>        ...
>>>> (
>>>>       error_propagate_prepend(errp, local_err, ...);
>>>> |
>>>>       error_propagate(errp, local_err);
>>>> )
>>>>        ...
>>>>    }
>>>>
>>>>
>>>> [..]
>>>>
>>>> match symbol ___errp_coccinelle_updating___ in following rules in function header
>>>>
>>>> [..]
>>>>
>>>>
>>>> @ disable optional_qualifier@
>>>> identifier fn, local_err;
>>>> symbol errp;
>>>> @@
>>>>
>>>>    fn(..., Error **
>>>> - ___errp_coccinelle_updating___
>>>> + errp
>>>>       , ...)
>>>>    {
>>>>        ...
>>>>    }
>>>>
>>>>
>>>> - hacky, but seems not more hacky than python detection, and should work better
>>>
>>> As simple, forceful and unsubtle as a sledgehammer.  I like it :)
>>>
>>
>>
>> Hmm, not so simple.
>>
>> It leads to reindenting of function header, which is bad.
> 
> Because ___errp_coccinelle_updating___ is longer than errp, I guess.
> Try ____?

I'm afraid not. It's because it just adds \n, when I do

...,

- errp
+ ___errp_coccinelle_updating___
,...

> 
>> Possible solution is instead
>>
>> fn(...)
>> {
>> +   ___errp_coccinelle_updating___();
>>
>>
>> but this slow down coccinelle. For example, on block.c from ~3s to 1m16s.
>>
>> .
>>
>> So, I'm returning to just a warning.
>>
>> I think something simple like
>>
>> @@
>> identifier rule1.fn;
>> position p != rule1.p;
>> @@
>>
>> fn@p(...) {...}
>>
>> @ script:python@
>>
>> <print warning>
>>
>> should work.
> 
> Up to you.
> 


-- 
Best regards,
Vladimir

