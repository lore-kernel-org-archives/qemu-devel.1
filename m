Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E889C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 19:21:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B1772084A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 19:21:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B1772084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52374 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1he2d3-0005jd-0u
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 15:21:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49169)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1he24J-0003Ee-UF
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 14:45:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1he24F-0007cM-F2
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 14:45:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47880)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1he23k-0006yM-8k; Thu, 20 Jun 2019 14:45:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 87F35CCFE6;
 Thu, 20 Jun 2019 18:44:35 +0000 (UTC)
Received: from [10.10.123.29] (ovpn-123-29.rdu2.redhat.com [10.10.123.29])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C801C5D71C;
 Thu, 20 Jun 2019 18:44:31 +0000 (UTC)
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20190620010356.19164-1-jsnow@redhat.com>
 <20190620010356.19164-8-jsnow@redhat.com>
 <9f5578c5-e513-d848-6f64-2e1c494e12e1@redhat.com>
From: John Snow <jsnow@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <688964da-a1d4-c9cd-ba5e-078edb59a032@redhat.com>
Date: Thu, 20 Jun 2019 14:44:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <9f5578c5-e513-d848-6f64-2e1c494e12e1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Thu, 20 Jun 2019 18:44:35 +0000 (UTC)
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
 vsementsov@virtuozzo.com, Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 6/20/19 1:00 PM, Max Reitz wrote:
> On 20.06.19 03:03, John Snow wrote:
>> This adds an "always" policy for bitmap synchronization. Regardless of=
 if
>> the job succeeds or fails, the bitmap is *always* synchronized. This m=
eans
>> that for backups that fail part-way through, the bitmap retains a reco=
rd of
>> which sectors need to be copied out to accomplish a new backup using t=
he
>> old, partial result.
>>
>> In effect, this allows us to "resume" a failed backup; however the new=
 backup
>> will be from the new point in time, so it isn't a "resume" as much as =
it is
>> an "incremental retry." This can be useful in the case of extremely la=
rge
>> backups that fail considerably through the operation and we'd like to =
not waste
>> the work that was already performed.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  qapi/block-core.json |  5 ++++-
>>  block/backup.c       | 10 ++++++----
>>  2 files changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index 0332dcaabc..58d267f1f5 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -1143,6 +1143,9 @@
>>  # An enumeration of possible behaviors for the synchronization of a b=
itmap
>>  # when used for data copy operations.
>>  #
>> +# @always: The bitmap is always synchronized with remaining blocks to=
 copy,
>> +#          whether or not the operation has completed successfully or=
 not.
>> +#
>>  # @conditional: The bitmap is only synchronized when the operation is=
 successul.
