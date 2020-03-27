Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D1BC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 06:01:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCB7F20714
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 06:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="nL1wb7T3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCB7F20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHi42-0003XK-UP
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 02:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48740)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jHi2j-0002hl-UX
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 02:00:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jHi2i-0006gI-Od
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 02:00:33 -0400
Received: from mail-eopbgr10139.outbound.protection.outlook.com
 ([40.107.1.139]:14697 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jHi2e-0005wg-7L; Fri, 27 Mar 2020 02:00:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrBtqYHZOAENUPeNX+dO4nGv/vi0i9ZmG5QZr4D5YXX3K8L/ElahTvXBbl5BtjiiBggOU0nGEdluhD5ZJZZcwCm/1/yekQbJx0aDI9vV92LwDmFPgEdzzK8Nd7UmJAk1GTdInRti6r6I2Qqh/pftuev70Nak90dH4ayxce0oqqNFvuwoxlT5Jlu6ejPdQv7pRsyXau6kZGbWn0jXrGJ1dckc2OOFWBkyGMzhhPcKmCLvDsK7eOksvDFh7/IVyZ738NWF8xFRwrB4SJfORtGChyGvSVkrB9Bnpyxa1HoeTHh9MA1+EUqO3F+EQl50QOH8aBznkOa2OWFct12Aoutjig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCQalB+9+B5iijTQNgOIPK107xlHC+JJC1ZGak4b/nE=;
 b=YRpuA83iDyc8hi5CHn6Joq1ngZGYEhNG6mtxOHcKkAQ+aBQAi7sipp4f2FZ679WdSoTka8Vy6Ap5gqciu7S+6nffKIzAUffM1cEIK+3Lq/CEgum6Dra2di0DbO+9dYcHf5oq8+c9mkTP6IpBoctn3+VEHunCl6JqogslWHDg/0q/5G7FP5ahYIEhOgAltISSDql89ZsqRyTFJFeJicna+tKMgRxchFnH1CaoSJIparPVg6MNSEJSb17wx0Zriung4JNtxJgCdlACNH+pESr+DvqZAV7TB8XJ9Vof1lRsfzIuM0Q+R3pfcTdy+xtt9/XsWEL9jP6QoL0ooeIcWlAWzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCQalB+9+B5iijTQNgOIPK107xlHC+JJC1ZGak4b/nE=;
 b=nL1wb7T3oll++wt+E5WQQA62PSYqsIjyYdfsxPtPCR51ClRuWI4mzCfA7ZIslQc0XTOPSOZsd1Xrugmiw5U9LzQSfeab/Lmuysn/lSd8qwubtXp6Z5JBDeopuge35NLni5bPXqmgQBw3u3Vqzt7yYPLB2rs3rbh7oBe0A+NJ2BE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5461.eurprd08.prod.outlook.com (10.141.174.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20; Fri, 27 Mar 2020 06:00:25 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533%6]) with mapi id 15.20.2835.023; Fri, 27 Mar 2020
 06:00:25 +0000
Subject: Re: [PATCH v2 1/3] backup: don't acquire aio_context in backup_clean
To: Stefan Reiter <s.reiter@proxmox.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
References: <20200326155628.859862-1-s.reiter@proxmox.com>
 <20200326155628.859862-2-s.reiter@proxmox.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200327090023209
