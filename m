Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E14C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 12:04:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2F3021775
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 12:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Y7Iqo7c6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2F3021775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTlRy-0003GP-Rz
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 08:04:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52284)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTlPl-0002QK-SG
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 08:03:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTlO2-0007QH-37
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 08:02:08 -0400
Received: from mail-eopbgr10094.outbound.protection.outlook.com
 ([40.107.1.94]:25438 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jTlO1-0007JO-Cx; Wed, 29 Apr 2020 08:00:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ot7SbZn4IN2ibJ16YuNvVBO4FXk+MViJ4q3z5TZ//8XfecKEbXfsKq+/qDSskUfwqOPc8qXPukRpw/tfEL4/IjaxAEwcDXerQMS9+PlnqpFWFw6wsYctWZXz8Vif46/u+9rUCkiVP45kN5LQdy/mVQ01+5VLrrxlBDfVsd53awJ1GKm8grJ1CskHiGex2KdWNn14Un4PMJkc42JVZhVDzQPvYXfBs0Gf7ZvndPi6GiC22rv+9Dqly3UuS5wUogepiZ9sn+qIUwmDGaq5rkl/aLOoXZguEmXhB2KOY+qD9GCfQbcLalinr7HRkns+Qqxp4KBmleHdEedhcx9G1Vu7tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHQVWOsnnEm/jtDqFr33y8nJaMcPT1GWj/o+6wg4cdw=;
 b=VX9SEYZ7TFeKQlubqgrQRMC3Ly2foMDyp2JNfl90n3iCBSJn5TzbWVITeM6hQi+aYZePSmm11l6ITQjxaRnp1lL0XG+uHjw0cDwB8yX9I2q+QJmyo0z0ulPa5bJfxLLBs3g/0MgGtj9yn7ozLDVJu+fpUD6O/qF8LKzHEk9T6V6E4h33TU1eYzs72oarjaYuQqQKVvqLoo6spqJtWay/t8Yze5/gcgH2p6azKYUDWWgW8RFPC70CdiKyuPh1pg5JpruFa6A+/uPiyL+Rcupe6buix9rlGbss5mznylcIlNt76Y/LomzNnt3iJ1Ju0BrvcqweevgF3D1wuRhyzPIsmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHQVWOsnnEm/jtDqFr33y8nJaMcPT1GWj/o+6wg4cdw=;
 b=Y7Iqo7c6vGj8hltdrGOR6BAN4G+6o7PrUCeYUEK5d/7S5MUSgvUmpn0ahhUzlveh2d9Otcg44mLy19e7v4oyl0GHNTTohqj+jid73WiJHFJgyUoyu8bbMxJjM12GkR5jDR+N01zE0iyzOAUnsh/diRWBeUJTxkZD8xtJ+7xBzxU=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5528.eurprd08.prod.outlook.com (2603:10a6:20b:dd::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Wed, 29 Apr
 2020 12:00:17 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.023; Wed, 29 Apr 2020
 12:00:17 +0000
Subject: Re: [PATCH 2/3] backup: Make sure that source and target size match
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200429111539.42103-1-kwolf@redhat.com>
 <20200429111539.42103-3-kwolf@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200429150015953
Message-ID: <7991aeee-59bf-0f36-c90e-1dd9adeee51a@virtuozzo.com>
Date: Wed, 29 Apr 2020 15:00:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200429111539.42103-3-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0013.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::23)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.184) by
 FRYP281CA0013.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.19 via Frontend Transport; Wed, 29 Apr 2020 12:00:17 +0000
