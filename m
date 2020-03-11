Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A794C18E5A
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:15:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62D1E206B7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Tjw+yfuI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62D1E206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC29F-0004EK-IZ
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 10:15:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40385)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jC1zM-0003uh-Iy
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 10:05:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jC1zL-0005ER-9d
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 10:05:36 -0400
Received: from mail-eopbgr60091.outbound.protection.outlook.com
 ([40.107.6.91]:62118 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jC1zI-0005C9-4v; Wed, 11 Mar 2020 10:05:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxdtm9Le83LHq6H58vka0f8z+Wur4dmNtBxdvKIV/A0/a2iOIzUKkjNaPIViJOkuMwJWJtnqR9e+QCd05AtSj3h0+wPqz0DGwBOrfX1APNi+1w4P59XpSfLpWUJs9OQvtIHhqm6vyrcKyaOZ5Chkb0QyouzC7RNH51uFwApgMoJrMYECgeU1s91XVGH3TfuB4xDgvoBKUgQtCXNoe4x0xKU6SxCisV6v+QuBxoSJEI2VPBxJY+NWMLTJgbQHmfwoqArrVQiFA3bt2tyo+MpJqi/qTjO72lvyii03Xuzrxszr1JR5qGP0HULmIDkF/vSvDcK8CPODDah7HVRZiwr9AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdNWddZboibVKNd6sn2CayHx7QjB6YmjHdswUZOo4qk=;
 b=Mo+esbpCcRIT20dhe6enwgozX2paiz8OtONsklj14/Fhb51ZzZgae0xX5iKyLBcRYvSEJmiMMU2N8gw4gLy04bAjBx6tuREKjlE4O7yqMV0bWutd6OvjexxPCCOoV06myo3RVPL3QsjHZWvwCeYpgKBdCvnBjmGn1uiVdiBcPuobFN9HVa1AfIAddh+s/nPPNMURAHaU0yu8B8EwvCybWXg+LRBjjQa/pEuVBhAqs23msst+bVLG6lvPcBotfLmj8qyJ5St6b23zTlrJl6rJpHhp8zz5Gz/jQMr/NjvAfVSL2V5HnHwnuisI8ZtTcyByIAxhypSxM/9yaOOgyGJ3cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdNWddZboibVKNd6sn2CayHx7QjB6YmjHdswUZOo4qk=;
 b=Tjw+yfuI9KHtAFxvwn+UJfluBtOPcddikgnse5cWgxihOoeds0AS2RnsqfAvQ5BlHYd7kcgMiBqakyZ9lO/+N8hPMsUoGmGbV0oTKE/WMkKxbjm1SfzUWKZxfmWVd7zwbFcBVblqB7Oi0YaQE5Qg0FzdALJxmO5yUBt6p3pL4sg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3253.eurprd08.prod.outlook.com (52.135.165.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Wed, 11 Mar 2020 14:05:28 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2814.007; Wed, 11 Mar 2020
 14:05:28 +0000
Subject: Re: [PATCH v8 02/10] scripts: add coccinelle script to use auto
 propagated errp
To: Markus Armbruster <armbru@redhat.com>
References: <20200306051536.27803-1-vsementsov@virtuozzo.com>
 <20200306051536.27803-3-vsementsov@virtuozzo.com>
 <87lfo997hs.fsf@dusky.pond.sub.org>
 <fda76f8a-bb62-d867-d7b4-7cf8caf0489e@virtuozzo.com>
 <87a74ngriw.fsf@dusky.pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200311170524320
Message-ID: <71ada30b-c72b-6251-cc38-877ddd4156a8@virtuozzo.com>
Date: Wed, 11 Mar 2020 17:05:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <87a74ngriw.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0802CA0021.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::31) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0802CA0021.eurprd08.prod.outlook.com (2603:10a6:3:bd::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.16 via Frontend Transport; Wed, 11 Mar 2020 14:05:26 +0000
X-Tagtoolbar-Keys: D20200311170524320
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d81d41d6-9a70-47f0-acb9-08d7c5c540ca
X-MS-TrafficTypeDiagnostic: AM6PR08MB3253:
X-Microsoft-Antispam-PRVS: <AM6PR08MB32536A60B1FE5EB6600AC378C1FC0@AM6PR08MB3253.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(39850400004)(136003)(366004)(346002)(396003)(376002)(199004)(54906003)(81156014)(81166006)(2906002)(36756003)(316002)(52116002)(16576012)(8676002)(5660300002)(956004)(6486002)(8936002)(66946007)(66556008)(4326008)(31686004)(66476007)(478600001)(7416002)(86362001)(26005)(186003)(2616005)(6916009)(31696002)(16526019);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3253;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jCWf3SSKGYw8HEtN9IGSa4I2QxkAi9X7uYWBBIwmSSQR2ALNnM6nLmXwlv4D9g8lKOOU8XvIRHt3YV9f7pX3CGjHQKzrpVICKKu9s++IGB8YnC8R2VKNCwI1cEhMjcDFxs7eCy93tt0FBEf8PqDzidkqtnnTIa7dD0USvXD2FiumQicj/j/sMjalKipHXEsPHJ3Qu19a005pbV1jqAPmHAcnZ22kxf/LPSqoJdUuPcMo2O6kVp60Q/7efRt92od0HkFjIO/1LIuFBfT0hGZVx6tp43PV92/0ArmA9tpbxm9kWy+zlCwA4ZhEwo7+FRsQlh7VwC5ITwRX8A8gaJ/ssPfty7T2DyVBOdIuKfjvpz51rk5QXynJaThXpmnzIxpRjIki2vO1gfN8YFbcEKrJUqRJ+IVLZ8pLCrtjS0BFjhHIouaIl0Y1o+UOprMMFEPq
X-MS-Exchange-AntiSpam-MessageData: DmADZP0MdiY4aIo9RrpvTooL8VYa94lr4hAHU5cgf/NQgbCgbGpyrSPZDJz4EnGOj6QUWhCveXpcgSDh3talH5/f65F++KxFkZRnrRgyBn5ZVj7w3uBLN22i2ktIFm1Q3/c7YeVNrdWlQxAdnNWh6Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d81d41d6-9a70-47f0-acb9-08d7c5c540ca
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 14:05:28.4177 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v48qwGu3nrzx1/lRhYWp/LltieU+A8XPZXiApWvPGjLecQC33UuRjCytUu/JW5kR5cWaY0FiN46D8vIgtf2dfcNg6KMRmTriyOm3IHwZsDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3253
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.91
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
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

11.03.2020 12:38, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
> 
>> 09.03.2020 12:56, Markus Armbruster wrote:
>>> Suggest
>>>
>>>       scripts: Coccinelle script to use auto-propagated errp
>>>
>>> or
>>>
>>>       scripts: Coccinelle script to use ERRP_AUTO_PROPAGATE()
>>>
>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
> [...]
>>>> +// Note, that we update everything related to matched by rule1 function name
>>>> +// and local_err name. We may match something not related to the pattern
>>>> +// matched by rule1. For example, local_err may be defined with the same name
>>>> +// in different blocks inside one function, and in one block follow the
>>>> +// propagation pattern and in other block doesn't. Or we may have several
>>>> +// functions with the same name (for different configurations).
>>>
>>> Context: rule1 matches functions that have all three of
>>>
>>> * an Error **errp parameter
>>>
>>> * an Error *local_err = NULL variable declaration
>>>
>>> * an error_propagate(errp, local_err) or error_propagate_prepend(errp,
>>>     local_err, ...) expression, where @errp is the parameter and
>>>     @local_err is the variable.
>>>
>>> If I understand you correctly, you're pointing out two potential issues:
>>>
>>> 1. This rule can match functions rule1 does not match if there is
>>> another function with the same name that rule1 does match.
>>>
>>> 2. This rule matches in the entire function matched by rule1, even when
>>> parts of that function use a different @errp or @local_err.
>>>
>>> I figure these apply to all rules with identifier rule1.fn, not just
>>> this one.  Correct?
>>>
>>> Regarding 1.  There must be a better way to chain rules together, but I
>>> don't know it.
>>
>> Hmm, what about something like this:
>>
>> @rule1 disable optional_qualifier exists@
>> identifier fn, local_err;
>> symbol errp;
>> @@
>>
>>   fn(..., Error **
>> - errp
>> + ___errp_coccinelle_updating___
>>      , ...)
>>   {
>>       ...
>>       Error *local_err = NULL;
>>       ...
>> (
>>      error_propagate_prepend(errp, local_err, ...);
>> |
>>      error_propagate(errp, local_err);
>> )
>>       ...
>>   }
>>
>>
>> [..]
>>
>> match symbol ___errp_coccinelle_updating___ in following rules in function header
>>
>> [..]
>>
>>
>> @ disable optional_qualifier@
>> identifier fn, local_err;
>> symbol errp;
>> @@
>>
>>   fn(..., Error **
>> - ___errp_coccinelle_updating___
>> + errp
>>      , ...)
>>   {
>>       ...
>>   }
>>
>>
>> - hacky, but seems not more hacky than python detection, and should work better
> 
> As simple, forceful and unsubtle as a sledgehammer.  I like it :)
> 


Hmm, not so simple.

It leads to reindenting of function header, which is bad.

Possible solution is instead

fn(...)
{
+   ___errp_coccinelle_updating___();


but this slow down coccinelle. For example, on block.c from ~3s to 1m16s.

.

So, I'm returning to just a warning.

I think something simple like

@@
identifier rule1.fn;
position p != rule1.p;
@@

fn@p(...) {...}

@ script:python@

<print warning>

should work.

-- 
Best regards,
Vladimir

