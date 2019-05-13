Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9ED8C04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 14:33:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B35E0208C3
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 14:33:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B35E0208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58422 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQC0v-0003J2-IW
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 10:33:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hQBzA-0002XZ-8G
	for qemu-devel@nongnu.org; Mon, 13 May 2019 10:31:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hQBz9-00017a-AF
	for qemu-devel@nongnu.org; Mon, 13 May 2019 10:31:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hQBz6-00014n-Ot; Mon, 13 May 2019 10:31:20 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 43EC7307C94F;
	Mon, 13 May 2019 14:31:19 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.206.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id F036E1001DE1;
	Mon, 13 May 2019 14:31:17 +0000 (UTC)
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1557754872.git.berto@igalia.com>
	<20dfb3d9ccec559cdd1a9690146abad5d204a186.1557754872.git.berto@igalia.com>
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
Message-ID: <5783a050-5866-80d5-4699-7ea0bf122398@redhat.com>
Date: Mon, 13 May 2019 16:31:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20dfb3d9ccec559cdd1a9690146abad5d204a186.1557754872.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="t974NlSDzOl3d1xWbLGZYVng0SMqck0zD"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Mon, 13 May 2019 14:31:19 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v3 2/2] block: Make
 bdrv_root_attach_child() unref child_bs on failure
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--t974NlSDzOl3d1xWbLGZYVng0SMqck0zD
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <5783a050-5866-80d5-4699-7ea0bf122398@redhat.com>
Subject: Re: [PATCH v3 2/2] block: Make bdrv_root_attach_child() unref
 child_bs on failure
References: <cover.1557754872.git.berto@igalia.com>
 <20dfb3d9ccec559cdd1a9690146abad5d204a186.1557754872.git.berto@igalia.com>
In-Reply-To: <20dfb3d9ccec559cdd1a9690146abad5d204a186.1557754872.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13.05.19 15:46, Alberto Garcia wrote:
> A consequence of the previous patch is that bdrv_attach_child()
> transfers the reference to child_bs from the caller to parent_bs,
> which will drop it on bdrv_close() or when someone calls
> bdrv_unref_child().
>=20
> But this only happens when bdrv_attach_child() succeeds. If it fails
> then the caller is responsible for dropping the reference to child_bs.
>=20
> This patch makes bdrv_attach_child() take the reference also when
> there is an error, freeing the caller for having to do it.
>=20
> A similar situation happens with bdrv_root_attach_child(), so the
> changes on this patch affect both functions.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block.c               | 25 +++++++++++++++++--------
>  block/block-backend.c |  3 +--
>  block/quorum.c        |  1 -
>  blockjob.c            |  2 +-
>  4 files changed, 19 insertions(+), 12 deletions(-)
>=20
> diff --git a/block.c b/block.c
> index 3c3bd0f8d2..df727314ff 100644
> --- a/block.c
> +++ b/block.c

[...]

> @@ -2569,10 +2582,6 @@ BdrvChild *bdrv_open_child(const char *filename,=

>      }
> =20
>      c =3D bdrv_attach_child(parent, bs, bdref_key, child_role, errp);
> -    if (!c) {
> -        bdrv_unref(bs);
> -        return NULL;
> -    }
> =20
>      return c;
>  }

(That could have been simplified even further. *shrug*)


--t974NlSDzOl3d1xWbLGZYVng0SMqck0zD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzZf7QACgkQ9AfbAGHV
z0DdOQf/bKdfYar4Uvwzi4oYIIF219eU+BCwL054KjyO3eyjp4xlSdLCO6BOFKsC
akGyQUhVW/4oL3d+88oaQi/18hnXBWlRWZD+16ZRDUKwOzI/ynDxbs3lNepVObwv
8ixfUSqG67edj6DU+iVLBT3I19Jx2vcTptjdVLmIchV9XkoMLFIiBgWg5y6JpIvM
Cg07zIsfMbw314YTgqLXdmP0tA5NqjKhaCP81d+0DMtN67fKaUDf/29U76JgLNaN
YkoUVVLk/ZnCTHXeqpxWVyJNmopYxPoeTZ6rLrw+oB0ga/AyCpcKcqjUASUzJ4dm
f9RBDnD2X7fVTY9cHhkZd3BSXXJhkA==
=P0QD
-----END PGP SIGNATURE-----

--t974NlSDzOl3d1xWbLGZYVng0SMqck0zD--

