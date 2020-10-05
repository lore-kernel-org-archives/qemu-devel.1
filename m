Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A8AC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:25:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60C2F206DD
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="UTCjbBgM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60C2F206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPTIe-00048V-Fe
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 12:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kPTHL-0003As-3I; Mon, 05 Oct 2020 12:24:00 -0400
Received: from mail-eopbgr130110.outbound.protection.outlook.com
 ([40.107.13.110]:22464 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kPTHH-00068g-Ff; Mon, 05 Oct 2020 12:23:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n8PMxc8WUBxBic71X/+Ki6dzAxy+O3XTjxtUUWcTshEqiVGu/SB8G5HukQBEtH7Vph4ZL/KHMlpqlYvqump+VdgsSmgSmEr2PJVEaWKRMjKC/GzZy1dFDwPJCXxyRTNm/yLoQwbGR1oHpMkOuwJmJbn++SwCT/wQiiuGtOXUQ+2Gt3XrOxaRrRypxIq+JG5ymiZ4lvVYZt4Cs/AS5DjZIpWgrvpnGXyjm/dX6+t02Sky3pv3qk7IxWsUyZweuGI4PhSgeh6Zf/pPBX2PQc29HBTdy9vW/pRaznDlppV/xZh/Ldm3H6md7y6oI0puN3NjTNJWg3AQGPwCwEqnBHo1Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpzeEWUdh63h0AX1B/bTahS3gudzv7SmmdLqnkpHToA=;
 b=SfEJKv6bg6BxBvySGuUPXSA0Xx8okXKhULMNUf6XSSfwOEK0W8az9dvRyug3A+ly6TBKSdITVFGm9nG5pAdU0Y/vXg+tgTxQ55WPz2MkaTymI0E7ejZVDLWMxQUXQvol6ucMizy9U81/xl4fJ0un4aJ7ZJvkYABxwoIUh5/m0TT6o1LrMUwZAIqH5bBo7E58jsen5s2XBXHYIYRq0IWCAxeU6Fw1Mk3e4kEd9etBx2eD1PV02oZZf610kNbOlYFJYnCiV0z1tfSifT+J3wTy3ClaBi5MuIrlCqVRCbBsSgS6PrbupdKhlP0KmFhx2uGPxMadtwUult50TfC189LAwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpzeEWUdh63h0AX1B/bTahS3gudzv7SmmdLqnkpHToA=;
 b=UTCjbBgMFaBangDErKji+qeoYl4qWSTxn8kIxuGNbgDd4U4gCBECBH0458OLFYP1SIqU3R83eLVJje7kwP2btEaACuLKeiiedTYHDo7iTawMCJcb4m1vBxHq1vMXY4FKV7Q/XGTIsh84ij3iH6/u8P6h7hydZZxCnBuE5BHIb7k=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com (2603:10a6:3:89::22)
 by HE1PR0801MB1770.eurprd08.prod.outlook.com (2603:10a6:3:7d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.39; Mon, 5 Oct
 2020 16:23:47 +0000
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036]) by HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036%6]) with mapi id 15.20.3433.043; Mon, 5 Oct 2020
 16:23:47 +0000
Subject: Re: [PATCH v10 2/9] copy-on-read: add filter append/drop functions
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com,
 stefanha@redhat.com, fam@euphon.net, jsnow@redhat.com, armbru@redhat.com,
 eblake@redhat.com, den@openvz.org
References: <1601383109-110988-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1601383109-110988-3-git-send-email-andrey.shinkevich@virtuozzo.com>
 <777a8fc5-293b-2866-bbdf-01b181291b40@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <ba52d896-f876-6000-ec9c-1be98dfb6ebe@virtuozzo.com>
