Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40807C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 18:59:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F11B320707
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 18:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="C2oWyoRV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F11B320707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixF2K-0001ts-4U
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 13:59:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54780)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1ixF1B-0000sc-9S
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 13:58:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1ixF19-0001dy-15
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 13:58:20 -0500
Received: from mail-eopbgr30101.outbound.protection.outlook.com
 ([40.107.3.101]:20910 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1ixF18-0001ah-By; Thu, 30 Jan 2020 13:58:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WoX149gbKIlncbegp+zsdIFbIq1SbaBcF8Ama0D0Vg2Ws7oc9a3C23eLUFPIW6UtqzcvAU+1lWgrlJdAPOgKnEc3WbxnHiZbiVkVdiYRHpCk/dhA+r+LcL1+pFnuugkN4+mR35LIvFGwAmvs/kKd/EFtsGC1RAxuFu3Y7C4Oui1wJrdeelxJltBVoQ3qAt6BbSo7ulnVUsAVad81fipWbQP3nsET9ISYzUglBYsl47MjdafUhGeyuW0cqs/K5rK+QVCLhNeHYBGd95vJsstWbx3bJ594H0WgPPPITMqwbOEIJhu0BAHd56y2ct9AOgY+maO7k5Swf7rQ9yJk1pUXgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiYEGbY/TUm+Qf0e/t29nynhehy5nKHArBTWlIBkfs4=;
 b=fsqVFw7St96vu7JpgiL86toURMDs+dfKAFfo6hIlwJXwlja/Kwoltc2zREE6RfJpoQUUnesh4H5FiM7oxj0WmXaGwpIL/FPJjV84Rfpp1M03qNpUeeDQCiP4FxRT+ufUamz6aRd4nynpcKYnzx3rcMjL9PmgkeiYDTR9XDuVt7A+15AfoVcMmo6+3BF0kq7RwpdCZkVCUzoUAbJHGfxXD8OImmtnJfAm+R3B+NrtVm1Rw7r0m0LcJCJ8SJzQC2GRQXuPCyYP2E2hIsWs2vAFozPEelP0AOS0tsXwqE4xnRb7i+VJUW2+NFAa0Rsq29nfi+Uc++zjJ9tCAWvb8ZhdXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiYEGbY/TUm+Qf0e/t29nynhehy5nKHArBTWlIBkfs4=;
 b=C2oWyoRVVUYvWn8wE+BRmSBvEgA265wG3NNrMJBW0rQbIswW5i51oR3Lm7q6fgDc9xeEsvNQKwBNi5I81BePBZUyZbFmnxEoYbrRusFBlGBJXNBg3Y7bNn6N4CKKbfcgfouIDSd53gWDouCRhMhiaX2Wr1gqu+CoPqPMHAliopw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com (10.255.123.95) by
 AM6PR08MB3942.eurprd08.prod.outlook.com (20.179.3.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22; Thu, 30 Jan 2020 18:58:15 +0000
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::8805:5633:ca46:c8c8]) by AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::8805:5633:ca46:c8c8%7]) with mapi id 15.20.2686.025; Thu, 30 Jan 2020
 18:58:15 +0000
Subject: Re: [PATCH v2 7/7] block/block-copy: hide structure definitions
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20191127180840.11937-1-vsementsov@virtuozzo.com>
 <20191127180840.11937-8-vsementsov@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Organization: Virtuozzo
Message-ID: <9db878a7-fe50-e8b3-bf6c-e5cc754e4262@virtuozzo.com>
Date: Thu, 30 Jan 2020 21:58:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20191127180840.11937-8-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1P190CA0015.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::25)
 To AM6PR08MB5048.eurprd08.prod.outlook.com
 (2603:10a6:20b:ee::31)
MIME-Version: 1.0
Received: from [172.16.24.225] (185.231.240.5) by
 HE1P190CA0015.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27 via Frontend Transport; Thu, 30 Jan 2020 18:58:14 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5871c671-c19b-4074-aef2-08d7a5b65c9f
