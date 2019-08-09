Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDA9C31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 19:32:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B43F120B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 19:32:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B43F120B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwAcS-0004bT-TR
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 15:32:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60416)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hwAbq-000440-Ja
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 15:31:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hwAbp-0003xQ-AH
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 15:31:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53588)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hwAbh-0003rj-Jg; Fri, 09 Aug 2019 15:31:21 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6CF0B3084244;
 Fri,  9 Aug 2019 19:31:18 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C23760BF4;
 Fri,  9 Aug 2019 19:31:17 +0000 (UTC)
To: qemu-block@nongnu.org
References: <20190724171239.8764-1-mreitz@redhat.com>
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
Message-ID: <54ac3fae-66fd-d42a-9794-e0e1c6655772@redhat.com>
Date: Fri, 9 Aug 2019 21:31:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190724171239.8764-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="q8oIJHUrIzns2SHUmODKdkNIlQb9of3bv"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Fri, 09 Aug 2019 19:31:18 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 00/11] block: Fix some things about
 bdrv_has_zero_init()
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--q8oIJHUrIzns2SHUmODKdkNIlQb9of3bv
Content-Type: multipart/mixed; boundary="5i7sE4J7Tyx8eMYDVNGixwvccmm3PjuN1";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <54ac3fae-66fd-d42a-9794-e0e1c6655772@redhat.com>
Subject: Re: [PATCH v2 00/11] block: Fix some things about
 bdrv_has_zero_init()
References: <20190724171239.8764-1-mreitz@redhat.com>
In-Reply-To: <20190724171239.8764-1-mreitz@redhat.com>

--5i7sE4J7Tyx8eMYDVNGixwvccmm3PjuN1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 24.07.19 19:12, Max Reitz wrote:
> Hi,
>=20
> See the previous cover letter for the reason for patches 6 through 9:
> https://lists.nongnu.org/archive/html/qemu-block/2019-07/msg00563.html
>=20
> But no only some bdrv_has_zero_init() implementations are wrong, some
> callers also use it the wrong way.
>=20
> First, qemu-img and mirror use it for pre-existing images, where it
> doesn=E2=80=99t have any meaning.  Both should consider pre-existing im=
ages to
> always be non-zero and not look at bdrv_has-zero_init() (patches 1, 2,
> and the tests in 10 and 11).
>=20
> Second, vhdx and parallels call bdrv_has_zero_init() when they do not
> really care about an image=E2=80=99s post-create state but only about w=
hat
> happens when you grow an image.  That is a bit ugly, and also overly
> safe when growing preallocated images without preallocating the new
> areas.  So this series adds a new function bdrv_has_zero_init_truncate(=
)
> that is more suited to vhdx's and parallel's needs (patches 3 through
> 5).

Thanks for the reviews, I took a part of this last paragraph, added it
as patch 5=E2=80=99s commit message, and applied the series to my block-n=
ext branch.

Max


--5i7sE4J7Tyx8eMYDVNGixwvccmm3PjuN1--

--q8oIJHUrIzns2SHUmODKdkNIlQb9of3bv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1NygMACgkQ9AfbAGHV
z0D5vQf/VhrQhlX0HzSpMPiypJ3u9OAjIyox7zNmeqclju6Ad+FeTnnuO7CSsux3
us2LnMsBIyTP4lOAYyzWvL6xXORiRdTiCk6GeFMoDB7JZEBBTJQBNRRRS9MuRT0O
i6MXdm02qjKoiKjVf4Ql95zSYPC/hdfpX9wHgilcT30FjYGyZlh8w5auaaSmtrmL
txewj9F9veQfk49BlAGXsu/3kGWPEHqYZX50nHq31cfljkUN1aAMNiFJCxoFBHJo
eMW+l1GTZRCRUkyjzN9dqXyNlxa/wHw6DnMPOEoansui8h2JPftD8IAMWQR5Yi2n
n4zObhUwySlEceDhB43PJxaQzb2tBg==
=5XsX
-----END PGP SIGNATURE-----

--q8oIJHUrIzns2SHUmODKdkNIlQb9of3bv--

