Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CCDC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 14:51:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 643B920780
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 14:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f4wLicVT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 643B920780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr0YL-0002j6-Md
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 10:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jr0XY-0001rP-V5
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 10:50:16 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53306
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jr0XW-0004Ch-6A
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 10:50:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593701412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xdYoEge9p0b26RNFypop29e+6QfpopZSZeerSbyBnuw=;
 b=f4wLicVTqVTUFMhi689eVQ4/ooMhRFMBapj+Cmnnlt553CD8E5yuMlX7lsO6/gS/Fl3s3g
 mk2wt6nze8uyaQXZdxaJmuYDnQXcdIj4WlpzrWteyOb5dtv2tBIR7uXdA9jf9uUsgLGUK5
 ormlRhvRvlHtZxFM5eoHNgJWL+rnu6s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-3WnY3TaCOHaYRuBa9fko8w-1; Thu, 02 Jul 2020 10:50:10 -0400
X-MC-Unique: 3WnY3TaCOHaYRuBa9fko8w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CCF98100A8E8;
 Thu,  2 Jul 2020 14:50:08 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-196.ams2.redhat.com
 [10.36.113.196])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C9A7610F2;
 Thu,  2 Jul 2020 14:50:06 +0000 (UTC)
Subject: Re: [PATCH v9 30/34] qcow2: Add prealloc field to QCowL2Meta
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1593342067.git.berto@igalia.com>
 <0dd88b3b4d3e90b28267267d7686cf5350d9dea0.1593342067.git.berto@igalia.com>
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
Message-ID: <cadd98f7-1fc4-3a54-5999-b988cc79e618@redhat.com>
Date: Thu, 2 Jul 2020 16:50:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <0dd88b3b4d3e90b28267267d7686cf5350d9dea0.1593342067.git.berto@igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6uOnktM6KUYLY1arRk1FT3lSuIZyhRJbY"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 04:18:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Derek Su <dereksu@qnap.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6uOnktM6KUYLY1arRk1FT3lSuIZyhRJbY
Content-Type: multipart/mixed; boundary="kbpCIoZiCAQT0FL08PU9abhIcxGj3sy9n"

--kbpCIoZiCAQT0FL08PU9abhIcxGj3sy9n
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 28.06.20 13:02, Alberto Garcia wrote:
> This field allows us to indicate that the L2 metadata update does not
> come from a write request with actual data but from a preallocation
> request.
>=20
> For traditional images this does not make any difference, but for
> images with extended L2 entries this means that the clusters are
> allocated normally in the L2 table but individual subclusters are
> marked as unallocated.
>=20
> This will allow preallocating images that have a backing file.
>=20
> There is one special case: when we resize an existing image we can
> also request that the new clusters are preallocated. If the image
> already had a backing file then we have to hide any possible stale
> data and zero out the new clusters (see commit 955c7d6687 for more
> details).
>=20
> In this case the subclusters cannot be left as unallocated so the L2
> bitmap must be updated.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/qcow2.h         | 8 ++++++++
>  block/qcow2-cluster.c | 2 +-
>  block/qcow2.c         | 6 ++++++
>  3 files changed, 15 insertions(+), 1 deletion(-)

Sounds good, but I=E2=80=99m just not quite sure about the details on
falloc/full allocation: With .prealloc =3D true, writing to the
preallocated subclusters will require a COW operation.  That=E2=80=99s not
ideal, and avoiding those COWs may be a reason to do preallocation in
the first place.

Now, with backing files, it=E2=80=99s entirely correct.  You need a COW
operation, because that=E2=80=99s the point of having a backing file.

But without a backing file I wonder if it wouldn=E2=80=99t be better to set
.prealloc =3D false to avoid that COW.

Of course, if we did that, you couldn=E2=80=99t create the overlay separate=
ly
from the backing file, preallocate it, and only then attach the backing
file to the overlay.  But is that a problem?

(Or are there other problems to consider?)

Max


--kbpCIoZiCAQT0FL08PU9abhIcxGj3sy9n--

--6uOnktM6KUYLY1arRk1FT3lSuIZyhRJbY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl799BwACgkQ9AfbAGHV
z0C1NggAiLgSQ9iLHc5kLGt9k7kaW4PWqdwjZBRbmfQHQ5z1WBZUVD5gFzCdbixa
i/DTKumqSYiulvVFe1oyvwNnmTZDyFIW0Zu6c7t1ynp7ZZRB0Cuj3TmR7XtMiGqJ
1D5kO7c2kVC9Hqsgot1vyMqQfoVhUKHxq26IpWYTuPGhHPyt1kaznmqA8AIxcSDD
ziuccGvy3kCDexaUObWNiSg2x/kvhIysoSdMR8ftO/vAXGk5aMm5Nacfkb4lK+rM
yYzWwvoFo4AJipFpeDL81QvcC37kTau36vi0WojUpcbfK+iEzJ5NYbowAymVwvOV
cFgZigHOEmggsatO1zNN9HqCzJ/tgg==
=FYdA
-----END PGP SIGNATURE-----

--6uOnktM6KUYLY1arRk1FT3lSuIZyhRJbY--


