Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D660AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 10:52:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1CFE206D4
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 10:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="i30pGwbl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1CFE206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jazr8-00052Y-Sk
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 06:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jazqY-0004Z8-A8; Tue, 19 May 2020 06:51:42 -0400
Received: from mail-am6eur05on2128.outbound.protection.outlook.com
 ([40.107.22.128]:14368 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jazqW-0007nG-D4; Tue, 19 May 2020 06:51:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CxlVF9WNjEdvWKRjz0lKkwwoDATTi5QFT60bQ1Hyb763/jmgAQ7W77py5+8h61nnex48yCw2mgTkQGD/6PLtf+0w5E+gK0PTOwTkBWtBkOw69y4I6LkK7L9cDtzblQ8zve687HHPlT7GGQhgN53ruJCECMtarA05KXI/zegZHoLXJxKP9tSd0hKqeprZDa3YlcY0EU81B7VSWOBIbDbcNXhTUNbh9PmclyGfs7nc9kvFiXcDQAIUA8XjC5cC5YWqvXERfAcEKAXPRJ0T6qsjb1DhLXkSB9lvj+aazBRlVFDXsJJwCa8bKrlfYdfV391371HazyyxmKl3VzQMmO5Gpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/1qLS9ad1+qfcK8f4Owq0/z/qU+5X8FzRWYGFM3wO4=;
 b=U6On79UwGqyJqGB0XyTnrQLy1dY/ywHEaTszIOcUkXAHOVCimSYbSU883jPcDRFNbeEVFXzMsBCevsXk7BBItwJixXwuMoBK8Gov1YdcKtFqaL5mu3mTN8DCjm0LKpq1DnU2VhLblamZQ7/SvrFFkv6YpIO9UbPd0UqciL/rnoIucSpyLHpIZT4L+gbemcmLD4Bf8NGIoYg2Lba6RpsPAeqlxEVb0rIzAOnVPk+abhFdyfC6UbuPraNdmhmiNQTiNuQHGEeZRku0743KhzpAy0s+85ZqA7afstEmkB4NweFw/+4F3x/CHYhlOBLb8aPsxUGdVcgTmp2WQ1htQtNhBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/1qLS9ad1+qfcK8f4Owq0/z/qU+5X8FzRWYGFM3wO4=;
 b=i30pGwblsCXtuY18E2ZjxSVE+FphIoy+N6AeuLQ+RfZmITgeqTiFMmNxBLm2wjJ0DYCMhaofITJ4IQEq7S+5rZAJnrk5A+M+FAX7VZhZnR1EMobC9AeikUO2d2oobK0dUxm6YCcT2NzC77pUggeo82oMqz9rfOCyMS+fQbdtWHU=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5429.eurprd08.prod.outlook.com (2603:10a6:20b:107::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Tue, 19 May
 2020 10:51:37 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 10:51:37 +0000
Subject: Re: [PATCH v3 4/7] migration/block-dirty-bitmap: fix bitmaps
 pre-blockdev migration during mirror job
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200515124024.3491-1-vsementsov@virtuozzo.com>
 <20200515124024.3491-5-vsementsov@virtuozzo.com>
 <5cd24411-55bf-92c9-b5fe-2030c2915d1a@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <7dd23a01-96e7-b3c0-27b5-8c4b176a52d7@virtuozzo.com>
Date: Tue, 19 May 2020 13:51:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <5cd24411-55bf-92c9-b5fe-2030c2915d1a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR03CA0031.eurprd03.prod.outlook.com
 (2603:10a6:208:14::44) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.178) by
 AM0PR03CA0031.eurprd03.prod.outlook.com (2603:10a6:208:14::44) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.23 via Frontend Transport; Tue, 19 May 2020 10:51:36 +0000
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f33eaee-43ea-48c9-2482-08d7fbe29a77
X-MS-TrafficTypeDiagnostic: AM7PR08MB5429:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5429313056EB1C8979477717C1B90@AM7PR08MB5429.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dw6SA+++F+CWxYJ2DFbi/WBzkJB/1RRvnyFITkTYfaT+QEa8LRInrNdpXkZ1x1qQPGzN9/PqvCAJuPpRcKbrscVoVib2zO6qZn2ix1YKdSg9PT04pyiAopwZ8JhvTnb/UethGeCtWgNoGpBLlJdfewjbDsTQJes/WY2dlHCqeqdyWjG9S3drYLtNgpvOqY8ST7B0QSu5ABoN7km1kYZlWgbATx03NJPuGR27hH5HWWpTuzPJi1jjbChxp3diAPYQBZfp+YKsYq7itSFKcDutrXTapf6AQX5NMiIKvxHGUXyBJpeRYB7vIi4c6rMhhNiZSIfip2If4n+xYPsME4u/u1oiY3O++Y2BFrU8S97bR/7b+yfiP8G44KrQ+P0zEQmPHrmE8QCC1x6TxNlu9OxSUwY8C76LNAQWKkQCLvX/96l23lzlg78NQ/Kv6Kg/CsGY6mbKH2Gu2holGYuZD8k3SLiXmlCjnEfxK7yOhR2LM1a6nR6mtTPaYo8ZcB8xXtaQozVOJVu3ksIYoSgCNxWvEXY2/KtP+BqyoxNPR6Te5DAaHIqGloaSSJfh3jyGmixaPhHJgc3OFXtW7DfUXnA8nstbAXQKX9Wwjg1SJaVaHss=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(39840400004)(346002)(366004)(136003)(66946007)(31696002)(956004)(478600001)(7416002)(31686004)(8676002)(2616005)(4326008)(53546011)(8936002)(16576012)(6486002)(5660300002)(316002)(36756003)(26005)(52116002)(2906002)(966005)(107886003)(66476007)(66556008)(86362001)(16526019)(186003)(14143004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: OZjGFv3tYF85z5brx/WtQd6/nAaVcXsW8tQzJr6ki0aAGkEL41JR080jpjpB8XPmFej4LPhYj2hRSZkDoD0Kjy12bUt2Uyh6L3mwdMP5WCk/Ar8IVfmj8iBSQGM8Dtu23yGZxke8Jz2uQAHnrUrazO+OKzU7WJntn2NQd1ttzIvYoZF68tvm7I4Q7+T/2JWyZ5RTRW4aEDPD6DtN20fHWYx5t2n8QkrtJ4w1uTva6SxaJur++jtb5P+4clhkvq0Mn2kGBAJltDA8fDevP9P9SzfWB+qpGdWMrJAjMbfEhU1fAQS+/pQy9jqbFDbufUD+ZH3VSetgVJ6f1w+DiQzdSd0sl8yVmd9ZEzZeOhko7yCBPTMgCxkSFgT9joBpFEvvjNCL2qhNt00dOys8CaEbV19JIh4uEjDkjGKoooKLlKhfrdx1TBRFCpL9kGtFvmo1iwSPZJRCoYFXvDdH7CS9Er+U5xWGEHYpfsgdHIbrTOJlybxFURehMONQuznpnQQ5
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f33eaee-43ea-48c9-2482-08d7fbe29a77
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 10:51:37.1204 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pjAzT4CSuLU2DwexP/7E7QRYK1OoOA2kE/a9Pk358A8WqSrrvLYZEfurR376LiRL/WJWS0xeuhEYWwDmu060zIEsJJFiRQZDO6DLiy1OUJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5429
Received-SPF: pass client-ip=40.107.22.128;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 06:51:37
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
Cc: kwolf@redhat.com, fam@euphon.net, pavel.dovgaluk@ispras.ru,
 quintela@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com,
 mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, pbonzini@redhat.com,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

18.05.2020 23:36, Eric Blake wrote:
> On 5/15/20 7:40 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Important thing for bitmap migration is to select destination block
>> node to obtain the migrated bitmap.
>>
>> Prepatch, on source we use bdrv_get_device_or_node_name() to identify
>> the node, and on target we do bdrv_lookup_bs.
>> bdrv_get_device_or_node_name() returns blk name only for direct
>> children of blk. So, bitmaps of direct children of blks are migrated by
>> blk name and others - by node name.
>>
>> Old libvirt is unprepared to bitmap migration by node-name,
>> node-names are mostly auto-generated. So actually only migration by blk
>> name works for it.
>>
>> Newer libvirt will use new interface (which will be added soon) to
>> specify node-mapping for bitmaps migration explicitly. Still, let's
>> improve the current behavior a bit.
>>
>> Now, consider classic libvirt migrations assisted by mirror block job:
>> mirror block job inserts filter, so our source is not a direct child of
>> blk, and bitmaps are migrated by node-names. And this just don't work
> 
> either "won't" or "doesn't"
> 
>> with auto-generated node names
> 
> trailing '.'
> 
>>
>> Let's fix it by allowing use blk-name even if some implicit filters are
>> inserted.
> 
> s/allowing use/using/
> 
>>
>> Note2: we, of course, can't skip filters and use blk name to migrate
>> bitmaps in filtered node by blk name for this blk if these filters have
>> named bitmaps which should be migrated.
>>
>> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1652424
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   migration/block-dirty-bitmap.c | 39 +++++++++++++++++++++++++++++++++-
>>   1 file changed, 38 insertions(+), 1 deletion(-)
>>
>> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
>> index 7e93718086..5d3a7d2b07 100644
>> --- a/migration/block-dirty-bitmap.c
>> +++ b/migration/block-dirty-bitmap.c
>> @@ -319,14 +319,48 @@ static int init_dirty_bitmap_migration(void)
>>   {
>>       BlockDriverState *bs;
>>       DirtyBitmapMigBitmapState *dbms;
>> +    GHashTable *handled_by_blk = g_hash_table_new(NULL, NULL);
>> +    BlockBackend *blk;
>>       dirty_bitmap_mig_state.bulk_completed = false;
>>       dirty_bitmap_mig_state.prev_bs = NULL;
>>       dirty_bitmap_mig_state.prev_bitmap = NULL;
>>       dirty_bitmap_mig_state.no_bitmaps = false;
>> +    /*
>> +     * Use blockdevice name for direct (or filtered) children of named block
>> +     * backends.
>> +     */
>> +    for (blk = blk_next(NULL); blk; blk = blk_next(blk)) {
>> +        const char *name = blk_name(blk);
>> +
>> +        if (!name || strcmp(name, "") == 0) {
>> +            continue;
>> +        }
>> +
>> +        bs = blk_bs(blk);
>> +
>> +        /* Skip filters without bitmaos */
>> +        while (bs && bs->drv && bs->drv->is_filter &&
>> +               !bdrv_has_named_bitmaps(bs))
>> +        {
>> +            bs = bs->backing->bs ?: bs->file->bs;
> 
> Is this correct, or should it be:
> 
> bs = bs->backing ? bs->backing->bs : bs->file->bs;

Hmm, yes, otherwise it should crash on file-based filter :)

> 
> Otherwise looks reasonable, but I'm hesitant to include it in today's bitmap pull request in order to give it more review/testing time.  It should be ready for a pull request next week, though.
> 


-- 
Best regards,
Vladimir

