Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4472CC4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 08:48:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3CC221775
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 08:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KBY0cMSS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3CC221775
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVWGL-0003PG-Oe
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 04:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVWFJ-0002qH-7b; Thu, 22 Oct 2020 04:46:53 -0400
Received: from mail-eopbgr40106.outbound.protection.outlook.com
 ([40.107.4.106]:32901 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVWFF-0005Q9-IL; Thu, 22 Oct 2020 04:46:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4DiccWO3X5OHrile9BB1z/7dOth1WYOiAEkkN3Q0ZE4AEQHIfB4nruevfVDYvjlaTfd9WhVeWpIlD20Ekp0iFGpXR5J26c5F8X7EPbU8dR9xG1Va/E+rYiIVVLvXHbI8iW87Jz45NU4AHhmgroWOv2oAkJQ63KhNqfuaKWQskIkHvi/b4+tpX15+Iv44345XzO3+6VMOtwrPsQjX7V7hFrmSA6X3wvhrzdxa1atKhtKgPI41CfQOIUoVbNQVXGWFQQILDyCpekd1/uXNyd0xI5yOJePh+Cans05tPx3+q/TBzERwFxMazd/q/7cx0ZLp8h3D0rQE3lC0vYMZ+sguA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlZ0KdFHRNy7YKkKYmIy0+0UmN/6yTHLGtw6ytsMVVI=;
 b=QJtkJLkoqql6lcI2kiiIevGFnuZBH1Zu5zaKhLPpRI6ELpfgozbzI1pe8ujbKJtP5smgpyylEPSSzPyfz8liGWBJmt1sp6z+hevz0D5iICaTuJgvH/YvtbKeLWDl8eGCHswjmDAdU8hKbFR3eSjJsDwTZV99maIcOIxviQsJ9xNcOMdt0vnLBeDfZmSPOLuE3iKzCvyrL1aLL40de4sluPNgCCv3BFncwTEzxPHQQ8mrmQvutsK5qR7x8SVHalFjm+zoBfn2PFUb2ObwUn5hKnkKP7FaoTt/9vXeqSqkc0R2t7cqVRvsZEo96pAm9J5Y1xZSjftlQjoz3sEEEAAWog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlZ0KdFHRNy7YKkKYmIy0+0UmN/6yTHLGtw6ytsMVVI=;
 b=KBY0cMSSYl9BNIH1ZZFWQBeEeHnvaI+HuZif75PG+rVFQtGqYZ6A8VWquQgloq58JMcP5MZ5PkyYVeo7tvQkSL/G3v1rkuSTr0TljBLUT8/hEsJpK7CezcWl0Fk5qY+yuso9K3LpkF4KAvTirTj9sum/a08bWmmva6cV7mMJUyM=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3959.eurprd08.prod.outlook.com (2603:10a6:20b:aa::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Thu, 22 Oct
 2020 08:46:45 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Thu, 22 Oct 2020
 08:46:45 +0000
Subject: Re: [PATCH] migration/block-dirty-bitmap: fix larger granularity
 bitmaps
To: Stefan Reiter <s.reiter@proxmox.com>, quintela@redhat.com,
 dgilbert@redhat.com
Cc: jsnow@redhat.com, eblake@redhat.com, fam@euphon.net, stefanha@redhat.com, 
 qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20201021144456.1072-1-s.reiter@proxmox.com>
 <0f3e0eba-28a3-7c6d-d8db-6831ab6a54f5@virtuozzo.com>
 <f7ad1bf2-067e-5de2-8ba4-6000761c7367@proxmox.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <b409b754-c63c-ad64-e108-a2e58f6dced8@virtuozzo.com>
Date: Thu, 22 Oct 2020 11:46:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
In-Reply-To: <f7ad1bf2-067e-5de2-8ba4-6000761c7367@proxmox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [185.215.60.82]
X-ClientProxiedBy: FR2P281CA0015.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::25) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.82) by
 FR2P281CA0015.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.7 via Frontend Transport; Thu, 22 Oct 2020 08:46:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4013d92-98c5-468e-ab22-08d8766701a1
