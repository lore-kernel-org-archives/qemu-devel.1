Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CC2C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 08:43:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FE08206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 08:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZrS4wVIi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FE08206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juu3x-0002zT-PJ
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 04:43:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1juu3O-0002Ut-19; Mon, 13 Jul 2020 04:43:14 -0400
Received: from mail-eopbgr80114.outbound.protection.outlook.com
 ([40.107.8.114]:60151 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1juu3L-0000fS-QG; Mon, 13 Jul 2020 04:43:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=StEEyyyc8dXRCaiS1tAUOosVTvxs2mgvJqDDg6ckIQ9ZdgBxRtTfqkqCjNxKtRg0WGbMkvHH4OYDeLu3HJNjP/AzPTcy9p/dK/MSi2eef+8xghEynbkGsmQCHDIxVStGJg3QmgmSO6l0mEyqDpEFhrTWYJ7FfMzQ29FjIK1ylwA94zzs1FD7NmioclpV8HAc9ZQP19qJMwvbvZqZvLMJO2sEddIBkHqmB1F2Ou9TYpiNpJEve/i7nNVx31lcymutj/uElTMjYhJdeQpHGQ/uE+qwAXt6g8zWy9kkmmEfYj6qQjphgzcXuAgaKGeeTlVFajAIb+W5jB+Dti9PGSjbmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7xuyMmRoL5H0YTBCzgUJCeCZlAi4ZI7YWo4hIBc5II=;
 b=Fkk/F+oTREyOhRNmnOTst9fABFDwQxw4z5R/N/iZ100KQl3i66saSxVg9SFDeKU9AEZesU3Q9KSK/KILmnpLpzYGsdXBajXuNPYm+lkmNgxWEygK+51Bj1kpxfVijMiyJbBVxIUqithccQYfPGCk6tlnWU++XXD5tO3jFpHD8C8iDnbaY6ZmInByZ9enE+XWtdkzxxdWJxrQiyjGM+xR1Q5wx2+bBZlR0ILT7zGZNd93AMlyTdpwhFo1dAQaIEfpsQiHw1ALYUBGTTxYOpkOFEiTpiqikB5nNOfn7Y3XDQwNO0vLi+7XuiueXF1o5H3M//d//wk0zP9w33cQjebhWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7xuyMmRoL5H0YTBCzgUJCeCZlAi4ZI7YWo4hIBc5II=;
 b=ZrS4wVIiGV0F8+XSfV3HUiLSDSqwGJyYqOu0n0Jc/E2X/DlS5u0Km3SxIUE5q8x1VhpuNj629oBLja5P5TYIjBRh3OmM3YT0ZqCympg1/iwGKYe4OMhwrN7PnxpBmO/HO8vbfOX2dA06hlQhT+anb+peDLuAajHtLIdPGM6GnqQ=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5495.eurprd08.prod.outlook.com (2603:10a6:20b:104::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Mon, 13 Jul
 2020 08:43:08 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 08:43:08 +0000
Subject: Re: [PATCH v2] scripts/simplebench: compare write request performance
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1593181915-853845-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <73ac42ec-dc28-c4e6-a555-d9cf11cbeed0@virtuozzo.com>
 <f19f4323-94cb-4404-1530-279d256be46b@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <ab34ca3e-087f-9040-9927-43902281b453@virtuozzo.com>
Date: Mon, 13 Jul 2020 11:43:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <f19f4323-94cb-4404-1530-279d256be46b@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0070.eurprd04.prod.outlook.com
 (2603:10a6:208:1::47) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.167) by
 AM0PR04CA0070.eurprd04.prod.outlook.com (2603:10a6:208:1::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21 via Frontend Transport; Mon, 13 Jul 2020 08:43:07 +0000
X-Originating-IP: [185.215.60.167]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d6bb6a8-7cf8-472a-8b88-08d82708c44c
X-MS-TrafficTypeDiagnostic: AM7PR08MB5495:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5495E0E1F086ECC03C553A73C1600@AM7PR08MB5495.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3vmqxebz0KUSxDz+MQJeTF7G7DIPKU+0Hvb8lf/DUn6Y1n14m6k18HJIiXDKc5sG5zXglG/zQWKkqTpsiFgUyzkGMgCL/Z5MpQgJ0thK0NRx8hRulzOAL1+WrVV8d0uWz03+xs70OP9IT54yWGNmwcumazrgTEd1H2ShtI8jBryHJS36pvocsRchzq4nygm6h4LhKqs5sXGYVdTHp+S2cRYjLeFAYoPHhi3beWqc/2Goibe7hnQe1fbgOu9YDF7G7vxsZxMBjoVtR5tMMiZorfNzJmg4D2KMghzhg5ezqVPGtoSr+XwC97Fv/0AlFCyJsA1Z5mh4E9qSs9VAaykJilfmSG1c0mCSdvb2u1qeosJ0DaY9l7RlXZYs3aR9CvjV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(396003)(376002)(346002)(39830400003)(2616005)(31686004)(956004)(2906002)(4326008)(16526019)(186003)(36756003)(478600001)(316002)(5660300002)(107886003)(52116002)(8676002)(83380400001)(26005)(66476007)(86362001)(16576012)(53546011)(8936002)(66946007)(31696002)(66556008)(6486002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: IdEV6yPckwgp3/UdmIzFG/ELuoUZ3R55A1XYjJOsmSe3BLMIOTN7fuMQDNposewO2j+IN1J95/x9kdpl9cEnbSCdM/quJFJGPVt0u4JmyqB2wZ4ccBWqcFAqop4VizQnnasTlOcChcqiuQj7PPRwVBf+q3XQvHSVvCTAHBpjzSr9UFKM/jVGu1EBDVMukBLsy2x0Requ3U1oFQnlVlH+bvc0plCq0dIZ27Q5Hf259JE0DXGir1FypzJcwXnFsmsvD+eexwbNQrAJCsK7OaqvkYX7hh+x+iaWeFfstPz0DatcizUVJ4wTiRWZcC2UyenLSR9O9+se5SozTrfmlMmu7X+OVFVta3QWqXUzk4z+kXFVOOJHvHFmFGLr9W5eRBuq375tBplDieRA5xM8VzLPPRM4/me6pNPX+CYSe28/DJdmzQqg+jtDYTtA1XFqrcE59BHoEfewhbYnYHGsTMLsNJMBdhkZ0zv82cH9daKp3tGejw5+5rOVWpQ1CPRuY4pN
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d6bb6a8-7cf8-472a-8b88-08d82708c44c
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2020 08:43:08.0831 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bxSRIcSBd9OjOsSdwklBIaK4O/OFilpv71v0vQUzrP4iy+MoTbXTZ1Lux9bzVj9EROpNSrQM1d+Y6DBgBZHj98ISv8/AQQFsyW+DkG8KDqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5495
Received-SPF: pass client-ip=40.107.8.114;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 04:43:09
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

12.07.2020 19:07, Andrey Shinkevich wrote:
> On 11.07.2020 16:05, Vladimir Sementsov-Ogievskiy wrote:
>> 26.06.2020 17:31, Andrey Shinkevich wrote:
>>> The script 'bench_write_req.py' allows comparing performances of write
>>> request for two qemu-img binary files.
>>> An example with (qemu-img binary 1) and without (qemu-img binary 2) the
>>> applied patch "qcow2: skip writing zero buffers to empty COW areas"
>>> (git commit ID: c8bb23cbdbe32f5)
>>> The <unaligned> case does not involve the COW optimization.
>>>
>> Good, this proves that c8bb23cbdbe32f5 makes sense.
>>
>>> Suggested-by: Denis V. Lunev <den@openvz.org>
>>> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>> ---
>>> v2:
>>>    01: Three more test cases added to the script:
>>>        <simple case>
>>>        <general case>
>>>        <unaligned>
>>>
>>>   scripts/simplebench/bench_write_req.py | 201 +++++++++++++++++++++++++++++++++
>>>   1 file changed, 201 insertions(+)
>>>   create mode 100755 scripts/simplebench/bench_write_req.py
>>>
>>> diff --git a/scripts/simplebench/bench_write_req.py b/scripts/simplebench/bench_write_req.py
>>> new file mode 100755
>>> index 0000000..fe92d01
>>> --- /dev/null
>>> +++ b/scripts/simplebench/bench_write_req.py
>>> @@ -0,0 +1,201 @@
>>
>> Next, I don't understand, are you trying to fill qcow2 image by dd directly? This is strange. Even if you don't break metadata, you don't change it, so all cluster will remain empty.
>>
>>
> I have tested and it works as designed.
>

But how is it designed? You just filled unallocated clusters with some data. When you read from qcow2, you'll still read zeros, because L1/L2 tables are not filled. The random data will lay untouched.

  
> This dd command doesn't hurt the metadata and fills the image with random data. The actual disk size becomes about 1G after the dd command.
> 


-- 
Best regards,
Vladimir

