Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD91DC38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:53:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87BCE20643
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="h4vuW1le"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87BCE20643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWkiB-0004ID-Py
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 13:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWkYx-0002lQ-5q; Thu, 07 May 2020 13:43:59 -0400
Received: from mail-eopbgr70128.outbound.protection.outlook.com
 ([40.107.7.128]:45170 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWkYu-0003vC-7U; Thu, 07 May 2020 13:43:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIOpFxA8b67lQ7Dwo0bbUxvf+FTlVEKmMHksWhY1J/T0HZfnN+20VbACGhUAW1whkD1/PKAB++0rX0zpBOH6jAIl2JxYJ4dTieEaAjxcVs3JQ7sFaNkV/HMskqBpkbFENq+83Um7AO8G9l79TQSuTWVwFxCbpLDOwdh8o3w8jTxW8iRFZgwRvjVAqF01AwdF3wsU4uaxtJjcQlAiitfe30Oji7vIKfNw9jh1/h1e993JAB2gAc3oMOQ5L00z8Hm+shUbWf1KhBSKXYI6eW8BwuwEM7HBeHi4LqxVmvX2nbXTpkocF8Db2EtPwGOX8inBRnrM/ZRd6JqVbg9n+0cFGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8jpS3TKYsYxB53abSble+/p3aMUxzLgM2NCi8uYUCM=;
 b=W7DkvFiMGShLYvxAooHjtUbxXTbQmMLi8HWn1rJ1orYaSQHQRAu44HIi5W/uvRKw1uVzeS9koTNp0bLGOjEcFwrbRm24qAcw7YCi56CJyA6lmp/C74ucyjlwNWQkPpQP2c6AuEv5TP8m5zKldVcTbTDVJePrwN8QEltV/xgzlW3+qB10wwJ+g/wFQ2HQ79vuAdDsCY1lkVKVDc11QZo0+C7yTxDLB83F4ZPCw8TT93UQ+MMeUBneeklzUgiFJNJP4uu6uPSD4Y8q1V6C98IjO6dy+XDDnbYOsp5rkLeZWri+3CAOX5dtc/1g7vFHIg1qnVG1eP6J0FE/qydhPMmkGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8jpS3TKYsYxB53abSble+/p3aMUxzLgM2NCi8uYUCM=;
 b=h4vuW1leJPNazI9wNfndATT3tNvCACbUrwvHHwMkO9oQRNlVW1aUMSCb/rd1Mtv3TssvP1FghwEt7OowlKhrnv6NxyFNVI0mrJn1dlGJBtn86ZY7lRq/9fWSzpCamGUqzM4hG5mISzJ42mwTrWwvKCV0Z5xEi6p0lfPX229dXoY=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5367.eurprd08.prod.outlook.com (2603:10a6:20b:dd::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 7 May
 2020 17:43:52 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.034; Thu, 7 May 2020
 17:43:52 +0000
Subject: Re: [PATCH v3 06/10] iotests: add testfinder.py
To: Kevin Wolf <kwolf@redhat.com>
References: <20200421073601.28710-1-vsementsov@virtuozzo.com>
 <20200421073601.28710-7-vsementsov@virtuozzo.com>
 <20200421165647.GE22440@linux.fritz.box>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200507204351140
Message-ID: <5a185a4e-1c5d-9887-c88c-6ca71ebeeee1@virtuozzo.com>
Date: Thu, 7 May 2020 20:43:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200421165647.GE22440@linux.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR07CA0004.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::17) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.171) by
 AM0PR07CA0004.eurprd07.prod.outlook.com (2603:10a6:208:ac::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.12 via Frontend Transport; Thu, 7 May 2020 17:43:52 +0000
X-Tagtoolbar-Keys: D20200507204351140
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40ab61cf-c83f-4c54-f82e-08d7f2ae351b
X-MS-TrafficTypeDiagnostic: AM7PR08MB5367:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5367CD38352BEC3C07B72A91C1A50@AM7PR08MB5367.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c18JIau13myEET8NDOn/AHGiploB1RKutasqU264+e6fuO15Y0hEgxYb1TUwv26kLCcHc421t8KsRogjBQm7wiKNjtM9bI0ZPQL+uWQSJQvdNianmvUV2aTbdiOs4jraZQVCgDU0GphuEuL3MD/LWbmmiUzj5m7XpeYx6K9Cnq2boHGBKQ+7U5mN0DaepNFww5Wm2zPGJAB7AmQ88KYAHnxIEq3PmjaCYPTAmv5CUU29uchNRa9nSwE0WSqTLTO3e2Xtphcda9OpmHnPsFY+OksU0INHu4pZB7BDazSUIgjqhrgdm/rcw3E2x27ZoVgDb/ehQsWrRFooxo5PhoIPimpbORvPepJ2IB8753QEx1Xfq5A+iNS1o0iOyWjnTGuAwo38NIruuPKbh0pTRkutg0QA/rVUgRxTe7p6efYFQosK32ELnRNQVcDckPU68253GFOKnB+7COhs5y0SVklBit0efVC1bRAwBtoFLA//HzC7cHVCFlOHlhqfpv0mG4DTOdLIyH7DEDK4uFaPT3Bsber06sglxRKmKWm9lXRfed7+2Fwzn4fDAZ+f43QRmWQs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(346002)(376002)(39850400004)(396003)(33430700001)(956004)(2616005)(52116002)(2906002)(5660300002)(31686004)(33440700001)(86362001)(66476007)(66556008)(8676002)(66946007)(6486002)(31696002)(16576012)(6916009)(83310400001)(83290400001)(186003)(26005)(478600001)(316002)(36756003)(83320400001)(16526019)(83280400001)(8936002)(83300400001)(4326008)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: nbDD59omn+nbmI0jiDmHQylgFRY+EYZi4kfF4LJJaRHO0DlrrNdO4eogZEkwwVNH6uJinKofaWb9gIuNdv802786CAnBuk/IBFRZzk4qQ7xlHfxSqdNo6gg/Mhbp2ISB6Yzl+P3qU7zOm8LPo0dxAa24vi2px6fuUbK/6bi9MImFClCkZ+RKgkpi6UCYe4gp5iJPXX39HAxkBqpmHOwTe6g+eEflq0Wc413D4DR8ra4K+zXg0J49gLqyaiKQsUeVySTyiSvxc7McGciYwhGTA/lo/gdfYQlLXtVTO3sMS1H0ClZCAZDwFRAbMgRZTKLGNLxzr5PjyCuY+utLAza9RLUrVp0YJY0xRiIJzFUxInhBJ/nnEl1vKmd9UO9aVyXyBe1poHCLpGzEp3wobTlAqexwvHd3HHK3SCwlzrQkFDrAZWO3KRIk9jAoMjQiNnHenBWf3qp0JiFTwWp7nfS+rCOs/whQpGpgM4HzNHU51BRxvw3d2sixFOre+f2S8HuOdvKm4dAo/Bh6yR1EpQw969bIqlfT4GWHCB1Uq2NX7/ENR+pXcAM28HNUrUNNCBO69TTxFTFUnYimDMn/B5u/Scx7Tnro3F/oNimuUBRFnvdGj7FLL0/u5hdaXhSgxFnblcN2MZe8riV3FlhlCpd78qi9SFv6AmRIT66Ur2rhXw2H2NhJInsuOj60LdD5+kqk/KmQAPfJJQL0ytxYlsSZZ9+ksMI/kmNkjfL+gPr0DITajkBZzRB1yx9vSR2td14ab4yHTTFvKeQ8Vz8Ltu5ECXxNKi4jF4mcAhq/lBGx3tw=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ab61cf-c83f-4c54-f82e-08d7f2ae351b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 17:43:52.6815 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G9X9+HoWr/iPtY4/6K5Wi684eHey0e4kZ/QnPljY3CW4gQjf2H0rveFWR6P+dJjaHBTpLV3XiAJ0NzRUKkkihGzW45l6/A7P+v8BiPY0Lvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5367
Received-SPF: pass client-ip=40.107.7.128;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 13:43:53
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
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

21.04.2020 19:56, Kevin Wolf wrote:
> Am 21.04.2020 um 09:35 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> Add python script with new logic of searching for tests:
>>
>> Current ./check behavior:
>>   - tests are named [0-9][0-9][0-9]
>>   - tests must be registered in group file (even if test doesn't belong
>>     to any group, like 142)
>>
>> Behavior of new test:
>>   - group file is dropped
>>   - tests are searched by file-name instead of group file, so it's not
>>     needed more to "register the test", just create it with name
>>     *-test. Old names like [0-9][0-9][0-9] are supported too, but not
>>     recommended for new tests
> 
> I wonder if a tests/ subdirectory instead of the -test suffix would
> organise things a bit better.
> 

It will make more difficult to import iotests.py.. Calling common.rc from
bash tests will need to be modified too.

So, we'll need additional line in all python tests:

sys.path.append(os.path.join(os.path.dirname(__file__), '..'))

which doesn't seem to be good practice.. So, instead we'd better call tests with PYTHONPATH set appropriately..

and modify bash tests to do
. ../common.rc
. ../common.filter
<etc>

or again, better to export BASH_TEST_LIB directory.

Is it worth doing?

I think, there are two variants:

1) keep as is: all in one directory, add *-test notation

2) go further and restructure to something like:

iotests/<only check script and its dependencies here>
iotests/tests/<all-tests-here>
iotests/lib/python/iotests.py
iotests/lib/bash/<common.rc and friends here>

And then, check script will export PYTHONPATH and BASH_TEST_LIB variables.

In case of [2], I definitely prefer to split directory tree refactoring to the separate series. So this series just rewrite check into python and get rid of group file.

What do you prefer?

-- 
Best regards,
Vladimir

