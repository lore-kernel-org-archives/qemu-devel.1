Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9550DC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 16:22:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64ED524653
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 16:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iiF2UkcC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64ED524653
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itwI8-0008AR-Ei
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 11:22:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35822)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1itwGQ-0006O2-Hd
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:20:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1itwGP-0007om-9u
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:20:26 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36456
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1itwGP-0007nW-3E
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:20:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579623621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+WAv0MYtdqKI1zjEAfNKbrmaveVAT3YOotRA2IVpeBc=;
 b=iiF2UkcCupH8wdiXUeC4XCiGkX2kWw28wtNBt6sFKk1j34k1d6wlOQtPhq8Ks+7KIISleg
 /sFtbrJ+TLdSCh9KdTdxjMDSMGfxf3lF9LP/HOhSnwzAqKK9Ia7j6B/tgdqxYySxa5vb8L
 3NQZ8EFAyC/EJOpKl9VP76xjtbGVrmw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-xFlAZ3irN3CGVM-aHZECQA-1; Tue, 21 Jan 2020 11:20:17 -0500
X-MC-Unique: xFlAZ3irN3CGVM-aHZECQA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0E1C8017CC;
 Tue, 21 Jan 2020 16:20:15 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-116.ams2.redhat.com
 [10.36.117.116])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4025F7DB34;
 Tue, 21 Jan 2020 16:20:14 +0000 (UTC)
Subject: Re: [PATCH v10 2/2] docs: qcow2: introduce compression type feature
To: Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200120171345.24345-1-vsementsov@virtuozzo.com>
 <20200120171345.24345-3-vsementsov@virtuozzo.com>
 <679ba957-0b47-27ab-0684-e066ca8a6196@redhat.com>
From: Max Reitz <mreitz@redhat.com>
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
Message-ID: <f005bd08-faee-1116-071f-819a491086bb@redhat.com>
Date: Tue, 21 Jan 2020 17:20:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <679ba957-0b47-27ab-0684-e066ca8a6196@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="AyK8HeigY3oMsJ1q4q0lqysMbSrd4nXZ4"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: kwolf@redhat.com, den@openvz.org, dplotnikov@virtuozzo.com,
 qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AyK8HeigY3oMsJ1q4q0lqysMbSrd4nXZ4
Content-Type: multipart/mixed; boundary="4vrppqaMj5YxarihldW79FJTzItYBiZNf"

--4vrppqaMj5YxarihldW79FJTzItYBiZNf
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 20.01.20 20:46, Eric Blake wrote:
> On 1/20/20 11:13 AM, Vladimir Sementsov-Ogievskiy wrote:
>> The patch add new additional field to qcow2 header: compression_type,
>=20
> s/add/adds a/
> s/to/to the/
>=20
>> which specifies compression type. If field is absent or zero, default
>> compression type is set: ZLIB, which corresponds to current behavior.
>>
>> New compression type (ZSTD) is to be added in further commit.
>=20
> It would be nice to have that patch as part of the same series, but it
> has already been posted to the list separately, so I'm okay with this
> series as just doc word-smithing while we get that patch series in soon.
>=20
>>
>> Suggested-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> =A0 docs/interop/qcow2.txt | 16 +++++++++++++++-
>> =A0 1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
>> index 355925c35e..4569f0dba3 100644
>> --- a/docs/interop/qcow2.txt
>> +++ b/docs/interop/qcow2.txt
>> @@ -109,6 +109,11 @@ the next fields through header_length.
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 An External Data File Name header
>> extension may
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 be present if this bit is set.
>> =A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Bit 3:=A0=
=A0=A0=A0=A0 Compression type bit.=A0 If this bit
>> is set,
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 a non-default compression is used for
>> compressed
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 clusters. The compression_type field
>> must be
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 present and not zero.
>=20
> Why must the compression_type field be non-zero?=A0 If this bit is set, a=
n
> older qemu cannot use the image, regardless of the contents of the
> compression_type field, so for maximum back-compat, a sane app will
> never set this bit when compression_type is zero.=A0 But there is nothing
> technically wrong with setting this bit even when compression_type is 0,
> and newer qemu would still manage to use the image correctly with zlib
> compression if it were not for this arbitrary restriction.

There is something technically wrong if the specification demands otherwise=
.

As you yourself say, no sane software would deviate from this behavior
anyway.  If that is so, I don=92t see why we shouldn=92t specify it this
way.  I see no benefit in allowing this bit be set for zlib images.

Max


--4vrppqaMj5YxarihldW79FJTzItYBiZNf--

--AyK8HeigY3oMsJ1q4q0lqysMbSrd4nXZ4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl4nJLwACgkQ9AfbAGHV
z0C9JAf8DODrGyCL7mehicMmRwwI2mHKz8E065R9S292LGztwSnWgl2LkVvzDZXU
ftpGVZMrM4bMmm6g1Im5sXJZpWLbm1BMpsZfLy6ynapYqIhLD685ALrV/Gd6M7NC
RyHj0RKpJlR9yk3iboAe+9GDablg7CEWrPOBVz1bWGViWozHa5m1iZMdkxboPjHm
fcbClXQDSNuyfinlyhriS3VsJXJ8TNaf+mixe7FzwxCWLUkE3cwWd5vvwHWZm2DJ
1C6UKYniUw/ATkkTnFLal49s/3IVaOLAqefHJ/6DL77xZzmaMJGdmjU3Ocgpaf4i
UoiefbwQNlGbdmCcjuD+deDAR4s4+g==
=Z9kv
-----END PGP SIGNATURE-----

--AyK8HeigY3oMsJ1q4q0lqysMbSrd4nXZ4--


