Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C60C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:12:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 271A420863
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:12:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 271A420863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37127 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hToSo-000050-Ay
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 10:12:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hToIP-0006wo-2u
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:02:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hToIK-0004vr-7F
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:02:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hToIA-0004oY-7G; Thu, 23 May 2019 10:01:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ED17F30C1217;
	Thu, 23 May 2019 14:01:51 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.176])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C006568367;
	Thu, 23 May 2019 14:01:49 +0000 (UTC)
To: Sam Eiderman <shmuel.eiderman@oracle.com>, kwolf@redhat.com,
	qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20190502085029.30776-1-shmuel.eiderman@oracle.com>
	<20190502135828.42797-1-shmuel.eiderman@oracle.com>
	<20190502135828.42797-3-shmuel.eiderman@oracle.com>
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
Message-ID: <c117d2e2-eef2-df4f-ef3d-37a33426dd51@redhat.com>
Date: Thu, 23 May 2019 16:01:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190502135828.42797-3-shmuel.eiderman@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="s6sKGehxa1AM7u7r2jKzqX62fI2qScy63"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Thu, 23 May 2019 14:01:52 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v2 2/3] qemu-img: rebase: Reduce reads on
 in-chain rebase
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
Cc: sagi.amit@oracle.com, arbel.moshe@oracle.com, liran.alon@oracle.com,
	eyal.moscovici@oracle.com, karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--s6sKGehxa1AM7u7r2jKzqX62fI2qScy63
From: Max Reitz <mreitz@redhat.com>
To: Sam Eiderman <shmuel.eiderman@oracle.com>, kwolf@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: eyal.moscovici@oracle.com, sagi.amit@oracle.com, karl.heubaum@oracle.com,
 liran.alon@oracle.com, arbel.moshe@oracle.com
Message-ID: <c117d2e2-eef2-df4f-ef3d-37a33426dd51@redhat.com>
Subject: Re: [PATCH v2 2/3] qemu-img: rebase: Reduce reads on in-chain rebase
References: <20190502085029.30776-1-shmuel.eiderman@oracle.com>
 <20190502135828.42797-1-shmuel.eiderman@oracle.com>
 <20190502135828.42797-3-shmuel.eiderman@oracle.com>
In-Reply-To: <20190502135828.42797-3-shmuel.eiderman@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02.05.19 15:58, Sam Eiderman wrote:
> In the following case:
>=20
> (base) A <- B <- C (tip)
>=20
> when running:
>=20
>     qemu-img rebase -b A C
>=20
> QEMU would read all sectors not allocated in the file being rebased (C)=

> and compare them to the new base image (A), regardless of whether they
> were changed or even allocated anywhere along the chain between the new=

> base and the top image (B). This causes many unneeded reads when
> rebasing an image which represents a small diff of a large disk, as it
> would read most of the disk's sectors.
>=20
> Instead, use bdrv_is_allocated_above() to reduce the number of
> unnecessary reads.
>=20
> Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
> Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
> Signed-off-by: Eyal Moscovici <eyal.moscovici@oracle.com>
> ---
>  qemu-img.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
>=20
> diff --git a/qemu-img.c b/qemu-img.c
> index d9b609b3f0..7f20858cb9 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c

[...]

> @@ -3422,6 +3428,23 @@ static int img_rebase(int argc, char **argv)
>                  continue;
>              }
> =20
> +            if (prefix_chain_bs) {
> +                /*
> +                 * If cluster wasn't changed since prefix_chain, we do=
n't need
> +                 * to take action
> +                 */
> +                ret =3D bdrv_is_allocated_above(bs, prefix_chain_bs,
> +                                              offset, n, &n);

This will always return true because it definitely is allocated in @bs,
or we wouldn=E2=80=99t be here.  (We just checked that with
bdrv_is_allocated().)  I think @top should be backing_bs(bs).

Max

> +                if (ret < 0) {
> +                    error_report("error while reading image metadata: =
%s",
> +                                 strerror(-ret));
> +                    goto out;
> +                }
> +                if (!ret) {
> +                    continue;
> +                }
> +            }
> +
>              /*
>               * Read old and new backing file and take into considerati=
on that
>               * backing files may be smaller than the COW image.
>=20



--s6sKGehxa1AM7u7r2jKzqX62fI2qScy63
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzmp8wACgkQ9AfbAGHV
z0DC4AgArkNz2w/pi46i1kT3xZfnoFRLrPpZZ91hG/6HEurEb1/XN12F0/PeNRpZ
0hnL2n5hVnrudqZPxk0sJ58s0utVBOaR0JKdA+x9LIHKNnLDx2zsMLEhp+6DneiN
mg+nU8w+yBW0WM1dwr7st1gTmyhDWibTHuVOYXhE+t2lD/WpX0ymNTTp8VJrQ+rc
kmJrv/1IS7VwUkGLlGpA0W34MexTOXs8o4cyyKYGGQBAbz6RMRU5g+dCNdKvU1WG
7orAqWUfMx4dZmUAYf6/66wiNAjCLq9+ufM61miG0GwzAGEzpvTbuLKjuuc8QNME
LRlMyS7E1EmV7HKAKfLDuhEUqBXD2A==
=E2Q0
-----END PGP SIGNATURE-----

--s6sKGehxa1AM7u7r2jKzqX62fI2qScy63--

