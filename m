Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7D9C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 08:22:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C09D2064B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 08:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="errPK9aK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C09D2064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44766 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdsKz-00055b-GI
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 04:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57715)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hdsGc-0001z2-0V
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 04:17:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hds63-0004Ng-Bi
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 04:07:05 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:46955 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hds61-0004BI-8W; Thu, 20 Jun 2019 04:07:03 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45TvY338lQz9s3l; Thu, 20 Jun 2019 18:06:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1561018007;
 bh=VwaLLJEuYJ8wa40TVT4s9MjpP6xhvTobIWpv8qUFH4g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=errPK9aK91m7xVWOiZb28HbbkkyTijdO6ZOX33h9il9yBbxA/qO9m3LwPw5dTe3xr
 54ow86StdoXW46SCiU9+yURdnoDxh16yHaCz1xpdJXDwvGDTa7FIugqrg4IlXjcpH6
 69pu4oYLh6SSEC7lQ6/q66n9t68Kp2I4LD8wEvn4=
Date: Thu, 20 Jun 2019 18:02:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190620080231.GE2066@umbus.BigPond>
References: <156077918969.433243.1416211899441569578.stgit@bahia.lan>
 <156077920102.433243.6605099291134598170.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="s9fJI615cBHmzTOP"
Content-Disposition: inline
In-Reply-To: <156077920102.433243.6605099291134598170.stgit@bahia.lan>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH 2/6] xics/spapr: Rename xics_kvm_init()
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


--s9fJI615cBHmzTOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2019 at 03:46:41PM +0200, Greg Kurz wrote:
> Switch to using the connect/disconnect terminology like we already do for
> XIVE.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied, thanks.

> ---
>  hw/intc/xics_kvm.c          |    2 +-
>  hw/ppc/spapr_irq.c          |    2 +-
>  include/hw/ppc/xics_spapr.h |    2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index c7f8f5edd257..534515143ea8 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -331,7 +331,7 @@ void ics_kvm_set_irq(ICSState *ics, int srcno, int va=
l)
>      }
>  }
> =20
> -int xics_kvm_init(SpaprMachineState *spapr, Error **errp)
> +int xics_kvm_connect(SpaprMachineState *spapr, Error **errp)
>  {
>      int rc;
>      CPUState *cs;
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 84b9b32fe40f..ff3df0bbd8cf 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -237,7 +237,7 @@ static const char *spapr_irq_get_nodename_xics(SpaprM=
achineState *spapr)
>  static void spapr_irq_init_kvm_xics(SpaprMachineState *spapr, Error **er=
rp)
>  {
>      if (kvm_enabled()) {
> -        xics_kvm_init(spapr, errp);
> +        xics_kvm_connect(spapr, errp);
>      }
>  }
> =20
> diff --git a/include/hw/ppc/xics_spapr.h b/include/hw/ppc/xics_spapr.h
> index 330448126223..5dabc9a1388f 100644
> --- a/include/hw/ppc/xics_spapr.h
> +++ b/include/hw/ppc/xics_spapr.h
> @@ -33,7 +33,7 @@
> =20
>  void spapr_dt_xics(SpaprMachineState *spapr, uint32_t nr_servers, void *=
fdt,
>                     uint32_t phandle);
> -int xics_kvm_init(SpaprMachineState *spapr, Error **errp);
> +int xics_kvm_connect(SpaprMachineState *spapr, Error **errp);
>  void xics_kvm_disconnect(SpaprMachineState *spapr, Error **errp);
>  bool xics_kvm_has_broken_disconnect(SpaprMachineState *spapr);
>  void xics_spapr_init(SpaprMachineState *spapr);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--s9fJI615cBHmzTOP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0LPZcACgkQbDjKyiDZ
s5K3OBAAotxqmL9VSCTij4i1Lt8uf4GwDNgg2bnu81nGKR62B804eMY2VQoesvIb
/qWbbmnnuXhN4C77+rZLzMu0XG4cbhGN2v9UysLqqtiw7Korus67DiY3Ek0gNrzO
ReGdao0KGRyqEPrvraVFXbM4uuy7ghiToSbd19+5W2D6OnWLKBG+fgYEyXnGFW1D
ZPuQHHOqa99iMsCEE89JAMV+OgEEG43t5P9V2VS9kSx0hpUAg4QDUVga7RkN8LJj
oYSEmXGJbsznXmzncWl1OAfP0YHznIWPqkAOBiidTfuM+DsXwsUsrYeeoLDo7G8b
Esgm6x11US5f2vdWTnWrK4SIZ15taoTMqMqfLH4/KqcsyjQwYeoMOpihdV8xE+Fv
52Fb0tEB2N5EqSqqm0TsQhid8xW7ort8Nla5WZuHqEncwzBcO8FIqMUHuFVDqsPG
jHJF57u7Xq+Y5o8rxBIJb2/4MAvNAYz6cufS2kKbu1HI7Qg3uMDfTbRAGW9KnWAK
aoj0fH6+pLyXZpdojQgF3R80XmkkAYPMwhpQ6pqOrDIRDtacCcAo7OUdDbAn4B8+
MS4TEyD/bgVe3SCkFYib1rujnNdKyIi9Lq9s5xtiKGT6YlGusUACt8iukCWSIR+s
LKcfavDtNrCgx2soB9Bj0POFgk435xbPcBZlFCmCuyK+wt4KMDo=
=sPQp
-----END PGP SIGNATURE-----

--s9fJI615cBHmzTOP--