X-Tagtoolbar-Keys: D20200429150015953
X-Originating-IP: [185.215.60.184]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 799964fd-8c9d-4b3f-1fd7-08d7ec34e268
X-MS-TrafficTypeDiagnostic: AM7PR08MB5528:
X-Microsoft-Antispam-PRVS: <AM7PR08MB55283ED594B906C561CEDC37C1AD0@AM7PR08MB5528.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03883BD916
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39840400004)(376002)(346002)(396003)(366004)(52116002)(31696002)(86362001)(186003)(16526019)(4326008)(2616005)(31686004)(956004)(36756003)(26005)(6486002)(66476007)(16576012)(66946007)(66556008)(8676002)(8936002)(2906002)(5660300002)(316002)(478600001)(966005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7VfobNCf+X3aGB+X9Rm/7C7ViacgpcTY9i5oSdkwSqzqtmjt0Cs4kEmL76rWb1xxwfS5kv55FGjBF2NJajQpxgt+4ui6X5J/KwdFNLpZGgswpmnXssKYh+ELxuRrbB5G8cHYjBXLSfDpOX1K/TL3yGAJVVWYKsHLHiWQ/AGCx6+whk/9uEj0+T3ozW86CELKoTBnmkltxigG2vXFqSUBdnK9P6zPn12LgQxNLqVEa0WG4rnOOqrHuiqNN+t/jI3lePfEueYm01aokNUL14Zppdau4apFJlITW0qIIMBhOnZ7luoDrqVvbeYgT8KH34b86I+GN3lRfSp9ppyWz1vMntJfIbbKPRBKzO3WdeGk+s70M7E8Y8xbxOlmL7NOfFesQ9bXpLEnCP5Ay2S1jd2vCKQE551a8+ahI89Xey9DNbBK7OhdAvINhAp4HMyILk/bW0ThJ5F4pif9U6LDiKADVuR8XeO6HyNXKQWLE74BLCGotKQz2fx65BRrUlhLnDGcZ1ZCmhrSjUj/HkccfyWg/A==
X-MS-Exchange-AntiSpam-MessageData: ugmgvy9Ad6p787yd8R7FxkCOg2A0oKsbMddJsOP9bZ9ieRZtluYtoF2xFvnVyoeqenVXwfuxH5oeYW8DV3bK3url44AJaVzTe+JdoLxsCxt4nLbqvPmwr7UtCPZr2dBg8qcHYNoqTW67uTPaERpWhiJQUKqtI+fWk2RB+J42QSFBFhSseeocfSY8IB5yNY+Csxpo30OY3JZzmmD3bREDVACCwne8sSffo2lSs+v0dhs9tsl4DQQbTKcZRXrGXyrDqf6p5u7RW5eAjj2Bz0GYR/sKFy3JW+SVQ4rv5WEhsUYiE0GIB+xZ0fwltkA/119AfEs8GOtrCtv5zBCPYdld3dTPzH5QYKuU12yJiraFq0O1IxMQW8AOUXivyaasiSh1qt0NvhwAB10Y/+ItMed9d4xBduXNB14yG0UJtkeOwW/4f+ADALNf+ZzfhrGcGjXekNOBFekbioCykRlm6jbZY3rFmP/h4I843ARDxlXv8yb7kPZqywvBUD9v/VdZVjB2miorzgyAGNt1jlbc4550E/FNFdKC9UmOcsnepX1SEjZ04BuygBpGFH62Ypb6j3Pfg95ZL4bbnFR/l232g6CWJ+iJ5jhZ2UjZOfYkZJmQWYtuB+kni6Kk9gm8sb6QkrSwVtzTleJsGoB/gBJJM0yqDPa4Eo+Ap43KgZSdfBH7uBxBHK7suAdLB8z4CCp2/GGpFCF1vVJ9BTf6eIkUGEs7UrICyhwJWlA9CbcQL0Ie86hNVTuyQ4UmvlBkV8q9BuMrx/Cav8FtHIx/j0wf3o8IvfH5SIJB3oD07KtR0dzY0Pc=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 799964fd-8c9d-4b3f-1fd7-08d7ec34e268
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2020 12:00:17.8298 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6pBkzM49dXLHlmnGp3TuubyHGqeaIsFxxdKwzEJa0J43OdD3S6GLNFhDoouoHGLZ9cZl2XYbL4czKRbzSHhjjvxlcFMJotjPX87cBlF2Cv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5528
Received-SPF: pass client-ip=40.107.1.94;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 08:00:18
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.1.94
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

29.04.2020 14:15, Kevin Wolf wrote:
> Since the introduction of a backup filter node, the backup block job
> crashes when the target image is smaller than the source image because
> it will try to write after the end of the target node without having
> BLK_PERM_RESIZE. (Previously, the BlockBackend layer would have caught
> this and errored out gracefully.)
> 
> We can fix this and even do better than the old behaviour: Check that
> source and target have the same image size at the start of the block job
> and unshare BLK_PERM_RESIZE. This will immediately error out when
> starting the job instead of only when writing to a block that doesn't
> exist in the target.
> 
> Longer target than source would technically work because we would never
> write to blocks that don't exist, but semantically these are invalid,
> too, because a backup is supposed to create a copy, not just an image
> that starts with a copy.
> 
> The bugs were introduced in commits 2c8074c45 (BLK_PERM_RESIZE is shared

no, it was unshared by blks in block-copy

> since this commit) and 00e30f05d (BdrvChild instead of BlockBackend
> turns I/O errors into assertion failures).

and here becomes shared.

So, seems only 00e30f05d is broken and introduces both problems

> 
> Fixes: 2c8074c453ff13a94bd08ec26061917670ec03be
> Fixes: 00e30f05de1d19586345ec373970ef4c192c6270
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1778593
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/backup-top.c | 12 ++++++++----
>   block/backup.c     | 14 +++++++++++++-
>   2 files changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/block/backup-top.c b/block/backup-top.c
> index 3b50c06e2c..0e515a7705 100644
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

Is it correct to use directly total_sectors and not bdrv_getlenght()?
Anyway, using bdrv_getlength() seems safer, and will help us if we move
to byte-accurate block-layer at some moment in future.

Hmm but total_sectors used directly anyway in this function, so OK


> +
> +    top = bdrv_new_open_driver(&bdrv_backup_top_filter, filter_node_name,
> +                              BDRV_O_RDWR, errp);

alignment broken. With it fixed:

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

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

