Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB77C11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:55:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C967624650
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EWmwkMOI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C967624650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7KZp-0002Aq-0p
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 09:55:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52035)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j7KZ0-0001Mc-Dw
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:54:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j7KYz-0007jE-Cr
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:54:58 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41891
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j7KYz-0007j2-89
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:54:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582815296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pYkijqfZUXFsVYRpAfwa9WDabN6JnxqtJbSwjqzY/fI=;
 b=EWmwkMOIuVdlJ2KeMmwA5k16bnkG0i6my7G++7r8Nk8EEHoz+cHchA3rayEFErCeC1qfd6
 Da9J7NKz2PEyNhilCk7eXPmVHmUSo4rbrmjlaXuWW4gGxGzOBiuKFB/Sk3a50bjneSgPgP
 YL3kG+3Qpla2HMy/gfHn1nHPWxdNoeQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-bye3zZucOju3uQz2PwSk-g-1; Thu, 27 Feb 2020 09:54:51 -0500
X-MC-Unique: bye3zZucOju3uQz2PwSk-g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F7B0107ACC4;
 Thu, 27 Feb 2020 14:54:50 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E5D4089F21;
 Thu, 27 Feb 2020 14:54:48 +0000 (UTC)
Subject: Re: [PATCH] qcow2: Explicit mention of padding bytes
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200227144508.1078501-1-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
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
Message-ID: <36d1582d-3b2a-d697-110e-25973e344be1@redhat.com>
Date: Thu, 27 Feb 2020 15:54:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200227144508.1078501-1-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DduQpZZfcuF7w84cJaD1Uhyf7AfsH855k"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: kwolf@redhat.com, dplotnikov@virtuozzo.com, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DduQpZZfcuF7w84cJaD1Uhyf7AfsH855k
Content-Type: multipart/mixed; boundary="izy467crMbQ3DQiGACCRt2YRfqf5EgklG"

--izy467crMbQ3DQiGACCRt2YRfqf5EgklG
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 27.02.20 15:45, Eric Blake wrote:
> Although we already covered the need for padding bytes with our
> changes in commit 3ae3fcfa, commit 66fcbca5 just added one byte and
> relied on the earlier text for implicitly covering 7 padding bytes.
> For consistency with other parts of the header,

Those other places are about table entries where there is padding to the
next entry of the table, though.  In addition, for those other places
it=E2=80=99s the only mention that they are padded.

For the header, there is a whole own section describing the padding, so
I don=E2=80=99t quite see the point.

> it does not hurt to be
> explicit that this version of the header is using padding bytes, and
> if we later add other extension fields, we can rework the allocation
> of those padding bytes to match those additions.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  docs/interop/qcow2.txt | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
> index 5597e244746e..193ac7c5c1af 100644
> --- a/docs/interop/qcow2.txt
> +++ b/docs/interop/qcow2.txt
> @@ -209,6 +209,8 @@ version 2.
>                      Available compression type values:
>                          0: zlib <https://www.zlib.net/>
>=20
> +          105 - m:  Zero padding to round up the header size to the next
> +                    multiple of 8.

And if we really want this, I think it might as well be specific, i.e.
=E2=80=9C105 - 112=E2=80=9D.  We would have to adjust it every time we add =
a new field
anyway.

Max

>  =3D=3D=3D Header padding =3D=3D=3D
>=20



--izy467crMbQ3DQiGACCRt2YRfqf5EgklG--

--DduQpZZfcuF7w84cJaD1Uhyf7AfsH855k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5X2DcACgkQ9AfbAGHV
z0B3Ygf/RK38wcxBh5btiRU3eUPNU6+CXHLS9lc7AXI1aBcHaQcYHzX3ELAAQ7BQ
3HbKn5WPpfpomnA57jxDb8RSEye2oWzxxHi6UTsQScERoSzco7dSLWO6ye8pZfFU
6xSzdbIosfY6sh+CkNJnFfhNex50d6Wp/Zu6DUgNHO2JS0oJyJe7bE7CyGGUL0hd
ry+KEw/EHow0Rlj1O4q4onydVuvw/MgiVYrZoDm6AaQWVtaBo6UqsYnM9wSwK1zL
HDVbhoF+JPaSd8Xh5O6BuFA2erhmX4b7cjNFtlWPOQKKELBccSn/CCV+Skk1+JKa
uaQ2py909CwSgbQuy+8cFyzfMagkeg==
=NGqA
-----END PGP SIGNATURE-----

--DduQpZZfcuF7w84cJaD1Uhyf7AfsH855k--


