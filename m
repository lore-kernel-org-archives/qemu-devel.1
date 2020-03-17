Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455F0C3F2CE
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:23:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11A7220735
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="nosOD6jD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11A7220735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEBFk-0003aq-A0
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 08:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47386)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jEBE3-0001ld-DL
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 08:21:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jEBE2-00072k-6B
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 08:21:39 -0400
Received: from mail-ve1eur03on072e.outbound.protection.outlook.com
 ([2a01:111:f400:fe09::72e]:22842
 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jEBDu-0006G0-Mr; Tue, 17 Mar 2020 08:21:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OkPIoESUAlPI+lqIHaYmUDv+8KzZghYLQz+AFpIsD4T/FQmxclT/QjOekc//OteoXiVbJeyxR0VzQ/YgGYBZfqkob+WU1l6QsFbmFuV6JGI7WCrUVSNl16Zm4NtdGo7apU8NSPPMHmKwCZ75qJq9rYY3CuXlHt8Gwe4t/HbrbjYdAnPRoa9LFYwxC0qEA7/+TRO551Qk1vIQyqJO7zQ881kk4XlePKkREZc+Md/e+CwV+N6jHJRlm/anpJ1Azktu030GuZroC5Cg895F1EcGZG9ax9iji43vT190Q9yOWkKqpAMS0ISWP6nCntILDLecImhrVCPgGJK4zL9iRooZpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DJOnLR23l8Rk12FcvoVRIV7JhKGuxT0q54Xu3kLqqE=;
 b=Wod/7+VzomiKDMvBdgS98ayQR73LhGPBAAhuqPBZAPGOq1AIS2c1/Ubljclbda7tz54i7kgTUymCOn1HZpLPOwU5vFqtQO8nZAALcO42BgyaU01BxomM+VgoelS9jB7ZnPTJp7QDbWROKsRvCx9QxFGYwDCsPQAUyEDzUMHDDznQdUK2J0uzk0irWLpF91WCDLnOeZxjPySDweUkvXJn2htNU/Gw4WL2euaVhesCzYSBgdxTjq5sdmGPv8gkyvb8gNaI22chb6YQrMpykz/u7eYl1xRpGKK+tR+4lIlT10lkjyeLYltwhc7IphywGnD4hzmLHzvwtkW3lj1Wa2YGyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DJOnLR23l8Rk12FcvoVRIV7JhKGuxT0q54Xu3kLqqE=;
 b=nosOD6jD1uX4Uvqp72WVpqAM2wbFh3xJ8uHRLk3Lj2INSCClcK1CAytUaLOJPFmXrVmpd4Lb9tYsx4UOpuG6JFksKmoEX2HGaHG38tmM8LyakJUM8IEVX4qtr5M7DWEuG1ywjJvwed3cgTfOvopkfUQn+Imtz+CmA2Dp02ChQ+E=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from HE1PR0802MB2507.eurprd08.prod.outlook.com (10.175.35.136) by
 HE1PR0802MB2411.eurprd08.prod.outlook.com (10.175.32.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.22; Tue, 17 Mar 2020 12:21:26 +0000
Received: from HE1PR0802MB2507.eurprd08.prod.outlook.com
 ([fe80::4d32:e4e1:5b9f:240f]) by HE1PR0802MB2507.eurprd08.prod.outlook.com
 ([fe80::4d32:e4e1:5b9f:240f%12]) with mapi id 15.20.2814.021; Tue, 17 Mar
 2020 12:21:25 +0000
Subject: Re: [PATCH 1/3] Use &error_abort instead of separate assert()
To: Markus Armbruster <armbru@redhat.com>, Alexander Bulekov <alxndr@bu.edu>
References: <20200313170517.22480-1-armbru@redhat.com>
 <20200313170517.22480-2-armbru@redhat.com>
 <20200313173745.2cwlwbkt4fc7nmpc@mozz.bu.edu>
 <878sk3cz22.fsf@dusky.pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200317152123404
Message-ID: <da2e4799-a6b1-257c-edff-d0c7691a546e@virtuozzo.com>
Date: Tue, 17 Mar 2020 15:21:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <878sk3cz22.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0015.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::25)
 To HE1PR0802MB2507.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.248) by
 FRYP281CA0015.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.19 via Frontend Transport; Tue, 17 Mar 2020 12:21:24 +0000
