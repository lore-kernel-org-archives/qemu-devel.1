Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58635C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 13:40:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CD58206A2
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 13:40:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CD58206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsopj-0007P4-7J
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 09:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52869)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hsopF-0006sy-S8
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 09:39:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hsopE-0000bJ-9u
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 09:39:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:24401)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hsop9-0000Zz-Fx; Wed, 31 Jul 2019 09:39:24 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 200AF308FC4E;
 Wed, 31 Jul 2019 13:39:22 +0000 (UTC)
Received: from [10.10.123.215] (ovpn-123-215.rdu2.redhat.com [10.10.123.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F1C2960BEC;
 Wed, 31 Jul 2019 13:39:20 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190724094025.12442-1-vsementsov@virtuozzo.com>
 <1977e825-0a1f-e575-2ffa-0ea8c65531bb@redhat.com>
 <d8138170-aecd-dbab-3576-3b2e9d458cd5@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <bbbf5f82-f2df-2c69-564f-77d0e759049c@redhat.com>
Date: Wed, 31 Jul 2019 09:39:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d8138170-aecd-dbab-3576-3b2e9d458cd5@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Wed, 31 Jul 2019 13:39:22 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3] blockjob: drain all job nodes in
 block_job_drain
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 7/31/19 6:28 AM, Vladimir Sementsov-Ogievskiy wrote:
> 30.07.2019 22:11, John Snow wrote:
>>
>>
>> On 7/24/19 5:40 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> Instead of draining additional nodes in each job code, let's do it in
>>> common block_job_drain, draining just all job's children.
>>> BlockJobDriver.drain becomes unused, so, drop it at all.
>>>
>>> It's also a first step to finally get rid of blockjob->blk.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>>
>>> v3: just resend, as I've some auto returned mails and not sure that
>>>      v2 reached recipients.
>>>
>>> v2: apply Max's suggestions:
>>>   - drop BlockJobDriver.drain
>>>   - do firtly loop of bdrv_drained_begin and then separate loop
>>>     of bdrv_drained_end.
>>>
>>>     Hmm, a question here: should I call bdrv_drained_end in reverse
>>>     order? Or it's OK as is?
>>>
>>
>> I think it should be OK. These nodes don't necessarily have a well
>> defined relationship between each other, do they?
>>
>>>   include/block/blockjob_int.h | 11 -----------
>>>   block/backup.c               | 18 +-----------------
>>>   block/mirror.c               | 26 +++-----------------------
>>>   blockjob.c                   | 13 ++++++++-----
>>>   4 files changed, 12 insertions(+), 56 deletions(-)
>>>
>>
>> Nice diffstat :)
>>
>>> diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
>>> index e4a318dd15..e1abf4ee85 100644
>>> --- a/include/block/blockjob_int.h
>>> +++ b/include/block/blockjob_int.h
>>> @@ -52,17 +52,6 @@ struct BlockJobDriver {
>>>        * besides job->blk to the new AioContext.
>>>        */
>>>       void (*attached_aio_context)(BlockJob *job, AioContext *new_context);
>>> -
>>> -    /*
>>> -     * If the callback is not NULL, it will be invoked when the job has to be
>>> -     * synchronously cancelled or completed; it should drain BlockDriverStates
>>> -     * as required to ensure progress.
>>> -     *
>>> -     * Block jobs must use the default implementation for job_driver.drain,
>>> -     * which will in turn call this callback after doing generic block job
>>> -     * stuff.
>>> -     */
>>> -    void (*drain)(BlockJob *job);
>>
>> I was about to say "huh?" ... but then realized you're deleting this
>> confusing glob. Good.
>>
>>>   };
>>>   
>>>   /**
>>> diff --git a/block/backup.c b/block/backup.c
>>> index 715e1d3be8..7930004bbd 100644
>>> --- a/block/backup.c
>>> +++ b/block/backup.c
>>> @@ -320,21 +320,6 @@ void backup_do_checkpoint(BlockJob *job, Error **errp)
>>>       hbitmap_set(backup_job->copy_bitmap, 0, backup_job->len);
>>>   }
>>>   
>>> -static void backup_drain(BlockJob *job)
>>> -{
>>> -    BackupBlockJob *s = container_of(job, BackupBlockJob, common);
>>> -
>>> -    /* Need to keep a reference in case blk_drain triggers execution
>>> -     * of backup_complete...
>>> -     */
>>> -    if (s->target) {
>>> -        BlockBackend *target = s->target;
>>> -        blk_ref(target);
>>> -        blk_drain(target);
>>> -        blk_unref(target);
>>> -    }
>>> -}
>>> -
>>
>> Adios ...
>>
>>>   static BlockErrorAction backup_error_action(BackupBlockJob *job,
>>>                                               bool read, int error)
>>>   {
>>> @@ -493,8 +478,7 @@ static const BlockJobDriver backup_job_driver = {
>>>           .commit                 = backup_commit,
>>>           .abort                  = backup_abort,
>>>           .clean                  = backup_clean,
>>> -    },
>>> -    .drain                  = backup_drain,
>>> +    }
>>>   };
>>>   
>>
>> This pleases the eyes.
>>
>>>   static int64_t backup_calculate_cluster_size(BlockDriverState *target,
>>> diff --git a/block/mirror.c b/block/mirror.c
>>> index 8cb75fb409..8456ccd89d 100644
>>> --- a/block/mirror.c
>>> +++ b/block/mirror.c
>>> @@ -644,14 +644,11 @@ static int mirror_exit_common(Job *job)
>>>       bdrv_ref(mirror_top_bs);
>>>       bdrv_ref(target_bs);
>>>   
>>> -    /* Remove target parent that still uses BLK_PERM_WRITE/RESIZE before
>>> +    /*
>>> +     * Remove target parent that still uses BLK_PERM_WRITE/RESIZE before
>>
>> (Thanks, patchew...)
>>
>>>        * inserting target_bs at s->to_replace, where we might not be able to get
>>>        * these permissions.
>>> -     *
>>> -     * Note that blk_unref() alone doesn't necessarily drop permissions because
>>> -     * we might be running nested inside mirror_drain(), which takes an extra
>>> -     * reference, so use an explicit blk_set_perm() first. */
>>> -    blk_set_perm(s->target, 0, BLK_PERM_ALL, &error_abort);
>>> +     */
>>>       blk_unref(s->target);
>>>       s->target = NULL;
>>>   
>>> @@ -1143,21 +1140,6 @@ static bool mirror_drained_poll(BlockJob *job)
>>>       return !!s->in_flight;
>>>   }
>>>   
>>> -static void mirror_drain(BlockJob *job)
>>> -{
>>> -    MirrorBlockJob *s = container_of(job, MirrorBlockJob, common);
>>> -
>>> -    /* Need to keep a reference in case blk_drain triggers execution
>>> -     * of mirror_complete...
>>> -     */
>>> -    if (s->target) {
>>> -        BlockBackend *target = s->target;
>>> -        blk_ref(target);
>>> -        blk_drain(target);
>>> -        blk_unref(target);
>>> -    }
>>> -}
>>> -
>>>   static const BlockJobDriver mirror_job_driver = {
>>>       .job_driver = {
>>>           .instance_size          = sizeof(MirrorBlockJob),
>>> @@ -1172,7 +1154,6 @@ static const BlockJobDriver mirror_job_driver = {
>>>           .complete               = mirror_complete,
>>>       },
>>>       .drained_poll           = mirror_drained_poll,
>>> -    .drain                  = mirror_drain,
>>>   };
>>>   
>>>   static const BlockJobDriver commit_active_job_driver = {
>>> @@ -1189,7 +1170,6 @@ static const BlockJobDriver commit_active_job_driver = {
>>>           .complete               = mirror_complete,
>>>       },
>>>       .drained_poll           = mirror_drained_poll,
>>> -    .drain                  = mirror_drain,
>>>   };
>>>   
>>>   static void coroutine_fn
>>> diff --git a/blockjob.c b/blockjob.c
>>> index 20b7f557da..78cf71d6c8 100644
>>> --- a/blockjob.c
>>> +++ b/blockjob.c
>>> @@ -92,12 +92,15 @@ void block_job_free(Job *job)
>>>   void block_job_drain(Job *job)
>>>   {
>>>       BlockJob *bjob = container_of(job, BlockJob, job);
>>> -    const JobDriver *drv = job->driver;
>>> -    BlockJobDriver *bjdrv = container_of(drv, BlockJobDriver, job_driver);
>>> +    GSList *l;
>>>   
>>> -    blk_drain(bjob->blk);
>>> -    if (bjdrv->drain) {
>>> -        bjdrv->drain(bjob);
>>> +    for (l = bjob->nodes; l; l = l->next) {
>>> +        BdrvChild *c = l->data;
>>> +        bdrv_drained_begin(c->bs);
>>> +    }
>>> +    for (l = bjob->nodes; l; l = l->next) {
>>> +        BdrvChild *c = l->data;
>>> +        bdrv_drained_end(c->bs);
>>>       }
>>>   }
>>>   
>>>
>>
>> Seems much nicer to me. What becomes of the ref/unref pairs?
>>
>> I guess not needed anymore?, since job cleanup necessarily happens in
>> the main loop context now and we don't have a backup_complete function
>> anymore ...?
> 
> What pairs do you mean?

blk_ref / blk_unref in the backup and mirror specific drain paths.

> 
>>
>> In the cases where auto_finalize=true, do we have any guarantee that the
>> completion callbacks cannot be scheduled while we are here?
>>
> 
> Hmm, not simple for me to assume.. Is it a problem? And is it about this patch?
> 


