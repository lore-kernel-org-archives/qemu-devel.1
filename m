Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA746C74A21
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 16:50:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A717120665
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 16:50:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A717120665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlFnR-0001ZZ-DS
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 12:50:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38252)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hlFmC-0000vx-Ns
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 12:49:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hlFmB-0001B6-PR
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 12:49:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60668)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hlFm5-0000p8-HT; Wed, 10 Jul 2019 12:48:59 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CB5065AFF8;
 Wed, 10 Jul 2019 16:48:53 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DAE9A60141;
 Wed, 10 Jul 2019 16:48:48 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20190710010556.32365-1-jsnow@redhat.com>
 <20190710010556.32365-8-jsnow@redhat.com>
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
Message-ID: <01ddc5da-c4e1-864e-ee0d-e39036d6d4dd@redhat.com>
Date: Wed, 10 Jul 2019 18:48:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190710010556.32365-8-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2GUMKSUQX5fvNxRjcXoWBfVbqZNzx2GVq"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Wed, 10 Jul 2019 16:48:53 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 7/8] block/backup: support bitmap sync
 modes for non-bitmap backups
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
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2GUMKSUQX5fvNxRjcXoWBfVbqZNzx2GVq
Content-Type: multipart/mixed; boundary="D2vPYTo1A7DbfKRepr2imBcM57KF6TWx5";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>
Message-ID: <01ddc5da-c4e1-864e-ee0d-e39036d6d4dd@redhat.com>
Subject: Re: [PATCH 7/8] block/backup: support bitmap sync modes for
 non-bitmap backups
References: <20190710010556.32365-1-jsnow@redhat.com>
 <20190710010556.32365-8-jsnow@redhat.com>
In-Reply-To: <20190710010556.32365-8-jsnow@redhat.com>

--D2vPYTo1A7DbfKRepr2imBcM57KF6TWx5
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10.07.19 03:05, John Snow wrote:
> Accept bitmaps and sync policies for the other backup modes.
> This allows us to do things like create a bitmap synced to a full backu=
p
> without a transaction, or start a resumable backup process.
>=20
> Some combinations don't make sense, though:
>=20
> - NEVER policy combined with any non-BITMAP mode doesn't do anything,
>   because the bitmap isn't used for input or output.
>   It's harmless, but is almost certainly never what the user wanted.
>=20
> - sync=3DNONE is more questionable. It can't use on-success because thi=
s
>   job never completes with success anyway, and the resulting artifact
>   of 'always' is suspect: because we start with a full bitmap and only
>   copy out segments that get written to, the final output bitmap will
>   always be ... a fully set bitmap.
>=20
>   Maybe there's contexts in which bitmaps make sense for sync=3Dnone,
>   but not without more severe changes to the current job, and omitting
>   it here doesn't prevent us from adding it later.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/backup.c       |  8 +-------
>  blockdev.c           | 22 ++++++++++++++++++++++
>  qapi/block-core.json |  6 ++++--
>  3 files changed, 27 insertions(+), 9 deletions(-)

[...]

> diff --git a/blockdev.c b/blockdev.c
> index f0b7da53b0..bc152f8e0d 100644
> --- a/blockdev.c
> +++ b/blockdev.c

[...]

> +    if (!backup->has_bitmap && backup->has_bitmap_mode) {
> +        error_setg(errp, "Cannot specify Bitmap sync mode without a bi=
tmap");

Any reason for capitalizing the first =E2=80=9CBitmap=E2=80=9D?

With a reason or it fixed:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--D2vPYTo1A7DbfKRepr2imBcM57KF6TWx5--

--2GUMKSUQX5fvNxRjcXoWBfVbqZNzx2GVq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0mFu8ACgkQ9AfbAGHV
z0ARFggAugsRshaHH0+29U0HjaEqG7IkrP6dTuEkHjD/KSd+ARKV7FeJgfBI9uIz
i6qY54abkMtp+QDhKstR2uyu3aO1EV4vaA15fvJStEQDie9b78wFIbJZcPWTyZJr
c8UJfe3vQTqmxP+aBSQ/JZUyykKAbmQqic6rmRU7le7RpNp4MVOYCwsDBieIHn3J
Rgwr4AueW7sPOueUuQAmUMKFtBqTUvdFJrojlLRBcIFqYBHTBnUR4ISDbRmFEoxv
4CM5yvaNWNLn5J4OisOi+R59dL/9MgG7oam3DHVz+FeDYGaQS12ykZQZ/fyu7gau
4nJ5d9IngVzsCNPo2VgyZ+o+kQv+PA==
=kECK
-----END PGP SIGNATURE-----

--2GUMKSUQX5fvNxRjcXoWBfVbqZNzx2GVq--

