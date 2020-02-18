Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B084C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:27:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41503208C4
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="EozAfdJC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41503208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j43qc-0005BP-9s
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 09:27:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56497)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1j43pJ-000361-JV
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:26:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1j43pI-0001Iw-Gd
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:26:17 -0500
Received: from mail-db8eur05on2120.outbound.protection.outlook.com
 ([40.107.20.120]:44209 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1j43pE-0001Fp-Us; Tue, 18 Feb 2020 09:26:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+PMYE7VjsqjA8Du5NzP+51z7jsj3knqsMLVw0xFYtLIH/2fuaRh7T4bvEVT+wXUzTgZtup68+sm/zLk0pIKgLGBTMwP0IH5E9nBS0EsrPXDTm27Sm5XOWGPxvzjChMa6aQzk/al5A+S6gOqffrs8uXMk3yPnHgFWKzE3nY7r2NZHGqcpKVO0gzNKraxn12ApTLa76RryPpI7+r8tGoOcGrNSskkh2Nku/xgDMIeWK2IVAfumM+pR9k5yBze+yJPCmhHFr2e+0uS+1JVK8R4tKJq9YGjl8xu1aDrzAHbNk6wWZrZ6bcBsnlHimHwyd8eRMVyNrdNXCC7FNPjeKwP/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HADE2WY7We3AY1QH3gyoBdnvoleK5K50fswd7X63GzM=;
 b=SaW2gfUap1fS1OZXStSuGQedVm/i2QNPJRxI5+B1K49GDBJ+hzbazSS8hwzRnlNY92oFojk7cRywO7tSSh3Ezqwxz+mtCPLCxGo9No/FARULDoGizb/D1pFwp0wiIHfM5qs5bCUAUoNj5na7GC86ESuv/mqJSZ1gwp6M+WMp1NvXCPMRhBavL3lushLSh1ewOeDghdn9Ws2G0q9rkxBSQuk9JQH18bFvwADJH8PwzdnJzttE1anfwKHyXdLZD07Ypg6WYtlndTrAGxy3tiPBOQ8gCPAj6aXQ6ZIrYTa859M9gD4RXMiAzp6HDbt7vEGY/ocPXekLJe95i5qnA092ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HADE2WY7We3AY1QH3gyoBdnvoleK5K50fswd7X63GzM=;
 b=EozAfdJCKPrXV4JI/O0+zYuib/Ke8wCLnhKCdk+ZbGT5tPb1zDt5o073ZcMQuSzyOJ9md7q3S5ctk1AvFTWYgozsWMAl+e9t2juhmuWWHMYhhijDKgc6KSL8axAFXo7jBL8nhkorw7IJ6twt1RIRQqkbZKkFf3r5d/1KigAe0zA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com (10.255.123.95) by
 AM6PR08MB5015.eurprd08.prod.outlook.com (10.255.121.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Tue, 18 Feb 2020 14:26:11 +0000
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::1883:da16:865a:139d]) by AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::1883:da16:865a:139d%5]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 14:26:10 +0000
Subject: Re: [PATCH v2 07/22] migration/block-dirty-bitmap: simplify
 dirty_bitmap_load_complete
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
 <20200217150246.29180-8-vsementsov@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Organization: Virtuozzo
Message-ID: <4682455a-db9d-f1af-9b45-f0bce493d17c@virtuozzo.com>
Date: Tue, 18 Feb 2020 17:26:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200217150246.29180-8-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0901CA0064.eurprd09.prod.outlook.com
 (2603:10a6:3:45::32) To AM6PR08MB5048.eurprd08.prod.outlook.com
 (2603:10a6:20b:ee::31)
