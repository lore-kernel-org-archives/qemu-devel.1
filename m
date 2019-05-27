Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A346AC04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 13:25:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 687F72075E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 13:25:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 687F72075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45957 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVFd3-0004Zc-Mh
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 09:25:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVFc1-0003wd-Nu
	for qemu-devel@nongnu.org; Mon, 27 May 2019 09:24:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVFc0-0005Th-MX
	for qemu-devel@nongnu.org; Mon, 27 May 2019 09:24:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54726)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hVFby-0005Rb-Dc; Mon, 27 May 2019 09:24:22 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B9BF53082B5F;
	Mon, 27 May 2019 13:24:21 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.13])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 92C5E6A857;
	Mon, 27 May 2019 13:24:18 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20190524180201.3302-1-jsnow@redhat.com>
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
Message-ID: <a095f348-af2f-1a0f-88dd-33930980a7be@redhat.com>
Date: Mon, 27 May 2019 15:24:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190524180201.3302-1-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mzjwNGIMljfwC8FjxJ6lqQRFrTVbxfoPx"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Mon, 27 May 2019 13:24:21 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH] event_match: always match on None value
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mzjwNGIMljfwC8FjxJ6lqQRFrTVbxfoPx
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Message-ID: <a095f348-af2f-1a0f-88dd-33930980a7be@redhat.com>
Subject: Re: [PATCH] event_match: always match on None value
References: <20190524180201.3302-1-jsnow@redhat.com>
In-Reply-To: <20190524180201.3302-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 24.05.19 20:02, John Snow wrote:
> Before, event_match didn't always recurse if the event value was not a
> dictionary, and would instead check for equality immediately.
>=20
> By delaying equality checking to post-recursion, we can allow leaf
> values like "5" to match "None" and take advantage of the generic
> None-returns-True clause.
>=20
> This makes the matching a little more obviously consistent at the
> expense of being able to check for explicit None values, which is
> probably not that important given what this function is used for.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  python/qemu/__init__.py | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
>=20
> diff --git a/python/qemu/__init__.py b/python/qemu/__init__.py
> index 98ed8a2e28..77d45f88fe 100644
> --- a/python/qemu/__init__.py
> +++ b/python/qemu/__init__.py
> @@ -409,27 +409,30 @@ class QEMUMachine(object):
> =20
>          The match criteria takes the form of a matching subdict. The e=
vent is
>          checked to be a superset of the subdict, recursively, with mat=
ching
> -        values whenever those values are not None.
> +        values whenever the subdict values are not None.
> +
> +        This has a limitation that you cannot explicitly check for Non=
e values.
> =20
>          Examples, with the subdict queries on the left:
>           - None matches any object.
>           - {"foo": None} matches {"foo": {"bar": 1}}
> -         - {"foo": {"baz": None}} does not match {"foo": {"bar": 1}}
> -         - {"foo": {"baz": 2}} matches {"foo": {"bar": 1, "baz": 2}}
> +         - {"foo": None} matches {"foo": 5}
> +         - {"foo": {"abc": None}} does not match {"foo": {"bar": 1}}
> +         - {"foo": {"rab": 2}} matches {"foo": {"bar": 1, "rab": 2}}
>          """
>          if match is None:
>              return True
> =20
> -        for key in match:
> -            if key in event:
> -                if isinstance(event[key], dict):
> -                    if not QEMUMachine.event_match(event[key], match[k=
ey]):
> -                        return False
> -                elif event[key] !=3D match[key]:
> +        try:
> +            for key in match:
> +                if key in event:
> +                    return QEMUMachine.event_match(event[key], match[k=
ey])

With this change, we only check a single key that is both in @match and
@event.  I think we want to keep the "if not -- return False" pattern,
don=E2=80=99t we?

Max

> +                else:
>                      return False
> -            else:
> -                return False
> -        return True
> +            return True
> +        except TypeError:
> +            # either match or event wasn't iterable (not a dict)
> +            return match =3D=3D event
> =20
>      def event_wait(self, name, timeout=3D60.0, match=3DNone):
>          """
>=20



--mzjwNGIMljfwC8FjxJ6lqQRFrTVbxfoPx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzr5QEACgkQ9AfbAGHV
z0DGCQf9F8nhlBV8GcLtEWE1gjySOnMHkadBKXY+SJ2KVmJUCR89PBy63SXy4ODo
vA5XCGJfrbh1+G8H1MQ1F0z5MMker+E13N8cuz9zdywNCkV86mguuYwqh2iqNHhJ
c6jY9jMOs1m7OhOEJz3oTPCcGQzHzcRWgxDZ2PYArkkwmaI7uNrBz+XvY+pgApt/
2oxNFboU7g+151tPWOPL3KRBjUrMPIgoUxBOF3VSkFoIha4rkH2YLicuVXWql2Hc
973LO/IAT2m4ChNHE2zEL4Q/rYpzAs5DKmSHmwn4nI0QtEk95BvhDO+q0XWhSSSo
2VBdDsUn+CE46gPeGQsE094cBIORCA==
=ujKs
-----END PGP SIGNATURE-----

--mzjwNGIMljfwC8FjxJ6lqQRFrTVbxfoPx--

