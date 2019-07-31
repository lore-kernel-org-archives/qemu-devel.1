Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A35C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 09:07:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAF6D2067D
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 09:07:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF6D2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hska0-0004Oj-2D
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 05:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55756)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hskZY-0003vk-5J
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 05:07:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hskZX-0001Vz-5a
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 05:07:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57218)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hskZU-0001VC-RK; Wed, 31 Jul 2019 05:06:57 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 362BB81F18;
 Wed, 31 Jul 2019 09:06:56 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-44.ams2.redhat.com
 [10.36.117.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C004E1000329;
 Wed, 31 Jul 2019 09:06:54 +0000 (UTC)
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20190730172508.19911-1-mreitz@redhat.com>
 <20190730172508.19911-9-mreitz@redhat.com>
 <fdce3796-8a60-cf7e-cb07-72a21d226b94@redhat.com>
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
Message-ID: <f2fdcde0-d363-8e3d-e705-3931535c4060@redhat.com>
Date: Wed, 31 Jul 2019 11:06:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <fdce3796-8a60-cf7e-cb07-72a21d226b94@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WNCqFY6v4v0mDJWuI3vyw0cC8EoZ0v8Ml"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Wed, 31 Jul 2019 09:06:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.2 08/13] qcow2: Fix broken snapshot
 table entries
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WNCqFY6v4v0mDJWuI3vyw0cC8EoZ0v8Ml
Content-Type: multipart/mixed; boundary="aQUIwxmaRjpto4Zd44frl2RQXrKVxAvio";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <f2fdcde0-d363-8e3d-e705-3931535c4060@redhat.com>
Subject: Re: [PATCH for-4.2 08/13] qcow2: Fix broken snapshot table entries
References: <20190730172508.19911-1-mreitz@redhat.com>
 <20190730172508.19911-9-mreitz@redhat.com>
 <fdce3796-8a60-cf7e-cb07-72a21d226b94@redhat.com>
In-Reply-To: <fdce3796-8a60-cf7e-cb07-72a21d226b94@redhat.com>

--aQUIwxmaRjpto4Zd44frl2RQXrKVxAvio
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 30.07.19 21:02, Eric Blake wrote:
> On 7/30/19 12:25 PM, Max Reitz wrote:
>> The only case where we currently reject snapshot table entries is when=

>> they have too much extra data.  Fix them with qemu-img check -r all by=

>> counting it as a corruption, reducing their extra_data_size, and then
>> letting qcow2_check_fix_snapshot_table() do the rest.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/qcow2-snapshot.c | 69 ++++++++++++++++++++++++++++++++++-------=
-
>>  1 file changed, 56 insertions(+), 13 deletions(-)
>>
>=20
>> @@ -112,16 +141,22 @@ int qcow2_read_snapshots(BlockDriverState *bs, E=
rror **errp)
>>          }
>> =20
>>          if (sn->extra_data_size > sizeof(extra)) {
>> -            /* Store unknown extra data */
>>              size_t unknown_extra_data_size =3D
>>                  sn->extra_data_size - sizeof(extra);
>> =20
>> -            sn->unknown_extra_data =3D g_malloc(unknown_extra_data_si=
ze);
>> -            ret =3D bdrv_pread(bs->file, offset, sn->unknown_extra_da=
ta,
>> -                             unknown_extra_data_size);
>> -            if (ret < 0) {
>> -                error_setg_errno(errp, -ret, "Failed to read snapshot=
 table");
>> -                goto fail;
>> +            if (discard_unknown_extra_data) {
>> +                /* Discard unknown extra data */
>> +                sn->extra_data_size =3D sizeof(extra);
>=20
> This truncates it down to just the data we know. Should it instead
> truncate down to the 1024 bytes of QCOW_MAX_SNAPSHOT_EXTRA_DATA defined=

> in 2/13?  (We can't keep all of the user's extra stuff, but we can at
> least try to preserve as much as possible)

On one hand, potentially cutting unknown data in half sounds like not
such a good idea to me.

On the other, a field can only be considered present if it is fully
present.  So cutting any optional data in half shouldn=E2=80=99t have any=

negative impact.

So, yes, truncating it down to 1024 bytes sounds good.

Max

> Otherwise, looks good.
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20



--aQUIwxmaRjpto4Zd44frl2RQXrKVxAvio--

--WNCqFY6v4v0mDJWuI3vyw0cC8EoZ0v8Ml
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1BWiwACgkQ9AfbAGHV
z0CiTggAqmGIYRJ/LX9BbE2vanEyUH4aJizCDAhGFI6sj/LOJomF0o1ARS/MY2eu
9yKSUJzIhCeZikZJsg/Pflc5DxAjPhzxjU469uaW8Jw5TufJIxULfRtKUAZcFFHp
RaLLbiV40U+IQtyJvchFz0FdIzC5wBoPcxpXFRJQdJFlh1bth0S7+18oF/76bdNv
HzBV34/kugK66DQt95BWkgQTKqAyR52kXNi8Xc6VZ9BWkrNjMqmRTDvV7Jvublqu
MUOg4+H/XL1rtuCeaVKF7z5sXfWfjGNHAmPqmwmOjAn8p2D14WIZ4AN2L4rFgafy
tENEQQigigCa7oEQPwjVPKCwc0xV3A==
=f2cU
-----END PGP SIGNATURE-----

--WNCqFY6v4v0mDJWuI3vyw0cC8EoZ0v8Ml--

