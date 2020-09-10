Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B77C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 21:03:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC6BD20829
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 21:03:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC6BD20829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxera.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGTjB-00077T-UP
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 17:03:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ari@tuxera.com>)
 id 1kGThp-0005fB-8A; Thu, 10 Sep 2020 17:02:09 -0400
Received: from mgw-02.mpynet.fi ([82.197.21.91]:41234)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ari@tuxera.com>)
 id 1kGThk-0001Ki-Pn; Thu, 10 Sep 2020 17:02:07 -0400
Received: from pps.filterd (mgw-02.mpynet.fi [127.0.0.1])
 by mgw-02.mpynet.fi (8.16.0.42/8.16.0.42) with SMTP id 08AKrBlF058142;
 Fri, 11 Sep 2020 00:01:23 +0300
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
 by mgw-02.mpynet.fi with ESMTP id 33bxbvp0j9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2020 00:01:23 +0300
Received: from [192.168.0.79] (62.78.240.173) by tuxera-exch.ad.tuxera.com
 (10.20.48.11) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 11 Sep
 2020 00:01:22 +0300
Subject: Re: [PATCH 07/14] block/blklogwrites: drop error propagation
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 <qemu-block@nongnu.org>
References: <20200909185930.26524-1-vsementsov@virtuozzo.com>
 <20200909185930.26524-8-vsementsov@virtuozzo.com>
From: Ari Sundholm <ari@tuxera.com>
Message-ID: <8856cf15-4092-55b7-6537-a6beb4ce8a18@tuxera.com>
Date: Fri, 11 Sep 2020 00:01:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200909185930.26524-8-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [62.78.240.173]
X-ClientProxiedBy: tuxera-exch.ad.tuxera.com (10.20.48.11) To
 tuxera-exch.ad.tuxera.com (10.20.48.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-10_09:2020-09-10,
 2020-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=mpy_notspam policy=mpy score=0 bulkscore=0
 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009100185
Received-SPF: pass client-ip=82.197.21.91; envelope-from=ari@tuxera.com;
 helo=mgw-02.mpynet.fi
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 17:01:57
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -77
X-Spam_score: -7.8
X-Spam_bar: -------
X-Spam_report: (-7.8 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.576,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
Cc: kwolf@redhat.com, berto@igalia.com, pavel.dovgaluk@ispras.ru,
 qemu-devel@nongnu.org, armbru@redhat.com, groug@kaod.org, stefanha@redhat.com,
 pbonzini@redhat.com, mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Vladimir!

Thank you for working on this. My comments below.

On 9/9/20 9:59 PM, Vladimir Sementsov-Ogievskiy wrote:
> It's simple to avoid error propagation in blk_log_writes_open(), we
> just need to refactor blk_log_writes_find_cur_log_sector() a bit.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/blklogwrites.c | 23 +++++++++++------------
>   1 file changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/block/blklogwrites.c b/block/blklogwrites.c
> index 7ef046cee9..c7da507b2d 100644
> --- a/block/blklogwrites.c
> +++ b/block/blklogwrites.c
> @@ -96,10 +96,10 @@ static inline bool blk_log_writes_sector_size_valid(uint32_t sector_size)
>           sector_size < (1ull << 24);
>   }
>   
> -static uint64_t blk_log_writes_find_cur_log_sector(BdrvChild *log,
> -                                                   uint32_t sector_size,
> -                                                   uint64_t nr_entries,
> -                                                   Error **errp)
> +static int64_t blk_log_writes_find_cur_log_sector(BdrvChild *log,

I'd rather not change the return type for reasons detailed below.

> +                                                  uint32_t sector_size,
> +                                                  uint64_t nr_entries,
> +                                                  Error **errp)
>   {
>       uint64_t cur_sector = 1;
>       uint64_t cur_idx = 0;
> @@ -112,13 +112,13 @@ static uint64_t blk_log_writes_find_cur_log_sector(BdrvChild *log,
>           if (read_ret < 0) {
>               error_setg_errno(errp, -read_ret,
>                                "Failed to read log entry %"PRIu64, cur_idx);
> -            return (uint64_t)-1ull;
> +            return read_ret;

This is OK, provided the change in return type signedness is necessary 
in the first place.

>           }
>   
>           if (cur_entry.flags & ~cpu_to_le64(LOG_FLAG_MASK)) {
>               error_setg(errp, "Invalid flags 0x%"PRIx64" in log entry %"PRIu64,
>                          le64_to_cpu(cur_entry.flags), cur_idx);
> -            return (uint64_t)-1ull;
> +            return -EINVAL;

This is OK, provided the return type signedness change is necessary, 
although we already do have errp to indicate any errors.

>           }
>   
>           /* Account for the sector of the entry itself */
> @@ -143,7 +143,6 @@ static int blk_log_writes_open(BlockDriverState *bs, QDict *options, int flags,
>   {
>       BDRVBlkLogWritesState *s = bs->opaque;
>       QemuOpts *opts;
> -    Error *local_err = NULL;
>       int ret;
>       uint64_t log_sector_size;
>       bool log_append;
> @@ -215,15 +214,15 @@ static int blk_log_writes_open(BlockDriverState *bs, QDict *options, int flags,
>           s->nr_entries = 0;
>   
>           if (blk_log_writes_sector_size_valid(log_sector_size)) {
> -            s->cur_log_sector =
> +            int64_t cur_log_sector =
>                   blk_log_writes_find_cur_log_sector(s->log_file, log_sector_size,
> -                                    le64_to_cpu(log_sb.nr_entries), &local_err);
> -            if (local_err) {
> -                ret = -EINVAL;
> -                error_propagate(errp, local_err);
> +                                    le64_to_cpu(log_sb.nr_entries), errp);
> +            if (cur_log_sector < 0) {
> +                ret = cur_log_sector;

This changes the semantics slightly. Changing the return type to int64 
may theoretically cause valid return values to be interpreted as errors. 
Since we already do have a dedicated out pointer for the error value 
(errp), why not use it?

Assigning cur_log_sector to ret looks a bit odd to me. Why not use the 
original -EINVAL - or maybe some more appropriate errno value than -EINVAL?

I think the desired effect of this change could be achieved with less 
churn. How about just making just the following change in addition to 
adding ERRP_GUARD() to the beginning of the function and getting rid of 
local_err:

-                                    le64_to_cpu(log_sb.nr_entries), 
&local_err);
+                                    le64_to_cpu(log_sb.nr_entries), errp);
-            if (local_err) {
+            if (*errp) {
                  ret = -EINVAL;
-                error_propagate(errp, local_err);
>                   goto fail_log;
>               }
>   
> +            s->cur_log_sector = cur_log_sector;
>               s->nr_entries = le64_to_cpu(log_sb.nr_entries);
>           }
>       } else {
> 

Best regards,
Ari Sundholm
ari@tuxera.com

