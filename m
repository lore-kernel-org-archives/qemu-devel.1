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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBF0C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 12:37:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBD502072D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 12:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="C3JEBSPW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBD502072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juxiB-0005GF-53
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 08:37:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1juxhY-0004kM-KS; Mon, 13 Jul 2020 08:36:56 -0400
Received: from mail-eopbgr40131.outbound.protection.outlook.com
 ([40.107.4.131]:37445 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1juxhW-0001gE-SU; Mon, 13 Jul 2020 08:36:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIkVOHfDuXWP+ND6IPJ99hsZU/sbiGfpV3EGwy13FL7RyZ9Vvn1xQJBjoNMd8Tte4R8DJK1buF76AgYyV5+TNoiRiAZaIfi/e2LL+2brat815LUQjTOAp09HU0kcIPCbsNfIJ3eVZe8jtfahrds+HzJ12jAt6LE4+cP8uTOPSPlqXi6Z7E2wyn+g2sqYEAOoFSwNesnAcXEY7aDaz8fqWR/m3Utg3DkL9d5jZUZwYXYMuBF2MWzxT5ScDyvPoREIpQty37QejsZAwDzrjYVd3NX3xjKfWrIy95wX0HeLUfypZGPzirvjo3MKTRmCNIRvc5vGNUsDErShuCcYh6JR9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=daSKym4/IlmHfBqVUQQ387ElR2JYq8TqOrodfgjBHwI=;
 b=bqHCvujlPWXZ8z+iRiDzcggio3gc/05FlAMinQ0RYEdtiSti1B0SzO50xUqrzzRGL8/MK4JUk2mSB95JPOXo6N2OKIhlhDZwYQ63wnBvSx21l3hWy3WwS5X/Bt8G4SWtyd8DHQ6Z4cjfaFqXKHgNYwYLyu4clkOWGt2sGXDfAL3manNgtdw9PT+ZtGgwg7fWirbqF9t+ggYfcKt6NJMaYU0WcVo08MZW4aNsNoxECIUDSwQ9oZdX20Xif9bP5mKXr67cvnJnQtryEyAX0vD2EE3vmrN3Yvd+0nQRCblLKE/XUQcYS37qHQ0m3qIFoQtKOBTVcsVE4gLgngk8jEJn7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=daSKym4/IlmHfBqVUQQ387ElR2JYq8TqOrodfgjBHwI=;
 b=C3JEBSPW59fj2l4QCgXbHOCBadqMbPcdoKT9CCt1TAp7HUKFAjtshBRDoon78iOoSMlCC+BC09TYfLqlK7y5ZFnnfkWU5UtvRllB/SD3W+cZ/yEpncGG6Qgs3hk/JKx5ueQpMVo6LL9C1PWCRUtbRXtYJRSWh74pq29bQUQBfuE=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4850.eurprd08.prod.outlook.com (2603:10a6:20b:d2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Mon, 13 Jul
 2020 12:36:52 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 12:36:52 +0000
Subject: Re: [PATCH v2] scripts/simplebench: compare write request performance
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1593181915-853845-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <73ac42ec-dc28-c4e6-a555-d9cf11cbeed0@virtuozzo.com>
 <f19f4323-94cb-4404-1530-279d256be46b@virtuozzo.com>
 <ab34ca3e-087f-9040-9927-43902281b453@virtuozzo.com>
 <5dc513ae-a425-43e5-e257-acb73a02af7d@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <f12e3633-f44f-a5a1-4e84-b072b1e155fb@virtuozzo.com>
Date: Mon, 13 Jul 2020 15:36:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <5dc513ae-a425-43e5-e257-acb73a02af7d@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR07CA0029.eurprd07.prod.outlook.com
 (2603:10a6:205:1::42) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.167) by
 AM4PR07CA0029.eurprd07.prod.outlook.com (2603:10a6:205:1::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.12 via Frontend Transport; Mon, 13 Jul 2020 12:36:51 +0000
X-Originating-IP: [185.215.60.167]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fc1804a-3552-4f4f-0714-08d827296b32
X-MS-TrafficTypeDiagnostic: AM6PR08MB4850:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB48508A0F7FD34777E03551D1C1600@AM6PR08MB4850.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /4NYAB/dFfSBt9EANBQUsDva/fXTFrNEHNCh4WFeGzJC/LHqvXIC12WUhDQODC88K8lDlIeEzAzNE1tDBFfRVGo2NHk/h2bE3UTtS/94ttyb2FibOC4e5RnhG/lKSF/n9JxPslzBS9st9N6n9gTKLpuQK0xzrSf8kbdlpIanRANlbx0pkXBKOfHEImJOl/lI7cZ1bJxkYxWJHeiqJRoil8O6Xu8bw62FgTYkSFIZjfLkMmVhz0ZiQrrl+lPTJkvs+MHABOtiIkVG3YInna7CaoE0x5+Dv7Cbz//vQLH3kgrBIQP2U7Sh+DB08VuL0X+rBD6bwvEPsMkknElNZKCcpb4pT4xzc0AZxmX1QHDKKVLOeWVD1cfDNY10fE/c7vwc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(346002)(366004)(39840400004)(136003)(478600001)(26005)(83380400001)(5660300002)(107886003)(52116002)(8676002)(31696002)(6486002)(66556008)(316002)(86362001)(53546011)(8936002)(16576012)(66946007)(66476007)(2906002)(956004)(2616005)(31686004)(36756003)(4326008)(16526019)(186003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 9oRFl+B9a7Jqf43vZVTSdIzoa84S1bx0Ll7kccONIpM0SnRBalGyhDyENzqkbvuAp2oe/xzqKftd1nNctwiTpE4NR4cuAWPH3+iCxgNf8TLo67aiP/UaiLYagaXBRiVIXUZ6Wz5bLclI9QAfey5VzsG3feGYzk/V78S0+aO7KscNNIh/AjB1QQR8ej1tgQfFAt5O363WdChEX2Cs6r7EVw+SjBFx5eKo9bgd9FeXClkcfNxnSIQGViC56uvuuChXJDrowqat+Onp6RYB/9EWfb+qUstm7kSsj5QIlcQmanIxlCKwBXPxYELLz26IfLzD3x67Iza+1ICRlBYTOg/+FsOY88ix+PB+WvZu9DaWVzMsdz/PVMFTCa26KeFPnF+qq7Xyu4a2AsLDPFNUvcESAXf+hwRCUWQKEJlmpOgL8MRFaI8beVCs+9I26whVak/LbXrUqz0/RnZy73WfvT92JZWKGiNB6CXZLhnpqxGSN6e7j7B5Du36o3pIXSYVGkBY
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc1804a-3552-4f4f-0714-08d827296b32
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2020 12:36:51.9543 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: syJQzOtqxQ/zmmDujjfuqbUymq19OzRM7bKcvZAR5rT9c1M3sLWWXJoQafhqK9WJEu092liBETt/P4gxGPPq3R3lHQl5D5mts+Cq+EAlW3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4850
Received-SPF: pass client-ip=40.107.4.131;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 08:36:53
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

13.07.2020 13:26, Andrey Shinkevich wrote:
> On 13.07.2020 11:43, Vladimir Sementsov-Ogievskiy wrote:
>> 12.07.2020 19:07, Andrey Shinkevich wrote:
>>> On 11.07.2020 16:05, Vladimir Sementsov-Ogievskiy wrote:
>>>> 26.06.2020 17:31, Andrey Shinkevich wrote:
>>>>> The script 'bench_write_req.py' allows comparing performances of write
>>>>> request for two qemu-img binary files.
>>>>> An example with (qemu-img binary 1) and without (qemu-img binary 2) the
>>>>> applied patch "qcow2: skip writing zero buffers to empty COW areas"
>>>>> (git commit ID: c8bb23cbdbe32f5)
>>>>> The <unaligned> case does not involve the COW optimization.
>>>>>
>>>> Good, this proves that c8bb23cbdbe32f5 makes sense.
>>>>
>>>>> Suggested-by: Denis V. Lunev <den@openvz.org>
>>>>> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>>>> ---
>>>>> v2:
>>>>>    01: Three more test cases added to the script:
>>>>>        <simple case>
>>>>>        <general case>
>>>>>        <unaligned>
>>>>>
>>>>>   scripts/simplebench/bench_write_req.py | 201 +++++++++++++++++++++++++++++++++
>>>>>   1 file changed, 201 insertions(+)
>>>>>   create mode 100755 scripts/simplebench/bench_write_req.py
>>>>>
>>>>> diff --git a/scripts/simplebench/bench_write_req.py b/scripts/simplebench/bench_write_req.py
>>>>> new file mode 100755
>>>>> index 0000000..fe92d01
>>>>> --- /dev/null
>>>>> +++ b/scripts/simplebench/bench_write_req.py
>>>>> @@ -0,0 +1,201 @@
>>>>
>>>> Next, I don't understand, are you trying to fill qcow2 image by dd directly? This is strange. Even if you don't break metadata, you don't change it, so all cluster will remain empty.
>>>>
>>>>
>>> I have tested and it works as designed.
>>>
>>
>> But how is it designed? You just filled unallocated clusters with some data. When you read from qcow2, you'll still read zeros, because L1/L2 tables are not filled. The random data will lay untouched.
>>
>>
> 
> Sounds reasonable. But why do QEMU-ING INFO shows the actual size increased after the dd command?
> 

Because actual file size changed :) img-info shows two sizes: virtual disk size (it's unchanged of course), and real size of file, which is affected by dd of course.



-- 
Best regards,
Vladimir

