Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3F1C43465
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 13:59:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86CBE20866
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 13:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Vxq1/CZ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86CBE20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKMLu-00009V-Gl
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 09:59:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kKMKg-00084E-A1; Mon, 21 Sep 2020 09:58:18 -0400
Received: from mail-am6eur05on2126.outbound.protection.outlook.com
 ([40.107.22.126]:16416 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kKMKc-00077i-Hj; Mon, 21 Sep 2020 09:58:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sn1TAK4GNz2i59PEQv9gP9M2pAkeQcBLd4yC/7Goha9+vY958DvQDdwkWskeNrZakp4HVJpNiTa0grpe6goTzZ09wVSkLx5lX2QKmAzUhVCpCvGG4Til9KDknvJwk+ADY5cXynre1PfjJ6ibsSKTvjteSOtKVoqegpmqDODfSkY7e0I7dV/quC4C72OamIrFE7NnM91dSIVV/igBa+a1+4mvm6/vx2Fo7kJHSivQcxzNx1WZbp9lSFt8042R8F6tqOhx/u31E821Ymg6AYCeUzJhUFdnU/5XWKTzPO2meGep5QzgIuAvuU4o3lAsI15nQJCw8kEhktn73tcNZtLmMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPk58qivMeEzmRe0y0SkAQPpdW2E72Cf4xUn0EsdbP0=;
 b=bjSEWExG/qNDLuGc+l0gqerFWLbAfmzKR1F21Iduohkf43FwUsPAgDKS5kOpz5sehnNEHccd3I288WX3+cLsSSEN5j8fp9Rb8lzMuYC7bussmhl3mJYXTn32RfK2HhdLFhXHuG/LUvUrLDcNF4QwKh0EPUQo2/mxdti818r3qnyWPP3DQAdYBeSGXuGUA1bIbOxYrk5p3H9A8ok8CHYOPMyFkH9v5YFFYftbF7MRIysPjd74MwG2Pb+azlgka0owgMzx2AxuQ4KtV0JRdSw3kDcHvR3Ehi75+Hc0OU6M8hah9dd/uHN/PhcwE2KPiJdEfzIX46OFsbOCeuQwvYDHhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPk58qivMeEzmRe0y0SkAQPpdW2E72Cf4xUn0EsdbP0=;
 b=Vxq1/CZ5FwPaYqCnPueqteVI4Fks3YBAY9vlyktnydUDik/360DXRbu/pPrlbIEz580IFjg1bkB+O7/LvXn5J0o71CrccRhjT8mfXn02bX7V26FKnVe4bxUJavsDIzJVELF3r/frNAXBEyi6GGRE+mWHgMhqQQz2L1TQwuDP9Vk=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3717.eurprd08.prod.outlook.com (2603:10a6:20b:8e::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Mon, 21 Sep
 2020 13:58:09 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.033; Mon, 21 Sep 2020
 13:58:09 +0000
Subject: Re: [PATCH v2 17/20] backup: move to block-copy
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, wencongyang2@huawei.com,
 xiechanglong.d@gmail.com, armbru@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org, den@openvz.org
References: <20200601181118.579-1-vsementsov@virtuozzo.com>
 <20200601181118.579-18-vsementsov@virtuozzo.com>
 <6376705f-d24d-1b40-f4dd-480c53c7ae55@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <4cc0ab8c-6845-b35c-ff5e-814715a82b35@virtuozzo.com>
Date: Mon, 21 Sep 2020 16:58:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
In-Reply-To: <6376705f-d24d-1b40-f4dd-480c53c7ae55@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0113.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::18) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.94) by
 AM0PR01CA0113.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend
 Transport; Mon, 21 Sep 2020 13:58:08 +0000
