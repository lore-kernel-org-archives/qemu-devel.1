Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501B7CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:56:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BBB621929
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VoNVR9yv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BBB621929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO112-0002XF-Lj
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 10:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45757)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iO0Zu-0000wp-PD
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:28:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iO0Zs-00054G-HY
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:28:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45259
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iO0Zs-00053v-Cr
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:28:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572013711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=SCDwoMZv5JVNbsOXs3g2XT8c9uHNYYmK8D+2SHZfePE=;
 b=VoNVR9yvkh+EYXr5TbNbZEf5cPq1VTQ2VSKCJwex2zN2Rbkumr3A/05bkGag0pxDhwB0MS
 CSeGKg/K3VperfX8JegwU4iZ4euveADECbudO88vg66ce5nutLZRjeXu9OF9/2NCbHpxKC
 cgHJomduJ4Gvini83TGVkd729Ffq+PE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-jnPVNbzqPHSgaImU8TJnJQ-1; Fri, 25 Oct 2019 10:28:26 -0400
X-MC-Unique: jnPVNbzqPHSgaImU8TJnJQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29236800D41;
 Fri, 25 Oct 2019 14:28:25 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-230.ams2.redhat.com
 [10.36.117.230])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2104C60BEC;
 Fri, 25 Oct 2019 14:28:23 +0000 (UTC)
Subject: Re: [PULL 3/3] iotests: test nbd reconnect
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20191023020126.24991-1-eblake@redhat.com>
 <20191023020126.24991-4-eblake@redhat.com>
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
Message-ID: <4d5f2858-a0a1-a005-ef2e-056e7b0e8e88@redhat.com>
Date: Fri, 25 Oct 2019 16:28:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191023020126.24991-4-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4pJzrzxj7iOnZqSuMfvlMVBMKEnME2IlG"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4pJzrzxj7iOnZqSuMfvlMVBMKEnME2IlG
Content-Type: multipart/mixed; boundary="REmuQyZuECOUcqKh3hPuhbGr5UPeprdyc"

--REmuQyZuECOUcqKh3hPuhbGr5UPeprdyc
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 23.10.19 04:01, Eric Blake wrote:
> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20
> Add test, which starts backup to nbd target and restarts nbd server
> during backup.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Message-Id: <20191009084158.15614-4-vsementsov@virtuozzo.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/qemu-iotests/264        | 95 +++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/264.out    | 13 +++++
>  tests/qemu-iotests/group      |  1 +
>  tests/qemu-iotests/iotests.py | 11 ++++
>  4 files changed, 120 insertions(+)
>  create mode 100755 tests/qemu-iotests/264
>  create mode 100644 tests/qemu-iotests/264.out

I suppose this test should limit the supported image formats.  For me,
it fails for at least LUKS, cloop, and vpc.  (Due to different reasons
for each format.)

Max


--REmuQyZuECOUcqKh3hPuhbGr5UPeprdyc--

--4pJzrzxj7iOnZqSuMfvlMVBMKEnME2IlG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2zBoYACgkQ9AfbAGHV
z0Dyggf/QGgxy/G7Yyv7nsDmgQlvOhsmI6QHqEp/eJhTsQLc7oQJf6QqBh8io3BL
KodAtxHeCo3x7nDITM8IASj+Lp9/BLpYy+Z5ndYZjuRwRI9ItW0Z6coqF1R7U5fZ
Il2R7VZlFP3UyBFf+2wLIUxpbqSt6IinahyEjm0MnK39l3YcDOXrp1a/fy2LnO9B
0edFBKFB2R3wxtN5QBBFXrUqh5pK+/4J5F3eZj9TNFO2q+8dvaC05cKoLcKXaN1r
e261RxZJ6G6mcOfZzqTukj/G6/VZ594dvVc4Bw6PSRri7qgM81wthlTH70Pzu31U
64mtcjH0sKOhZXUZylxt4dh6KWILEg==
=met6
-----END PGP SIGNATURE-----

--4pJzrzxj7iOnZqSuMfvlMVBMKEnME2IlG--


