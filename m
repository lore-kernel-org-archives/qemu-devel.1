Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA91CC2BB84
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 16:54:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77C50221F1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 16:54:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77C50221F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxera.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIahG-0002P4-GS
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 12:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ari@tuxera.com>)
 id 1kIafi-0000dz-In; Wed, 16 Sep 2020 12:52:42 -0400
Received: from mgw-02.mpynet.fi ([82.197.21.91]:53692)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ari@tuxera.com>)
 id 1kIafe-0004zi-T4; Wed, 16 Sep 2020 12:52:41 -0400
Received: from pps.filterd (mgw-02.mpynet.fi [127.0.0.1])
 by mgw-02.mpynet.fi (8.16.0.42/8.16.0.42) with SMTP id 08GGi13E028423;
 Wed, 16 Sep 2020 19:52:02 +0300
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
 by mgw-02.mpynet.fi with ESMTP id 33k5pf12d2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2020 19:52:02 +0300
Received: from [192.168.0.79] (62.78.240.173) by tuxera-exch.ad.tuxera.com
 (10.20.48.11) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 16 Sep
 2020 19:52:02 +0300
Subject: Re: [PATCH 07/14] block/blklogwrites: drop error propagation
To: Markus Armbruster <armbru@redhat.com>
References: <20200909185930.26524-1-vsementsov@virtuozzo.com>
 <20200909185930.26524-8-vsementsov@virtuozzo.com>
 <8856cf15-4092-55b7-6537-a6beb4ce8a18@tuxera.com>
 <87k0x0g2pu.fsf@dusky.pond.sub.org>
