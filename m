Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659E3C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 11:30:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 166EA21D56
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 11:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="qJoaXVCE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 166EA21D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j414j-0005HF-8g
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 06:30:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59397)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1j413r-0004kf-Fk
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 06:29:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1j413q-0003OA-8B
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 06:29:07 -0500
Received: from mail-eopbgr00104.outbound.protection.outlook.com
 ([40.107.0.104]:26372 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1j413m-0003LD-C4; Tue, 18 Feb 2020 06:29:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5SSpdMv2DtVObBFBGI1iDzoDTJ/FVfdo1xp6HD6616DAUjNZlO9B/VEKJWvOnVbXnCwC5K6pEohzAU+lFPCufpt2KavXSVn9OXzPX2WZ7RMuqFnKtOZBykIzRxFRrEmC1kE8FSGAsMu0HAKCADxFzMUMf4FdlYmjMtM5xT1e56EBD4jEff23BK/s0lbSNJ0Mo2zG45jUA1tMw/kk6y4R/4a3DazGoNGWgMmwGjjY38h1EAnMcbUOt68IXC8MD4YWA/fkAtp3BcfS87g/E9soHwgNCeDTOAjnlnl2mOQOA/KnzjCvmwlrU1S31ZF0rJTeSs5yNXGEZht7mq3+BmpYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEk0rv6lt6v1VGtd9yR0QXO8LZZ0Ogyfdxu3Q7wskLI=;
 b=RrR+15Pu51COgQ7yEVoU6OFrjUzlUv39UZ9BfNynqz6hg8RbXUskC8/jtPckM+XLOY1KShAShka5huLIDFyZmKxIO59b+TiPGIP7mGSqqvfVuO8SEzE4d8EpMB/7DGzCr6RY+yQx1+IlNfkKLGHba6McqSFEZwRfQwKhBoknKxrzQlKBQrBY0uNdFEyZmOdLrxNBLZDWkleRdBQ4DV0XCm5awmzMeq6JODM5CTj/w0OjjsdSqiY27JrrN3OenSi1zXsHhVlKcvNvF6yAYB6fE025VhL9qmWn+SwXpw6yBz3Yjr+Qky4NnhUiWKflYkgFUL8bPSqi+dSVpRK0+p0TyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEk0rv6lt6v1VGtd9yR0QXO8LZZ0Ogyfdxu3Q7wskLI=;
 b=qJoaXVCEjzNdajwUgE+x0OeUbcY/eaRMunq6Po3X++R3/fWv+APNF7FrYKMyYk7wWA0dRlKXR7OO6gVpzsHFVpLbsLi8dmq7AKqba3lFbPGlLQ0ggN+Aair337XgfTDgFyR43L5ehPtDZ5ViP7QfccJ8534bezUr5z5VaySL1+k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com (10.255.123.95) by
 AM6PR08MB3077.eurprd08.prod.outlook.com (52.135.165.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Tue, 18 Feb 2020 11:28:59 +0000
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::1883:da16:865a:139d]) by AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::1883:da16:865a:139d%5]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 11:28:59 +0000
Subject: Re: [PATCH v2 04/22] migration/block-dirty-bitmap: move mutex init to
 dirty_bitmap_mig_init
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
 <20200217150246.29180-5-vsementsov@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Organization: Virtuozzo
Message-ID: <aa7c283e-ac9c-01d9-7204-06c5b13c25fb@virtuozzo.com>
Date: Tue, 18 Feb 2020 14:28:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200217150246.29180-5-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0301CA0008.eurprd03.prod.outlook.com
 (2603:10a6:3:76::18) To AM6PR08MB5048.eurprd08.prod.outlook.com
 (2603:10a6:20b:ee::31)
