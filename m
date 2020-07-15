Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62324C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 12:59:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CBEE20657
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 12:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="mpuoA81S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CBEE20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvh08-0000xd-FC
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 08:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jvgzL-0008VU-FR; Wed, 15 Jul 2020 08:58:19 -0400
Received: from mail-am6eur05on2121.outbound.protection.outlook.com
 ([40.107.22.121]:9965 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jvgzI-00023j-J5; Wed, 15 Jul 2020 08:58:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fapPV8M1YMFFZQhOR+Fp2sBw0T/zlBzSaKYv1QquuuGXthczzNp0jj9kidCECuA0hMin2l9RNccqy0xyRDHwQvpR2lDQoxQpswB0cGwiBWdz03O18F7EMzqjVYOqUA4IkmNluQL6BpPWAmkRuVmydLvNEsc72TkfjtvQSZRBsOigAZXTwrs+mRo828ejXCSLMSgG1cM+4W8cEJ9jjYJxFuxYwZuZ6c5FZFzH0Lnum4FZ+a64raPiegihsDROfQ+ufuGOWYnrV1gh5rqMWkE2TWP2TAfA7a+EKU1S+du3CLyPUr8tlkxi60cLd1ZPw0bwCWp49RTmBjs1rVnWPJGLJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5xwQP0z47UjmN4+jMXakNiau+CdY5ddT1sK0uXyefY=;
 b=kPxWSlkmkjLEiHlp9RzAmNuP/A1VWNM3KTBZIr5GCBzKlZXS/Fxf1On8ML66OYwq4evfyJZi/uPywB+8LPuYfnOcIa+ZEPLxrvRcyzKLeRfdC1L5gYVWpmDeX66QziZag3pRhJMe8tqYMPn+bhTYI0DJxNV4YiKGAOFEPskZ+SVw4xgKzZCmNekX4fgLrkk/3mxZwrTnz2Fy4PgADHOgtrdHGnTBm4ZNBatUQVMNtzOwxfNXnCCkcwtrdl1/iCxds6JQpyqe69ng6UapNwUKIcfpHSyoNVd011UnovEyi/U7YD6WDuEiXOckcHbwW8AysH2P/ewJ533R4q2z6SW9KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5xwQP0z47UjmN4+jMXakNiau+CdY5ddT1sK0uXyefY=;
 b=mpuoA81SOiAxCB2pPn7vfICJrx4p2RHtrUqcHYwyF2E1X6EzezawVgcB9gcCuCnjtXe6fxWfmXK/pbSBZRL4jvFBGlukL9gxgPsW45t/SXwzdUMuzWG/vACODDqanUJbioRTPUZkfgxYFAK2Cca/vXB4eItwiWzy1QrY+lXxRSY=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB4850.eurprd08.prod.outlook.com (2603:10a6:20b:d2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Wed, 15 Jul
 2020 12:58:13 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3195.018; Wed, 15 Jul 2020
 12:58:13 +0000
Subject: Re: [PATCH v7 21/47] block: Use CAFs in bdrv_refresh_filename()
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-22-mreitz@redhat.com>
 <71aca7a2-ebb0-92f3-c943-6a876cf9f57c@virtuozzo.com>
Message-ID: <470d137a-75dc-650b-a324-6d11d1c3155d@virtuozzo.com>
Date: Wed, 15 Jul 2020 15:58:10 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <71aca7a2-ebb0-92f3-c943-6a876cf9f57c@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AM3PR07CA0096.eurprd07.prod.outlook.com
 (2603:10a6:207:6::30) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 AM3PR07CA0096.eurprd07.prod.outlook.com (2603:10a6:207:6::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17 via Frontend Transport; Wed, 15 Jul 2020 12:58:12 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 762d2636-ce5d-41d4-fa98-08d828bebbd4
X-MS-TrafficTypeDiagnostic: AM6PR08MB4850:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB485007094554ED65F6389CA3F47E0@AM6PR08MB4850.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z0jdLiqsSv2gJU39zUU7fu3rJ0nFYmkCKXJjNLzhk4CpzYJCuhmn0z+yYNhL+CD204/q8/SbGzBJAhZ5J3uFxPfw6a9cRRKSjtemmS+bE3/LpMmz2Qow0o9/Zk4vjJZlsgVazuDqv8g1g0LO0MTnVK0ry2pAh4OKnTkivkXwLiFntIx5J7uZjxRqnuPidOgQxu0kD6x4Xk0TE+s9nHjKtQbYrESTAxGWYmt5e+Uw7ok2Y5p2y1eibh3vISTf3rnpMSMTKqmbEz8KV29PeQCDvIQ0iPu4HJVDi4qbpHG3lOeMdqqdIUZ0ydrTwvRgBdKh9mLLUlWHkR/i9/eBm7n/JqeIyQmIug/CJZ45svCF41bBUn4vZXYFBXiiSp6chBLz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(376002)(136003)(366004)(39840400004)(186003)(16526019)(44832011)(5660300002)(66556008)(66476007)(66946007)(31686004)(2616005)(83380400001)(478600001)(6486002)(36756003)(54906003)(6512007)(4326008)(52116002)(53546011)(956004)(86362001)(31696002)(26005)(6506007)(2906002)(8936002)(8676002)(316002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ILMRC6I5oQLC9TjQ3UU4PYmvLK2La1evyGXEArph4PU8KvBLg0kqNZuJ+74TQ8kmmvdSXSXxkrmvPru33nEHbGCwARBF5zT2ULq6EgT8N9Wwaq3hO6r8QGu3pQSVs8QQeH1Qn9oNYR63VfUYSmj8swxPhmQwBjRjkX6tIo/M56ruFKmVZCEHpEyuRfqiAOvVqg4LTSZH1ACb0Vf4jwYXzeH3yLfgVdcBXP2YXhUpHny6chdu1YzuyWs8fT6RXNilbOzQaZBKCgwhF5CGkWG/RBiTHMyRY/E0ahAaqOHtfSA1HxwR8hOcGXRar4u458GMg3XeSxyMsaBbgs6Z3prSh/ZsaquePS+6Kyss/JtWHaQKr2m4DIMeSXi3P4+QBhjQl20BU/QPzNRQbhuhlAkilAXiquFLtFOWGKYaG1/+QCNyW500BiJFVCG/pDINg6nzUvk9l2cUvjxYxMZWu/feqeboobplBcEuNPhzAMyS+QZZOX7yvSYlU7fr1KCws+oA
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 762d2636-ce5d-41d4-fa98-08d828bebbd4
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2020 12:58:13.4588 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hAqOew+nzYgk7Gs/hLBOk7Zhhdf3xuwttBB1Dia3hY5yDFP1l3ypC5Peo2KpAc5D+2xH3O0DU/X7hHrsJC7hRcoffcqx3nbrv0lpyCMpZrs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4850
Received-SPF: pass client-ip=40.107.22.121;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 08:58:14
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 15.07.2020 15:52, Andrey Shinkevich wrote:
> On 25.06.2020 18:21, Max Reitz wrote:
>> bdrv_refresh_filename() and the kind of related bdrv_dirname() should
>> look to the primary child when they wish to copy the underlying file's
>> filename.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>   block.c | 29 +++++++++++++++++++++--------
>>   1 file changed, 21 insertions(+), 8 deletions(-)
>>
>> diff --git a/block.c b/block.c
>> index 8131d0b5eb..7c827fefa0 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -6797,6 +6797,7 @@ void bdrv_refresh_filename(BlockDriverState *bs)
>>   {
>>       BlockDriver *drv = bs->drv;
>>       BdrvChild *child;
>> +    BlockDriverState *primary_child_bs;
>>       QDict *opts;
>>       bool backing_overridden;
>>       bool generate_json_filename; /* Whether our default 
>> implementation should
>> @@ -6866,20 +6867,30 @@ void bdrv_refresh_filename(BlockDriverState *bs)
>>       qobject_unref(bs->full_open_options);
>>       bs->full_open_options = opts;
>>   +    primary_child_bs = bdrv_primary_bs(bs);
>> +
>>       if (drv->bdrv_refresh_filename) {
>>           /* Obsolete information is of no use here, so drop the old 
>> file name
>>            * information before refreshing it */
>>           bs->exact_filename[0] = '\0';
>>             drv->bdrv_refresh_filename(bs);
>> -    } else if (bs->file) {
>> -        /* Try to reconstruct valid information from the underlying 
>> file */
>> +    } else if (primary_child_bs) {
>> +        /*
>> +         * Try to reconstruct valid information from the underlying
>> +         * file -- this only works for format nodes (filter nodes
>> +         * cannot be probed and as such must be selected by the user
>> +         * either through an options dict, or through a special
>> +         * filename which the filter driver must construct in its
>> +         * .bdrv_refresh_filename() implementation).
>> +         */
>
>
> The caller may not be aware of a filter node and intend to refresh the 
> name of underlying format node.
>
> In that case, the filter driver should redirect the call to the format 
> node.
>
> What are situations the name of the filter itself should be refreshed in?
>
> If there are any, should we do both actions or choose either?
>
> Andrey
>

I ment the node FILE name.

Andrey


>
>>             bs->exact_filename[0] = '\0';
>>             /*
>>            * We can use the underlying file's filename if:
>>            * - it has a filename,
>> +         * - the current BDS is not a filter,
>
>
> Should we check the function input parameter for being a filter's BS 
> here, in this function, and handle the case here or let the filter 
> driver function do that or else the caller should check it?
>
> Andrey
>
>
>>            * - the file is a protocol BDS, and
>>            * - opening that file (as this BDS's format) will 
>> automatically create
>>            *   the BDS tree we have right now, that is:
>> @@ -6888,11 +6899,11 @@ void bdrv_refresh_filename(BlockDriverState *bs)
>>            *   - no non-file child of this BDS has been overridden by 
>> the user
>>            *   Both of these conditions are represented by 
>> generate_json_filename.
>>            */
>> -        if (bs->file->bs->exact_filename[0] &&
>> -            bs->file->bs->drv->bdrv_file_open &&
>> -            !generate_json_filename)
>> +        if (primary_child_bs->exact_filename[0] &&
>> +            primary_child_bs->drv->bdrv_file_open &&
>> +            !drv->is_filter && !generate_json_filename)
>>           {
>> -            strcpy(bs->exact_filename, bs->file->bs->exact_filename);
>> +            strcpy(bs->exact_filename, 
>> primary_child_bs->exact_filename);
>>           }
>>       }
>>   @@ -6912,6 +6923,7 @@ void bdrv_refresh_filename(BlockDriverState *bs)
>>   char *bdrv_dirname(BlockDriverState *bs, Error **errp)
>>   {
>>       BlockDriver *drv = bs->drv;
>> +    BlockDriverState *child_bs;
>>         if (!drv) {
>>           error_setg(errp, "Node '%s' is ejected", bs->node_name);
>> @@ -6922,8 +6934,9 @@ char *bdrv_dirname(BlockDriverState *bs, Error 
>> **errp)
>>           return drv->bdrv_dirname(bs, errp);
>>       }
>>   -    if (bs->file) {
>> -        return bdrv_dirname(bs->file->bs, errp);
>> +    child_bs = bdrv_primary_bs(bs);
>> +    if (child_bs) {
>> +        return bdrv_dirname(child_bs, errp);
>>       }
>>         bdrv_refresh_filename(bs);
>

