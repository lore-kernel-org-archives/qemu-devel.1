Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD42CC606AF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 12:10:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4A1B2064A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 12:10:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4A1B2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkSTR-0004J8-RW
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 08:10:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57377)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hkSOe-0000MT-Qq
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 08:05:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hkSOc-0006W0-WB
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 08:05:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53730)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hkSOH-00068U-1n; Mon, 08 Jul 2019 08:05:06 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8F21B2F8BDC;
 Mon,  8 Jul 2019 12:05:02 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-127.brq.redhat.com
 [10.40.204.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E414B39A45;
 Mon,  8 Jul 2019 12:04:54 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20190703215542.16123-1-jsnow@redhat.com>
 <20190703215542.16123-13-jsnow@redhat.com>
 <ee65fb7c-1f19-17f8-ea32-7aa3cc2a1b3d@redhat.com>
 <63fe8c7b-69ad-d043-d629-664370a2acc5@redhat.com>
 <979481d8-7c1c-71d4-cdca-7b1f6954aa6e@redhat.com>
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
Message-ID: <41c350ee-2e11-563f-16db-4472321cc775@redhat.com>
Date: Mon, 8 Jul 2019 14:04:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <979481d8-7c1c-71d4-cdca-7b1f6954aa6e@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="05dYt25Bbf5K1AHEHhZzLkiLlAPalM0UN"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Mon, 08 Jul 2019 12:05:02 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 12/18] block/backup: add 'always' bitmap
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
 vsementsov@virtuozzo.com, Juan Quintela <quintela@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--05dYt25Bbf5K1AHEHhZzLkiLlAPalM0UN
Content-Type: multipart/mixed; boundary="dk9EVwhWcPB6G9nRASgzSjnmoRsVeioJK";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, vsementsov@virtuozzo.com,
 Xie Changlong <xiechanglong.d@gmail.com>
Message-ID: <41c350ee-2e11-563f-16db-4472321cc775@redhat.com>
Subject: Re: [PATCH v2 12/18] block/backup: add 'always' bitmap sync policy
References: <20190703215542.16123-1-jsnow@redhat.com>
 <20190703215542.16123-13-jsnow@redhat.com>
 <ee65fb7c-1f19-17f8-ea32-7aa3cc2a1b3d@redhat.com>
 <63fe8c7b-69ad-d043-d629-664370a2acc5@redhat.com>
 <979481d8-7c1c-71d4-cdca-7b1f6954aa6e@redhat.com>
In-Reply-To: <979481d8-7c1c-71d4-cdca-7b1f6954aa6e@redhat.com>

--dk9EVwhWcPB6G9nRASgzSjnmoRsVeioJK
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 05.07.19 18:59, John Snow wrote:
>=20
>=20
> On 7/4/19 2:05 PM, Max Reitz wrote:
>> On 04.07.19 19:43, Max Reitz wrote:
>>> On 03.07.19 23:55, John Snow wrote:
>>>> This adds an "always" policy for bitmap synchronization. Regardless =
of if
>>>> the job succeeds or fails, the bitmap is *always* synchronized. This=
 means
>>>> that for backups that fail part-way through, the bitmap retains a re=
cord of
>>>> which sectors need to be copied out to accomplish a new backup using=
 the
>>>> old, partial result.
>>>>
>>>> In effect, this allows us to "resume" a failed backup; however the n=
ew backup
>>>> will be from the new point in time, so it isn't a "resume" as much a=
s it is
>>>> an "incremental retry." This can be useful in the case of extremely =
large
>>>> backups that fail considerably through the operation and we'd like t=
o not waste
>>>> the work that was already performed.
>>>>
>>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>>> ---
>>>>  block/backup.c       | 25 +++++++++++++++++--------
>>>>  qapi/block-core.json |  5 ++++-
>>>>  2 files changed, 21 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/block/backup.c b/block/backup.c
>>>> index 9cc5a7f6ca..495d8f71aa 100644
>>>> --- a/block/backup.c
>>>> +++ b/block/backup.c
>>>> @@ -266,16 +266,25 @@ static void backup_cleanup_sync_bitmap(BackupB=
lockJob *job, int ret)
>>
>> [...]
>>
>>>> +        /* If we failed and synced, merge in the bits we didn't cop=
y: */
>>>> +        bdrv_dirty_bitmap_merge_internal(bm, job->copy_bitmap,
>>>> +                                         NULL, true);
>>>
>>> I presume this is for sync=3Dfull?
>>
>=20
> Well, we don't allow bitmaps for sync=3Dfull at this point in the serie=
s.
>=20
>> Ah, no.  This is necessary because the original sync bitmap was
>> discarded by bdrv_dirty_bitmap_abdicate().  So yep, these bits need to=

>> go back into the sync bitmap then.
>>
>> Max
>>
>=20
> Yuh -- we actually want to clear the original bitmap for the 'always'
> case, which the "abdicate" handles for us. This ought to trigger only
> for the always case, so I think the conditional here is correct and as
> simple as it can be.
>=20
> Does your R-B stand?

Sure.

Max


--dk9EVwhWcPB6G9nRASgzSjnmoRsVeioJK--

--05dYt25Bbf5K1AHEHhZzLkiLlAPalM0UN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0jMWUACgkQ9AfbAGHV
z0AC+Qf/WQMC92G/ftD/Hs/bRJDFldpaXYASzXt7vEXrAnK1S3JQq2xiNaAkrG2R
xGM/DfDHmtUTuT6E4jytLuJz7aS+BHG7QWeoa6y/pzZhTDawX4xc4TFiVtyRnpah
vEKCdhdqDod5B62SV536BBWF055mDKvOQ4p1/r0StPuyPGJ914by4mDYcpQfoaov
zM/MRCZV0Dft7IdDc6yt6deHrHDLZKOoRBn3g4jh65MgdF2G+eAGz/qNVewOfthI
z39B0zQtO6rDvxeURcuil7AqjqlvLPM+LHGAQe9WE+uny8w+N5LvXcHI32gy4Mp3
37UWSR3VQU1kS6U/KxzfIQCB7WRdag==
=tKck
-----END PGP SIGNATURE-----

--05dYt25Bbf5K1AHEHhZzLkiLlAPalM0UN--

