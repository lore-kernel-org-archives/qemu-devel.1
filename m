Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B100C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 17:29:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20A0920850
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 17:29:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20A0920850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51653 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQbEt-0003FD-6V
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 13:29:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hQbE3-0002u9-Cv
	for qemu-devel@nongnu.org; Tue, 14 May 2019 13:28:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hQbE2-0000mn-2M
	for qemu-devel@nongnu.org; Tue, 14 May 2019 13:28:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hQbDw-0000fO-SG; Tue, 14 May 2019 13:28:21 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3140E81E0D;
	Tue, 14 May 2019 17:28:20 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.236])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A8E9D601A0;
	Tue, 14 May 2019 17:28:18 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, Qemu-block <qemu-block@nongnu.org>
References: <c276dc0c-0190-1e83-d491-8157d78ec817@redhat.com>
	<5e56cded-5097-ce97-6f2b-7afee8e480af@redhat.com>
	<ce551fef-3987-a5fd-7280-e406226c6a20@redhat.com>
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
Message-ID: <20a7f01f-894c-e121-afc9-03415f55aa82@redhat.com>
Date: Tue, 14 May 2019 19:28:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ce551fef-3987-a5fd-7280-e406226c6a20@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Q8O84HfVXzXGdrP8qtZzvN3D3b9Blqe5H"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Tue, 14 May 2019 17:28:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] Unaligned images with O_DIRECT
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
Cc: Kevin Wolf <kwolf@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Q8O84HfVXzXGdrP8qtZzvN3D3b9Blqe5H
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, Qemu-block <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <20a7f01f-894c-e121-afc9-03415f55aa82@redhat.com>
Subject: Re: Unaligned images with O_DIRECT
References: <c276dc0c-0190-1e83-d491-8157d78ec817@redhat.com>
 <5e56cded-5097-ce97-6f2b-7afee8e480af@redhat.com>
 <ce551fef-3987-a5fd-7280-e406226c6a20@redhat.com>
In-Reply-To: <ce551fef-3987-a5fd-7280-e406226c6a20@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 14.05.19 18:15, Max Reitz wrote:
> On 14.05.19 17:45, Eric Blake wrote:
>> On 5/14/19 10:06 AM, Max Reitz wrote:
>>> Hi,
>>>
>>> Unaligned images don=E2=80=99t work so well with O_DIRECT:
>>>
>>> $ echo > foo
>>> $ qemu-img map --image-opts driver=3Dfile,filename=3Dfoo,cache.direct=
=3Don
>>> Offset          Length          Mapped to       File
>>> qemu-img: block/io.c:2093: bdrv_co_block_status: Assertion `*pnum &&
>>> QEMU_IS_ALIGNED(*pnum, align) && align > offset - aligned_offset' fai=
led.
>>> [1]    10954 abort (core dumped)  qemu-img map --image-opts
>>> driver=3Dfile,filename=3Dfoo,cache.direct=3Don
>>>
>>> (compare https://bugzilla.redhat.com/show_bug.cgi?id=3D1588356)
>>>
>>> This is because the request_alignment is 512 (in my case), but the EO=
F
>>> is not aligned accordingly, so raw_co_block_status() returns an align=
ed
>>> *pnum.
>>
>> Uggh. Yet another reason why I want qemu to support byte-accurate
>> sizing, instead of rounding up. The rounding keeps raising its head in=

>> more and more places. I have pending patches that are trying to improv=
e
>> block status to round driver answers up to match request_alignment (wh=
en
>> the protocol layer has finer granularity than the format layer); but
>> this sounds like it is a bug in the file driver itself for returning a=
n
>> answer that is not properly rounded according to its own
>> request_alignment boundary, and not one where my pending patches would=
 help.
>=20
> Yes, I think so, too.
>=20
>>> I suppose having an unaligned tail is not so bad and maybe we can jus=
t
>>> adjust the assertion accordingly.  On the other hand, this has been
>>> broken for a while.  Does it even make sense to use O_DIRECT with
>>> unaligned images?  Shouldn=E2=80=99t we just reject them outright?
>>
>> The tail of an unaligned file is generally inaccessible to O_DIRECT,
>=20
> Especially with this.
>=20
>> where it is easier to use ftruncate() up to an aligned boundary if you=

>> really must play with that region of the file, and then ftruncate() ba=
ck
>> to the intended size after I/O. But that sounds hairy.  We could also
>> round down and silently ignore the tail of the file, but that is at od=
ds
>> with our practice of rounding size up.  So for the short term, I'd be
>> happy with a patch that just rejects any attempt to use cache.direct=3D=
on
>> (O_DIRECT) with a file that is not already a multiple of the alignment=

>> required thereby. (For reference, that's what qemu as NBD client
>> recently did when talking to a server that advertises a size
>> inconsistent with forced minimum block access: commit 3add3ab7)
>=20
> OK, I=E2=80=99ll send a patch.  Thanks for you explanation!
Well, or maybe not.

$ ./qemu-img create -f qcow2 foo.qcow2 64M
$ ./qemu-img map --image-opts \
    driver=3Dqcow2,file.filename=3Dfoo.qcow2,cache.direct=3Don
qemu-img: Could not open
'driver=3Dqcow2,file.filename=3Dfoo.qcow2,cache.direct=3Don': File length=

(196616 bytes) is not a multiple of the O_DIRECT alignment (512 bytes)
Try cache.direct=3Doff, or increasing the file size to match the alignmen=
t

That may be considered a bug in qcow2.  Maybe it should always fill all
clusters.  But even if we did so and fixed it now, we can=E2=80=99t disal=
low
qemu from opening such images.

Also, well, the tail is accessible, we just need to access it with the
proper alignment (and then we get a short read).  This seems to be
handled just fine.

So I think file-posix should just return a rounded result.  Well, or
bdrv_co_Block_status() could ignore it for the EOF, because it throws
away everything past the EOF anyway with:

    if (*pnum > bytes) {
        *pnum =3D bytes;
    }

On one hand, I agree that file-posix should return an aligned result.
On the other, it doesn=E2=80=99t make a difference, so I don=E2=80=99t th=
ink we need to
enforce it (at EOF).

Max


--Q8O84HfVXzXGdrP8qtZzvN3D3b9Blqe5H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlza+rAACgkQ9AfbAGHV
z0DOKgf+L32Ja0ovpfoKxgXsNZ9XJBFXS3kbwcjIuR/wX4RbmRrRk6wQCxLi7Grn
Ao0SM/h1ZacFHMLz05c+9jcZInGZcp+QH5BARul3wde/mnirhVurDlKvL2T2GCgO
A5KY9yj8X5bC14rpwNemCzXSr9jT4wPIm6E5Q2u+J/zCKdrdZbyZu2qyhzmTbS23
f4uPNkQRk+TMXNKQ781e3amjunWJ+u+dK6TAOf8WujEcRSA9IzegdPYJeV0+cFsr
E2iuE7uKEo6VPRIsaUtgeuEBFy/XVuTUGmAnwu7lQxx6KnVadCIHclHIhHcqI7aA
t+bv7RIzfuH15wLFRsEezxZDpYq7zQ==
=MIxM
-----END PGP SIGNATURE-----

--Q8O84HfVXzXGdrP8qtZzvN3D3b9Blqe5H--

