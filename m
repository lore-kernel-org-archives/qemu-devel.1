Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB263C31E4A
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 15:23:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7AD421743
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 15:23:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7AD421743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40850 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbRZ7-0006f1-1t
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 11:23:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56042)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hbQ3K-00083s-63
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 09:46:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hbQ3H-0000co-QF
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 09:46:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59487)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hbQ34-0000Rr-DN; Thu, 13 Jun 2019 09:45:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C310430860D1;
 Thu, 13 Jun 2019 13:45:40 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.187])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4CCF4541F0;
 Thu, 13 Jun 2019 13:45:30 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20190529154654.95870-1-vsementsov@virtuozzo.com>
 <20190529154654.95870-3-vsementsov@virtuozzo.com>
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
Message-ID: <dd3c1d3f-a92a-bbd7-a916-ba7b066ee5dc@redhat.com>
Date: Thu, 13 Jun 2019 15:45:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190529154654.95870-3-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VBikqgUIMp5eS9iZMySBLyDSJ9uABLP83"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Thu, 13 Jun 2019 13:45:40 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v8 2/7] block: swap operation order in
 bdrv_append
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
Cc: fam@euphon.net, kwolf@redhat.com, stefanha@redhat.com, den@openvz.org,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VBikqgUIMp5eS9iZMySBLyDSJ9uABLP83
Content-Type: multipart/mixed; boundary="B9JQ2dXiD0TDdJGgtq2mpVBPIemm3Z9DM";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: fam@euphon.net, stefanha@redhat.com, jsnow@redhat.com, kwolf@redhat.com,
 den@openvz.org, eblake@redhat.com
Message-ID: <dd3c1d3f-a92a-bbd7-a916-ba7b066ee5dc@redhat.com>
Subject: Re: [PATCH v8 2/7] block: swap operation order in bdrv_append
References: <20190529154654.95870-1-vsementsov@virtuozzo.com>
 <20190529154654.95870-3-vsementsov@virtuozzo.com>
In-Reply-To: <20190529154654.95870-3-vsementsov@virtuozzo.com>

--B9JQ2dXiD0TDdJGgtq2mpVBPIemm3Z9DM
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 29.05.19 17:46, Vladimir Sementsov-Ogievskiy wrote:
> bs_top parents may conflict with bs_new backing child permissions, so
> let's do bdrv_replace_node first, it covers more possible cases.
>=20
> It is needed for further implementation of backup-top filter, which
> don't want to share write permission on its backing child.
>=20
> Side effect is that we may set backing hd when device name is already
> available, so 085 iotest output is changed.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block.c                    | 11 ++++++++---
>  tests/qemu-iotests/085.out |  2 +-
>  2 files changed, 9 insertions(+), 4 deletions(-)
>=20
> diff --git a/block.c b/block.c
> index e6e9770704..57216f4115 100644
> --- a/block.c
> +++ b/block.c
> @@ -4088,22 +4088,27 @@ void bdrv_append(BlockDriverState *bs_new, Bloc=
kDriverState *bs_top,
>  {
>      Error *local_err =3D NULL;
> =20
> -    bdrv_set_backing_hd(bs_new, bs_top, &local_err);
> +    bdrv_ref(bs_top);
> +
> +    bdrv_replace_node(bs_top, bs_new, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
> +        error_prepend(errp, "Failed to replace node: ");
>          goto out;
>      }
> =20
> -    bdrv_replace_node(bs_top, bs_new, &local_err);
> +    bdrv_set_backing_hd(bs_new, bs_top, &local_err);
>      if (local_err) {
> +        bdrv_replace_node(bs_new, bs_top, &error_abort);

Hm.  I see the need for switching this stuff around, but this
&error_abort is much more difficult to verify than the previous one for
bdrv_set_backing_hd(..., NULL, ...).  I think it at least warrants a
comment why the order has to be this way (using git blame has the
disadvantage of fading over time as other people modify a piece of
code), and why this &error_abort is safe.

Max

>          error_propagate(errp, local_err);
> -        bdrv_set_backing_hd(bs_new, NULL, &error_abort);
> +        error_prepend(errp, "Failed to set backing: ");
>          goto out;
>      }
> =20
>      /* bs_new is now referenced by its new parents, we don't need the
>       * additional reference any more. */
>  out:
> +    bdrv_unref(bs_top);
>      bdrv_unref(bs_new);
>  }
> =20
> diff --git a/tests/qemu-iotests/085.out b/tests/qemu-iotests/085.out
> index 6edf107f55..e5a2645bf5 100644
> --- a/tests/qemu-iotests/085.out
> +++ b/tests/qemu-iotests/085.out
> @@ -74,7 +74,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1=
34217728 backing_file=3DTEST_DIR/
> =20
>  =3D=3D=3D Invalid command - snapshot node used as backing hd =3D=3D=3D=

> =20
> -{"error": {"class": "GenericError", "desc": "Node 'snap_11' is busy: n=
ode is used as backing hd of 'snap_12'"}}
> +{"error": {"class": "GenericError", "desc": "Node 'snap_11' is busy: n=
ode is used as backing hd of 'virtio0'"}}
> =20
>  =3D=3D=3D Invalid command - snapshot node has a backing image =3D=3D=3D=

> =20
>=20



--B9JQ2dXiD0TDdJGgtq2mpVBPIemm3Z9DM--

--VBikqgUIMp5eS9iZMySBLyDSJ9uABLP83
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0CU3gACgkQ9AfbAGHV
z0AzAgf/QX4kOVLV81+sA+F3llCweKYZHciFDmKGQMXsemeD3gZO0kpI1eN9FZzy
vrzCTvXDbggumkK20wTpETW63rO/MAAk51is6PMFFvOpbP6xoQSSqUo2bwv073kK
NZWtYiNxS+/mUWG4AUSIiKgzaZMlA/qe6WwGSJijmlUA3H760F4Oqvjhpa4Y6b0E
2pf8wMCzV21EYg0iYS4LFbcfpZlXfhLai1B4x/bV6yfYBI1bw/8lX9rmmBR6AdtS
eaddYkW7MRGRj3PSaJZ9dCR5bAc9hPqOxZnWzp0kasP5xrLW7dHfKVu3jYbgFcW3
Fo8bxssKVsfPf6gh3CYwPo+h1NozXg==
=n/2+
-----END PGP SIGNATURE-----

--VBikqgUIMp5eS9iZMySBLyDSJ9uABLP83--

