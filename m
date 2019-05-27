Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BC1C04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 13:52:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CC7F20675
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 13:52:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CC7F20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46268 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVG33-0004SI-60
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 09:52:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVG2B-00048z-KJ
	for qemu-devel@nongnu.org; Mon, 27 May 2019 09:51:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVG29-0002jR-NG
	for qemu-devel@nongnu.org; Mon, 27 May 2019 09:51:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hVG26-0002gA-Ra; Mon, 27 May 2019 09:51:23 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1705E308FF2C;
	Mon, 27 May 2019 13:51:18 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.13])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4AEB07BE99;
	Mon, 27 May 2019 13:51:16 +0000 (UTC)
To: Anton Nefedov <anton.nefedov@virtuozzo.com>,
	Alberto Garcia <berto@igalia.com>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190524172812.27308-1-mreitz@redhat.com>
	<20190524172812.27308-2-mreitz@redhat.com>
	<w51ef4ljlt7.fsf@maestria.local.igalia.com>
	<66e86c16-c30c-5363-ef94-f01da8979872@redhat.com>
	<w515zpwrs30.fsf@maestria.local.igalia.com>
	<92b7c22d-06bb-f04a-0df1-7340c11be954@redhat.com>
	<80167166-a23a-6f10-c28b-a3a905f7ca6e@virtuozzo.com>
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
Message-ID: <6df6e5e7-2d42-2e71-b887-56c091413232@redhat.com>
Date: Mon, 27 May 2019 15:51:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <80167166-a23a-6f10-c28b-a3a905f7ca6e@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="zhvKhCwMelUKxxyP4fkwz5GcmAis1ME3O"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Mon, 27 May 2019 13:51:21 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [RFC 1/3] block: Add ImageRotationalInfo
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>,
	Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zhvKhCwMelUKxxyP4fkwz5GcmAis1ME3O
From: Max Reitz <mreitz@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <6df6e5e7-2d42-2e71-b887-56c091413232@redhat.com>
Subject: Re: [RFC 1/3] block: Add ImageRotationalInfo
References: <20190524172812.27308-1-mreitz@redhat.com>
 <20190524172812.27308-2-mreitz@redhat.com>
 <w51ef4ljlt7.fsf@maestria.local.igalia.com>
 <66e86c16-c30c-5363-ef94-f01da8979872@redhat.com>
 <w515zpwrs30.fsf@maestria.local.igalia.com>
 <92b7c22d-06bb-f04a-0df1-7340c11be954@redhat.com>
 <80167166-a23a-6f10-c28b-a3a905f7ca6e@virtuozzo.com>
In-Reply-To: <80167166-a23a-6f10-c28b-a3a905f7ca6e@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27.05.19 15:44, Anton Nefedov wrote:
> On 27/5/2019 3:57 PM, Max Reitz wrote:
>> On 27.05.19 14:37, Alberto Garcia wrote:
>>> On Mon 27 May 2019 02:16:53 PM CEST, Max Reitz wrote:
>>>> On 26.05.19 17:08, Alberto Garcia wrote:
>>>>> On Fri 24 May 2019 07:28:10 PM CEST, Max Reitz <mreitz@redhat.com> =
wrote:
>>>>>> +##
>>>>>> +# @ImageRotationalInfo:
>>>>>> +#
>>>>>> +# Indicates whether an image is stored on a rotating disk or not.=

>>>>>> +#
>>>>>> +# @solid-state: Image is stored on a solid-state drive
>>>>>> +#
>>>>>> +# @rotating:    Image is stored on a rotating disk
>>>>>
>>>>> What happens when you cannot tell? You assume it's solid-state?
>>>>
>>>> When *I* cannot tell?  This field is generally optional, so in that =
case
>>>> it just will not be present.
>>>>
>>>> (When Linux cannot tell?  I don=E2=80=99t know :-))
>>>>
>=20
> Linux defaults to rotational =3D=3D 1 unless the driver sets
> QUEUE_FLAG_NONROT.
>=20
> By the way as far as I can tell, qemu does not report this flag unless
> explicitly set in a device property.
>=20
>      DEFINE_PROP_UINT16("rotation_rate", IDEDrive, dev.rotation_rate, 0=
),
> and
>      DEFINE_PROP_UINT16("rotation_rate", SCSIDiskState, rotation_rate, =
0),
>=20
>>>> Do you think there should be an explicit value for that?
>>>
>>> I'll try to rephrase:
>>>
>>> we have a new optimization that improves performance on SSDs but redu=
ces
>>> performance on HDDs, so this series would detect where an image is
>>> stored in order to enable the faster code path for each case.
>>>
>>> What happens if QEMU cannot detect if we have a solid drive or a
>>> rotational drive? (e.g. a remote storage backend). Will it default to=

>>> enabling preallocation using write_zeroes()?
>>
>> In this series, yes.  That is the default I chose.
>>
>> We have to make a separate decision for each case.  In the case of
>> filling newly allocated areas with zeroes, I think the performance gai=
n
>> for SSDs is more important than the performance loss for HDDs.  That i=
s
>> what I wrote in my response to Anton=E2=80=99s series.  So I took the =
series
>> even without it being able to distinguish both cases at all.
>> Consequentially, I believe it is reasonable for that to be the default=

>> behavior if we cannot tell.
>>
>> I think in general optimizing for SSDs should probably be the default.=

>> HDDs are slow anyway, so whoever uses them probably doesn=E2=80=99t ca=
re about
>> performance too much anyway...?  Whereas people using SSDs probably do=
=2E
>>   But as I said, we can and should always make a separate decision for=

>> each case.
>>
>=20
> Overall it looks good to me but I wonder how do we ensure both variants=

> are test covered? Need a blockdev option to enforce the mode?

That=E2=80=99s a good point.  Yes, file-posix should probably take an opt=
ion to
override the mode.  Actually, that may be a useful option in general (if
the file is on some file system where we cannot query this information
(like glusterfs), the user may want to manually provide it).

Max


--zhvKhCwMelUKxxyP4fkwz5GcmAis1ME3O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzr61IACgkQ9AfbAGHV
z0DCoAgAqMo7Df0ZNXKQZTpMbO1PeOj7+kKPmX8i/6QKZEXzPZ3uE9UKwjwLVdnI
4Ospo/nWvLnVwW6a+4d3DanzpvsQY6j7lTW3oBd4PpwMBTLnnv2Ptoh0Pl6t/EI1
mDpE78QxSwJw//d6XOPZWcOj4i8zDbEK1OJhxYqkyAtKbgATfXIz9zjZ/Z8avJkY
qyu38yUNw185z18qPT1ZFajOW2XpGLn+NfxWg6HiXOt3kuNcH0l3kcEjOPKSbDJ8
UaWTrzZOxsDHOXIYClGBwy9j9hw7EIf3FGcBD27/PIGPt/slxF9tSSSQXZUnicJA
FGskyZoaVyklPXrtCNwcoOShwNan+A==
=ezG2
-----END PGP SIGNATURE-----

--zhvKhCwMelUKxxyP4fkwz5GcmAis1ME3O--