X-MS-TrafficTypeDiagnostic: AM6PR08MB3942:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB39429C09775EDB7E183684ECF4040@AM6PR08MB3942.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:304;
X-Forefront-PRVS: 02981BE340
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(136003)(376002)(39850400004)(346002)(199004)(189003)(2616005)(2906002)(5660300002)(66946007)(66476007)(66556008)(53546011)(44832011)(956004)(4326008)(6486002)(30864003)(478600001)(186003)(31696002)(8936002)(86362001)(26005)(8676002)(16526019)(16576012)(36756003)(52116002)(31686004)(36916002)(81166006)(81156014)(316002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3942;
 H:AM6PR08MB5048.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3nnL9khgU8HAh9xv/EQ9bo1VmQJ9171RgrD7ufy5laQfdXjaIBnrhcj3bZ6xQR/O8mFPDl4DKKOrJ0tmuKanzdesclHUOOsYrNgCp9mcUn5+dOUQcnX37XjWR7aJJGapYWuWVfrgCxqoi/KJOA4xWdyXCEIf3R+cpRKCcvFyFBILTRXNmQAfg/w/rU97izcIc76mSqOytnvqVr+h3GL2ypjp/J29VbJUENtMr3r68+3cxCgPgsQ7/VZIcx6zrQAgZG5rh3uLud9neQORJRShvqvBJwCdb1fuaubESu/HFwSRlfsQEJxpYuy9VRJqw0R2C28NOwh6LxQtY8It1G63+DwZcaBbUZ3yHIHVmM4incB8akKFuEPlVoLIkNVd+i+UQC3ELURQ571Q0G/NWmdHMszt2OYmBBAv0cFbvXSHp8ahqiJG5aDsuo1VlkBiVCZ7
X-MS-Exchange-AntiSpam-MessageData: XTOBe8CFsunB/I8FHgx2w4jf+ehNcyK71SNOx+DnfWnM7jS1r8+8A6XfzhKO6Op2gjwfxTo7a8nPlG3p5Ekvce3hKtUyCWbkOxLc3YFYfKX2wv2M6A6w/2nU/3VkwGfOileTcT8zwg63ihARZkjyWg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5871c671-c19b-4074-aef2-08d7a5b65c9f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2020 18:58:15.4443 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MfesI5IOt5X+oUYz395fjCzYVK/7QV/ZiFXBp35RXeJs22Jf8+S4hCWWXI6f9Svi9EoiaZ3bNv9r7zQ5DKNvlaorOBSvV8uiJtYY1yHtmm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3942
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.101
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
Cc: kwolf@redhat.com, den@openvz.org, jsnow@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 27/11/2019 21:08, Vladimir Sementsov-Ogievskiy wrote:
> Hide structure definitions and add explicit API instead, to keep an
> eye on the scope of the shared fields.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   include/block/block-copy.h | 57 +++------------------------------
>   block/backup-top.c         |  6 ++--
>   block/backup.c             | 27 ++++++++--------
>   block/block-copy.c         | 64 ++++++++++++++++++++++++++++++++++++++
>   4 files changed, 86 insertions(+), 68 deletions(-)
>=20
> diff --git a/include/block/block-copy.h b/include/block/block-copy.h
> index d96b097267..753fa663ac 100644
> --- a/include/block/block-copy.h
> +++ b/include/block/block-copy.h
> @@ -18,61 +18,9 @@
>   #include "block/block.h"
>   #include "qemu/co-shared-resource.h"
>  =20
> -typedef struct BlockCopyInFlightReq {
> -    int64_t offset;
> -    int64_t bytes;
> -    QLIST_ENTRY(BlockCopyInFlightReq) list;
> -    CoQueue wait_queue; /* coroutines blocked on this request */
> -} BlockCopyInFlightReq;
> -
>   typedef void (*ProgressBytesCallbackFunc)(int64_t bytes, void *opaque);
>   typedef void (*ProgressResetCallbackFunc)(void *opaque);
> -typedef struct BlockCopyState {
> -    /*
> -     * BdrvChild objects are not owned or managed by block-copy. They ar=
e
> -     * provided by block-copy user and user is responsible for appropria=
te
> -     * permissions on these children.
> -     */
> -    BdrvChild *source;
> -    BdrvChild *target;
> -    BdrvDirtyBitmap *copy_bitmap;
> -    int64_t cluster_size;
> -    bool use_copy_range;
> -    int64_t copy_size;
> -    uint64_t len;
> -    QLIST_HEAD(, BlockCopyInFlightReq) inflight_reqs;
> -
> -    BdrvRequestFlags write_flags;
> -
> -    /*
> -     * skip_unallocated:
> -     *
> -     * Used by sync=3Dtop jobs, which first scan the source node for una=
llocated
> -     * areas and clear them in the copy_bitmap.  During this process, th=
e bitmap
> -     * is thus not fully initialized: It may still have bits set for are=
as that
> -     * are unallocated and should actually not be copied.
> -     *
> -     * This is indicated by skip_unallocated.
> -     *
> -     * In this case, block_copy() will query the source=E2=80=99s alloca=
tion status,
> -     * skip unallocated regions, clear them in the copy_bitmap, and invo=
ke
> -     * block_copy_reset_unallocated() every time it does.
> -     */
> -    bool skip_unallocated;
> -
> -    /* progress_bytes_callback: called when some copying progress is don=
e. */
> -    ProgressBytesCallbackFunc progress_bytes_callback;
> -
> -    /*
> -     * progress_reset_callback: called when some bytes reset from copy_b=
itmap
> -     * (see @skip_unallocated above). The callee is assumed to recalcula=
te how
> -     * many bytes remain based on the dirty bit count of copy_bitmap.
> -     */
> -    ProgressResetCallbackFunc progress_reset_callback;
> -    void *progress_opaque;
> -
> -    SharedResource *mem;
> -} BlockCopyState;
> +typedef struct BlockCopyState BlockCopyState;
>  =20
>   BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *targ=
et,
>                                        int64_t cluster_size,
> @@ -93,4 +41,7 @@ int64_t block_copy_reset_unallocated(BlockCopyState *s,
>   int coroutine_fn block_copy(BlockCopyState *s, int64_t start, uint64_t =
bytes,
>                               bool *error_is_read);
>  =20
> +BdrvDirtyBitmap *block_copy_dirty_bitmap(BlockCopyState *s);
> +void block_copy_set_skip_unallocated(BlockCopyState *s, bool skip);
> +
>   #endif /* BLOCK_COPY_H */
> diff --git a/block/backup-top.c b/block/backup-top.c
> index 7cdb1f8eba..1026628b57 100644
> --- a/block/backup-top.c
> +++ b/block/backup-top.c
> @@ -38,6 +38,7 @@ typedef struct BDRVBackupTopState {
>       BlockCopyState *bcs;
>       BdrvChild *target;
>       bool active;
> +    int64_t cluster_size;
>   } BDRVBackupTopState;
>  =20
>   static coroutine_fn int backup_top_co_preadv(
> @@ -51,8 +52,8 @@ static coroutine_fn int backup_top_cbw(BlockDriverState=
 *bs, uint64_t offset,
>                                          uint64_t bytes)
>   {
>       BDRVBackupTopState *s =3D bs->opaque;
> -    uint64_t end =3D QEMU_ALIGN_UP(offset + bytes, s->bcs->cluster_size)=
;
> -    uint64_t off =3D QEMU_ALIGN_DOWN(offset, s->bcs->cluster_size);
> +    uint64_t end =3D QEMU_ALIGN_UP(offset + bytes, s->cluster_size);
> +    uint64_t off =3D QEMU_ALIGN_DOWN(offset, s->cluster_size);
>  =20
>       return block_copy(s->bcs, off, end - off, NULL);
>   }
> @@ -227,6 +228,7 @@ BlockDriverState *bdrv_backup_top_append(BlockDriverS=
tate *source,
>           goto failed_after_append;
>       }
>  =20
> +    state->cluster_size =3D cluster_size;
>       state->bcs =3D block_copy_state_new(top->backing, state->target,
>                                         cluster_size, write_flags, &local=
_err);
>       if (local_err) {
> diff --git a/block/backup.c b/block/backup.c
> index cf62b1a38c..acab0d08da 100644
> --- a/block/backup.c
> +++ b/block/backup.c
> @@ -48,6 +48,7 @@ typedef struct BackupBlockJob {
>       int64_t cluster_size;
>  =20
>       BlockCopyState *bcs;
> +    BdrvDirtyBitmap *bcs_bitmap;
>   } BackupBlockJob;
>  =20
>   static const BlockJobDriver backup_job_driver;
> @@ -63,7 +64,7 @@ static void backup_progress_bytes_callback(int64_t byte=
s, void *opaque)
>   static void backup_progress_reset_callback(void *opaque)
>   {
>       BackupBlockJob *s =3D opaque;
> -    uint64_t estimate =3D bdrv_get_dirty_count(s->bcs->copy_bitmap);
> +    uint64_t estimate =3D bdrv_get_dirty_count(s->bcs_bitmap);
>  =20
>       job_progress_set_remaining(&s->common.job, estimate);
>   }
> @@ -111,8 +112,7 @@ static void backup_cleanup_sync_bitmap(BackupBlockJob=
 *job, int ret)
>  =20
>       if (ret < 0 && job->bitmap_mode =3D=3D BITMAP_SYNC_MODE_ALWAYS) {
>           /* If we failed and synced, merge in the bits we didn't copy: *=
/
> -        bdrv_dirty_bitmap_merge_internal(bm, job->bcs->copy_bitmap,
> -                                         NULL, true);
> +        bdrv_dirty_bitmap_merge_internal(bm, job->bcs_bitmap, NULL, true=
);
>       }
>   }
>  =20
> @@ -151,7 +151,7 @@ void backup_do_checkpoint(BlockJob *job, Error **errp=
)
>           return;
>       }
>  =20
> -    bdrv_set_dirty_bitmap(backup_job->bcs->copy_bitmap, 0, backup_job->l=
en);
> +    bdrv_set_dirty_bitmap(backup_job->bcs_bitmap, 0, backup_job->len);
>   }
>  =20
>   static BlockErrorAction backup_error_action(BackupBlockJob *job,
> @@ -196,7 +196,7 @@ static int coroutine_fn backup_loop(BackupBlockJob *j=
ob)
>       BdrvDirtyBitmapIter *bdbi;
>       int ret =3D 0;
>  =20
> -    bdbi =3D bdrv_dirty_iter_new(job->bcs->copy_bitmap);
> +    bdbi =3D bdrv_dirty_iter_new(job->bcs_bitmap);
>       while ((offset =3D bdrv_dirty_iter_next(bdbi)) !=3D -1) {
>           do {
>               if (yield_and_check(job)) {
> @@ -216,13 +216,13 @@ static int coroutine_fn backup_loop(BackupBlockJob =
*job)
>       return ret;
>   }
>  =20
> -static void backup_init_copy_bitmap(BackupBlockJob *job)
> +static void backup_init_bcs_bitmap(BackupBlockJob *job)
>   {
>       bool ret;
>       uint64_t estimate;
>  =20
>       if (job->sync_mode =3D=3D MIRROR_SYNC_MODE_BITMAP) {
> -        ret =3D bdrv_dirty_bitmap_merge_internal(job->bcs->copy_bitmap,
> +        ret =3D bdrv_dirty_bitmap_merge_internal(job->bcs_bitmap,
>                                                  job->sync_bitmap,
>                                                  NULL, true);
>           assert(ret);
> @@ -232,12 +232,12 @@ static void backup_init_copy_bitmap(BackupBlockJob =
*job)
>                * We can't hog the coroutine to initialize this thoroughly=
.
>                * Set a flag and resume work when we are able to yield saf=
ely.
>                */
> -            job->bcs->skip_unallocated =3D true;
> +            block_copy_set_skip_unallocated(job->bcs, true);
>           }
> -        bdrv_set_dirty_bitmap(job->bcs->copy_bitmap, 0, job->len);
> +        bdrv_set_dirty_bitmap(job->bcs_bitmap, 0, job->len);
>       }
>  =20
> -    estimate =3D bdrv_get_dirty_count(job->bcs->copy_bitmap);
> +    estimate =3D bdrv_get_dirty_count(job->bcs_bitmap);
>       job_progress_set_remaining(&job->common.job, estimate);
>   }
>  =20
> @@ -246,7 +246,7 @@ static int coroutine_fn backup_run(Job *job, Error **=
errp)
>       BackupBlockJob *s =3D container_of(job, BackupBlockJob, common.job)=
;
>       int ret =3D 0;
>  =20
> -    backup_init_copy_bitmap(s);
> +    backup_init_bcs_bitmap(s);
>  =20
>       if (s->sync_mode =3D=3D MIRROR_SYNC_MODE_TOP) {
>           int64_t offset =3D 0;
> @@ -265,12 +265,12 @@ static int coroutine_fn backup_run(Job *job, Error =
**errp)
>  =20
>               offset +=3D count;
>           }
> -        s->bcs->skip_unallocated =3D false;
> +        block_copy_set_skip_unallocated(s->bcs, false);
>       }
>  =20
>       if (s->sync_mode =3D=3D MIRROR_SYNC_MODE_NONE) {
>           /*
> -         * All bits are set in copy_bitmap to allow any cluster to be co=
pied.
> +         * All bits are set in bcs_bitmap to allow any cluster to be cop=
ied.
>            * This does not actually require them to be copied.
>            */
>           while (!job_is_cancelled(job)) {
> @@ -458,6 +458,7 @@ BlockJob *backup_job_create(const char *job_id, Block=
DriverState *bs,
>       job->sync_bitmap =3D sync_bitmap;
>       job->bitmap_mode =3D bitmap_mode;
>       job->bcs =3D bcs;
> +    job->bcs_bitmap =3D block_copy_dirty_bitmap(bcs);
>       job->cluster_size =3D cluster_size;
>       job->len =3D len;
>  =20
> diff --git a/block/block-copy.c b/block/block-copy.c
> index aca44b13fb..7e14e86a2d 100644
> --- a/block/block-copy.c
> +++ b/block/block-copy.c
> @@ -24,6 +24,60 @@
>   #define BLOCK_COPY_MAX_BUFFER (1 * MiB)
>   #define BLOCK_COPY_MAX_MEM (128 * MiB)
>  =20
> +typedef struct BlockCopyInFlightReq {
> +    int64_t offset;
> +    int64_t bytes;
> +    QLIST_ENTRY(BlockCopyInFlightReq) list;
> +    CoQueue wait_queue; /* coroutines blocked on this request */
> +} BlockCopyInFlightReq;
> +
> +typedef struct BlockCopyState {
> +    /*
> +     * BdrvChild objects are not owned or managed by block-copy. They ar=
e
> +     * provided by block-copy user and user is responsible for appropria=
te
> +     * permissions on these children.
> +     */
> +    BdrvChild *source;
> +    BdrvChild *target;
> +    BdrvDirtyBitmap *copy_bitmap;
> +    int64_t cluster_size;
> +    bool use_copy_range;
> +    int64_t copy_size;
> +    uint64_t len;
> +    QLIST_HEAD(, BlockCopyInFlightReq) inflight_reqs;
> +
> +    BdrvRequestFlags write_flags;
> +
> +    /*
> +     * skip_unallocated:
> +     *
> +     * Used by sync=3Dtop jobs, which first scan the source node for una=
llocated
> +     * areas and clear them in the copy_bitmap.  During this process, th=
e bitmap
> +     * is thus not fully initialized: It may still have bits set for are=
as that
> +     * are unallocated and should actually not be copied.
> +     *
> +     * This is indicated by skip_unallocated.
> +     *
> +     * In this case, block_copy() will query the source=E2=80=99s alloca=
tion status,
> +     * skip unallocated regions, clear them in the copy_bitmap, and invo=
ke
> +     * block_copy_reset_unallocated() every time it does.
> +     */
> +    bool skip_unallocated;
> +
> +    /* progress_bytes_callback: called when some copying progress is don=
e. */
> +    ProgressBytesCallbackFunc progress_bytes_callback;
> +
> +    /*
> +     * progress_reset_callback: called when some bytes reset from copy_b=
itmap
> +     * (see @skip_unallocated above). The callee is assumed to recalcula=
te how
> +     * many bytes remain based on the dirty bit count of copy_bitmap.
> +     */
> +    ProgressResetCallbackFunc progress_reset_callback;
> +    void *progress_opaque;
> +
> +    SharedResource *mem;
> +} BlockCopyState;
> +
>   static BlockCopyInFlightReq *block_copy_find_inflight_req(BlockCopyStat=
e *s,
>                                                             int64_t offse=
t,
>                                                             int64_t bytes=
)
> @@ -492,3 +546,13 @@ int coroutine_fn block_copy(BlockCopyState *s, int64=
_t start, uint64_t bytes,
>  =20
>       return 0;
>   }
> +
> +BdrvDirtyBitmap *block_copy_dirty_bitmap(BlockCopyState *s)
> +{
> +    return s->copy_bitmap;
> +}
> +
> +void block_copy_set_skip_unallocated(BlockCopyState *s, bool skip)
> +{
> +    s->skip_unallocated =3D skip;
> +}
>=20

The idea of API is OK but we have got the duplicated members in the=20
nested structures.

Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
--=20
With the best regards,
Andrey Shinkevich


