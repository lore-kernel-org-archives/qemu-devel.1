Return-Path: <SRS0=NWXH=WU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E15FC3A59E
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 10:04:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6959220870
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 10:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="BJs+FInV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6959220870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1SuZ-00038c-F2
	for qemu-devel@archiver.kernel.org; Sat, 24 Aug 2019 06:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i1SqX-0000wz-Lj
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 06:00:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i1SqW-0000Pb-BQ
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 06:00:33 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:57823)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i1SqV-0000FG-Si; Sat, 24 Aug 2019 06:00:32 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46Fv062Vwmz9sN1; Sat, 24 Aug 2019 20:00:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566640822;
 bh=C42fnOAYgag6+7hG6W+ra2eNskn1C/9uAvWMGNDyPQw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BJs+FInV8iOuzlVwjBwgudZAojJ8Km0Sylv8uUEm3Q8ONR/NjZkKeB1i6VK7MIs0+
 3nOQcPAvYqhy7vL3L+9vJiM+eQwZUFlz2/Ve6gmh37ZsEtZ2Lx47u58XZGFHCjPB1k
 5CQcvoX5I+OYWheakZa2iwF2lP5jD4Pfjh9Bnoi8=
Date: Sat, 24 Aug 2019 19:32:55 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: sathnaga@linux.vnet.ibm.com
Message-ID: <20190824093255.GI3027@umbus.fritz.box>
References: <20190819082820.14817-1-sathnaga@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3eH4Qcq5fItR5cpy"
Content-Disposition: inline
In-Reply-To: <20190819082820.14817-1-sathnaga@linux.vnet.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH V2 1/2] tests.acceptance.avocado_qemu: Add
 support for powerpc
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--3eH4Qcq5fItR5cpy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2019 at 01:58:20PM +0530, sathnaga@linux.vnet.ibm.com wrote:
> From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
>=20
> Current acceptance test will not run properly in powerpc
> environment due qemu target is different from arch, this
> usually matches, except with bi-endian architectures like ppc64.
> uname would return `ppc64` or `ppc64le` based `big` or `little`
> endian but qemu `target` is always `ppc64`. Let's handle it.
>=20
> Reviewed-by: C=E9dric Le Goater <clg@kaod.org>
> Signed-off-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

I sent a similar patch a little while back, but it seems it got lost.


> ---
>  tests/acceptance/avocado_qemu/__init__.py | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance=
/avocado_qemu/__init__.py
> index aee5d820ed..bd41e0443c 100644
> --- a/tests/acceptance/avocado_qemu/__init__.py
> +++ b/tests/acceptance/avocado_qemu/__init__.py
> @@ -39,6 +39,9 @@ def pick_default_qemu_bin(arch=3DNone):
>      """
>      if arch is None:
>          arch =3D os.uname()[4]
> +    # qemu binary path does not match arch for powerpc, handle it
> +    if 'ppc64le' in arch:
> +        arch =3D 'ppc64'
>      qemu_bin_relative_path =3D os.path.join("%s-softmmu" % arch,
>                                            "qemu-system-%s" % arch)
>      if is_readable_executable_file(qemu_bin_relative_path):

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3eH4Qcq5fItR5cpy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1hBEcACgkQbDjKyiDZ
s5I03A/+OS9ebOnz0+cQwmnBm1y+uvf3xbR//fdbiYVjw/YSOnDV5n9L5mqdkGaI
6HjN2tGCxdFbZfsWTxoLG+PuaAaeVLh4nhvhM/urwajK1kLUREnkDOaq+9yjWnE2
noW4KW6CUg/DC/1J+vI/PT6Pp3HBgkbOHo9sFS1cCqYrkzHNJFYtai5V15X+RkSO
GD4JdC9YBhCdkzTKG0mGwV76ZAMllpRlsSoMlmDiAT2BWF3/qeK0JsXZLJLQ0VRT
jYec7OS4WpCWbWEBxfaVaJXiBoD4+Z59nlAi/T5oggXIqpy7TERsOX2WbfxLw5L6
Wti9rCCEhQ+A+3iaWBKcRpeszeT8S4TB9zjGP7iaoogW8Ksa9vcJavbr8+fjyxbA
+qUxqywCb6ujl1NQ1EpozTwZ1YV8EZoaCPVVKTvHUB3pSyv1qe7TJNZK1inrxQFo
hT29bPwFAZvIXpMFFVco7XXlN97S/gpvL1MrljrbyQ6vbAF3yNunHrfZR6llrbeT
6iyHfnTSQyCOHJC71cXkWHcadqfHJ9nAaXxk57J8jZAnhIzy/KNs4i8gK/KMkWBH
2Gh1jlCOgCXMh9JagFblWcHj9JVaN9j+M4heGhtBNayj+fU4VD1lEKn9amloJrhZ
+V/i04LNUfmZYyjQGay7NBD+M22JXyHROd/CiAnuIA0yFr7vYrs=
=f6Ww
-----END PGP SIGNATURE-----

--3eH4Qcq5fItR5cpy--

