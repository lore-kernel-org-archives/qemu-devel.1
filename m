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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54063C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 13:35:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EEAE20756
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 13:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="IhUjsdPX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EEAE20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPQdx-00015W-84
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 09:35:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kPQdK-0000Xt-VX; Mon, 05 Oct 2020 09:34:30 -0400
Received: from mail-eopbgr140118.outbound.protection.outlook.com
 ([40.107.14.118]:58205 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kPQdH-000636-Sq; Mon, 05 Oct 2020 09:34:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FtYrMFBblP93kI72irHm1Q4hgnWFOMbUe2ZUBODNsTE059Y/ySgbOLJvM/7uLwyXsRgTW+o/zNQGl3YTRIV3n/nkD20xTU/xzxtNQCO6iMkG2ZSAtMQOY7oIPnHT1F0+7w6WqeEiOp/+5tMBL4mwnC2in2ZagcYnYBhF+Spj6DyuL8AUy2q6ZyW3xDWCweZpDvbo6Mzv85FkAlvgxVaRgh7LjG0pVhQbvVAd7NVCXRXnFynEXoPy9GLwVfRVxsKJZAIxPh2XznRXDLd/uCFwi46BWjZoh4y7TEVcNYpq1q3gE7StyitsI/+VZg7fZQIf/ycFObtOgiy01TjkMpck2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHpEAp2sPnhcNZNjwwgRB/vRqVjn6GERvv8S1nlHjG4=;
 b=PdNPuuvysKcRs6tdTRDlwwpME2qurp8u3/tIeArRbefKNtQFuzuS7m5iNh1V4oL7kdQREs0l01OAZKTWDIsS+LIGM8vcXuBlzKROx5U3IjuzHbd1Ny9HQ6oBcd/TNGt1LSTI8+GqU8BjU7Kd0sNO+MZzRnYPmp095rXWRkaGtbPodHPydP0qka46IJ7e5DdO+O1yiqnEttjn311eI1yHjHdPTjowmA/dYDcsoxdn3VWoqZ37r1v7wpbSbsV7qzYF0YhAHkP/XbB7DjG8sfyl21Qm8nnn5CmX7Ift+vnemOQeVtgEYoppcUSC9/fUAM6eqt3t2lnZMox8i6vT1AUktA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHpEAp2sPnhcNZNjwwgRB/vRqVjn6GERvv8S1nlHjG4=;
 b=IhUjsdPXjR+JUtpHZJNjaaEUzU/72SVwEv8zuBNExaVZ38XYp60XHS67/HuH36lSQCB3yNHrSpcI4gEHQbvPZX+T8xeY13OU3diA315N54J5Zr21CTzOOjmpjS5zK4dpX4fhSlD15RqF/i/TmeXHpKy66Efv7XmyMMJHRsLlvmA=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3096.eurprd08.prod.outlook.com (2603:10a6:209:43::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.37; Mon, 5 Oct
 2020 13:34:23 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3433.044; Mon, 5 Oct 2020
 13:34:23 +0000
Subject: Re: [PATCH v10 2/9] copy-on-read: add filter append/drop functions
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com,
 stefanha@redhat.com, fam@euphon.net, jsnow@redhat.com, armbru@redhat.com,
 eblake@redhat.com, den@openvz.org
References: <1601383109-110988-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1601383109-110988-3-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <777a8fc5-293b-2866-bbdf-01b181291b40@virtuozzo.com>
Date: Mon, 5 Oct 2020 16:34:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
In-Reply-To: <1601383109-110988-3-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.116]
X-ClientProxiedBy: AM4PR0701CA0026.eurprd07.prod.outlook.com
 (2603:10a6:200:42::36) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.116) by
 AM4PR0701CA0026.eurprd07.prod.outlook.com (2603:10a6:200:42::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.15 via Frontend
 Transport; Mon, 5 Oct 2020 13:34:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1feb380-02ff-4169-5102-08d869335ed2
X-MS-TrafficTypeDiagnostic: AM6PR08MB3096:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB309676C5FFD3BF3FD57518B0C10C0@AM6PR08MB3096.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /6ibK0hE9epSSDKGgRAm9wcfpIk2wqtleYi2n27TyS/Z0Fv6y5bMZUf13uqgJtp6juWGIOTfZ02YbBKQTrlv/7mto0GEdlq3AzBMuOnBu6Jo9vFl3eusJhW0w1xqvvzGQ0PhHOH6CIRBeSZA8+u35nLQKHVMbvy7UhMPxjM7DgpPS9zCJ2as+cej0JZVw+t77MuM1csteJ3zbN2H2s/8qqzD26jfl0wZX04HKFtLqNzUBf0ginrshXSqp2Iz1cIixr76RtDV9a/Pg8hSV23IV+IpfLuWS5QhqkxAMw4DUyUY4b/kRzJMtFiliQi5JdTVVBnN7GXDFguMkajgup7m+M52CxXUgauoGY6cT1uGxz7cx/jxBEZSlBXT6Sf3+kYz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(376002)(346002)(136003)(39840400004)(16526019)(186003)(31696002)(2616005)(26005)(5660300002)(2906002)(956004)(6486002)(8936002)(66476007)(107886003)(66946007)(4326008)(66556008)(316002)(86362001)(83380400001)(8676002)(52116002)(31686004)(16576012)(36756003)(478600001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Df8NI25vAR7UwoV0TrwN49PYXwJRpdhruz7lj4df/RskGMsw4TUYdLg3neok8BE3AtIi4JMP19W+DNaZxWewO0ykNHjmdq3/JZSBuev8eo3hZXI38Jt4qMy7daG/MqAHxCLkbqoFXzOrTvkxJCunyFsvLAQGaCCKXHcdRuvzmFvKLCeFGu+Cx1AKnqv7BYLcvMiomyl1kY5LLfHN6MUU+N3375oA1Y0LYhlkhzMs3wy3gTDI/9UmReDi0Iu6Sb45VANQDHSugxCrf4pPdJehC8uuUnWJM96jVYnKr47sVmOZ9L0VzC6ZJT9kuJLi3EySDkAeBzRVIIMehQxh52u/mVStUEPD1vPAvs3DlyiwRO/E1xLFkQ9Sc534FG3AkWfqVepKnZIEwnYqlwdNH8E4/de3z7hfKtHV7nJb4oVla2CJsYrRrEOFyj0Hn6Y4chQyok4jmYM7E62MbeKbY51q+eeH4uCEFERlBMfDjPEAlFpPRthS8iBRo0lHPfNWSOcyxOdI7g6wnjenD0Dl6M5Il1lKHEUSKR68Z3dUbA5W+p9JUFAXxI9VzlrkA7eAL+xSD6R2yN0oU3sB8RSClbcLtYfOFLowHdiOlKRtm4Yh8+k6JCE8ErcsvYcjlD9/K9LWxmOtew1/Zdfc5uXwz3x3qw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1feb380-02ff-4169-5102-08d869335ed2
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2020 13:34:22.9847 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jwhoovJKRnEIkqrEhNFz7tBwx9qFD0P9yMD9VI6/Ea28cRkU0U2yP75O5uOipi1PSgDA9rhb6l0xP7EbURKzdc6eZMtx0b2AZDBS7jyTBWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3096
Received-SPF: pass client-ip=40.107.14.118;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 09:34:24
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

29.09.2020 15:38, Andrey Shinkevich wrote:
> Provide API for the COR-filter insertion/removal.
> Also, drop the filter child permissions for an inactive state when the
> filter node is being removed.
> 
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   block/copy-on-read.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   block/copy-on-read.h | 35 ++++++++++++++++++++++
>   2 files changed, 119 insertions(+)
>   create mode 100644 block/copy-on-read.h
> 
> diff --git a/block/copy-on-read.c b/block/copy-on-read.c
> index cb03e0f..3c8231f 100644
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
> @@ -42,6 +52,13 @@ static int cor_open(BlockDriverState *bs, QDict *options, int flags,
>           ((BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK) &
>               bs->file->bs->supported_zero_flags);
>   
> +    state->active = true;
> +
> +    /*
> +     * We don't need to call bdrv_child_refresh_perms() now as the permissions
> +     * will be updated later when the filter node gets its parent.
> +     */
> +
>       return 0;
>   }
>   
> @@ -57,6 +74,17 @@ static void cor_child_perm(BlockDriverState *bs, BdrvChild *c,
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
> @@ -135,6 +163,7 @@ static void cor_lock_medium(BlockDriverState *bs, bool locked)
>   
>   static BlockDriver bdrv_copy_on_read = {
>       .format_name                        = "copy-on-read",
> +    .instance_size                      = sizeof(BDRVStateCOR),
>   
>       .bdrv_open                          = cor_open,
>       .bdrv_child_perm                    = cor_child_perm,
> @@ -159,4 +188,59 @@ static void bdrv_copy_on_read_init(void)
>       bdrv_register(&bdrv_copy_on_read);
>   }
>   
> +
> +BlockDriverState *bdrv_cor_filter_append(BlockDriverState *bs,
> +                                         QDict *node_options,
> +                                         int flags, Error **errp)


Ok, now function can add ~any filter, not only COR.. But it's a pair for bdrv_cor_filter_drop(), and with "active" hack we don't want make the functions generic I think. So it's OK for now to keep function here and named _cor_.

> +{
> +    BlockDriverState *cor_filter_bs;
> +    Error *local_err = NULL;
> +
> +    cor_filter_bs = bdrv_open(NULL, NULL, node_options, flags, errp);
> +    if (cor_filter_bs == NULL) {
> +        error_prepend(errp, "Could not create COR-filter node: ");
> +        return NULL;
> +    }

You've dropped setting ->implicit field if filter_node_name not specified. Probably caller now can do it.. I don't really care about implicit case, so it's OK for me if it works with iotests.

So,

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


-- 
Best regards,
Vladimir

