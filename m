Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9A3CA9EC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 16:24:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D87B2087E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 16:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dSfg9UTC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D87B2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPqlv-0005qI-9K
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 12:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55488)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iPql3-00050C-RG
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 12:23:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iPql1-0005uN-G7
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 12:23:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28307
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iPql1-0005tB-Ar
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 12:23:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572452618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=llqFRB9jVia/9cs/zdNOtTujMWDzbDUfq+Ukx4S9Bkw=;
 b=dSfg9UTCCqsyHmQyMGrEuAmgel0cxnKCY+AfUyz3nbTnE9x25/I99/MddJCvdN5MOSiH2A
 jLH2pBOhHQaArffMt620E6FM0pbOEzeOSiuugB/lmyDXn76JXoaJ1uEabM8gNPdrCOntvs
 AZ4g/c/1KSKDK0uh0sWOlxUP3g3trq0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-PPwcryUBMkWRKQ-r91Oyxw-1; Wed, 30 Oct 2019 12:23:35 -0400
X-MC-Unique: PPwcryUBMkWRKQ-r91Oyxw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87D281800D55;
 Wed, 30 Oct 2019 16:23:34 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-147.ams2.redhat.com
 [10.36.117.147])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 23F715C1B0;
 Wed, 30 Oct 2019 16:23:31 +0000 (UTC)
Subject: Re: [RFC PATCH v2 05/26] qcow2: Document the Extended L2 Entries
 feature
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1572125022.git.berto@igalia.com>
 <57cddd5db9c79406fba70a9bf46c436f6fc9ccd3.1572125022.git.berto@igalia.com>
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
Message-ID: <0c738172-732f-eee0-3396-5a9576a4addf@redhat.com>
Date: Wed, 30 Oct 2019 17:23:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <57cddd5db9c79406fba70a9bf46c436f6fc9ccd3.1572125022.git.berto@igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xbQxQrHqHXV31FpQHYVHkRejA605Kxa4i"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
--xbQxQrHqHXV31FpQHYVHkRejA605Kxa4i
Content-Type: multipart/mixed; boundary="HY8rDvDpsSvc9nb1X63Hm611XOEVksutR"

--HY8rDvDpsSvc9nb1X63Hm611XOEVksutR
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26.10.19 23:25, Alberto Garcia wrote:
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

Sounds good, just a bit of bit nit-picking from my side.

> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
> index af5711e533..d34261f955 100644
> --- a/docs/interop/qcow2.txt
> +++ b/docs/interop/qcow2.txt

[...]

> @@ -524,6 +535,57 @@ file (except if bit 0 in the Standard Cluster Descri=
ptor is set). If there is
>  no backing file or the backing file is smaller than the image, they shal=
l read
>  zeros for all parts that are not covered by the backing file.
> =20
> +=3D=3D Extended L2 Entries =3D=3D
> +
> +An image uses Extended L2 Entries if bit 3 is set on the incompatible_fe=
atures
> +field of the header.
> +
> +In these images standard data clusters are divided into 32 subclusters o=
f the
> +same size. They are contiguous and start from the beginning of the clust=
er.
> +Subclusters can be allocated independently and the L2 entry contains inf=
ormation
> +indicating the status of each one of them. Compressed data clusters don'=
t have
> +subclusters so they are treated like in images without this feature.
> +
> +The size of an extended L2 entry is 128 bits so the number of entries pe=
r table
> +is calculated using this formula:
> +
> +    l2_entries =3D (cluster_size / (2 * sizeof(uint64_t)))
> +
> +The first 64 bits have the same format as the standard L2 table entry de=
scribed
> +in the previous section, with the exception of bit 0 of the standard clu=
ster
> +descriptor.
> +
> +The last 64 bits contain a subcluster allocation bitmap with this format=
:
> +
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

I seem to remember that someone proposed this bit ordering to you, but I
wonder why.  So far everything in qcow2 starts from the least
significant bit, for example refcounts (=E2=80=9CIf refcount_bits implies a
sub-byte width, note that bit 0 means the least significant bit in this
context=E2=80=9D), feature bits, and sub-byte structure descriptions in gen=
eral
(which you reference directly with =E2=80=9Cbit x=E2=80=9D).

Soo...  What=E2=80=99s the reason for doing it the other way around here?

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
> +
> +Subcluster Allocation Bitmap (for compressed clusters):

Going from nit-picking to bike shedding: I=E2=80=99d drop the parentheses.

Max


--HY8rDvDpsSvc9nb1X63Hm611XOEVksutR--

--xbQxQrHqHXV31FpQHYVHkRejA605Kxa4i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl25uQIACgkQ9AfbAGHV
z0DTJQf/QC27NG1bD1h7S4e7IcoaJMpQj+sc+7oG2MsNGk+xxCZ9Tg8vZEOpbhFo
5Op5U5ttBpKDt9ZM9wRd/PaY464runzRKkDLQammfrKssT1iYFhxkwgYyythRBL6
lWHWSNu18vHzk0eTMRmzUNvM/35n0Hfk63UoqH8ioScX9cmidofpHC/I2piy11MF
wt39sGCgs/Gp//eAHUXBUR12Vys+JOJCI8wLCqmsxMrLQsOxDU1x91eWbeUCUAve
AWUBnrnrBSzhxCCjXcqbcNL7gKlStRkJcEnZX6a1f85j+28H+zxu2RU2A2qjSXc8
PrvEhgskoHibEjgmhq1UfAV6s6NYkA==
=ppc+
-----END PGP SIGNATURE-----

--xbQxQrHqHXV31FpQHYVHkRejA605Kxa4i--


