Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11201C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 18:51:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCBC72073B
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 18:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="mf1ciW+k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCBC72073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1je19G-0007Ij-2V
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 14:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1je18O-0006XJ-6X; Wed, 27 May 2020 14:50:36 -0400
Received: from mail-eopbgr70101.outbound.protection.outlook.com
 ([40.107.7.101]:58177 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1je18L-0003Cf-LE; Wed, 27 May 2020 14:50:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IGTLiUJK59oW7PvkgYftnEsY6A5Hiba236i5evu/LU8TH6Ykn6do7zkQ8uNmkqyVDtfKdUsk42fkVUfArHHBJleO/ZJbFCw/iGjP1hWd62TYeYRL5cW94KB4A6w1tJ3hxwugwa01BRYf9QmtUbMtlmURnf9KmkP8SVGUur1ZYfLOQgq2ZZDqg50h5uw9k2s5wSxQUFGYDIZOS+IiYDnmyCkCGN1erSpltR121rqPjnXEb/7t0W/icdHBSTt0GdDfWhYWzj+qSoys4fAPYaiq+no2+J5NQoqe/hLreKuiIWf4Xh3Av9xHMfFTfnsk6tn0vMqBGn81EJliw4CmwsSalw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzEHYtAs9dNYbraWw8vJNGLcdwdKQcfMFk1ae85wHmM=;
 b=YTpc4P45GJAxr8sPb/uRFnAXL3lZTtCFHkrFaS0XRnzqYorSMvml8YQY0iaXFVkQOPk4ICgOu/DApHZrjEkqqqwGIV3YAvYv8n/FZQSAbR0On21iZc36gXZtWzdu5SQdoCbyHc1abllcQ7ee/uXGAydMzYvPhmxhxy3sg7csG3X7JKw4t1T67Fj2Z+yiqJNuRz/4uvTgjh0tAjsvHYIJzdh/0FTEL246cf+DBBSQrUJSFKd+YOgLQxiqmdwK7g0scmUuAfwcWYOqo3JIQc0/1xIDHcLB3qNe1iMUpr1ciQGICoJDWvjoa8SRw0JzrNMieCTyPZ6fdnwhh1xR3D/abw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzEHYtAs9dNYbraWw8vJNGLcdwdKQcfMFk1ae85wHmM=;
 b=mf1ciW+kS073nOMjDU/ZO8sV7vuRR9enf3H+sZtAMd3w90VUDuTzl53nixOTyYDqKRxQlFYKk5BlppTbryEpXahbh09VBxTVMd7C9U0N4W4YYqWfvRthgQDUK7ZIWQx7N7Pq+eVeR6ut7nXvYAIvNTpDUj3PaR8Z6RupaCL/3I4=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5352.eurprd08.prod.outlook.com (2603:10a6:20b:10e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.18; Wed, 27 May
 2020 18:50:29 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.018; Wed, 27 May 2020
 18:50:29 +0000
Subject: Re: [PATCH v4 9/9] iotests: rename and move 169 and 199 tests
To: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>
References: <20200515211505.3042-1-vsementsov@virtuozzo.com>
 <20200515211505.3042-10-vsementsov@virtuozzo.com>
 <6ad020e7-ed54-5bc8-0c70-9776dab903ac@redhat.com>
 <20200519090709.GC7652@linux.fritz.box>
 <2dfeb643-bbb2-d50b-d14c-ea2db04aa3c5@virtuozzo.com>
 <20200519114107.GL7652@linux.fritz.box>
 <8ac73337-4d93-7916-dea3-e20d2895bcb6@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <0e390fe3-b53c-c98a-90c6-3a8831b3a370@virtuozzo.com>
Date: Wed, 27 May 2020 21:50:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <8ac73337-4d93-7916-dea3-e20d2895bcb6@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR07CA0020.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::33) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.148) by
 AM0PR07CA0020.eurprd07.prod.outlook.com (2603:10a6:208:ac::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.7 via Frontend Transport; Wed, 27 May 2020 18:50:28 +0000
X-Originating-IP: [185.215.60.148]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1aaa057d-2808-4cf5-99f6-08d8026ed381
X-MS-TrafficTypeDiagnostic: AM7PR08MB5352:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5352E0816436616B9F5CB00BC1B10@AM7PR08MB5352.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 04163EF38A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jYx1703lkkY7bDyhwwMtNoE5hgR4klk5bBjJMyHvnQwfD3aS4wyfD6OYeNHnWVV9xad/Wn9UoYslGs8RcZqPDxF3BHywHsqXPt6oBBOzBkIGG5s9APfNC3Lhs+/9gV0tbA7OWIvrwJCp4ED4YHiNR7zubnVqZymZGfPR84yBiAtfTw90mbcIIm+ijrxzC0hqmw6TVQuqd61q43iiN1ftHpQdoDrDTLS4tZLY/UUFqR1+dPACDs/oJi99HmGa6wPf1zavhROjtHOkwqgjT9fzy5zAvjVAANzHjZWmbWJ14bec1nrHcwgTHawv0w7kPvvzlXL9xaTsCnNYhBLePreux8qZ5iWIyrFojcOGshBldilR0JF4wNfrqGF0QjYiz6gz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39850400004)(396003)(376002)(346002)(366004)(2906002)(16576012)(110136005)(4326008)(66946007)(8676002)(956004)(66556008)(31696002)(83380400001)(316002)(8936002)(5660300002)(66476007)(36756003)(26005)(16526019)(186003)(478600001)(31686004)(53546011)(107886003)(2616005)(52116002)(6486002)(86362001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Sftt8OWz3ER8ZzQA/FQ0k51QnrZ+TENOTDhV9wb/UOlVzFC2Uj2M+APUJwhgACvv75DLMmgtG9biwSVmKP5NSuhgET+3j/tsetAwuBkTMX8IroCsLJhk6EeNEFSfHj65WUAlsaIo3hMppGRvw/NkhXSeh+FQ+BMDhaG+uY2puYdsC4uyBnUGBVcTutLYNCbW7GNA1CRVCLqvT8eb+emEOSFRLTeVL0MJnrq/t4Ca8o26xcKAL1LS0RIwINafqg3FLvfz9JrvECeD49S3iO03UUfYWNCGJzjh5v0Q5+aO+q6K7sGMWSvxalPmLlRWpBnHFfDXIUP4nBVCtuAsqhc7/GZO7eOn/k9WaBtwHcg4GgNfUlJo0OMOl0qfnvPOxSwnJPFzhLyN5/+iF1/o3oVz54bX221TQAQfIjnN59jgnvddIfxrec/KalLBkVgYafOnwypg7hCFUBA7YLhkS+1MG9pid7/QPMm2LmVnlscxpPjdTLBQK3/Sx4BvXjvvBzXS
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aaa057d-2808-4cf5-99f6-08d8026ed381
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2020 18:50:29.3229 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lr7jW/5GDbLrylGRkZ0/UWPq4SnepQNjBLRLLFMwnXVdohYjMNNZm1h1kYq+ejH50JjexGcksm6dvrjd2hJuCcKT3/pXQBWvim6PvxeQLf4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5352
Received-SPF: pass client-ip=40.107.7.101;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 14:50:30
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: den@openvz.org, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

21.05.2020 21:32, John Snow wrote:
> 
> 
> On 5/19/20 7:41 AM, Kevin Wolf wrote:
>> Am 19.05.2020 um 13:32 hat Vladimir Sementsov-Ogievskiy geschrieben:
>>> 19.05.2020 12:07, Kevin Wolf wrote:
>>>> Am 18.05.2020 um 18:12 hat Thomas Huth geschrieben:
>>>>> On 15/05/2020 23.15, Vladimir Sementsov-Ogievskiy wrote:
>>>>>> Rename bitmaps migration tests and move them to tests subdirectory to
>>>>>> demonstrate new human-friendly test naming.
>>>>>>
>>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>>>> ---
>>>>>>    tests/qemu-iotests/{199 => tests/migrate-bitmaps-postcopy-test}   | 0
>>>>>>    .../{199.out => tests/migrate-bitmaps-postcopy-test.out}          | 0
>>>>>>    tests/qemu-iotests/{169 => tests/migrate-bitmaps-test}            | 0
>>>>>>    tests/qemu-iotests/{169.out => tests/migrate-bitmaps-test.out}    | 0
>>>>>>    4 files changed, 0 insertions(+), 0 deletions(-)
>>>>>>    rename tests/qemu-iotests/{199 => tests/migrate-bitmaps-postcopy-test} (100%)
>>>>>>    rename tests/qemu-iotests/{199.out => tests/migrate-bitmaps-postcopy-test.out} (100%)
>>>>>>    rename tests/qemu-iotests/{169 => tests/migrate-bitmaps-test} (100%)
>>>>>>    rename tests/qemu-iotests/{169.out => tests/migrate-bitmaps-test.out} (100%)
>>>>>>
>>>>>> diff --git a/tests/qemu-iotests/199 b/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
>>>>>> similarity index 100%
>>>>>> rename from tests/qemu-iotests/199
>>>>>> rename to tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
>>>>>> diff --git a/tests/qemu-iotests/199.out b/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test.out
>>>>>> similarity index 100%
>>>>>> rename from tests/qemu-iotests/199.out
>>>>>> rename to tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test.out
>>>>>> diff --git a/tests/qemu-iotests/169 b/tests/qemu-iotests/tests/migrate-bitmaps-test
>>>>>> similarity index 100%
>>>>>> rename from tests/qemu-iotests/169
>>>>>> rename to tests/qemu-iotests/tests/migrate-bitmaps-test
>>>>>> diff --git a/tests/qemu-iotests/169.out b/tests/qemu-iotests/tests/migrate-bitmaps-test.out
>>>>>> similarity index 100%
>>>>>> rename from tests/qemu-iotests/169.out
>>>>>> rename to tests/qemu-iotests/tests/migrate-bitmaps-test.out
>>>>>
>>>>> I like the idea ... but the path name + file names get now quite long.
>>>>> While you're at it, what about renaming the "qemu-iotests" directory to
>>>>> just "iotests" or even just "io" now?
>>>>
>>>> Renames are always kind of painful. Do we have a real reason for the
>>>> rename except that the paths feel a bit long subjectively?
>>>>
>>>> Of course, if we're renaming all files anyway, changing the directory
>>>> name at the same time shouldn't give any additional pain, so it would be
>>>> completely reasonable then. We're not renaming the test harness files,
>>>> though, and even only two test cases in this patch.
>>>>
>>>> Maybe this final patch should stay RFC until we have the infrastructure
>>>> in and then we can have a single series that moves all tests and also
>>>> renames the directory? Maybe a not strictly necessary rename of the
>>>> tooling would be bearable in the context of a mass rename of tests.
>>>
>>> I'm absolutely not hurrying about this thing. And actual aim of the
>>> series is another. I even doubt that we will mass rename the tests:
>>> who knows what they all test?) I don't.
>>
>> Good point.
>>
>> And conversely, there are a few test cases that I do know (like 026 030
>> 040 041 055) and probably wouldn't recognise for a while after a rename.
>> :-)
>>
>>> Still we may rename some tests, and we'll create new named tests which
>>> is good enough.. OK, if I resend a new version, I'll add an RFC patch
>>> on renaming the directory, up to maintainers, take it now or not :)
>>
>> I guess a final patch to rename the directory as an RFC makes sense.
>> Then we can continue the discussion there and decide whether or not to
>> apply it without holding up the rest of the series.
>>
>> I think I would be inclined to leave the name unchanged as long as we
>> don't have a real reason, but if people overwhelmingly think otherwise,
>> we can still rename.
>>
> 
> It's a pinch long, but it's not a big ordeal. I wouldn't object to
> .tests/io as long as all of the renames happened all at once.
> 
> I'll admit to not having read the series, but I will miss the ability to
> specify ranges of tests. I'm not sure how that happens under the new
> proposal; but I think it's a strict improvement to give the tests human
> readable names in the filesystem.
> 

Hmm. Actually, I think, it's not a problem to continue support ranges of tests for number test names, if you need it.

Note a new paramter --start-from, which is here to re-run failed  ./check run from the middle of the process, is it your use-case or not?


-- 
Best regards,
Vladimir