From: Ari Sundholm <ari@tuxera.com>
Message-ID: <dd40693c-2dda-895d-f372-662b0071ee62@tuxera.com>
Date: Wed, 16 Sep 2020 19:52:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87k0x0g2pu.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [62.78.240.173]
X-ClientProxiedBy: tuxera-exch.ad.tuxera.com (10.20.48.11) To
 tuxera-exch.ad.tuxera.com (10.20.48.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-16_11:2020-09-16,
 2020-09-16 signatures=0
X-Proofpoint-Spam-Details: rule=mpy_notspam policy=mpy score=0 spamscore=0
 phishscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009160119
Received-SPF: pass client-ip=82.197.21.91; envelope-from=ari@tuxera.com;
 helo=mgw-02.mpynet.fi
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 12:52:32
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.062,
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
Cc: kwolf@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 berto@igalia.com, stefanha@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, groug@kaod.org, pavel.dovgaluk@ispras.ru,
 pbonzini@redhat.com, mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On 9/11/20 11:03 AM, Markus Armbruster wrote:
> Ari Sundholm <ari@tuxera.com> writes:
> 
>> Hi Vladimir!
>>
>> Thank you for working on this. My comments below.
>>
>> On 9/9/20 9:59 PM, Vladimir Sementsov-Ogievskiy wrote:
>>> It's simple to avoid error propagation in blk_log_writes_open(), we
>>> just need to refactor blk_log_writes_find_cur_log_sector() a bit.
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy
>>> <vsementsov@virtuozzo.com>
>>> ---
>>>    block/blklogwrites.c | 23 +++++++++++------------
>>>    1 file changed, 11 insertions(+), 12 deletions(-)
>>> diff --git a/block/blklogwrites.c b/block/blklogwrites.c
>>> index 7ef046cee9..c7da507b2d 100644
>>> --- a/block/blklogwrites.c
>>> +++ b/block/blklogwrites.c
>>> @@ -96,10 +96,10 @@ static inline bool blk_log_writes_sector_size_valid(uint32_t sector_size)
>>>            sector_size < (1ull << 24);
>>>    }
>>>    -static uint64_t blk_log_writes_find_cur_log_sector(BdrvChild
>>> *log,
>>> -                                                   uint32_t sector_size,
>>> -                                                   uint64_t nr_entries,
>>> -                                                   Error **errp)
>>> +static int64_t blk_log_writes_find_cur_log_sector(BdrvChild *log,
>>
>> I'd rather not change the return type for reasons detailed below.
>>
>>> +                                                  uint32_t sector_size,
>>> +                                                  uint64_t nr_entries,
>>> +                                                  Error **errp)
>>>    {
>>>        uint64_t cur_sector = 1;
>>>        uint64_t cur_idx = 0;
>>> @@ -112,13 +112,13 @@ static uint64_t blk_log_writes_find_cur_log_sector(BdrvChild *log,
>>>            if (read_ret < 0) {
>>>                error_setg_errno(errp, -read_ret,
>>>                                 "Failed to read log entry %"PRIu64, cur_idx);
>>> -            return (uint64_t)-1ull;
>>> +            return read_ret;
>>
>> This is OK, provided the change in return type signedness is necessary
>> in the first place.
>>
>>>            }
>>>              if (cur_entry.flags & ~cpu_to_le64(LOG_FLAG_MASK)) {
>>>                error_setg(errp, "Invalid flags 0x%"PRIx64" in log entry %"PRIu64,
>>>                           le64_to_cpu(cur_entry.flags), cur_idx);
>>> -            return (uint64_t)-1ull;
>>> +            return -EINVAL;
>>
>> This is OK, provided the return type signedness change is necessary,
>> although we already do have errp to indicate any errors.
>>
>>>            }
>>>              /* Account for the sector of the entry itself */
>>> @@ -143,7 +143,6 @@ static int blk_log_writes_open(BlockDriverState *bs, QDict *options, int flags,
>>>    {
>>>        BDRVBlkLogWritesState *s = bs->opaque;
>>>        QemuOpts *opts;
>>> -    Error *local_err = NULL;
>>>        int ret;
>>>        uint64_t log_sector_size;
>>>        bool log_append;
>>> @@ -215,15 +214,15 @@ static int blk_log_writes_open(BlockDriverState *bs, QDict *options, int flags,
>>>            s->nr_entries = 0;
>>>              if (blk_log_writes_sector_size_valid(log_sector_size)) {
>>> -            s->cur_log_sector =
>>> +            int64_t cur_log_sector =
>>>                    blk_log_writes_find_cur_log_sector(s->log_file, log_sector_size,
>>> -                                    le64_to_cpu(log_sb.nr_entries), &local_err);
>>> -            if (local_err) {
>>> -                ret = -EINVAL;
>>> -                error_propagate(errp, local_err);
>>> +                                    le64_to_cpu(log_sb.nr_entries), errp);
>>> +            if (cur_log_sector < 0) {
>>> +                ret = cur_log_sector;
>>
>> This changes the semantics slightly. Changing the return type to int64
>> may theoretically cause valid return values to be interpreted as
>> errors. Since we already do have a dedicated out pointer for the error
>> value (errp), why not use it?
> 
> Error.h's big comment:
> 
>   * Error reporting system loosely patterned after Glib's GError.
>   *
>   * = Rules =
>   [...]
>   * - Whenever practical, also return a value that indicates success /
>   *   failure.  This can make the error checking more concise, and can
>   *   avoid useless error object creation and destruction.  Note that
>   *   we still have many functions returning void.  We recommend
>   *   • bool-valued functions return true on success / false on failure,
>   *   • pointer-valued functions return non-null / null pointer, and
>   *   • integer-valued functions return non-negative / negative.
> 
> blk_log_writes_find_cur_log_sector() does return such an error value
> before the patch: (uint64_t)-1.
> 
> The caller does not use it to check for errors.  It uses @err instead.
> Awkward, has to error_propagate().
> 
> Avoiding error_propagate() reduces the error handling boileplate.  It
> also improves behavior when @errp is &error_abort: we get the abort
> right where the error happens instead of where we propagate it.
> 
> Furthermore, caller has to make an error code (-EINVAL), because
> returning (uint64_t)-1 throws it away.  Yes, a detailed error is stored
> into @err, but you can't cleanly extract the error code.
> 
> Using a signed integer for returning "non-negative offset or negative
> errno code" is pervasive, starting with read() and write().  It hasn't
> been a problem there, and it hasn't been a problem in the block layer.
> 8 exbi-blocks should do for a while.  Should it become troublesome, we
> won't solve the problem by going unsigned and adding one bit, we'll
> double the width and add 64.
> 

I am in complete agreement with eliminating error propagation within the 
blklogwrites driver. This was never a point of disagreement.

As error propagation is dropped in this patch, the awkwardness referred 
to above will be no more, making that a moot point.

My main issue was that this patch does more than just the mechanical 
transformation required. Changes that are not strictly necessary are 
made, and they slightly change the semantics while duplicating the error 
code and halving the range of the return type (instead of just returning 
*some* value in the absence of a possibility to return nothing, which 
will be thrown away by the caller anyway when an error has occurred).

However, as the consensus seems to be that it is best to change the 
return type to int64_t for consistency with the rest of the codebase, I 
will not object any further regarding that point. Having conceded that, 
this makes the difference between my preferred minimalistic approach and 
this patch insignificant, and it is not my intention to needlessly 
obstruct a perfectly fine patch series.

BTW, I do not think it would be difficult at all to extend the code in 
error.h to make it convenient to extract errno and/or win32 error values 
that have been explicitly provided, but this is a matter best discussed 
separately and left for a later patch.

As for general matters regarding error handling and separation between 
results and errors, I am open to discussing these off-list.

Best regards,
Ari Sundholm
ari@tuxera.com

> Additional rationale for returning recognizable error values:
> 
> commit e3fe3988d7851cac30abffae06d2f555ff7bee62
> Author: Markus Armbruster <armbru@redhat.com>
> Date:   Tue Jul 7 18:05:31 2020 +0200
> 
>      error: Document Error API usage rules
>      
>      This merely codifies existing practice, with one exception: the rule
>      advising against returning void, where existing practice is mixed.
>      
>      When the Error API was created, we adopted the (unwritten) rule to
>      return void when the function returns no useful value on success,
>      unlike GError, which recommends to return true on success and false on
>      error then.
>      
>      When a function returns a distinct error value, say false, a checked
>      call that passes the error up looks like
>      
>          if (!frobnicate(..., errp)) {
>              handle the error...
>          }
>      
>      When it returns void, we need
>      
>          Error *err = NULL;
>      
>          frobnicate(..., &err);
>          if (err) {
>              handle the error...
>              error_propagate(errp, err);
>          }
>      
>      Not only is this more verbose, it also creates an Error object even
>      when @errp is null, &error_abort or &error_fatal.
>      
>      People got tired of the additional boilerplate, and started to ignore
>      the unwritten rule.  The result is confusion among developers about
>      the preferred usage.
>      
>      Make the rule advising against returning void official by putting it
>      in writing.  This will hopefully reduce confusion.
>      [...]
> 
> Additional rationale for avoiding error_propagate():
> 
> commit ae7c80a7bd73685437bf6ba9d7c26098351f4166
> Author: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Date:   Tue Jul 7 18:50:30 2020 +0200
> 
>      error: New macro ERRP_GUARD()
>      
>      Introduce a new ERRP_GUARD() macro, to be used at start of functions
>      with an errp OUT parameter.
>      
>      It has three goals:
>      
>      1. Fix issue with error_fatal and error_prepend/error_append_hint: the
>      user can't see this additional information, because exit() happens in
>      error_setg earlier than information is added. [Reported by Greg Kurz]
>      
>      2. Fix issue with error_abort and error_propagate: when we wrap
>      error_abort by local_err+error_propagate, the resulting coredump will
>      refer to error_propagate and not to the place where error happened.
>      (the macro itself doesn't fix the issue, but it allows us to [3.] drop
>      the local_err+error_propagate pattern, which will definitely fix the
>      issue) [Reported by Kevin Wolf]
>      
>      3. Drop local_err+error_propagate pattern, which is used to workaround
>      void functions with errp parameter, when caller wants to know resulting
>      status. (Note: actually these functions could be merely updated to
>      return int error code).
>      [...]
> 
>> Assigning cur_log_sector to ret looks a bit odd to me. Why not use the
>> original -EINVAL - or maybe some more appropriate errno value than
>> -EINVAL?
> 
> We assign the error code returned by
> blk_log_writes_find_cur_log_sector(), which seems proper to me.
> 
> Care to suggest a better variable name?
> 
>> I think the desired effect of this change could be achieved with less
>> churn. How about just making just the following change in addition to
>> adding ERRP_GUARD() to the beginning of the function and getting rid
>> of local_err:
>>
>> -                                    le64_to_cpu(log_sb.nr_entries),
>>                                       &local_err);
>> +                                    le64_to_cpu(log_sb.nr_entries), errp);
>> -            if (local_err) {
>> +            if (*errp) {
>>                   ret = -EINVAL;
>> -                error_propagate(errp, local_err);
>>>                    goto fail_log;
>>>                }
>>>    +            s->cur_log_sector = cur_log_sector;
>>>                s->nr_entries = le64_to_cpu(log_sb.nr_entries);
>>>            }
>>>        } else {
> 
> I prefer this patch.  But it's up to the block maintainers.
> 


