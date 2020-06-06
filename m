Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C5DC433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 07:05:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD1652073E
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 07:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QOheohXS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD1652073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhSt4-00020W-3t
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 03:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jhSrW-000131-C8; Sat, 06 Jun 2020 03:03:26 -0400
Received: from mail-eopbgr130110.outbound.protection.outlook.com
 ([40.107.13.110]:4836 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jhSrT-000675-TS; Sat, 06 Jun 2020 03:03:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCrHX+WsKcBZ4+vxPFe9GGrlNxy/j/W7rLyNEhfknqBJfUD6ieJbVYA0dY0PjNzwoJWoOt3b30x6fVQzpn87Piv26UOewW7xRd1tNGVakPZh74rAylQjad2CAVzkMJeINF19DZbL8bM1/u7pQxmsDBBHllxwOaq8DU5yRq8B8jwwn0KAX3ACUG9RlNIQgAf+yue8sXD8UsGudxI4gnT7LwrSVfSHZybJ49/Mm3firo8CZ2aJuPzSDq8qIVhrvrovT0dTdignhieelyAqXS3hSuXPPeBzgCDfd6c6NMPRCeczcUsoaAcBzs6mmV3cY5ay5r3m7Hb37VaR1B7olLKm9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnQRb5Y5OiL63GTgeKPgftom3uf+iR+6yDxAvc+XSR0=;
 b=XsVzzPy9/izznFNfBQWAN3ZzYh4EIOyfhs3CTMACJl/zhZgOxe+dCkxaM6JX0D8rsV4YSPnWCPBsla+e/NkYZUsv/GREVzvMh9N9O8oNxpQXPPsiKjHi/kPsvHveekP8zFK5SjR+ELtk/PwTL9pk63Uh3OetrU9+Xf7e7Zt2ofwmdzSX3Tz7B5eN9Aec+ylyHPLn2VqhnIEL3IAmvQV9XftaX7A5fafO1XguXzOK+0BzfapNVXh07fZOLRMldTY6eZzNhZGxFRU/05QfpemGppgvPsOeMxp1lD0xau34MuT/9BjWociMwoAyrkuMbDlynUNJ81wUdeYMTwakH80YTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnQRb5Y5OiL63GTgeKPgftom3uf+iR+6yDxAvc+XSR0=;
 b=QOheohXSngo0yimmPgkstgcp5BX+CwqHql91hdUjDKDa9CHALHRhpmkdyFg0bB+EJN7vSrjP5mobmmbF6qI6tek7aDUzCOjIG4F/Jjb9I8uPTX6kca3SGjL7OXiJE6v3CHmvGDsN/QSLjcVBHHHJdOZKNjOX4Z1cOElpy4Q/Z5E=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5526.eurprd08.prod.outlook.com (2603:10a6:20b:108::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Sat, 6 Jun
 2020 07:03:21 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Sat, 6 Jun 2020
 07:03:21 +0000
Subject: Re: [PATCH v4 02/12] qcow2.py: move qcow2 format classes to separate
 module
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200604174135.11042-1-vsementsov@virtuozzo.com>
 <20200604174135.11042-3-vsementsov@virtuozzo.com>
 <bba065d2-cdd9-08f0-1e02-31f314ecfb0c@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <cf264553-0a51-e7ca-3117-25d0ea690d05@virtuozzo.com>
Date: Sat, 6 Jun 2020 10:03:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <bba065d2-cdd9-08f0-1e02-31f314ecfb0c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR10CA0080.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::33) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.130) by
 AM0PR10CA0080.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Sat, 6 Jun 2020 07:03:20 +0000