X-MS-TrafficTypeDiagnostic: AM6PR08MB3959:
X-Microsoft-Antispam-PRVS: <AM6PR08MB3959C00CB0C9C77B15A021EBC11D0@AM6PR08MB3959.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7vKTSQ89rffyDSfZ7W/ojtdTzzQUalV5s73FwBDjqxZVmHsPlKu4lbB9ML1keEhxrKWO9dZHHhhn7c5YYcVlarA3r0l5lpDH11qV020e/s+4FY8bjoTg3cPp+61gGQ+YyjpI+1HjuFtHG1xWg8evQuQG4WomT8c2juNTajzq/0UimFo3j6pllL8FGqF81pSaWVaAOEdUpDYjv/tgcx8nPwfxvzzfRtFCdGP7MgHmnrfobkCRzY/Ps0iG/SmFnjeKbEIXjjpPWaRRoSoxIrh+c54QQo85Fj6nywDIWQWQKjs23GAHPMYhs8/PNyWTE/5mlK7v1DviNf12jeWKX24tF2dcW4tNvD8j241Z1v1w7IlH593hJWVB84f6fWk/7vMqByw5czGv5DFbk7k1tbfLwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39840400004)(396003)(376002)(346002)(136003)(2906002)(8676002)(86362001)(186003)(31686004)(956004)(16526019)(83380400001)(36756003)(2616005)(478600001)(4326008)(66476007)(66946007)(316002)(8936002)(16576012)(5660300002)(66556008)(26005)(53546011)(6486002)(31696002)(52116002)(14143004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: NJHITS4BQqirv2hHSUNZGRnr7zFfq5QIF70u78J8HBsa9nUO0Hb4jP/H4xQd0X9Cx8UXIomiU3J8bvY5NvpW3ZFPZBbuWAvc6FX0cY4lmOb945aQP8rFTbe1oiujcXI8GhKesHRgdKu1VD70L4bd2HfpSO94hdvhxU7Yxp7DtDIP70gp9dNCuK9osq2MskQ65p/WaCms6qtLuGJzDNafy6MoJRPuIGfbk2DWQR3MSZvWHen6vyGOl24KbxXLHdFPuf6+eh7NFBnB8MLMaZspnVziBhE8BC4oajG3QH6/vZSCMYHWQVk9Xuo3MkSQFn9JjNxuWNry9iB7xSTUENglkP3ZFF0gV1KXhzF13RXHo3SkIEvn64VwMFZTEPiPH/iyQ7A+7KsKjb3L/xQ82GitTEfXKDkWPYWp/Tk/rz3qdUZGXcoQPNDocN36edoUus1V2iN03vKiHdKef9bJvqVV+IfNLkNBsE+WQ1pqlU47roBPzh9nq+MmaFZ6DCmdpdBZyzaI9SO/rzuFxilfVQ4sVj5VORZ5fpgMl8YMPtiSbacziXMTuj6o7/JFI/W2sBuzPOAyxDdFs6s1C3m6L5UfhWcUhP2TO7xKLAMDDmezxdS2oycQ2uWPCok810RKDbkrhmaw1hMoBWZ0SdqkAgd5YA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4013d92-98c5-468e-ab22-08d8766701a1
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2020 08:46:45.5997 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nYVPPv3gUuzYyJFevbrRBlTwpDFQwsRlvC6Lbe68ANTVOyPizKPKjw69MY+qF9jWABCZTTVJveGZ9efs2SVuxusjUCI7HLzIORhmIfCEqaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3959
Received-SPF: pass client-ip=40.107.4.106;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 04:46:46
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_LOW=-0.7,
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

22.10.2020 10:46, Stefan Reiter wrote:
> On 10/21/20 5:17 PM, Vladimir Sementsov-Ogievskiy wrote:
>> 21.10.2020 17:44, Stefan Reiter wrote:
>>> sectors_per_chunk is a 64 bit integer, but the calculation is done in 32
>>> bits, leading to an overflow for coarse bitmap granularities.
>>>
>>> If that results in the value 0, it leads to a hang where no progress is
>>> made but send_bitmap_bits is constantly called with nr_sectors being 0.
>>>
>>> Signed-off-by: Stefan Reiter <s.reiter@proxmox.com>
>>> ---
>>>   migration/block-dirty-bitmap.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
>>> index 5bef793ac0..5398869e2b 100644
>>> --- a/migration/block-dirty-bitmap.c
>>> +++ b/migration/block-dirty-bitmap.c
>>> @@ -562,8 +562,9 @@ static int add_bitmaps_to_list(DBMSaveState *s, BlockDriverState *bs,
>>>           dbms->bitmap_alias = g_strdup(bitmap_alias);
>>>           dbms->bitmap = bitmap;
>>>           dbms->total_sectors = bdrv_nb_sectors(bs);
>>> -        dbms->sectors_per_chunk = CHUNK_SIZE * 8 *
>>> +        dbms->sectors_per_chunk = CHUNK_SIZE * 8lu *
>>
>> I'd prefer 8llu for absolute safety.
>>
>>>               bdrv_dirty_bitmap_granularity(bitmap) >> BDRV_SECTOR_BITS;
>>> +        assert(dbms->sectors_per_chunk != 0);
>>
>> I doubt that we need this assertion. Bug fixed, and it's obviously impossible.
>> And if we really want to assert that there is no overflow (assuming future changes),
>> it should look like this:
>>
>>    assert(bdrv_dirty_bitmap_granularity(bitmap) < (1ull << 63) / CHUNK_SIZE / 8 >> BDRV_SECTOR_BITS);
>>
>> to cover not only corner case but any overflow.. And of course we should modify original expression
>> to do ">> BDRV_SECTOR_BITS" earlier than all multiplies, like
>>
>>    dbms->sectors_per_chunk = CHUNK_SIZE * 8llu * (bdrv_dirty_bitmap_granularity(bitmap) >> BDRV_SECTOR_BITS);
>>
>>
>> But I think that only s/8/8ull/ change is enough.
>>
> 
> I agree, and I wouldn't mind removing the assert, but just to clarify it was mostly meant to prevent the case where the migration gets stuck entirely. Even if the calculation is wrong, it would at least do _something_ instead of endlessly looping.
> 
> Maybe an
> 
>      assert(nr_sectors != 0);
> 
> in send_bitmap_bits instead for that?

Hmm, just sending 0 sectors should not be a problem by itself. It's a problem when we don't make a progress in the loop in bulk_phase().. So, I'd prefer your original assertion, as sectors_per_chunk=0 is definitely wrong thing.

> 
>>>           if (bdrv_dirty_bitmap_enabled(bitmap)) {
>>>               dbms->flags |= DIRTY_BITMAP_MIG_START_FLAG_ENABLED;
>>>           }
>>>
>>
>>
>> With 8llu and with or without assertion:
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>
> 


-- 
Best regards,
Vladimir

