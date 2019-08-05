Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC89C0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 11:33:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B322C20679
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 11:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B322C20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hubEp-0007Px-2F
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 07:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56987)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hubEP-0006vh-As
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 07:32:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hubEO-0003is-2S
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 07:32:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:9349)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hubEL-0003hH-GU; Mon, 05 Aug 2019 07:32:45 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B402C308A968;
 Mon,  5 Aug 2019 11:32:44 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A559CF6D9;
 Mon,  5 Aug 2019 11:32:40 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20190802185830.74648-1-vsementsov@virtuozzo.com>
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
Message-ID: <e97ff375-6527-8701-2ee5-bf5bb4e1a9bf@redhat.com>
Date: Mon, 5 Aug 2019 13:32:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802185830.74648-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CAo88kCi4G2kehwymQclYcdlueCCYAHMx"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Mon, 05 Aug 2019 11:32:44 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] util/hbitmap: fix unaligned reset
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
Cc: fam@euphon.net, kwolf@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org,
 den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CAo88kCi4G2kehwymQclYcdlueCCYAHMx
Content-Type: multipart/mixed; boundary="3ZzsMiZ55qRtj1XKNibOQPiwmws3SaF7D";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, fam@euphon.net,
 kwolf@redhat.com, den@openvz.org
Message-ID: <e97ff375-6527-8701-2ee5-bf5bb4e1a9bf@redhat.com>
Subject: Re: [PATCH] util/hbitmap: fix unaligned reset
References: <20190802185830.74648-1-vsementsov@virtuozzo.com>
In-Reply-To: <20190802185830.74648-1-vsementsov@virtuozzo.com>

--3ZzsMiZ55qRtj1XKNibOQPiwmws3SaF7D
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 02.08.19 20:58, Vladimir Sementsov-Ogievskiy wrote:
> hbitmap_reset is broken: it rounds up the requested region. It leads to=

> the following bug, which is shown by fixed test:
>=20
> assume granularity =3D 2
> set(0, 3) # count becomes 4
> reset(0, 1) # count becomes 2
>=20
> But user of the interface assume that virtual bit 1 should be still
> dirty, so hbitmap should report count to be 4!
>=20
> In other words, because of granularity, when we set one "virtual" bit,
> yes, we make all "virtual" bits in same chunk to be dirty. But this
> should not be so for reset.
>=20
> Fix this, aligning bound correctly.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>=20
> Hi all!
>=20
> Hmm, is it a bug or feature? :)
> I don't have a test for mirror yet, but I think that sync mirror may be=
 broken
> because of this, as do_sync_target_write() seems to be using unaligned =
reset.
>=20
>  tests/test-hbitmap.c |  2 +-
>  util/hbitmap.c       | 24 +++++++++++++++++++-----
>  2 files changed, 20 insertions(+), 6 deletions(-)
>=20
> diff --git a/tests/test-hbitmap.c b/tests/test-hbitmap.c
> index 592d8219db..0008025a9f 100644
> --- a/tests/test-hbitmap.c
> +++ b/tests/test-hbitmap.c
> @@ -424,7 +424,7 @@ static void test_hbitmap_granularity(TestHBitmapDat=
a *data,
>      hbitmap_test_set(data, 0, 3);
>      g_assert_cmpint(hbitmap_count(data->hb), =3D=3D, 4);
>      hbitmap_test_reset(data, 0, 1);
> -    g_assert_cmpint(hbitmap_count(data->hb), =3D=3D, 2);
> +    g_assert_cmpint(hbitmap_count(data->hb), =3D=3D, 4);
>  }
> =20
>  static void test_hbitmap_iter_granularity(TestHBitmapData *data,
> diff --git a/util/hbitmap.c b/util/hbitmap.c
> index 7905212a8b..61a813994a 100644
> --- a/util/hbitmap.c
> +++ b/util/hbitmap.c
> @@ -473,15 +473,29 @@ void hbitmap_reset(HBitmap *hb, uint64_t start, u=
int64_t count)
>  {
>      /* Compute range in the last layer.  */
>      uint64_t first;
> -    uint64_t last =3D start + count - 1;
> +    uint64_t last;
> +    uint64_t end =3D start + count;
> +    uint64_t gran =3D UINT64_C(1) << hb->granularity;
> =20
> -    trace_hbitmap_reset(hb, start, count,
> -                        start >> hb->granularity, last >> hb->granular=
ity);
> +    /*
> +     * We should clear only bits, fully covered by requested region. O=
therwise
> +     * we may clear something that is actually still dirty.
> +     */
> +    first =3D DIV_ROUND_UP(start, gran);
> =20
> -    first =3D start >> hb->granularity;
> -    last >>=3D hb->granularity;
> +    if (end =3D=3D hb->orig_size) {

This should be =E2=80=9C>=3D=E2=80=9D.

There are callers that don=E2=80=99t make sure that start + count <=3D
hb->orig_size (e.g. the backup job just calls it with multiples of
cluster_size, which may or may not end up at the image end; and
hbitmap_truncate() just uses =E2=80=9Chb->size << hb->granularity=E2=80=9D=
 as the end,
which is arguably not ideal, but that=E2=80=99s how it is).

Max

> +        end =3D DIV_ROUND_UP(end, gran);
> +    } else {
> +        end =3D end >> hb->granularity;
> +    }
> +    if (end <=3D first) {
> +        return;
> +    }
> +    last =3D end - 1;
>      assert(last < hb->size);
> =20
> +    trace_hbitmap_reset(hb, start, count, first, last);
> +
>      hb->count -=3D hb_count_between(hb, first, last);
>      if (hb_reset_between(hb, HBITMAP_LEVELS - 1, first, last) &&
>          hb->meta) {
>=20



--3ZzsMiZ55qRtj1XKNibOQPiwmws3SaF7D--

--CAo88kCi4G2kehwymQclYcdlueCCYAHMx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1IE9cACgkQ9AfbAGHV
z0An4gf+JO7R2FSizsXWCyLoEhre1yOSvH8muIhgqvBQDYJWFIdU+9jp9RjakhEj
lPRVWsujifdBiBVBAVnDyyY3O875LcBW0xXBp3bWO6qTygvGxuOEJwVTJQcC7dtD
JFLP2zYp/HUdlD27M13DF+RJxTOgX1sgr6BLGSBkzd7IfQpYnlxWekjZgmUtTEam
n+B6sAC/g/HW0SP2CUnPln/b94ntojnEKpupijkw+r0SDhM7Cqp7rmubBT49QjIL
RN0Ucd5ko6jknjlb0z/7lDyFzVucm1NREgF5HSh0hRec4Wu5nkd0jWsdTimkdTbE
CA2g8nMLDBb1aDlswfcvuf2yhss0Lg==
=DAVk
-----END PGP SIGNATURE-----

--CAo88kCi4G2kehwymQclYcdlueCCYAHMx--