Date: Mon, 5 Oct 2020 19:23:43 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <777a8fc5-293b-2866-bbdf-01b181291b40@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [109.252.114.22]
X-ClientProxiedBy: AM0PR05CA0073.eurprd05.prod.outlook.com
 (2603:10a6:208:136::13) To HE1PR0801MB2124.eurprd08.prod.outlook.com
 (2603:10a6:3:89::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.22) by
 AM0PR05CA0073.eurprd05.prod.outlook.com (2603:10a6:208:136::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32 via Frontend
 Transport; Mon, 5 Oct 2020 16:23:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ba8cb47-eac0-4b9c-3505-08d8694b0908
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1770:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1770A1CDFA59CC2A670D3242F40C0@HE1PR0801MB1770.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DRJ/g1bVtUN2LOXhOsSM1Fm86NwZCoLB6LnJoHjS7GuCqlGCZI+SXkEKI24MaVv+S/+sCALujEGMup+v34V5A3kXtbpE1IQxizRJ4Jcyhul5mOgvDJCFGTBt23n5Tz5YYzpRRhdPUEwwCs28HAR4AJQ2nvagW4mh87UiGTc/6WsKVPiqy5K5Clk6kOph69Y69aREUFMwG69C76czzmiOfzyPVugFxXLma25CV66sEwpFpAqRRMGaItlgc2BzWSbY0WJDHe46ZS9qJ14zpOuf8z3KmOvF3MYk57CaKCyZfJeO3tcOlgbQuWSJ5d2hDLA9VDb1DQ+7E8CabBLRrP1aECbFGwAOeFL2AP5LQkNUG1RM8SagaBC1zE5rYucg5MxH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB2124.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(376002)(396003)(136003)(366004)(346002)(83380400001)(52116002)(478600001)(26005)(316002)(16526019)(186003)(107886003)(8676002)(66946007)(8936002)(6512007)(31696002)(31686004)(36756003)(66556008)(6506007)(66476007)(53546011)(2616005)(4326008)(5660300002)(6486002)(86362001)(44832011)(2906002)(956004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 8yKSEkROIvawVQXb2bCGnVzYIlXDa7dpOzoLxejVEPeNShg1Hki37HnbqGccaKJJegLuuu0dz62sibObM1t83x0mhQrlpzijIhQGbTwWI/RhzuYjLltO3NippybVSoJ107VIPRpoATjZ8TJqLKYK3+YWPzK2CDlQvXNQaEYxSjifEsQYoXhiwEG4Ha14b3tXQ11cxsgfqiDbRMdv48Z29YUAZh7g5+bYNkeOgb/xESXjj6DqR0i44pwn1iFrdvUnZBZQJkTKjBwftdv5Rp3saxNvHrQJv5as/Of2BCc0sEoiz8GCeTHC5/297Macp0jOWoMKdJ+F/dw0WRygm63pun+8ZzYBbggA8fj9GaU0cIsYjXkcbp3p1Iujtk0vfDlPrei89HKgFDUKAS8Gf76Oag4ux4xrAb3R3PuAb9URF0aB2us15O3r4PI6JGBYrlw7To8PInLf/U8IjLNfBIRteCjzFwPaouBAfggGQTpBwK95FoF55lPyQpDpWSG9p+1yw6nWVEt+Gs2UyzM/+7zqW74FCDSA8XB6PPXzc4LyD4pv1DhKSZmKRb7JmQm0JF8faJSrlroP39R1irzEthP3ssTBNaVLQF94u8UHgXjUU9vRlHKDaphsBYdQdxCDyHv9oL6eRA6zYAqhtyZI2kJpvg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba8cb47-eac0-4b9c-3505-08d8694b0908
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB2124.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2020 16:23:47.0340 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BrPNUxEdM50Y6+G58KMeggm/HCRaEcaGkCBAcByuKJs3dvV6s3wksaK2jLLc9Z9e0cw11ClRDajS+7Ip0L+tpZD5g3qqfB3y8At8eR5+doM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1770
Received-SPF: pass client-ip=40.107.13.110;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 12:23:49
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

On 05.10.2020 16:34, Vladimir Sementsov-Ogievskiy wrote:
> 29.09.2020 15:38, Andrey Shinkevich wrote:
>> Provide API for the COR-filter insertion/removal.
>> Also, drop the filter child permissions for an inactive state when the
>> filter node is being removed.
>>
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> ---
>>   block/copy-on-read.c | 84 
>> ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   block/copy-on-read.h | 35 ++++++++++++++++++++++
>>   2 files changed, 119 insertions(+)
>>   create mode 100644 block/copy-on-read.h
>>
>> diff --git a/block/copy-on-read.c b/block/copy-on-read.c
>> index cb03e0f..3c8231f 100644
>> --- a/block/copy-on-read.c
>> +++ b/block/copy-on-read.c
>> @@ -23,11 +23,21 @@
>>   #include "qemu/osdep.h"
>>   #include "block/block_int.h"
>>   #include "qemu/module.h"
>> +#include "qapi/error.h"
>> +#include "qapi/qmp/qdict.h"
>> +#include "block/copy-on-read.h"
>> +
>> +
>> +typedef struct BDRVStateCOR {
>> +    bool active;
>> +} BDRVStateCOR;
>>   static int cor_open(BlockDriverState *bs, QDict *options, int flags,
>>                       Error **errp)
>>   {
>> +    BDRVStateCOR *state = bs->opaque;
>> +
>>       bs->file = bdrv_open_child(NULL, options, "file", bs, 
>> &child_of_bds,
>>                                  BDRV_CHILD_FILTERED | 
>> BDRV_CHILD_PRIMARY,
>>                                  false, errp);
>> @@ -42,6 +52,13 @@ static int cor_open(BlockDriverState *bs, QDict 
>> *options, int flags,
>>           ((BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK) &
>>               bs->file->bs->supported_zero_flags);
>> +    state->active = true;
>> +
>> +    /*
>> +     * We don't need to call bdrv_child_refresh_perms() now as the 
>> permissions
>> +     * will be updated later when the filter node gets its parent.
>> +     */
>> +
>>       return 0;
>>   }
>> @@ -57,6 +74,17 @@ static void cor_child_perm(BlockDriverState *bs, 
>> BdrvChild *c,
>>                              uint64_t perm, uint64_t shared,
>>                              uint64_t *nperm, uint64_t *nshared)
>>   {
>> +    BDRVStateCOR *s = bs->opaque;
>> +
>> +    if (!s->active) {
>> +        /*
>> +         * While the filter is being removed
>> +         */
>> +        *nperm = 0;
>> +        *nshared = BLK_PERM_ALL;
>> +        return;
>> +    }
>> +
>>       *nperm = perm & PERM_PASSTHROUGH;
>>       *nshared = (shared & PERM_PASSTHROUGH) | PERM_UNCHANGED;
>> @@ -135,6 +163,7 @@ static void cor_lock_medium(BlockDriverState *bs, 
>> bool locked)
>>   static BlockDriver bdrv_copy_on_read = {
>>       .format_name                        = "copy-on-read",
>> +    .instance_size                      = sizeof(BDRVStateCOR),
>>       .bdrv_open                          = cor_open,
>>       .bdrv_child_perm                    = cor_child_perm,
>> @@ -159,4 +188,59 @@ static void bdrv_copy_on_read_init(void)
>>       bdrv_register(&bdrv_copy_on_read);
>>   }
>> +
>> +BlockDriverState *bdrv_cor_filter_append(BlockDriverState *bs,
>> +                                         QDict *node_options,
>> +                                         int flags, Error **errp)
> 
> 
> Ok, now function can add ~any filter, not only COR.. But it's a pair for 
> bdrv_cor_filter_drop(), and with "active" hack we don't want make the 
> functions generic I think. So it's OK for now to keep function here and 
> named _cor_.
> 
>> +{
>> +    BlockDriverState *cor_filter_bs;
>> +    Error *local_err = NULL;
>> +
>> +    cor_filter_bs = bdrv_open(NULL, NULL, node_options, flags, errp);
>> +    if (cor_filter_bs == NULL) {
>> +        error_prepend(errp, "Could not create COR-filter node: ");
>> +        return NULL;
>> +    }
> 
> You've dropped setting ->implicit field if filter_node_name not 
> specified. Probably caller now can do it.. I don't really care about 
> implicit case, so it's OK for me if it works with iotests.

Thank you for your R-B. The idea behind setting the 'implicit' member by 
a caller is to prepare the code for the node replacement by a function 
at the block generic layer in future. In the scope of this series, that 
may be better to keep it here.

Andrey

> 
> So,
> 
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 
> 

