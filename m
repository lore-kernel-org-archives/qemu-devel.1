Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391C5C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 19:09:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B6D22064A
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 19:09:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B6D22064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsXV9-0000th-BR
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 15:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53018)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hsXUL-00006N-SL
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 15:08:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hsXUK-0006rS-O9
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 15:08:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48920)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hsXUG-0006n4-Hm; Tue, 30 Jul 2019 15:08:40 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 82C2D81F0F;
 Tue, 30 Jul 2019 19:08:39 +0000 (UTC)
Received: from [10.3.116.93] (ovpn-116-93.phx2.redhat.com [10.3.116.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A4F2F5C1A1;
 Tue, 30 Jul 2019 19:08:38 +0000 (UTC)
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20190730172508.19911-1-mreitz@redhat.com>
 <20190730172508.19911-10-mreitz@redhat.com>
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
Message-ID: <43850eef-932e-6f28-6346-15cd91e5ebbb@redhat.com>
Date: Tue, 30 Jul 2019 14:08:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190730172508.19911-10-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="TbegD9a7KNRoD0Dv0apYN0MoloVX2QYLi"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 30 Jul 2019 19:08:39 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.2 09/13] qcow2: Fix overly long
 snapshot tables
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TbegD9a7KNRoD0Dv0apYN0MoloVX2QYLi
Content-Type: multipart/mixed; boundary="IQk6BvfprSIPPKcnCc72yHIgGhrbctUs1";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <43850eef-932e-6f28-6346-15cd91e5ebbb@redhat.com>
Subject: Re: [PATCH for-4.2 09/13] qcow2: Fix overly long snapshot tables
References: <20190730172508.19911-1-mreitz@redhat.com>
 <20190730172508.19911-10-mreitz@redhat.com>
In-Reply-To: <20190730172508.19911-10-mreitz@redhat.com>

--IQk6BvfprSIPPKcnCc72yHIgGhrbctUs1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/30/19 12:25 PM, Max Reitz wrote:
> We currently refuse to open qcow2 images with overly long snapshot
> tables.  This patch makes qemu-img check -r all drop all offending
> entries past what we deem acceptable.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/qcow2-snapshot.c | 89 +++++++++++++++++++++++++++++++++++++-----=

>  1 file changed, 79 insertions(+), 10 deletions(-)

I'm less sure about this one.  8/13 should have no semantic effect (if
the user _depended_ on that much extra data, they should have set an
incompatible feature flag bit, at which point we'd leave their data
alone because we don't recognize the feature bit; so it is safe to
assume the user did not depend on the data and that we can thus nuke it
with impunity).  But here, we are throwing away the user's internal
snapshots, and not even giving them a say in which ones to throw away
(more likely, by trimming from the end, we are destroying the most
recent snapshots in favor of the older ones - but I could argue that
throwing away the oldest also has its uses).


> @@ -417,7 +461,32 @@ int coroutine_fn qcow2_check_read_snapshot_table(B=
lockDriverState *bs,
> =20
>          return ret;
>      }
> -    result->corruptions +=3D extra_data_dropped;
> +    result->corruptions +=3D nb_clusters_reduced + extra_data_dropped;=

> +
> +    if (nb_clusters_reduced) {
> +        /*
> +         * Update image header now, because:
> +         * (1) qcow2_check_refcounts() relies on s->nb_snapshots to be=

> +         *     the same as what the image header says,
> +         * (2) this leaks clusters, but qcow2_check_refcounts() will
> +         *     fix that.
> +         */
> +        assert(fix & BDRV_FIX_ERRORS);
> +
> +        snapshot_table_pointer.nb_snapshots =3D cpu_to_be32(s->nb_snap=
shots);
> +        ret =3D bdrv_pwrite_sync(bs->file, 60,

That '60' needs a name; it keeps popping up.

If we like the patch, I didn't spot major coding problems.  But because
I'm not sure we want this patch, I'll skip R-b for now.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--IQk6BvfprSIPPKcnCc72yHIgGhrbctUs1--

--TbegD9a7KNRoD0Dv0apYN0MoloVX2QYLi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1AlbUACgkQp6FrSiUn
Q2rWRAf+KEMpG0tC2jXJ6r5OtU9dZkunxY6/pqtgq2LyhCO7tLlneIBtd3CpGhPH
olNII93whTm9zI3PkOuAhak4rDvdLok+JWRDON34OJlI+Fs/6K3cWDBOU5N7rveb
3+bYgwe0JxxRNiwP8QpSo4/xNmR01WSp488wY6bfVl+HIKq3ayE6a0bvJrwtrlSO
3hX/M/fk5Bwi3/X+W0KTZi1XvTo4PIRBFoPM+LyqQP9InjJkfK6FnrgwFqe6843A
Oc1y4GVHQ0Q3yun4V4kG7C/C7EesR5z6NvKVr4CvmYycmibOep+ZvLve77QSdTGs
ymMg4Vqs8RJS4sAHUlHykCY8TV2Kjw==
=EMHq
-----END PGP SIGNATURE-----

--TbegD9a7KNRoD0Dv0apYN0MoloVX2QYLi--

