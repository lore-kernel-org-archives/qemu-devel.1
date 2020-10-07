Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13616C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 19:33:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 533D5207EA
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 19:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="GOgcTp8q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 533D5207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQFCB-0004wX-8S
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 15:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kQFBJ-0004VA-Hm; Wed, 07 Oct 2020 15:32:57 -0400
Received: from mail-db8eur05on2137.outbound.protection.outlook.com
 ([40.107.20.137]:6241 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kQFBF-00006U-2T; Wed, 07 Oct 2020 15:32:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QWFA2x/Nm/e8SQHSmexKOo2iIPJiiGalBC6NFAoIOXvku2GSY1BFdbpDt2WnnQqbopl7glrz1sP88FGcI/t6uqqtRUKkGPtBtm++wfZlmCTxkGcLMRqGdt/B0R31faGfWu4RkRncU7N6nYnnipk+L+7ooQ62KiztJOdlykWA1BBw1LxARK5jM7DVzZSS1QPXB0uJwdNRknkCdWkP14D7aGCskxhdfRyXeksDQCLdyhhux7T4zv3SUOmPBsxaFJUE4OlFZyUVEfMG2Ah/1qIRvcRthNQdYw0QoV5H/4c5qcIACFxoxn2nu5zzcR/Gcg8hOTZ9ql0GPDH84DcvO1VtpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgIQRaB6LEyRl3iN7hFW3ZvDeVIhIfSMk/mjGtnOocE=;
 b=CVobZ59MUUQAT3xk2kfGr4tdEVkRtoUWDCQL53WQakuYHJWtiguaGesmWnsPdewHjC+jtgDsanm/c2CUnV96jU8z6bszxm5a96/rm3KtyM94h7SV3CPwdROJMxcE/aGji7LHtkJTCBsQaZEReCkLRdZ5fO4rOfM1lH+SRAUWN/sLRJffwS/0PD+njuRNnm/WSHAiIgevku7zON1ET+6dm5N1G91CHX7NkwnPi0nqeM6MUz0OgbGpi2b6FuiIdD16MjtzrOM2VcIA8I5hxGcSt87nQcZL1IaIvaAyaXA6ayRISFy0/WU/P2xGxhINz45j4vlo5PeWeqXQKmg7z1+wtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgIQRaB6LEyRl3iN7hFW3ZvDeVIhIfSMk/mjGtnOocE=;
 b=GOgcTp8qPpyEgqiqrMcGbEIrcykqLihqGC30480smdwQJiPvvZKouk2XfSwxPgJ1WTV2xmutdZ2rWO4IjuQ/5Eg8C64qqx59dh8cV7JVpRD5nBLot6f5B68Ffy2+3rEgJzrJX9DXtxX/nXYbbtV5jRgSNBvFOeJuydFOWDKBnek=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com (2603:10a6:3:89::22)
 by HE1PR0802MB2219.eurprd08.prod.outlook.com (2603:10a6:3:c3::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.38; Wed, 7 Oct
 2020 19:32:49 +0000
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036]) by HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036%6]) with mapi id 15.20.3433.045; Wed, 7 Oct 2020
 19:32:49 +0000
Subject: Re: [PATCH v10 8/9] block: remove unused backing-file name parameter
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com,
 stefanha@redhat.com, fam@euphon.net, jsnow@redhat.com, armbru@redhat.com,
 eblake@redhat.com, den@openvz.org
References: <1601383109-110988-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1601383109-110988-9-git-send-email-andrey.shinkevich@virtuozzo.com>
 <7944f050-1158-bda7-a3f9-c90001322599@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <fe79268b-ba8d-a138-45fe-2bd0dc4b4460@virtuozzo.com>
