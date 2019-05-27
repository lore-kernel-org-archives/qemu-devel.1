Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B79DC04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 12:15:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7461214D8
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 12:15:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7461214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45074 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVEXj-0001SO-20
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 08:15:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVEWr-0000xi-KI
	for qemu-devel@nongnu.org; Mon, 27 May 2019 08:15:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVEWq-0005eF-Qu
	for qemu-devel@nongnu.org; Mon, 27 May 2019 08:15:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58206)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hVEWo-0005SH-IZ; Mon, 27 May 2019 08:14:58 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BDA103082B4D;
	Mon, 27 May 2019 12:14:56 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.13])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E735C6F440;
	Mon, 27 May 2019 12:14:52 +0000 (UTC)
To: Alberto Garcia <berto@igalia.com>,
	Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-block@nongnu.org
References: <20190516142749.81019-1-anton.nefedov@virtuozzo.com>
	<f2d129f6-b03f-aaa8-3e7d-fff48ea52233@redhat.com>
	<w51h89hjm3c.fsf@maestria.local.igalia.com>
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
Message-ID: <d8cb4e5b-9ba8-53d0-e269-b3cbf30e06a1@redhat.com>
Date: Mon, 27 May 2019 14:14:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <w51h89hjm3c.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="U9X08WqziKpEOAA0bCJdkGhWDsExXak2V"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Mon, 27 May 2019 12:14:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v14 0/1] qcow2: cluster space preallocation
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
	den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--U9X08WqziKpEOAA0bCJdkGhWDsExXak2V
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>,
 Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, eblake@redhat.com,
 den@virtuozzo.com, vsementsov@virtuozzo.com
Message-ID: <d8cb4e5b-9ba8-53d0-e269-b3cbf30e06a1@redhat.com>
Subject: Re: [PATCH v14 0/1] qcow2: cluster space preallocation
References: <20190516142749.81019-1-anton.nefedov@virtuozzo.com>
 <f2d129f6-b03f-aaa8-3e7d-fff48ea52233@redhat.com>
 <w51h89hjm3c.fsf@maestria.local.igalia.com>
In-Reply-To: <w51h89hjm3c.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 26.05.19 17:01, Alberto Garcia wrote:
> On Fri 24 May 2019 03:56:21 PM CEST, Max Reitz <mreitz@redhat.com> wrot=
e:
>>>     +-----------+-------+------+-------+------+------+
>>>     |   file    |    before    |     after    | gain |
>>>     +-----------+-------+------+-------+------+------+
>>>     |    ssd    |      61.153  |      36.313  |  41% |
>>>     |    hdd    |     112.676  |     122.056  |  -8% |
>>>     +-----------+--------------+--------------+------+
>>
>> I=E2=80=99ve done a few more tests, and I=E2=80=99ve seen more slowdow=
n on an HDD.
>> (Like 30 % when doing 64 kB requests that are not aligned to
>> clusters.)  On the other hand, the SSD gain is generally in the same
>> ballpark (38 % when issuing the same kind of requests.)
>   [...]
>> [1] Hm.  We can probably investigate whether the file is stored on a
>> rotational medium or not.  Is there a fundamental reason why this
>> patch seems to degrade performance on an HDD but improves it on an
>> SSD?  If so, we can probably make a choice based on that.
>=20
> This is when writing to an unallocated cluster with no existing data on=

> the backing image, right? Then it's probably because you need 2
> operations (write zeros + write data) instead of just one.

Hm, yes.  I didn=E2=80=99t test writing tail and head separately, which s=
hould
be even worse.

Max


--U9X08WqziKpEOAA0bCJdkGhWDsExXak2V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzr1LoACgkQ9AfbAGHV
z0AhAAf/S4l8hXoK5oh7x+/5sW568HKmdM3TD4OGw0XNQTsF6ZGGtWOZudSjbRg2
6YgocB8f4uq7b/8upjTWD60xyEgYRFV81hfGaQiVOdMniIF4tqjGSK0kR0G93cQq
4i80n2ck83qPZkOokwQCPoLsst/VJcWIU64tPpUXaxcglGn+/NCqhLXG6iyY1gxu
MVj8rmF7vRv1euVlCqByhWFvKTjC93oQAexe2YLpP7aJA+Km43XouOi04knalNEL
2eS9/idsYbND2/Mo+vQHAF0yJI3kZJU2xWkMBJczIvU11oYfR4eoA8g09exUFn1G
sY2BBS5B6Utj7DBFKLhBtyHVkocQKA==
=Re0c
-----END PGP SIGNATURE-----

--U9X08WqziKpEOAA0bCJdkGhWDsExXak2V--

