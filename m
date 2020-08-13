Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49237C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 10:46:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1868E204FD
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 10:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="jqd8J3w2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1868E204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Akd-0001Nu-AF
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 06:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k6AjW-00082e-2U; Thu, 13 Aug 2020 06:45:18 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:51625 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k6AjS-0008Jo-Er; Thu, 13 Aug 2020 06:45:17 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BS39y3VF9z9sTT; Thu, 13 Aug 2020 20:45:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597315510;
 bh=Iqr7z75P5o17X1hFSYVPasdhb6r5YidNMV4F78WNOLQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jqd8J3w2P7Dd5hI9nTZ/FYzNOu9k1eayZnQgUprodYzQHproe6Ubp2G4bSuHnsT+/
 Kemft0411flsvGRXaxtKTFgvdoAXUhhuRL7oRfXUpYkmqbeqmWyd0GDLcqx88hfRoG
 saqKgIn11gVYw1fNHr220m7DFdtUehKU4gOOJyj4=
Date: Thu, 13 Aug 2020 20:19:45 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 04/14] spapr/xive: Rework error handling of
 kvmppc_xive_mmap()
Message-ID: <20200813101945.GG181791@yekko.fritz.box>
References: <159707843034.1489912.1082061742626355958.stgit@bahia.lan>
 <159707845972.1489912.719896767746375765.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="m0vRWufqUC70IDnR"
Content-Disposition: inline
In-Reply-To: <159707845972.1489912.719896767746375765.stgit@bahia.lan>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 06:45:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--m0vRWufqUC70IDnR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2020 at 06:54:19PM +0200, Greg Kurz wrote:
> Callers currently check failures of kvmppc_xive_mmap() through the
> @errp argument, which isn't a recommanded practice. It is preferred
> to use a return value when possible.
>=20
> Since NULL isn't an invalid address in theory, it seems better to
> return MAP_FAILED and to teach callers to handle it.

Heh... there's a world of C and Unix subtleties buried in that
assertion.  But, given that it's a function named ..._mmap() using
MAP_FAILED isn't a bad option.

Applied to ppc-for-5.2.

>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/intc/spapr_xive_kvm.c |   18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> index d801bf5cd11c..b2a36fd59dae 100644
> --- a/hw/intc/spapr_xive_kvm.c
> +++ b/hw/intc/spapr_xive_kvm.c
> @@ -698,6 +698,7 @@ int kvmppc_xive_post_load(SpaprXive *xive, int versio=
n_id)
>      return 0;
>  }
> =20
> +/* Returns MAP_FAILED on error and sets errno */
>  static void *kvmppc_xive_mmap(SpaprXive *xive, int pgoff, size_t len,
>                                Error **errp)
>  {
> @@ -708,7 +709,6 @@ static void *kvmppc_xive_mmap(SpaprXive *xive, int pg=
off, size_t len,
>                  pgoff << page_shift);
>      if (addr =3D=3D MAP_FAILED) {
>          error_setg_errno(errp, errno, "XIVE: unable to set memory mappin=
g");
> -        return NULL;
>      }
> =20
>      return addr;
> @@ -728,6 +728,7 @@ int kvmppc_xive_connect(SpaprInterruptController *int=
c, uint32_t nr_servers,
>      size_t tima_len =3D 4ull << TM_SHIFT;
>      CPUState *cs;
>      int fd;
> +    void *addr;
> =20
>      /*
>       * The KVM XIVE device already in use. This is the case when
> @@ -763,11 +764,12 @@ int kvmppc_xive_connect(SpaprInterruptController *i=
ntc, uint32_t nr_servers,
>      /*
>       * 1. Source ESB pages - KVM mapping
>       */
> -    xsrc->esb_mmap =3D kvmppc_xive_mmap(xive, KVM_XIVE_ESB_PAGE_OFFSET, =
esb_len,
> -                                      &local_err);
> -    if (local_err) {
> +    addr =3D kvmppc_xive_mmap(xive, KVM_XIVE_ESB_PAGE_OFFSET, esb_len,
> +                            &local_err);
> +    if (addr =3D=3D MAP_FAILED) {
>          goto fail;
>      }
> +    xsrc->esb_mmap =3D addr;
> =20
>      memory_region_init_ram_device_ptr(&xsrc->esb_mmio_kvm, OBJECT(xsrc),
>                                        "xive.esb-kvm", esb_len, xsrc->esb=
_mmap);
> @@ -781,11 +783,13 @@ int kvmppc_xive_connect(SpaprInterruptController *i=
ntc, uint32_t nr_servers,
>      /*
>       * 3. TIMA pages - KVM mapping
>       */
> -    xive->tm_mmap =3D kvmppc_xive_mmap(xive, KVM_XIVE_TIMA_PAGE_OFFSET, =
tima_len,
> -                                     &local_err);
> -    if (local_err) {
> +    addr =3D kvmppc_xive_mmap(xive, KVM_XIVE_TIMA_PAGE_OFFSET, tima_len,
> +                            &local_err);
> +    if (addr =3D=3D MAP_FAILED) {
>          goto fail;
>      }
> +    xive->tm_mmap =3D addr;
> +
>      memory_region_init_ram_device_ptr(&xive->tm_mmio_kvm, OBJECT(xive),
>                                        "xive.tima", tima_len, xive->tm_mm=
ap);
>      memory_region_add_subregion_overlap(&xive->tm_mmio, 0,
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--m0vRWufqUC70IDnR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl81E8EACgkQbDjKyiDZ
s5KdeQ//bktUE1RHUSizwebxm6dmJ2L8t3e/F7xocfhiMx5Y2Zdqi85vDzhWAmdA
KFjTNQhqVpzsWHCylM69gpXYLdgs5PyW//MMKvqGrfJDoE/8Pwnknj5pcaGdB0JZ
p0VNnRkL3SFcBI710SALUNWeV6o4pneZOXywLmAYuUm5/f8rxQpFRQb4JBrhNfqc
VboSVlWNECobK/J1QQFN30AZ4OhwJibpWotgEWmmFp2CsMVidMydiJAS0MagZBr3
tVLjA0/mQvGmWIOmLxX4tN8sKhl+3iPURApizzKBFSHDHM+uOzvlB5ZFSauMPwZu
6DBfZKKdMW4hRJIfqnw9c+iTXPIDByLuEzIdnwzpkBuN498WexmAq+JKfZFAltoF
grr+SgVNCGMeXshDzaD2YlW9a2cENJ3mq34hJcsh8MwIvYoLGvf3i/Jd2Kc7ODbe
JBoMt52lXybHdclJRrWFsDiaJUOe7Udxz6KamNiEYnE1aInAGZzVPQ31KbMT9nOq
3AI2hyAnTBgSDRtFDxZXB6zDIAPFFtxfwNtp6uAFvgxtxgAaMRJMyVR9P86YGwPl
YGxQiEZ8sXioXu8T1zaXvEiILVNNpp+2I4QPPKFQ53lpeKfuMAvLC+RddvseX/I2
5jYA1/h3gMmmSJDIrh4UqvqsD2ejrs7CuI8LynYLM4+53idhovs=
=45zW
-----END PGP SIGNATURE-----

--m0vRWufqUC70IDnR--

