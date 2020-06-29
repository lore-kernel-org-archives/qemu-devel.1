Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641CBC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 09:50:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2833523440
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 09:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vgPS3sQT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2833523440
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpqQJ-0003vR-Ck
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 05:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jpqOL-0002eH-Uq; Mon, 29 Jun 2020 05:47:57 -0400
Received: from mail-eopbgr60124.outbound.protection.outlook.com
 ([40.107.6.124]:13902 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jpqOJ-0002EL-QZ; Mon, 29 Jun 2020 05:47:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kntU2ASlGhT6LVDTOQwpyFr1quHQYDDsSqUe5A2TnlluMwX/93b3/bst7BK5S+l3RJco3KgmYGoibfrRDbllxuebhi19RdwOo+h9aEy1f/931XWvFY+sxO56m4knLRZPEGUQ65hEuBO0N4jGynzda4kIdl5PJQOtJHUk7nmb6wv5iyNVLrz9/w+W3ztCRdDivAdy7hDq/LEPYMeOqFmO8p0o4crCRBAd6fmG4PNXStB7Y9IrfNp1E4Z463P2rzJi4NCwpPzX8sLTmXCHncOXyPbpz7g0yDpfL6bDHdjmLHN6PJrOjuNSvhxj5Jz68hpC0v/8jHQztVAbDzEq4ZrNww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/4ftfCACLucBS9p95q9zG5AyQYIxKb4qDfL2YOLjmM=;
 b=F39inyeMTPiljsUBnwh579Zmo3uCZuP4oeiOHqz5kK9efL3BgiWkRIkBekFi4I3R8bZqZ5EfVcr/5zmiAGurkEWAGa6GzUkZT0j9lcF6xPGx0vurR0cEwqDQTRJmn97Ul0w3N++2gKi0OUb3pK5s6Ax9wXEI2UdeNJNlMn71jKHysvD2PcJ1cYjHOrWLSQfMZIJHP0jHUpa0dPuhXwPUefmGeIIlLzShgUl7MJdfl/DPUAXy1sZX8K3liJqVfpuQlZh5lnceve+YTlc8/v2PV+CUBF/SMCXt63vJ8+C9Z695Qo01I9GyW9pT/jDd17QtDGKt5TaQkcl24+asQZXaqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/4ftfCACLucBS9p95q9zG5AyQYIxKb4qDfL2YOLjmM=;
 b=vgPS3sQT7z7losQEaKyXhABCwPIPpAWGW6J4OLMW+WXIC0pJmN9j2rPlPVYHAWtmUZsLXM0U+cZgLU8Jkk3j688AtGEZAxZxgT03IH17ZH46oYLQ3F6nnC7f5JmZlALDBD1ulwbn2wdquzPubORKynnpN7QMYFui//CYl8R0tpc=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1905.eurprd08.prod.outlook.com (2603:10a6:203:43::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Mon, 29 Jun
 2020 09:47:53 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.026; Mon, 29 Jun 2020
 09:47:53 +0000
Subject: Re: [PATCH 11/46] qemu-option: Make uses of find_desc_by_name() more
 similar
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-12-armbru@redhat.com>
 <a73876ff-2ac1-b077-9fba-a135d97ba9a8@virtuozzo.com>
Message-ID: <5fd6cf6d-1214-d930-ce18-648cbbe0062e@virtuozzo.com>
Date: Mon, 29 Jun 2020 12:47:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <a73876ff-2ac1-b077-9fba-a135d97ba9a8@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::15) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.28) by
 FR2P281CA0005.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.20 via Frontend Transport; Mon, 29 Jun 2020 09:47:52 +0000
