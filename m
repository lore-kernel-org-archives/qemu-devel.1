Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A94C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 11:51:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1D2D22D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 11:51:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1D2D22D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0P96-00060U-1u
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 07:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54064)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i0OgR-0006if-Qd
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:21:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i0OgQ-0007DK-7Z
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:21:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:10879)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i0OgM-0007BR-T3; Wed, 21 Aug 2019 07:21:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 19A452F3663;
 Wed, 21 Aug 2019 11:21:38 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.84])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F2D655C221;
 Wed, 21 Aug 2019 11:21:32 +0000 (UTC)
To: Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190516143314.81302-1-anton.nefedov@virtuozzo.com>
 <20190516143314.81302-10-anton.nefedov@virtuozzo.com>
 <9280c26d-13c4-7fad-dc15-ff799c5284e3@redhat.com>
 <fa4859e0-2418-8171-10c4-e1c908567dad@virtuozzo.com>
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
Message-ID: <57ec1cb0-107c-b811-b59c-992ffa5e2ed4@redhat.com>
Date: Wed, 21 Aug 2019 13:21:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <fa4859e0-2418-8171-10c4-e1c908567dad@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="a9NIjLicrMCmCwl5RYzelfBs2Mw1deWcZ"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Wed, 21 Aug 2019 11:21:38 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v8 9/9] qapi: query-blockstat: add driver
 specific file-posix stats
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "berto@igalia.com" <berto@igalia.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--a9NIjLicrMCmCwl5RYzelfBs2Mw1deWcZ
Content-Type: multipart/mixed; boundary="APP0wEbyT3uAPHDktm7PnCBjYaksHu5ZI";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kwolf@redhat.com" <kwolf@redhat.com>, "jsnow@redhat.com"
 <jsnow@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "berto@igalia.com" <berto@igalia.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <57ec1cb0-107c-b811-b59c-992ffa5e2ed4@redhat.com>
Subject: Re: [PATCH v8 9/9] qapi: query-blockstat: add driver specific
 file-posix stats
References: <20190516143314.81302-1-anton.nefedov@virtuozzo.com>
 <20190516143314.81302-10-anton.nefedov@virtuozzo.com>
 <9280c26d-13c4-7fad-dc15-ff799c5284e3@redhat.com>
 <fa4859e0-2418-8171-10c4-e1c908567dad@virtuozzo.com>
In-Reply-To: <fa4859e0-2418-8171-10c4-e1c908567dad@virtuozzo.com>

--APP0wEbyT3uAPHDktm7PnCBjYaksHu5ZI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 21.08.19 13:00, Anton Nefedov wrote:
> On 12/8/2019 10:04 PM, Max Reitz wrote:
>> On 16.05.19 16:33, Anton Nefedov wrote:
>>> A block driver can provide a callback to report driver-specific
>>> statistics.
>>>
>>> file-posix driver now reports discard statistics
>>>
>>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> Acked-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>   qapi/block-core.json      | 38 ++++++++++++++++++++++++++++++++++++=
++
>>>   include/block/block.h     |  1 +
>>>   include/block/block_int.h |  1 +
>>>   block.c                   |  9 +++++++++
>>>   block/file-posix.c        | 38 +++++++++++++++++++++++++++++++++++-=
--
>>>   block/qapi.c              |  5 +++++
>>>   6 files changed, 89 insertions(+), 3 deletions(-)
>>
>>
>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>> index 55194f84ce..368e09ae37 100644
>>> --- a/qapi/block-core.json
>>> +++ b/qapi/block-core.json
>>> @@ -956,6 +956,41 @@
>>>              '*wr_latency_histogram': 'BlockLatencyHistogramInfo',
>>>              '*flush_latency_histogram': 'BlockLatencyHistogramInfo' =
} }
>>>  =20
>>> +##
>>> +# @BlockStatsSpecificFile:
>>> +#
>>> +# File driver statistics
>>> +#
>>> +# @discard-nb-ok: The number of successful discard operations perfor=
med by
>>> +#                 the driver.
>>> +#
>>> +# @discard-nb-failed: The number of failed discard operations perfor=
med by
>>> +#                     the driver.
>>> +#
>>> +# @discard-bytes-ok: The number of bytes discarded by the driver.
>>> +#
>>> +# Since: 4.1
>>> +##
>>> +{ 'struct': 'BlockStatsSpecificFile',
>>> +  'data': {
>>> +      'discard-nb-ok': 'uint64',
>>> +      'discard-nb-failed': 'uint64',
>>> +      'discard-bytes-ok': 'uint64' } }
>>> +
>>> +##
>>> +# @BlockStatsSpecific:
>>> +#
>>> +# Block driver specific statistics
>>> +#
>>> +# Since: 4.1
>>> +##
>>> +{ 'union': 'BlockStatsSpecific',
>>> +  'base': { 'driver': 'BlockdevDriver' },
>>> +  'discriminator': 'driver',
>>> +  'data': {
>>> +      'file': 'BlockStatsSpecificFile',
>>> +      'host_device': 'BlockStatsSpecificFile' } }
>>
>> I would like to use these chance to complain that I find this awkward.=

>> My problem is that I don=E2=80=99t know how any management application=
 is
>> supposed to reasonably consume this.  It feels weird to potentially ha=
ve
>> to recognize the result for every block driver.
>>
>> I would now like to note that I=E2=80=99m clearly not in a position to=
 block
