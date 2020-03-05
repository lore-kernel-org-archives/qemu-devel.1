Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9802DC3F2CE
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 01:44:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6312020828
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 01:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="RuXp9In0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6312020828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9fYz-0001uW-EQ
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 20:44:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45863)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j9fXz-0000ND-Fl
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 20:43:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j9fXy-0006nM-6v
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 20:43:35 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:58009)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j9fXx-0006jJ-DO; Wed, 04 Mar 2020 20:43:34 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48XtnF2n9yz9sRR; Thu,  5 Mar 2020 12:43:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1583372609;
 bh=KfFScldfDJRFXoF+zStRnA+4pS6Brq4igwumwcCUZ0Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RuXp9In0Wg7c6rjGLALM/R215BodlOwA7BO8hA7+0BldeuwwBJUp1aIcMJ4hyNsYl
 vU5EpPSJuGBJv41KjFz//dZDekSe8YmZvBIqvFTfjXNzQOER2ict1Gh1/b7rRBkroW
 JA9JkOE6WNcidq8kPy7WEXa/+jjRMBHYFrfgh3Pk=
Date: Thu, 5 Mar 2020 11:39:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 1/5] hw/scsi/viosrp: Add missing 'hw/scsi/srp.h' include
Message-ID: <20200305003953.GG593957@umbus.fritz.box>
References: <20200304153311.22959-1-philmd@redhat.com>
 <20200304153311.22959-2-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8JPrznbw0YAQ/KXy"
Content-Disposition: inline
In-Reply-To: <20200304153311.22959-2-philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: Fam Zheng <fam@euphon.net>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--8JPrznbw0YAQ/KXy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 04, 2020 at 04:33:07PM +0100, Philippe Mathieu-Daud=E9 wrote:
> This header use the srp_* structures declared in "hw/scsi/srp.h".
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Applied to ppc-for-5.0.

> ---
>  hw/scsi/viosrp.h | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/hw/scsi/viosrp.h b/hw/scsi/viosrp.h
> index d8e365db1e..25676c2383 100644
> --- a/hw/scsi/viosrp.h
> +++ b/hw/scsi/viosrp.h
> @@ -34,6 +34,8 @@
>  #ifndef PPC_VIOSRP_H
>  #define PPC_VIOSRP_H
> =20
> +#include "hw/scsi/srp.h"
> +
>  #define SRP_VERSION "16.a"
>  #define SRP_MAX_IU_LEN    256
>  #define SRP_MAX_LOC_LEN 32

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8JPrznbw0YAQ/KXy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5gSlcACgkQbDjKyiDZ
s5K3GxAAne9165hJvwlB60B256HGkEL3F1CP+2Ij2MveX7p9SKaGpu0XVnIdevQy
CgbH17BK2UL5+Rt1hEMAMYf8Hc4gD7gxMYwrnWJM7VpX28HGVwYTTSWOSbJVzgg1
EWi9Y3EDmMDOg/pmdecqdeOrQt2OrZEnX95zBctIY7O90wtzO+MeYWcpzRkhlWAO
Oyv8d3l/x+q4Bruh3yrH2bGgjKsRErhyBzm8H75EQqUzQy0OhsTS3nIaH8rMnSwH
B5C9+BnZbu4hg7PHoRKX0As7TACekVq7c6ftPhbrX8bTLH0Odmw7jlVtaUq3xmI6
npDbUIfphIpAD9WxX+wzs5TXjgG+6oguaezfZ4jBIXif//Ezx+EGbNmeKVJVUyxR
COZX+gWmy4S7DrtS7SoKqs9QjojYD5yKEYMJw2pQ+spPKNE22dXdeFcjD81rvNC3
RGTPAyFJ7DAyTh5Ttgfp85eAUepzOYuDkUoeyp0eQnzot5hhPoJ11NgPZ7CpPvhh
n5FZ/Ng1fnmx6nrUTIeJiCtoTkpha60eHlgjMSk1Z1/P9mt4qkCKZZoDoQFK1nBc
ZM+LRzT/a+RPv+QjOPoIVZmAGDQDNbhsp4Zr2mL52aJ0JSkO3tF4VmCum0wSKZhm
E47+y6WAhEWZaJRhm8eK09bPO0T469tHfCb4M2iK4mGoLUxBL7E=
=0ZLL
-----END PGP SIGNATURE-----

--8JPrznbw0YAQ/KXy--

