Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19973C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 20:31:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8B3F206F0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 20:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Qjo12Kft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8B3F206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jz4Ll-0006Mc-4M
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 16:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jz4L4-0005r5-QF; Fri, 24 Jul 2020 16:30:42 -0400
Received: from mail-eopbgr20128.outbound.protection.outlook.com
 ([40.107.2.128]:32483 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jz4L1-0001xT-Uf; Fri, 24 Jul 2020 16:30:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P47p78oQjR4h70eRXfLE6maOVRGrxDBFOLYXX5OZ45nelbJcWermnUSkYVbRYhpSj21b7qJcFqYWXMdBi+gFlKHBUPjIvetxFxU0osJ6oq3yM6Gma2aTW96NQ+SIYFbyTYWYMtrJnY/bl8gaAbopS0vQb4Vzbwv3UcuMrHKzvD8XzS7ulY8pJMvlfDfz4YrSE3Q5BKsZaJXs49Gk0/89wT0m+7zz5ZzsjCPMA8/yudgIkXp446ETPUvwJLjc3J/h0GPODlsC7QVLTW4loqsYU3FBjUv/clZfsk0/Ur1cYBSXet7HdotKW1zdxZartG3ZKxA+7LZgp7OpVgR5KOAo/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMynVFLGJ/cHgLWwz3l9RWCKroqAAvgSJW2VApRKMkg=;
 b=NcuRnWINcXQ9X5KeU8foJ0UugOGiGdph9cHZtQs35ok1z3U1qJ497Z16aFL1H2+1d1ISJ8CVppBm+17Uym01ryH3sFEREQMpNAmTo3Rg3XasgFf2h8Li8DD+Y0A9rQOuyJFWhSeIPTlvuGIvWDreozvirFJRj0e0J/Pq7e4ZpeWBPVyvdH2z4ImDPWogfiTqVS/zH9CqaDlmIO8/mNQ7jmp4QoIMpe660I/i1Gt2eN5hWcd04hodnipnE1LsFlt8+si+FJw17OLiHzFLbiDf9hB7QjsynYqbAuDl5b2DMhVpDJiktywDvAzHpoy/MnHJrOQqb8zGA3N3JuMMbEKqWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMynVFLGJ/cHgLWwz3l9RWCKroqAAvgSJW2VApRKMkg=;
 b=Qjo12KftW1RzOqU+k/jlrRyegnY+Yo26Qkmaqxnl8tmjGoYKC9X0TTiM40WQMq9Ez3d+GhwlNxSbwav68uEneiaMzE1Of1elX5ChrqfxkhKF0FlTda8n1jSG5Dw0M+OO1eoEw51jwjnLODD4yi4+ZDGBxlaDibAi1v3Te7a40hI=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4915.eurprd08.prod.outlook.com (2603:10a6:20b:d1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22; Fri, 24 Jul
 2020 20:30:34 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 20:30:34 +0000
Subject: Re: [PATCH v3 15/21] migration/block-dirty-bitmap: relax error
 handling in incoming part
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200724084327.15665-1-vsementsov@virtuozzo.com>
 <20200724084327.15665-16-vsementsov@virtuozzo.com>
 <35252620-8a4e-9440-f647-6b15d697365f@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <685495bd-83a6-6a2a-7ae6-9632e432e771@virtuozzo.com>
Date: Fri, 24 Jul 2020 23:30:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <35252620-8a4e-9440-f647-6b15d697365f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR03CA0092.eurprd03.prod.outlook.com
 (2603:10a6:208:69::33) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.156) by
 AM0PR03CA0092.eurprd03.prod.outlook.com (2603:10a6:208:69::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.21 via Frontend Transport; Fri, 24 Jul 2020 20:30:33 +0000
X-Originating-IP: [185.215.60.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 616d2602-a4e5-4268-6527-08d830106aa5
X-MS-TrafficTypeDiagnostic: AM6PR08MB4915:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4915A4EAFA7C9276CDE069B0C1770@AM6PR08MB4915.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:883;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y0LtzUPzCwADNHMWLUNDDdS6oAAC3qCGFLc3JmgDTyfh3byjdE9Ummk6SJBj3gJLdEbGwCkSpp8fvm1qOS1t/ElkQEuzdQU0WnA2/v/etUcYPiT83ixxzc/iH6YdeYhXRMbEFG5buzevEgSRnUUjrcgRUMemoNoNS84WBG+/RCb02Clq9o8nhPpzTHmSmG8HWXLnIdrDd0D23iwdAkU54RAo1SWDaAVZ3Xj6zhDPM7kBuxdcrASX7ednd/D6jZyDSmnzlKyz7BAU7wrkM9hq5CjjmtSCrJjbg2JHxPK6ykloOEBhLF25kQhlixa+9Nk9VhElV9vd9+1Qit4i1eBNfLDfo4Ti8NEISMSNTVqukc9DPkWlaxgFoYJqorlrfbWJw81wAqruouSSXDfk4snMBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(136003)(346002)(396003)(39850400004)(26005)(956004)(2616005)(4326008)(31696002)(31686004)(7416002)(86362001)(66476007)(66556008)(83380400001)(66946007)(107886003)(8676002)(16526019)(5660300002)(186003)(36756003)(2906002)(316002)(16576012)(6486002)(8936002)(53546011)(52116002)(478600001)(14143004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: +fiCUkYQOEuliHlVdx6oZQr3+tuUc+ukobCean5SSt2I7I+Tj3qcmQp1JHkySZ4gHTldbXy2Yu0iiNWqrpVNxklAHMnt2ZqpwkHWL3NNs/ziQbCq7rhOrMV86BqkOEc0JSIhAIFG7iMg8H2Wcpu8tFQMQGFNInTEZYsQzMTU6t7BX48mMTte0ppUPCm8xLacrhER41xOjMbktUGEWLZdwMGsjmq/k1tmDzllZ42UjZQ9QWU3QalMHdUYAUMtU2u5qaT2PJ9klHA5m6IP4memyDimGhiYcgjq6lDJbflHWJTpp92ARarB7Qkf8LoM96IMLHP3mT5dLpqkTLB6d971txWplGZMr2AbYs5BHRFo2SrOKIL48BQlZxofm3MfxOUnHbp0jsXXLsSGDTTRSwJaGZjjeOGhhMxOA5h+R8MjMwwRC506hOL+reOWqsMQLGhRku/jTdHL/fo2sOQPcnsGSkR02kl1IbPkxlAw0m2yTLcPAjyr+kgsSiSB0sA28EaK
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 616d2602-a4e5-4268-6527-08d830106aa5
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 20:30:34.1422 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NG6osOdBo+3HU6rPEnU/ArMnez1AwpyMfnAvYfGaT6iPfvRAsgBE0zD/2VI1PTJOsyc08TpzO4dBq1iNaXodtyBHtOfy49iFYeGWx8jQWe8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4915
Received-SPF: pass client-ip=40.107.2.128;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 16:30:35
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
Cc: kwolf@redhat.com, fam@euphon.net, quintela@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, stefanha@redhat.com,
 andrey.shinkevich@virtuozzo.com, den@openvz.org, mreitz@redhat.com,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

24.07.2020 20:35, Eric Blake wrote:
> On 7/24/20 3:43 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Bitmaps data is not critical, and we should not fail the migration (or
>> use postcopy recovering) because of dirty-bitmaps migration failure.
>> Instead we should just lose unfinished bitmaps.
>>
>> Still we have to report io stream violation errors, as they affect the
>> whole migration stream.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   migration/block-dirty-bitmap.c | 152 +++++++++++++++++++++++++--------
>>   1 file changed, 117 insertions(+), 35 deletions(-)
>>
> 
>> @@ -650,15 +695,32 @@ static int dirty_bitmap_load_bits(QEMUFile *f, DBMLoadState *s)
>>       if (s->flags & DIRTY_BITMAP_MIG_FLAG_ZEROES) {
>>           trace_dirty_bitmap_load_bits_zeroes();
>> -        bdrv_dirty_bitmap_deserialize_zeroes(s->bitmap, first_byte, nr_bytes,
>> -                                             false);
>> +        if (!s->cancelled) {
>> +            bdrv_dirty_bitmap_deserialize_zeroes(s->bitmap, first_byte,
>> +                                                 nr_bytes, false);
>> +        }
>>       } else {
>>           size_t ret;
>>           uint8_t *buf;
>>           uint64_t buf_size = qemu_get_be64(f);
> 
> Pre-existing, but if I understand, we are reading a value from the migration stream...

Hmm, actually, this becomes worse after patch, as before patch we had the check, that the size at least corresponds to the bitmap.. But we want to relax things in cancelled mode (and we may not have any bitmap). Most correct thing is to use read in a loop to just skip the data from stream if we are in cancelled mode (something like nbd_drop()).

I can fix this with a follow-up patch.

> 
>> -        uint64_t needed_size =
>> -            bdrv_dirty_bitmap_serialization_size(s->bitmap,
>> -                                                 first_byte, nr_bytes);
>> +        uint64_t needed_size;
>> +
>> +        buf = g_malloc(buf_size);
>> +        ret = qemu_get_buffer(f, buf, buf_size);
> 
> ...and using it to malloc memory.  Is that a potential risk of a malicious stream causing us to allocate too much memory in relation to the guest's normal size?  If so, fixing that should be done separately.
> 
> I'm not a migration expert, but the patch looks reasonable to me.
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 


-- 
Best regards,
Vladimir

