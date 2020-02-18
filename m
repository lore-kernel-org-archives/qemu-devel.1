Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF2CC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 13:09:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B5F820801
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 13:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FRZAHHVD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B5F820801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j42d2-0006Gx-FD
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 08:09:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43070)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1j42Zm-0001Ow-Ip
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:06:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1j42Zk-0003ac-FY
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:06:10 -0500
Received: from mail-eopbgr70121.outbound.protection.outlook.com
 ([40.107.7.121]:13328 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1j42ZZ-0003WV-N7; Tue, 18 Feb 2020 08:05:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eyphQS+XftUmeskgyvs8iA2m8rXujc9dj7vUTDNVw1zyu0dxmrks6EusNrTa95H9g30/03DaKsPlgy0IronBLD/auLX1e0574wsePmoaO2xeZa98uGjQ1+uMuEWSu3TBwil24jN3uzfNy0kxW8bUPzd76U7PnKcZazGtf/KVW1kgyqZgMTLla/SH5pBo0SfjKGz0FJyxxfWt9wbq45UAjHvS4tvrRm0fbMr9BEH3reQlM3NXRnaxkUDiFvmxshm3XezD955phGS/A/z+IwmxrQam3MZ6n9VLLJnzOI7tE08MlyRhsLvPVOGIxdtCeNGC3S20afJPzul0Pr51y6hN9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHglvF863bURst2HYt3WcTE4YmwAL6JZgbn6apPOnv8=;
 b=MdoMPWglR2PUCnpvSHdJjd/YgUOY+WOTTIKMBCpRCiNBuxPYgiB/jhNAGbX8+GrFVbmqb3lKCspaMl4VLXv18DKh3i4746hnonWpxzXiqqCWRiKITV87KgMSv2VJ7wn06Taq/4c74t0BF3KJZU9+tsG/f3fSUYdl/OUwZ6j0PJLDwjfkFYsNtM5IqclDymrY59Kg/PefydHy3qkcPDqvY0i6MGztiijr/7JX1adyzYuTrxGfJECXws3cfmGIcMFMAAHG0DA37PrkMKzKpu9ajMWcEIKEzur68acY141ZqcHhgNHDq6JIalC36ybB08ciBSvO99dGQPCfl1PwyiYE1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHglvF863bURst2HYt3WcTE4YmwAL6JZgbn6apPOnv8=;
 b=FRZAHHVD54nnlqCLLpdy6ci/fV2jkKeZDn8u6qYBLqEyGmJt2QcVh6alcKOv83tewQewagk5ZseBJ320v5lfQ3QtTHWsEJ7v51hlnZpE7OkBZsNg2soVlteAWxqe23Hqkv/hyHQodJnCGASMcvPjRmpt0eT/RAPc9OXoY6B9HI0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com (10.255.123.95) by
 AM6PR08MB3399.eurprd08.prod.outlook.com (20.177.113.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Tue, 18 Feb 2020 13:05:54 +0000
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::1883:da16:865a:139d]) by AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::1883:da16:865a:139d%5]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 13:05:54 +0000
Subject: Re: [PATCH v2 05/22] migration/block-dirty-bitmap: refactor state
 global variables
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
 <20200217150246.29180-6-vsementsov@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Organization: Virtuozzo
Message-ID: <662ed516-18c4-6bfd-c295-f2528e770d15@virtuozzo.com>
Date: Tue, 18 Feb 2020 16:05:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200217150246.29180-6-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0902CA0001.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::11) To AM6PR08MB5048.eurprd08.prod.outlook.com
 (2603:10a6:20b:ee::31)