X-Originating-IP: [185.215.60.28]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67eb0ad1-e498-4259-9587-08d81c117e50
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1905:
X-Microsoft-Antispam-PRVS: <AM5PR0801MB19055AC45ABC5C44CF0870F7C16E0@AM5PR0801MB1905.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-Forefront-PRVS: 044968D9E1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vcVj3bHokpLBxkdN3SqJ9nWEv8BLx1ezmxJm7VHbgNnQdxCXGZVC1bEEKmBKhjW7yytft43zN3era6Jc+XbTeGIGbAyr6qq/hxIuQWxMZYdqesaIwVvSabXCu4jzbPhBLrjXdSb/oXfA2vzVYIgNsnYhZ/KYdBVfGc/FhKIJ1Z/OlLGaY5lhoXj8yIbzDs5vIcCjeA0tVjOFq6TYihslQkjNKXnMQpMKpAN3dfOXLvnBIn9sRTeh8y0k/Sr8206attVUB45kbd/snBoaW7Yyv/eFTVayC/V/kLFtiFQx57/JvnMhTqrisIAa7xSYJ0QUSmCqn0UGp2hytVEvsHnmFZkqo3vDOhFM/0x6l33R/LqtVP93xNvlSeGRwym20M4w
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(366004)(346002)(39840400004)(136003)(6486002)(478600001)(2616005)(36756003)(956004)(83380400001)(4326008)(26005)(8936002)(2906002)(186003)(16526019)(5660300002)(8676002)(16576012)(31696002)(316002)(86362001)(66946007)(66556008)(66476007)(52116002)(31686004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: THBY8GvHNklcQr2P83fRuzlYw21yzCEMuji0wC3vZprIvrKdeRIbqbY0xgG+lRqSsmfN5Kiy3+J1OylrauSY7+wyaiyuigYSlz+DJE2WFUb6lOD6nNE9/naSrNYNXVy3wBUf5Wjd9yO6tkFA2VpR1fF3mlpICmTAL8b48NF8BY/FjLRX3OKM0aJu1Zngy5ymouQF57I7yMaCLl/ZAUuMNYqUxsP2DGAr0oDgdGiQ83eDE/3j3D0bedbmVZdIpBOW7JYU+4Ztc6LmEWfhC0jOncjTlayuEv1JuPdt2k92vU77+TB6YAq/1QKifKzVK6ziQUGuhAuHDLjf3UQgcM1HHJ+4D7dxd3YrIFjn2f3QeuX7yZagSvO83dIVR+gL/EXDN8hZX9+/gU81Mh4zUy/H0hZjxq4Fg3y6qBgZz5xORknmtKhHFX43GIlADS/3ySbinRvE4jGiUJHnk0L6i3RmOcqVRLOFj8+QukX8wBf0PKA=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67eb0ad1-e498-4259-9587-08d81c117e50
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2020 09:47:53.3003 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: POnfeYnF9CmsrBY6UDfUdKTJIcoxqQPtG6S5NtTpCIYM/WUHokKdeH/t9ZCo22PZ0JUt0M2zn9cYtvG0pa9fOzOpnQpebsggp+GiIsWcUZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1905
Received-SPF: pass client-ip=40.107.6.124;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 05:47:54
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

29.06.2020 12:36, Vladimir Sementsov-Ogievskiy wrote:
> 24.06.2020 19:43, Markus Armbruster wrote:
>> This is to make the next commit easier to review.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   util/qemu-option.c | 32 ++++++++++++++++++--------------
>>   1 file changed, 18 insertions(+), 14 deletions(-)
>>
>> diff --git a/util/qemu-option.c b/util/qemu-option.c
>> index 6119f971a4..9941005c91 100644
>> --- a/util/qemu-option.c
>> +++ b/util/qemu-option.c
>> @@ -270,6 +270,7 @@ static void qemu_opt_del_all(QemuOpts *opts, const char *name)
>>   const char *qemu_opt_get(QemuOpts *opts, const char *name)
>>   {
>>       QemuOpt *opt;
>> +    const QemuOptDesc *desc;
> Honestly, I don't see how this hunk helps with the following patch, which is simple anyway.
> Keeping desc variable scope smaller seems better for me, as well as further scope of
> def_val. (Still, keep my r-b if you don't want to change it).
> 

Aha, I see, we have more similar patterns and you want them to look similarly. Still, it's
better to keep scope of variable smaller. May be a follow-up.

-- 
Best regards,
Vladimir

