Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA82C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:01:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98AD02089E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:01:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98AD02089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw7KG-00039X-JL
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 12:01:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54047)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hw7JE-0001Fm-KP
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:00:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hw7JD-0003fT-BU
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:00:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:15117)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hw7JA-0003Ye-Jv; Fri, 09 Aug 2019 12:00:00 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A195B315C00B;
 Fri,  9 Aug 2019 15:59:59 +0000 (UTC)
Received: from [10.3.116.93] (ovpn-116-93.phx2.redhat.com [10.3.116.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E73819C70;
 Fri,  9 Aug 2019 15:59:54 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20190809153207.49288-1-vsementsov@virtuozzo.com>
 <20190809153207.49288-7-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=eblake@redhat.com; keydata=
 xsBNBEvHyWwBCACw7DwsQIh0kAbUXyqhfiKAKOTVu6OiMGffw2w90Ggrp4bdVKmCaEXlrVLU
 xphBM8mb+wsFkU+pq9YR621WXo9REYVIl0FxKeQo9dyQBZ/XvmUMka4NOmHtFg74nvkpJFCD
 TUNzmqfcjdKhfFV0d7P/ixKQeZr2WP1xMcjmAQY5YvQ2lUoHP43m8TtpB1LkjyYBCodd+LkV
 GmCx2Bop1LSblbvbrOm2bKpZdBPjncRNob73eTpIXEutvEaHH72LzpzksfcKM+M18cyRH+nP
 sAd98xIbVjm3Jm4k4d5oQyE2HwOur+trk2EcxTgdp17QapuWPwMfhaNq3runaX7x34zhABEB
 AAHNHkVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29tPsLAegQTAQgAJAIbAwULCQgHAwUV
 CgkICwUWAgMBAAIeAQIXgAUCS8fL9QIZAQAKCRCnoWtKJSdDahBHCACbl/5FGkUqJ89GAjeX
 RjpAeJtdKhujir0iS4CMSIng7fCiGZ0fNJCpL5RpViSo03Q7l37ss+No+dJI8KtAp6ID+PMz
 wTJe5Egtv/KGUKSDvOLYJ9WIIbftEObekP+GBpWP2+KbpADsc7EsNd70sYxExD3liwVJYqLc
 Rw7so1PEIFp+Ni9A1DrBR5NaJBnno2PHzHPTS9nmZVYm/4I32qkLXOcdX0XElO8VPDoVobG6
 gELf4v/vIImdmxLh/w5WctUpBhWWIfQDvSOW2VZDOihm7pzhQodr3QP/GDLfpK6wI7exeu3P
 pfPtqwa06s1pae3ad13mZGzkBdNKs1HEm8x6zsBNBEvHyWwBCADGkMFzFjmmyqAEn5D+Mt4P
 zPdO8NatsDw8Qit3Rmzu+kUygxyYbz52ZO40WUu7EgQ5kDTOeRPnTOd7awWDQcl1gGBXgrkR
 pAlQ0l0ReO57Q0eglFydLMi5bkwYhfY+TwDPMh3aOP5qBXkm4qIYSsxb8A+i00P72AqFb9Q7
 3weG/flxSPApLYQE5qWGSXjOkXJv42NGS6o6gd4RmD6Ap5e8ACo1lSMPfTpGzXlt4aRkBfvb
 NCfNsQikLZzFYDLbQgKBA33BDeV6vNJ9Cj0SgEGOkYyed4I6AbU0kIy1hHAm1r6+sAnEdIKj
 cHi3xWH/UPrZW5flM8Kqo14OTDkI9EtlABEBAAHCwF8EGAEIAAkFAkvHyWwCGwwACgkQp6Fr
 SiUnQ2q03wgAmRFGDeXzc58NX0NrDijUu0zx3Lns/qZ9VrkSWbNZBFjpWKaeL1fdVeE4TDGm
 I5mRRIsStjQzc2R9b+2VBUhlAqY1nAiBDv0Qnt+9cLiuEICeUwlyl42YdwpmY0ELcy5+u6wz
 mK/jxrYOpzXKDwLq5k4X+hmGuSNWWAN3gHiJqmJZPkhFPUIozZUCeEc76pS/IUN72NfprZmF
 Dp6/QDjDFtfS39bHSWXKVZUbqaMPqlj/z6Ugk027/3GUjHHr8WkeL1ezWepYDY7WSoXwfoAL
 2UXYsMAr/uUncSKlfjvArhsej0S4zbqim2ZY6S8aRWw94J3bSvJR+Nwbs34GPTD4Pg==
Organization: Red Hat, Inc.
Message-ID: <62bca2ef-d175-6926-e1e8-5edfc08d58ab@redhat.com>
Date: Fri, 9 Aug 2019 10:59:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190809153207.49288-7-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MxMtmgcDqSFsizqRw2sP3BGhXD612mTZ7"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 09 Aug 2019 15:59:59 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 6/7] block/backup: teach
 backup_cow_with_bounce_buffer to copy more at once
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MxMtmgcDqSFsizqRw2sP3BGhXD612mTZ7
Content-Type: multipart/mixed; boundary="FuBF7NkqvicEPde5zpZGf1gIG3SWlQxSR";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com,
 den@openvz.org, jsnow@redhat.com
Message-ID: <62bca2ef-d175-6926-e1e8-5edfc08d58ab@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 6/7] block/backup: teach
 backup_cow_with_bounce_buffer to copy more at once
References: <20190809153207.49288-1-vsementsov@virtuozzo.com>
 <20190809153207.49288-7-vsementsov@virtuozzo.com>
In-Reply-To: <20190809153207.49288-7-vsementsov@virtuozzo.com>

--FuBF7NkqvicEPde5zpZGf1gIG3SWlQxSR
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/9/19 10:32 AM, Vladimir Sementsov-Ogievskiy wrote:
> backup_cow_with_offload can transfer more than on cluster. Let

s/on/one/

> backup_cow_with_bounce_buffer behave similarly. It reduces number
> of IO and there are no needs to copy cluster by cluster.

It reduces the number of IO requests, since there is no need to copy
cluster by cluster.

>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/backup.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
>=20
> diff --git a/block/backup.c b/block/backup.c
> index d482d93458..155e21d0a3 100644
> --- a/block/backup.c
> +++ b/block/backup.c
> @@ -104,22 +104,25 @@ static int coroutine_fn backup_cow_with_bounce_bu=
ffer(BackupBlockJob *job,
>                                                        int64_t start,
>                                                        int64_t end,
>                                                        bool is_write_no=
tifier,
> -                                                      bool *error_is_r=
ead,
> -                                                      void **bounce_bu=
ffer)
> +                                                      bool *error_is_r=
ead)