MIME-Version: 1.0
Received: from [172.16.24.225] (185.231.240.5) by
 HE1PR0902CA0001.eurprd09.prod.outlook.com (2603:10a6:3:e5::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23 via Frontend Transport; Tue, 18 Feb 2020 13:05:54 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6069c898-d5a4-40fe-4cf7-08d7b47349b0
X-MS-TrafficTypeDiagnostic: AM6PR08MB3399:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB339972B6B7859A3BD86AC523F4110@AM6PR08MB3399.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:108;
X-Forefront-PRVS: 031763BCAF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(136003)(39850400004)(396003)(346002)(199004)(189003)(31696002)(26005)(53546011)(86362001)(5660300002)(44832011)(8936002)(186003)(956004)(2906002)(2616005)(30864003)(31686004)(66946007)(66476007)(66556008)(16526019)(81166006)(81156014)(478600001)(16576012)(316002)(6486002)(8676002)(36916002)(4326008)(52116002)(36756003)(54906003)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3399;
 H:AM6PR08MB5048.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q98mnZ0UpOXFQ3l5McwHXeX5XrSexKCIsBVUT8fdeZaaCmslBy2SwA/gB1tRG6JuHlp6qbiORduHYheJnfEeTzjVG5AQ+3qBVOfrh/tcp9+njYycERanlULoFb0JxbMHFVMBzXMVb1L8edH7JtQoAoS5oHFkfyUm+6jr3qy6lPhJEAhcnIUXSjGgS/5vBF9p3vg5Qx9E8fXd8M9G6PW6rt9VIicYIrmUvexQ5OwkUKp+7kDVHG7a7vV4/r2cyMkKQHHgbNyabT0J2shJOCGktVVlCVcvzCeC+11afIz8zitFx8K02E+nPCWnHFwdilKA/aVTW95oQNan1M7xqwk9ArVn47Ka+rD3ZFAR9poV+dI9kAoiRybMZ/DtFMwsrnj4Z+WQc6K+e1+mIUOHpegvuAh5kgrTFgKhgu9xk61qf3NhUbSHladHabL9zpg90DwqHqe5iguwZkcBtE7Ex7KhXelIDkBz21i4A685dInaEguydc50k99mZx8t7TUlLgmW
X-MS-Exchange-AntiSpam-MessageData: l4Wey6tzBuSWuodRYr7FSbDp1P74zanLMuO7yK0BwtwqkdOH7ymu4JIdgHd4vsP7Y+DaaSqTEGAiqqzwBOZHNAzr7f/VzXWSElQLHBeNj0jV5z+jfl027EoUWzu5D1O8iwq/ucXWxuoUNEOE0KceCA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6069c898-d5a4-40fe-4cf7-08d7b47349b0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2020 13:05:54.7983 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WtZy1RrYaLCTgyegvMA6dDp+qBQShJqCzP+y44MzaJdDyXHZ2bbr4HY2LmTqqzhPxfM5yP46IHDeADAjfS6PcXw9ZCIXgiTMDA0gexvPYRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3399
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.121
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
Cc: Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org, quintela@redhat.com,
 dgilbert@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 17/02/2020 18:02, Vladimir Sementsov-Ogievskiy wrote:
> Move all state variables into one global struct. Reduce global
> variable usage, utilizing opaque pointer where possible.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   migration/block-dirty-bitmap.c | 171 ++++++++++++++++++---------------
>   1 file changed, 95 insertions(+), 76 deletions(-)
> 
> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
> index 49d4cf8810..7a82b76809 100644
> --- a/migration/block-dirty-bitmap.c
> +++ b/migration/block-dirty-bitmap.c
> @@ -128,6 +128,12 @@ typedef struct DBMSaveState {
>       BdrvDirtyBitmap *prev_bitmap;
>   } DBMSaveState;
>   
> +typedef struct LoadBitmapState {
> +    BlockDriverState *bs;
> +    BdrvDirtyBitmap *bitmap;
> +    bool migrated;
> +} LoadBitmapState;
> +
>   /* State of the dirty bitmap migration (DBM) during load process */
>   typedef struct DBMLoadState {
>       uint32_t flags;
> @@ -135,18 +141,17 @@ typedef struct DBMLoadState {
>       char bitmap_name[256];
>       BlockDriverState *bs;
>       BdrvDirtyBitmap *bitmap;
> +
> +    GSList *enabled_bitmaps;
> +    QemuMutex finish_lock;
>   } DBMLoadState;
>   
> -static DBMSaveState dirty_bitmap_mig_state;
> +typedef struct DBMState {
> +    DBMSaveState save;
> +    DBMLoadState load;
> +} DBMState;
>   
> -/* State of one bitmap during load process */
> -typedef struct LoadBitmapState {
> -    BlockDriverState *bs;
> -    BdrvDirtyBitmap *bitmap;
> -    bool migrated;
> -} LoadBitmapState;
> -static GSList *enabled_bitmaps;
> -QemuMutex finish_lock;
> +static DBMState dbm_state;
>   
>   static uint32_t qemu_get_bitmap_flags(QEMUFile *f)
>   {
> @@ -169,21 +174,21 @@ static void qemu_put_bitmap_flags(QEMUFile *f, uint32_t flags)
>       qemu_put_byte(f, flags);
>   }
>   
> -static void send_bitmap_header(QEMUFile *f, SaveBitmapState *dbms,
> -                               uint32_t additional_flags)
> +static void send_bitmap_header(QEMUFile *f, DBMSaveState *s,
> +                               SaveBitmapState *dbms, uint32_t additional_flags)
>   {
>       BlockDriverState *bs = dbms->bs;
>       BdrvDirtyBitmap *bitmap = dbms->bitmap;
>       uint32_t flags = additional_flags;
>       trace_send_bitmap_header_enter();
>   
> -    if (bs != dirty_bitmap_mig_state.prev_bs) {
> -        dirty_bitmap_mig_state.prev_bs = bs;
> +    if (bs != s->prev_bs) {
> +        s->prev_bs = bs;
>           flags |= DIRTY_BITMAP_MIG_FLAG_DEVICE_NAME;
>       }
>   
> -    if (bitmap != dirty_bitmap_mig_state.prev_bitmap) {
> -        dirty_bitmap_mig_state.prev_bitmap = bitmap;
> +    if (bitmap != s->prev_bitmap) {
> +        s->prev_bitmap = bitmap;
>           flags |= DIRTY_BITMAP_MIG_FLAG_BITMAP_NAME;
>       }
>   
> @@ -198,19 +203,22 @@ static void send_bitmap_header(QEMUFile *f, SaveBitmapState *dbms,
>       }
>   }
>   
> -static void send_bitmap_start(QEMUFile *f, SaveBitmapState *dbms)
> +static void send_bitmap_start(QEMUFile *f, DBMSaveState *s,
> +                              SaveBitmapState *dbms)
>   {
> -    send_bitmap_header(f, dbms, DIRTY_BITMAP_MIG_FLAG_START);
> +    send_bitmap_header(f, s, dbms, DIRTY_BITMAP_MIG_FLAG_START);
>       qemu_put_be32(f, bdrv_dirty_bitmap_granularity(dbms->bitmap));
>       qemu_put_byte(f, dbms->flags);
>   }
>   
> -static void send_bitmap_complete(QEMUFile *f, SaveBitmapState *dbms)
> +static void send_bitmap_complete(QEMUFile *f, DBMSaveState *s,
> +                                 SaveBitmapState *dbms)
>   {
> -    send_bitmap_header(f, dbms, DIRTY_BITMAP_MIG_FLAG_COMPLETE);
> +    send_bitmap_header(f, s, dbms, DIRTY_BITMAP_MIG_FLAG_COMPLETE);
>   }
>   
> -static void send_bitmap_bits(QEMUFile *f, SaveBitmapState *dbms,
> +static void send_bitmap_bits(QEMUFile *f, DBMSaveState *s,
> +                             SaveBitmapState *dbms,
>                                uint64_t start_sector, uint32_t nr_sectors)
>   {
>       /* align for buffer_is_zero() */
> @@ -235,7 +243,7 @@ static void send_bitmap_bits(QEMUFile *f, SaveBitmapState *dbms,
>   
>       trace_send_bitmap_bits(flags, start_sector, nr_sectors, buf_size);
>   
> -    send_bitmap_header(f, dbms, flags);
> +    send_bitmap_header(f, s, dbms, flags);
>   
>       qemu_put_be64(f, start_sector);
>       qemu_put_be32(f, nr_sectors);
> @@ -254,12 +262,12 @@ static void send_bitmap_bits(QEMUFile *f, SaveBitmapState *dbms,
>   }
>   
>   /* Called with iothread lock taken.  */
> -static void dirty_bitmap_do_save_cleanup(void)
> +static void dirty_bitmap_do_save_cleanup(DBMSaveState *s)
>   {
>       SaveBitmapState *dbms;
>   
> -    while ((dbms = QSIMPLEQ_FIRST(&dirty_bitmap_mig_state.dbms_list)) != NULL) {
> -        QSIMPLEQ_REMOVE_HEAD(&dirty_bitmap_mig_state.dbms_list, entry);
> +    while ((dbms = QSIMPLEQ_FIRST(&s->dbms_list)) != NULL) {
> +        QSIMPLEQ_REMOVE_HEAD(&s->dbms_list, entry);
>           bdrv_dirty_bitmap_set_busy(dbms->bitmap, false);
>           bdrv_unref(dbms->bs);
>           g_free(dbms);
> @@ -267,17 +275,17 @@ static void dirty_bitmap_do_save_cleanup(void)
>   }
>   
>   /* Called with iothread lock taken. */
> -static int init_dirty_bitmap_migration(void)
> +static int init_dirty_bitmap_migration(DBMSaveState *s)
>   {
>       BlockDriverState *bs;
>       BdrvDirtyBitmap *bitmap;
>       SaveBitmapState *dbms;
>       Error *local_err = NULL;
>   
> -    dirty_bitmap_mig_state.bulk_completed = false;
> -    dirty_bitmap_mig_state.prev_bs = NULL;
> -    dirty_bitmap_mig_state.prev_bitmap = NULL;
> -    dirty_bitmap_mig_state.no_bitmaps = false;
> +    s->bulk_completed = false;
> +    s->prev_bs = NULL;
> +    s->prev_bitmap = NULL;
> +    s->no_bitmaps = false;
>   
>       for (bs = bdrv_next_all_states(NULL); bs; bs = bdrv_next_all_states(bs)) {
>           const char *name = bdrv_get_device_or_node_name(bs);
> @@ -316,35 +324,36 @@ static int init_dirty_bitmap_migration(void)
>                   dbms->flags |= DIRTY_BITMAP_MIG_START_FLAG_PERSISTENT;
>               }
>   
> -            QSIMPLEQ_INSERT_TAIL(&dirty_bitmap_mig_state.dbms_list,
> +            QSIMPLEQ_INSERT_TAIL(&s->dbms_list,
>                                    dbms, entry);
>           }
>       }
>   
>       /* unset migration flags here, to not roll back it */
> -    QSIMPLEQ_FOREACH(dbms, &dirty_bitmap_mig_state.dbms_list, entry) {
> +    QSIMPLEQ_FOREACH(dbms, &s->dbms_list, entry) {
>           bdrv_dirty_bitmap_skip_store(dbms->bitmap, true);
>       }
>   
> -    if (QSIMPLEQ_EMPTY(&dirty_bitmap_mig_state.dbms_list)) {
> -        dirty_bitmap_mig_state.no_bitmaps = true;
> +    if (QSIMPLEQ_EMPTY(&s->dbms_list)) {
> +        s->no_bitmaps = true;
>       }
>   
>       return 0;
>   
>   fail:
> -    dirty_bitmap_do_save_cleanup();
> +    dirty_bitmap_do_save_cleanup(s);
>   
>       return -1;
>   }
>   
>   /* Called with no lock taken.  */
> -static void bulk_phase_send_chunk(QEMUFile *f, SaveBitmapState *dbms)
> +static void bulk_phase_send_chunk(QEMUFile *f, DBMSaveState *s,
> +                                  SaveBitmapState *dbms)
>   {
>       uint32_t nr_sectors = MIN(dbms->total_sectors - dbms->cur_sector,
>                                dbms->sectors_per_chunk);
>   
> -    send_bitmap_bits(f, dbms, dbms->cur_sector, nr_sectors);
> +    send_bitmap_bits(f, s, dbms, dbms->cur_sector, nr_sectors);
>   
>       dbms->cur_sector += nr_sectors;
>       if (dbms->cur_sector >= dbms->total_sectors) {
> @@ -353,61 +362,66 @@ static void bulk_phase_send_chunk(QEMUFile *f, SaveBitmapState *dbms)
>   }
>   
>   /* Called with no lock taken.  */
> -static void bulk_phase(QEMUFile *f, bool limit)
> +static void bulk_phase(QEMUFile *f, DBMSaveState *s, bool limit)
>   {
>       SaveBitmapState *dbms;
>   
> -    QSIMPLEQ_FOREACH(dbms, &dirty_bitmap_mig_state.dbms_list, entry) {
> +    QSIMPLEQ_FOREACH(dbms, &s->dbms_list, entry) {
>           while (!dbms->bulk_completed) {
> -            bulk_phase_send_chunk(f, dbms);
> +            bulk_phase_send_chunk(f, s, dbms);
>               if (limit && qemu_file_rate_limit(f)) {
>                   return;
>               }
>           }
>       }
>   
> -    dirty_bitmap_mig_state.bulk_completed = true;
> +    s->bulk_completed = true;
>   }
>   
>   /* for SaveVMHandlers */
>   static void dirty_bitmap_save_cleanup(void *opaque)
>   {
> -    dirty_bitmap_do_save_cleanup();
> +    DBMSaveState *s = &((DBMState *)opaque)->save;
> +
> +    dirty_bitmap_do_save_cleanup(s);
>   }

Why do one need the extra nested "do" function?

>   
>   static int dirty_bitmap_save_iterate(QEMUFile *f, void *opaque)
>   {
> +    DBMSaveState *s = &((DBMState *)opaque)->save;
> +
>       trace_dirty_bitmap_save_iterate(migration_in_postcopy());
>   
> -    if (migration_in_postcopy() && !dirty_bitmap_mig_state.bulk_completed) {
> -        bulk_phase(f, true);
> +    if (migration_in_postcopy() && !s->bulk_completed) {
> +        bulk_phase(f, s, true);
>       }
>   
>       qemu_put_bitmap_flags(f, DIRTY_BITMAP_MIG_FLAG_EOS);
>   
> -    return dirty_bitmap_mig_state.bulk_completed;
> +    return s->bulk_completed;
>   }
>   
>   /* Called with iothread lock taken.  */
>   
>   static int dirty_bitmap_save_complete(QEMUFile *f, void *opaque)
>   {
> +    DBMSaveState *s = &((DBMState *)opaque)->save;
>       SaveBitmapState *dbms;
>       trace_dirty_bitmap_save_complete_enter();
>   
> -    if (!dirty_bitmap_mig_state.bulk_completed) {
> -        bulk_phase(f, false);
> +    if (!s->bulk_completed) {
> +        bulk_phase(f, s, false);
>       }
>   
> -    QSIMPLEQ_FOREACH(dbms, &dirty_bitmap_mig_state.dbms_list, entry) {
> -        send_bitmap_complete(f, dbms);
> +    QSIMPLEQ_FOREACH(dbms, &s->dbms_list, entry) {
> +        send_bitmap_complete(f, s, dbms);
>       }
>   
>       qemu_put_bitmap_flags(f, DIRTY_BITMAP_MIG_FLAG_EOS);
>   
>       trace_dirty_bitmap_save_complete_finish();
>   
> -    dirty_bitmap_do_save_cleanup();
> +    dirty_bitmap_save_cleanup(opaque);
>       return 0;
>   }
>   
> @@ -417,12 +431,13 @@ static void dirty_bitmap_save_pending(QEMUFile *f, void *opaque,
>                                         uint64_t *res_compatible,
>                                         uint64_t *res_postcopy_only)
>   {
> +    DBMSaveState *s = &((DBMState *)opaque)->save;
>       SaveBitmapState *dbms;
>       uint64_t pending = 0;
>   
>       qemu_mutex_lock_iothread();
>   
> -    QSIMPLEQ_FOREACH(dbms, &dirty_bitmap_mig_state.dbms_list, entry) {
> +    QSIMPLEQ_FOREACH(dbms, &s->dbms_list, entry) {
>           uint64_t gran = bdrv_dirty_bitmap_granularity(dbms->bitmap);
>           uint64_t sectors = dbms->bulk_completed ? 0 :
>                              dbms->total_sectors - dbms->cur_sector;
> @@ -481,7 +496,7 @@ static int dirty_bitmap_load_start(QEMUFile *f, DBMLoadState *s)
>           b->bs = s->bs;
>           b->bitmap = s->bitmap;
>           b->migrated = false;
> -        enabled_bitmaps = g_slist_prepend(enabled_bitmaps, b);
> +        s->enabled_bitmaps = g_slist_prepend(s->enabled_bitmaps, b);
>       }
>   
>       return 0;
> @@ -489,11 +504,12 @@ static int dirty_bitmap_load_start(QEMUFile *f, DBMLoadState *s)
>   
>   void dirty_bitmap_mig_before_vm_start(void)
>   {
> +    DBMLoadState *s = &dbm_state.load;
>       GSList *item;
>   
> -    qemu_mutex_lock(&finish_lock);
> +    qemu_mutex_lock(&s->finish_lock);
>   
> -    for (item = enabled_bitmaps; item; item = g_slist_next(item)) {
> +    for (item = s->enabled_bitmaps; item; item = g_slist_next(item)) {
>           LoadBitmapState *b = item->data;
>   
>           if (b->migrated) {
> @@ -505,10 +521,10 @@ void dirty_bitmap_mig_before_vm_start(void)
>           g_free(b);
>       }
>   
> -    g_slist_free(enabled_bitmaps);
> -    enabled_bitmaps = NULL;
> +    g_slist_free(s->enabled_bitmaps);
> +    s->enabled_bitmaps = NULL;
>   
> -    qemu_mutex_unlock(&finish_lock);
> +    qemu_mutex_unlock(&s->finish_lock);
>   }
>   
>   static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState *s)
> @@ -517,9 +533,9 @@ static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState *s)
>       trace_dirty_bitmap_load_complete();
>       bdrv_dirty_bitmap_deserialize_finish(s->bitmap);
>   
> -    qemu_mutex_lock(&finish_lock);
> +    qemu_mutex_lock(&s->finish_lock);
>   
> -    for (item = enabled_bitmaps; item; item = g_slist_next(item)) {
> +    for (item = s->enabled_bitmaps; item; item = g_slist_next(item)) {
>           LoadBitmapState *b = item->data;
>   
>           if (b->bitmap == s->bitmap) {
> @@ -530,7 +546,7 @@ static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState *s)
>   
>       if (bdrv_dirty_bitmap_has_successor(s->bitmap)) {
>           bdrv_dirty_bitmap_lock(s->bitmap);
> -        if (enabled_bitmaps == NULL) {
> +        if (s->enabled_bitmaps == NULL) {
>               /* in postcopy */
>               bdrv_reclaim_dirty_bitmap_locked(s->bitmap, &error_abort);
>               bdrv_enable_dirty_bitmap_locked(s->bitmap);
> @@ -549,7 +565,7 @@ static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState *s)
>           bdrv_dirty_bitmap_unlock(s->bitmap);
>       }
>   
> -    qemu_mutex_unlock(&finish_lock);
> +    qemu_mutex_unlock(&s->finish_lock);
>   }
>   
>   static int dirty_bitmap_load_bits(QEMUFile *f, DBMLoadState *s)
> @@ -646,7 +662,7 @@ static int dirty_bitmap_load_header(QEMUFile *f, DBMLoadState *s)
>   
>   static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)
>   {
> -    static DBMLoadState s;
> +    DBMLoadState *s = &((DBMState *)opaque)->load;
>       int ret = 0;
>   
>       trace_dirty_bitmap_load_enter();
> @@ -656,17 +672,17 @@ static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)
>       }
>   
>       do {
> -        ret = dirty_bitmap_load_header(f, &s);
> +        ret = dirty_bitmap_load_header(f, s);
>           if (ret < 0) {
>               return ret;
>           }
>   
> -        if (s.flags & DIRTY_BITMAP_MIG_FLAG_START) {
> -            ret = dirty_bitmap_load_start(f, &s);
> -        } else if (s.flags & DIRTY_BITMAP_MIG_FLAG_COMPLETE) {
> -            dirty_bitmap_load_complete(f, &s);
> -        } else if (s.flags & DIRTY_BITMAP_MIG_FLAG_BITS) {
> -            ret = dirty_bitmap_load_bits(f, &s);
> +        if (s->flags & DIRTY_BITMAP_MIG_FLAG_START) {
> +            ret = dirty_bitmap_load_start(f, s);
> +        } else if (s->flags & DIRTY_BITMAP_MIG_FLAG_COMPLETE) {
> +            dirty_bitmap_load_complete(f, s);
> +        } else if (s->flags & DIRTY_BITMAP_MIG_FLAG_BITS) {
> +            ret = dirty_bitmap_load_bits(f, s);
>           }
>   
>           if (!ret) {
> @@ -676,7 +692,7 @@ static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)
>           if (ret) {
>               return ret;
>           }
> -    } while (!(s.flags & DIRTY_BITMAP_MIG_FLAG_EOS));
> +    } while (!(s->flags & DIRTY_BITMAP_MIG_FLAG_EOS));
>   
>       trace_dirty_bitmap_load_success();
>       return 0;
> @@ -684,13 +700,14 @@ static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)
>   
>   static int dirty_bitmap_save_setup(QEMUFile *f, void *opaque)
>   {
> +    DBMSaveState *s = &((DBMState *)opaque)->save;
>       SaveBitmapState *dbms = NULL;
> -    if (init_dirty_bitmap_migration() < 0) {
> +    if (init_dirty_bitmap_migration(s) < 0) {
>           return -1;
>       }
>   
> -    QSIMPLEQ_FOREACH(dbms, &dirty_bitmap_mig_state.dbms_list, entry) {
> -        send_bitmap_start(f, dbms);
> +    QSIMPLEQ_FOREACH(dbms, &s->dbms_list, entry) {
> +        send_bitmap_start(f, s, dbms);
>       }
>       qemu_put_bitmap_flags(f, DIRTY_BITMAP_MIG_FLAG_EOS);
>   
> @@ -699,7 +716,9 @@ static int dirty_bitmap_save_setup(QEMUFile *f, void *opaque)
>   
>   static bool dirty_bitmap_is_active(void *opaque)
>   {
> -    return migrate_dirty_bitmaps() && !dirty_bitmap_mig_state.no_bitmaps;
> +    DBMSaveState *s = &((DBMState *)opaque)->save;
> +
> +    return migrate_dirty_bitmaps() && !s->no_bitmaps;
>   }
>   
>   static bool dirty_bitmap_is_active_iterate(void *opaque)
> @@ -727,10 +746,10 @@ static SaveVMHandlers savevm_dirty_bitmap_handlers = {
>   
>   void dirty_bitmap_mig_init(void)
>   {
> -    QSIMPLEQ_INIT(&dirty_bitmap_mig_state.dbms_list);
> -    qemu_mutex_init(&finish_lock);
> +    QSIMPLEQ_INIT(&dbm_state.save.dbms_list);
> +    qemu_mutex_init(&dbm_state.load.finish_lock);
>   
>       register_savevm_live("dirty-bitmap", 0, 1,
>                            &savevm_dirty_bitmap_handlers,
> -                         &dirty_bitmap_mig_state);
> +                         &dbm_state);
>   }
> 

Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
-- 
With the best regards,
Andrey Shinkevich

