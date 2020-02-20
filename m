Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99329C11D05
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 16:04:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 646F520658
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 16:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QQ6urN7t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 646F520658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4oJU-0005FJ-8Q
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 11:04:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53609)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j4oIa-0004Ic-KQ
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:03:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j4oIX-00023x-So
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:03:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36362
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j4oIX-00023X-NI
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:03:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582214613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=t0gxFDWSj+xEHMik+j1S0a70dIYRns/ROQ2LX33Vkvc=;
 b=QQ6urN7tA6XJOOW6cgxrnFxgTaypW2/pswmBhYR/RFE5AOEWvAO8XVtmsJNo+B2BnSIjV8
 q1N2Q4dWMulWXbsdjZvxGUcN/y8LmOtBcxM63eKiHlTMkCvgcg7lVzINc/mpiaF5SAl39V
 uqLdCjCyzlYWtPzBTcBQu8Noyu4xrYI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-Bwa9Lcj8NIe4irPVBlXpaw-1; Thu, 20 Feb 2020 11:03:29 -0500
X-MC-Unique: Bwa9Lcj8NIe4irPVBlXpaw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F06668017CC;
 Thu, 20 Feb 2020 16:03:27 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5671089F08;
 Thu, 20 Feb 2020 16:03:21 +0000 (UTC)
Subject: Re: [RFC PATCH v3 06/27] qcow2: Add dummy has_subclusters() function
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1577014346.git.berto@igalia.com>
 <bebe4058df5210ac3293e917ad6b61abac398f60.1577014346.git.berto@igalia.com>
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
Message-ID: <d639b563-830f-a118-d35d-a57eaf26bb0e@redhat.com>
Date: Thu, 20 Feb 2020 17:03:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <bebe4058df5210ac3293e917ad6b61abac398f60.1577014346.git.berto@igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="T5X9o8sfbq0665kYLaCkd2W4j6DnZjB0V"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
--T5X9o8sfbq0665kYLaCkd2W4j6DnZjB0V
Content-Type: multipart/mixed; boundary="uz2HbngxSkIZMdO3X0yXrfQOjT6SugQ40"

--uz2HbngxSkIZMdO3X0yXrfQOjT6SugQ40
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 22.12.19 12:36, Alberto Garcia wrote:
> This function will be used by the qcow2 code to check if an image has
> subclusters or not.
>=20
> At the moment this simply returns false. Once all patches needed for
> subcluster support are ready then QEMU will be able to create and
> read images with subclusters and this function will return the actual
> value.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2.h | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--uz2HbngxSkIZMdO3X0yXrfQOjT6SugQ40--

--T5X9o8sfbq0665kYLaCkd2W4j6DnZjB0V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5OrccACgkQ9AfbAGHV
z0BzcAgAmdQaCvWcVwotxfNxzICJU0/TtBzkLcjXUVKVf/cs79IRQbMqsk5g+Dj7
XEZaPBGu2uZ1e0p4Xfx+wTISssyox7iECELLzRf0nSjggNNOXiJ6KaiJXV2pLWUO
DymfPos4rKsJK8Lc2JTZl6wOHSHkR/vY15d7iyJuGlK0Zu5Nxu89osH6TJ1H13mq
5KGARiz2KTcA5zpWe33DLiBYYDKzHUnhLKeaV+7CFhzu3u3Uym9S/2S9D5FvLFm+
Fi5Sdgxls3CcPpDzgQSiLynrKzblV4XIS4UXSe0i6A3iI5binZpN4cafaOsU0UCg
xAQ1iplH7UMKMxsmuQHO3kwLrW6Y9w==
=k6p/
-----END PGP SIGNATURE-----

--T5X9o8sfbq0665kYLaCkd2W4j6DnZjB0V--


