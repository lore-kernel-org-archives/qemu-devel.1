Return-Path: <SRS0=HErD=SP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 843C7C10F11
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 16:12:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 563BD208E3
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 16:12:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 563BD208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53419 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFLGq-0002EM-GU
	for qemu-devel@archiver.kernel.org; Sat, 13 Apr 2019 12:12:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hFLG0-0001q0-Lj
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 12:11:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hFLFz-0006gr-QA
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 12:11:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hFLFx-0006dg-9Q; Sat, 13 Apr 2019 12:11:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C455D3091749;
	Sat, 13 Apr 2019 16:11:51 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-66.brq.redhat.com
	[10.40.204.66])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BEE245D70E;
	Sat, 13 Apr 2019 16:11:50 +0000 (UTC)
To: qemu-block@nongnu.org
References: <20180713111424.23670-1-mreitz@redhat.com>
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
Message-ID: <9afddacb-ca54-6ac3-1c02-b8916a08fcd3@redhat.com>
Date: Sat, 13 Apr 2019 18:11:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20180713111424.23670-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HFNPGbDcPuqMunTOqsYDGGXP0QQjJID3t"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Sat, 13 Apr 2019 16:11:51 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 0/3] qemu-img: Allow rebase with no input
 base
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190413161149.FiT_WBa2Ap-oGWmSeBiWHUh3Ut-XfPlFOyZUHe53730@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HFNPGbDcPuqMunTOqsYDGGXP0QQjJID3t
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <9afddacb-ca54-6ac3-1c02-b8916a08fcd3@redhat.com>
Subject: Re: [PATCH 0/3] qemu-img: Allow rebase with no input base
References: <20180713111424.23670-1-mreitz@redhat.com>
In-Reply-To: <20180713111424.23670-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ping again

(I feel like I just need to start merging unreviewed patches until I
break something (can't take that long) so you get so scared of my
patches that you at least refuse them outright)

On 13.07.18 13:14, Max Reitz wrote:
> This series allows using qemu-img rebase on images that do not have a
> backing file.  Right now, this fails with the rather cryptic error
> message:
>=20
> $ qemu-img rebase -b base.qcow2 foo.qcow2
> qemu-img: Could not open old backing file '': The 'file' block driver r=
equires a file name
>=20
> Yeah, well, OK.
>=20
> With how rebase currently works, this would lead to the overlay being
> filled with zeroes, however.  This is where patch 2 comes in and instea=
d
> makes rebase use blk_pwrite_zeroes() whenever it handles an area past
> the input=E2=80=99s backing file=E2=80=99s EOF.
>=20
> (Note that additionally we could try to punch holes in the overlay
> whenever it matches the new backing file, but that=E2=80=99s something =
I=E2=80=99ll put
> off for later.  (We don=E2=80=99t even have a reliable method for punch=
ing holes
> into an overlay yet, although I would like to have such because it coul=
d
> make active commit more efficient.))
>=20
>=20
> And patch 3 adds the usual test.
>=20
>=20
> Max Reitz (3):
>   qemu-img: Allow rebase with no input base
>   qemu-img: Use zero writes after source backing EOF
>   iotests: Add test for rebase without input base
>=20
>  qemu-img.c                 | 72 +++++++++++++++++++++++---------------=

>  tests/qemu-iotests/024     | 70 ++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/024.out | 37 ++++++++++++++++++++
>  3 files changed, 150 insertions(+), 29 deletions(-)
>=20



--HFNPGbDcPuqMunTOqsYDGGXP0QQjJID3t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlyyCkUACgkQ9AfbAGHV
z0Dy7Af+ObQ9F/kZa50J66nJg5GlX/ARIP188rvFsB6uphLNA/l/s+ESK2lCS5Yg
qOhSTBF98XI8TaabMsL8lSu3UzGBlmXB/q5qrbLMnjg4PYYHCUa1bJPseML52cFy
dP3SZ2iM1LVTbeyOiaddzI0zRT0E7GGAeFfe4M9Be19Jz3Z//fUX33hmPqDTbpbV
tuf25I7tOfyzsTPOdcgp7iExXQpQT12cA+hsF7BiFf6YRbOcGXaqA5DLxx2GYMhF
3ezN29jGkgj8Tm9AIhnVLRsJQuhsMwWnJN8iQBZG+ZU3DN7sgTqYP5JoZ+xPqcXv
MLQ1GVwexDnz/JNSOE3QoCsclRw43w==
=gwHx
-----END PGP SIGNATURE-----

--HFNPGbDcPuqMunTOqsYDGGXP0QQjJID3t--

