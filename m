Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB59C2BBC7
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 10:15:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BC0920644
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 10:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Des+nPjY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BC0920644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOIbM-00016i-IP
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 06:15:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36045)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jOIaX-0008Sq-8E
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 06:14:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jOIaU-00008l-BK
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 06:14:41 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30027
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jOIaU-000084-6b
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 06:14:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586859277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=chQYayxWk6V931eDiG8535byqvYXXCB4vc0IQDvjQCs=;
 b=Des+nPjYizXlge3C+uRHA/nr/0FgC9e1g0z4ZIrPDsbqxnp6V6UB2eI2oJHRiyFp4Hyptv
 KBN/3hAw5i8tq+s7yzPJxWy4hajZl1rs2ZZWnSmpVbeava//54OnD35Gz46XU8pI4TNFP6
 uw/R0Uq32jOy+zoSKYxVvZ9bUrtSZWI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-msIq-5X9ND2BW2610HBLkw-1; Tue, 14 Apr 2020 06:14:35 -0400
X-MC-Unique: msIq-5X9ND2BW2610HBLkw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E972802560;
 Tue, 14 Apr 2020 10:14:34 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-186.ams2.redhat.com
 [10.36.114.186])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D69460BF7;
 Tue, 14 Apr 2020 10:14:31 +0000 (UTC)
Subject: Re: [PATCH v4 30/30] iotests: Add tests for qcow2 images with
 extended L2 entries
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1584468723.git.berto@igalia.com>
 <420b76fbe25d5e2eeda53490a1c646935dab61c4.1584468724.git.berto@igalia.com>
 <3684cc01-3082-c52a-bd58-49300244a6eb@redhat.com>
 <w51tv1ni9vj.fsf@maestria.local.igalia.com>
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
Message-ID: <60e98587-b4d3-4a50-b4c2-da73084f55bd@redhat.com>
Date: Tue, 14 Apr 2020 12:14:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <w51tv1ni9vj.fsf@maestria.local.igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="YXMoiLfeu40aAFuyxFzjV4ASpvCJd1RJU"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-block@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YXMoiLfeu40aAFuyxFzjV4ASpvCJd1RJU
Content-Type: multipart/mixed; boundary="a5bwOBuELeIGDoqBt2VcAFUqA1tLYl9Mk"

--a5bwOBuELeIGDoqBt2VcAFUqA1tLYl9Mk
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.04.20 19:16, Alberto Garcia wrote:
> On Thu 09 Apr 2020 02:22:37 PM CEST, Max Reitz wrote:
>>> +    ### Write subcluster #31-#34 (cluster overlap) ###
>>
>> #31-#34, I think.
>=20
> That's what I wrote :-?

Errrrr #31-#33.

>>> +    ### Partially zeroize an unallocated cluster (#3)
>>> +    if [ "$use_backing_file" =3D "yes" ]; then
>>> +        alloc=3D"`seq 0 15`"; zero=3D""
>>
>> Isn=E2=80=99t this a TODO?  (I.e., ideally we=E2=80=99d want the first 1=
6 subclusters
>> to be zero, and the last 16 subclusters to be unallocated, right?)
>>
>> (I=E2=80=99m asking because you did raise a TODO for the =E2=80=9CZero s=
ubcluster #1=E2=80=9D
>> test)
>=20
> Maybe, but I just implemented zeroize at the subcluster level :-) Wait
> for the next version of the series.

OK :)

Max


--a5bwOBuELeIGDoqBt2VcAFUqA1tLYl9Mk--

--YXMoiLfeu40aAFuyxFzjV4ASpvCJd1RJU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6VjQYACgkQ9AfbAGHV
z0B80ggAlOmaGC9k3Tb5f+4qpEQuW9t1xU+oxBIvN7m3d5vzXpj7xIcysWm+zxwA
KjBFMsm8hryTR4c6LOxIiZJ/HCrHZ/+sgY+zevGR8qqfP77KB9+XalCagNrLkfpj
42EhfFHPPxJ1K50MZ59yYGEV/3Bd9hrmmpFVOI3f+O/Rnz1A1gvuxKvqhK+nnZ04
P1hZz+LkQB56Fy4DjILA9phjfjKDK9zpmTfUpScq+iKgQFIzlUBrrna7vz667OhK
pwKvD6QHkbo0UuVbp+iU4Zi5N0q3maZNHKP8obySfluxIU8/XeMSjl92HxOUocMj
eqiVWkv1KVjgUIW+GsyEyoC3aIHQqw==
=8MMM
-----END PGP SIGNATURE-----

--YXMoiLfeu40aAFuyxFzjV4ASpvCJd1RJU--


