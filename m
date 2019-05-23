Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDD0C46460
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 16:18:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34DD021773
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 16:18:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34DD021773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40194 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTqQN-0002B5-CS
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 12:18:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hTqMP-0007pK-PM
	for qemu-devel@nongnu.org; Thu, 23 May 2019 12:14:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hTqMO-00043C-QV
	for qemu-devel@nongnu.org; Thu, 23 May 2019 12:14:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hTqMM-00041F-35; Thu, 23 May 2019 12:14:26 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 83F379FFCA;
	Thu, 23 May 2019 16:14:10 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.176])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A2101001E6F;
	Thu, 23 May 2019 16:14:07 +0000 (UTC)
To: Sam Eiderman <shmuel.eiderman@oracle.com>, kwolf@redhat.com,
	qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20190523154444.28783-1-shmuel.eiderman@oracle.com>
	<20190523154444.28783-3-shmuel.eiderman@oracle.com>
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
Message-ID: <fc179916-0fb5-bb50-da41-14789b020be9@redhat.com>
Date: Thu, 23 May 2019 18:14:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523154444.28783-3-shmuel.eiderman@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="svCYFK1y7doim8dGxj4TE761EgjFVb2i1"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Thu, 23 May 2019 16:14:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v4 2/3] qemu-img: rebase: Reduce reads on
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
--svCYFK1y7doim8dGxj4TE761EgjFVb2i1
From: Max Reitz <mreitz@redhat.com>
To: Sam Eiderman <shmuel.eiderman@oracle.com>, kwolf@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: eyal.moscovici@oracle.com, sagi.amit@oracle.com, karl.heubaum@oracle.com,
 liran.alon@oracle.com, arbel.moshe@oracle.com
Message-ID: <fc179916-0fb5-bb50-da41-14789b020be9@redhat.com>
Subject: Re: [PATCH v4 2/3] qemu-img: rebase: Reduce reads on in-chain rebase
References: <20190523154444.28783-1-shmuel.eiderman@oracle.com>
 <20190523154444.28783-3-shmuel.eiderman@oracle.com>
In-Reply-To: <20190523154444.28783-3-shmuel.eiderman@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 23.05.19 17:44, Sam Eiderman wrote:
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
> index 9bd0bb1e47..e6fd8e1a98 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c

[...]

> @@ -3437,6 +3443,23 @@ static int img_rebase(int argc, char **argv)
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

I think you forgot to update the patch...?

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



--svCYFK1y7doim8dGxj4TE761EgjFVb2i1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzmxs0ACgkQ9AfbAGHV
z0Bdlgf6A5iK+y0oVdXqMKrMqgmvB25Fh4CDFpMtxURv8uokNqSbKI/d910hIKQD
ZvMdcXhOOQpPTnvmzLzrJaf06D0NVyArv/kj83sqnSjQiwGuNxGW4fDSjo2MfAM7
sKGKdU147ncNeHxtqzEHKl71be5AeohppIwKMV/4Ua5Bgcaq+Bt3KbuOoDO8Rf75
61R2L5ZSS2UWf9SA3dmzHy/JIrQzRCCA9lWW6CHyOtWfZHehCwLfYQqr5FLUYInp
wg1JgOeprhJisI697hnCAay6tTlSD36cvv5tmhJclnreX8GKD2BbUiDcnOgmN7jv
IvMuyDcHHJtHV6r0HUYiIND+8ZCzoA==
=phUP
-----END PGP SIGNATURE-----

--svCYFK1y7doim8dGxj4TE761EgjFVb2i1--

