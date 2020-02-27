Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392C0C4BA3B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:46:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4F3A20726
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bBaaDwaC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4F3A20726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Gg7-0006b1-1T
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 05:46:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50825)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j7Gex-0005kt-Mb
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:44:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j7Gew-0000zp-6a
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:44:51 -0500
Received: from mail-eopbgr10121.outbound.protection.outlook.com
 ([40.107.1.121]:12694 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j7Ger-0000Wq-Nx; Thu, 27 Feb 2020 05:44:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lnWc+xREITcL90dEzGmK+FKfvHzhFbCZNRSb8FFpu8uhrAk81spcLwACgG2lg6BXXYIUTlsT210wGYCnb+D4oglh/DlUdURzQ/E8yeTkrpuOFYs0Rlk5qtfyrMZOGR+wQ1UMoTpj2IyAN29WgNV5UhvI+48RIDy5VWE0hA422/U6SgFOGTzqEeQyLfT9MX6UUx+6FFl0QBRJ9dgQ2axK6ahcz3XDCrgvEWf3M+s04GJBDUAgC8Z30/OzWDgW38ea45AZIBCZJYNb3tvGCwhZeLBy5zMXTLI+5ji/SAg6OorieCwDmBLJq5SKu5I289N26ffdeNsTtEpdf7KLY1OwcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZLMfr+ehQWNLg7JvYYjkIhuqxqWFEcNJAFs0Aa3TKA=;
 b=MiVuVd0Wr0R2ktZBNZ8ViqnxQuAKej32R+1UgwTFJY+8Oi9mOJRKKLR+38IKLKyknflbCRPmQ6sgcdUW+zQHqtG6tnNL5ZaKVRT4GgE58TcnhiqiBj5U/07LtcoL1pTOzVdBkK77sp4oNL046bga7cOpItr7+Ip74b11NE3Y7UQYLwnfUm1Dh5Rzd3gCbdza9yBwltiYawg6rv8nxyVpKGsmS8kezLarfF+M2rba319kyz+0tYSkKOWg2EPEym11hnUXGlrc4WBES+AQcWxbzNyzjZSifXbZD7JxPHSiSnNIYiWhysQ6sqNsHN4SXIgfnGPjGasfUTqsNQqBqelgTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZLMfr+ehQWNLg7JvYYjkIhuqxqWFEcNJAFs0Aa3TKA=;
 b=bBaaDwaCIOylfC2DyFbcWQ1J7uysbCQ1yDP47gULaiJuWAEqpgUq9BePzlVnr8SlUh2gCsXK66NqQ5T0LuJMQ+DN9nVEVKwJTQ6ot9q2Xpic0K1T6v031CnWN/eNUa6lPylwb6ADnJOYiR0bqk0F1tDcRLMnVxYB9c5/Kt7zFCc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com (20.179.28.138) by
 VI1PR08MB2655.eurprd08.prod.outlook.com (10.170.236.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.22; Thu, 27 Feb 2020 10:44:43 +0000
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::91aa:2540:62c:aeda]) by VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::91aa:2540:62c:aeda%5]) with mapi id 15.20.2750.024; Thu, 27 Feb 2020
 10:44:43 +0000
Subject: Re: [PATCH 2/6] qmp: expose block-dirty-bitmap-populate
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200225005641.5478-1-jsnow@redhat.com>
 <20200225005641.5478-3-jsnow@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200227134440228
