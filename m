Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7023DC4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 08:55:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3573320752
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 08:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="f7SW505o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3573320752
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFDRQ-0004cU-Cp
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 04:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48780)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jFDQA-0003NB-Tc
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 04:54:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jFDQ9-0006C0-O4
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 04:54:26 -0400
Received: from ozlabs.org ([203.11.71.1]:51771)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1jFDQ9-00066N-Bv
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 04:54:25 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48kHdV1Kzyz9sSN; Fri, 20 Mar 2020 19:54:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584694462;
 bh=3gXFyaEK+E4fMA46XY26f65y9r7iou6a5dHtiEqRwUg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=f7SW505ouhVOQgswOfnJmGn75k6dEdf86Cl3SpI58jIYbiDumE1eCoCxaZiSn7kco
 ikb9l2fnGyneu58BavyAnIWvMe//ZVBRNjmpQF/Pnr2SW9LmcEI7Eu4pjQg9Z9NjA1
 hf+bBMR1JwktdDQs3Bq7Ac3JKrF9UXy0lKsHiAQQ=
Date: Fri, 20 Mar 2020 19:51:20 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Leonardo Bras <leonardo@linux.ibm.com>
Subject: Re: [PATCH v2 1/1] device_tree: Add info message when dumping dtb to
 file
Message-ID: <20200320085120.GE781112@umbus.fritz.box>
References: <20200319040326.391090-1-leonardo@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="SWTRyWv/ijrBap1m"
Content-Disposition: inline
In-Reply-To: <20200319040326.391090-1-leonardo@linux.ibm.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--SWTRyWv/ijrBap1m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2020 at 01:03:26AM -0300, Leonardo Bras wrote:
> When dumping dtb to a file, qemu exits silently before starting the VM.
>=20
> Add info message so user can easily track why the proccess exits.
> Add error message if dtb dump failed.
>=20
> Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  device_tree.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/device_tree.c b/device_tree.c
> index f8b46b3c73..bba6cc2164 100644
> --- a/device_tree.c
> +++ b/device_tree.c
> @@ -530,7 +530,12 @@ void qemu_fdt_dumpdtb(void *fdt, int size)
> =20
>      if (dumpdtb) {
>          /* Dump the dtb to a file and quit */
> -        exit(g_file_set_contents(dumpdtb, fdt, size, NULL) ? 0 : 1);
> +        if (g_file_set_contents(dumpdtb, fdt, size, NULL)) {
> +            info_report("dtb dumped to %s. Exiting.", dumpdtb);
> +            exit(0);
> +        }
> +        error_report("%s: Failed dumping dtb to %s", __func__, dumpdtb);
> +        exit(1);
>      }
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--SWTRyWv/ijrBap1m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl50hAcACgkQbDjKyiDZ
s5LdZA//QNquCO+9ZtCjl1kEL3xVpo2RrY+4RA7rJ51yCt3+CQxGZaL9oXhfd8T8
CYrsJuDMy/pBeE+tgXzkHvDWMCDsKM/u9UxYKSgmRwBRJSZ6DK1fUH0EC1Oo6Rzr
UIvlhR6swXQ+1LrKo2UEIMSlXiPxvvADQi+bc+SPKwfjR7QFq8EM2LGTm7VIeEa1
TpJ+s9vBkOPnEXVF4LURcWzXBx/o1F0gHU6u9vqzG5T6PrKYlMgE0Q+vsjX877vE
Dr/RbMqaLaiazyMyNx0CRW8KBvGkcXmwjYYqQaiQHZ2zPaFDvhvEyka9916f3csT
XYf7HmomhT6+MiHLSIUmbCRd5JW9JFU6M7K/XLz7vCnhYzg/m1jNCdu3JNPg6/qn
gdJQPn3m7UND/sm1eDeDiuD3tGrsOoSSXWUINvFgbYAeakf5wwrNbK8TT9F4cx3t
yC6k8bnc757LMJk+ti8uZG9ucuXAbCmNqpO9xUD7vRVvdXMboURA6zGStGpSFCQb
bBw20MxpddcvhWiEQOJfjbSUkbAJnzhVoYneltWt94gDOU07v+xaxopqmtl0ioFH
0U6FXSDPPMLFxlka0n91zUHSazDxN47vtyokIPLgZdtTA6tevsSdUo5vZ0APiwQG
sQwtNewiC54ONqe116D9XNUTyCA2j4RYaci+5J8OF7MwF1ez7OY=
=k5aN
-----END PGP SIGNATURE-----

--SWTRyWv/ijrBap1m--