MIME-Version: 1.0
Received: from [172.16.24.225] (185.231.240.5) by
 HE1PR0301CA0008.eurprd03.prod.outlook.com (2603:10a6:3:76::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22 via Frontend Transport; Tue, 18 Feb 2020 11:28:58 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2a0296c-3040-482b-01e6-08d7b465bf6b
X-MS-TrafficTypeDiagnostic: AM6PR08MB3077:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3077A19C966CEC8608969653F4110@AM6PR08MB3077.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-Forefront-PRVS: 031763BCAF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(39850400004)(136003)(396003)(366004)(376002)(346002)(199004)(189003)(54906003)(4326008)(31696002)(44832011)(36756003)(31686004)(26005)(5660300002)(478600001)(66946007)(36916002)(8936002)(52116002)(186003)(16526019)(16576012)(81156014)(8676002)(81166006)(2616005)(316002)(6486002)(86362001)(66556008)(2906002)(53546011)(66476007)(956004)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3077;
 H:AM6PR08MB5048.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: esIBuiAYcxUkbJHY8OcxAuCjYhAOng00+tKO5NT1hzGCfQ5ip+rQjuihPMhuhJxOoiNERuTCapO+/+8IHpxm8DdkFwoASEHuJCAWl11GW6d942+O9oMzQ/3TTeTH0RcspHatM4KZf5stznvzsYwTqPTzyb6Fwa5Zg7fAp4xvSn1tiODxK+vsMWjvRqaRkV/ifuTi4pqNkqI+iPmjb/K96tERzWTLufckCdgRVcWHQtNu+tOViTdXaii14ub5s7dcUv3ZKe7NLB3csqUfMQNIDUHTzGqOZHDzI25Lj2KlM+6aAwpXx+yM2avRXYkaWCjLWLcMoD9IOHCgoc4VkbIqYcMKPMfYhi/utMj5nLAwzX0KmN+btPrj3hKBiI+Rqhov52Nqc6ckeJWPbdxuRY+fPzLs6UZPDyzSMaygnfgSrI5OShyKa+V4HQ3loZUbl12sF1+vQ2MW/aXRbzLQTqSrdXmtsC+3w7o7R9s5xApl5nIn12O3X8Xt+5RXm0xfWSYX
X-MS-Exchange-AntiSpam-MessageData: 2KHwAQRJXq8qqUaJDggmpSnHcjwyjmrc6kcgPAupqCNQ77Q6JPask8Sj0g2pwe/+AodbiMGJkTq1hs+Qcw3JEIolYUf2NGuIgklMRt9Vfz7F7hKn2/LNxsxGyAzHlAcRlMkiYYog1/Vdn9cWA0FmsQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a0296c-3040-482b-01e6-08d7b465bf6b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2020 11:28:59.3871 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z1E9cHa1AO5kTbu7Sy10A+4kso9A+BP0guWbLyqzayCKohjJSIXQ1gfBoyNzaGYwhajY0b5+VTRAjxlH21ZZNapx2bfcRNqOzMQsbExhHEQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3077
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.104
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
> No reasons to keep two public init functions.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   migration/migration.h          | 1 -
>   migration/block-dirty-bitmap.c | 6 +-----
>   migration/migration.c          | 2 --
>   3 files changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/migration/migration.h b/migration/migration.h
> index 8473ddfc88..2948f2387b 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -332,7 +332,6 @@ void migrate_send_rp_recv_bitmap(MigrationIncomingState *mis,
>   void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value);
>   
>   void dirty_bitmap_mig_before_vm_start(void);
> -void init_dirty_bitmap_incoming_migration(void);
>   void migrate_add_address(SocketAddress *address);
>   
>   int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaque);
> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
> index 4e8959ae52..49d4cf8810 100644
> --- a/migration/block-dirty-bitmap.c
> +++ b/migration/block-dirty-bitmap.c
> @@ -148,11 +148,6 @@ typedef struct LoadBitmapState {
>   static GSList *enabled_bitmaps;
>   QemuMutex finish_lock;
>   
> -void init_dirty_bitmap_incoming_migration(void)
> -{
> -    qemu_mutex_init(&finish_lock);
> -}
> -
>   static uint32_t qemu_get_bitmap_flags(QEMUFile *f)
>   {
>       uint8_t flags = qemu_get_byte(f);
> @@ -733,6 +728,7 @@ static SaveVMHandlers savevm_dirty_bitmap_handlers = {
>   void dirty_bitmap_mig_init(void)
>   {
>       QSIMPLEQ_INIT(&dirty_bitmap_mig_state.dbms_list);
> +    qemu_mutex_init(&finish_lock);
>   
>       register_savevm_live("dirty-bitmap", 0, 1,
>                            &savevm_dirty_bitmap_handlers,
> diff --git a/migration/migration.c b/migration/migration.c
> index 8fb68795dc..515047932c 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -158,8 +158,6 @@ void migration_object_init(void)
>       qemu_sem_init(&current_incoming->postcopy_pause_sem_dst, 0);
>       qemu_sem_init(&current_incoming->postcopy_pause_sem_fault, 0);
>   
> -    init_dirty_bitmap_incoming_migration();
> -
>       if (!migration_object_check(current_migration, &err)) {
>           error_report_err(err);
>           exit(1);
> 

I rely on that the mutex initialization is being made in proper time.

Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
-- 
With the best regards,
Andrey Shinkevich

