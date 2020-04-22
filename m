Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37147C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:48:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E945F2073A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ov2j/wkT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E945F2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRFk6-0008Uk-Uf
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 09:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38916)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jRFid-0007nT-Bb
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:47:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jRFic-0004PB-0E
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:47:14 -0400
Received: from mail-eopbgr10118.outbound.protection.outlook.com
 ([40.107.1.118]:8867 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jRFib-000494-7P; Wed, 22 Apr 2020 09:47:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uc/3Ran5HcSQOvzVLgKMuMVHCtTfMp85zc5zlKRirN2oNTjPpq7gOwDcNk9Uth00Ub/3vrnwbTQY3y1LlWqpakVUZZiONeztt45vQ89iAzYLMDuFEkx1etn6Se0aMiNkWKieZZ7ywLkiyBtQ+YxaAlM+OG+h25L0h/HdMJjg15gh+4q30rDufQaPCIelUXdajFvDW+ig9LtEmz05sQDV0lA+W9vngDq6FLl9Io/6VauTw2x8RzDrpR1Ykqjm2GiVKB8nN3S6P7rEVVL4bmk7kXmPh51iTJ75iGzAP/7+zMi1F+Xsnt1pGdb3SEDnLK7lWcE2PGtaSW46YlFfnr8nWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XLQpZ8x0IwYu0Jt24j2jNYxod+yHTZtVHt7uhX7Qz0=;
 b=WJ4plw3qgzMLmMUxwdJe7kJoZ8Wk0GzDhMyCHtHHSmKu+G7+Th6CVvn3LQxUKymZTUPhYV/okj8YVlAu5ik/QtMmad03TUxe5MkMZkBNZ3yNbGKoFxa+6pWw41yAaHDKri1aNpxDcFrk0fVtY/mCkt6bARoHn1wmy8ZakdBV7CncKVElhUEZQVjy/gwRvGh6fQXzPOVFWxJsFYnj2+JXHhmK6P5a7QiJumkw9iki4fbRHI9oMjwkFq4GE+1UcCMSmiQPEuwFIB+bykp3BxD63tkAJQi2iCkWnTSWINBdW0DTlttwFemocQQTdz30WZjT1zvjf5sqQ0DPyoHM3977GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XLQpZ8x0IwYu0Jt24j2jNYxod+yHTZtVHt7uhX7Qz0=;
 b=ov2j/wkTAY2VNuKlBzcUHkf1nKR5h9mndrKL03/y1AIcmgfq91TSG7QliREtId/WBuIGM6bnm6A10PBV8b6sEjYcL76CCxJYAI0DL3lKlq8kVC0vPuZ1AKypZ1tNEx2HDFzXEaM16gr+pD8iOsZFuYdGDMzgbr016o/mR2TYEhY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5333.eurprd08.prod.outlook.com (2603:10a6:20b:104::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Wed, 22 Apr
 2020 13:47:09 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.012; Wed, 22 Apr 2020
 13:47:09 +0000
Subject: Re: [PATCH 5/9] block/io: expand in_flight inc/dec section: simple
 cases
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20200408093051.9893-1-vsementsov@virtuozzo.com>
 <20200408093051.9893-6-vsementsov@virtuozzo.com>
 <20200420162255.GE7321@stefanha-x1.localdomain>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200422164707602
Message-ID: <67b95ad8-2a19-5698-d683-f799c024cb01@virtuozzo.com>
Date: Wed, 22 Apr 2020 16:47:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200420162255.GE7321@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0057.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::37) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.157) by
 AM0PR10CA0057.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Wed, 22 Apr 2020 13:47:08 +0000
