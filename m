Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60770C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 15:42:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 390C420673
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 15:42:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 390C420673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49510 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdzCZ-0002wn-H8
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 11:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47969)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hdyw4-0005lu-OK
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 11:25:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hdyw3-0006O2-Ko
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 11:25:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35026)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hdyw0-0006IT-N7; Thu, 20 Jun 2019 11:25:09 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8CC1E308621B;
 Thu, 20 Jun 2019 15:25:07 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0685E60BE0;
 Thu, 20 Jun 2019 15:25:02 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20190620010356.19164-1-jsnow@redhat.com>
 <20190620010356.19164-4-jsnow@redhat.com>
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
Message-ID: <f3afc686-a37e-3c58-571c-96ae17c16414@redhat.com>
Date: Thu, 20 Jun 2019 17:25:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190620010356.19164-4-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BsFCE9uDTTd3EszbRCONjWk5HAQHSYbqF"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Thu, 20 Jun 2019 15:25:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 03/12] block/backup: add 'never' policy to
 bitmap sync mode
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 vsementsov@virtuozzo.com, Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BsFCE9uDTTd3EszbRCONjWk5HAQHSYbqF
Content-Type: multipart/mixed; boundary="g2RNTy14zQclwpZkQ73H49fnymtxgOSXG";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 eblake@redhat.com, vsementsov@virtuozzo.com,
 Markus Armbruster <armbru@redhat.com>, Fam Zheng <fam@euphon.net>,
 Xie Changlong <xiechanglong.d@gmail.com>
Message-ID: <f3afc686-a37e-3c58-571c-96ae17c16414@redhat.com>
Subject: Re: [PATCH 03/12] block/backup: add 'never' policy to bitmap sync
 mode
References: <20190620010356.19164-1-jsnow@redhat.com>
 <20190620010356.19164-4-jsnow@redhat.com>
In-Reply-To: <20190620010356.19164-4-jsnow@redhat.com>

--g2RNTy14zQclwpZkQ73H49fnymtxgOSXG
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 20.06.19 03:03, John Snow wrote:
> This adds a "never" policy for bitmap synchronization. Regardless of if=

> the job succeeds or fails, we never update the bitmap. This can be used=

> to perform differential backups, or simply to avoid the job modifying a=

> bitmap.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qapi/block-core.json | 6 +++++-
>  block/backup.c       | 5 +++--
>  2 files changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 6d05ad8f47..0332dcaabc 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1146,10 +1146,14 @@
>  # @conditional: The bitmap is only synchronized when the operation is =
successul.
>  #               This is useful for Incremental semantics.
>  #
> +# @never: The bitmap is never synchronized with the operation, and is
> +#         treated solely as a manifest of blocks to copy.
> +#         This is useful for Differential semantics.
> +#

Again, this is too buzzword-y for my taste.  I don=E2=80=99t find it as b=
ad
because there is not much to explain about this mode, and you do explain
it above, but still.

Like, I (me myself) read this and after the first sentence I think I=E2=80=
=99ve
understood what this is.  Then I read =E2=80=9Cfor Differential semantics=
=E2=80=9D and
I=E2=80=99m confused.  After a couple of seconds, I realize what you mean=

because I=E2=80=99ve described in my response to patch 1.

One reason it leaves the buzzword-y taste is because =E2=80=9Cdifferentia=
l=E2=80=9D is
never explained anywhere.  bitmaps.rst makes two mentions of it, but it
too just assumes I know what you mean.  Also, incremental backups are
just a certain kind of differential backups.

So you need to explain =E2=80=9Cdifferential=E2=80=9D somewhere and how i=
t differs from
=E2=80=9Cincremental=E2=80=9D in this regard.  Why not here?

=E2=80=9CThis is useful when you wish to repeatedly perform operations in=

reference to a constant synchronization point (when the bitmap was
created).=E2=80=9D

Or something.

Max

>  # Since: 4.1
>  ##
>  { 'enum': 'BitmapSyncMode',
> -  'data': ['conditional'] }
> +  'data': ['conditional', 'never'] }
> =20
>  ##
>  # @MirrorCopyMode:


--g2RNTy14zQclwpZkQ73H49fnymtxgOSXG--

--BsFCE9uDTTd3EszbRCONjWk5HAQHSYbqF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0LpU0ACgkQ9AfbAGHV
z0BKxwf8DixyOX4AbowOWamDs0MTCIJv4QtNHPndH1iiOj8aiPx+lSKfG92jWgXY
SCTg9zOm7b3Xxtcbs/UOnVGZet/SWJUtBQoItk4aXrsJYxjLfsRzmzbk01+HEJ9f
zLBIa7IGPXpfJmXqbAMxNsSr0K+TgyHJSGA+wMLNbDXUtITjX8tM2hgYhtFc3hEZ
jUlLdD/lK2uzLXtp0LQDaDo+njrjWJCjJ85K1fVRLtfeGq/MNYXWQTDssMu2UqHP
28gPMVCFvW1GyhiSeEVulXMqmAmK63co8XGmypNU7dnmVqt5YMSjWv97C36IlomW
H/Sg428AoGsOWG37Og+0OZW/DP+YXw==
=mC4w
-----END PGP SIGNATURE-----

--BsFCE9uDTTd3EszbRCONjWk5HAQHSYbqF--

