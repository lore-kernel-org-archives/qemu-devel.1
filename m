Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26053C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 05:55:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE7F920719
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 05:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="PIXjqsaZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE7F920719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHLUc-00025U-3O
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 01:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47805)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jHLTt-0001UL-UP
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 01:55:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jHLTs-0007UQ-I2
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 01:55:05 -0400
Received: from mail-db8eur05on2129.outbound.protection.outlook.com
 ([40.107.20.129]:9952 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jHLTn-0007TD-CT; Thu, 26 Mar 2020 01:54:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zv3GtOz9uimnaDVvM89uSsm+b7iIa5lfulWBU92ulTD4nEFIElLjISSCHXtBGEerxbPSrH7S4fgtL5EKhFDqhKQ4ALXONO1d403S6IGUv+xj+bTW0N9p+9SDmr2Pj1zl8xhaHNxrX4N0XdOs5dyBa6PR+Ixd0qzAbuPeQk+OD+NLCd4ANbpq5f3KsFsUDSgAEfazSTyCA4+dosR3V3G34R9OxJB5RG6ys7R6lYCVZfQSW6y6/+mK/hzy5UvqTuS3uxjoTZTrKJym/yXUbWoSZUr3i1/cEtyjxXFSHJoRh2J7LzGV0NXtkyNaRAdErc5ZkV+D5AtsdlF3uWk+q0NJYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dyKdwfgNnT7sZWsDM/RnsC7Ld3Ut7ozPkO6peoOkftE=;
 b=Ud7VOeq6B3HcZG76LGyYxrq7o+nhHZwd6mojNk2UAhjJlQaQoGB9wxzkDi7JjoyQUM19udHH9hWg2nW6XVBM9waU/PN9hpGWe7IzSbm2CUhSxhM+sj5YDeQT7qXfcQ5TFB82SOoVJf7NQMcJFAHLrgYoRXutikb8DCndoGMOc/0NCLRyH5s1kAdSZKAED+KZzhRhq10q9Cndw3uEZikZhr32pLz5cAcV2bju/enRXZyYlWjbf4sNZBJGXN2n2Kp8v3vOMz+a7J3gT5EiTdoxNofIn+3KiFvqeqg1Cbr6p/Yt01oux7UsDaiIb0yJMc8qTeC8ULF0b0TuH28r4xfh/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dyKdwfgNnT7sZWsDM/RnsC7Ld3Ut7ozPkO6peoOkftE=;
 b=PIXjqsaZoUmQuw2SbTMneC7JEnRFTRkZMs9zoCL+r0YFyHEoO3qdXpysSX/Z/Irw+mTOGvRGGvSjBxTClNJJ4rVNq6nYinGXpSUbufKNw/Z5z5hwSmvS4x84Xq2XfIK+PKrYanpDkc0SxhvwFCfWU/x550ShI/xZikyhx85iXyI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5462.eurprd08.prod.outlook.com (10.141.173.201) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.18; Thu, 26 Mar 2020 05:54:56 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533%6]) with mapi id 15.20.2835.023; Thu, 26 Mar 2020
 05:54:56 +0000
Subject: Re: [PATCH] backup: don't acquire aio_context in backup_clean
To: Stefan Reiter <s.reiter@proxmox.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
References: <76edbead-7ccf-833b-a3f2-15dff7f0748c@virtuozzo.com>
 <20200325155055.730633-1-s.reiter@proxmox.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200326085453548
