Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4358CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 11:33:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4829920E65
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 11:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="j/TdhRDC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4829920E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSIZ0-00049q-9v
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 07:33:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kSIXt-00031B-Ad; Tue, 13 Oct 2020 07:32:45 -0400
Received: from mail-eopbgr60135.outbound.protection.outlook.com
 ([40.107.6.135]:8903 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kSIXq-0002cg-8O; Tue, 13 Oct 2020 07:32:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OrQoAO+J0VD1aQOAw9ahE7vemX/5aU/ufjrTgJPzMqgonWivs2UkAo1H4mY/yNMIribCUCQlKsJErmqcXVTcqG5VegJfkiGhVgsuo0RJWpFKCQzFWGWG47hNDOxKQvjD6FwIX3yrG3IawUYl1weNtU8BXSiQadijL4sO9a3wuwB0BJTmLpHbvAchlzrsJ4rH7840W3F+S+oHZZQY1kNm/KXz7Fm4L5D/F0UCtRFQ8GJJXSA9UbaU905IJ7MNxrjv8fBUdYWfx8hSixfuNEjt8mEj6I/0fr+r8rYrLaKDxldwnTb/+lpy3W6OTFmvCITvnYUd1uiOROgroEycwXIcVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f45eGTI8FvgkMUJ+foXJ4xgL0hwpICBbYC3Gqr4Jh+M=;
 b=TqyvayCrcQQT9nwT7UTAJnJhG5RKoIo8kfzfB/hLfFDwU061XdwEyoiH4Rqmetnw6qpm9LuK49ZC1dB7bWKfndGojKTHXZNfHssRU0XxvHIOiYYDH9bSOyc4SgHLa8+HnST9DRViHhrwCtOc+tSQT9NAn1juZaM0owZ0OfXLLpCoNxu3owPNrUpSak6ZQrKD30pol4jnUDXT2JWCeDvzSKlykU1+pxh4Hd8o3bCW4GAR040C79GvbVifmG84Swsnl15JxMRGfsBPOzTPyz45XbYfaXR6TKqBtb9wPolon8jfX+WAqEaaFDJbXnXG+ag8AcPqeNYUk+ohyZsHQFxHpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f45eGTI8FvgkMUJ+foXJ4xgL0hwpICBbYC3Gqr4Jh+M=;
 b=j/TdhRDCiCU83htqG/6S88zaZaSf9Dqy5hcFGJxOknI6RLW+UW3MeotEFr+UaKh7LdIlZLILcvSadYYex1a9o9AHCP/XUnzVYDEJxXfWXZgoW0YQXafNu0t8loE4ZQrprzGOeafPgKpOKevCeKAPtPMu0LQQ0CHLAkrJEfMcqu4=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5031.eurprd08.prod.outlook.com (2603:10a6:20b:ed::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 13 Oct
 2020 11:32:37 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3455.031; Tue, 13 Oct 2020
 11:32:37 +0000
Subject: Re: [PATCH] migration/block-dirty-bitmap: fix uninitialized variable
 warning
To: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>,
 Laurent Vivier <laurent@vivier.eu>, Li Qiang <liq3ea@gmail.com>
Cc: Fam Zheng <fam@euphon.net>, ganqixin <ganqixin@huawei.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Juan Quintela <quintela@redhat.com>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Qemu Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Euler Robot <euler.robot@huawei.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
References: <20201010110730.1575180-1-kuhn.chenqun@huawei.com>
 <2b2bc826-0785-66e2-3515-b98abfac26ca@vivier.eu>
 <CAKXe6SL8fRN=-iqFEiHeWqZm0F+T+8vkc7qJeUz6izQcZQ2Q-A@mail.gmail.com>
 <70bc9735-6555-078a-52da-61da6c58f1d3@vivier.eu>
 <7412CDE03601674DA8197E2EBD8937E83B9B2054@dggemm531-mbx.china.huawei.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <82c0eefd-9227-8d76-e941-343ac78895a7@virtuozzo.com>
Date: Tue, 13 Oct 2020 14:32:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
In-Reply-To: <7412CDE03601674DA8197E2EBD8937E83B9B2054@dggemm531-mbx.china.huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [185.215.60.122]
X-ClientProxiedBy: AM3PR05CA0141.eurprd05.prod.outlook.com
 (2603:10a6:207:3::19) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.122) by
 AM3PR05CA0141.eurprd05.prod.outlook.com (2603:10a6:207:3::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.23 via Frontend Transport; Tue, 13 Oct 2020 11:32:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebc57186-c424-4470-5137-08d86f6bafa4
X-MS-TrafficTypeDiagnostic: AM6PR08MB5031:
X-Microsoft-Antispam-PRVS: <AM6PR08MB5031A0E28BA406A6CB3F0043C1040@AM6PR08MB5031.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:18;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BUdn6CBRjLmxXuAuN6jVX8vruWCg44XaIf24m9MIRzZS8FC9FrnHJNyj6mKgbmKL5824BNT55agsK2dbfSyxSanfgaT+72mAXVMN0RimNHaFyhj38D7fazyE0R8EdHWcJfY5mfOzi8mVZJYUgkCm5RvgMYZmBnRkb1TuuzJkL1BPQwY3hndewfxmu7dhoB8UTw9e1vvK0SkmlAdkz3wz1icgIBZcMNylFU5f/kerA1/54NGVwkOwMy7jIJ/Mv0fAk7Of3OVtEfqr8jBc/iM3OtsiWgDZx6bPZNjB3sJbcklOkIaKJtPn5rEHU4gizTakFyg73lxGjS5uIAsaDr1vw0TgxonMGU+sbvyhCmYMbNw9MgniMjblPblj1u+SbGM4oImpz4m+cbFPxxHmlhhjY62qeyy70yuk/8dEas3YxFkihbdjeYhR1nAIN+txjrIP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(39840400004)(346002)(376002)(136003)(83380400001)(66574015)(8676002)(316002)(110136005)(16576012)(54906003)(36756003)(8936002)(66556008)(66946007)(2906002)(66476007)(6486002)(5660300002)(52116002)(956004)(2616005)(86362001)(31696002)(31686004)(7416002)(53546011)(186003)(16526019)(26005)(478600001)(4326008)(14143004)(43740500002)(309714004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: j7hkmvsKn6WFpgKdYYFZty8BD7THG4ZjJa5NupyGNs5uYtwneM3U+tQD7q9+mX7rF/PhUy3ZYa+eH0jUPmcrXzQHkraNWUKGSfd2FQdG1711mZSsf5G7KAq1gtzxEwZIZlP9XgLB3/xIRumS0OS30YZm7F/YLeCGV6Kc1ZKp2X0rNO3486YDzU86LrkXaG3/b+TTCzADIKPD9SM/LmBoFpC+xz+YsniX1bB6J2sph4uY4q0MMqtQ0YARWNslKNMUS9MyciNBgKX2jqiCb/cF+Ot5OT89MqZ53vTmiVhn/9ug4aL7kbRT4CzCVGI5vbpSOnBZDAavFo11KrdPU63m7I8DrQdgZwyvs7wjltDfOcDC3IDhtUm4lGwJqbreZJP5FFOIMIKXECeB3iIDeLsCwZWYRFCbnTenfLd6jvLB5Om+lqdI/ozIZH6tRcZQXKVSLGFTcxlvKsAB7X7DE/HUep4jgRqbLevDF/7XBs4shalJS0LuRsLZyMW5SamX4OhQDHYFlGzqaxZ395n1e1CgzQ46T3KheGaqZWMdprlve3aLC1X+vXLAHa9+6TUefPGWDHY7z/EQv6l86dmAb1tyO9R3KgeOVa7hnU9dCgS+YR0uYWZsQsjGjjBUb72cQ6rysXwqd4TBoRW5eFfvpCudLA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebc57186-c424-4470-5137-08d86f6bafa4
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2020 11:32:37.2696 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XLS1bENowYwXNqt0Tx48lu3YY6CQvtPyrsjpg5HNY2yFYBSHb6uRyzYxsfkjzrCd2+A5+RCdKICFCZPWcyg3/O6Ghq9DdKwxN1tJckwOcBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5031
Received-SPF: pass client-ip=40.107.6.135;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 07:32:38
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

13.10.2020 10:49, Chenqun (kuhn) wrote:
>> -----Original Message-----
>> From: Laurent Vivier [mailto:laurent@vivier.eu]
>> Sent: Tuesday, October 13, 2020 3:11 PM
>> To: Li Qiang <liq3ea@gmail.com>
>> Cc: Fam Zheng <fam@euphon.net>; ganqixin <ganqixin@huawei.com>;
>> vsementsov@virtuozzo.com; Zhanghailiang
>> <zhang.zhanghailiang@huawei.com>; qemu-block@nongnu.org; Juan Quintela
>> <quintela@redhat.com>; qemu-trivial@nongnu.org; Qemu Developers
>> <qemu-devel@nongnu.org>; Dr. David Alan Gilbert <dgilbert@redhat.com>;
>> Stefan Hajnoczi <stefanha@redhat.com>; Euler Robot
>> <euler.robot@huawei.com>; Chenqun (kuhn) <kuhn.chenqun@huawei.com>;
>> Max Reitz <mreitz@redhat.com>; John Snow <jsnow@redhat.com>
>> Subject: Re: [PATCH] migration/block-dirty-bitmap: fix uninitialized variable
>> warning
>>
>> Le 13/10/2020 à 03:34, Li Qiang a écrit :
>>> Laurent Vivier <laurent@vivier.eu> 于2020年10月12日周一 下午11:33
>> 写道：
>>>>
>>>> Le 10/10/2020 à 13:07, Chen Qun a écrit :
>>>>> This if statement judgment is redundant and it will cause a warning:
>>>>>
>>>>> migration/block-dirty-bitmap.c:1090:13: warning: ‘bitmap_name’ may
>>>>> be used  uninitialized in this function [-Wmaybe-uninitialized]
>>>>>               g_strlcpy(s->bitmap_name, bitmap_name,
>> sizeof(s->bitmap_name));
>>>>>
>>>>>
>> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>>
>>>>> Reported-by: Euler Robot <euler.robot@huawei.com>
>>>>> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
>>>>> ---
>>>>>   migration/block-dirty-bitmap.c | 2 --
>>>>>   1 file changed, 2 deletions(-)
>>>>>
>>>>> diff --git a/migration/block-dirty-bitmap.c
>>>>> b/migration/block-dirty-bitmap.c index 5bef793ac0..e09ea4f22b 100644
>>>>> --- a/migration/block-dirty-bitmap.c
>>>>> +++ b/migration/block-dirty-bitmap.c
>>>>> @@ -1084,9 +1084,7 @@ static int dirty_bitmap_load_header(QEMUFile
>> *f, DBMLoadState *s,
>>>>>               } else {
>>>>>                   bitmap_name = s->bitmap_alias;
>>>>>               }
>>>>> -        }
>>>>>
>>>>> -        if (!s->cancelled) {
>>>>>               g_strlcpy(s->bitmap_name, bitmap_name,
>> sizeof(s->bitmap_name));
>>>>>               s->bitmap = bdrv_find_dirty_bitmap(s->bs,
>>>>> s->bitmap_name);
>>>>>
>>>>>
>>>>
>>>> I don't think it's correct as "cancel_incoming_locked(s)" can change
>>>> the value of "s->cancelled".
>>>>
>>>
>>> Hi Laurent,
>>>
>>> You're right. So I think this can simply assign 'bitmap_name' to NULL
>>> to make compiler happy.
>>
>> Yes, and adding a comment before the second "if (!s->cancelled) {" to explain
>> the value can be changed by "cancel_incoming_locked(s)" would avoid to have
>> this kind of patch posted regularly to the ML.
>>
> Hi Laurent,
> 
> We give the bitmap_name a default value (s->bitmap_alias) so that we can remove the assignment of the else branch statement.
> 
> And then we merge the two if statements("if (!s->cancelled)", "if (bitmap_alias_map)") ,  avoids confusion the two "if (!s->cancelled)".
> 
> Thanks,
> Chen Qun
> 
> 
> The code show as that:
> @@ -1064,15 +1064,14 @@ static int dirty_bitmap_load_header(QEMUFile *f, DBMLoadState *s,
>       assert(nothing || s->cancelled || !!alias_map == !!bitmap_alias_map);
> 
>       if (s->flags & DIRTY_BITMAP_MIG_FLAG_BITMAP_NAME) {
> -        const char *bitmap_name;
> +        const char *bitmap_name = s->bitmap_alias;
> 
>           if (!qemu_get_counted_string(f, s->bitmap_alias)) {
>               error_report("Unable to read bitmap alias string");
>               return -EINVAL;
>           }
> 
> -        if (!s->cancelled) {
> -            if (bitmap_alias_map) {
> +        if (!s->cancelled && bitmap_alias_map) {
>                   bitmap_name = g_hash_table_lookup(bitmap_alias_map,
>                                                     s->bitmap_alias);
>                   if (!bitmap_name) {
> @@ -1081,9 +1080,6 @@ static int dirty_bitmap_load_header(QEMUFile *f, DBMLoadState *s,
>                                    s->bs->node_name, s->node_alias);
>                       cancel_incoming_locked(s);
>                   }
> -            } else {
> -                bitmap_name = s->bitmap_alias;
> -            }
>           }
> 
>           if (!s->cancelled) {
> 

Sounds good.

-- 
Best regards,
Vladimir