Date: Wed, 7 Oct 2020 22:32:45 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <7944f050-1158-bda7-a3f9-c90001322599@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [109.252.114.22]
X-ClientProxiedBy: AM4PR0101CA0055.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::23) To HE1PR0801MB2124.eurprd08.prod.outlook.com
 (2603:10a6:3:89::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.22) by
 AM4PR0101CA0055.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend
 Transport; Wed, 7 Oct 2020 19:32:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c1cfcdf-e6a9-44fe-57bf-08d86af7c626
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2219:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0802MB221993CE98F3180EC5920FB6F40A0@HE1PR0802MB2219.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ebae+xu5oFa56d13bn858gTW4hhHfEzOXfQzbxLW0SjhNP7ZlyEKkJWEhwhYLSWTgGMR/6ZckbEgt3c91VKXKZcoQQXXLuyE1WGZIXYjGJQvynKrI2Cm5/vrklJiS3PzBBt/z14F8KS9JCZFJmMIZoXCd4uYyfWJ0chv/0rqVmFtJEGlb79+11IYtCkp3FetSi8grgq16Eh1s0Z70lk3MTXcTOQ0VVeEVcsznfQzaXm+W1BHBNLoElu8EPrRki82vO6VbAvO+kaX3DqBvBBM9bEf6CsW2EX7gjKNXr/joI1gY2614lZhD4YoUS+qnULUpYfPjnccqOStwjpy7LFirI7d20bPrEwHg2oF1WoRJPPcE9aw8TqQ9Eq0kCqOULz6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB2124.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(366004)(39850400004)(136003)(2616005)(86362001)(36756003)(52116002)(6512007)(6486002)(31696002)(316002)(66946007)(31686004)(83380400001)(66556008)(44832011)(8936002)(2906002)(66476007)(4326008)(478600001)(956004)(186003)(26005)(5660300002)(107886003)(6506007)(8676002)(53546011)(16526019)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: GH6FnMbcd57t+zdKWydw9FQ7sARURkkdEDi1d4WRTTyUjtTOW3dBiRATiIY85xHCPHy3RA/YsAL6jTrZjPbhyvyZ8A1nQvFf2Sjivypra+FY3OZ+2sdNlraUpRmXxYjx1lyqwRmcSFC4w9sgJoN+ugs2vROPAtPaVNfl2WpeJveLRiWdQ9zcQJvTmNLDXrXtj37zTGrDHI6VGUiYyZLrN2f8oCd6w0xzGD5NqRsXXJ1UD/JCXpq2mTUTXk40uy1rzYEcDhd7sp0O8K/T5WpUZ8uajgn6/f1cW2tIDYuIgZYsrDxBypPuK4HJoFfkprQ1CgPglh5gtf+cwIU49JGQaZwJuusPBGEu9bMmGjQlK7AcP+kd6V0iDe/isFCm8ClTmuxWNQnR6ybtRam5bPYteVtIM1RBYCG4rIgKXKrjS29pazuB5/ZuMUneSTOD3uqlE3VPMhem/A51cOXNn+V3/7cq63KBBJ6CZBFl1VuHhwgPQx37iNQ1IqtScjllQ+A1oMYzL6IAiYs59z818d02FquXwnaT5c5XtwSyRZpL+xFJuMeB0KL+lAEnk8Xmkp/9PGRsEeAMWOhJ4lehOw7nVfmoHvmZIWffN1e2qN4ZpaHakGHfsMrkLHduw6DWr4Nj0tyMoUITtKbsTJjQzgzxaw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c1cfcdf-e6a9-44fe-57bf-08d86af7c626
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB2124.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 19:32:48.8602 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nYXVlccSRVy4jhkBHHrjnlYA5g3eNZy+9EAHhHHM2MXszpObWNpNyiE3TjaUkTv6lDSS7UsskiZRUlqrW2l10cgOigXqzRmn4jUKjDn7KmA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2219
Received-SPF: pass client-ip=40.107.20.137;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 15:32:51
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


On 07.10.2020 13:21, Vladimir Sementsov-Ogievskiy wrote:
> 29.09.2020 15:38, Andrey Shinkevich wrote:
>> The block stream QMP parameter backing-file is in use no more. It
>> designates a backing file name to set in QCOW2 image header after the
>> block stream job finished. The base file name is used instead.
>>
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> 
> We can't just remove it without a deprecation period of three releases.

It has not been in use for a long. It's time.

> 
> So actually, in a previous patch, we should implement new behavior for
> automatic backing-file detection if this parameter is unspecified. Amd
> keep old behavior for backing-file-name if it is given.
> 
> Hmm. Or, probably, we can use direct base for base-filename? And in cases
> when we should skip filters (for example of parallel jobs) user should
> specify backing-file explicitly?

