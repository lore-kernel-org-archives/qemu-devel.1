Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D59AC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 15:08:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30C882085A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 15:08:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30C882085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49598 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQZ2C-0002Oe-5t
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 11:08:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hQZ1I-00022x-OT
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:07:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hQZ1H-0004nC-Op
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:07:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hQZ1F-0004iX-Dm; Tue, 14 May 2019 11:07:05 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7A5CF307D942;
	Tue, 14 May 2019 15:06:58 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.236])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5CA615C2F6;
	Tue, 14 May 2019 15:06:56 +0000 (UTC)
To: Qemu-block <qemu-block@nongnu.org>
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
Message-ID: <c276dc0c-0190-1e83-d491-8157d78ec817@redhat.com>
Date: Tue, 14 May 2019 17:06:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="o6uElI4Ogu9bP3LFS5HJiK3NGhKkx1sXw"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Tue, 14 May 2019 15:06:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: [Qemu-devel] Unaligned images with O_DIRECT
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
--o6uElI4Ogu9bP3LFS5HJiK3NGhKkx1sXw
From: Max Reitz <mreitz@redhat.com>
To: Qemu-block <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Message-ID: <c276dc0c-0190-1e83-d491-8157d78ec817@redhat.com>
Subject: Unaligned images with O_DIRECT
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Unaligned images don=E2=80=99t work so well with O_DIRECT:

$ echo > foo
$ qemu-img map --image-opts driver=3Dfile,filename=3Dfoo,cache.direct=3Do=
n
Offset          Length          Mapped to       File
qemu-img: block/io.c:2093: bdrv_co_block_status: Assertion `*pnum &&
QEMU_IS_ALIGNED(*pnum, align) && align > offset - aligned_offset' failed.=

[1]    10954 abort (core dumped)  qemu-img map --image-opts
driver=3Dfile,filename=3Dfoo,cache.direct=3Don

(compare https://bugzilla.redhat.com/show_bug.cgi?id=3D1588356)

This is because the request_alignment is 512 (in my case), but the EOF
is not aligned accordingly, so raw_co_block_status() returns an aligned
*pnum.

I suppose having an unaligned tail is not so bad and maybe we can just
adjust the assertion accordingly.  On the other hand, this has been
broken for a while.  Does it even make sense to use O_DIRECT with
unaligned images?  Shouldn=E2=80=99t we just reject them outright?

Max


--o6uElI4Ogu9bP3LFS5HJiK3NGhKkx1sXw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlza2Y8ACgkQ9AfbAGHV
z0BHjwgAkJ6q21GTuR4Z0KqN61MIOUH7MaHGRRbBl1zVG/rQYJTloognbyEBHVYZ
xiECi7c4V9dxV4CAOaV4o+NAfyPuRhX/UsWyX25QcVFHtFOcDc+vJZVe179xoW19
CumLiwklvkW6URBrmmy1HtkkY36j9PSZaWR4iD3RaChCOMtypIenWsG6KXw1v+gv
KaYhSHa4Cb0rYyknyAcTmvbrkEEPrQWuJB7iPYs9mzx/TZRyQrfrK/tsUj5J1Bfd
YPlWnABKVfrDqYn+kxmZFXPr4Pfx+Yn1qarfwfen+TcakyUV87Q0FotGiIvNAvPk
n/oSYxSwVzC7YtDViQKydnBEYrOADA==
=Ovh+
-----END PGP SIGNATURE-----

--o6uElI4Ogu9bP3LFS5HJiK3NGhKkx1sXw--

