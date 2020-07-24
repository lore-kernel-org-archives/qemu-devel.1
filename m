Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5461EC433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 05:19:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E6C6206F6
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 05:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="tzC1Cqhy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E6C6206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyq7A-00008W-EC
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 01:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jyq6F-00082b-1k; Fri, 24 Jul 2020 01:18:27 -0400
Received: from mail-db8eur05on2122.outbound.protection.outlook.com
 ([40.107.20.122]:39841 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jyq6B-0006x9-Se; Fri, 24 Jul 2020 01:18:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbA+Kxq13oiNcJRVHw6Mc9eDyuKgWgjcRu1uu0gXFiS/Hs7HZ9vbgxdNOWxtN9y0oW2lIFs9CwthRJmAB3n4rTBuXJ1uyYCwrYH1XNOOw0Ew3GWZiTr/UCdBLByeZzYdsAbsseC8cZJ6be8uLTwuomLrQK5PblkoQnAkI44wePTl21YuDaftfSlCcvlL2aSFytqHYvOeZd5MeqLl2RQU5GSHZ2hiFmncpOGxX4rP64oQC360JTymJS18VJE363rJmPuQ903dHv761EWLZkDcWZqqka7CO3Qo46hzzWYX3feT5bKS1/GtYJGXJwD3XNgCPxfvy5DHM+dhelytOw+Eww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1IDRPM0pEBUffK3d1/jjlX+hSsP3uo0G14f8JMZK98=;
 b=Ewz7Pq146QIjgOvFEdnaKTq7/CodIl2bjSJrJQ7RZC2+m4YCSOVQUAzjrNyP1+ZW74rgxlbzqLakQccbU451oLoSd8+McTwFyzbX8vq/QbBKtsiBqXd0f37KeU6+N4uoQc1Y5spe2pBaysGacx7KXigQloZSOyTguiThLmPzv0i552LfLdq7PBjpLdktk+kDxPBZbnb8iEX8sUUeMkcgQIYNP1qJGkllRvKOJluRkk4HF0R5s085T46hN8gDpkqV6cGchfMYhgF94MCm/aWMa67A6SyPsJXoJ3SNevCY8WeUSyWy5Flebkz2omIy8d2tDG0jPHpSGojfd6kuwyjJAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1IDRPM0pEBUffK3d1/jjlX+hSsP3uo0G14f8JMZK98=;
 b=tzC1Cqhy24ZtqIzaDHZV9P+1GF8Un5ZW92961HHe32HHwIwt/KlSI625HMEXF2nae+VQt35sYkzv1jLoutRlR/LlkXq11FmXmv2VN1RZA2OXgvsNlYE96NTvBFXPrm3osXCuF8Kck2smg2sUZk5Ja/PFHX2bQJzk5o+aN5tiBWA=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4069.eurprd08.prod.outlook.com (2603:10a6:20b:af::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Fri, 24 Jul
 2020 05:18:20 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 05:18:20 +0000
Subject: Re: [PATCH v2 08/22] migration/block-dirty-bitmap: keep bitmap state
 for all bitmaps
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
 <20200217150246.29180-9-vsementsov@virtuozzo.com>
 <bcc6b129-d63f-3e0c-ec01-65bff4c2c03d@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <3a9f9df2-9b54-10c2-2d76-b75806dd52d6@virtuozzo.com>
Date: Fri, 24 Jul 2020 08:18:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <bcc6b129-d63f-3e0c-ec01-65bff4c2c03d@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0036.eurprd04.prod.outlook.com
 (2603:10a6:208:122::49) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.156) by
 AM0PR04CA0036.eurprd04.prod.outlook.com (2603:10a6:208:122::49) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21 via Frontend
 Transport; Fri, 24 Jul 2020 05:18:20 +0000
X-Originating-IP: [185.215.60.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e61ecb55-997f-4a24-acd6-08d82f90fb09
X-MS-TrafficTypeDiagnostic: AM6PR08MB4069:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4069302520DD38D555CCE4C4C1770@AM6PR08MB4069.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:15;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ItZseYjwVDiotRxCQ/yy3CUT3j7snvG7eAishbuSP1wD5OcS58vK8AokiMJwpsX7mI2H4y3MTi0WsvoIlhwMEOD2V9mqrs9aPDQtYsfKyYUVVC9pSmbbmZSynEa6oIICkLd+1KvXRs6inAxTUpBpTrMCmp+qQc+NdEcOH9CFPHgutmonReVe8cNdYgPovN55maOVm/wZveF5LaotSUYA7Q1ujv2mkMv1YkKTdabZ86NH8KgcZRUzSG59zybn1R2lmUK3xoVgeK0QejmYO1z/Hh29hdt+fDwXZK2kiEWOaBsH3E9uTcITHHQj7snbPGVdhtWIv1Fzo07c68RDAWvIdwwlf3kXmt9EwlHsdTXaDftwCHy6XpqSHzft1E32C6sh0WbXs36mQzZQZyII+yJ/Vg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(366004)(346002)(376002)(136003)(396003)(52116002)(83380400001)(36756003)(478600001)(2906002)(16526019)(186003)(26005)(53546011)(2616005)(956004)(66946007)(54906003)(16576012)(8936002)(316002)(107886003)(66556008)(66476007)(31696002)(8676002)(5660300002)(6486002)(4326008)(86362001)(31686004)(14143004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: cK6vJQCQ1WGnYFD8kO5tZnhyxEL5xRJAJ2RqnOeur4Kzd6MmWuFYW1yT74FRaY3mlXf/F50TJZi0rYjhshpAPQjpnA7F3qbsOERK9UJ1Il4+49wPPbQHEgfRFWRy28QrnJgseLPKcrBvIblxyp+f6lZ/NZUaYxo7M16i/wCuv829zPwZX3p9r+qMXYsPwA0gIRmiu69oZLQzIy5PNG8rLkIzccR7JxWH7QdKsXaJfWa/koduRM56U9lHZeQfJ+c8I7DMhs3aRrR1d/9eUB+z4gbHYJnXyAvf+MCO70cktS0EGnjdUogUlLECmKX5Fc/AY9n3IetHpQNv0Bo8aM8frGJUK0h8+CGwSs9blKjoBYRZ/cbXguS3zbjkty1KUZeeAIFGE1w81RUEQEGQsCFCincGMf2c9whgsNw2+CkB0ytwPHxPCaYiHQYN3UeQqHDoUyEvxN/kSp8+9udi9IGPo4ccawpQYR6ENcl1i5FGtpgrKmfhSx3SzOWXD4cYLpnM
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e61ecb55-997f-4a24-acd6-08d82f90fb09
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 05:18:20.7213 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NFX2eFgvEFhweJ2KoXtnIXDljfCaDe0oO4X4JvGeMt35twgG6qLwYqPuw1gz+pWXfmrWXrhG+4HV0xzqnVBXVKxKdMaoEF3hoRzLQ66pNEQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4069
Received-SPF: pass client-ip=40.107.20.122;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 01:18:21
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org, quintela@redhat.com,
 dgilbert@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
 andrey.shinkevich@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

24.07.2020 00:30, Eric Blake wrote:
> On 2/17/20 9:02 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Keep bitmap state for disabled bitmaps too. Keep the state until the
>> end of the process. It's needed for the following commit to implement
>> bitmap postcopy canceling.
>>
>> To clean-up the new list the following logic is used:
>> We need two events to consider bitmap migration finished:
>> 1. chunk with DIRTY_BITMAP_MIG_FLAG_COMPLETE flag should be received
>> 2. dirty_bitmap_mig_before_vm_start should be called
>> These two events may come in any order, so we understand which one is
>> last, and on the last of them we remove bitmap migration state from the
>> list.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   migration/block-dirty-bitmap.c | 64 +++++++++++++++++++++++-----------
>>   1 file changed, 43 insertions(+), 21 deletions(-)
> 
>> @@ -484,45 +488,59 @@ static int dirty_bitmap_load_start(QEMUFile *f, DBMLoadState *s)
>>       bdrv_disable_dirty_bitmap(s->bitmap);
>>       if (flags & DIRTY_BITMAP_MIG_START_FLAG_ENABLED) {
>> -        LoadBitmapState *b;
>> -
>>           bdrv_dirty_bitmap_create_successor(s->bitmap, &local_err);
>>           if (local_err) {
>>               error_report_err(local_err);
>>               return -EINVAL;
>>           }
>> -
>> -        b = g_new(LoadBitmapState, 1);
>> -        b->bs = s->bs;
>> -        b->bitmap = s->bitmap;
>> -        b->migrated = false;
>> -        s->enabled_bitmaps = g_slist_prepend(s->enabled_bitmaps, b);
>>       }
>> +    b = g_new(LoadBitmapState, 1);
>> +    b->bs = s->bs;
>> +    b->bitmap = s->bitmap;
>> +    b->migrated = false;
>> +    b->enabled = flags & DIRTY_BITMAP_MIG_START_FLAG_ENABLED,
>> +
>> +    s->bitmaps = g_slist_prepend(s->bitmaps, b);
> 
> Did you really mean to use a comma operator there, or should that be ';'?
> 

Of course, it should be ';':)

-- 
Best regards,
Vladimir

