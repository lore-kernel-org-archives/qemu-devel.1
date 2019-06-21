Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4565BC43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 20:59:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A50C206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 20:59:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A50C206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37826 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heQdP-00078T-G2
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 16:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39803)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1heQbw-0006OW-3Q
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 16:58:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1heQbt-0003X0-Br
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 16:58:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59190)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1heQbo-0003Rm-MI; Fri, 21 Jun 2019 16:58:08 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C12EB3091786;
 Fri, 21 Jun 2019 20:58:07 +0000 (UTC)
Received: from [10.18.17.164] (dhcp-17-164.bos.redhat.com [10.18.17.164])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DE2BF5B689;
 Fri, 21 Jun 2019 20:58:01 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190620010356.19164-1-jsnow@redhat.com>
 <20190620010356.19164-8-jsnow@redhat.com>
 <8fde15e1-9693-9e46-b5c8-0f657b1eebed@virtuozzo.com>
 <0eba7f8d-d1ed-fd4d-c417-346083cbed9c@virtuozzo.com>
 <05fd79a3-1828-f65b-118a-952aef26642a@virtuozzo.com>
 <460b3bf5-23e6-15f5-eb9e-1451ef246af9@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <341981f8-9900-2349-023c-ab9b6cf0e6c1@redhat.com>
Date: Fri, 21 Jun 2019 16:58:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <460b3bf5-23e6-15f5-eb9e-1451ef246af9@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 21 Jun 2019 20:58:07 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 07/12] block/backup: add 'always' bitmap
 sync policy
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 6/21/19 9:44 AM, Vladimir Sementsov-Ogievskiy wrote:
> 21.06.2019 16:08, Vladimir Sementsov-Ogievskiy wrote:
>> 21.06.2019 15:59, Vladimir Sementsov-Ogievskiy wrote:
>>> 21.06.2019 15:57, Vladimir Sementsov-Ogievskiy wrote:

^ Home Run!

I'm going to reply to all four of these mails at once below, I'm sorry
for the words but I want to make sure I am being clear in my intent.

>>>> 20.06.2019 4:03, John Snow wrote:
>>>>> This adds an "always" policy for bitmap synchronization. Regardless=
 of if
>>>>> the job succeeds or fails, the bitmap is *always* synchronized. Thi=
s means
>>>>> that for backups that fail part-way through, the bitmap retains a r=
ecord of
>>>>> which sectors need to be copied out to accomplish a new backup usin=
g the
>>>>> old, partial result.
>>>>>
>>>>> In effect, this allows us to "resume" a failed backup; however the =
new backup
>>>>> will be from the new point in time, so it isn't a "resume" as much =
as it is
>>>>> an "incremental retry." This can be useful in the case of extremely=
 large
>>>>> backups that fail considerably through the operation and we'd like =
to not waste
>>>>> the work that was already performed.
>>>>>
>>>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>>>> ---
>>>>> =C2=A0 qapi/block-core.json |=C2=A0 5 ++++-
>>>>> =C2=A0 block/backup.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 ++++=
++----
>>>>> =C2=A0 2 files changed, 10 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>>>> index 0332dcaabc..58d267f1f5 100644
>>>>> --- a/qapi/block-core.json
>>>>> +++ b/qapi/block-core.json
>>>>> @@ -1143,6 +1143,9 @@
>>>>> =C2=A0 # An enumeration of possible behaviors for the synchronizati=
on of a bitmap
>>>>> =C2=A0 # when used for data copy operations.
>>>>> =C2=A0 #
>>>>> +# @always: The bitmap is always synchronized with remaining blocks=
 to copy,
>>>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 whether or=
 not the operation has completed successfully or not.
>>>>
>>>> Hmm, now I think that 'always' sounds a bit like 'really always' i.e=
. during backup
>>>> too, which is confusing.. But I don't have better suggestion.
>>>>

I could probably clarify to say "at the conclusion of the operation",
but we should also keep in mind that bitmaps tied to an operation can't
be used during that timeframe anyway.

