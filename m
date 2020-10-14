Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C120C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 12:29:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5556520848
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 12:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HOjGcNao"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5556520848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSfuQ-0003ZN-1t
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 08:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kSfns-0006iC-AT
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 08:22:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55445)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kSfnq-0004lY-I7
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 08:22:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602678165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OKqybWDPln/4Bex5pd+shnowTdbpMKZEqPmnIZBKuxA=;
 b=HOjGcNaobdZfYAb1DsDEIr9Y9AOlunc+Gv0Joek0r5Un6oBeEpg+wNfAadaPUFPpRF+YHb
 yw5dV6fkn1dr7yRb5MvtkTQjiEZNoN2iThyLMksVX+XVh0qy1dQe5OwlGHrEQbLbeJBW/0
 s18589En1oZp5wQbj/CZyoZocmNzJwY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-b7HhbxViOROg6mNJDTVlAA-1; Wed, 14 Oct 2020 08:22:42 -0400
X-MC-Unique: b7HhbxViOROg6mNJDTVlAA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D16B802B7C;
 Wed, 14 Oct 2020 12:22:41 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.194.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BC5B45D9D5;
 Wed, 14 Oct 2020 12:22:31 +0000 (UTC)
Subject: Re: [PATCH v11 06/13] block: modify the comment for BDRV_REQ_PREFETCH
 flag
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1602524605-481160-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1602524605-481160-7-git-send-email-andrey.shinkevich@virtuozzo.com>
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
Message-ID: <092bf4f6-ef81-872f-4712-016f573f7188@redhat.com>
Date: Wed, 14 Oct 2020 14:22:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1602524605-481160-7-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hvQX7PGeHNTEbHgR2QynqEl8aNRtW9Ugq"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 03:37:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 libvir-list@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 stefanha@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hvQX7PGeHNTEbHgR2QynqEl8aNRtW9Ugq
Content-Type: multipart/mixed; boundary="SoScWs07FhQp7vphvyNlnfUIzTKINYtAW"

--SoScWs07FhQp7vphvyNlnfUIzTKINYtAW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12.10.20 19:43, Andrey Shinkevich wrote:
> Modify the comment for the flag BDRV_REQ_PREFETCH as we are going to
> use it alone and pass it to the COR-filter driver for further
> processing.
>=20
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>  include/block/block.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/block/block.h b/include/block/block.h
> index 981ab5b..2b7efd1 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -71,9 +71,10 @@ typedef enum {
>      BDRV_REQ_NO_FALLBACK        =3D 0x100,
> =20
>      /*
> -     * BDRV_REQ_PREFETCH may be used only together with BDRV_REQ_COPY_ON=
_READ
> -     * on read request and means that caller doesn't really need data to=
 be
> -     * written to qiov parameter which may be NULL.
> +     * BDRV_REQ_PREFETCH may be used together with the BDRV_REQ_COPY_ON_=
READ
> +     * flag or when the COR-filter applied to read operations and means =
that

There=E2=80=99s some word missing here, but I=E2=80=99m not sure what it is=
...  At least
an =E2=80=9Cis=E2=80=9D before =E2=80=9Capplied=E2=80=9D.  Perhaps somethin=
g like =E2=80=9Dor when a COR filter
is involved (in read operations)=E2=80=9D would be better.

> +     * caller doesn't really need data to be written to qiov parameter w=
hich

And this =E2=80=9Cwritten to=E2=80=9D confused me for a second, because we=
=E2=80=99re reading
into qiov.  Technically, that means writing into the buffer, but, you know.

Could we rewrite the whole thing, perhaps?  Something like

=E2=80=9CBDRV_REQ_PREFETCH makes sense only in the context of copy-on-read
(i.e., together with the BDRV_REQ_COPY_ON_READ flag or when there is a
COR filter), in which case it signals that the COR operation need not
read the data into memory (qiov), but only ensure it is copied to the
top layer (i.e., that COR is done).=E2=80=9D

I don=E2=80=99t know.

Max

> +     * may be NULL.
>       */
>      BDRV_REQ_PREFETCH  =3D 0x200,
>      /* Mask of valid flags */
>=20



--SoScWs07FhQp7vphvyNlnfUIzTKINYtAW--

--hvQX7PGeHNTEbHgR2QynqEl8aNRtW9Ugq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl+G7YUACgkQ9AfbAGHV
z0BXmwgAiBWP7j0xsnO5pLw1EKomh0zpGS3Wvm99kVMAHPw+KzgAXj1PACe1HEWp
ng4uFxl2Lxd6rf4+1wyQFsqJONdWQdRo20rpf15d2DDFnnTEbxOiqfDCgsqJ6uTD
+g1LKv2KXIvCqkh9y3FxrcqzAUeb1y3Qt56HpI3CJzMrUNlYGPAC0mr+KBnBpqEd
szDIm28jRPI4oZQ/+webBM1wPyKBQ6EF9Mimr8JyjmRXaxKeO6oIABBBogt817D6
GKb05WAJIrRJSiAyEfdHbNUgMM8EsMtbv1C3xFfOahdlJ2EMmzlzHgGNTVefFsjr
U0I6DC3tNHJOq1yVg4nusLISqeEjnQ==
=MoGN
-----END PGP SIGNATURE-----

--hvQX7PGeHNTEbHgR2QynqEl8aNRtW9Ugq--


