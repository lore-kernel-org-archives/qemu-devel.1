Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67581C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 05:00:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39274205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 05:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FJ6ojb4a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39274205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ5yr-0008ER-8t
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 01:00:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZ5tB-000840-4R; Thu, 14 May 2020 00:54:33 -0400
Received: from mail-eopbgr00096.outbound.protection.outlook.com
 ([40.107.0.96]:59648 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZ5tA-0004rh-6j; Thu, 14 May 2020 00:54:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwLzDLuFUW1gOZFbnPBpZHf83S8h9lkiFxnLSNZ7Dvf9ldogWdGe+GHUAVM5BovazKQOFqvzox8UcTG2brc/wGvE/Etv1VZeUt6Mk0FSm3iN/KQFyTT3gEk5xXBHrenDnidFNTIyndtfKRSoM+SGH0H9wEJDnJZBvai6Bab0fi/zyD/Xn3SFJcGNO/Tu6qIKj3KH9r0L4uVlT3jiFXJ/Tp9fS7S7MVAECJJd6X645NNQKksyw8lb2HNCJaG38bvov/1ax7ZXY8Cg/9RNPYL/tlqSzcIyebHFJotAa1H8PNGOeUyyywlf7wzWN3y3wjkzdCb76CcwtCg7o404pbBBFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fT38Qby9SPo0G4YYDA7otnTwOSip0a4ZRC9130s/G3E=;
 b=AYDUmCZp+p6kV1sEaPYFq00VPPtRgbo/SW/toKLJG8w2lwfy65iCSAgI7ejrEGg4m7gDXCOT/vnchsxHHTT4LXzCNK1scp1YCewmopCScaJxWaErPMcckPNSD7oM2nKB85i1ihHJkKABbfFZ4csJFBYRfBWY4JpJWlMSMS89zRpgjhkzQEc5TOZ2vFxxwYrFKAXHyzWjg6nBM4zhyYryo+62AKmrE4eMyp0rD4ntPk022mMaH10tqIqzcvZZdVnCvNNBO0MQDztoasI+xdlfOOJbOgg4mt1Xk/YMO9VFoxitB74a3DXcrGnL/PYIQBnfn4dUHsFrzb1DcSVQDlVEng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fT38Qby9SPo0G4YYDA7otnTwOSip0a4ZRC9130s/G3E=;
 b=FJ6ojb4aSo/w6gQ4h/bgBCMBC2L3AsaRsEMJpHzhNu+F2yb5cTQgYtpUlOW5bYgo1ybq2FAWvHo2AKStbd80KGdtum9FMsOMXuh4zIzYgWRTQaQDCYSNA6OxZDA2UDlhQw9g6RVjnh5KL/yG8IruzUM7/zAC5HsiWzVJ4HiUZYg=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5333.eurprd08.prod.outlook.com (2603:10a6:20b:104::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Thu, 14 May
 2020 04:54:29 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.3000.016; Thu, 14 May 2020
 04:54:29 +0000
Subject: Re: [PATCH v3 06/10] iotests: add testfinder.py
To: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>
References: <20200421073601.28710-1-vsementsov@virtuozzo.com>
 <20200421073601.28710-7-vsementsov@virtuozzo.com>
 <20200421165647.GE22440@linux.fritz.box>
 <5a185a4e-1c5d-9887-c88c-6ca71ebeeee1@virtuozzo.com>
 <d0c4728e-99e4-568d-473e-952f57f3f07e@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <2a62c728-1607-1375-6126-713bd047d5b1@virtuozzo.com>
Date: Thu, 14 May 2020 07:54:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <d0c4728e-99e4-568d-473e-952f57f3f07e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0064.eurprd04.prod.outlook.com
 (2603:10a6:208:1::41) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.186) by
 AM0PR04CA0064.eurprd04.prod.outlook.com (2603:10a6:208:1::41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Thu, 14 May 2020 04:54:28 +0000
X-Originating-IP: [185.215.60.186]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c4a0df6-bf86-42fc-32e9-08d7f7c2e269
X-MS-TrafficTypeDiagnostic: AM7PR08MB5333:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5333C3A1ABCC266D08BA0359C1BC0@AM7PR08MB5333.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G6W+4j/jc9oV6P2SZj3kTdK0jBax7xmfrhl5hXexNLbUZA9i0b1I5PqUXNbef8+pjy51lekitPIJkuZfdmdpL1LIzt54P++qA/7wqDqmPTat897f3N3BS+5IG2FnqQxadqGmvmVmh2XcJiCtXwciN5j7AmlilX9BzjZ8MYJR76lQmLrtJDcf6GSjdHLhz+KA86X0yWMLJ73m3E0bvExpBgBDIn/L4hHZvkTL3iqzrJf5pzeo0XSSOMwKYSW9mFKcUjfjhnMQm/6fIZIqntg2D1tMG8DSMLU7V+Ve4R2fzi7ghM/pQagAS2poUjNBOQBha9x2iE/tGMSniDha6dBPkflZeJ3UrrVEcdS3IWYWKN7H2iE/ZkToK2hudE59lZ0LDmzzyE/h+rfuJyHna6DXB1C1RSg6tZH7vubutxKUNMzsr9bET+uWOBhr3uPgWqOM09gk1lsehNq6x8uHs6esYOAEjNFL/SpOEhUrhTMPpjx0TZ1/r6KcVIhFxPxpAa7F
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(346002)(376002)(136003)(396003)(366004)(956004)(16526019)(316002)(16576012)(186003)(110136005)(2616005)(31686004)(6486002)(36756003)(66946007)(66476007)(4326008)(66556008)(8676002)(53546011)(86362001)(52116002)(478600001)(8936002)(2906002)(31696002)(26005)(5660300002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: P0wNCtPI3wOBoAwaXsNumwAHLJuQVjVwPmsO02u6N5PrJPqW8XU/OeAtYbYIqU2rsyoTqqJOzro954IODOlw/Ok7dWX6UKLplqrqqRSEmKqISosad7bJJovgqmz70TobQ6elnxliozW28ZWFOML345JE41bdRJCbklUlA2IOyW9YVozVGVR1N3mJlccbvz+4V/nv3QrwcahS6d4NgpPQtuSW+uCqLJ7PK2/1Dp+nt/mLeIF1dIg40JSzJqFdefBv2qpczJ8ZcwJzulCVz5yl077v/6T+4IJIc+/6zLMTyt33POs53xRFxHTx7Z471kAZPYiUoWMdoCosaNopR7EHlcBj1FMZp/yWo9t1ZHhN1K7RZtueNiKJpIsDWSl34LsURRKWVrpaVR/kFlhnJhe+eefutGIIzKfwMJo2hNWL/+cwC5eDGgRT/CV1qpZkqff+DVKtb/EpX/htTsTL9ITIDkM33SILfLeF0tb56/NUDmqy1DZIBJbDPFay2WqUD+cm
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c4a0df6-bf86-42fc-32e9-08d7f7c2e269
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 04:54:29.1740 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EKiGtBhkzESRmdrhx+HmYwfgzismQqiDZuUmT2tR47jITbroq1wZlOOWq2UoGQnr6VPjjks+/YCWHHPexva4rDqgNiNWpBkvoCo+xOGspSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5333
Received-SPF: pass client-ip=40.107.0.96;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 00:54:30
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
Cc: den@openvz.org, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

14.05.2020 00:58, John Snow wrote:
> 
> 
> On 5/7/20 1:43 PM, Vladimir Sementsov-Ogievskiy wrote:
>> 21.04.2020 19:56, Kevin Wolf wrote:
>>> Am 21.04.2020 um 09:35 hat Vladimir Sementsov-Ogievskiy geschrieben:
>>>> Add python script with new logic of searching for tests:
>>>>
>>>> Current ./check behavior:
>>>>    - tests are named [0-9][0-9][0-9]
>>>>    - tests must be registered in group file (even if test doesn't belong
>>>>      to any group, like 142)
>>>>
>>>> Behavior of new test:
>>>>    - group file is dropped
>>>>    - tests are searched by file-name instead of group file, so it's not
>>>>      needed more to "register the test", just create it with name
>>>>      *-test. Old names like [0-9][0-9][0-9] are supported too, but not
>>>>      recommended for new tests
>>>
>>> I wonder if a tests/ subdirectory instead of the -test suffix would
>>> organise things a bit better.
>>>
>>
>> It will make more difficult to import iotests.py.. Calling common.rc from
>> bash tests will need to be modified too.
>>
>> So, we'll need additional line in all python tests:
>>
>> sys.path.append(os.path.join(os.path.dirname(__file__), '..'))
>>
>> which doesn't seem to be good practice.. So, instead we'd better call
>> tests with PYTHONPATH set appropriately..
>>
> 
> Just chiming in to say that it's largely bad practice because it
> confuses pylint, mypy and friends -- if we want to keep pushing our CI
> code analysis for python in that direction, this will be a barrier.
> 
> Using PYTHONPATH is better, because it isolates the script itself from
> the environment, but requires you to now always set PYTHONPATH to
> execute any of the individual iotests.
> 
> Not actually a big deal, because iotests already expect a large number
> of environment variables to be set. It's not really a huge net loss in
> convenience, I think.
> 
> looks like that's the direction you're headed in anyway based on
> discussion, so that's good.
> 

Hm, does PYTHONPATH-way works good with mypy and friends? Probably, it should
be set when checking the code? So, actually developers will have to set
PYTHONPATH by hand to always contain some directories within qemu source tree?

-- 
Best regards,
Vladimir

