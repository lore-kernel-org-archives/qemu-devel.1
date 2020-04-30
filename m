Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04402C4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:40:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B29252070B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="IVGg+x7O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B29252070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUE6s-0007xy-SH
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 14:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37716)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jUDoI-0000QG-Bo
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:21:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jUDoG-0002ZE-PQ
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:21:21 -0400
Received: from mail-db8eur05on2101.outbound.protection.outlook.com
 ([40.107.20.101]:3488 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jUDoF-0002Z5-Uq; Thu, 30 Apr 2020 14:21:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGqi0AAMaz5uCSymzWtbPonEZTtxiXSKj7ZdfFwKUIPKC31qUC+lGYTweTpeW2seufdon1Omw+B+D7bCohqxMD5zVDgxw4+roBcdUSlXEpASa/nGkmP9qVS4vQx1WGAeJbmQ9JbWtwC7b/UMfXrQugjzUOq3hGHp8zNWlDlawZvMDph1ykg+jFkWb93Mhluh2UdbcI3D/1Aevg+Q/Pfl21pgifUJ7MWros8+FjAhZyEN8/oQKmrOU6fVOAoSD5LnvPPrDCseMVwvG6+eGsmfYgj2S5iLWat4HRnSZPQarwDVQtutRfzXzboP0LELQP8vUYMwyXUEs41FO+z/8R7upA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlN3E3PkxKTW+Hk17hVtrJC7MFt/C+39dNW+7DH28bM=;
 b=MKdx1VdrOIjY4HnN0RPmDtp72Izsv8TVJ32WtUQed5Kuk5wNjI3jnD7VoF5f5NxpquNzLblF3DhrRxb7Vx07wKvE0hMZqf40Y44r65oKR4Xe7Eu7YWc4UK9RHyuEjPXpyAzsWBcuDBOHXMX64o98kRqC6FDg0eOWdPkFIS25kgSgepjlff024tNfhs+gxCncPf7o39esNhnLRhvkUryexelv+PwnZZY9VmaqgYlDRzBH3hItfCCwUheTkBFXh2l/6pHUWSdJlB3bTtWmdeeg5QZqoSX6AV90oKAxi7ggDS6JGV0/rVZGt15vLEc+6NCcZqwnywFUTryGpS+TTeROGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlN3E3PkxKTW+Hk17hVtrJC7MFt/C+39dNW+7DH28bM=;
 b=IVGg+x7Oabs8tyRdYTzKEYdZ8H5yKkhGEHo75qtAZUXYiR6hYQivSFE17xjXsvIrrwjKPn514F0wWhxFidQGlbFDB9jegZqKnH5eQMhM5nVcyflFiILLqKyMl6fmcr1wGhYQoTtXEzsnOFE+KUR9JpTkVLIdCsrzLRF1iP6W+14=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5509.eurprd08.prod.outlook.com (2603:10a6:20b:10c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 30 Apr
 2020 18:21:16 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 18:21:16 +0000
Subject: Re: [PATCH v2 3/4] backup: Make sure that source and target size match
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200430142755.315494-1-kwolf@redhat.com>
 <20200430142755.315494-4-kwolf@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200430212112906
Message-ID: <d5de1915-523b-fbdb-2ebe-8c31cf0e0cdf@virtuozzo.com>
Date: Thu, 30 Apr 2020 21:21:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200430142755.315494-4-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0202CA0006.eurprd02.prod.outlook.com
 (2603:10a6:200:89::16) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.138) by
 AM4PR0202CA0006.eurprd02.prod.outlook.com (2603:10a6:200:89::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend
 Transport; Thu, 30 Apr 2020 18:21:15 +0000
X-Tagtoolbar-Keys: D20200430212112906
X-Originating-IP: [185.215.60.138]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80704c28-dcef-451a-87ee-08d7ed33456c
X-MS-TrafficTypeDiagnostic: AM7PR08MB5509:
X-Microsoft-Antispam-PRVS: <AM7PR08MB550956594F594EA09C6C2B16C1AA0@AM7PR08MB5509.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R/rifIY1s1WpkjHT23ZCPqTleO0yyKnvf7bHb+5tlgqo2rmHrOAWxoCg9mU0nfW5W3Miyb/x97qc/qrzHOcutEkgCpfdWG30u8JToFLev9vNo5/dptTNFRpbe0p/Gd+ePi//Gg2L/nDrbm8mTUsl6CxSOkXjQFQmOachf3Z+P37R7lsjQoScRV5t4sKIqIU2Ku6+O/qfbLJmLyIcMitialtFBlanEyst8xZJkVHkZlr4xNyqpM3OGLbxPjVAAmn+ERfzyG1k9ixuaobxs6548iqyXth4h1LxN84c8g0kogqYpugzo5sMnyZi5CfUZl62xwhZBNICjSW0cr3YOugabJL/wtSJ/nao8vM/tpmTOH2kiGT/8CIr0NU5hQ57r4m+taUtYsFdeZodNYXTW90N+MEzWVkKLiN+05OE+ThcqKHtZRI2Tkelnv3fN1juZayvadferbcJWV7TMrNtlp9BoVcMMJxArJ7/B+Jdy1gDdZ+rH1l0+5/ncPTsvQdQiyX/nAcRpzeGRXAwbBZaiIjOyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(39850400004)(396003)(136003)(376002)(6486002)(16526019)(26005)(52116002)(8936002)(5660300002)(4326008)(31686004)(2616005)(956004)(2906002)(36756003)(316002)(186003)(86362001)(966005)(66556008)(66476007)(478600001)(66946007)(31696002)(8676002)(16576012)(6666004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: NfLmhL5MIl5xFwyTSyvr/ORBclcaFX1D8bQTQ3WRKod2V0VmCoGCkorn9QEyA9LmiQVQr+XWCrjzmBfNIveefYaB7BjRnIHeZw0Zh+MFcxOR7U9+InFScJoUSa2gD1XwKpnFxF9rnvyKEdks5XzNdE/hZ++qHd6ToR88FomO4xViy8IDBbCdQotJHmbSwxdRHYq6q+btfy8hpb/F9WGeEJ4jh4Sj/QF9fjaP4pqO71+TOK309LuWNnyUlX9j3J42ZztwFgPnQ9vRbGPZImUZva6i0VZQ5JJMDaRPozZCGyEYQIK0VVH80hNTtbmMXBaxwdDnlUwkHdvd4C97sxDdXB2PkoYl4bcwVaF9Yah0Nk3IcvK19W+MCxXule5981KGsfy6DPv+6eLLvK5sKKIy4JmncoTs0L1sWaZvnKMQ7EsnMqemEmLGwypXzAQyZHolTM5r5i0qg/HOWT6vUmRNjNBSGAyA7v1TCDan1AE4cAEdDTmvWTra0fFrA4DbVpZz/YVfGlnU1PJitHFkOiRMC+/0gk+B7Xmcs2TAbJAPvQAzc2Fa/2uGDzjNetTqQvi/es0Y+MzFe7hqUIbfPGIVRAgzbNosucappVoxey68sU4HgfmNdi+SH1I78hxqeCyNzPETr6w0U78RTDc9W4MzQ+uGsUigmSmfNWZ657DhmQ/k2Rhzem1D0jclGrJG4uw64Zfe5AcaSIKv0Gy8tk93wcJrmgiFND1+Q7ypLJJMdAyrN0EiaXx8DOo3Augtj1ts+YPPcj4xJ5il/kW8/tRvtyUmXm6T2zS7J3IQgxzYAQE=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80704c28-dcef-451a-87ee-08d7ed33456c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 18:21:16.1105 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hJ38bkiR7fd5oGy9lEphrGNJlFhpc6OgV5Cy2X0mlnQ9eBOT2MW9f0u8b7nakV62TOxAM+oKF2McUZCplUjFU/2mUk65Il/vlwqqnpMgZxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5509
Received-SPF: pass client-ip=40.107.20.101;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 14:21:17
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.20.101
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
Cc: jsnow@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

30.04.2020 17:27, Kevin Wolf wrote:
> Since the introduction of a backup filter node in commit 00e30f05d, the
> backup block job crashes when the target image is smaller than the
> source image because it will try to write after the end of the target
> node without having BLK_PERM_RESIZE. (Previously, the BlockBackend layer
> would have caught this and errored out gracefully.)
> 
> We can fix this and even do better than the old behaviour: Check that
> source and target have the same image size at the start of the block job
> and unshare BLK_PERM_RESIZE. (This permission was already unshared
> before the same commit 00e30f05d, but the BlockBackend that was used to
> make the restriction was removed without a replacement.) This will
> immediately error out when starting the job instead of only when writing
> to a block that doesn't exist in the target.
> 
> Longer target than source would technically work because we would never
> write to blocks that don't exist, but semantically these are invalid,
> too, because a backup is supposed to create a copy, not just an image
> that starts with a copy.
> 
> Fixes: 00e30f05de1d19586345ec373970ef4c192c6270
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1778593
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

I'm OK with it as is, as it fixes bug:

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

still, some notes below


> ---
>   block/backup-top.c | 14 +++++++++-----
>   block/backup.c     | 14 +++++++++++++-
>   2 files changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/block/backup-top.c b/block/backup-top.c
> index 3b50c06e2c..79b268e6dc 100644
> --- a/block/backup-top.c
> +++ b/block/backup-top.c
> @@ -148,8 +148,10 @@ static void backup_top_child_perm(BlockDriverState *bs, BdrvChild *c,
>            *
>            * Share write to target (child_file), to not interfere
>            * with guest writes to its disk which may be in target backing chain.
> +         * Can't resize during a backup block job because we check the size
> +         * only upfront.
>            */
> -        *nshared = BLK_PERM_ALL;
> +        *nshared = BLK_PERM_ALL & ~BLK_PERM_RESIZE;
>           *nperm = BLK_PERM_WRITE;
>       } else {
>           /* Source child */
> @@ -159,7 +161,7 @@ static void backup_top_child_perm(BlockDriverState *bs, BdrvChild *c,
>           if (perm & BLK_PERM_WRITE) {
>               *nperm = *nperm | BLK_PERM_CONSISTENT_READ;
>           }
> -        *nshared &= ~BLK_PERM_WRITE;
> +        *nshared &= ~(BLK_PERM_WRITE | BLK_PERM_RESIZE);
>       }
>   }
>   
> @@ -192,11 +194,13 @@ BlockDriverState *bdrv_backup_top_append(BlockDriverState *source,
>   {
>       Error *local_err = NULL;
>       BDRVBackupTopState *state;
> -    BlockDriverState *top = bdrv_new_open_driver(&bdrv_backup_top_filter,
> -                                                 filter_node_name,
> -                                                 BDRV_O_RDWR, errp);
> +    BlockDriverState *top;
>       bool appended = false;
>   
> +    assert(source->total_sectors == target->total_sectors);

May be better to error-out, just to keep backup-top independent. Still, now it's not
really needed, as we have only one caller. And this function have to be refactored
anyway, when publishing this filter (open() and close() should appear, so this code
will be rewritten anyway.)

And the other thought: the permissions we declared above, will be activated only after
successful bdrv_child_refresh_perms(). I think some kind of race is possible, so that
size is changed actual permission activation. So, may be good to double check sizes after
bdrv_child_refresh_perms().. But it's a kind of paranoia.

Also, third thought: the restricted permissions doesn't save us from resizing
of the source through exactly this node, does it? Hmm, but your test works somehow. But
(I assume) it worked in a previous patch version without unsharing on source..

Ha, but bdrv_co_truncate just can't work on backup-top, because it doesn't have file child.
But, if we fix bdrv_co_truncate to skip filters, we'll need to define .bdrv_co_truncate in
backup_top, which will return something like -EBUSY.. Or just -ENOTSUP, doesn't matter.

> +
> +    top = bdrv_new_open_driver(&bdrv_backup_top_filter, filter_node_name,
> +                               BDRV_O_RDWR, errp);
>       if (!top) {
>           return NULL;
>       }
> diff --git a/block/backup.c b/block/backup.c
> index c4c3b8cd46..4f13bb20a5 100644
> --- a/block/backup.c
> +++ b/block/backup.c
> @@ -340,7 +340,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
>                     BlockCompletionFunc *cb, void *opaque,
>                     JobTxn *txn, Error **errp)
>   {
> -    int64_t len;
> +    int64_t len, target_len;
>       BackupBlockJob *job = NULL;
>       int64_t cluster_size;
>       BdrvRequestFlags write_flags;
> @@ -405,6 +405,18 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
>           goto error;
>       }
>   
> +    target_len = bdrv_getlength(target);
> +    if (target_len < 0) {
> +        error_setg_errno(errp, -target_len, "Unable to get length for '%s'",
> +                         bdrv_get_device_or_node_name(bs));
> +        goto error;
> +    }
> +
> +    if (target_len != len) {
> +        error_setg(errp, "Source and target image have different sizes");
> +        goto error;
> +    }
> +
>       cluster_size = backup_calculate_cluster_size(target, errp);
>       if (cluster_size < 0) {
>           goto error;
> 


-- 
Best regards,
Vladimir