>> this at this point, because I=E2=80=99ve had a year to do so, I didn=E2=
=80=99t, so it
>> would be unfair to do it now.
>>
>> (Still, I feel like if I have a concern, I should raise it, even if it=
=E2=80=99s
>> too late.)
>>
>> I know Markus has proposed this, but I don=E2=80=99t understand why.  =
He set
>> ImageInfoSpecific as a precedence, but that has a different reasoning
>> behind it.  The point for that is that it simply doesn=E2=80=99t work =
any other
>> way, because it is clearly format-specific information that cannot be
>> shared between drivers.  Anything that can be shared is put into
>> ImageInfo (like the cluster size).
>>
>> We have the same constellation here, BlockStats contains common stuff,=

>> and BlockStatsSpecific would contain driver-specific stuff.  But to me=
,
>> BlockStatsSpecificFile doesn=E2=80=99t look very special.  It looks li=
ke it just
>> duplicates fields that already exist in BlockDeviceStats.
>>
>>
>> (Furthermore, most of ImageInfoSpecific is actually not useful to
>> management software, but only as an information for humans (and having=

>> such a structure for that is perfectly fine).  But these stats don=E2=80=
=99t
>> really look like something for immediate human consumption.)
>>
>>
>> So I wonder why you don=E2=80=99t just put this information into
>> BlockDeviceStats.  From what I can tell looking at
>> bdrv_query_bds_stats() and qmp_query_blockstats(), the @stats field is=

>> currently completely 0 if @query-nodes is true.
>>
>> (Furthermore, I wonder whether it would make sense to re-add
>> BlockAcctStats to each BDS and then let the generic block code do the
>> accounting on it.  I moved it to the BB in 7f0e9da6f13 because we didn=
=E2=80=99t
>> care about node-level information at the time, but maybe it=E2=80=99s =
time to
>> reconsider.)
>>
>>
>> Anyway, as I=E2=80=99ve said, I fully understand that complaining abou=
t a design
>> decision is just unfair at this point, so this is not a veto.
>>
>=20
> hi!
>=20
> Having both "unmap" and "discard" stats in the same list feels weird.
> The intention is that unmap belongs to the device level, and discard is=

> from the driver level.

Sorry, what I meant wasn=E2=80=99t adding a separate =E2=80=9Cdiscard=E2=80=
=9D group, but just
filling in the existing =E2=80=9Cunmap=E2=80=9D fields.  As far as I unde=
rstand, if we
had BlockAcctStats for each BDS, the file node=E2=80=99s unmap stats woul=
d be
the same as its discard stats, wouldn=E2=80=99t it?

> Now we have a separate structure named "driver-
> specific". Could also be called "driver-stats".
>=20
> We could make this structure non-optional, present for all driver
> types, as indeed there is nothing special about discard stats. But then=

> we need some way to distinguish
>   - discard_nb_ok =3D=3D 0 as no request reached the driver level
>   - discard_nb_ok =3D=3D 0 as the driver does not support the accountin=
g

You can simply make the fields optional.  (Then the first case is
=E2=80=9Cpresent, but 0=E2=80=9D, and the second is =E2=80=9Cnot present=E2=
=80=9D.)

> Yes, putting the accounting in the generic code would help, but do we
> really want to burden it with accounting too? Tracking that each and
> every case is covered with all those block_acct_done() invalid() and
> failed() can really be a pain.

That=E2=80=99s indeed a problem, yes. :-)

> And what accounting should be there? All the operations? Measuring
> discards at both device and BDS level is useful since discards are
> optional. Double-measuring reads&writes is probably not so useful (RMW =

> accounting? Read stats for the backing images?)

Yes, if we put BlockAcctStats at the node level, we should track all
operations, I suppose.  That would require adding accounting code in
many places, so it wouldn=E2=80=99t be easy, correct.

I think it would be the better solution, but you=E2=80=99re right in that=
 it=E2=80=99s
probably not worth it.

But I do think it would be good if we could get away from a
driver-specific structure (unless we really need it; and I don=E2=80=99t =
think
we do if we just make the stats fields optional).

Max


--APP0wEbyT3uAPHDktm7PnCBjYaksHu5ZI--

--a9NIjLicrMCmCwl5RYzelfBs2Mw1deWcZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1dKTsACgkQ9AfbAGHV
z0D57AgApGFA9L4zGiQi9njjR/ao1TgbqC0NCo0crddJPGjrUvBaYZJ4JNV4ck/m
N4bV2DwtMtvGZZQe2NKEfZzLM5WGp69qfOStkfdKZ3/tjDRwqMXNDJaHVEIiLhgE
T9RPSVWkipVnIlQNAxKgncOgsWutJq/THKYUrup8YtJ7ZgMzn/tnA6Ye0dClMRp7
Fk1P9N4Kr/q/QkskXYfiKHQBszUHd47F0h34GE+iu0V478VZeau+RQZgp1bzWx1p
sUCu78u7wmMIjLFWxBAVnSDtAsZ9O1NiABSEeCXBevwD0ADpJh71K1tkZ/oEVWOW
F8EK6sNhOmnqljYUAxytSqTEo/61Ow==
=/euY
-----END PGP SIGNATURE-----

--a9NIjLicrMCmCwl5RYzelfBs2Mw1deWcZ--