Message-ID: <ec317e02-1f34-9219-e2c5-13d352f64d82@virtuozzo.com>
Date: Fri, 27 Mar 2020 09:00:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200326155628.859862-2-s.reiter@proxmox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR07CA0024.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::37) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.35) by
 AM0PR07CA0024.eurprd07.prod.outlook.com (2603:10a6:208:ac::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.11 via Frontend Transport; Fri, 27 Mar 2020 06:00:24 +0000
X-Tagtoolbar-Keys: D20200327090023209
X-Originating-IP: [185.215.60.35]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 420c0eb4-f4d9-4e32-41fd-08d7d2142471
X-MS-TrafficTypeDiagnostic: AM7PR08MB5461:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5461E7D93953B55879372B17C1CC0@AM7PR08MB5461.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-Forefront-PRVS: 0355F3A3AE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(376002)(346002)(396003)(39850400004)(136003)(366004)(8676002)(316002)(16576012)(31696002)(86362001)(6486002)(66556008)(8936002)(4326008)(66946007)(81166006)(66476007)(81156014)(186003)(956004)(2616005)(16526019)(52116002)(36756003)(2906002)(26005)(5660300002)(31686004)(478600001);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mbyGXv047+104pnw0e6ZZoP5svNgWCfT4ie+ea30ta8UdHIQIPH463Q2JfyCvlh0hFNUCTvI5o55P3IhsemHvSoi0LArFQKrkqgdzDJCc/OZM03usCiQYNyfjrzkRRzZbv3+i4tvBbHwDqZhPQF74eH4USxqTl0Q8m1aAcMEtg1Bm5CVWzIaV0/w91lrWu1xUxa/JR/62VESkl2ulDwnN1e0n502l35Fyy2l9Tm9iz47bMLTZu2m8Mt3ZZb7UH4PMfBTVGbMOhaQt1YBQwmxE61Sj05FL7QEPbKnGl9IFotX23iXoQKe0Aa6t5EvXzV0kbKqjjJGwT8lHoTl/DYCHzCly5lgfzHCvVvLR/c1Ab+2npWcB99v2eBtoxA8l7V5TIDW+JBOMymr7ADnbAa6ef1NVgqb+OCwqZWT9YakrESqOWB6s4wKYG9fuLo3CxZS
X-MS-Exchange-AntiSpam-MessageData: qQv5Z4tUshih0BTXoxrKMvIOKu18yUTnN+cN9eI/Yi/Umbldw11LSTBPETMxWnpnsJpNS33x8OWq9OF5gA066UtgJQlo9s9Plf/NQEClnDo5ymvlW7Lj+1P6sePvV/kZhZZt5MgDzo74J356JOM10g==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 420c0eb4-f4d9-4e32-41fd-08d7d2142471
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2020 06:00:24.9950 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +DGQ0KyMKLc4NGSKXl3lIEEAfONoWcKkgieHRIAVI42MA9nUsCRK81PotCU/ETG3ZkXhMqcFYv1wy1ZBytIVhNYns5zsN/GoBCwmFidboTk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5461
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.1.139
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
Cc: kwolf@redhat.com, slp@redhat.com, mreitz@redhat.com, stefanha@redhat.com,
 jsnow@redhat.com, dietmar@proxmox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

26.03.2020 18:56, Stefan Reiter wrote:
> All code-paths leading to backup_clean (via job_clean) have the job's
> context already acquired. The job's context is guaranteed to be the same
> as the one used by backup_top via backup_job_create.

As we already discussed, this is not quite right. So, may be this patch should
be the last one...

> 
> Since the previous logic effectively acquired the lock twice, this
> broke cleanup of backups for disks using IO threads, since the BDRV_POLL_WHILE
> in bdrv_backup_top_drop -> bdrv_do_drained_begin would only release the lock
> once, thus deadlocking with the IO thread.
> 
> This is a partial revert of 0abf2581717a19.
> 
> Signed-off-by: Stefan Reiter <s.reiter@proxmox.com>
> ---
>   block/backup.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/block/backup.c b/block/backup.c
> index 7430ca5883..a7a7dcaf4c 100644
> --- a/block/backup.c
> +++ b/block/backup.c
> @@ -126,11 +126,7 @@ static void backup_abort(Job *job)
>   static void backup_clean(Job *job)
>   {
>       BackupBlockJob *s = container_of(job, BackupBlockJob, common.job);
> -    AioContext *aio_context = bdrv_get_aio_context(s->backup_top);
> -
> -    aio_context_acquire(aio_context);
>       bdrv_backup_top_drop(s->backup_top);
> -    aio_context_release(aio_context);
>   }
>   
>   void backup_do_checkpoint(BlockJob *job, Error **errp)
> 


-- 
Best regards,
Vladimir