Message-ID: <2b288000-7c09-ba31-82a7-02c5ed55f4e7@virtuozzo.com>
Date: Thu, 26 Mar 2020 08:54:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200325155055.730633-1-s.reiter@proxmox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR07CA0077.eurprd07.prod.outlook.com
 (2603:10a6:207:6::11) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.35) by
 AM3PR07CA0077.eurprd07.prod.outlook.com (2603:10a6:207:6::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.9 via Frontend Transport; Thu, 26 Mar 2020 05:54:55 +0000
X-Tagtoolbar-Keys: D20200326085453548
X-Originating-IP: [185.215.60.35]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19b61456-6f49-4a5d-9c65-08d7d14a362f
X-MS-TrafficTypeDiagnostic: AM7PR08MB5462:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5462C1FD026F89E0E24AD2E8C1CF0@AM7PR08MB5462.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 0354B4BED2
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(396003)(39850400004)(376002)(346002)(366004)(31686004)(4326008)(86362001)(52116002)(31696002)(2906002)(186003)(16526019)(81166006)(36756003)(26005)(81156014)(2616005)(956004)(66556008)(66476007)(316002)(6486002)(966005)(16576012)(66946007)(478600001)(5660300002)(8676002)(8936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM7PR08MB5462;
 H:AM7PR08MB5494.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1QUjOCkcgvMsv3i+iQeU2vysp3Xl0ulCIXCpRjo3igfuu/YCXckUSF7gjE8KdJS7CmBmTnH0zdaOljZT4jHUcpL37/lDPCfA1peSgGKSgPOsrLIba8PsgBrC3CCJiyfyT8VwLCz18BmQ1105v5bxyTLpoTWp+TAQVBnkAf6MqsxeqRBw+eNIP8mwoIfRxnmByFb2dwNndJ7HrwfGXWLu/Nw6rjIeyfLDrm7o9LoT8t2WdDijmBzlKh2kvx4wbEtiSy5/uofZ0AUQHngGifhX35OKNapRGaB5waK+cA/LTQ3E5hiV8SXLPrHTqUIewZTGgqAqV/K//JdD98SdrPSJEPEKQOlDah4jZz/ZVe/hi3Ti20ghglI7pGcVv4LH7oNdcR05/UkISx1/XFOWnseZj69zMh9SkwtZqwiwrVrGbDXq+jctIcJYcqGe8mPrre32Ci+WdNDx8IVgLrx2lxj9l+2wwHTZMvoQclLywkIiwqlJg47c3BaCN5ZEy6Y41Rqr84/21KTXAUlxY3GXpXhuOQ==
X-MS-Exchange-AntiSpam-MessageData: fBla/OjRwpQcIf4wKNj8EBpTA7ZtfPOwbqPJxz3MSnps/bks7jY/UnKquuna01tW/sA6Txidn2J5qCh3u6WRmbxhW9pfZq43EBe4GTXFMHsrjgKqrgjUVDcmIRoW+3eYImyYF6A2cWfWIV79373IcQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b61456-6f49-4a5d-9c65-08d7d14a362f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2020 05:54:56.6444 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0isNytWAKUKklDLsyq7eWTyGOrKqWozNXd4qKlpMTSBsf35MVwxl7C0euXypJN86jZP3QyjIEjWRhpj0kHDgYsgPoLun6zG4/PQxi0gGxuA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5462
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.20.129
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

25.03.2020 18:50, Stefan Reiter wrote:
> backup_clean is only ever called as a handler via job_exit, which

Hmm.. I'm afraid it's not quite correct.

job_clean

   job_finalize_single

      job_completed_txn_abort (lock aio context)

      job_do_finalize


Hmm. job_do_finalize calls job_completed_txn_abort, which cares to lock aio context..
And on the same time, it directaly calls job_txn_apply(job->txn, job_finalize_single)
without locking. Is it a bug?

And, even if job_do_finalize called always with locked context, where is guarantee that all
context of all jobs in txn are locked?

Still, let's look through its callers.

	  job_finalize

                qmp_block_job_finalize (lock aio context)
                qmp_job_finalize (lock aio context)
                test_cancel_concluded (doesn't lock, but it's a test)

           job_completed_txn_success

                job_completed

                     job_exit (lock aio context)

                     job_cancel
	 	
                          blockdev_mark_auto_del (lock aio context)

                          job_user_cancel

                              qmp_block_job_cancel (locks context)
                              qmp_job_cancel  (locks context)

                          job_cancel_err

                               job_cancel_sync (return job_finish_sync(job, &job_cancel_err, NULL);, job_finish_sync just calls callback)

                                    replication_close (it's .bdrv_close.. Hmm, I don't see context locking, where is it ?)

                                    replication_stop (locks context)

                                    drive_backup_abort (locks context)

                                    blockdev_backup_abort (locks context)

                                    job_cancel_sync_all (locks context)

                                    cancel_common (locks context)

                          test_* (I don't care)

> already acquires the job's context. The job's context is guaranteed to
> be the same as the one used by backup_top via backup_job_create.
> 
> Since the previous logic effectively acquired the lock twice, this
> broke cleanup of backups for disks using IO threads, since the BDRV_POLL_WHILE
> in bdrv_backup_top_drop -> bdrv_do_drained_begin would only release the lock
> once, thus deadlocking with the IO thread.
> 
> Signed-off-by: Stefan Reiter <s.reiter@proxmox.com>

Just note, that this thing were recently touched by 0abf2581717a19 , so add Sergio (its author) to CC.

> ---
> 
> This is a fix for the issue discussed in this part of the thread:
> https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg07639.html
> ...not the original problem (core dump) posted by Dietmar.
> 
> I've still seen it occasionally hang during a backup abort. I'm trying to figure
> out why that happens, stack trace indicates a similar problem with the main
> thread hanging at bdrv_do_drained_begin, though I have no clue why as of yet.
> 
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