X-Originating-IP: [185.215.60.94]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8402eb58-a062-4178-385b-08d85e365f0c
X-MS-TrafficTypeDiagnostic: AM6PR08MB3717:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3717CD33B9A200CBCBD1FCCFC13A0@AM6PR08MB3717.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IAd1iaRtrDkhtdl+sb8JFwV5/fbBx8bxIwggZJS6H26fuAskKrDmEvZ0I3/cIBwJm8c7K6pLLw4MKmL2bgFTSro9QkgB4r4PV5PRqudVjyu99g53CyQ5075r2Id2FpTh99Bfz/LXUp2p5f6SRYcw/rF3L9R4FUypgfBjBZm6r33orRZdVtQ5ouoSOvwvMkw9s2ZkqgXRzG5K7d/ocqz+9w+ZMDuZQiWgD2bskAOsdA8pbZPSO37877LybVqaxzG2DCmJqabLc5RPQowkk4x8x0oGlxM6EZaoxH95CUb0i6GBrcyW/DPYhT442Pn16NuiigvE0zFLHc5s7rfoxMNG4+oaJP58+/7hTmRt7ngTR0mE0wYXhiMhQ9RzbNdB98wt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39840400004)(346002)(136003)(376002)(86362001)(8936002)(316002)(6486002)(956004)(2616005)(16576012)(31686004)(5660300002)(66556008)(66476007)(66946007)(16526019)(83380400001)(8676002)(478600001)(107886003)(186003)(26005)(36756003)(4326008)(52116002)(31696002)(2906002)(53546011)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: xk/qh4BlcA9Ic42+Qr4lxypUENvo902OJJLVFZIB8SeCQ/6TUKdVmEqo6Hk6BG9fbH/xpTVhjszKRBS19m8+wzIYl+85hCUjJ3ckmYvzXKyaOpAv5D9meluPOgw09ozSHQRWGxd3AQqIgIyFXsS3SfRJiXMeXPQqyHlkkIsTQOvHZl1mxF+wry5xIZqxo7VDi738voAbEBBZUIHO/MxiMXny1HcsRw0tYW071kExz0te710sagrWnYm1o0e8bDlO8DbVnr/DBfVJwYfTAx66Wjru+5WIJGAd8PdiQX0v5pht+3pZoBDnO4lZxaZN0I7RfpdqB4GJxvpkcMdjZ9W/BUhZFV25AkVHJSxMIq06hDsctLai6Vmzug/z5O8jy8jZ/inaum9v6FvhVywRoG49TiuLWp6C3UN6dMCM9Q2Dsd/TwS0YbYoFUwfpQ5hX7kyknjQH6wCP4Sj8ES4L0ssOrjctRfnMoizmYn35eZT6ctTxnSNz8ND3ZLAIhkt3m/LI+3VXsis+ivuj2SjFimGs8j6aas0NUfcOEjZxYCB3iLDfuLmCzdirg+36/jYg8SP/k8PGMKmDnAaWAkx4K4f0k/Qt3QCXbtURVuJH8Bk3iDl9NmNK50sWHzkxXkvKtfnyLecKmqFCmxeZSQLrm5WxWw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8402eb58-a062-4178-385b-08d85e365f0c
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2020 13:58:09.0917 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 47gu+kYrQxskvUUVmX5oC9PSq8M/gmzYXNtCoDR701Y38cboATk6xb+IWHtvSymDyP6iB7QI2VyqDIdJyihQSUrjwfT8gZXn5W58aI8vX0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3717
Received-SPF: pass client-ip=40.107.22.126;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 09:58:10
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

