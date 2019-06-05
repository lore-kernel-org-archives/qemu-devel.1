Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4795C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 16:23:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E04C206C3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 16:23:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E04C206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45919 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYYhd-0007NT-Q4
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 12:23:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hYYge-0006xF-Gt
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 12:22:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hYYgd-0007Qc-F4
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 12:22:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1hYYgd-0007Ph-6d
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 12:22:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7AC4C8830F
	for <qemu-devel@nongnu.org>; Wed,  5 Jun 2019 16:22:50 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C2395F7D7;
	Wed,  5 Jun 2019 16:22:43 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <e7401f4d-e69b-2930-b070-fb0da55e4b98@redhat.com>
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
Message-ID: <aeafd8bd-4027-eb21-fe68-f76f656e514a@redhat.com>
Date: Wed, 5 Jun 2019 18:22:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <e7401f4d-e69b-2930-b070-fb0da55e4b98@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Ayq8fE1kZFsM2g5zoKprtuzlwKSGiqQdz"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Wed, 05 Jun 2019 16:22:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] sigsegv in chardev on iotest 045 (raw)
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ayq8fE1kZFsM2g5zoKprtuzlwKSGiqQdz
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Message-ID: <aeafd8bd-4027-eb21-fe68-f76f656e514a@redhat.com>
Subject: Re: [Qemu-devel] sigsegv in chardev on iotest 045 (raw)
References: <e7401f4d-e69b-2930-b070-fb0da55e4b98@redhat.com>
In-Reply-To: <e7401f4d-e69b-2930-b070-fb0da55e4b98@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05.06.19 03:15, John Snow wrote:
> Running tests on a development branch (I haven't touched chardev stuff,=

> I swear!); I ran into the below crash where s->ioc was NULL. I don't
> have the time to investigate at this exact moment, so please excuse the=

> hasty report so I don't forget to tell someone.
>=20
> It does not reproduce consistently, and I can't get it to show up again=
=2E
>=20
> (Is this maybe just a race on close where the device went away too fast=

> and it had nowhere to print the information? --js)

Your back trace looks exactly like what I posted in
http://lists.nongnu.org/archive/html/qemu-devel/2018-12/msg05579.html .

No, I don=E2=80=99t think anybody has posted a fix for this so far.  I kn=
ow
other people saw similar issues.

I know what I have on my test branch (which contains various fixes to
make all iotests run or at least pass those which are terminally broken):=


https://git.xanclic.moe/XanClic/qemu/commit/c52433f218c61ef608ab4d9abb56e=
1f705a3ae22

I have a lot of patches on my test branch.  (15, to be exact.)

Max


--Ayq8fE1kZFsM2g5zoKprtuzlwKSGiqQdz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlz37FEACgkQ9AfbAGHV
z0DARQgAj1G6RnLntDEKpKQu2XUiK+5izFyGrw90feKhf/7HdGpC4+qS0fq9IWUg
enx6xZhrOQUaxGSjoDARk+FZyOeWhvbRARpLEOeMpP5+Rtfsl68x0/qa7rc1TOEo
62iTeTlvhUoieX04qnjtONoysoXXc59XZAOBGONBK2U4JgJ9Hgeazpryj0jywye5
4n6gIlZXgbvxJC0vGuHFnd9DGWUxz+yBA4jRM9lS/eAahjGV9IJWxDP0nvItoyi4
OvUUFDYsS/FL55dlQIUX0zBuKkk/ZohSYpLdcKfy6nISzPE4nUOGvSiGlzAVEYWO
TZUt3JAWvQP7jgtslfkx8CmSgClVhg==
=su+T
-----END PGP SIGNATURE-----

--Ayq8fE1kZFsM2g5zoKprtuzlwKSGiqQdz--

