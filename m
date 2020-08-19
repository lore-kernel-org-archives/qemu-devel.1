Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39594C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 10:22:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4C7C2072D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 10:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="BtaZeRwv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4C7C2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8LEV-0000JH-4l
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 06:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8LDe-0007Ya-Gs; Wed, 19 Aug 2020 06:21:23 -0400
Received: from mail-eopbgr00120.outbound.protection.outlook.com
 ([40.107.0.120]:12772 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8LDZ-0008E3-6H; Wed, 19 Aug 2020 06:21:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WlnVrTvtNUiHBGT0sramxDyCrGlew2KYUZTkS7a0lxTugObyqP3zclQL22KferkzcI9YIjjdFVP+xCt/UJcp83MGqJT0UEsuZxAJyZcVodnRhh2UgDebjdEHY5NvChxJvm4ab9N2S22fylSbedGlu1NU1pnNX84atqHlx2W7ovy1d37WcjQqjZDGQdXduWg/dBOZR2GB8lHa/g5DLonNrEDGz1fzx6h0OdAjr0Uiu47NH4Md8ZiWyGHbso4Z1csLkIj0BRnorribZtfBqr7YHxnDVyfKqYO6rzzV7Amjx6ybOOLOUeODR+edYsO6XVrovhebKhV+PihbgXlVo2+suw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOhtQhzymE77xrhJNoiQ9VF4wLblU8Mtrhi1ZwawEaw=;
 b=NhZzoTzKndHWurwjWaA/bzoXCTf5Nro9to9MXSLLSkDHYtJf/xSHoUpKkflXW+5QRso2CZu1HqWpEb8J3kAaFpHBk99cD1i6KgTTMwK7lHrb0cVF1mypx2INtjTnLxE/eDDGcsTfdjqxgBIItyEvJj1l0vCIpjZSV9dZGsFkZq/ctN3lAgywm6ec+dPGBPdzGKrVgL2dyWNe2JYcgZyaT6ffaIv1Dv1zANeoJufgNfcuXx8d8C9TKh4vqS0HtAPfXU62vW7U+aoUdT+BhoNLxn63LxpjxzhZ7Hkdm/8qHMpO+huJwIYpRIe0211vHC/FBqkJpLgpgBH5MHQZEPw1cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOhtQhzymE77xrhJNoiQ9VF4wLblU8Mtrhi1ZwawEaw=;
 b=BtaZeRwvRKYWXhzKLxua0GGtkLoSySdywrBGVUhPztU0fP4eHXeQe3PCLfuZeylJnZOnlEFqeAHzXnw12sZmzR3BC7ix9wvpbwtGRr127i7i9GbN3BAl5ql8aVyXAioZstuy9RxdtQGKbPkPUIs7E7eVQu1kVhWVf5eA8f1XuOQ=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4167.eurprd08.prod.outlook.com (2603:10a6:20b:ad::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Wed, 19 Aug
 2020 10:21:14 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Wed, 19 Aug 2020
 10:21:14 +0000
Subject: Re: [PATCH v6 2/4] copy-on-read: add filter append/drop functions
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1597785880-431103-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1597785880-431103-3-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <3f450bc2-73a5-49f8-53ad-d1bfa1051407@virtuozzo.com>
Date: Wed, 19 Aug 2020 13:21:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <1597785880-431103-3-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR06CA0139.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::44) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.171) by
 AM0PR06CA0139.eurprd06.prod.outlook.com (2603:10a6:208:ab::44) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.25 via Frontend Transport; Wed, 19 Aug 2020 10:21:13 +0000
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88468117-1af5-4384-72a0-08d8442999d1
X-MS-TrafficTypeDiagnostic: AM6PR08MB4167:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB416787AD05830850BDBDB846C15D0@AM6PR08MB4167.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bZi9J8f28czn+7eZPjvdhFcYwzGk71cqsUDkqpjR1P7ACOcXpQBhfRfrfH5XQqdlNqW7D59QCwMrn36yF7ygLrj+qY6wCzWpTFXGYoGn522gNTCP8mKcq5TfkVGjrwAvQ91+0zul8uZYFTsC0LwaqR3G2Aan9GFg28qF3pi4DTpmu1MQMZ/arzqsEaAPDs564fsGgIXwxJDVcZ6xOVDIJDI14uOD6nMXZ9i6ZTRu9E5fPFaC42TsYpJId+MYZ9tS4WGFVBvvSmPVrlP5jB5xd5Ul89F2VH/acdV+p2bnLlKurEliJ4aGot7deq1HXJbZNlI9Xx6R0byQ+8abs5XkggyzRW+BIahcLy7YOc5hGNuSH+rXx9u0ir+7AI2J04yaCjMndh5SaiwBAtnOHbZe0oqEYA6lyyPXfOu9r5iMylGrl/m/gxQv5M/viTwIaYoEj2v4IRYavRoMF1x3pBwWTuFIgdzf9r1MdTnKU4H/H+0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(346002)(376002)(39840400004)(316002)(4326008)(478600001)(31696002)(8936002)(956004)(66476007)(66946007)(66556008)(2616005)(8676002)(6486002)(2906002)(186003)(83380400001)(36756003)(16576012)(16526019)(86362001)(26005)(107886003)(5660300002)(52116002)(31686004)(2004002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: efOHxucXtokladI7NK9valbDXpVcSCOrskV9kJe695ga2sCayBflkg7lE1NKUQOWuMvrmmBHPffdNL64mDfmuaLau5Ivq6zY+JuiZKLwMicKiKtNsP+OWf0ewCXcN78wT260qfjKkBs0J4DbZaLGT/QDQhBkpB1I3latHn/jEAiJpJNUZRTDbErUvCW1lTko9H9K2xMIuPRrw0HTLjQzptIagIWpoQFoxNZ2MzhLdxzdq/tVPcc1YVOpAaeNELRgnAzbMZhJ0Q8mWwFlNa7z8WmUZ0LYO3OvxvdH6zhyfu3//9TnvP7eqL9nEBiZ/c2aEuqQ8uJS/FOSB65UUSg3om0ijC4Dm2O+Fs51LaxASKWfrL6voo/AvzqgP+DtgUYLJoDu40YpHkIDgr5pTE2n9IaDDBP6lcgpnaLX99vG2ET2haAbFB2pJpjxILA1HtRm8I4TjCKbTkwri5W2O12dynKuXXl3VPymKL4nJr/cLL9Wzz2o00F/1oeLUyXLriAGrGf9wccqGxExJTi1XucOOpesa5DDuO5bNA9Y5GYMgiIU0+oN0MUvanKNIGdIgZwrZmo2vKvC0kXIjewqELOKy29pkFtTE0haTPVl0jt/ChlfEUo082G1yR1lqKi3YZXgVv2/BigAH1NKCm6XbMEtNg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88468117-1af5-4384-72a0-08d8442999d1
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 10:21:13.9267 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XnMTaVoqHaRJCzkVBG6BhdoecHeowcwuVnj8QlVydAbfhr6xMUU+Fsq7lz9Ap1BFVGQdEOB2lc6sI3DDpXY9bloEQZ+ica4EJupQh+3aYIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4167
Received-SPF: pass client-ip=40.107.0.120;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 06:21:14
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
Cc: kwolf@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, den@openvz.org,
 mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

19.08.2020 00:24, Andrey Shinkevich wrote:
> Provide API for the COR-filter insertion/removal.
> Also, drop the filter child permissions for an inactive state when the
> filter node is being removed.
> 
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   block/copy-on-read.c | 103 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   block/copy-on-read.h |  36 ++++++++++++++++++
>   2 files changed, 139 insertions(+)
>   create mode 100644 block/copy-on-read.h
> 
> diff --git a/block/copy-on-read.c b/block/copy-on-read.c
> index cb03e0f..150d9b7 100644
> --- a/block/copy-on-read.c
> +++ b/block/copy-on-read.c
> @@ -23,11 +23,21 @@
>   #include "qemu/osdep.h"
>   #include "block/block_int.h"
>   #include "qemu/module.h"
> +#include "qapi/error.h"
> +#include "qapi/qmp/qdict.h"
> +#include "block/copy-on-read.h"
> +
> +
> +typedef struct BDRVStateCOR {
> +    bool active;
> +} BDRVStateCOR;
>   
>   
>   static int cor_open(BlockDriverState *bs, QDict *options, int flags,
>                       Error **errp)
>   {
> +    BDRVStateCOR *state = bs->opaque;
> +
>       bs->file = bdrv_open_child(NULL, options, "file", bs, &child_of_bds,
>                                  BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
>                                  false, errp);
> @@ -42,6 +52,8 @@ static int cor_open(BlockDriverState *bs, QDict *options, int flags,
>           ((BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK) &
>               bs->file->bs->supported_zero_flags);
>   
> +    state->active = true;

We don't need to call bdrv_child_refresh_perms() here, as permissions will be
updated soon, when the filter node get its parent, yes?

Let's add at least a comment on this.

> +
>       return 0;
>   }
>   
> @@ -57,6 +69,17 @@ static void cor_child_perm(BlockDriverState *bs, BdrvChild *c,
>                              uint64_t perm, uint64_t shared,
>                              uint64_t *nperm, uint64_t *nshared)
>   {
> +    BDRVStateCOR *s = bs->opaque;
> +
> +    if (!s->active) {
> +        /*
> +         * While the filter is being removed
> +         */
> +        *nperm = 0;
> +        *nshared = BLK_PERM_ALL;
> +        return;
> +    }
> +
>       *nperm = perm & PERM_PASSTHROUGH;
>       *nshared = (shared & PERM_PASSTHROUGH) | PERM_UNCHANGED;
>   
> @@ -135,6 +158,7 @@ static void cor_lock_medium(BlockDriverState *bs, bool locked)
>   
>   static BlockDriver bdrv_copy_on_read = {
>       .format_name                        = "copy-on-read",
> +    .instance_size                      = sizeof(BDRVStateCOR),
>   
>       .bdrv_open                          = cor_open,
>       .bdrv_child_perm                    = cor_child_perm,
> @@ -159,4 +183,83 @@ static void bdrv_copy_on_read_init(void)
>       bdrv_register(&bdrv_copy_on_read);
>   }
>   
> +
> +static BlockDriverState *create_filter_node(BlockDriverState *bs,
> +                                            const char *filter_node_name,
> +                                            Error **errp)
> +{
> +    QDict *opts = qdict_new();
> +
> +    qdict_put_str(opts, "driver", "copy-on-read");
> +    qdict_put_str(opts, "file", bdrv_get_node_name(bs));
> +    if (filter_node_name) {
> +        qdict_put_str(opts, "node-name", filter_node_name);
> +    }
> +
> +    return bdrv_open(NULL, NULL, opts, BDRV_O_RDWR, errp);
> +}
> +
> +
> +BlockDriverState *bdrv_cor_filter_append(BlockDriverState *bs,
> +                                         const char *filter_node_name,
> +                                         Error **errp)
> +{
> +    BlockDriverState *cor_filter_bs;
> +    BDRVStateCOR *state;
> +    Error *local_err = NULL;
> +
> +    cor_filter_bs = create_filter_node(bs, filter_node_name, errp);
> +    if (cor_filter_bs == NULL) {
> +        error_prepend(errp, "Could not create filter node: ");
> +        return NULL;
> +    }
> +
> +    if (!filter_node_name) {
> +        cor_filter_bs->implicit = true;
> +    }
> +
> +    bdrv_drained_begin(bs);
> +    bdrv_replace_node(bs, cor_filter_bs, &local_err);
> +    bdrv_drained_end(bs);
> +
> +    if (local_err) {
> +        bdrv_unref(cor_filter_bs);
> +        error_propagate(errp, local_err);
> +        return NULL;
> +    }
> +
> +    state = cor_filter_bs->opaque;
> +    state->active = true;

hmm stop. it's already active, after create_filter_node, so you don't need to set it again, isn't it?

> +
> +    return cor_filter_bs;
> +}
> +
> +
> +void bdrv_cor_filter_drop(BlockDriverState *cor_filter_bs)
> +{
> +    BdrvChild *child;
> +    BlockDriverState *bs;
> +    BDRVStateCOR *s = cor_filter_bs->opaque;
> +
> +    child = bdrv_filter_child(cor_filter_bs);
> +    if (!child) {
> +        return;
> +    }
> +    bs = child->bs;
> +
> +    /* Retain the BDS until we complete the graph change. */
> +    bdrv_ref(bs);
> +    /* Hold a guest back from writing while permissions are being reset. */
> +    bdrv_drained_begin(bs);
> +    /* Drop permissions before the graph change. */
> +    s->active = false;
> +    bdrv_child_refresh_perms(cor_filter_bs, child, &error_abort);
> +    bdrv_replace_node(cor_filter_bs, bs, &error_abort);
> +
> +    bdrv_drained_end(bs);
> +    bdrv_unref(bs);
> +    bdrv_unref(cor_filter_bs);
> +}
> +
> +
>   block_init(bdrv_copy_on_read_init);
> diff --git a/block/copy-on-read.h b/block/copy-on-read.h
> new file mode 100644
> index 0000000..db03c6c
> --- /dev/null
> +++ b/block/copy-on-read.h
> @@ -0,0 +1,36 @@
> +/*
> + * Copy-on-read filter block driver
> + *
> + * The filter driver performs Copy-On-Read (COR) operations
> + *
> + * Copyright (c) 2018-2020 Virtuozzo International GmbH.
> + *
> + * Author:
> + *   Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef COPY_ON_READ_FILTER
> +#define COPY_ON_READ_FILTER
> +
> +#include "block/block_int.h"
> +#include "block/block-copy.h"

do you really need block-copy.h ?

> +
> +BlockDriverState *bdrv_cor_filter_append(BlockDriverState *bs,
> +                                         const char *filter_node_name,
> +                                         Error **errp);
> +void bdrv_cor_filter_drop(BlockDriverState *cor_filter_bs);
> +
> +#endif /* COPY_ON_READ_FILTER */
> 

Code seems correct to me, with extra "state->active = true;" dropped:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

