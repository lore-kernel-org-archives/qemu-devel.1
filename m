Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6547BCA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 12:36:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FB9D21E6F
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 12:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dqLZHuMo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FB9D21E6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRbaz-0001eM-B4
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 07:36:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43218)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iRbaI-000166-Ue
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 07:35:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iRbaC-0002lw-Kx
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 07:35:49 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55411
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iRbaC-0002lC-GY
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 07:35:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572870943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=W2SzK7rW/ruNuqFxqj78bePW2XG1XC0a3JpeCMjqC+A=;
 b=dqLZHuMoKn4lKYOL/T964l0Q9sCKnsDjrIY6khxTaPnaZJ1cWwAraAtcxPiHcqwKA0TpRY
 HO7iEukC2bKXuxg+rtmOS1sicO0QGtw3+Lp6dJCJiVOB2VBkj8qp9S1j5LzIqLfLoMax2l
 C+T85esz7leswBhEroUKS87vQQHfzMc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-2Aa8by7jM1OhA2g45en4lA-1; Mon, 04 Nov 2019 07:35:38 -0500
X-MC-Unique: 2Aa8by7jM1OhA2g45en4lA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C21B81800D53;
 Mon,  4 Nov 2019 12:35:36 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 044481001B35;
 Mon,  4 Nov 2019 12:35:31 +0000 (UTC)
Subject: Re: [RFC PATCH v2 11/26] qcow2: Add qcow2_get_subcluster_type()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1572125022.git.berto@igalia.com>
 <b497a6d5d5876f68a7320f58dad56806bab95cde.1572125022.git.berto@igalia.com>
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
Message-ID: <7d2238bf-1c8d-5d5d-a0d3-c700725dc44d@redhat.com>
Date: Mon, 4 Nov 2019 13:35:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <b497a6d5d5876f68a7320f58dad56806bab95cde.1572125022.git.berto@igalia.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="zasKvd7pUXFbb9ch1lQUjpnigIUXLTUYk"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
--zasKvd7pUXFbb9ch1lQUjpnigIUXLTUYk
Content-Type: multipart/mixed; boundary="C13o4S0q9opo54FiwqyVoCRjuVhTETGpt"

--C13o4S0q9opo54FiwqyVoCRjuVhTETGpt
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26.10.19 23:25, Alberto Garcia wrote:
> This function returns the type of an individual subcluster. If an
> image does not have subclusters then this returns the exact same value
> as qcow2_get_cluster_type().
>=20
> The information in standard and extended L2 entries is encoded in a
> slightly different way, but all existing QCow2ClusterType values are
> also valid for subclusters and have the same meanings (although they
> typically only apply to the requested subcluster).
>=20
> There are two important exceptions to this:
>=20
>   a) QCOW2_CLUSTER_COMPRESSED means that the whole cluster is
>      compressed. We do not support compression at the subcluster
>      level.
>=20
>   b) QCOW2_CLUSTER_UNALLOCATED means that the cluster is unallocated,
>      that is, the offset field of the L2 entry does not point to a
>      host cluster. All subclusters are obviously unallocated too but
>      any of them could be of type QCOW2_CLUSTER_ZERO_PLAIN.
>=20
> In addition to that, extended L2 entries allow one new scenario where
> the cluster is normally allocated but an individual subcluster is not.
> This is very different from (b) and because of that this patch adds a
> new value called QCOW2_CLUSTER_UNALLOCATED_SUBCLUSTER.
>=20
> As a last thing, this patch adds QCOW2_CLUSTER_INVALID to detect the
> cases where an L2 entry has a value that violates the spec. The caller
> is responsible for handling these situations.
>=20
> To prevent compatibility problems with images that have invalid values
> but are currently being read by QEMU without causing side effects,
> QCOW2_CLUSTER_INVALID is only returned for images with extended L2
> entries.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2.h | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)

[...]

> +        case QCOW2_CLUSTER_ZERO_PLAIN:
> +        case QCOW2_CLUSTER_ZERO_ALLOC:
> +            return QCOW2_CLUSTER_INVALID;

The spec doesn=E2=80=99t say anything about this, though.

(I would have assumed it=E2=80=99s valid and the subcluster zero status is
simply ignored.  It makes sense to forbit this case, but the spec should
make a note of it.)

Nax


--C13o4S0q9opo54FiwqyVoCRjuVhTETGpt--

--zasKvd7pUXFbb9ch1lQUjpnigIUXLTUYk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3AGxIACgkQ9AfbAGHV
z0Ba4gf/Yl7TYUuxfqFX97utwwh1AOzxhzXjuE8kow+nROT+R65Y1pNw0T7QM+MD
8SI6SdjKX0BtBssrbQxb3dxtSkUlE8yNyzzsjJB5XoJsw829Bpa6BlKupJJgatuv
OQKU6/gjLYR15n79cOfcmUcxUXJuGO8uoJKqG0Ifgpe/OCFvj+t31vwRFY2LRZv4
xb0grb1GToteJ0t8InyRNHHntycDnPOZkUYnSQuJVqccfjvfe2ppaR2s22HdXdce
ZsMXNdG+5Q0U37B+q6SRXI4eN1Nc66XBldWrBnA0u/OvYqFpYKwYknkTjVIPRGev
1MOAskBBssvDJSLaFrgQGX0wFVDGYw==
=0Z82
-----END PGP SIGNATURE-----

--zasKvd7pUXFbb9ch1lQUjpnigIUXLTUYk--