Why is this signature changing?

>  {
>      int ret;
>      BlockBackend *blk =3D job->common.blk;
>      int nbytes;
>      int read_flags =3D is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0=
;
> +    void *bounce_buffer;
> =20
>      assert(QEMU_IS_ALIGNED(start, job->cluster_size));
> -    bdrv_reset_dirty_bitmap(job->copy_bitmap, start, job->cluster_size=
);
> -    nbytes =3D MIN(job->cluster_size, job->len - start);
> -    if (!*bounce_buffer) {
> -        *bounce_buffer =3D blk_blockalign(blk, job->cluster_size);

Pre-patch, you allocate the bounce_buffer at most once (but limited to a
cluster size), post-patch, you are now allocating and freeing a bounce
buffer every iteration through.  There may be fewer calls because you
are allocating something bigger, but still, isn't it a good goal to try
and allocate the bounce buffer as few times as possible and reuse it,
rather than getting a fresh one each iteration?

> +
> +    nbytes =3D MIN(end - start, job->len - start);

What is the largest this will be? Will it exhaust memory on a 32-bit or
otherwise memory-constrained system, where you should have some maximum
cap for how large the bounce buffer will be while still getting better
performance than one cluster at a time and not slowing things down by
over-sizing malloc?  64M, maybe?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--FuBF7NkqvicEPde5zpZGf1gIG3SWlQxSR--

--MxMtmgcDqSFsizqRw2sP3BGhXD612mTZ7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1NmHkACgkQp6FrSiUn
Q2ofAQf/eFJtlEXaE4rm3eFHjnFCy8qGa2W0NpWwgrqvqc4SQoy7VFJHnE9NQQr1
5bddGS9v4vGDtq5VVXMxLJfD8LPBvWXi5KdDPLJko3WDPap+3XMXDLGjvhuqDwuN
NEXUycnNNf8QMktUfRCh+O/2s55i6XZmQ0ZCbRDTIXN1q/asw6tkp0KMT35CKHVB
8xMCRFpNr3L3T6kkvOTM9QnSxA+TT7gnXROpOqDbzDyleHNjSPZ0C1/f0WctiRoI
gNLsx4OPx8kFTeriAxoZH3Z7jPRkcUr7JGw/IkrT1mXzNvfHdkx+2ZAgZDzgmM5J
0ux+lUXTIebrxJEAyL8vKCNIeYkVjA==
=6v2f
-----END PGP SIGNATURE-----

--MxMtmgcDqSFsizqRw2sP3BGhXD612mTZ7--

