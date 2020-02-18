Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726EBC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 13:23:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DFAF2173E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 13:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="smQAgDLF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DFAF2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j42qW-00023A-FD
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 08:23:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45723)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1j42nJ-00062Z-6U
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:20:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1j42nI-0000PT-1h
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:20:09 -0500
Received: from mail-eopbgr60129.outbound.protection.outlook.com
 ([40.107.6.129]:1797 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1j42nE-0000ND-BN; Tue, 18 Feb 2020 08:20:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SVUasmPlkr7lPYKVw75REwZVDcvg85isyzHwM6mMQL2URPrktzmfW2hPCwiTJDLXXVkkHgbOHwA255p5V1UjMGzQ40Hvd4VWVVHxLdYhVUp+XxjxppMMWAsUFA/6A4SRnvHCWhf5JIOdx2RoXkVFAT0qIqJMFrFXCN3SFbvwAVE3DlHSSUsHUwiR2NLedxlgVPdKuqYjSLjfRYPdkEGTctsP2J7Zbj3JzwmFRGXZd4CdHBHi/hlnXYDuDRP3OFuMSlkez+5LOjAlkIRgVmXvZ1RVDQDjisRelHEonNV5mX200eDLO62G6FxDx8tUJrv1bjyVkGX4RZDmmpaYgpTsIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSpbRBEeOnpc02gY2qMyh8I18Ag7XYZtfN8vA5Eaj+8=;
 b=MrXONnCkM4WB0sYt3tNYuXvTxFG2TEfZhkrrxv549mVq6mRwcZlI+gmJOE4Z0rGs1BdDTWDoZ6c1pKMMC7huE7HkqBv0HbOHW6aZIVZGMarXPGYxQmuXxWhj+QLjUUEd0miC4wHxHcToM31W/YYVfkM80528XHuzQH5zBVtTUyDKCiLBrI5kCwyUrd1DxS0TliyqGw1vu3BynC6Evd12dqmiISAyghq+L4UCw+UuHyv2LyqDYCOgWfRLb23bM7GtB4sc5j2Nhy3jJ1ist9kQn8IahQWKbzCuvEIFlPFkB3P1Zwrs7VHfRCNRbq5d+ed+kuEvPr5Dlb26Btyv6zCA7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSpbRBEeOnpc02gY2qMyh8I18Ag7XYZtfN8vA5Eaj+8=;
 b=smQAgDLFVkE6zD/x1T3lTWoIuO8dZ+01GEGsr38px7JFJG1Rc4ZxYHFuC/RfvMI5Fxp5htca+VLyBMqJs8LFBdU3NVJO3Ar8cCVAS2GCeydjdIWbtjEODim1F4sO8TXru9AzloCDjMhzlXgIxxq9DcTPAdAwhIKRuhmf469buHc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com (10.255.123.95) by
 AM6PR08MB2951.eurprd08.prod.outlook.com (52.135.168.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Tue, 18 Feb 2020 13:20:02 +0000
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::1883:da16:865a:139d]) by AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::1883:da16:865a:139d%5]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 13:20:02 +0000
Subject: Re: [PATCH v2 06/22] migration/block-dirty-bitmap: rename finish_lock
 to just lock
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
 <20200217150246.29180-7-vsementsov@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Organization: Virtuozzo
Message-ID: <ad589995-5d0d-9f61-d71f-a34074ec011a@virtuozzo.com>
Date: Tue, 18 Feb 2020 16:20:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200217150246.29180-7-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1P195CA0011.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::21)
 To AM6PR08MB5048.eurprd08.prod.outlook.com
 (2603:10a6:20b:ee::31)
MIME-Version: 1.0
Received: from [172.16.24.225] (185.231.240.5) by
 HE1P195CA0011.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22 via Frontend Transport; Tue, 18 Feb 2020 13:20:01 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a3b4049-c5ec-4021-20df-08d7b47542a6
