Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1C7C33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 05:13:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 615CA2467B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 05:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="BDHPWFUG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 615CA2467B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuUno-0007at-B4
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 00:13:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36675)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iuUn1-0006uV-E5
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 00:12:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iuUn0-00083l-0d
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 00:12:23 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:53859 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iuUmy-00081V-VC; Thu, 23 Jan 2020 00:12:21 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4839PX1mJJz9sSL; Thu, 23 Jan 2020 16:12:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1579756336;
 bh=ebRqJnIRoOoWB5UuDmfgJAZGA1WzqHhkVT3dHXfYHaw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BDHPWFUGXGjCPiG+NT92T+lvJ3z5ZDosGlwo4673nCrg3BbkKnf3QJ2hPKBm0IwIv
 iNKt+Zj/raVUOnRlQokJNnY7i8nFojsJa91bZatuQXvMZ5drTP5s10KvIkdrtGS84R
 TYaIoKdW/kVr5EbgyX1Q1F3Xi8iNojCX5MYs+ScA=
Date: Thu, 23 Jan 2020 15:59:33 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] spapr: Don't allow multiple active vCPUs at CAS
Message-ID: <20200123045933.GM2347@umbus.fritz.box>
References: <157969867170.571404.12117797348882189656.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8c07nsHwQobhlezh"
Content-Disposition: inline
In-Reply-To: <157969867170.571404.12117797348882189656.stgit@bahia.lan>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--8c07nsHwQobhlezh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2020 at 02:11:12PM +0100, Greg Kurz wrote:
> According to the description of "ibm,client-architecture-support" that
> can found in LoPAPR "B.6.2.3 Root Node Methods":
>=20
> If multiple partition processors or threads are active at the time of
> the ibm,client-architecture-support method call, or an error is detected
> in the format of the ibm,architecture.vec structure, the err? boolean
> shall be TRUE; else FALSE.
>=20
> We certainly don't want to temper with the platform or with the PCR of
> the other vCPUs if they happen to be active. Ensure we have only one
> active vCPU and fail CAS otherwise. This is just for conformance and
> robustness, it doesn't fix any known bugs.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-5.0, thanks.

> ---
>  hw/ppc/spapr_hcall.c |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index ffb14641f9d3..b8bb66b5c0d4 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1676,6 +1676,18 @@ static target_ulong h_client_architecture_support(=
PowerPCCPU *cpu,
>      Error *local_err =3D NULL;
>      bool raw_mode_supported =3D false;
>      bool guest_xive;
> +    CPUState *cs;
> +
> +    /* CAS is supposed to be called early when only the boot vCPU is act=
ive. */
> +    CPU_FOREACH(cs) {
> +        if (cs =3D=3D CPU(cpu)) {
> +            continue;
> +        }
> +        if (!cs->halted) {
> +            warn_report("guest has multiple active vCPUs at CAS, which i=
s not allowed");
> +            return H_MULTI_THREADS_ACTIVE;
> +        }
> +    }
> =20
>      cas_pvr =3D cas_check_pvr(spapr, cpu, &addr, &raw_mode_supported, &l=
ocal_err);
>      if (local_err) {
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8c07nsHwQobhlezh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4pKDMACgkQbDjKyiDZ
s5KnwBAAxMqy59Hk0aoY8MNQQULstXcRNQKkn3tSOmy+Y0m1ApMJ/PrZlPzmr0F8
0apFN/FdKwUZG1015DXOLaW+Jwpw4GgkfqmzQkqAyndDVwsni+U2mg/1IyHAJXan
acccSvh6RBh9D/u5ochgxQQ57jRuQ1IiA2dM1o+6zy4I9baOk7PMP1PUqFyt9jwP
bVZQMIP7v2npMm9XFpZBbV+29k4JRGlI9GxWUOr3RGGdWHqomk+JXphfIWD34l8Q
+9VD/du4IBxtIIbuKB6hxk12w3GFHQxEJC6qahjTGs8sdtH28Rv1C/NS5xw/LsBK
GJ4vvGRUKv4ydRtt6emwHv923VGNk8iXZAciRs3ixZ+MFkjEBw72X7uWLxU9eDy1
gvndkd11Oh4US8v1gZuNTdcLEC31F+yhtnpYR3jgXLX8JbpUPdVo5kNzYq4T0M45
yxQJHlEpfsoz8uYJzJhsmXjXCjIp0+KItmgczyUBSpMrVkUP3C4fCJyFKHM0olu/
sNRB55qTZ6it6Xp9Y6zXCWhMw6HEZVQYeEV4flc8mpuln6zxh5Wd/yHP8U9mljwO
hPV99Ip74pAe6hnchrWNRZMY2FGeR9uCVJSYmR2mGYXyGjqVq8HbY5efkiS/6EN0
KI09VlPthx6tfwuE0BhTIxatNejP9HUpwUb65XlrSZr4i/LNRbo=
=TE+g
-----END PGP SIGNATURE-----

--8c07nsHwQobhlezh--

