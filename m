Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE92C10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 19:08:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3059D20855
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 19:08:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3059D20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57605 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDZdY-00063h-Ag
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 15:08:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hDZYG-00028j-BV
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:03:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hDZYF-0007hE-14
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:03:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hDZY7-0007Yo-CX; Mon, 08 Apr 2019 15:03:20 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7E21B3007C32;
	Mon,  8 Apr 2019 19:03:10 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-100.brq.redhat.com
	[10.40.204.100])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AA87719C57;
	Mon,  8 Apr 2019 19:03:08 +0000 (UTC)
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
	qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <1551346019-293202-1-git-send-email-andrey.shinkevich@virtuozzo.com>
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
Message-ID: <1c64f75a-d379-980f-aab9-d4ce75c1144b@redhat.com>
Date: Mon, 8 Apr 2019 21:03:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1551346019-293202-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bg0Soj2nfIfpWsJ6601seDLdHDolp1QSY"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Mon, 08 Apr 2019 19:03:10 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v2] qcow2: discard bitmap when removed
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
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408190306.jJsokmhlbtyeZEtUHSFJXqmgMtxdWO4F0W4-aGTF9SM@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bg0Soj2nfIfpWsJ6601seDLdHDolp1QSY
From: Max Reitz <mreitz@redhat.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com
Message-ID: <1c64f75a-d379-980f-aab9-d4ce75c1144b@redhat.com>
Subject: Re: [PATCH v2] qcow2: discard bitmap when removed
References: <1551346019-293202-1-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1551346019-293202-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 28.02.19 10:26, Andrey Shinkevich wrote:
> When a bitmap is removed, we can clean some space on the disk. The size=

> of a cluster may be larger, so is the size of the bitmap that includes
> many clusters. Some bitmaps can be as large as tens of megabytes.
> The flag QCOW2_DISCARD_ALWAYS allows a call to the raw_co_pdiscard()
> that does the actual cleaning of the image on disk, while with the flag=

> QCOW2_DISCARD_OTHER, a reference count of the cluster is updated only.
>=20
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
> v1: Discard old bitmap directories in QCOW2 image
>=20
> In the first version of the patch, any call to qcow2_free_clusters() in=

> block/qcow2-bitmap.c was with the flag QCOW2_DISCARD_ALWAYS, even in th=
e
> cases when the cleaned space is insignificant, particularly, in case of=

> bitmap directories.
> Discussed in the email thread with the message ID
> <1549974951-731285-1-git-send-email-andrey.shinkevich@virtuozzo.com>
>=20
>  block/qcow2-bitmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, changed the commit message to Vladimir=E2=80=99s proposal and app=
lied to
my block-next branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block-next

Max


--bg0Soj2nfIfpWsJ6601seDLdHDolp1QSY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlyrmusACgkQ9AfbAGHV
z0Bz1AgAobena+F9O1UAYsE+dsFEdKmtKwt31AB1+kzAZ5BMHu5y+o9eA845tAS7
tRulyBFi1jECq/QeL/Pk2voFEInfjAKs87Wx8fmLVAPnBi0yoG+5E/1zlhcYig+7
W4buiJJhC6pXkpPuzmXhpGwG547iARRBKWNjUCtTnZAaYSQjxSXCehVjLY2QZsI9
QNK7d9JN69gImQvYPg3k6ORPsU54soItUYsoS/IGX1wxVdqgqPaVkAE+t5DDgqj6
xOt2JiO4yUCladKLHExUnrkBZFeFKI84vrSTpPuj5AoRI2QxAJwfvNPlhbAJRqMq
10UA2pFF8zXJ0MRt0JzYFfyDnqR1rg==
=vVXa
-----END PGP SIGNATURE-----

--bg0Soj2nfIfpWsJ6601seDLdHDolp1QSY--

