Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E1BC11D05
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 15:55:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17547208CD
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 15:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aQF6CGjL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17547208CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4oAS-0004l2-7z
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 10:55:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52202)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j4o9m-0004Hm-RA
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:54:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j4o9l-0006at-OK
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:54:30 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32500
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j4o9l-0006ac-KK
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:54:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582214068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JpQXW6xEVphve23dMB1FjO7XF+tPwHRnryrqlvbim5Y=;
 b=aQF6CGjLHNUrqsUBWYlh9EtI23HKcyzDM88djY0LEeWkcEsLBQT0+gv8WChuBl9Lc3v6KD
 btJq5onj0VoxaOuv3smbpUtZYdomSlntxlx/zeCGtxyRrvVM3xPSFRQmgfHPXz7FU7wVv3
 1xffe/dphIgj1m543d8W45cvvLYYBeM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-EgGE50CTMi-qv_xzaSGk2A-1; Thu, 20 Feb 2020 10:54:24 -0500
X-MC-Unique: EgGE50CTMi-qv_xzaSGk2A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B748C107ACC4;
 Thu, 20 Feb 2020 15:54:22 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7163589F08;
 Thu, 20 Feb 2020 15:54:16 +0000 (UTC)
Subject: Re: [RFC PATCH v3 05/27] qcow2: Document the Extended L2 Entries
 feature
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1577014346.git.berto@igalia.com>
 <0b884ddcd0ac3a3c0b8cdd9d09c74566ac107c9a.1577014346.git.berto@igalia.com>
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
Message-ID: <7ff19f65-5148-a40a-9b7a-6a330cf7272e@redhat.com>
Date: Thu, 20 Feb 2020 16:54:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <0b884ddcd0ac3a3c0b8cdd9d09c74566ac107c9a.1577014346.git.berto@igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="YP0xxjwwPFhk4laozEnLD82eDYv78gwHQ"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-block@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YP0xxjwwPFhk4laozEnLD82eDYv78gwHQ
Content-Type: multipart/mixed; boundary="brAosk83YhrqLffY1Nwcm1fbwuOfW2iN2"

--brAosk83YhrqLffY1Nwcm1fbwuOfW2iN2
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 22.12.19 12:36, Alberto Garcia wrote:
> Subcluster allocation in qcow2 is implemented by extending the
> existing L2 table entries and adding additional information to
> indicate the allocation status of each subcluster.
>=20
> This patch documents the changes to the qcow2 format and how they
> affect the calculation of the L2 cache size.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  docs/interop/qcow2.txt | 68 ++++++++++++++++++++++++++++++++++++++++--
>  docs/qcow2-cache.txt   | 19 +++++++++++-
>  2 files changed, 83 insertions(+), 4 deletions(-)
>=20
> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
> index af5711e533..d34261f955 100644
> --- a/docs/interop/qcow2.txt
> +++ b/docs/interop/qcow2.txt
> @@ -39,6 +39,9 @@ The first cluster of a qcow2 image contains the file he=
ader:
>                      as the maximum cluster size and won't be able to ope=
n images
>                      with larger cluster sizes.
> =20
> +                    Note: if the image has Extended L2 Entries then clus=
ter_bits
> +                    must be at least 14 (i.e. 16384 byte clusters).
> +
>           24 - 31:   size
>                      Virtual disk size in bytes.
> =20
> @@ -109,7 +112,12 @@ in the description of a field.
>                                  An External Data File Name header extens=
ion may
>                                  be present if this bit is set.
> =20
> -                    Bits 3-63:  Reserved (set to 0)
> +                    Bit 3:      Extended L2 Entries.  If this bit is set=
 then

I suppose bit 4 now.  (Compression is bit 3.)

[...]

> +Subcluster Allocation Bitmap (for standard clusters):
> +
> +    Bit  0 -  31:   Allocation status (one bit per subcluster)
> +
> +                    1: the subcluster is allocated. In this case the
> +                       host cluster offset field must contain a valid
> +                       offset.
> +                    0: the subcluster is not allocated. In this case
> +                       read requests shall go to the backing file or
> +                       return zeros if there is no backing file data.
> +
> +                    Bits are assigned starting from the most significant=
 one.
> +                    (i.e. bit x is used for subcluster 31 - x)

I still prefer it the other way round, both personally (e.g. it=E2=80=99s t=
he C
ordering), and because other places in qcow2 use LSb for bit ordering
(the refcount order).

I don=E2=80=99t see ease of debugging as a particularly good reason; but th=
en
again, I didn=E2=80=99t have to debug this feature yet (as opposed to you).

But since I=E2=80=99m used to counting bits from the right (because this is=
 how
it=E2=80=99s done basically everywhere), I can=E2=80=99t imagine I would fi=
nd it more
difficult than counting them from the left.

Max

> +        32 -  63    Subcluster reads as zeros (one bit per subcluster)
> +
> +                    1: the subcluster reads as zeros. In this case the
> +                       allocation status bit must be unset. The host
> +                       cluster offset field may or may not be set.
> +                    0: no effect.
> +
> +                    Bits are assigned starting from the most significant=
 one.
> +                    (i.e. bit x is used for subcluster 63 - x)


--brAosk83YhrqLffY1Nwcm1fbwuOfW2iN2--

--YP0xxjwwPFhk4laozEnLD82eDYv78gwHQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5Oq6EACgkQ9AfbAGHV
z0Dwdgf/ds9m+41IbzNA+uSQAlfUybGynxkLhYz4c1I20UaJqHNnD5FgccdrzmES
ccwcTGt1NnW8cblKpvoAwk9djB1uBSL2C5a1DFVN1WFaF5Yc6Tcxyr5Ktj67HPOn
K+ifTebdKva3zyhwUFWp5HI+F8nrlyrAYVJr439VgYZobVD8nvgk8effQ7lw1cR9
c2K0vdff81q0ua81jUF6kLW7Sc85TbCizYI3Bd5zymiLl6l2V1vOE+2vdQf3g3Uv
pYkbX9q37WOvqF3hxHzV+/iFJQAETaZawhUqjzdv+VK1E2pn61L73pebVj9DbiLi
kSncwGGNcwUKqCj2hPcZ4SxFbkbVdw==
=Btqr
-----END PGP SIGNATURE-----

--YP0xxjwwPFhk4laozEnLD82eDYv78gwHQ--