23.07.2020 12:47, Max Reitz wrote:
> On 01.06.20 20:11, Vladimir Sementsov-Ogievskiy wrote:
>> This brings async request handling and block-status driven chunk sizes
>> to backup out of the box, which improves backup performance.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   include/block/block-copy.h |   9 +--
>>   block/backup.c             | 145 +++++++++++++++++++------------------
>>   block/block-copy.c         |  21 ++----
>>   3 files changed, 83 insertions(+), 92 deletions(-)
> 
> This patch feels like it should be multiple ones.  I don’t see why a
> patch that lets backup use block-copy (more) should have to modify the
> block-copy code.
> 
> More specifically: I think that block_copy_set_progress_callback()
> should be removed in a separate patch.  Also, moving
> @cb_opaque/@progress_opaque from BlockCopyState into BlockCopyCallState
> seems like a separate patch to me, too.
> 
> (I presume if the cb had had its own opaque object from patch 5 on,
> there wouldn’t be this problem now.  We’d just stop using the progress
> callback in backup, and remove it in one separate patch.)
> 
> [...]
> 
>> diff --git a/block/backup.c b/block/backup.c
>> index ec2676abc2..59c00f5293 100644
>> --- a/block/backup.c
>> +++ b/block/backup.c
>> @@ -44,42 +44,19 @@ typedef struct BackupBlockJob {
>>       BlockdevOnError on_source_error;
>>       BlockdevOnError on_target_error;
>>       uint64_t len;
>> -    uint64_t bytes_read;
>>       int64_t cluster_size;
>>       int max_workers;
>>       int64_t max_chunk;
>>   
>>       BlockCopyState *bcs;
>> +
>> +    BlockCopyCallState *bcs_call;
> 
> Can this be more descriptive?  E.g. background_bcs?  bg_bcs_call?  bg_bcsc?
> 
>> +    int ret;
>> +    bool error_is_read;
>>   } BackupBlockJob;
>>   
>>   static const BlockJobDriver backup_job_driver;
>>   
> 
> [...]
> 
>>   static int coroutine_fn backup_loop(BackupBlockJob *job)
>>   {
>> -    bool error_is_read;
>> -    int64_t offset;
>> -    BdrvDirtyBitmapIter *bdbi;
>> -    int ret = 0;
>> +    while (true) { /* retry loop */
>> +        assert(!job->bcs_call);
>> +        job->bcs_call = block_copy_async(job->bcs, 0,
>> +                                         QEMU_ALIGN_UP(job->len,
>> +                                                       job->cluster_size),
>> +                                         true, job->max_workers, job->max_chunk,
>> +                                         backup_block_copy_callback, job);
>>   
>> -    bdbi = bdrv_dirty_iter_new(block_copy_dirty_bitmap(job->bcs));
>> -    while ((offset = bdrv_dirty_iter_next(bdbi)) != -1) {
>> -        do {
>> -            if (yield_and_check(job)) {
>> -                goto out;
>> +        while (job->bcs_call && !job->common.job.cancelled) {
>> +            /* wait and handle pauses */
> 
> Doesn’t someone need to reset BlockCopyCallState.cancelled when the job
> is unpaused?  I can’t see anyone doing that.
> 
> Well, or even just reentering the block-copy operation after
> backup_pause() has cancelled it.  Is there some magic I’m missing?
> 
> Does pausing (which leads to cancelling the block-copy operation) just
> yield to the CB being invoked, so the copy operation is considered done,
> and then we just enter the next iteration of the loop and try again?

Yes, that's my idea: we cancel on pause and just run new block_copy operation
on resume.

> But cancelling the block-copy operation leads to it returning 0, AFAIR,
> so...

Looks like it should be fixed. By returning ECANCELED or by checking the bitmap.

> 
>> +
>> +            job_pause_point(&job->common.job);
>> +
>> +            if (job->bcs_call && !job->common.job.cancelled) {
>> +                job_yield(&job->common.job);
>>               }
>> -            ret = backup_do_cow(job, offset, job->cluster_size, &error_is_read);
>> -            if (ret < 0 && backup_error_action(job, error_is_read, -ret) ==
>> -                           BLOCK_ERROR_ACTION_REPORT)
>> -            {
>> -                goto out;
>> +        }
>> +
>> +        if (!job->bcs_call && job->ret == 0) {
>> +            /* Success */
>> +            return 0;
> 
> ...I would assume we return here when the job is paused.
> 
>> +        }
>> +
>> +        if (job->common.job.cancelled) {
>> +            if (job->bcs_call) {
>> +                block_copy_cancel(job->bcs_call);
>>               }
>> -        } while (ret < 0);
>> +            return 0;
>> +        }
>> +
>> +        if (!job->bcs_call && job->ret < 0 &&
> 
> Is it even possible for bcs_call to be non-NULL here?
> 
>> +            (backup_error_action(job, job->error_is_read, -job->ret) ==
>> +             BLOCK_ERROR_ACTION_REPORT))
>> +        {
>> +            return job->ret;
>> +        }
> 
> So if we get an error, and the error action isn’t REPORT, we just try
> the whole operation again?  That doesn’t sound very IGNORE-y to me.

Not the whole. We have the dirty bitmap: clusters that was already copied are not touched more.



-- 
Best regards,
Vladimir

