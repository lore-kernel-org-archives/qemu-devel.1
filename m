Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C7AC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 17:04:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F94A2082E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 17:04:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F94A2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34824 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEGef-0001Tk-DD
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 13:04:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hEGdl-000189-4F
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 13:04:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hEGdk-0006BN-6O
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 13:04:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hEGde-00065P-Oa; Wed, 10 Apr 2019 13:03:55 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 62FCA3078AAE;
	Wed, 10 Apr 2019 17:03:53 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.69])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E2089104C421;
	Wed, 10 Apr 2019 17:03:51 +0000 (UTC)
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1551895813.git.berto@igalia.com>
	<e25b416f8646a476017f21a8484a05931b0e3f5a.1551895814.git.berto@igalia.com>
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
Message-ID: <1df28c23-7efe-310d-2955-432b9a4bb1ad@redhat.com>
Date: Wed, 10 Apr 2019 19:03:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e25b416f8646a476017f21a8484a05931b0e3f5a.1551895814.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wsXlU5LRRQdBRHDSEsLlWxlKtWPY1NAj4"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Wed, 10 Apr 2019 17:03:53 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v2 13/13] qemu-iotests: Test the
 x-blockdev-reopen QMP command
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
Message-ID: <20190410170350.CL1XivdMvlzGZY9zYsk3FnfgV3CgX2Q83LpjYY11DdY@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wsXlU5LRRQdBRHDSEsLlWxlKtWPY1NAj4
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <1df28c23-7efe-310d-2955-432b9a4bb1ad@redhat.com>
Subject: Re: [PATCH v2 13/13] qemu-iotests: Test the x-blockdev-reopen QMP
 command
References: <cover.1551895813.git.berto@igalia.com>
 <e25b416f8646a476017f21a8484a05931b0e3f5a.1551895814.git.berto@igalia.com>
In-Reply-To: <e25b416f8646a476017f21a8484a05931b0e3f5a.1551895814.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06.03.19 19:11, Alberto Garcia wrote:
> This patch adds several tests for the x-blockdev-reopen QMP command.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  tests/qemu-iotests/243     | 991 +++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/243.out |   5 +
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 997 insertions(+)
>  create mode 100644 tests/qemu-iotests/243
>  create mode 100644 tests/qemu-iotests/243.out
>=20
> diff --git a/tests/qemu-iotests/243 b/tests/qemu-iotests/243
> new file mode 100644
> index 0000000000..35b30092ca
> --- /dev/null
> +++ b/tests/qemu-iotests/243
> @@ -0,0 +1,991 @@

[...]

> +    # If an image has a backing file then the 'backing' option must be=

> +    # passed on reopen. We don't allow leaving the option out in this
> +    # case because it's unclear what the correct semantics would be.
> +    def test_missing_backing_options_1(self):

[...]

> +        # hd0 has no backing file: we can omit the 'backing' option
> +        self.reopen(opts)

[...]

> +        # Detach hd2 from hd0.
> +        self.reopen(opts, {'backing': None})
> +        self.reopen(opts, {}, "backing is missing for 'hd0'")

I don=E2=80=99t understand the second test.  hd0 has no default backing f=
ile and
it currently has no backing child attached to it.  Why would this call
fail now?

I=E2=80=99m asking because this no longer throws an error after =E2=80=9C=
block: Leave
BDS.backing_file constant=E2=80=9D of my =E2=80=9Cblock: Deal with filter=
s=E2=80=9D series.

Max


--wsXlU5LRRQdBRHDSEsLlWxlKtWPY1NAj4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlyuIfYACgkQ9AfbAGHV
z0C8IAf9F+SVG9TWeDOQfua02TtwAY/o9h92UZA6H3hfgXQNr4AkWDrqJgbKLoa8
2qswPehoi7vOF3KVv17I2Y270LbKwQOucb40QSJzGT2Pwbuted48nuSDmfujGikL
IIilMJ7zVkBIsetEVALew5V9bYr66rGIcouVytvqOXMjDFm5q0DsqsoERHDHRk/c
cK41W+K/zNBtHdaaa/2T6UjSX0JS2Ogq8ahwyIL2CiiHJu8Q81zDdGilg4UeOeYT
tjdk3VXOftOIkddxYmYUN+OA7TFTlppJkDcKYXttrYEWTS3S14HImFEFo37zHkha
2sR8nHdfrtCXeo3kdH/TxEumrO32pA==
=dRjU
-----END PGP SIGNATURE-----

--wsXlU5LRRQdBRHDSEsLlWxlKtWPY1NAj4--