Message-ID: <f64989f8-555d-6e52-87f0-f387bb21d3eb@virtuozzo.com>
Date: Thu, 27 Feb 2020 13:44:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200225005641.5478-3-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1P190CA0019.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::29)
 To VI1PR08MB4432.eurprd08.prod.outlook.com
 (2603:10a6:803:102::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1P190CA0019.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Thu, 27 Feb 2020 10:44:42 +0000
X-Tagtoolbar-Keys: D20200227134440228
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b771d466-b6cd-448f-a81f-08d7bb720ddc
X-MS-TrafficTypeDiagnostic: VI1PR08MB2655:
X-Microsoft-Antispam-PRVS: <VI1PR08MB26555790B4DF17E06870A1E2C1EB0@VI1PR08MB2655.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:107;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(376002)(396003)(39840400004)(346002)(136003)(366004)(189003)(199004)(26005)(186003)(16526019)(66476007)(5660300002)(66556008)(36756003)(2616005)(54906003)(66946007)(7416002)(19627235002)(956004)(2906002)(8936002)(478600001)(52116002)(6486002)(4326008)(86362001)(31696002)(316002)(16576012)(8676002)(31686004)(81166006)(81156014)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB2655;
 H:VI1PR08MB4432.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IYWC5MjguqD3AmjpbqzHgPBsnNDwQwGSCNuioCfYE0WgpQ1ylhtwY0jlxjDMDttVzmFVCwa1RDHGayY7mG7zvOGFNVYqvLS7Ts3hUjjodbrHUkMZbYIYbjoqNZyjpDcTMfxMhngsBtqtlXWU5qORl1hCEXzED57Nq3qX9ECRXzJxqEpdxw4llWfMytczsWoqlIbbIAHF9HWME7upsm4SpUYpVzq2IDpz0Ao+cN3xFqLxXQGHHELASiaKjzGf6jofBZHsKdKYjhUAx84tmOvd2aQKUAoRdOU405edFDwEBpPOTWHXVWzJ/4fGS9Z4edeCdgSI19xCWzn80RvZoBjW3g5goT0LBjNtDs3zCp5DQ3daIX97vBQgKIZXJpMVKWRvzNWpD2cnSQqpa4tYTjah5GNdaRsj/VUNN1nD0w0HeK2g+Aml9E8XaAnXBTnvOxEYylkyYOtSqH+NmlJC0YdH5KB/4iO1KmySTyp1dlSecoisoN3JUOHrfyq34jrrExKO
X-MS-Exchange-AntiSpam-MessageData: YlPfQCeUCyeHK4PM6XA7VNzEFxMIE0faAaypkf5l/1cdsrbYGGhUN7KIvq4SG578+ur6RWqxWEsAAyHMOzz1er3GbizdzS60EERqGvvRIq9Irw3jWKZ9pbvgATcHvrhBYt1sSlbLcjEH3u0e0x/O5Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b771d466-b6cd-448f-a81f-08d7bb720ddc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 10:44:43.1214 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ASsJoYuDkyikfIIeSHBPvkGGgGDNhPCB228VnbPjFUQwPkGOMVKG983a/VTM1qpk3FEKk33Iiyy1yeOu0AQIfOSE80xh68w1YkzHiHgYVvc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2655
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.121
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
Cc: Kevin Wolf <kwolf@redhat.com>, pkrempa@redhat.com,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

25.02.2020 3:56, John Snow wrote:
> This is a new job-creating command.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   qapi/block-core.json  | 18 ++++++++++
>   qapi/transaction.json |  2 ++
>   blockdev.c            | 78 +++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 98 insertions(+)
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index df1797681a..a8be1fb36b 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2293,6 +2293,24 @@
>               '*auto-finalize': 'bool',
>               '*auto-dismiss': 'bool' } }
>   
> +##
> +# @block-dirty-bitmap-populate:
> +#
> +# Creates a new job that writes a pattern into a dirty bitmap.
> +#
> +# Since: 5.0
> +#
> +# Example:
> +#
> +# -> { "execute": "block-dirty-bitmap-populate",
> +#      "arguments": { "node": "drive0", "target": "bitmap0",
> +#                     "job-id": "job0", "pattern": "allocate-top" } }
> +# <- { "return": {} }
> +#
> +##
> +{ 'command': 'block-dirty-bitmap-populate', 'boxed': true,
> +  'data': 'BlockDirtyBitmapPopulate' }
> +
>   ##
>   # @BlockDirtyBitmapSha256:
>   #
> diff --git a/qapi/transaction.json b/qapi/transaction.json
> index 04301f1be7..28521d5c7f 100644
> --- a/qapi/transaction.json
> +++ b/qapi/transaction.json
> @@ -50,6 +50,7 @@
>   # - @block-dirty-bitmap-enable: since 4.0
>   # - @block-dirty-bitmap-disable: since 4.0
>   # - @block-dirty-bitmap-merge: since 4.0
> +# - @block-dirty-bitmap-populate: since 5.0
>   # - @blockdev-backup: since 2.3
>   # - @blockdev-snapshot: since 2.5
>   # - @blockdev-snapshot-internal-sync: since 1.7
> @@ -67,6 +68,7 @@
>          'block-dirty-bitmap-enable': 'BlockDirtyBitmap',
>          'block-dirty-bitmap-disable': 'BlockDirtyBitmap',
>          'block-dirty-bitmap-merge': 'BlockDirtyBitmapMerge',
> +       'block-dirty-bitmap-populate': 'BlockDirtyBitmapPopulate',
>          'blockdev-backup': 'BlockdevBackup',
>          'blockdev-snapshot': 'BlockdevSnapshot',
>          'blockdev-snapshot-internal-sync': 'BlockdevSnapshotInternal',
> diff --git a/blockdev.c b/blockdev.c
> index 011dcfec27..33c0e35399 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -2314,6 +2314,67 @@ static void block_dirty_bitmap_remove_commit(BlkActionState *common)
>       bdrv_release_dirty_bitmap(state->bitmap);
>   }
>   
> +static void block_dirty_bitmap_populate_prepare(BlkActionState *common, Error **errp)