X-MS-TrafficTypeDiagnostic: AM6PR08MB2951:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB29512FC1FD154433FAC04390F4110@AM6PR08MB2951.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:51;
X-Forefront-PRVS: 031763BCAF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(396003)(39850400004)(136003)(366004)(346002)(376002)(199004)(189003)(26005)(31696002)(36756003)(54906003)(2906002)(6486002)(16576012)(5660300002)(86362001)(52116002)(31686004)(53546011)(66946007)(186003)(4326008)(478600001)(16526019)(81156014)(81166006)(36916002)(44832011)(8936002)(8676002)(316002)(66556008)(2616005)(956004)(66476007)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB2951;
 H:AM6PR08MB5048.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AGsrNJ5kLwf/La/7OdxWd0AKxrkHvo07O7Us10pFI1D3boCItI3ClH5bDyCpVkM+E/cmGqLpPD2vsuxoc00f95tDppdLGF8wtLrkmuPQigHqV0uSDgXZEZeUCJ+Fy0lLllapu9uw0p0YVqreb3nFLBLlEUx+u5ZQqqK4aN6QEWslzJ+EByAHadws+AY0ryl7RnOkt2AaB100tgUMezc5h7b4K2RdiDlqrTiZykULjWZ4EluSnGK48rd5r3hCdZ/2qBf4jFQEmkNAp52fs5XucYpSwM0QD9FeCFSbno2kC08z0E/YanTUj6i3k6CTW2Wz24W3V0bmzBz+/OnPKbL19Yx0HQqotSI1GMNbt4b8G26uHjJzqJ5q7W3tdtzi6DOB1abZiDL1CgTlSe2uMtYFXBc+wJcg4SaC0y0IrWtizoyjzeaCFKwnxKKTHz5u+FbHX0AsSA3Ss4IwPx6lVcewbJp7P2F3eouxI+TkznvbQkiB8nMZgHdhGyTcs76heW+c
X-MS-Exchange-AntiSpam-MessageData: UHL5t84jnuSsF/CR9LToagy3g+N43KLhe4Hm8GBh42WB9qNe3RkqaA0JuYzSs7BgS3yGXfYByZjrR1UfErFNfvt+l1Ak19LzhINb2NzQr0WW3HoZVjIslbvkX0vwxxtOF98lMTAOT9n88b4jlfcZDA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a3b4049-c5ec-4021-20df-08d7b47542a6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2020 13:20:02.0630 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EtKrRWt2Qponr4fOsI2+OVa97gCIfSJzb/fyICAnlx5z3XwxOQAqOAWeqBBg9FRH9fDlfMPrLP4ykDxeRPtrmmq9mpmeF4jsZ73/9VQ9jWc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB2951
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.129
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
> finish_lock is bad name, as lock used not only on process end.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   migration/block-dirty-bitmap.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
> index 7a82b76809..440c41cfca 100644
> --- a/migration/block-dirty-bitmap.c
> +++ b/migration/block-dirty-bitmap.c
> @@ -143,7 +143,7 @@ typedef struct DBMLoadState {
>       BdrvDirtyBitmap *bitmap;
>   
>       GSList *enabled_bitmaps;
> -    QemuMutex finish_lock;
> +    QemuMutex lock; /* protect enabled_bitmaps */
>   } DBMLoadState;
>   
>   typedef struct DBMState {
> @@ -507,7 +507,7 @@ void dirty_bitmap_mig_before_vm_start(void)
>       DBMLoadState *s = &dbm_state.load;
>       GSList *item;
>   
> -    qemu_mutex_lock(&s->finish_lock);
> +    qemu_mutex_lock(&s->lock);
>   
>       for (item = s->enabled_bitmaps; item; item = g_slist_next(item)) {
>           LoadBitmapState *b = item->data;
> @@ -524,7 +524,7 @@ void dirty_bitmap_mig_before_vm_start(void)
>       g_slist_free(s->enabled_bitmaps);
>       s->enabled_bitmaps = NULL;
>   
> -    qemu_mutex_unlock(&s->finish_lock);
> +    qemu_mutex_unlock(&s->lock);
>   }
>   
>   static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState *s)
> @@ -533,7 +533,7 @@ static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState *s)
>       trace_dirty_bitmap_load_complete();
>       bdrv_dirty_bitmap_deserialize_finish(s->bitmap);
>   
> -    qemu_mutex_lock(&s->finish_lock);
> +    qemu_mutex_lock(&s->lock);
>   
>       for (item = s->enabled_bitmaps; item; item = g_slist_next(item)) {
>           LoadBitmapState *b = item->data;
> @@ -565,7 +565,7 @@ static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState *s)
>           bdrv_dirty_bitmap_unlock(s->bitmap);
>       }
>   
> -    qemu_mutex_unlock(&s->finish_lock);
> +    qemu_mutex_unlock(&s->lock);
>   }
>   
>   static int dirty_bitmap_load_bits(QEMUFile *f, DBMLoadState *s)
> @@ -747,7 +747,7 @@ static SaveVMHandlers savevm_dirty_bitmap_handlers = {
>   void dirty_bitmap_mig_init(void)
>   {
>       QSIMPLEQ_INIT(&dbm_state.save.dbms_list);
> -    qemu_mutex_init(&dbm_state.load.finish_lock);
> +    qemu_mutex_init(&dbm_state.load.lock);
>   
>       register_savevm_live("dirty-bitmap", 0, 1,
>                            &savevm_dirty_bitmap_handlers,
> 

Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
-- 
With the best regards,
Andrey Shinkevich