X-Tagtoolbar-Keys: D20200317152123404
X-Originating-IP: [185.215.60.248]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf556d93-140b-40a3-4ed8-08d7ca6db63d
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2411:
X-Microsoft-Antispam-PRVS: <HE1PR0802MB2411D6E0A7B101A49132FD20C1F60@HE1PR0802MB2411.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:538;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(396003)(376002)(366004)(346002)(39850400004)(199004)(316002)(8936002)(81156014)(8676002)(81166006)(6486002)(2906002)(31686004)(16576012)(110136005)(16526019)(478600001)(956004)(186003)(2616005)(26005)(4326008)(36756003)(5660300002)(31696002)(66476007)(66556008)(52116002)(66946007)(86362001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:HE1PR0802MB2411;
 H:HE1PR0802MB2507.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /o4N6ak7bwPOEbYJbeKWM9d2f9IH/LoVt1mU6UQ2LBEPO04G+4AtIBIVgt62KcA09yW7GxWTTqZNFYbKdOKr8wAcrvcMlwknplCGD1GJVa8KgMhj0I93u5+cq07PRW0rWVIfW5Y4NYIw5uSn3NA8GjXq8fpVzbae+4nbfE5S58YbUUsiHS9+EOAOrsHLsDIhml5XokClgIhfggErDaz/mFrWRelsRXLrIKwm6ko/vZH1g9WL898ytAgLCguqE3Ta9SxiYK9H7n4IROBIg5l0KkCR9pyb5zL28hVDIzwUzMdjiqaE9D10WkMX9cz7gSudvLo1hjBXkD5gkpv3TCwRo+QBGSJPU4LYCRh8NnnXhrxBdwCr9N4Z6/4phplJFrD4EFV/XBpa5LxIa68Irxi78v6dptGkG9R0VmHB3Sz98V//hQplL1cmNYwjJY+Ro4Cq
X-MS-Exchange-AntiSpam-MessageData: Zu/+785t+6raUl50MdZesAi4V9LTD81I5ug8fmi5qKVRlrgpkGMIW0MzIxkIvwJZsyXBhg0EDiHVqYlhTRPRcRLu7dyDfOdljvNLhuzKwlmsJPTQ9l1lz6PVrXmzIxnep/1y4EVi+DLiYOKQ5BAAqQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf556d93-140b-40a3-4ed8-08d7ca6db63d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 12:21:25.7280 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9AZD9ddfsAF5lej5jV3moIVgII/PdvbNkVkK50cMSXWrALcL4L0OHAMxvAGY2zUtLshsUsiBfVH9bzgSPDOFRKtKdGnBdsk1CxE74kdBQVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2411
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe09::72e
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
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, ashijeetacharya@gmail.com,
 paul.durrant@citrix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

14.03.2020 7:58, Markus Armbruster wrote:
> Alexander Bulekov <alxndr@bu.edu> writes:
> 
>> On 200313 1805, Markus Armbruster wrote:
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>
>>
>>> index 1a99277d60..aa9eee6ebf 100644
>>> --- a/tests/qtest/fuzz/qos_fuzz.c
>>> +++ b/tests/qtest/fuzz/qos_fuzz.c
>>> @@ -57,8 +57,7 @@ static void qos_set_machines_devices_available(void)
>>>       QList *lst;
>>>       Error *err = NULL;
>> Can this err declaration be removed? Don't think it's used anywhere
>> else.
> 
> Will do.

with this:

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

> 
>>> -    qmp_marshal_query_machines(NULL, &response, &err);
>>> -    assert(!err);
>>> +    qmp_marshal_query_machines(NULL, &response, &error_abort);
>>>       lst = qobject_to(QList, response);
>>>       apply_to_qlist(lst, true);
>>>   
>>> @@ -70,8 +69,7 @@ static void qos_set_machines_devices_available(void)
>>>       qdict_put_bool(args, "abstract", true);
>>>       qdict_put_obj(req, "arguments", (QObject *) args);
>>>   
>>> -    qmp_marshal_qom_list_types(args, &response, &err);
>>> -    assert(!err);
>>> +    qmp_marshal_qom_list_types(args, &response, &error_abort);
>>>       lst = qobject_to(QList, response);
>>>       apply_to_qlist(lst, false);
>>>       qobject_unref(response);
>>> -- 
>>> 2.21.1
>>>
>> Thanks!
>>
>> Acked-by: Alexander Bulekov <alxndr@bu.edu>
> 
> Thanks!
> 


-- 
Best regards,
Vladimir

