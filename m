Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660DDC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 16:17:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F12621D7E
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 16:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I9bjrYzL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F12621D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itZjp-0000aq-99
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 11:17:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56583)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1itZhb-0007ZR-FV
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 11:15:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1itZhX-0007pF-Ky
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 11:14:59 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59880
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1itZhX-0007p7-Gx
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 11:14:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579536895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=r0I0KsyEoqcLE2wllXlOv7kDqQCIS7HD0QX2fSOULAM=;
 b=I9bjrYzL+ynv+h4uCyWhzIl089e7yYES66afMSwfJ/gnfWeJwmDLxnQv3Rz6J0k9ytBxSV
 ZOx2egpaUBPfkU/cOLKJLJfEh6VtoBK/8h3o2wqv1moj0uH/rtOx9bJZkUDUU8sOVZpmoU
 iJVUBrF+l/zw8dgtiLZvhy6xFwxwnIU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-MhHU-dqCPQujv80w2B7Ryw-1; Mon, 20 Jan 2020 11:14:51 -0500
X-MC-Unique: MhHU-dqCPQujv80w2B7Ryw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32B4B8017CC;
 Mon, 20 Jan 2020 16:14:50 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-225.ams2.redhat.com
 [10.36.117.225])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A77D11001B2D;
 Mon, 20 Jan 2020 16:14:47 +0000 (UTC)
Subject: Re: [PATCH v9 2/2] docs: qcow2: introduce compression type feature
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20191216121733.63562-1-vsementsov@virtuozzo.com>
 <20191216121733.63562-3-vsementsov@virtuozzo.com>
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
Message-ID: <d1856518-c246-75bf-abaf-2711b332437f@redhat.com>
Date: Mon, 20 Jan 2020 17:14:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191216121733.63562-3-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rpkMiUWNtrjlzTZLJyq66SqrmK9XioFwe"
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, armbru@redhat.com,
 dplotnikov@virtuozzo.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rpkMiUWNtrjlzTZLJyq66SqrmK9XioFwe
Content-Type: multipart/mixed; boundary="GtNnekeSVsjO5Wg4z5nNl1eYwGWzgKZHn"

--GtNnekeSVsjO5Wg4z5nNl1eYwGWzgKZHn
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 16.12.19 13:17, Vladimir Sementsov-Ogievskiy wrote:
> The patch add new additional field to qcow2 header: compression_type,
> which specifies compression type. If field is absent or zero, default
> compression type is set: ZLIB, which corresponds to current behavior.
>=20
> New compression type (ZSTD) is to be added in further commit.
>=20
> Suggested-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  docs/interop/qcow2.txt | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>=20
> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
> index d92c827763..77146b5169 100644
> --- a/docs/interop/qcow2.txt
> +++ b/docs/interop/qcow2.txt
> @@ -109,6 +109,11 @@ the next fields through header_length.
>                                  An External Data File Name header extens=
ion may
>                                  be present if this bit is set.
> =20
> +                    Bit 3:      Compression type bit.  If this bit is se=
t,
> +                                non-default compression is used for comp=
ressed

s/non-default/a non-default/

> +                                clusters. compression_type field must be
> +                                present and not zero.

s/compression_type field/The compression_type field/

> +
>                      Bits 3-63:  Reserved (set to 0)
> =20
>           80 -  87:  compatible_features
> @@ -188,7 +193,16 @@ present*, if not altered by specific incompatible bi=
t.
>  *. Field is not present when header_length is less or equal to field's o=
ffset.
>  Also, all additional fields are not present for version 2.
> =20
> -        < ... No additional fields in the header currently ... >
> +              104:  compression_type
> +                    Defines the compression method used for compressed c=
lusters.
> +                    A single compression type is applied to all compress=
ed image
> +                    clusters.

Sounds a bit too complicated.  Maybe =84All compressed clusters in an
image use the same compression type.=94 instead?  (Or s/an/the same/)

> +                    If incompatible compression type bit is set: the fie=
ld must

Hmm, this sounds like there was an =93incompatible compression type=94 bit,
instead of an incompatible bit called =93compression type=94.  So maybe =93=
If
the incompatible bit "compression type" is set, this field must...=94?

> +                    be present and non-zero (which means non-zlib compre=
ssion type)

s/$/./

> +                    If incompatible compression type bit is unset: the f=
ield

I=92d just make this =93Otherwise, this field...=94

> +                    may not exist or it must be zero (which means zlib).

=93must not be present or must be zero=94?

(=93exist=94 sounds a bit weird; the spec only defined =93not present=94 so=
 far.
 As for the =93may not=94, that isn=92t in RFC 2119. :-))

Max

> +                    Available compression type values:
> +                        0: zlib <https://www.zlib.net/>
> =20
>  Header padding
> =20
>=20



--GtNnekeSVsjO5Wg4z5nNl1eYwGWzgKZHn--

--rpkMiUWNtrjlzTZLJyq66SqrmK9XioFwe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl4l0fUACgkQ9AfbAGHV
z0BQawf/TZ5Vwe6iiMpoWTn/HMTGcfXAcTpUraQsNs9Qn3TwAsUxH5bDBbm9snzN
kHVC1xJ4U5f10U1GSXrB9wXUoFhMPu4ECxLDBsMWseG2BAJQSgj1/m6RF2Muvt2s
g2Bi7JS6eFyqIu8cVPRVW64YUGU26ybe8kV67HDxTXW6CZtWzoUPWEou3aaHLlVR
oSP/H3t07pqjXUTvDpMWqoSGi5CPPiM8Lul7kCTnxwxYbhlW/Feeu0FvmsRyW3Pb
60TGovrF8pTpY8xPqjJFpw9ICOV371ZgHnDKjm2kIksY1d4ckkSYPP9wazfj+ZJ1
Ocvx/7kUxvUgrs0TCYt1QIRSt/19Fg==
=IbpN
-----END PGP SIGNATURE-----

--rpkMiUWNtrjlzTZLJyq66SqrmK9XioFwe--


