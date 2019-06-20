Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0C8C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 14:35:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 338982064B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 14:35:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 338982064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48330 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdyAK-0003yP-UL
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 10:35:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37832)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hdy5r-0001AM-RT
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 10:33:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hdxyP-0005Of-RU
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 10:25:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47324)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hdxwa-0004Jw-9W; Thu, 20 Jun 2019 10:21:41 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B37E630C0DC2;
 Thu, 20 Jun 2019 14:21:32 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DD4019C4F;
 Thu, 20 Jun 2019 14:21:27 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20190620010356.19164-1-jsnow@redhat.com>
 <20190620010356.19164-2-jsnow@redhat.com>
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
Message-ID: <d671f373-77d1-d475-ff23-30bd7674c6df@redhat.com>
Date: Thu, 20 Jun 2019 16:21:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190620010356.19164-2-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="iV4RdhEYnAWY9zIp5Im1BXp1uDa80diTE"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Thu, 20 Jun 2019 14:21:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 01/12] qapi: add BitmapSyncMode enum
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
--iV4RdhEYnAWY9zIp5Im1BXp1uDa80diTE
Content-Type: multipart/mixed; boundary="ST1J5Omq9yA8FbeUpP3LhBMAEK5IiPnwh";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 eblake@redhat.com, vsementsov@virtuozzo.com,
 Markus Armbruster <armbru@redhat.com>, Fam Zheng <fam@euphon.net>,
 Xie Changlong <xiechanglong.d@gmail.com>
Message-ID: <d671f373-77d1-d475-ff23-30bd7674c6df@redhat.com>
Subject: Re: [PATCH 01/12] qapi: add BitmapSyncMode enum
References: <20190620010356.19164-1-jsnow@redhat.com>
 <20190620010356.19164-2-jsnow@redhat.com>
In-Reply-To: <20190620010356.19164-2-jsnow@redhat.com>

--ST1J5Omq9yA8FbeUpP3LhBMAEK5IiPnwh
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 20.06.19 03:03, John Snow wrote:
> Depending on what a user is trying to accomplish, there might be a few
> bitmap cleanup actions that occur when an operation is finished that
> could be useful.
>=20
> I am proposing three:
> - NEVER: The bitmap is never synchronized against what was copied.
> - ALWAYS: The bitmap is always synchronized, even on failures.
> - CONDITIONAL: The bitmap is synchronized only on success.
>=20
> The existing incremental backup modes use 'conditional' semantics,
> so add just that one for right now.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qapi/block-core.json | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 0d43d4f37c..caf28a71a0 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1134,6 +1134,20 @@
>  { 'enum': 'MirrorSyncMode',
>    'data': ['top', 'full', 'none', 'incremental'] }
> =20
> +##
> +# @BitmapSyncMode:
> +#
> +# An enumeration of possible behaviors for the synchronization of a bi=
tmap
> +# when used for data copy operations.
> +#
> +# @conditional: The bitmap is only synchronized when the operation is =
successul.

*successful

> +#               This is useful for Incremental semantics.

Hm, well.  All bitmap modes are for incremental semantics, in some way
or another.  (=E2=80=9Cconditional=E2=80=9D and =E2=80=9Calways=E2=80=9D =
just automatically create
point-in-time snapshots, in a sense, where =E2=80=9Cnever=E2=80=9D requir=
es the user to
manually do so.)

So maybe something more concrete would be better?  Like =E2=80=9CThis all=
ows
incremental use from one successful operation to the next, and
restarting any operation on failure=E2=80=9D?

Max

> +#
> +# Since: 4.1
> +##
> +{ 'enum': 'BitmapSyncMode',
> +  'data': ['conditional'] }
> +
>  ##
>  # @MirrorCopyMode:
>  #
>=20



--ST1J5Omq9yA8FbeUpP3LhBMAEK5IiPnwh--

--iV4RdhEYnAWY9zIp5Im1BXp1uDa80diTE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0LlmYACgkQ9AfbAGHV
z0AVtggAkVtU5NzSPC4wAXtTDZLrwXOOsfIMcGaozOWQjsEKMda6bXrR06FS4gZ+
bI594qPuc6C1cIwEg4E1P/wVtYhJzHzbjTviiwF4F1lVniM7gsyT3enUco+gJgb+
2RIMycIMRIMMSvmqr2F0bfRUKEE7lzew1wq2CdApCGgoorRoK7ht6WUsb2CYU8Rh
/4PE7GBIjqxm8olbcrqUXfqIzTz0dNPgH9Q0ugp107a8/EIyoBTv4XaqhE8xlF0q
ED27It91kYiYpoMyNda7pv7c/Y3WbMbIyGackfh5TO6b8c1xEPgk87sKpGvLxSjy
40lZp/jdlkIsk8v8yNcMa3WS2ertJw==
=ZLP/
-----END PGP SIGNATURE-----

--iV4RdhEYnAWY9zIp5Im1BXp1uDa80diTE--