The backing_file_str is always specified if the base is specified and is 
always equal to the base->filename. So, the user's backing file name is 
always NULL for the stream job. Furthermore, it is not checked for being 
the correct backing node and can lead to a wrong record in the QCOW2 header.

Andrey

> 
>> ---
>>   block/monitor/block-hmp-cmds.c |  2 +-
>>   block/stream.c                 |  6 +-----
>>   blockdev.c                     | 17 +----------------
>>   include/block/block_int.h      |  2 +-
>>   qapi/block-core.json           | 17 +----------------
>>   5 files changed, 5 insertions(+), 39 deletions(-)
>>
>> diff --git a/block/monitor/block-hmp-cmds.c 
>> b/block/monitor/block-hmp-cmds.c
>> index 4e66775..5f19499 100644
>> --- a/block/monitor/block-hmp-cmds.c
>> +++ b/block/monitor/block-hmp-cmds.c
>> @@ -506,7 +506,7 @@ void hmp_block_stream(Monitor *mon, const QDict 
>> *qdict)
>>       int64_t speed = qdict_get_try_int(qdict, "speed", 0);
>>       qmp_block_stream(true, device, device, base != NULL, base, 
>> false, NULL,
>> -                     false, NULL, qdict_haskey(qdict, "speed"), 
>> speed, true,
>> +                     qdict_haskey(qdict, "speed"), speed, true,
>>                        BLOCKDEV_ON_ERROR_REPORT, false, NULL, false, 
>> false, false,
>>                        false, &error);
>> diff --git a/block/stream.c b/block/stream.c
>> index b0719e9..fe2663f 100644
>> --- a/block/stream.c
>> +++ b/block/stream.c
>> @@ -34,7 +34,6 @@ typedef struct StreamBlockJob {
>>       BlockDriverState *base_overlay; /* COW overlay (stream from 
>> this) */
>>       BlockDriverState *above_base;   /* Node directly above the base */
>>       BlockdevOnError on_error;
>> -    char *backing_file_str;
>>       bool bs_read_only;
>>       bool chain_frozen;
>>   } StreamBlockJob;
>> @@ -103,8 +102,6 @@ static void stream_clean(Job *job)
>>           blk_set_perm(bjob->blk, 0, BLK_PERM_ALL, &error_abort);
>>           bdrv_reopen_set_read_only(bs, true, NULL);
>>       }
>> -
>> -    g_free(s->backing_file_str);
>>   }
>>   static int coroutine_fn stream_run(Job *job, Error **errp)
>> @@ -220,7 +217,7 @@ static const BlockJobDriver stream_job_driver = {
>>   };
>>   void stream_start(const char *job_id, BlockDriverState *bs,
>> -                  BlockDriverState *base, const char *backing_file_str,
>> +                  BlockDriverState *base,
>>                     int creation_flags, int64_t speed,
>>                     BlockdevOnError on_error,
>>                     const char *filter_node_name,
>> @@ -295,7 +292,6 @@ void stream_start(const char *job_id, 
>> BlockDriverState *bs,
>>       s->base_overlay = base_overlay;
>>       s->above_base = above_base;
>> -    s->backing_file_str = g_strdup(backing_file_str);
>>       s->bs_read_only = bs_read_only;
>>       s->chain_frozen = true;
>> diff --git a/blockdev.c b/blockdev.c
>> index d719c47..b223601 100644
>> --- a/blockdev.c
>> +++ b/blockdev.c
>> @@ -2486,7 +2486,6 @@ out:
>>   void qmp_block_stream(bool has_job_id, const char *job_id, const 
>> char *device,
>>                         bool has_base, const char *base,
>>                         bool has_base_node, const char *base_node,
>> -                      bool has_backing_file, const char *backing_file,
>>                         bool has_speed, int64_t speed,
>>                         bool has_on_error, BlockdevOnError on_error,
>>                         bool has_filter_node_name, const char 
>> *filter_node_name,
>> @@ -2498,7 +2497,6 @@ void qmp_block_stream(bool has_job_id, const 
>> char *job_id, const char *device,
>>       BlockDriverState *base_bs = NULL;
>>       AioContext *aio_context;
>>       Error *local_err = NULL;
>> -    const char *base_name = NULL;
>>       int job_flags = JOB_DEFAULT;
>>       if (!has_on_error) {
>> @@ -2526,7 +2524,6 @@ void qmp_block_stream(bool has_job_id, const 
>> char *job_id, const char *device,
>>               goto out;
>>           }
>>           assert(bdrv_get_aio_context(base_bs) == aio_context);
>> -        base_name = base;
>>       }
>>       if (has_base_node) {
>> @@ -2541,7 +2538,6 @@ void qmp_block_stream(bool has_job_id, const 
>> char *job_id, const char *device,
>>           }
>>           assert(bdrv_get_aio_context(base_bs) == aio_context);
>>           bdrv_refresh_filename(base_bs);
>> -        base_name = base_bs->filename;
>>       }
>>       /* Check for op blockers in the whole chain between bs and base */
>> @@ -2553,17 +2549,6 @@ void qmp_block_stream(bool has_job_id, const 
>> char *job_id, const char *device,
>>           }
>>       }
>> -    /* if we are streaming the entire chain, the result will have no 
>> backing
>> -     * file, and specifying one is therefore an error */
>> -    if (base_bs == NULL && has_backing_file) {
>> -        error_setg(errp, "backing file specified, but streaming the "
>> -                         "entire chain");
>> -        goto out;
>> -    }
>> -
>> -    /* backing_file string overrides base bs filename */
>> -    base_name = has_backing_file ? backing_file : base_name;
>> -
>>       if (has_auto_finalize && !auto_finalize) {
>>           job_flags |= JOB_MANUAL_FINALIZE;
>>       }
>> @@ -2571,7 +2556,7 @@ void qmp_block_stream(bool has_job_id, const 
>> char *job_id, const char *device,
>>           job_flags |= JOB_MANUAL_DISMISS;
>>       }
>> -    stream_start(has_job_id ? job_id : NULL, bs, base_bs, base_name,
>> +    stream_start(has_job_id ? job_id : NULL, bs, base_bs,
>>                    job_flags, has_speed ? speed : 0, on_error,
>>                    filter_node_name, &local_err);
>>       if (local_err) {
>> diff --git a/include/block/block_int.h b/include/block/block_int.h
>> index f782737..bbe2ee6 100644
>> --- a/include/block/block_int.h
>> +++ b/include/block/block_int.h
>> @@ -1147,7 +1147,7 @@ int is_windows_drive(const char *filename);
>>    * BlockDriverState.
>>    */
>>   void stream_start(const char *job_id, BlockDriverState *bs,
>> -                  BlockDriverState *base, const char *backing_file_str,
>> +                  BlockDriverState *base,
>>                     int creation_flags, int64_t speed,
>>                     BlockdevOnError on_error,
>>                     const char *filter_node_name,
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index 32fb097..6358606 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -2512,21 +2512,6 @@
>>   # @base-node: the node name of the backing file.
>>   #             It cannot be set if @base is also set. (Since 2.8)
>>   #
>> -# @backing-file: The backing file string to write into the top
>> -#                image. This filename is not validated.
>> -#
>> -#                If a pathname string is such that it cannot be
>> -#                resolved by QEMU, that means that subsequent QMP or
>> -#                HMP commands must use node-names for the image in
>> -#                question, as filename lookup methods will fail.
>> -#
>> -#                If not specified, QEMU will automatically determine
>> -#                the backing file string to use, or error out if there
>> -#                is no obvious choice.  Care should be taken when
>> -#                specifying the string, to specify a valid filename or
>> -#                protocol.
>> -#                (Since 2.1)
>> -#
>>   # @speed: the maximum speed, in bytes per second
>>   #
>>   # @on-error: the action to take on an error (default report).
>> @@ -2566,7 +2551,7 @@
>>   ##
>>   { 'command': 'block-stream',
>>     'data': { '*job-id': 'str', 'device': 'str', '*base': 'str',
>> -            '*base-node': 'str', '*backing-file': 'str', '*speed': 
>> 'int',
>> +            '*base-node': 'str', '*speed': 'int',
>>               '*on-error': 'BlockdevOnError',
>>               '*filter-node-name': 'str',
>>               '*auto-finalize': 'bool', '*auto-dismiss': 'bool' } }
>>
> 
> 

