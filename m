Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F119FC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 16:55:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C34DA22CED
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 16:55:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C34DA22CED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i31Ds-0000c1-IE
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 12:55:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38470)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i310T-0004bq-E4
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 12:41:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i310S-0000wk-5Q
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 12:41:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57172)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i310N-0000u3-El; Wed, 28 Aug 2019 12:41:07 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8DB1CC04959E;
 Wed, 28 Aug 2019 16:41:06 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-32.brq.redhat.com
 [10.40.204.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D843E6012D;
 Wed, 28 Aug 2019 16:40:58 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20190826161312.489398-1-vsementsov@virtuozzo.com>
 <20190826161312.489398-8-vsementsov@virtuozzo.com>
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
Message-ID: <8700abe3-01a0-9395-59fb-ca78d9f05a30@redhat.com>
Date: Wed, 28 Aug 2019 18:40:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826161312.489398-8-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Q7xZIY48ugaM74Hc1P5pUnQdwly5ITro5"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Wed, 28 Aug 2019 16:41:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v9 07/13] iotests: prepare 124 and 257
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
--Q7xZIY48ugaM74Hc1P5pUnQdwly5ITro5
Content-Type: multipart/mixed; boundary="JXWQCGFSBq2jnpQ2O4TC3fh7XxzcJxJk5";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, eblake@redhat.com, armbru@redhat.com,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, fam@euphon.net,
 stefanha@redhat.com, jsnow@redhat.com, kwolf@redhat.com, den@openvz.org
Message-ID: <8700abe3-01a0-9395-59fb-ca78d9f05a30@redhat.com>
Subject: Re: [PATCH v9 07/13] iotests: prepare 124 and 257 bitmap querying for
 backup-top filter
References: <20190826161312.489398-1-vsementsov@virtuozzo.com>
 <20190826161312.489398-8-vsementsov@virtuozzo.com>
In-Reply-To: <20190826161312.489398-8-vsementsov@virtuozzo.com>

--JXWQCGFSBq2jnpQ2O4TC3fh7XxzcJxJk5
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26.08.19 18:13, Vladimir Sementsov-Ogievskiy wrote:
> After backup-top filter appearing it's not possible to see dirty
> bitmaps in top node, so use node-name instead.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  tests/qemu-iotests/124        |   3 +-
>  tests/qemu-iotests/257        |  39 +---
>  tests/qemu-iotests/257.out    | 364 +++++++++++++---------------------=

>  tests/qemu-iotests/iotests.py |  22 ++
>  4 files changed, 173 insertions(+), 255 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/124 b/tests/qemu-iotests/124
> index 3440f54781..8b6024769c 100755
> --- a/tests/qemu-iotests/124
> +++ b/tests/qemu-iotests/124
> @@ -749,8 +749,7 @@ class TestIncrementalBackupBlkdebug(TestIncremental=
BackupBase):
> =20
>          # Bitmap Status Check
>          query =3D self.vm.qmp('query-block')
> -        ret =3D [bmap for bmap in query['return'][0]['dirty-bitmaps']
> -               if bmap.get('name') =3D=3D bitmap.name][0]
> +        ret =3D self.vm.get_bitmap(None, drive0['id'], bitmap.name)
>          self.assert_qmp(ret, 'count', 458752)
>          self.assert_qmp(ret, 'granularity', 65536)
>          self.assert_qmp(ret, 'status', 'frozen')

I see a couple more instances of querying the bitmaps through
query-block here.  Wouldn=E2=80=99t it make sense to replace them all wit=
h
get_bitmap()?

[...]

> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests=
=2Epy
> index 84438e837c..9381964d9f 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -643,6 +643,28 @@ class VM(qtest.QEMUQtestMachine):
>                  return x
>          return None
> =20
> +    def query_bitmaps(self):
> +        res =3D self.qmp("query-named-block-nodes")
> +        return {"bitmaps": {device['node-name']: device['dirty-bitmaps=
']
> +                                for device in res['return']
> +                                    if 'dirty-bitmaps' in device}}

I=E2=80=99d leave the wrapping in {"bitmaps": x} to the callers, if they =
need it.

> +
> +    def get_bitmap(self, bitmaps, node_name, name, recording=3DNone):
> +        """
> +        get a specific bitmap from the object returned by query_bitmap=
s.
> +        :param recording: If specified, filter results by the specifie=
d value.
> +        """
> +        if bitmaps is None:
> +            bitmaps =3D self.query_bitmaps()
> +
> +        for bitmap in bitmaps['bitmaps'][node_name]:
> +            if bitmap.get('name', '') =3D=3D name:
> +                if recording is None:
> +                    return bitmap
> +                elif bitmap.get('recording') =3D=3D recording:
> +                    return bitmap

Maybe add a =E2=80=9Cbreak=E2=80=9D or =E2=80=9Creturn None=E2=80=9D here=
?

(Yes, yes, you just moved existing code.  Still.)

Max

> +        return None
> +
> =20
>  index_re =3D re.compile(r'([^\[]+)\[([^\]]+)\]')
> =20
>=20



--JXWQCGFSBq2jnpQ2O4TC3fh7XxzcJxJk5--

--Q7xZIY48ugaM74Hc1P5pUnQdwly5ITro5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1mrpkACgkQ9AfbAGHV
z0DlUQf+LyB6pC19Jf+0wdUyeBlsUkr7TCHwvvE8hXLHklLoAoXeR2de3LVG0I8y
EzB+kffdlG7w3P0i4lYdX+uGov4i6/pbbWVAw7p1pls62t5L3CpkEcbRC68dATXR
ZoHWcTOZGhIp0d2t8LknH0AFAcGfHs4Mo2zLk38SjXs4UVzEPKgkF624qYXoKVvJ
ulT5nwPogwC1sw35/GQDBiJYsfH6HsoO3JUjQkVB10bkc+XpX88yFRkiFWgUJ8+S
Z/9DB4gz2TyYrLnQKE+XlA9ThStaf2RaV8eWo98iT+3AT5m7e5CwkOT1wjUn9tTG
yjbJxt0khg2Oz98limCEEfF1l3oXWQ==
=VOhO
-----END PGP SIGNATURE-----

--Q7xZIY48ugaM74Hc1P5pUnQdwly5ITro5--

