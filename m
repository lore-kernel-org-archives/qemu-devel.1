Return-Path: <SRS0=HErD=SP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A5BC10F11
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 15:49:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A52A4214D8
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 15:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A52A4214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52927 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFKu9-0007Le-Ac
	for qemu-devel@archiver.kernel.org; Sat, 13 Apr 2019 11:49:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hFKtC-0006v1-9Q
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 11:48:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hFKtB-0005hm-8q
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 11:48:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hFKt8-0005fd-O5; Sat, 13 Apr 2019 11:48:19 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D4B313084027;
	Sat, 13 Apr 2019 15:48:16 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-66.brq.redhat.com
	[10.40.204.66])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 970F7600C8;
	Sat, 13 Apr 2019 15:48:14 +0000 (UTC)
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1554992449.git.berto@igalia.com>
	<6c17d784-c5e4-9a3c-c38c-19940352ea35@redhat.com>
	<w51zhoufg2l.fsf@maestria.local.igalia.com>
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
Message-ID: <b30d2279-2311-5b3e-6108-e93577bc7255@redhat.com>
Date: Sat, 13 Apr 2019 17:48:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <w51zhoufg2l.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="o7fqvdit2YWUlq6Eg3L9XZTGZ5Ov4573U"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Sat, 13 Apr 2019 15:48:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH for-4.1 0/2] Fix check for default backing
 files in bdrv_reopen_prepare()
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
Message-ID: <20190413154811.VHG_e3ccGNJvV7qDSjs4O_IFTkXmbWhy4eJtpcZy5gg@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--o7fqvdit2YWUlq6Eg3L9XZTGZ5Ov4573U
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <b30d2279-2311-5b3e-6108-e93577bc7255@redhat.com>
Subject: Re: [PATCH for-4.1 0/2] Fix check for default backing files in
 bdrv_reopen_prepare()
References: <cover.1554992449.git.berto@igalia.com>
 <6c17d784-c5e4-9a3c-c38c-19940352ea35@redhat.com>
 <w51zhoufg2l.fsf@maestria.local.igalia.com>
In-Reply-To: <w51zhoufg2l.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13.04.19 10:46, Alberto Garcia wrote:
> On Sat 13 Apr 2019 02:56:57 AM CEST, Max Reitz wrote:
>>> Patch 2 fixes a different (but slightly related) issue that I found
>>> while preparing the first patch.
>>
>> I think the real problem is that bs->backing_file is not a cache for
>> bs->backing->bs->filename.
>>
>> In fact, every user of bs->backing_file expects it to be something
>> different.  Some expect it to be a cache for
>> bs->backing->bs->filename, some expect it to be what the image header
>> says (i.e., it if=E2=80=99s a relative path, it=E2=80=99s relative to =
the overlay),
>> some expect it to be what the image header says, but relative paths to=

>> be translated so they are relative to qemu=E2=80=99s CWD.
>>
>> All of this should be cleaned up and this is what patch 7 in my "block=
:
>> Deal with filters" series does:
>>
>> http://lists.nongnu.org/archive/html/qemu-block/2019-04/msg00308.html
>=20
> Ok, you can leave out the second patch then. The first one should still=

> be correct, right?

I just think it=E2=80=99s unnecessary because as of my series both backin=
g_file
and auto_backing_file serve the purpose.

Max


--o7fqvdit2YWUlq6Eg3L9XZTGZ5Ov4573U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlyyBLwACgkQ9AfbAGHV
z0ACpAgAq1frsGLAm8X0VtxkMGnpJoZi3ZNIOVShcNj40bvOmn8nkUEtdcDiJMDp
AQYC3ieabrBsyKArdXfdCIbe40HwY7dQlVt/BKm03qxRd7EJribKyNTZQtjdB6c1
HGU0AutN2nOcr9pOszCNXG6ZOoSqe2xRsOjfRFCxZUfqX0qWij49WeVNMYybZaBI
pypZYZSgQbMxzuCzeGkJh24fDb9JfOsvNPLFSLWu/L2hOyBOs6Eu6vUZwL15i9rd
c98RgfTozWkbnQmNeJptEGbh/4lAwqmS+Uq/WCNP2Gskq3VxZGrOAeMIH7+mfHzh
ovuZFVeytGLEau0yQg9yQofRfxGcjA==
=MnpV
-----END PGP SIGNATURE-----

--o7fqvdit2YWUlq6Eg3L9XZTGZ5Ov4573U--

