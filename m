Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D882EC7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 11:45:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB436206B8
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 11:45:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB436206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmzQC-0003ic-NQ
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 07:45:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54505)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hmzPz-0003Fm-Eq
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 07:45:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hmzPy-0001Wl-Ec
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 07:45:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51178)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hmzPw-0001V1-6j; Mon, 15 Jul 2019 07:45:16 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 24B7783F4C;
 Mon, 15 Jul 2019 11:45:15 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4291F6012C;
 Mon, 15 Jul 2019 11:44:56 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20190708220502.12977-1-jsnow@redhat.com>
 <20190708220502.12977-4-jsnow@redhat.com>
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
Message-ID: <bda05664-9e59-9088-0109-7e6372547c6b@redhat.com>
Date: Mon, 15 Jul 2019 13:44:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190708220502.12977-4-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ccGzMyfbLL6K16pS3SvuctNBqXPaqWb38"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Mon, 15 Jul 2019 11:45:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 3/3] iotests: test bitmap moving inside
 254
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 vsementsov@virtuozzo.com, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ccGzMyfbLL6K16pS3SvuctNBqXPaqWb38
Content-Type: multipart/mixed; boundary="TsDN3vcpc9oSLuBcBckWe84AessbSImNn";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 vsementsov@virtuozzo.com, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <bda05664-9e59-9088-0109-7e6372547c6b@redhat.com>
Subject: Re: [PATCH v3 3/3] iotests: test bitmap moving inside 254
References: <20190708220502.12977-1-jsnow@redhat.com>
 <20190708220502.12977-4-jsnow@redhat.com>
In-Reply-To: <20190708220502.12977-4-jsnow@redhat.com>

--TsDN3vcpc9oSLuBcBckWe84AessbSImNn
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09.07.19 00:05, John Snow wrote:
> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20
> Test persistent bitmap copying with and without removal of original
> bitmap.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/qemu-iotests/254     | 30 +++++++++++++-
>  tests/qemu-iotests/254.out | 82 ++++++++++++++++++++++++++++++++++++++=

>  2 files changed, 110 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/254 b/tests/qemu-iotests/254
> index 8edba91c5d..9a57bccc26 100755
> --- a/tests/qemu-iotests/254
> +++ b/tests/qemu-iotests/254

[...]

> @@ -39,16 +43,38 @@ vm.qmp_log('transaction', indent=3D2, actions=3D[
>      {'type': 'blockdev-snapshot-sync',
>       'data': {'device': 'drive0', 'snapshot-file': top,
>                'snapshot-node-name': 'snap'}},
> +
> +    # copy non-persistent bitmap0
>      {'type': 'block-dirty-bitmap-add',
>       'data': {'node': 'snap', 'name': 'bitmap0'}},
>      {'type': 'block-dirty-bitmap-merge',
>       'data': {'node': 'snap', 'target': 'bitmap0',
> -              'bitmaps': [{'node': 'base', 'name': 'bitmap0'}]}}
> +              'bitmaps': [{'node': 'base', 'name': 'bitmap0'}]}},
> +
> +    # copy persistent bitmap1, original will be saved to base image
> +    {'type': 'block-dirty-bitmap-add',
> +     'data': {'node': 'snap', 'name': 'bitmap1', 'persistent': True}},=

> +    {'type': 'block-dirty-bitmap-merge',
> +     'data': {'node': 'snap', 'target': 'bitmap1',
> +              'bitmaps': [{'node': 'base', 'name': 'bitmap1'}]}},
> +
> +    # move persistent bitmap1, original will be removed and not saved

*bitmap2

Reviewed-by: Max Reitz <mreitz@redhat.com>

> +    # to base image
> +    {'type': 'block-dirty-bitmap-add',
> +     'data': {'node': 'snap', 'name': 'bitmap2', 'persistent': True}},=

> +    {'type': 'block-dirty-bitmap-merge',
> +     'data': {'node': 'snap', 'target': 'bitmap2',
> +              'bitmaps': [{'node': 'base', 'name': 'bitmap2'}]}},
> +    {'type': 'block-dirty-bitmap-remove',
> +     'data': {'node': 'base', 'name': 'bitmap2'}}
>  ], filters=3D[iotests.filter_qmp_testfiles])


--TsDN3vcpc9oSLuBcBckWe84AessbSImNn--

--ccGzMyfbLL6K16pS3SvuctNBqXPaqWb38
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0sZzUACgkQ9AfbAGHV
z0CUwggAilzTF6vnNP83er0PmghEHsKe0qvy/12kMSdZ8qkpkYgE6vbTGszDKQJq
rgCxGwyGS2IWPQE0NIEKEnzbzHaAYb7yrA+HZQwHRxjua2wSe+xauLvsSmCaP4oR
ZXDb1hLRTqPe5mqrtAEZFnNVWZ/GCUYsUudW65AnGnNwuIKW00thZNJRl586SiyM
wUXorAuG/TgVSUXJQwJ3kBqSWkm9kbUnB7cJsbrapEZ3mpLn2cowBZxQe71/Ki1h
bVRA5Pn1NdX0W9/I2sSTzUlN/I+6QHWklR/9U77wwxP5yEEii+jM7MUVC7xWHB+t
V6Xgk4nUhfNBypTiGZDR1n96niqspA==
=4qlG
-----END PGP SIGNATURE-----

--ccGzMyfbLL6K16pS3SvuctNBqXPaqWb38--