over80 line (not the only)

> +{
> +    BlockdevBackupState *state = DO_UPCAST(BlockdevBackupState, common, common);

At first glance using *Backup* looks like a mistake. May be rename it, or at least add a comment.

> +    BlockDirtyBitmapPopulate *bitpop;
> +    BlockDriverState *bs;
> +    AioContext *aio_context;
> +    BdrvDirtyBitmap *bmap = NULL;
> +    int job_flags = JOB_DEFAULT;
> +
> +    assert(common->action->type == TRANSACTION_ACTION_KIND_BLOCK_DIRTY_BITMAP_POPULATE);
> +    bitpop = common->action->u.block_dirty_bitmap_populate.data;
> +
> +    bs = bdrv_lookup_bs(bitpop->node, bitpop->node, errp);
> +    if (!bs) {
> +        return;
> +    }
> +
> +    aio_context = bdrv_get_aio_context(bs);
> +    aio_context_acquire(aio_context);
> +    state->bs = bs;
> +
> +    bmap = bdrv_find_dirty_bitmap(bs, bitpop->name);

Could we use block_dirty_bitmap_lookup ?

> +    if (!bmap) {
> +        error_setg(errp, "Bitmap '%s' could not be found", bitpop->name);
> +        return;

aio context lock leaked

> +    }
> +
> +    /* Paired with .clean() */
> +    bdrv_drained_begin(state->bs);
> +
> +    if (!bitpop->has_on_error) {
> +        bitpop->on_error = BLOCKDEV_ON_ERROR_REPORT;
> +    }
> +    if (!bitpop->has_auto_finalize) {
> +        bitpop->auto_finalize = true;
> +    }
> +    if (!bitpop->has_auto_dismiss) {
> +        bitpop->auto_dismiss = true;
> +    }
> +
> +    if (!bitpop->auto_finalize) {
> +        job_flags |= JOB_MANUAL_FINALIZE;
> +    }
> +    if (!bitpop->auto_dismiss) {
> +        job_flags |= JOB_MANUAL_DISMISS;
> +    }
> +
> +    state->job = bitpop_job_create(
> +        bitpop->job_id,
> +        bs,
> +        bmap,
> +        bitpop->pattern,
> +        bitpop->on_error,
> +        job_flags,
> +        NULL, NULL,
> +        common->block_job_txn,
> +        errp);
> +
> +    aio_context_release(aio_context);
> +}
> +
>   static void abort_prepare(BlkActionState *common, Error **errp)
>   {
>       error_setg(errp, "Transaction aborted using Abort action");
> @@ -2397,6 +2458,13 @@ static const BlkActionOps actions[] = {
>           .commit = block_dirty_bitmap_remove_commit,
>           .abort = block_dirty_bitmap_remove_abort,
>       },
> +    [TRANSACTION_ACTION_KIND_BLOCK_DIRTY_BITMAP_POPULATE] = {
> +        .instance_size = sizeof(BlockdevBackupState),
> +        .prepare = block_dirty_bitmap_populate_prepare,
> +        .commit = blockdev_backup_commit,
> +        .abort = blockdev_backup_abort,
> +        .clean = blockdev_backup_clean,
> +    },
>       /* Where are transactions for MIRROR, COMMIT and STREAM?
>        * Although these blockjobs use transaction callbacks like the backup job,
>        * these jobs do not necessarily adhere to transaction semantics.
> @@ -3225,6 +3293,16 @@ void qmp_block_dirty_bitmap_merge(const char *node, const char *target,
>       do_block_dirty_bitmap_merge(node, target, bitmaps, NULL, errp);
>   }
>   
> +void qmp_block_dirty_bitmap_populate(BlockDirtyBitmapPopulate *bitpop,
> +                                     Error **errp)
> +{
> +    TransactionAction action = {
> +        .type = TRANSACTION_ACTION_KIND_BLOCK_DIRTY_BITMAP_POPULATE,
> +        .u.block_dirty_bitmap_populate.data = bitpop,
> +    };
> +    blockdev_do_action(&action, errp);
> +}
> +
>   BlockDirtyBitmapSha256 *qmp_x_debug_block_dirty_bitmap_sha256(const char *node,
>                                                                 const char *name,
>                                                                 Error **errp)
> 


-- 
Best regards,
Vladimir