>>  #               This is useful for Incremental semantics.
>>  #
>> @@ -1153,7 +1156,7 @@
>>  # Since: 4.1
>>  ##
>>  { 'enum': 'BitmapSyncMode',
>> -  'data': ['conditional', 'never'] }
>> +  'data': ['always', 'conditional', 'never'] }
>> =20
>>  ##
>>  # @MirrorCopyMode:
>> diff --git a/block/backup.c b/block/backup.c
>> index 627f724b68..beb2078696 100644
>> --- a/block/backup.c
>> +++ b/block/backup.c
>> @@ -266,15 +266,17 @@ static void backup_cleanup_sync_bitmap(BackupBlo=
ckJob *job, int ret)
>>      BlockDriverState *bs =3D blk_bs(job->common.blk);
>> =20
>>      if (ret < 0 || job->bitmap_mode =3D=3D BITMAP_SYNC_MODE_NEVER) {
>> -        /* Failure, or we don't want to synchronize the bitmap.
>> -         * Merge the successor back into the parent, delete nothing. =
*/
>> +        /* Failure, or we don't want to synchronize the bitmap. */
>> +        if (job->bitmap_mode =3D=3D BITMAP_SYNC_MODE_ALWAYS) {
>> +            bdrv_dirty_bitmap_claim(job->sync_bitmap, &job->copy_bitm=
ap);
>=20
> Hmm...  OK, bitmaps in backup always confuse me, so bear with me, pleas=
e.
>=20

I realize this is an extremely dense section that actually covers a
*lot* of pathways.

> (Hi, I=E2=80=99m a time traveler from the end of this section and I can=
 tell you
> that everything is fine.  I was just confused.  I=E2=80=99ll still keep=
 this
> here, because it was so much work.)
>=20
> The copy_bitmap is copied from the sync_bitmap at the beginning, so the
> sync_bitmap can continue to be dirtied, but that won=E2=80=99t affect t=
he job.
> In normal incremental mode, this means that the sync point is always at
> the beginning of the job.  (Well, naturally, because that=E2=80=99s how=
 backup
> is supposed to go.)
>=20

sync_bitmap: This is used as an initial manifest for which sectors to
copy out. It is the user-provided bitmap. We actually *never* edit this
bitmap in the body of the job.

copy_bitmap: This is the manifest for which blocks remain to be copied
out. We clear bits in this as we go, because we use it as our loop
condition.

So what you say is actually only half-true: the sync_bitmap actually
remains static during the duration of the job, and it has an anonymous
child that accrues new writes. This is a holdover from before we had a
copy_bitmap, and we used to use a sync_bitmap directly as our loop
condition.

(This could be simplified upstream at present; but after this patch it
cannot be for reasons explained below. We do wish to maintain three
distinct sets of bits:
1. The bits at the start of the operation,
2. The bits accrued during the operation, and
3. The bits that remain to be, or were not, copied during the operation.)

So there's actually three bitmaps:

- sync_bitmap: actually just static and read-only
- sync_bitmap's anonymous child: accrues new writes.
- copy_bitmap: loop conditional.

> But then replacing the sync_bitmap with the copy_bitmap here means that
> all of these dirtyings that happened during the job are lost.  Hmm, but
> that doesn=E2=80=99t matter, does it?  Because whenever something was d=
irtied in
> sync_bitmap, the corresponding area must have been copied to the backup
> due to the job.
>=20

The new dirty bits were accrued very secretly in the anonymous child.
The new dirty bits are merged in via the reclaim() function.

So, what happens is:

- Sync_bitmap gets the bit pattern of copy_bitmap (one way or another)
- Sync_bitmap reclaims (merges with) its anonymous child.

> Ah, yes, it would actually be wrong to keep the new dirty bits, because
> in this mode, sync_bitmap should (on failure) reflect what is left to
> copy to make the backup complete.  Copying these newly dirtied sectors
> would be wrong.  (Yes, I know you wrote that in the documentation of
> @always.  I just tried to get a different perspective.)
>=20
> Yes, yes, and copy_bitmap is always set whenever a CBW to the target
> fails before the source can be updated.  Good, good.
>=20

You might have slightly the wrong idea; it's important to keep track of
what was dirtied during the operation because that data is important for
the next bitmap backup.

The merging of "sectors left to copy" (in the case of a failed backup)
and "sectors dirtied since we started the operation" forms the actual
minimal set needed to re-write to this target to achieve a new
functioning point in time. This is what you get with the "always" mode
in a failure case.

In a success case, it just so happens that "sectors left to copy" is the
empty set.

It's like an incremental on top of the incremental.

Consider this:

We have a 4TB drive and we have dirtied 3TB of it since our full backup.
We copy out 2TB as part of a new incremental backup before suffering
some kind of failure.

Today, you'd need to start a new incremental backup that copies that
entire 3TB *plus* whatever was dirtied since the job failed.

With this mode, you'd only need to copy the remaining 1TB + whatever was
dirtied since.

So, what this logic is really doing is:

If we failed, OR if we want the "never" sync policy:

Merge the anonymous child (bits written during op) back into sync_bitmap
(bits we were instructed to copy), leaving us as if we have never
started this operation.

If, however, we failed and we have the "always" sync policy, we destroy
the sync_bitmap (bits we were instructed to copy) and replace it with
the copy_bitmap (bits remaining to copy). Then, we merge that with the
anonymous child (bits written during op).

Or, in success cases (when sync policy is not never), we simply delete
the sync_bitmap (bits we were instructed to copy) and replace it with
its anonymous child (bits written during op).

>=20
> Hi, I=E2=80=99m the time traveler from above.  I also left the section =
here so I
> can give one of my trademark =E2=80=9CRamble, ramble,
>=20
> Reviewed-by: Max Reitz <mreitz@redhat.com>
>=20
> =E2=80=9D
>=20
>> +        }
>> +        /* Merge the successor back into the parent. */
>>          bm =3D bdrv_reclaim_dirty_bitmap(bs, job->sync_bitmap, NULL);
>> -        assert(bm);
>>      } else {
>>          /* Everything is fine, delete this bitmap and install the bac=
kup. */
>>          bm =3D bdrv_dirty_bitmap_abdicate(bs, job->sync_bitmap, NULL)=
;
>> -        assert(bm);
>>      }
>> +    assert(bm);
>>  }
>> =20
>>  static void backup_commit(Job *job)
>>
>=20
>=20

--=20
=E2=80=94js