X-Tagtoolbar-Keys: D20200422164707602
X-Originating-IP: [185.215.60.157]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 405a80a6-9a90-4636-9825-08d7e6c3a707
X-MS-TrafficTypeDiagnostic: AM7PR08MB5333:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB533305D00B28C8C5C3DD1334C1D20@AM7PR08MB5333.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03818C953D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(39840400004)(136003)(366004)(346002)(86362001)(186003)(8676002)(36756003)(8936002)(2906002)(5660300002)(81156014)(478600001)(316002)(16576012)(16526019)(6486002)(66556008)(6916009)(107886003)(66476007)(66946007)(31696002)(52116002)(2616005)(4326008)(956004)(26005)(31686004);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PV+Cu4OFk6a5iigzSTRW/Tqiau9eS1Xz7DMmdiVOwLWay3jX6NaFcf3HS4Oi+lhzyoZ2Xf/PpNnlVX3Tfek/K76aMpINl60NP1KVLTLS/x6sbFqPjsRBXJ7nR2l+lxrQDNemAtd32pSQOcPbju9bPwUCGpXt5csoM5buGxEgzJKigR/7BBYMK7ApE95cPjcEPs9VheYJ8ggLE7GVorjC9bICCTIoxjlFQ+N/uaWw/uBJpRIcQtWYqgPoVKfxjD2Ff171YdWY9iGCrAkDFwwD8WNrx6/KWC1cFFla7y8lxVTOUrjnC/YPLAPXvG+/2MObCIeF59UVQqKmi4INlO3AT+aEDR4+6Prdj76ML1jhNjnIgqmwEp5ZEND94DlhqImHwYR6hyJ+APz3iuEqODPDwY5N/DnwvybRML1Srm4DVddIMG1oq6gqnsXsAejDd1KU
X-MS-Exchange-AntiSpam-MessageData: IkzCk9g1xDdzXzH05uGr/D8f5MHLW3Ni7RiZ1LtYhM/l6kc9b6ZYFERDzHOj2BoSAPPgTzC/hhBo/yNO8b6Ww5PEyhWUjerlXzTzHnZGLD6ZXbSG/Yw8tDT03y6tUpaUS9wsOobzN/B5lJXVOT+8sA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 405a80a6-9a90-4636-9825-08d7e6c3a707
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 13:47:09.3559 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KAcTEg67K/NOKdJmgraeTzM5q0fe9qn2Lgb8eENOQpo+CPNA6Jn1V4AVGzxIcA16L5izuC9HJPHzNC4hz+ugNFDiVW428KH5ClGvyuP4ZC4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5333
Received-SPF: pass client-ip=40.107.1.118;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 09:47:10
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.1.118
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.04.2020 19:22, Stefan Hajnoczi wrote:
> On Wed, Apr 08, 2020 at 12:30:47PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> It's safer to expand in_flight request to start before enter to
> 
> Please explain what exeactly "safer" means.  If I understand correctly
> this is just a refactoring and does not fix bugs that have been hit in
> the real world.
> 
> Is this just a generate attempt to avoid accidentally performing
> operations that need to happen as part of the request after the dec
> call?

Consider write.

It's possible, that qemu_coroutine_enter only schedules execution, assume such case.
Then we may possibly have the following:

1. Somehow check that we are not in drained section in outer code

2. call bdrv_pwritev(), assuming that it will increse in_flight, which will protect us from starting drained section

3. it calls bdrv_prwv_co -> bdrv_coroutine_enter (not yet increased in_flight)

4. assume coroutine not yet actually entered, only scheduled, and we go to some code, which starts drained section (as in_flight is zero)

5. scheduled coroutine starts, and blindly increases in_flight, and we are in drained section with in_flight request.

The series does the same thing for block/io.c like Kevin's "block: Fix blk->in_flight during blk_wait_while_drained()" for blk layer.

> 
>> @@ -2718,17 +2746,18 @@ bdrv_co_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
>>               ret = drv->bdrv_save_vmstate(bs, qiov, pos);
>>           }
>>       } else if (bs->file) {
>> -        ret = bdrv_co_rw_vmstate(bs->file->bs, qiov, pos, is_read);
>> +        bdrv_inc_in_flight(bs->file->bs);
>> +        ret = bdrv_do_rw_vmstate(bs->file->bs, qiov, pos, is_read);
>> +        bdrv_dec_in_flight(bs->file->bs);
> 
> Here we inc/dec...
> 
>>       }
>>   
>> -    bdrv_dec_in_flight(bs);
>>       return ret;
>>   }
>>   
>>   static void coroutine_fn bdrv_co_rw_vmstate_entry(void *opaque)
>>   {
>>       BdrvVmstateCo *co = opaque;
>> -    co->ret = bdrv_co_rw_vmstate(co->bs, co->qiov, co->pos, co->is_read);
>> +    co->ret = bdrv_do_rw_vmstate(co->bs, co->qiov, co->pos, co->is_read);
> 
> ...here we don't.  The code is correct, but bdrv_co_rw_vmstate_entry()
> should also document that its caller must inc/dec.
> 
>> @@ -2950,7 +2994,7 @@ static void coroutine_fn bdrv_flush_co_entry(void *opaque)
>>   {
>>       FlushCo *rwco = opaque;
>>   
>> -    rwco->ret = bdrv_co_flush(rwco->bs);
>> +    rwco->ret = bdrv_do_flush(rwco->bs);
>>       aio_wait_kick();
>>   }
> 
> This function should also document that the caller must inc/dec.
> 


-- 
Best regards,
Vladimir

