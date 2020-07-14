Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E912C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 03:23:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EF63206D9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 03:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g7CPVloi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF63206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvBXM-0001rp-Ex
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 23:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jvBWh-0001Mo-PN
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 23:22:39 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36608
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jvBWg-00006H-AT
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 23:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594696957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tRWwIyu4oOMvqLNRZsAVngXFQsyNwrIHohrJD16Bqps=;
 b=g7CPVloikc5j37IJTp+jI2tg9ICWob12tt80EZwAsqW67DT0/0EByO3i+YYUeslQ0F1VRu
 Yy9Umd9Y56zHX0a80qE4cAEUTe7rHfkg5vrWPF58ZZPF5PZb1zwjO0PZyTJfEswHam1X+M
 dvq6zgDYZqYvMYOXFshXnbApejeKMRM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-E2h5FCvjPVmnLwda2u0xaw-1; Mon, 13 Jul 2020 23:22:34 -0400
X-MC-Unique: E2h5FCvjPVmnLwda2u0xaw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 875338018A1;
 Tue, 14 Jul 2020 03:22:32 +0000 (UTC)
Received: from localhost.localdomain (ovpn-112-247.rdu2.redhat.com
 [10.10.112.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8246C6FDD1;
 Tue, 14 Jul 2020 03:22:28 +0000 (UTC)
Date: Mon, 13 Jul 2020 23:22:26 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH v2 4/9] tests/acceptance/boot_linux: Expand SD card image
 to power of 2
Message-ID: <20200714032226.GE2983508@localhost.localdomain>
References: <20200713183209.26308-1-f4bug@amsat.org>
 <20200713183209.26308-5-f4bug@amsat.org>
MIME-Version: 1.0
In-Reply-To: <20200713183209.26308-5-f4bug@amsat.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pY3vCvL1qV+PayAL"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 23:07:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Prasad J Pandit <pjp@fedoraproject.org>, qemu-block@nongnu.org,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Niek Linnenbank <nieklinnenbank@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--pY3vCvL1qV+PayAL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2020 at 08:32:04PM +0200, Philippe Mathieu-Daud=E9 wrote:
> In few commits we won't allow SD card images with invalid size
> (not aligned to a power of 2). Prepare the tests: add the
> pow2ceil() and image_pow2ceil_expand() methods and resize the
> images (expanding) of the tests using SD cards.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
> Since v1: Addressed review comments
> - truncate -> expand reword (Alistair Francis)
> - expand after uncompress (Niek Linnenbank)
> ---
>  tests/acceptance/boot_linux_console.py | 27 +++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
>=20
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index b7e8858c2d..8f2a6aa8a4 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -28,6 +28,18 @@
>  except CmdNotFoundError:
>      P7ZIP_AVAILABLE =3D False
> =20
> +# round up to next power of 2
> +def pow2ceil(x):
> +    return 1 if x =3D=3D 0 else 2**(x - 1).bit_length()
> +

Nitpick: turn the comment into a docstring.

Then, I was going to have a second nitpick about the method name, but
realized it was following qemu-common.h's implementation.

> +# expand file size to next power of 2
> +def image_pow2ceil_expand(path):
> +        size =3D os.path.getsize(path)
> +        size_aligned =3D pow2ceil(size)
> +        if size !=3D size_aligned:
> +            with open(path, 'ab+') as fd:
> +                fd.truncate(size_aligned)
> +

Same nitpick comment about comment -> docstring here.

Either way,

Reviewed-by: Cleber Rosa <crosa@redhat.com>

--pY3vCvL1qV+PayAL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl8NJO8ACgkQZX6NM6Xy
CfPUPxAAtsPyCQD1q8QrePFWiB5+sbKOY4cEc3Fa6RXApnDDwXmbdBRF+f4+quub
jXQDTYoTuEfmYGQwRy0OrNwfYSbdUOBLwMGOp4W6ZnhzUIqFjUK5l6J8rzHNZQ8Y
WthT5jmq5WGN3VyFNbrDiMR+OkIpZYBH06D++i/Q9/40LQ4NHdlDT1fxDix0O0pR
/wb/w8kQozK1BId01YxRH0WBapvegVQR41caN9wNb3H4jYNeaT0OlY6c7cu2AF+I
6elmZj8E1gCJO/3iEkXpvVjXwdnegDgiwP7ba8O5zphVVYd8tOPiNWab10epysxi
EIowe27y1Dm6faHN/MSzabEayk0GuHGDXMqo1Ro51br0yaaznh88pLGy0OgSICie
75ftPdyRO7GUnONodahv0pEiug8zeFfA7sR3rnAR75g9QkAg58qDA44S1Ctgsn0y
jtQGKoM2flUJC7A6LhZbWtAhbIbIJQG0m+ipHtRO1dnHyDq+Y2N/jSKKOV+/C6qJ
DXrVadFuQMwO4KN7yfs1S8WATC6tMraMVRefVmP8pMAtTdAof8Gp2VXhHUGSXjqb
a9Giy5IMmh4sYaT+qs9qFmtN8xexKdC0nN4dyWpXqQRd0yX4XAcIR/5ng3e4bZQk
LPPy57IA3ZiAvMsgvcivbvS6vuGMvZqmtdOu45AolAWCLtfQdTg=
=FZzv
-----END PGP SIGNATURE-----

--pY3vCvL1qV+PayAL--


