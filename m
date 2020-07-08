Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFB2C433E1
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 16:18:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4950220786
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 16:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="biRWqA6B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4950220786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtCmT-0001rm-EJ
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 12:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jtCln-0001MN-0N; Wed, 08 Jul 2020 12:18:03 -0400
Received: from mail-eopbgr30121.outbound.protection.outlook.com
 ([40.107.3.121]:17123 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jtCli-00044o-H5; Wed, 08 Jul 2020 12:18:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YrjJlmTXXxvgLovfUf8pHhxzuvXTKbJr3klqzUAYu7fqhK7zz+vybDl9/RRx7n1bjaQP5hdvFIGixIXkz4OwczURnaWG8iQlCecg415fw8P5fmiDnvWE0Lh658V7ombOpYPM4MykNiiXk6CSKGdt7+sn57VejXTm5Dp+wNweiBVoRYkJwZ2l2iDfb6k/HSQ8wBEaHAqu/ioQSF0/hHGyoNsd3tztUDo6hHlgFhzYtomIyKUF6keXyPmKLTJ0p1sOzoAjJlhO4NMmVEBbWOt5G87AwdOxDuoeiebwPa/FH+IzKfg++UrCAKNWHcYhuyI0zL9DACOt0aVWucNSsEYGpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1AVKaf8byY/phk9qfA4JoEiLDZiHHfxfy/h41iJ3iU=;
 b=kTy+zTQLYUsM9jfC2C2C59oDyXsdFbhjjue0YPbl4fbH8AjeEvyWqR+ln+71Bdzb5u5B4rmSTznap/b7GwVvlVAd2or/kHItkd/BYaRlGwJO1opLEhFBjUz5+dK6Tn4rdNxV3R+mf8A+DZx/Bllx9OkDIbL9H7c92AK27M9cT2WswHBFGVypmQNPCap6K6A4oLzOLWBc6wX0EkNFc/fK8/0OqCXQKbkfacYxRR49nmNZQSSOD/Y5oNZOaQQMghHpJElxAWEdcqYVf/tEy433/YWK6FzHCSrTL0y2dAUHls3/G50WydGtCqegz/2pzlyzYmSR4BOPwnVaN5uY0ecENw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1AVKaf8byY/phk9qfA4JoEiLDZiHHfxfy/h41iJ3iU=;
 b=biRWqA6BO+moAQWm6rNYBaUjXk2HCnW2XFwGDRFgTnjckQ9434wwAA/8ggNhsowJOygi6VYBPNZ7CndW+3LucD/haOIzYQ6LIPp2dT9H5AEOcMhcCBnpN/qvEaQqK2ObzFU+ThCFanckMwLDQ2UM1NKj3+H6R/0lqvaSmUCcPGw=
Authentication-Results: acronis.com; dkim=none (message not signed)
 header.d=none;acronis.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4599.eurprd08.prod.outlook.com (2603:10a6:20b:8f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22; Wed, 8 Jul
 2020 16:17:54 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3174.021; Wed, 8 Jul 2020
 16:17:54 +0000
Subject: Re: [PATCH 3/5] block: introduce preallocate filter
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20200620143649.225852-1-vsementsov@virtuozzo.com>
 <20200620143649.225852-4-vsementsov@virtuozzo.com>
 <20200708120726.GC459887@stefanha-x1.localdomain>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <9a351987-6532-65d8-d144-defd04b5bba4@virtuozzo.com>
Date: Wed, 8 Jul 2020 19:17:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200708120726.GC459887@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR05CA0077.eurprd05.prod.outlook.com
 (2603:10a6:208:136::17) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.17) by
 AM0PR05CA0077.eurprd05.prod.outlook.com (2603:10a6:208:136::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend
 Transport; Wed, 8 Jul 2020 16:17:53 +0000
X-Originating-IP: [185.215.60.17]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4766351b-1448-41ac-36b9-08d8235a7825
X-MS-TrafficTypeDiagnostic: AM6PR08MB4599:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB45994CDDA47E268AE9238452C1670@AM6PR08MB4599.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 04583CED1A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CQcuQauTW6bxotuZALg2Z8+efjk9dExwCnYw67B98t2rYqnr70yY52EPDGjGhl5hP94/v/73ZHDSWq5kPwmF8u74xAZKju3elGaCzqhoMkbqcncFQNCOm3EqG+btSwc5tyJi38letpvKRiOXy9/POhFgHJkYSXNj2/vxdjla6lZ1xcbDr//8roeZJ8InWvxsnLj7ZK0pnrecL2rWgY2243M19JOmT18DbLc7KJhqwkv9LDrsrGgVncac2nr7k0QCg32kv/H2c4rvkJ36t4sUtlBkpOY2uljtvUGuyr43itQ1rTgjVOEhuK8MBH2K+rF+qFiVyGlCvftBvuA1I5sSMndZuM3Y3cMg7jpNjLP4pZZHM/Vlwn03IZmo/z1JeftWrzjqwyx2+liSZmtysNGLf0RemVFvD9uzKQ13votdWS+Huiu90g71ual2z/3saA1SCZGuqpZobH3iOMjvE/V6uzfbA6kas5IMD95jcl7MEg8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(39840400004)(366004)(396003)(136003)(316002)(8936002)(31696002)(66556008)(66946007)(66476007)(16576012)(6486002)(2616005)(956004)(4326008)(8676002)(478600001)(86362001)(2906002)(5660300002)(16526019)(30864003)(186003)(26005)(6916009)(31686004)(83380400001)(36756003)(52116002)(2004002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 00IG2Gxsw5BplsLbpCy4WYgfFfW6GkT6cRmRizHnGlL6xP4fxxn0mdGSX8kn5yoUvOX1OiCux0XJPDVFEEUIAi4IB/PF2Kwq8qyEu9khPlPI+hZxmrIIRV7yW7Tbi8MSLRrzK8/0o3X9y97ah/+mInczO9674GDPB7LwUvaMWpfhIDaPh16dzOKml2VacEl7GhDb2QH41Ztzb1RmShP9OaWKQct/SSncQ0/kD1zOAEewiaOOjhYK44sEfPOL3UW4jJl2TN3GS00hwghgd4b1KyV6UgLWW1Xk9XTPwlWXspbioUzvdrJ/KG0mQULrNgTMzt3ppBX8gr3wqpO8W6bA4FOUOBO1/s5idjU8V5efqRaOBj6Sns5ih1ieIXb8BvlLzK8Y4t4CGSw5zlsjLNdL4Km7iDaLYg2Rmz4P7wGvOYNn37StN3MsoOvXaJhJGB9YyjOV1W8Ofuvoemd3Xq06wqw0cOd5g5+Gs3ASsGLpsTg=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4766351b-1448-41ac-36b9-08d8235a7825
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 16:17:54.3903 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VMTFeZ/x/Ex2k2BbxgIaXa177o7z8RfMonXKm8oa+NEwGcaqdu4JeMSRcKzvD1yIUZ5VO4HwOLAhzh+2DkTdXIxMRKmVq4gmhFgVDR08dhA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4599
Received-SPF: pass client-ip=40.107.3.121;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/08 12:17:55
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-block@nongnu.org,
 Anton.Nefedov@acronis.com, armbru@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

08.07.2020 15:07, Stefan Hajnoczi wrote:
> On Sat, Jun 20, 2020 at 05:36:47PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> It may be used for file-systems with slow allocation.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   qapi/block-core.json |   3 +-
>>   block/preallocate.c  | 255 +++++++++++++++++++++++++++++++++++++++++++
>>   block/Makefile.objs  |   1 +
>>   3 files changed, 258 insertions(+), 1 deletion(-)
>>   create mode 100644 block/preallocate.c
> 
> Please add documentation to docs/system/qemu-block-drivers.rst.inc
> describing the purpose of this block driver and how to use it.

This implies adding new section "Filters", yes?

> 
> Since this filter grows the file I guess it's intended to be below an
> image format?

Yes, between format and protocol nodes.

> 
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index 0e1c6a59f2..a0bda399d6 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -2805,7 +2805,7 @@
>>               'cloop', 'compress', 'copy-on-read', 'dmg', 'file', 'ftp', 'ftps',
>>               'gluster', 'host_cdrom', 'host_device', 'http', 'https', 'iscsi',
>>               'luks', 'nbd', 'nfs', 'null-aio', 'null-co', 'nvme', 'parallels',
>> -            'qcow', 'qcow2', 'qed', 'quorum', 'raw', 'rbd',
>> +            'preallocate', 'qcow', 'qcow2', 'qed', 'quorum', 'raw', 'rbd',
>>               { 'name': 'replication', 'if': 'defined(CONFIG_REPLICATION)' },
>>               'sheepdog',
>>               'ssh', 'throttle', 'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat', 'vxhs' ] }
>> @@ -3995,6 +3995,7 @@
>>         'null-co':    'BlockdevOptionsNull',
>>         'nvme':       'BlockdevOptionsNVMe',
>>         'parallels':  'BlockdevOptionsGenericFormat',
>> +      'preallocate':'BlockdevOptionsGenericFormat',
>>         'qcow2':      'BlockdevOptionsQcow2',
>>         'qcow':       'BlockdevOptionsQcow',
>>         'qed':        'BlockdevOptionsGenericCOWFormat',
>> diff --git a/block/preallocate.c b/block/preallocate.c
>> new file mode 100644
>> index 0000000000..c272a6e41d
>> --- /dev/null
>> +++ b/block/preallocate.c
>> @@ -0,0 +1,255 @@
>> +/*
>> + * preallocate filter driver
>> + *
>> + * The driver performs preallocate operation: it is injected above
>> + * some node, and before each write over EOF it does additional preallocating
>> + * write-zeroes request.
>> + *
>> + * Copyright (c) 2020 Virtuozzo International GmbH.
>> + *
>> + * Author:
>> + *  Sementsov-Ogievskiy Vladimir <vsementsov@virtuozzo.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +
>> +#include "qemu/module.h"
>> +#include "qemu/units.h"
>> +#include "block/block_int.h"
>> +
>> +
>> +typedef struct BDRVPreallocateState {
>> +    int64_t prealloc_size;
>> +    int64_t prealloc_align;
>> +
>> +    /*
>> +     * Track real data end, to crop preallocation on close  data_end may be
>> +     * negative, which means that actual status is unknown (nothing cropped in
>> +     * this case)
>> +     */
>> +    int64_t data_end;
>> +} BDRVPreallocateState;
>> +
>> +
>> +static int preallocate_open(BlockDriverState *bs, QDict *options, int flags,
>> +                            Error **errp)
>> +{
>> +    BDRVPreallocateState *s = bs->opaque;
>> +
>> +    /*
>> +     * Parameters are hardcoded now. May need to add corresponding options in
>> +     * future.
>> +     */
> 
> The code for .bdrv_open() options is quick to write. If you add the
> options right away then it will be much easier for users who need to
> tweak them in the future.

OK

> 
>> +    s->prealloc_align = 1 * MiB;
>> +    s->prealloc_size = 128 * MiB;
>> +
>> +    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_of_bds,
>> +                               BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
>> +                               false, errp);
>> +    if (!bs->file) {
>> +        return -EINVAL;
>> +    }
>> +
>> +    s->data_end = bdrv_getlength(bs->file->bs);
>> +    if (s->data_end < 0) {
>> +        return s->data_end;
>> +    }
>> +
>> +    bs->supported_write_flags = BDRV_REQ_WRITE_UNCHANGED |
>> +        (BDRV_REQ_FUA & bs->file->bs->supported_write_flags);
>> +
>> +    bs->supported_zero_flags = BDRV_REQ_WRITE_UNCHANGED |
>> +        ((BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK) &
>> +            bs->file->bs->supported_zero_flags);
>> +
>> +    return 0;
>> +}
>> +
>> +static void preallocate_close(BlockDriverState *bs)
>> +{
>> +    BDRVPreallocateState *s = bs->opaque;
>> +
>> +    if (s->data_end >= 0 && bdrv_getlength(bs->file->bs) > s->data_end) {
>> +        bdrv_truncate(bs->file, s->data_end, true, PREALLOC_MODE_OFF, 0, NULL);
>> +    }
>> +}
>> +
>> +static void preallocate_child_perm(BlockDriverState *bs, BdrvChild *c,
>> +                                   BdrvChildRole role,
>> +                                   BlockReopenQueue *reopen_queue,
>> +                                   uint64_t perm, uint64_t shared,
>> +                                   uint64_t *nperm, uint64_t *nshared)
>> +{
>> +    bdrv_default_perms(bs, c, role, reopen_queue, perm, shared, nperm, nshared);
>> +
>> +    /* Force RESIZE permission, to be able to crop file on close() */
>> +    *nperm |= BLK_PERM_RESIZE;
>> +}
>> +
>> +static coroutine_fn int preallocate_co_preadv_part(
>> +        BlockDriverState *bs, uint64_t offset, uint64_t bytes,
>> +        QEMUIOVector *qiov, size_t qiov_offset, int flags)
>> +{
>> +    return bdrv_co_preadv_part(bs->file, offset, bytes, qiov, qiov_offset,
>> +                               flags);
>> +}
>> +
>> +static int coroutine_fn preallocate_co_pdiscard(BlockDriverState *bs,
>> +                                               int64_t offset, int bytes)
>> +{
>> +    return bdrv_co_pdiscard(bs->file, offset, bytes);
>> +}
>> +
>> +static bool coroutine_fn do_preallocate(BlockDriverState *bs, int64_t offset,
>> +                                       int64_t bytes, bool write_zero)
>> +{
>> +    BDRVPreallocateState *s = bs->opaque;
>> +    int64_t len, start, end;
>> +    BdrvTrackedRequest *lock;
>> +    int ret;
>> +
>> +    if (s->data_end >= 0) {
>> +        s->data_end = MAX(s->data_end,
>> +                          QEMU_ALIGN_UP(offset + bytes, BDRV_SECTOR_SIZE));
>> +    }
>> +
>> +    len = bdrv_getlength(bs->file->bs);
>> +    if (len < 0) {
>> +        return false;
>> +    }
>> +
>> +    if (s->data_end < 0) {
>> +        s->data_end = MAX(len,
>> +                          QEMU_ALIGN_UP(offset + bytes, BDRV_SECTOR_SIZE));
>> +    }
>> +
>> +    if (offset + bytes <= len) {
>> +        return false;
>> +    }
>> +
>> +    lock = bdrv_co_range_try_lock(bs->file->bs, len, INT64_MAX - len);
>> +    if (!lock) {
>> +        /* There are already preallocating requests in-fligth */
> 
> s/fligth/flight/
> 
>> +        return false;
>> +    }
>> +
>> +    /* Length should not have changed */
>> +    assert(len == bdrv_getlength(bs->file->bs));
>> +
>> +    start = write_zero ? MIN(offset, len) : len;
>> +    end = QEMU_ALIGN_UP(offset + bytes + s->prealloc_size, s->prealloc_align);
>> +
>> +    ret = bdrv_co_pwrite_zeroes_locked(bs->file, start, end - start,
>> +                                       BDRV_REQ_NO_FALLBACK, lock);
>> +
>> +    bdrv_co_range_unlock(lock);
> 
> Hmm...if this piece of code is the only user of bdrv_co_range_try_lock()
> then a BDRV_REQ_NO_WAIT flag might be a simpler API.
> 
> I thought the lock request would be used to perform multiple operations,
> but if it's just for a single operation then I think it's less code and
> easier to understand without the lock request.

Hmm, again, I don't remember exact reasons. Firstly, I was afraid of length
change during try_lock and have a double check for bdrv_getlength(). Then
I decided that it's impossible and change the check to an assertion.
Probably, the only reason to leave locked range was "I already have the code,
it will help with copy-on-read, why not to use it".. OK, I'll try rewrite it
with help of new flag.

> 
>> +
>> +    return !ret;
>> +}
>> +
>> +static int coroutine_fn preallocate_co_pwrite_zeroes(BlockDriverState *bs,
>> +        int64_t offset, int bytes, BdrvRequestFlags flags)
>> +{
>> +    if (do_preallocate(bs, offset, bytes, true)) {
>> +        return 0;
>> +    }
>> +
>> +    return bdrv_co_pwrite_zeroes(bs->file, offset, bytes, flags);
>> +}
>> +
>> +static coroutine_fn int preallocate_co_pwritev_part(BlockDriverState *bs,
>> +                                                    uint64_t offset,
>> +                                                    uint64_t bytes,
>> +                                                    QEMUIOVector *qiov,
>> +                                                    size_t qiov_offset,
>> +                                                    int flags)
>> +{
>> +    do_preallocate(bs, offset, bytes, false);
>> +
>> +    return bdrv_co_pwritev_part(bs->file, offset, bytes, qiov, qiov_offset,
>> +                                flags);
>> +}
>> +
>> +static int coroutine_fn
>> +preallocate_co_truncate(BlockDriverState *bs, int64_t offset,
>> +                        bool exact, PreallocMode prealloc,
>> +                        BdrvRequestFlags flags, Error **errp)
>> +{
>> +    BDRVPreallocateState *s = bs->opaque;
>> +    int ret = bdrv_co_truncate(bs->file, offset, exact, prealloc, flags, errp);
>> +
>> +    /* s->data_end may become negative here, which means unknown data end */
>> +    s->data_end = bdrv_getlength(bs->file->bs);
>> +
>> +    return ret;
>> +}
>> +
>> +static int coroutine_fn preallocate_co_flush(BlockDriverState *bs)
>> +{
>> +    if (!bs->file) {
>> +        return 0;
>> +    }
> 
> When does this happen? It's surprising to see the !bs->file check here
> but not in other functions.

It's just done line in mirror-top and backup-top.. But seems there should not be such an issue. Will drop.

> 
>> +
>> +    return bdrv_co_flush(bs->file->bs);
>> +}
>> +
>> +static int64_t preallocate_getlength(BlockDriverState *bs)
>> +{
>> +    /*
>> +     * We probably can return s->data_end here, but seems safer to return real
>> +     * file length, not trying to hide the preallocation.
>> +     *
>> +     * Still, don't miss the chance to restore s->data_end if it is broken.
>> +     */
>> +    BDRVPreallocateState *s = bs->opaque;
>> +    int64_t ret = bdrv_getlength(bs->file->bs);
>> +
>> +    if (s->data_end < 0) {
>> +        s->data_end = ret;
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +BlockDriver bdrv_preallocate_filter = {
>> +    .format_name = "preallocate",
>> +    .instance_size = sizeof(BDRVPreallocateState),
>> +
>> +    .bdrv_getlength = preallocate_getlength,
>> +    .bdrv_open = preallocate_open,
>> +    .bdrv_close = preallocate_close,
>> +
>> +    .bdrv_co_preadv_part = preallocate_co_preadv_part,
>> +    .bdrv_co_pwritev_part = preallocate_co_pwritev_part,
>> +    .bdrv_co_pwrite_zeroes = preallocate_co_pwrite_zeroes,
>> +    .bdrv_co_pdiscard = preallocate_co_pdiscard,
>> +    .bdrv_co_flush = preallocate_co_flush,
>> +    .bdrv_co_truncate = preallocate_co_truncate,
>> +
>> +    .bdrv_co_block_status = bdrv_co_block_status_from_file,
>> +
>> +    .bdrv_child_perm = preallocate_child_perm,
>> +
>> +    .has_variable_length = true,
>> +    .is_filter = true,
>> +};
>> +
>> +static void bdrv_preallocate_init(void)
>> +{
>> +    bdrv_register(&bdrv_preallocate_filter);
>> +}
>> +
>> +block_init(bdrv_preallocate_init);
>> diff --git a/block/Makefile.objs b/block/Makefile.objs
>> index 3635b6b4c1..f46a353a35 100644
>> --- a/block/Makefile.objs
>> +++ b/block/Makefile.objs
>> @@ -45,6 +45,7 @@ block-obj-y += crypto.o
>>   block-obj-y += aio_task.o
>>   block-obj-y += backup-top.o
>>   block-obj-y += filter-compress.o
>> +block-obj-y += preallocate.o
>>   common-obj-y += monitor/
>>   
>>   block-obj-y += stream.o
>> -- 
>> 2.18.0
>>


-- 
Best regards,
Vladimir