>>>>> +#
>>>>> =C2=A0 # @conditional: The bitmap is only synchronized when the ope=
ration is successul.
>>>>> =C2=A0 #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 This is useful for Incremental semantics.
>>>>> =C2=A0 #
>>>>> @@ -1153,7 +1156,7 @@
>>>>> =C2=A0 # Since: 4.1
>>>>> =C2=A0 ##
>>>>> =C2=A0 { 'enum': 'BitmapSyncMode',
>>>>> -=C2=A0 'data': ['conditional', 'never'] }
>>>>> +=C2=A0 'data': ['always', 'conditional', 'never'] }
>>>>> =C2=A0 ##
>>>>> =C2=A0 # @MirrorCopyMode:
>>>>> diff --git a/block/backup.c b/block/backup.c
>>>>> index 627f724b68..beb2078696 100644
>>>>> --- a/block/backup.c
>>>>> +++ b/block/backup.c
>>>>> @@ -266,15 +266,17 @@ static void backup_cleanup_sync_bitmap(Backup=
BlockJob *job, int ret)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockDriverState *bs =3D blk_bs(job-=
>common.blk);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0 || job->bitmap_mode =3D=3D=
 BITMAP_SYNC_MODE_NEVER) {
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Failure, or we don't=
 want to synchronize the bitmap.
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Merge the succe=
ssor back into the parent, delete nothing. */
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Failure, or we don't=
 want to synchronize the bitmap. */
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (job->bitmap_mode =3D=
=3D BITMAP_SYNC_MODE_ALWAYS) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 bdrv_dirty_bitmap_claim(job->sync_bitmap, &job->copy_bitmap);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Merge the successor =
back into the parent. */
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bm =3D bdrv_=
reclaim_dirty_bitmap(bs, job->sync_bitmap, NULL);
>>>>
>>>> Hmm good, it should work. It's a lot more tricky, than just
>>>> "synchronized with remaining blocks to copy", but I'm not sure the w=
e need more details in
>>>> spec.
>>>>

Right, it's complicated because backups involve two points in time; the
start and finish of the operation. The actual technical truth of what
happens is hard to phrase succinctly.

It was difficult to phrase for even the normal Incremental/conditional
mode that we have.

I can't help but feel I need to write a blog post that has some good
diagrams that can be used to explain the concept clearly.

>>>> What we have in backup? So, from one hand we have an incremental bac=
kup, and a bitmap, counting from it.
>>>> On the other hand it's not normal incremental backup, as it don't co=
rrespond to any valid state of vm disk,
>>>> and it may be used only as a backing in a chain of further successfu=
l incremental backup, yes?
>>>>

You can also continue writing directly into it, which is likely the
smarter choice because it saves you the trouble of doing an intermediate
block commit later, and then you don't keep any image files that are
"meaningless" by themselves.

However, yes, iotest 257 uses them as backing images.

>>>> And then I think: with this mode we can not stop on first error, but=
 ignore it, just leaving dirty bit for
>>>> resulting bitmap.. We have BLOCKDEV_ON_ERROR_IGNORE, which may be us=
ed to achieve it, but seems it don't
>>>> work as expected, as in backup_loop() we retry operation if ret < 0 =
and=C2=A0 action !=3D BLOCK_ERROR_ACTION_REPORT.
>>>>

This strikes me as a good idea, but I wonder: if we retry already for
'ignore', it seems likely that transient network errors likely recover
on their own as a result already. Are there cases where we really want
the job to move forward, because we expect certain sectors will never
copy correctly, like reading from unreliable media? Are those cases ones
we expect to be able to fix later?

(Actually, what happens if we ignore errors and we get stuck on a
sector? How many times do we retry this before we give up and admit that
it's actually an error we can't ignore?)

The use cases aren't clear to me right away, but it's worth looking into
because it sounds like it could be useful. I think that should not be
part of this series, however.

>>>> And another thought: can user take a decision of discarding (like CO=
NDITIONAL) or saving in backing chain (like
>>>> ALWAYS) failed backup result _after_ backup job complete? For exampl=
e, for small resulting backup it may be
>>>> better to discard it and for large - to save.

That seems complicated, because you need to keep the bitmap split into
its component subsets (original, copy manifest, and writes since start)
all the way until AFTER the job, which means more bitmap management
commands that need to be issued after the job is done.

Which means the job would move the bitmap into yet another new state
where it is "busy" and cannot be used, but is awaiting some kind of
rollover command from the user.

However, you could also just use our 'merge' support to make a copy of
the bitmap before you begin and use the 'always' sync mode, then if you
decide it's not worth restarting after the fact, you can just delete the
copy.

>>>> Will it work if we start job with ALWAYS mode and autocomplete =3D f=
alse, then on fail we can look at job progress,
>>>> and if it is small we cancel job, otherwise call complete? Or stop, =
block-job-complete will not work with failure
>>>> scenarios? Then we have to set BLOCKDEV_ON_ERROR_IGNORE, and on firs=
t error event decide, cancel or not? But we
>>>> can only cancel or continue..
>>>>
>>>> Hmm. Cancel. So on cancel and abort you synchronize bitmap too? Seem=
s in bad relation with what cancel should do,
>>>> and in transactions in general...
>>>
>>> I mean grouped transaction mode, how should it work with this?
>>
>> Actual the problem is that you want to implement partial success, and =
block jobs api and transactions api are not prepared
>> for such thing

I wouldn't call it partial success, but rather a "failure with detailed
error log" -- but I concede I am playing games with terminology.

The operation failed, but the bitmap can be considered a record of
exactly which bitmap regions didn't succeed in being copied.

You're right, though; the regions that got cleared could be considered a
record of partial success; but I think I might resist the idea of
wanting to formalize that in a new API. I think it's easier to
conceptualize it as a recoverable failure, and the bitmap behaves as the
resume/recovery data.

>=20
>=20
> Should it be OK if we just:
>=20
> 1. restrict using ALWAYS together with grouped transaction mode, so we =
don't need to deal with other job failures.
> 2. don't claim but only reclaim on cancel even in ALWAYS mode, to make =
cancel roll-back all things
>=20
> ?
>=20
>=20

> "grouped transaction mode, how should it work with this?"

With or without the grouped completion mode, it does the same thing: it
ALWAYS synchronizes!

Yes, that means that:

1. In the case of user cancellation, it still saves partial work.
2. In the case of an induced cancellation from a peer job, it saves
partial work.

I think this behavior is correct because grouped completion mode does
not actually guarantee that jobs that are already running clean up
completely as if they were never launched; that is, we cannot undo the
fact that we DID copy data out to a target. Therefore, because we
factually DID perform some work, this mode simply preserves a record of
what DID occur, in the case that the client prefers to salvage partial
work instead of restarting from scratch.

Just because we launched this as part of a transaction, in other words,
does not seem like a good case for negating the intention of the user to
be able to resume from failures if they occur.

I realize this seems like a strange usage of a transaction -- because
state from the transaction can escape a failed transaction -- but real
database systems in practice do allow the ability to do partial unwinds
to minimize the amount of work that needs to be redone. I don't think
this is too surprising -- and it happens ONLY when the user specifically
requests it, so I believe this is safe behavior.

I do agree that it *probably* doesn't make sense to use these together
-- it will work just fine, but why would you be okay with one type of
partial completion when you're not ok with another? I don't understand
why you'd ask for it, but I think it will do exactly what you ask for.
It's actually less code to just let it work like this.


> "So on cancel and abort you synchronize bitmap too?"

I will concede that this means that if you ask for a bitmap backup with
the 'always' policy and, for whatever reason change your mind about
this, there's no way to "cancel" the job in a manner that does not edit
the bitmap at this point.

I do agree that this seems to go against the wishes of the user, because
we have different "kinds" of cancellations:

A) Cancellations that actually represent failures in transactions
B) Cancellations that represent genuine user intention

It might be nice to allow the user to say "No wait, please don't edit
that bitmap, I made a mistake!"

In these cases, how about a slight overloading of the "forced" user
cancellation? For mirror, a "forced" cancel means "Please don't try to
sync the mirror, just exit immediately." whereas an unforced cancel
means "Please complete!"

For backup, it could mean something similar:

force: "Please exit immediately, don't even sync the bitmap!"
!force: "Exit, but proceed with normal cleanup."

This would mean that in the grouped completion failure case, we actually
still sync the bitmap, but if the user sends a forced-cancel, they can
actually abort the entire transaction.

Actually, that needs just a minor edit:

job.c:746:

job_cancel_async(other_job, false);

should become:

job_cancel_async(other_job, job->force_cancel)


And then the bitmap cleanup code can check for this condition to avoid
synchronizing the bitmap in these cases.

