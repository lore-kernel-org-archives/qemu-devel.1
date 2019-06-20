Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D281DC43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 19:47:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B778206BA
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 19:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B778206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52538 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1he31x-00044w-77
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 15:47:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51233)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1he2Bp-0006mI-OC
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 14:53:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1he2Bn-0005sr-Oh
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 14:53:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56804)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1he2Bh-0005pQ-MZ; Thu, 20 Jun 2019 14:53:35 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B82AC308623C;
 Thu, 20 Jun 2019 18:53:32 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 27F7619C77;
 Thu, 20 Jun 2019 18:53:27 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20190620010356.19164-1-jsnow@redhat.com>
 <20190620010356.19164-8-jsnow@redhat.com>
 <9f5578c5-e513-d848-6f64-2e1c494e12e1@redhat.com>
 <688964da-a1d4-c9cd-ba5e-078edb59a032@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <13f560b2-4d20-40c0-9679-e4a564756132@redhat.com>
Date: Thu, 20 Jun 2019 20:53:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <688964da-a1d4-c9cd-ba5e-078edb59a032@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="t3xzUjSc0sxgNxdBuq87ebL7YXOFxEhnQ"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Thu, 20 Jun 2019 18:53:32 +0000 (UTC)
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--t3xzUjSc0sxgNxdBuq87ebL7YXOFxEhnQ
Content-Type: multipart/mixed; boundary="qHel6A7Eb95Yz8eHaWA7soswhYK6XFJQp";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 eblake@redhat.com, vsementsov@virtuozzo.com,
 Markus Armbruster <armbru@redhat.com>, Fam Zheng <fam@euphon.net>,
 Xie Changlong <xiechanglong.d@gmail.com>
Message-ID: <13f560b2-4d20-40c0-9679-e4a564756132@redhat.com>
Subject: Re: [PATCH 07/12] block/backup: add 'always' bitmap sync policy
References: <20190620010356.19164-1-jsnow@redhat.com>
 <20190620010356.19164-8-jsnow@redhat.com>
 <9f5578c5-e513-d848-6f64-2e1c494e12e1@redhat.com>
 <688964da-a1d4-c9cd-ba5e-078edb59a032@redhat.com>
In-Reply-To: <688964da-a1d4-c9cd-ba5e-078edb59a032@redhat.com>

--qHel6A7Eb95Yz8eHaWA7soswhYK6XFJQp
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 20.06.19 20:44, John Snow wrote:
>=20
>=20
> On 6/20/19 1:00 PM, Max Reitz wrote:
>> On 20.06.19 03:03, John Snow wrote:
>>> This adds an "always" policy for bitmap synchronization. Regardless o=
f if
>>> the job succeeds or fails, the bitmap is *always* synchronized. This =
means
>>> that for backups that fail part-way through, the bitmap retains a rec=
ord of
>>> which sectors need to be copied out to accomplish a new backup using =
the
>>> old, partial result.
>>>
>>> In effect, this allows us to "resume" a failed backup; however the ne=
w backup
>>> will be from the new point in time, so it isn't a "resume" as much as=
 it is
>>> an "incremental retry." This can be useful in the case of extremely l=
arge
>>> backups that fail considerably through the operation and we'd like to=
 not waste
