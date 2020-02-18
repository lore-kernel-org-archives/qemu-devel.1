Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E67BC34049
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 19:14:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2FB124125
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 19:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="SuOv8wEF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2FB124125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j48KF-0003Ih-O6
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 14:14:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1j48HY-0007AV-SS
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:11:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1j48HX-0004NG-MS
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:11:44 -0500
Received: from mail-db8eur05on20727.outbound.protection.outlook.com
 ([2a01:111:f400:7e1a::727]:60641
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1j48HT-0004Ao-Sz; Tue, 18 Feb 2020 14:11:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ds6SxkA+c/RoCdkS/N+Zz+TuqtZQ89vRBmK6RfA5RhfbNAP1aiZO0VGymVJ9ZaMVdPdIt+zfsgD9WHpibEvc4mQCzMOzz5LiDqhwEqF+fVFY7G9Zeq48i9SSi7gEASBx0q0HvInyPtrDB/RE05iUfUA2zsYu/9b/ffF9pdQiCyzakmuzHgHakXHU8LxN9+60EEdsoNVTaP9bvDh5An4GVCQW+zWb8T+bytdfRbjXjWWAU2SySE55Tf6TDoEtPDGgxNZZMrulFquHojP3h/Cky/xRdJ3K8QL8xjsJVTsoHI5QkuDEaz9VlkPwb6jot9hB4rsNxsbdxU0hy1RHYzek+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uf3VCV7M4HcTxMd4BbUSXzmojFz0nV2aJkbCpdJNgGY=;
 b=YmXIhdiJnrI2ia9npRt8bX7j2nkaHHesjHLam0E6T8G8ik+LA63elOK/vg/UzUVlcP1U1Y8g4JlPOPpMU/xUrONx0RDNaKHxYvYWoC+OFvtCN+1mlzpP1s4VxxTkmTJOnYUB99v9qC1M1mTzhj4YkJ9k43xxhoPrh+37JIBT/qWSuc5uHB5zMYtcVdXrLqKdo0tZWz5zLJ+wvTIMzV/nmtd6qXWT6fCq2Ku2K7yjbQXXP8NYFS6cXsAbQcb3oQi7SgCzkt+Ml3nLDih/rxjW7cm9LV1io5FY8APv6Mibj2PVtg6GCs79LaGiiB9HVjSc3M19Rar3LVw5IyvIRL6mng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uf3VCV7M4HcTxMd4BbUSXzmojFz0nV2aJkbCpdJNgGY=;
 b=SuOv8wEFBLOQqaa5w0T2twWm+isWRdEjD6KsyYw4i/feHWlwkxRg/hTpxrCN7q+LDck1gGRyEf/aHYfNEY2KWmzdtJDOY444tofQ9ImSxZM3e6Y5wmKFQE0DGtFfRK7LuR2m0aGE8QYVN/Vv2Imkmxh0/Qz/xg1I/5vl2fqsy74=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com (10.255.123.95) by
 AM6PR08MB3462.eurprd08.prod.outlook.com (20.177.113.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Tue, 18 Feb 2020 19:11:36 +0000
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::1883:da16:865a:139d]) by AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::1883:da16:865a:139d%5]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 19:11:36 +0000
Subject: Re: [PATCH v2 10/22] migration/block-dirty-bitmap: cancel migration
 on shutdown
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
 <20200217150246.29180-11-vsementsov@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Organization: Virtuozzo
Message-ID: <a308d87d-c666-4a6b-be6f-ba672f61994d@virtuozzo.com>
Date: Tue, 18 Feb 2020 22:11:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200217150246.29180-11-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR05CA0164.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::12) To AM6PR08MB5048.eurprd08.prod.outlook.com
 (2603:10a6:20b:ee::31)
