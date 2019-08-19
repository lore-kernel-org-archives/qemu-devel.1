Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D143C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 19:27:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1464E206C1
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 19:27:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1464E206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hznJB-0004Ew-8c
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 15:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36843)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1hznI9-0003fg-AK
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 15:26:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hznI8-0001D2-64
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 15:26:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60070)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hznI2-00017t-5N; Mon, 19 Aug 2019 15:26:02 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 416FE19562BC;
 Mon, 19 Aug 2019 19:26:01 +0000 (UTC)
Received: from [10.3.117.3] (ovpn-117-3.phx2.redhat.com [10.3.117.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B42315C559;
 Mon, 19 Aug 2019 19:26:00 +0000 (UTC)
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20190819185602.4267-1-mreitz@redhat.com>
 <20190819185602.4267-8-mreitz@redhat.com>
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
Message-ID: <77ed11dd-9fc0-d139-d308-05dadf963dc9@redhat.com>
Date: Mon, 19 Aug 2019 14:25:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190819185602.4267-8-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mO93EJkGzq8VRrXHTwkHuvFQQd3Tqxwnr"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Mon, 19 Aug 2019 19:26:01 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 07/16] qcow2: Write v3-compliant
 snapshot list on upgrade
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
--mO93EJkGzq8VRrXHTwkHuvFQQd3Tqxwnr
Content-Type: multipart/mixed; boundary="VfD6pcNS5yrsUreTgEraacKmmAMbioG8f";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <77ed11dd-9fc0-d139-d308-05dadf963dc9@redhat.com>
Subject: Re: [PATCH v2 07/16] qcow2: Write v3-compliant snapshot list on
 upgrade
References: <20190819185602.4267-1-mreitz@redhat.com>
 <20190819185602.4267-8-mreitz@redhat.com>
In-Reply-To: <20190819185602.4267-8-mreitz@redhat.com>

--VfD6pcNS5yrsUreTgEraacKmmAMbioG8f
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/19/19 1:55 PM, Max Reitz wrote:
> qcow2 v3 requires every snapshot table entry to have two extra data
> fields: The 64-bit VM state size, and the virtual disk size.  Both are
> optional for v2 images, so they may not be present.
>=20
> qcow2_upgrade() therefore should update the snapshot table to ensure al=
l
> entries have these extra data fields.
>=20
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1727347
> Reported-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/qcow2.c | 32 ++++++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
>=20

> @@ -4768,7 +4770,33 @@ static int qcow2_upgrade(BlockDriverState *bs, i=
nt target_version,
>      /* There are no other versions (yet) that you can upgrade to */
>      assert(target_version =3D=3D 3);
> =20
> -    status_cb(bs, 0, 1, cb_opaque);
> +    status_cb(bs, 0, 2, cb_opaque);
> +
> +    /*
> +     * In v2, snapshots do not need to have extra data.  v3 requires
> +     * the 64-bit VM state size and the virtual disk size to be
> +     * present.
> +     * qcow2_write_snapshots() will always write the list in the
> +     * v3-compliant format.
> +     */
> +    need_snapshot_update =3D false;
> +    for (i =3D 0; i < s->nb_snapshots; i++) {
> +        if (s->snapshots[i].extra_data_size <
> +            sizeof_field(QCowSnapshotExtraData, vm_state_size_large) +=

> +            sizeof_field(QCowSnapshotExtraData, disk_size))

sizeof(extra) would be more concise than two sizeof_field() added
together, but might cause problems if we later expand the size of extra
for other reasons, but don't revisit this code.  So I actually like what
you did here.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--VfD6pcNS5yrsUreTgEraacKmmAMbioG8f--

--mO93EJkGzq8VRrXHTwkHuvFQQd3Tqxwnr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1a98gACgkQp6FrSiUn
Q2r/SQf+LHAACjC0dSYUhVCxQNJsZWawuVZjhWzcp1FwioY7VE4ruz1vM1p4126R
Zlj6uVsOzwFuHJmgZZJqgfpF7w40jA3qZPGzPK0wCEcpsU0ryaNZxSdwLMZKOaCh
DbdCgatFaXjJ0JONfaTLswiJI53AzY/1MvJPnGLgYC5tPWRN50t0LnPErwo4AISQ
RZ+SYBvsLINrKXnMDAE+mWSl4I+Aq6/mhHAuIkB/oxGvE5JXQWh6f/xnVSrk07Vb
JuHnR6Fr8YvDrc4BF0NoXHTmVeSioaTGliYJm4mP3eK6YH7P7QpdOjPzUvCBcvvD
krNNhmSGEG3cc0vWDbhX6BP6gd4NHQ==
=1c51
-----END PGP SIGNATURE-----

--mO93EJkGzq8VRrXHTwkHuvFQQd3Tqxwnr--

