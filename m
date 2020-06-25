Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804DDC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 02:10:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C98B207E8
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 02:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="nLA/hETq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C98B207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joHLK-0005C5-Jg
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 22:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1joHKX-0004NT-Ta
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 22:09:33 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:59797)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1joHKU-0004Ct-9u
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 22:09:33 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49sk3N3dk0z9sSJ; Thu, 25 Jun 2020 12:09:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1593050960;
 bh=UJd5aYrp27cQgULaaWdpg07eSQ1UROlxe8lLr+kxyi0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nLA/hETqv1BhNyhTP5seYRyipy5TC7S7S9BXvLZn/3rVf50eNWJS0sFWoggdmbqXw
 7N8PnQ0whxVQO9Ay8kiPgntwO+hpJ8DrUrWRW1S99SXnnPd04zeFAZQKa5oGUToi6K
 EZrK2Nax7hn5JgRIAstzkby62PZkcGchdU2kPn8Y=
Date: Thu, 25 Jun 2020 11:40:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: P J P <ppandit@redhat.com>
Subject: Re: [PATCH v2 4/9] prep: add ppc-parity write method
Message-ID: <20200625014041.GB69292@umbus.fritz.box>
References: <20200624185523.762240-1-ppandit@redhat.com>
 <20200624185523.762240-5-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NDin8bjvE/0mNLFQ"
Content-Disposition: inline
In-Reply-To: <20200624185523.762240-5-ppandit@redhat.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Prasad J Pandit <pjp@fedoraproject.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Li Qiang <liq3ea@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Lei Sun <slei.casper@gmail.com>, Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2020 at 12:25:18AM +0530, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>=20
> Add ppc-parity mmio write method to avoid NULL pointer dereference
> issue.
>=20
> Reported-by: Lei Sun <slei.casper@gmail.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/prep_systemio.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> Update v2: use LOG_GUEST_ERROR
>   -> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg04975.html
>=20
> diff --git a/hw/ppc/prep_systemio.c b/hw/ppc/prep_systemio.c
> index bbc51b6e9a..03a2f8af6e 100644
> --- a/hw/ppc/prep_systemio.c
> +++ b/hw/ppc/prep_systemio.c
> @@ -23,6 +23,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/log.h"
>  #include "hw/irq.h"
>  #include "hw/isa/isa.h"
>  #include "hw/qdev-properties.h"
> @@ -235,8 +236,15 @@ static uint64_t ppc_parity_error_readl(void *opaque,=
 hwaddr addr,
>      return val;
>  }
> =20
> +static void ppc_parity_error_writel(void *opaque, hwaddr addr,
> +                                    uint64_t data, unsigned size)
> +{
> +    qemu_log_mask(LOG_GUEST_ERROR, "%s not implemented\n", __func__);
> +}
> +
>  static const MemoryRegionOps ppc_parity_error_ops =3D {
>      .read =3D ppc_parity_error_readl,
> +    .write =3D ppc_parity_error_writel,
>      .valid =3D {
>          .min_access_size =3D 4,
>          .max_access_size =3D 4,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NDin8bjvE/0mNLFQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl70AJYACgkQbDjKyiDZ
s5ID1RAAklZ+LiQfAF0JUvX8SwQj2z5JmfO5pCfcVU6MMCz0FtfiklGcnYQpWjTN
ppsR6W0MsFToHteeGwrkksi5RGy4tg3YLpO6kgLi9xlo8ISmAwVhKXzrMlsr8OHV
auRWsDwREdVuKSJkCUAekZ8t9R0xtAxswfN3H+NkOOgm52nor9dGmKtu8KQYFqMp
/+QGlEQDL2Xr8pVIQFMrBXzcIqO7pw9Nlyt5BqtIaJTkp7yePu39+PAglX35W+1m
NLNw8keWF8R627ksPEkogfnT9pd08AGATJQsv3V6UN6K1sDnS3jwlMJfRrZhDHkW
xv9uhlvXape0F6ID6BxEz5F6Y0cPdEpjitZiob+tM17rKWpuq5rSHtOtYOAoDJop
oXJFikThQmxMR+pwZ4IMpbJvJnPxBVqezba9HGRQmk70DecFtkzO5Qz1FSqm2Pi1
/4oG9XijI/jU7+Wr4u6QdB4a52xEGb66dHcAV0eeFTWrgwVy8dNpsBqQzKaYTahB
gBE+X1+FTW4AQsWngMX/ITERO2XZd8xLsBTJnR/eTq63dBg0MlTIKbzKugseQohG
JNseGP+gFj645KuFtAQhwXWgT6gWHzYQYObZ/P2WFC9uxIxIOZzCa4lsrEEV05XJ
K/euwBYZ4+ezw2DJ6T3z+W4Edjy3rnolXBv9P8ghgsp4/6aqHtA=
=T6hD
-----END PGP SIGNATURE-----

--NDin8bjvE/0mNLFQ--