MIME-Version: 1.0
Received: from [172.16.24.225] (185.231.240.5) by
 HE1PR0901CA0064.eurprd09.prod.outlook.com (2603:10a6:3:45::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25 via Frontend Transport; Tue, 18 Feb 2020 14:26:10 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfead49e-1391-4597-9b5a-08d7b47e8043
X-MS-TrafficTypeDiagnostic: AM6PR08MB5015:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB50155C64AE11FB0CF5EBD90AF4110@AM6PR08MB5015.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-Forefront-PRVS: 031763BCAF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(396003)(376002)(346002)(136003)(366004)(39850400004)(189003)(199004)(478600001)(316002)(16576012)(81166006)(36756003)(81156014)(4326008)(54906003)(6486002)(8676002)(36916002)(52116002)(956004)(186003)(44832011)(8936002)(5660300002)(31696002)(26005)(86362001)(53546011)(16526019)(66946007)(66476007)(66556008)(2906002)(31686004)(2616005)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB5015;
 H:AM6PR08MB5048.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vhu7Jv/nkhLgy2j4l65NKarQazq9Ap3Ii8ntagP8Za/A6IhpTvJy9a+EV0bzLGcQ2FX+LFZOMQcgbjAoyq8v27RuhW5c+tbfu6vp3rNymVte5wxK5sA1R6lt8fUi0ZDtTcMVWu3XEsXaSE1sKgIBGbOotVMZT6v1gXcy7Z7DM/g4oP+ulcIi4WrKcsGk6PhfLWJlCyqR1pn8dV2SHkOknSfiwh9lYKYX9pJHFgK9vHreK4te6HmtKTrrVkJK5ZjqmqhFAftLJKOBfxa428JParZmP10FgtFSnCXOPIwuTD3iPbYrGxjNwQdSYRLp1Wkz9GKMKmujEfyo022LJcn0jTcirae/KsyvPWW1g6h3iZs7ZQ8YXVcY/WeDTYauBLHmh/R7KLVeOLdNP9cQ57DXWilIwVn3xtebM6EL0PRhu81uCNvGzpUNQ1iYDWrbzENE1dRb1J+Gh1nUk6d6YwlLKmbOh/eyIAakl4y7bGvUjCxr67rTt+HJHpiGjpHORN22
X-MS-Exchange-AntiSpam-MessageData: VzksJA4uF7jKgSwDhXgFS5VnQEHb5XzC+HnzSufl3yRPy14gJet98hWrYxlBhXsgu90zd3prGSrUK25DziLiCHeVKxntJ9lrxYX663iSYMmj/kKrE/JZoT3EO524n63bQVSya1anLXEFqSn1b1qCmA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfead49e-1391-4597-9b5a-08d7b47e8043
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2020 14:26:10.8506 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JuBiXEKVywRfNNCv+/TIEaz+d4+BPUVTDyIhgatYO3do9CM6UDQyqB+S/SnXDrDb6pk4JqCqjiYLGaQ1qU9NJgqSM6Mk0xergRE9GGZhu8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5015
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.20.120
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
> bdrv_enable_dirty_bitmap_locked() call does nothing, as if we are in
> postcopy, bitmap successor must be enabled, and reclaim operation will
> enable the bitmap.
> 
> So, actually we need just call _reclaim_ in both if branches, and
> making differences only to add an assertion seems not really good. The
> logic becomes simple: on load complete we do reclaim and that's all.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   migration/block-dirty-bitmap.c | 25 ++++---------------------
>   1 file changed, 4 insertions(+), 21 deletions(-)
> 
> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
> index 440c41cfca..9cc750d93b 100644
> --- a/migration/block-dirty-bitmap.c
> +++ b/migration/block-dirty-bitmap.c
> @@ -535,6 +535,10 @@ static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState *s)
>   
>       qemu_mutex_lock(&s->lock);
>   
> +    if (bdrv_dirty_bitmap_has_successor(s->bitmap)) {
What about making it sure?
            assert(!s->bitmap->successor->disabled);

> +        bdrv_reclaim_dirty_bitmap(s->bitmap, &error_abort);
> +    }
> +
>       for (item = s->enabled_bitmaps; item; item = g_slist_next(item)) {
>           LoadBitmapState *b = item->data;
>   
> @@ -544,27 +548,6 @@ static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState *s)
>           }
>       }
>   
> -    if (bdrv_dirty_bitmap_has_successor(s->bitmap)) {
> -        bdrv_dirty_bitmap_lock(s->bitmap);
> -        if (s->enabled_bitmaps == NULL) {
> -            /* in postcopy */
> -            bdrv_reclaim_dirty_bitmap_locked(s->bitmap, &error_abort);
> -            bdrv_enable_dirty_bitmap_locked(s->bitmap);
> -        } else {
> -            /* target not started, successor must be empty */
> -            int64_t count = bdrv_get_dirty_count(s->bitmap);
> -            BdrvDirtyBitmap *ret = bdrv_reclaim_dirty_bitmap_locked(s->bitmap,
> -                                                                    NULL);
> -            /* bdrv_reclaim_dirty_bitmap can fail only on no successor (it
> -             * must be) or on merge fail, but merge can't fail when second
> -             * bitmap is empty
> -             */
> -            assert(ret == s->bitmap &&
> -                   count == bdrv_get_dirty_count(s->bitmap));
> -        }
> -        bdrv_dirty_bitmap_unlock(s->bitmap);
> -    }
> -
>       qemu_mutex_unlock(&s->lock);
>   }
>   
> 

Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
-- 
With the best regards,
Andrey Shinkevich

