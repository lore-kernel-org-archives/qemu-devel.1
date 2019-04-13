Return-Path: <SRS0=HErD=SP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB92C10F0E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 00:54:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7781420850
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 00:54:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7781420850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44766 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hF6wR-0002f4-NJ
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 20:54:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hF6vb-0002Lv-JC
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:53:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hF6va-00012L-HZ
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:53:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hF6vX-0000xR-6C; Fri, 12 Apr 2019 20:53:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D99EA308A968;
	Sat, 13 Apr 2019 00:53:48 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-22.brq.redhat.com
	[10.40.204.22])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5662D608C0;
	Sat, 13 Apr 2019 00:53:45 +0000 (UTC)
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1551895813.git.berto@igalia.com>
	<e25b416f8646a476017f21a8484a05931b0e3f5a.1551895814.git.berto@igalia.com>
	<1df28c23-7efe-310d-2955-432b9a4bb1ad@redhat.com>
	<w515zrkveul.fsf@maestria.local.igalia.com>
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
Message-ID: <5f16da0c-d689-b06c-883b-3911a2c9ff9d@redhat.com>
Date: Sat, 13 Apr 2019 02:53:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <w515zrkveul.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9TDZkTturvFkl5NtRPxjaqRoj6uO4dbL0"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Sat, 13 Apr 2019 00:53:48 +0000 (UTC)
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
Message-ID: <20190413005342.NkJPm7MzAu4QHPlMeOThd9HfNgy6v1upsgUDdpnpOX0@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9TDZkTturvFkl5NtRPxjaqRoj6uO4dbL0
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <5f16da0c-d689-b06c-883b-3911a2c9ff9d@redhat.com>
Subject: Re: [PATCH v2 13/13] qemu-iotests: Test the x-blockdev-reopen QMP
 command
References: <cover.1551895813.git.berto@igalia.com>
 <e25b416f8646a476017f21a8484a05931b0e3f5a.1551895814.git.berto@igalia.com>
 <1df28c23-7efe-310d-2955-432b9a4bb1ad@redhat.com>
 <w515zrkveul.fsf@maestria.local.igalia.com>
In-Reply-To: <w515zrkveul.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11.04.19 15:41, Alberto Garcia wrote:
> On Wed 10 Apr 2019 07:03:50 PM CEST, Max Reitz wrote:
>>> +        # hd0 has no backing file: we can omit the 'backing' option
>>> +        self.reopen(opts)
>>
>> [...]
>>
>>> +        # Detach hd2 from hd0.
>>> +        self.reopen(opts, {'backing': None})
>>> +        self.reopen(opts, {}, "backing is missing for 'hd0'")
>>
>> I don=E2=80=99t understand the second test.  hd0 has no default backin=
g file
>> and it currently has no backing child attached to it.  Why would this
>> call fail now?
>=20
> I think there's a bug.
>=20
> Calling x-blockdev-reopen without 'backing' should only fail if
>=20
>  a) the image has a backing file attached to it.
>     In this case it doesn't: we just detached it in the previous line.
>=20
>  b) there's a default backing file written on the image header.
>     In this case there isn't (hd0 is created without one in setUp()).

That=E2=80=99s what I thought, too, hence me applying effectively the sam=
e
change to the test in v4 of my series as you in your "Fix check for
default backing files" series:

http://lists.nongnu.org/archive/html/qemu-block/2019-04/msg00308.html

> So it should not fail. I think the bug is that the test for condition
> (b) in bdrv_reopen_prepare() that returns "backing is missing..." is
> using backing_file but it should use (correct me if I'm wrong)
> auto_backing_file.

Well, I think both should be fine, because...

> Changing that and replacing the test line with self.reopen(opts) fixes
> it for me.
>=20
> Not directly related to this, but should bdrv_backing_detach() also
> clear backing_file ?

=2E..I don=E2=80=99t think it should.  That=E2=80=99s what that my patch =
addresses.  The
real problem is that bs->backing_file is not a cache for
bs->backing->bs->filename, so it shouldn=E2=80=99t be treated as such.

Max


--9TDZkTturvFkl5NtRPxjaqRoj6uO4dbL0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlyxMxcACgkQ9AfbAGHV
z0DVeAgAxLa+9ldDqDCJHPLqkaUjbKACMit6d5J86ZjXq0fisJ3gIsZNbkgEWKA6
9MQS0JrmUGr7ySKD4zNr3J7wb+pOYHmdMdYEzaWKCcBpPXtFyfjXAeP7yKL+ysuE
skuHw2XPcv8Bs8Z5TLatJh1JPObXWGA6buXXlSOoQe2sa6Ey/n6nj391TyZjcXTv
vDRmHqvfNqMe+NjSB4rPdNGfsyLeCoQPQ0B60W5eL7Y5jOXuONKoq+iNymrhsDUY
rqy8iZCs4ZsJq0eM9zxE+pZboT2fO86xaAIV8LoHJTr6qP0uEkn3gUj081CMpyj4
LBKD+zlMGVabg7IW5ChxXs28oREG0g==
=21bd
-----END PGP SIGNATURE-----

--9TDZkTturvFkl5NtRPxjaqRoj6uO4dbL0--