>>> the work that was already performed.
>>>
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> ---
>>>  qapi/block-core.json |  5 ++++-
>>>  block/backup.c       | 10 ++++++----
>>>  2 files changed, 10 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>> index 0332dcaabc..58d267f1f5 100644
>>> --- a/qapi/block-core.json
>>> +++ b/qapi/block-core.json
>>> @@ -1143,6 +1143,9 @@
>>>  # An enumeration of possible behaviors for the synchronization of a =
bitmap
>>>  # when used for data copy operations.
>>>  #
>>> +# @always: The bitmap is always synchronized with remaining blocks t=
o copy,
>>> +#          whether or not the operation has completed successfully o=
r not.
>>> +#
>>>  # @conditional: The bitmap is only synchronized when the operation i=
s successul.
>>>  #               This is useful for Incremental semantics.
>>>  #
>>> @@ -1153,7 +1156,7 @@
>>>  # Since: 4.1
>>>  ##
>>>  { 'enum': 'BitmapSyncMode',
>>> -  'data': ['conditional', 'never'] }
>>> +  'data': ['always', 'conditional', 'never'] }
>>> =20
>>>  ##
>>>  # @MirrorCopyMode:
>>> diff --git a/block/backup.c b/block/backup.c
>>> index 627f724b68..beb2078696 100644
>>> --- a/block/backup.c
>>> +++ b/block/backup.c
>>> @@ -266,15 +266,17 @@ static void backup_cleanup_sync_bitmap(BackupBl=
ockJob *job, int ret)
>>>      BlockDriverState *bs =3D blk_bs(job->common.blk);
>>> =20
>>>      if (ret < 0 || job->bitmap_mode =3D=3D BITMAP_SYNC_MODE_NEVER) {=

>>> -        /* Failure, or we don't want to synchronize the bitmap.
>>> -         * Merge the successor back into the parent, delete nothing.=
 */
>>> +        /* Failure, or we don't want to synchronize the bitmap. */
>>> +        if (job->bitmap_mode =3D=3D BITMAP_SYNC_MODE_ALWAYS) {
>>> +            bdrv_dirty_bitmap_claim(job->sync_bitmap, &job->copy_bit=
map);
>>
>> Hmm...  OK, bitmaps in backup always confuse me, so bear with me, plea=
se.
>>
>=20
> I realize this is an extremely dense section that actually covers a
> *lot* of pathways.
>=20
>> (Hi, I=E2=80=99m a time traveler from the end of this section and I ca=
n tell you
>> that everything is fine.  I was just confused.  I=E2=80=99ll still kee=
p this
>> here, because it was so much work.)
>>
>> The copy_bitmap is copied from the sync_bitmap at the beginning, so th=
e
>> sync_bitmap can continue to be dirtied, but that won=E2=80=99t affect =
the job.
>> In normal incremental mode, this means that the sync point is always a=
t
>> the beginning of the job.  (Well, naturally, because that=E2=80=99s ho=
w backup
>> is supposed to go.)
>>
>=20
> sync_bitmap: This is used as an initial manifest for which sectors to
> copy out. It is the user-provided bitmap. We actually *never* edit this=

> bitmap in the body of the job.
>=20
> copy_bitmap: This is the manifest for which blocks remain to be copied
> out. We clear bits in this as we go, because we use it as our loop
> condition.
>=20
> So what you say is actually only half-true: the sync_bitmap actually
> remains static during the duration of the job, and it has an anonymous
> child that accrues new writes. This is a holdover from before we had a
> copy_bitmap, and we used to use a sync_bitmap directly as our loop
> condition.
>=20
> (This could be simplified upstream at present; but after this patch it
> cannot be for reasons explained below. We do wish to maintain three
> distinct sets of bits:
> 1. The bits at the start of the operation,
> 2. The bits accrued during the operation, and
> 3. The bits that remain to be, or were not, copied during the operation=
=2E)
>=20
> So there's actually three bitmaps:
>=20
> - sync_bitmap: actually just static and read-only
> - sync_bitmap's anonymous child: accrues new writes.

Ah, right...  Thanks for writing that up.

> - copy_bitmap: loop conditional.
>=20
>> But then replacing the sync_bitmap with the copy_bitmap here means tha=
t
>> all of these dirtyings that happened during the job are lost.  Hmm, bu=
t
>> that doesn=E2=80=99t matter, does it?  Because whenever something was =
dirtied in
>> sync_bitmap, the corresponding area must have been copied to the backu=
p
>> due to the job.
>>
>=20
> The new dirty bits were accrued very secretly in the anonymous child.
> The new dirty bits are merged in via the reclaim() function.
>=20
> So, what happens is:
>=20
> - Sync_bitmap gets the bit pattern of copy_bitmap (one way or another)
> - Sync_bitmap reclaims (merges with) its anonymous child.
>=20
>> Ah, yes, it would actually be wrong to keep the new dirty bits, becaus=
e
>> in this mode, sync_bitmap should (on failure) reflect what is left to
>> copy to make the backup complete.  Copying these newly dirtied sectors=

>> would be wrong.  (Yes, I know you wrote that in the documentation of
>> @always.  I just tried to get a different perspective.)
>>
>> Yes, yes, and copy_bitmap is always set whenever a CBW to the target
>> fails before the source can be updated.  Good, good.
>>
>=20
> You might have slightly the wrong idea; it's important to keep track of=

> what was dirtied during the operation because that data is important fo=
r
> the next bitmap backup.
>=20
> The merging of "sectors left to copy" (in the case of a failed backup)
> and "sectors dirtied since we started the operation" forms the actual
> minimal set needed to re-write to this target to achieve a new
> functioning point in time. This is what you get with the "always" mode
> in a failure case.
>=20
> In a success case, it just so happens that "sectors left to copy" is th=
e
> empty set.
>=20
> It's like an incremental on top of the incremental.
>=20
> Consider this:
>=20
> We have a 4TB drive and we have dirtied 3TB of it since our full backup=
=2E
> We copy out 2TB as part of a new incremental backup before suffering
> some kind of failure.
>=20
> Today, you'd need to start a new incremental backup that copies that
> entire 3TB *plus* whatever was dirtied since the job failed.
>=20
> With this mode, you'd only need to copy the remaining 1TB + whatever wa=
s
> dirtied since.
>=20
> So, what this logic is really doing is:
>=20
> If we failed, OR if we want the "never" sync policy:
>=20
> Merge the anonymous child (bits written during op) back into sync_bitma=
p
> (bits we were instructed to copy), leaving us as if we have never
> started this operation.
>=20
> If, however, we failed and we have the "always" sync policy, we destroy=

> the sync_bitmap (bits we were instructed to copy) and replace it with
> the copy_bitmap (bits remaining to copy). Then, we merge that with the
> anonymous child (bits written during op).

Oh, so that=E2=80=99s the way it works.  I thought =E2=80=9Calways=E2=80=9D=
 meant that you can
repeat the backup.  But it just means you keep your partial backup and
pretend it=E2=80=99s a full incremental one.

Now that I think about it again...  Yeah, you can=E2=80=99t repeat a back=
up at a
later point, of course.  If data is gone in the meantime, it=E2=80=99s go=
ne.

So, uh, I was wrong that it=E2=80=99s all good, because it would have bee=
n
wrong?  But thankfully I was just wrong myself, and so it is all good
after all?  My confusion with bitmaps as lifted, now I=E2=80=99m just con=
fused
with myself.

I revoke my R-b and give a new one:

Reviewed-by: Max Reitz <mreitz@redhat.com>

Or something like that.

Again, thanks a lot for clarifying.

Max

> Or, in success cases (when sync policy is not never), we simply delete
> the sync_bitmap (bits we were instructed to copy) and replace it with
> its anonymous child (bits written during op).


--qHel6A7Eb95Yz8eHaWA7soswhYK6XFJQp--

--t3xzUjSc0sxgNxdBuq87ebL7YXOFxEhnQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0L1iYACgkQ9AfbAGHV
z0Bajgf+InKrgKiyipPIC0CfkV2h0T7E1j8OSZKmJuuXuXw3/IdD3O0F+SVZuqWR
mjMrY3BtBrB5r5c9KtTB4gWALTnAW6BOfmbrRvsfGiNfoSMtMOzODN6QHyIENSwa
Gim/G7MvhkNln6na+Glzym7Rk3aMwXQbxhQ5MV3MYnkj/jBVPpJqTgVQP0yMlvnm
qjvWDvDxLWNgxssMRFLUEj7BLw11x3QwvA2n30eT1aqSikLl5YENztBQUqUbHvoQ
yheiAlrEyLJ+em+yyq2xiqfhnN7BSPS5if1DgwyfYHuWsESs/lLPORddsZeIerxH
Q8LuHFZFccxtEze15ARhDGYZJAInHQ==
=wWPS
-----END PGP SIGNATURE-----

--t3xzUjSc0sxgNxdBuq87ebL7YXOFxEhnQ--