X-Originating-IP: [185.215.60.130]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95fcbddd-0f25-4f3f-408f-08d809e7b282
X-MS-TrafficTypeDiagnostic: AM7PR08MB5526:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB552648C29017EB280A2BF4E3C1870@AM7PR08MB5526.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 04267075BD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HRMUGHRysGMakjLitVmCAv+ETIJlKm38MPxy9XWnhSWn+g/q/RZl7PqVcigNE8UiFW4Cr4pNfws6c3eaK1SEDSA/c146XasApF5cA0+Lw+/5QsAIjksDIByaQfLBaPltpOJo2gUVWoSqOai9wwJNIg9y7oA0ZLryIlk3iQfcUZRcfe1DIm4kQuRJJiENXCkjpsTZf4gbsoyoYsbZHeyDlEbS1bXkHC1lBCkVU2V68RASrdtkqfj3x9YleAYvzvsdkgJ0qHq5Flf9OGd+Ia/1CNzTMlJAbO+DQFKiTcPTMYhdyIoZyx1kgAjuuhTwpLuSGMzuesF3OIbuERXD+QGfbf4xLCGHATnsqwNgExHrD03FUAWNvfNDpApwtj+7Rs5f0+coYlNYEEyTJ4zgTKY8vQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(376002)(346002)(396003)(39830400003)(31686004)(107886003)(4326008)(2906002)(31696002)(36756003)(66946007)(66556008)(66476007)(6486002)(5660300002)(83380400001)(478600001)(2616005)(956004)(86362001)(316002)(16576012)(26005)(53546011)(52116002)(8936002)(186003)(16526019)(8676002)(2004002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: bEnIiCeOa3zoqJWM62i2aw/EVdg4LWlZUIlK7ZTyf03LLnPPyMNIc/+w/dNjC+B6KpQP4HgbHWbqscoPhDsgdIY4vNNxPFdPDWnU5IN35Llabek6phgsm+mJSyHcq++N1xkc6vI3nRqI1gZPOaefkMIjIOhzb5FxhE/WapmTlL9mj6mMk5xgPNxwnURsYF4Ko7oFXPiT8GqmMo2f/u51YBo4NyboSuoWmGP1AsN6bs7Lmj+px7nzar7SWoGKF56VgxfpUuguZc5FnNtOXzy3t1dlMQVSW/XVDb1KgOIMd6R57CqG2IC326qcR+97Bf1VMNb9Xn3CFZMV/t8G3M9g5NjlSu72I7/w6QJtK5ZRJFI45uLs90XShuc0kZ0+o1c/lRe45kVCJ5/ofHQuXjlWDB8CCJuVYFwOjw4ozHGNsM7rL0wm4O2mFbT3SYAiDkynRJDKfpXLC9Euo3Gowh/E+eCqnI+l+sri9QXgdD+bljX9PtFWPl7o5we3FWMi11cc
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95fcbddd-0f25-4f3f-408f-08d809e7b282
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2020 07:03:21.1354 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r12BUCjDyTWl++Y1S1IeJSfPRpbCKKAyJdIdef0WHpCqjrM9yTmiz6YQgmXO6Etdx47skfkXgV4XNm6yi9A7XZx8x9jx9XkJ3mGGBTlSnhw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5526
Received-SPF: pass client-ip=40.107.13.110;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/06 03:03:21
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: kwolf@redhat.com, den@openvz.org, andrey.shinkevich@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

05.06.2020 23:14, Eric Blake wrote:
> On 6/4/20 12:41 PM, Vladimir Sementsov-Ogievskiy wrote:
>> We are going to enhance qcow2 format parsing by adding more structure
>> classes. Let's split format parsing from utility code.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   tests/qemu-iotests/qcow2.py        | 161 +----------------------------
>>   tests/qemu-iotests/qcow2_format.py | 157 ++++++++++++++++++++++++++++
>>   2 files changed, 161 insertions(+), 157 deletions(-)
>>   create mode 100644 tests/qemu-iotests/qcow2_format.py
>>
>> diff --git a/tests/qemu-iotests/qcow2.py b/tests/qemu-iotests/qcow2.py
>> index 539f5a186b..d9c41668fd 100755
>> --- a/tests/qemu-iotests/qcow2.py
>> +++ b/tests/qemu-iotests/qcow2.py
>> @@ -1,163 +1,10 @@
>>   #!/usr/bin/env python3
>> -
>>   import sys
> 
> Pre-existing: no copyright blurb on the old file...
> 
>> +++ b/tests/qemu-iotests/qcow2_format.py
>> @@ -0,0 +1,157 @@
>> +import struct
>> +import string
>> +
> 
> It would be nice to fix that, and have one on the new file as well.
> 


Yes, I thought about this.. But what to add? Seems OK to add Virtuozzo copyright and common "This program is free software; you can redist... GPL ..." header to qcow2_format.py, as we are going to rewrite and improve it a lot. But what to add to qcow2.py, to the part which is kept mostly unchanged?

-- 
Best regards,
Vladimir