MIME-Version: 1.0
Received: from [172.16.24.225] (185.231.240.5) by
 HE1PR05CA0164.eurprd05.prod.outlook.com (2603:10a6:3:f8::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17 via Frontend Transport; Tue, 18 Feb 2020 19:11:36 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b525b3b4-9c07-4e19-6c37-08d7b4a66036
X-MS-TrafficTypeDiagnostic: AM6PR08MB3462:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB34628153311CB5FD4427F94AF4110@AM6PR08MB3462.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-Forefront-PRVS: 031763BCAF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(396003)(376002)(346002)(136003)(366004)(39850400004)(189003)(199004)(31696002)(26005)(53546011)(86362001)(8936002)(44832011)(186003)(956004)(5660300002)(31686004)(66946007)(2616005)(2906002)(66476007)(66556008)(16526019)(81166006)(81156014)(478600001)(16576012)(316002)(6486002)(36916002)(4326008)(52116002)(6666004)(36756003)(54906003)(8676002)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3462;
 H:AM6PR08MB5048.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L0RRFmWdy6gsALjMZ7Bj1eVlVD9EFc3+HfuLUttcrf7mI3P+Xk50Ja90Jo+m8+nWfYQVZ5P2SapbDhIJqANknKl7I2aZG07RQLh2EKWd4/N3J4erGnDo7/He3Qg0EQ/80xGZ++HnZmdouIMTVSouAxoMS16Oln8+OzNPltYTd6K+Q+ujLep1KN03CE9LJeIiTX6rUaMtYTz1pC075JChnOnMf9GItz4CMIEHXzOboTkYk+earxzues/O3EYlbQj0lrPaQwnxOoZfpRfhr8AfcHBPKp1ytJ9zunFtUW1hPJvn3BdVnRNIoEuh70yL/p4Y/w4wkh0UxbUHPM5l1t2q3NIWz9bYjN69oKn6IwvUW9cAMOz24grox3fcnzC2D50wOqtYyEAZmg/ajWNWo2a1GPWXJ8v+xMG0PCpWzxMdRMijTGe1wgqg3mLf7fxbi1uSXgIbc+Eu75zREBs5rTG/o/QXIUdOb6whMFxqE1VrAGeIRH2+BYNxBddX5hfSDTbb
X-MS-Exchange-AntiSpam-MessageData: zUxK1tcLgzIwLSO4EbSvyPTXXUexVyi1SrjlYB1/RILB8ujuQJrv4SL+UiuN+0x7xoNZ7sS/RFO55l1X2bjn4X6SWlWUdQgPwluPzLY32I6NkAZkVFrdSt7qbjqMOZkLxX1CTeyIUZTIikNIDae01Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b525b3b4-9c07-4e19-6c37-08d7b4a66036
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2020 19:11:36.8904 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hnD16lDoogCxKfg1biCV1da2kEe+3xaFD7nkAd2hRDJTRpGkkES7lvGXu0TI3pjs8A7U2WvR2chioJr4hk0djYprFjt+0M3zOaLRnP535Yg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3462
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:7e1a::727
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
> If target is turned of prior to postcopy finished, target crashes
> because busy bitmaps are found at shutdown.
> Canceling incoming migration helps, as it removes all unfinished (and
> therefore busy) bitmaps.
> 
> Similarly on source we crash in bdrv_close_all which asserts that all
> bdrv states are removed, because bdrv states involved into dirty bitmap
> migration are referenced by it. So, we need to cancel outgoing
> migration as well.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   migration/migration.h          |  2 ++
>   migration/block-dirty-bitmap.c | 16 ++++++++++++++++
>   migration/migration.c          | 13 +++++++++++++
>   3 files changed, 31 insertions(+)
> 
> diff --git a/migration/migration.h b/migration/migration.h
> index 2948f2387b..2de6b8bbe2 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -332,6 +332,8 @@ void migrate_send_rp_recv_bitmap(MigrationIncomingState *mis,
>   void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value);
>   
>   void dirty_bitmap_mig_before_vm_start(void);
> +void dirty_bitmap_mig_cancel_outgoing(void);
> +void dirty_bitmap_mig_cancel_incoming(void);
>   void migrate_add_address(SocketAddress *address);
>   
>   int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaque);
> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
> index aea5326804..3ca425d95e 100644
> --- a/migration/block-dirty-bitmap.c
> +++ b/migration/block-dirty-bitmap.c
> @@ -585,6 +585,22 @@ static void cancel_incoming_locked(DBMLoadState *s)
>       s->bitmaps = NULL;
>   }
>   
> +void dirty_bitmap_mig_cancel_outgoing(void)
> +{
> +    dirty_bitmap_do_save_cleanup(&dbm_state.save);

The comment above the dirty_bitmap_do_save_cleanup() says:
"Called with iothread lock taken"

> +}
> +
> +void dirty_bitmap_mig_cancel_incoming(void)
> +{
> +    DBMLoadState *s = &dbm_state.load;
> +
> +    qemu_mutex_lock(&s->lock);
> +
> +    cancel_incoming_locked(s);
> +
> +    qemu_mutex_unlock(&s->lock);
> +}
> +
>   static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState *s)
>   {
>       GSList *item;
> diff --git a/migration/migration.c b/migration/migration.c
> index 515047932c..7c605ba218 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -181,6 +181,19 @@ void migration_shutdown(void)
>        */
>       migrate_fd_cancel(current_migration);
>       object_unref(OBJECT(current_migration));
> +
> +    /*
> +     * Cancel outgoing migration of dirty bitmaps. It should
> +     * at least unref used block nodes.
> +     */
> +    dirty_bitmap_mig_cancel_outgoing();
> +
> +    /*
> +     * Cancel incoming migration of dirty bitmaps. Dirty bitmaps
> +     * are non-critical data, and their loss never considered as
> +     * something serious.
> +     */
> +    dirty_bitmap_mig_cancel_incoming();
>   }
>   
>   /* For outgoing */
> 

Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
-- 
With the best regards,
Andrey Shinkevich

