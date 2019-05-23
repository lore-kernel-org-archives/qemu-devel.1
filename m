Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747B7C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 17:53:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 391FB2186A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 17:53:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 391FB2186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41331 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTrtl-0005zG-Hc
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 13:53:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hTrsW-0005Ch-4L
	for qemu-devel@nongnu.org; Thu, 23 May 2019 13:51:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hTrsV-0001t6-56
	for qemu-devel@nongnu.org; Thu, 23 May 2019 13:51:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hTrsQ-0001oX-Kh; Thu, 23 May 2019 13:51:38 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EE8B630BC100;
	Thu, 23 May 2019 17:51:37 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.176])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DE4AD600C8;
	Thu, 23 May 2019 17:51:33 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20190523170643.20794-1-jsnow@redhat.com>
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
Message-ID: <8ced8d39-6307-83d1-943b-ccfb22c68488@redhat.com>
Date: Thu, 23 May 2019 19:51:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523170643.20794-1-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Zfya8Fy3gDEIUKMwrzYh4DQh1pjYxiktr"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Thu, 23 May 2019 17:51:38 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v3 0/5] blockdev-backup: don't check
 aio_context too early
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
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Zfya8Fy3gDEIUKMwrzYh4DQh1pjYxiktr
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, eblake@redhat.com,
 qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <8ced8d39-6307-83d1-943b-ccfb22c68488@redhat.com>
Subject: Re: [PATCH v3 0/5] blockdev-backup: don't check aio_context too early
References: <20190523170643.20794-1-jsnow@redhat.com>
In-Reply-To: <20190523170643.20794-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 23.05.19 19:06, John Snow wrote:
> See patch one's commit message for justification.
> Patches 2-5 are for testing, because that's always how these things go.=

>=20
> 001/5:[----] [--] 'blockdev-backup: don't check aio_context too early'
> 002/5:[0004] [FC] 'iotests.py: do not use infinite waits'
> 003/5:[down]      'QEMUMachine: add events_wait method'
> 004/5:[0022] [FC] 'iotests.py: rewrite run_job to be pickier'
> 005/5:[0017] [FC] 'iotests: add iotest 250 for testing blockdev-backup
>                    across iothread contexts'
>=20
> v3: Rebased on Max's staging branch:
>     Rebase patch 2
>     added patch 3, to add events_wait.
>     Rework patch 4 to make run_job consume legacy events, too
>     Minorly edit patch 5 due to the two above.
> v2: added patch 4, with iotest framework adjustments in patches 2/3.
>=20
> John Snow (5):
>   blockdev-backup: don't check aio_context too early
>   iotests.py: do not use infinite waits
>   QEMUMachine: add events_wait method
>   iotests.py: rewrite run_job to be pickier
>   iotests: add iotest 250 for testing blockdev-backup across iothread
>     contexts
>=20
>  blockdev.c                    |   4 --
>  python/qemu/__init__.py       |  69 +++++++++++++------
>  tests/qemu-iotests/250        | 122 ++++++++++++++++++++++++++++++++++=

>  tests/qemu-iotests/250.out    | 119 +++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/group      |   1 +
>  tests/qemu-iotests/iotests.py |  60 ++++++++++-------
>  6 files changed, 326 insertions(+), 49 deletions(-)
>  create mode 100755 tests/qemu-iotests/250
>  create mode 100644 tests/qemu-iotests/250.out

Looks good to me (if it helps:

Reviewed-by: Max Reitz <mreitz@redhat.com>

), just a question on patch 3 on pre-existing quirks.

Max


--Zfya8Fy3gDEIUKMwrzYh4DQh1pjYxiktr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzm3aQACgkQ9AfbAGHV
z0AANgf+NAfhhrXwofJ3QTT4qpcz5a3rgSBnNUC9IMIAHa+3mDhI37vDTLMtBRR/
uUJcEEgSe9dLZAUlJbIsTdliE2hvdCYBzHyFKT7HN4V6urN+AGyGv/X0Jhnnip8K
bCAHLIKEd8Bq3mnFrwUbPbb/Jz5cFXlWxvkfxShqs0JfO+lAMawnOKvsoWc14E40
Z7ibDBG4tAtbinynjYlBqNXwIZwyhDI2opUBTSpA/VCAdkzxzfbqEZdvOjvU4RUW
BY2TI9DvF0WuHqRSIk01E41ZhPJmc+3W+GZsHP5xETD8BGCxW6EnnEbQ0j+ICJIx
rW/Mn6Z1nmRStEqMm5ZSQqmxts6TCQ==
=dH05
-----END PGP SIGNATURE-----

--Zfya8Fy3gDEIUKMwrzYh4DQh1pjYxiktr--

