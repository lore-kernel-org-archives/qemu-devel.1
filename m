Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5451C4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 13:27:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DAD1218DE
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 13:27:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DAD1218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7JhU-0006lv-Q2
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 09:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58518)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i7JgX-0006G0-T5
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 09:26:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i7JgW-0006wx-QQ
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 09:26:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55420)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i7JgQ-0006sd-WA; Mon, 09 Sep 2019 09:26:19 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CFC1A30EE130;
 Mon,  9 Sep 2019 13:26:11 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-179.ams2.redhat.com
 [10.36.116.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4208F104C516;
 Mon,  9 Sep 2019 13:26:03 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20190830161228.54238-1-vsementsov@virtuozzo.com>
 <20190830161228.54238-9-vsementsov@virtuozzo.com>
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
Message-ID: <75066c81-04f5-b849-51a8-c663fea5b60b@redhat.com>
Date: Mon, 9 Sep 2019 15:25:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190830161228.54238-9-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GD0tNTi8vcxamK77z7hxyNGE2CsQEfOAU"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Mon, 09 Sep 2019 13:26:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v10 08/14] iotests: prepare 124 and 257
 bitmap querying for backup-top filter
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
Cc: fam@euphon.net, kwolf@redhat.com, wencongyang2@huawei.com,
 xiechanglong.d@gmail.com, qemu-devel@nongnu.org, armbru@redhat.com,
 jsnow@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GD0tNTi8vcxamK77z7hxyNGE2CsQEfOAU
Content-Type: multipart/mixed; boundary="EvBFEPat0qzqzPhHQh1xAeF31rAvn1gj2";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, eblake@redhat.com, armbru@redhat.com,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, fam@euphon.net,
 stefanha@redhat.com, jsnow@redhat.com, kwolf@redhat.com, den@openvz.org
Message-ID: <75066c81-04f5-b849-51a8-c663fea5b60b@redhat.com>
Subject: Re: [PATCH v10 08/14] iotests: prepare 124 and 257 bitmap querying
 for backup-top filter
References: <20190830161228.54238-1-vsementsov@virtuozzo.com>
 <20190830161228.54238-9-vsementsov@virtuozzo.com>
In-Reply-To: <20190830161228.54238-9-vsementsov@virtuozzo.com>

--EvBFEPat0qzqzPhHQh1xAeF31rAvn1gj2
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 30.08.19 18:12, Vladimir Sementsov-Ogievskiy wrote:
> After backup-top filter appearing it's not possible to see dirty
> bitmaps in top node, so use node-name instead.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  tests/qemu-iotests/124        |  83 ++++----
>  tests/qemu-iotests/257        |  49 ++---
>  tests/qemu-iotests/257.out    | 364 +++++++++++++---------------------=

>  tests/qemu-iotests/iotests.py |  27 +++
>  4 files changed, 219 insertions(+), 304 deletions(-)

[...]

> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests=
=2Epy
> index 84438e837c..1906eb72f3 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -643,6 +643,33 @@ class VM(qtest.QEMUQtestMachine):

[...]

> +    def check_bitmap_status(self, node_name, bitmap_name, fields):
> +        ret =3D self.get_bitmap(node_name, bitmap_name)
> +
> +        return fields.items() <=3D ret.items()

Why the <=3D?  AFAIU, it will compare each of the arrays=E2=80=99 element=
s one by
one and return true if all of the ones in @fields are less than or equal
to the ones in @ret.

But that would mean that the values given in @fields no longer need to
be equal to the ones in @ret.  On top of that, I suppose if
@fields.items() at some index contains a key that is not equal to the
key in @ret.items() at the same index, luck will determine whether the
comparison passes or not.

Why not just loop through all keys of @fields and check that @fields and
@ret contain the same value for all of them?

Max


--EvBFEPat0qzqzPhHQh1xAeF31rAvn1gj2--

--GD0tNTi8vcxamK77z7hxyNGE2CsQEfOAU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl12UucACgkQ9AfbAGHV
z0CPRAf/UNDBgw9M2+iQguCGrAE6QNiv2SPudFO0nYOTXaAQa17ffMIJqpBMb8Yu
A0sDoBM5zRVOrLdNAj7kIW4QO+sGes+VMEI3f8IhzD/rjBYXFX2jz4LLQbTfOics
R3C0s4Ty8yqOKb7yjyTR/qPPPjkwro2esZ7WNcEXEUMn4+nIF8PKu2dijNdtc4CP
GLPn/lS95J1RdmrJooDWxocUqjHQZfSiEUv4bIwk27nKHoKzy+Vk0l3VbzaWyryJ
fc8rKfy4gm63ysIJiLdNZEV0UgGuWh82GOPWh+6nz8yn369TrHL8WB0MC8YAUJzX
X4o7ZZEc9zh1vFS5fHi5VjW3njOHfQ==
=ijwy
-----END PGP SIGNATURE-----

--GD0tNTi8vcxamK77z7hxyNGE2CsQEfOAU--

