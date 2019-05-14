Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4DDC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 13:04:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71CD121473
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 13:04:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71CD121473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48008 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQX6i-0006y1-9q
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 09:04:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hQX5E-0006GE-7E
	for qemu-devel@nongnu.org; Tue, 14 May 2019 09:03:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hQX5A-0001Qj-2W
	for qemu-devel@nongnu.org; Tue, 14 May 2019 09:03:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38382)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hQX51-0001KI-DI; Tue, 14 May 2019 09:02:51 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 35C6BC069B2C;
	Tue, 14 May 2019 13:02:40 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.236])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CDEB25D6A6;
	Tue, 14 May 2019 13:02:35 +0000 (UTC)
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1551895813.git.berto@igalia.com>
	<e25b416f8646a476017f21a8484a05931b0e3f5a.1551895814.git.berto@igalia.com>
	<1df28c23-7efe-310d-2955-432b9a4bb1ad@redhat.com>
	<w515zrkveul.fsf@maestria.local.igalia.com>
	<5f16da0c-d689-b06c-883b-3911a2c9ff9d@redhat.com>
	<w51k1etqnmk.fsf@maestria.local.igalia.com>
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
Message-ID: <f3214198-33ed-5689-2831-802d26a88d21@redhat.com>
Date: Tue, 14 May 2019 15:02:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <w51k1etqnmk.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mydn7reGStVa5i7YyTKJoXWMUS1jqDTFM"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Tue, 14 May 2019 13:02:50 +0000 (UTC)
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mydn7reGStVa5i7YyTKJoXWMUS1jqDTFM
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <f3214198-33ed-5689-2831-802d26a88d21@redhat.com>
Subject: Re: [PATCH v2 13/13] qemu-iotests: Test the x-blockdev-reopen QMP
 command
References: <cover.1551895813.git.berto@igalia.com>
 <e25b416f8646a476017f21a8484a05931b0e3f5a.1551895814.git.berto@igalia.com>
 <1df28c23-7efe-310d-2955-432b9a4bb1ad@redhat.com>
 <w515zrkveul.fsf@maestria.local.igalia.com>
 <5f16da0c-d689-b06c-883b-3911a2c9ff9d@redhat.com>
 <w51k1etqnmk.fsf@maestria.local.igalia.com>
In-Reply-To: <w51k1etqnmk.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 14.05.19 13:30, Alberto Garcia wrote:
> On Sat 13 Apr 2019 02:53:42 AM CEST, Max Reitz wrote:
>>> Calling x-blockdev-reopen without 'backing' should only fail if
>>>
>>>  a) the image has a backing file attached to it.
>>>     In this case it doesn't: we just detached it in the previous line=
=2E
>>>
>>>  b) there's a default backing file written on the image header.
>>>     In this case there isn't (hd0 is created without one in setUp()).=

>>
>> That=E2=80=99s what I thought, too, hence me applying effectively the =
same
>> change to the test in v4 of my series as you in your "Fix check for
>> default backing files" series:
>>
>> http://lists.nongnu.org/archive/html/qemu-block/2019-04/msg00308.html
>>
>>> So it should not fail. I think the bug is that the test for condition=

>>> (b) in bdrv_reopen_prepare() that returns "backing is missing..." is
>>> using backing_file but it should use (correct me if I'm wrong)
>>> auto_backing_file.
>>
>> Well, I think both should be fine, because...
>=20
> Why would both be fine? backing_file refers to the backing file
> currently attached, and auto_backing_file refers to the one written on
> the image metadata, or am I wrong?

After my series, backing_file refers to the image metadata.

>>> Not directly related to this, but should bdrv_backing_detach() also
>>> clear backing_file ?
>>
>> ...I don=E2=80=99t think it should.  That=E2=80=99s what that my patch=
 addresses. The
>> real problem is that bs->backing_file is not a cache for
>> bs->backing->bs->filename, so it shouldn=E2=80=99t be treated as such.=

>=20
> But what's the point of having backing_file set if no backing file is
> attached?

What=E2=80=99s the point of having backing_file set to the same value as
bs->backing->bs->filename?

We need some storage for =E2=80=9CWhat does the image header say=E2=80=9D=
=2E  Currently,
that sometimes is BDS.backing_file.  Sometimes it isn=E2=80=99t.  That=E2=
=80=99s broken.
 See
http://lists.nongnu.org/archive/html/qemu-block/2019-04/msg00308.html.
BDS.auto_backing_file does not refer to the image metadata.  It refers
to something like bdrv_refresh_filename(bdrv_open(bs->backing_file)).
We need this just to calculate @backing_overridden in
bdrv_refresh_filename().

Max


--mydn7reGStVa5i7YyTKJoXWMUS1jqDTFM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzavGkACgkQ9AfbAGHV
z0BCAQgAu/u/zowKujPnqDXrE9HrIFQaJTLijpWf2NFggesE3jp1cMlVR4F1W5eF
daKmcEO0j+Mxu/SCO5qFsywe7aitc2dt7gPCqIV6Sik2bwTgaeDXaZwyMryqQY1k
xVi1DxgicfAwhcjoFJkux7Sr9n5Cy4JA01L8grtCldrTxwokZaal6JDSeLcy/Tio
HQYzj+3aXUlJpJsuP3XNZ3pFZrU/APqfJ627OO1HGPoTu9p2pn6LPNU4u6L4dc4W
gvDQmGIUYnXqT8BGZBBRAOk4w7VEor5sCFj2jm4NZ5/OO9+cGsE1v4tmomJnXdkO
0+Set5zjwB5QjIsuoNUShFPbFlJE0w==
=thCN
-----END PGP SIGNATURE-----

--mydn7reGStVa5i7YyTKJoXWMUS1jqDTFM--

