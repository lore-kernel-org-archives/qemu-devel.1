Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71BFC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 11:33:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9059B20708
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 11:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="EByNyTgV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9059B20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb0VB-0007gP-Ny
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 07:33:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jb0Uc-0007Ak-Bo; Tue, 19 May 2020 07:33:06 -0400
Received: from mail-eopbgr70135.outbound.protection.outlook.com
 ([40.107.7.135]:25408 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jb0Ua-0007uU-H1; Tue, 19 May 2020 07:33:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFdKcbeLokswNRYK/UZJI1jnh30gkrRV80HZRpFidjL+NVlB5b6Ib5RpWQsl69VGo+ofZh5YOuG3Ey/zuu5lO0evhJprcBJhukEgekfJUJ9U5WtErL0ZgxSBJMBU4U5PUcQUP5sPnUuVKNRnLQ9yqbZppdly2DDit8sm6bZA5rcsrDaRkpOC6LG4wtMUbRDWwsw+Fix8JUR2ox+rywL2nxirfcncnY4ODX9L9AF4ZqWbuZMzCYwKI8YrR9+9yrJgyZbQhsxu0BYPJ1BQszyWQSPBGPOKFCiAiEl7HyrPfuIgogv3JBoQB1lr1GEnRMPcNzqvwM+vz6gaBmM3B7ibgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4a9+LxiBTQj4Rn5SkWl3FuiDEY7YOenkZoP1aHjBVM=;
 b=BtZ7oANeroEgPVTg1yvbSLICIIR780AjuRFDwIHSmxRdwX6nfFKlfXGxSOGmM6uoomqCH8Ej8vbUjBK/U0zlxu7fuvoM0eAkkL4QeHi9qwaEAWLHf8+3cCNbDk6neHC2UL+5PGqCnh54H4rmkTFVG2X4XrNV8di9bXtacdzqE1KyL4CV6xPeoqV3+qkprtlJFb6+zIbFq2vUenye/QwhbE0l8LmOqCnQkm1gOr9CNYlCMRLMnTBHLAyaaSnguq9Hn//KdNXo1ZThAV7sLp4PbCUAM+yHqzWZYVhVSnXhXgT/RJI95iXhDzsu1WVjHPVeVInECa+JanJCYkhqjPAyyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4a9+LxiBTQj4Rn5SkWl3FuiDEY7YOenkZoP1aHjBVM=;
 b=EByNyTgVaDaA/sk9Pk8O7+gpqanV6nOMwWozVbRrJ+Iio45uYdD5oxDbA5XEhqF3q2MdahO9YXf84euiC18RsLOc9r4o0N6v3XdikfQI+ouvV6kYhyuWwjcKZ6Iitb+uNgLqTOHjhiN0WP7SYWSTMRn67VHiK+utJ/Ms9GCoRdY=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5301.eurprd08.prod.outlook.com (2603:10a6:20b:dd::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Tue, 19 May
 2020 11:33:00 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 11:33:00 +0000
Subject: Re: [PATCH v4 9/9] iotests: rename and move 169 and 199 tests
To: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20200515211505.3042-1-vsementsov@virtuozzo.com>
 <20200515211505.3042-10-vsementsov@virtuozzo.com>
 <6ad020e7-ed54-5bc8-0c70-9776dab903ac@redhat.com>
 <20200519090709.GC7652@linux.fritz.box>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <2dfeb643-bbb2-d50b-d14c-ea2db04aa3c5@virtuozzo.com>
Date: Tue, 19 May 2020 14:32:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200519090709.GC7652@linux.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0131.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::36) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.178) by
 AM0PR01CA0131.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24 via Frontend
 Transport; Tue, 19 May 2020 11:33:00 +0000
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58455b44-d9d7-4c70-3ba3-08d7fbe862e3
X-MS-TrafficTypeDiagnostic: AM7PR08MB5301:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB530158B34D64140F5CAA6FB4C1B90@AM7PR08MB5301.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OWiP4ws/zDtbfAipQm4cFne6JLQHpAFYv6RTbk56cMVWVLyCd5zlZC4alOZVQmUTc4G2NuYXkn8T+9CtcMlpm5tVXlyDHiCpwzTyxImA/wzis5kintTQtqM/brQZ9W8/KP+FVLU+va3XvpGCe4giEcyJUENvZJjf3wdrylpmmQKCTesTaSpW/NyWqy48Zmq6b+OYgZ3t1WijU6VlMF7q1+/8c0ZW1BvFoikRIAbF/Wy+1iTiw5u8XqfwtfdmUnrMok8I3tCKL1VABkEL2TnDbgwanHVp0oG0UUuce74KvbHA9WntF6b0gv5ja/LuyGAIYseWqmJLFsHjO/TwkpzOTTcBTmUUgfEduVeg9TOhsN8a93ckZfj29kOh9Y9f0chgc5RU9HoHuMHvhx4WmvRlZtBGioqoGOTeyzbj3BvqycZ3hqm+s1D9ESIpWubhQtEd3RwocwrfPT3MwtbqFIi5HvlF1TVvGK7nMWU6/E1vyG+xqdU42aYbU/nRqD0IB/Jh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39850400004)(346002)(366004)(396003)(136003)(66946007)(16576012)(16526019)(110136005)(5660300002)(186003)(316002)(956004)(2616005)(478600001)(26005)(31686004)(6486002)(4326008)(66556008)(107886003)(2906002)(66476007)(31696002)(8936002)(86362001)(8676002)(36756003)(52116002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: aeb6Dwminb56mMWMHtLlOr5p2JCp5cGyP1aMd1MZKBCuSfmwhOgObB0Zxwpn4//CBotR9jt+/6plZHlLqM57fSdqGrmMN3UETIQsoJ1ipKOTjQjesYsUq1MVt7oWTHoiy8EQydKhsm/cFWN/i1RVFPRyADk365kDaSWXVTnqqRz9kzSqkp1oFGOknhnBZAnfsef+MmeT4LPzZ5tTGL8qTRkePnmo7eIYNrOCp/B5gLu6vYihivzZzS+wgWTwF0evYPiW8dG65icTAPQlHrnHvLzcDsy8D83RXQn488wiIDGUD1URZ7VouOaBxWUh+AQAhdpHhLptd9WynuvqlqF2Y578IpCZAjGVcYT0hRofBXr8a04kspMKVUZWGleOzUXlSxeexf2hcVG9+6mcWAVd0jvuDG0OBRZMABm9srDK5XzzD79diH1TH5mYcTHdgh/pwXCN0/KWzLBiMKGyMJiiPCbfW9qUIK1oDsDksElv0yU=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58455b44-d9d7-4c70-3ba3-08d7fbe862e3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 11:33:00.7144 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rIqvKY3OCLG3V4PvqFDrxCaMhF0qkSb2I8LaF0aAcXYyoPJwjNw/0mAzu+eAewUdOHZaN5H2AxCugUe5n6ZNYTgYyH/L7dibhsmKp8CzBGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5301
Received-SPF: pass client-ip=40.107.7.135;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 07:33:01
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
Cc: den@openvz.org, jsnow@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

19.05.2020 12:07, Kevin Wolf wrote:
> Am 18.05.2020 um 18:12 hat Thomas Huth geschrieben:
>> On 15/05/2020 23.15, Vladimir Sementsov-Ogievskiy wrote:
>>> Rename bitmaps migration tests and move them to tests subdirectory to
>>> demonstrate new human-friendly test naming.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>>   tests/qemu-iotests/{199 => tests/migrate-bitmaps-postcopy-test}   | 0
>>>   .../{199.out => tests/migrate-bitmaps-postcopy-test.out}          | 0
>>>   tests/qemu-iotests/{169 => tests/migrate-bitmaps-test}            | 0
>>>   tests/qemu-iotests/{169.out => tests/migrate-bitmaps-test.out}    | 0
>>>   4 files changed, 0 insertions(+), 0 deletions(-)
>>>   rename tests/qemu-iotests/{199 => tests/migrate-bitmaps-postcopy-test} (100%)
>>>   rename tests/qemu-iotests/{199.out => tests/migrate-bitmaps-postcopy-test.out} (100%)
>>>   rename tests/qemu-iotests/{169 => tests/migrate-bitmaps-test} (100%)
>>>   rename tests/qemu-iotests/{169.out => tests/migrate-bitmaps-test.out} (100%)
>>>
>>> diff --git a/tests/qemu-iotests/199 b/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
>>> similarity index 100%
>>> rename from tests/qemu-iotests/199
>>> rename to tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
>>> diff --git a/tests/qemu-iotests/199.out b/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test.out
>>> similarity index 100%
>>> rename from tests/qemu-iotests/199.out
>>> rename to tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test.out
>>> diff --git a/tests/qemu-iotests/169 b/tests/qemu-iotests/tests/migrate-bitmaps-test
>>> similarity index 100%
>>> rename from tests/qemu-iotests/169
>>> rename to tests/qemu-iotests/tests/migrate-bitmaps-test
>>> diff --git a/tests/qemu-iotests/169.out b/tests/qemu-iotests/tests/migrate-bitmaps-test.out
>>> similarity index 100%
>>> rename from tests/qemu-iotests/169.out
>>> rename to tests/qemu-iotests/tests/migrate-bitmaps-test.out
>>
>> I like the idea ... but the path name + file names get now quite long.
>> While you're at it, what about renaming the "qemu-iotests" directory to
>> just "iotests" or even just "io" now?
> 
> Renames are always kind of painful. Do we have a real reason for the
> rename except that the paths feel a bit long subjectively?
> 
> Of course, if we're renaming all files anyway, changing the directory
> name at the same time shouldn't give any additional pain, so it would be
> completely reasonable then. We're not renaming the test harness files,
> though, and even only two test cases in this patch.
> 
> Maybe this final patch should stay RFC until we have the infrastructure
> in and then we can have a single series that moves all tests and also
> renames the directory? Maybe a not strictly necessary rename of the
> tooling would be bearable in the context of a mass rename of tests.
> 

I'm absolutely not hurrying about this thing. And actual aim of the series is another. I even doubt that we will mass rename the tests: who knows what they all test?) I don't. Still we may rename some tests, and we'll create new named tests which is good enough.. OK, if I resend a new version, I'll add an RFC patch on renaming the directory, up to maintainers, take it now or not :)

-- 
Best regards,
Vladimir

