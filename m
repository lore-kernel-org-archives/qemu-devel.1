Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C65C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 00:41:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BEFF20737
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 00:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Pq7zGUe/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BEFF20737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHGa6-0000f6-4i
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 20:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43665)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jHGXK-0003lE-UR
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 20:38:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jHGXJ-0002He-KM
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 20:38:18 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:33589)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jHGXJ-0002A5-92; Wed, 25 Mar 2020 20:38:17 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48nmL80JXJz9sSM; Thu, 26 Mar 2020 11:38:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1585183088;
 bh=XyVjfju493DIm4gXM7RKH2aS3xOA1NQ4eh+jrmOLPVk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Pq7zGUe/MvFTEY+bPfMrj/dmJec63o/tGhxDfbA110NQo5GolQLweFEOj4hB+0GDS
 afS0o6sZzOGN77KvuZOslaOxt2UV+XX1DzhMAcqRJmNLlREVnlAobCzN3xbIOC5EAk
 ezsK58EGDCAV6wf1WGLJESW7yzFARXk9heTTRl3s=
Date: Thu, 26 Mar 2020 11:02:45 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 1/4] spapr: Don't check capabilities removed between CAS
 calls
Message-ID: <20200326000245.GH36889@umbus.fritz.box>
References: <158514992409.478799.6718223069768660390.stgit@bahia.lan>
 <158514993021.478799.10928618293640651819.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8bBEDOJVaa9YlTAt"
Content-Disposition: inline
In-Reply-To: <158514993021.478799.10928618293640651819.stgit@bahia.lan>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--8bBEDOJVaa9YlTAt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2020 at 04:25:30PM +0100, Greg Kurz wrote:
> We currently check if some capability in OV5 was removed by the guest
> since the previous CAS, and we trigger a CAS reboot in that case. This
> was required because it could call for a device-tree property or node
> removal, that we didn't support until recently (see commit 6787d27b04a7
> "spapr: add option vector handling in CAS-generated resets" for details).
>=20
> Now that we render a full FDT at CAS and that SLOF is able to handle
> node removal, we don't need to do a CAS reset in this case anymore.
> Also, this check can only return true if the guest has already called
> CAS since the last full system reset (otherwise spapr->ov5_cas is
> empty). Linux doesn't do that so this can be considered as dead code
> for the vast majority of existing setups.
>=20
> Drop the check. Since the only use of the ov5_cas_old variable is
> precisely the check itself, drop the variable as well.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-5.1.

> ---
>  hw/ppc/spapr_hcall.c |   14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 40c86e91eb89..1f123a68e46c 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1676,7 +1676,7 @@ static target_ulong h_client_architecture_support(P=
owerPCCPU *cpu,
>      target_ulong fdt_bufsize =3D args[2];
>      target_ulong ov_table;
>      uint32_t cas_pvr;
> -    SpaprOptionVector *ov1_guest, *ov5_guest, *ov5_cas_old;
> +    SpaprOptionVector *ov1_guest, *ov5_guest;
>      bool guest_radix;
>      Error *local_err =3D NULL;
>      bool raw_mode_supported =3D false;
> @@ -1781,22 +1781,10 @@ static target_ulong h_client_architecture_support=
(PowerPCCPU *cpu,
>       * by LoPAPR 1.1, 14.5.4.8, which QEMU doesn't implement, we don't n=
eed
>       * to worry about this for now.
>       */
> -    ov5_cas_old =3D spapr_ovec_clone(spapr->ov5_cas);
> -
> -    /* also clear the radix/hash bit from the current ov5_cas bits to
> -     * be in sync with the newly ov5 bits. Else the radix bit will be
> -     * seen as being removed and this will generate a reset loop
> -     */
> -    spapr_ovec_clear(ov5_cas_old, OV5_MMU_RADIX_300);
> =20
>      /* full range of negotiated ov5 capabilities */
>      spapr_ovec_intersect(spapr->ov5_cas, spapr->ov5, ov5_guest);
>      spapr_ovec_cleanup(ov5_guest);
> -    /* capabilities that have been added since CAS-generated guest reset.
> -     * if capabilities have since been removed, generate another reset
> -     */
> -    spapr->cas_reboot =3D !spapr_ovec_subset(ov5_cas_old, spapr->ov5_cas=
);
> -    spapr_ovec_cleanup(ov5_cas_old);
>      /* Now that processing is finished, set the radix/hash bit for the
>       * guest if it requested a valid mode; otherwise terminate the boot.=
 */
>      if (guest_radix) {
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8bBEDOJVaa9YlTAt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl578SUACgkQbDjKyiDZ
s5L6FQ/+MDBUXp+KiWQ4IGOc7prc7Ua2yjld8P4zUtB6g1oZhglST7spsPmKqQfl
M5AZaci8kF6hsUUH4RsW6ofFPP+XRQh5phExEWbV9URM5d+c+DMTSBu0sKZOAbRb
qYRl5L5BtRmLRIPAsvaOnIYxa4OoZ+P3lE7Sx9u3y+xLTI+ZDrYYRTnumQahVekC
08+bjVq51jOea0xkfdPQNm9tZYnOcQhAdaJj1GjCiRwE2j99Z3NDb1WIcVXFdKbh
geQWVIBhYJrc25SSxyzdlb51ezoMC3zwOVwEU6EWH2U2H+7WhYeHYahenZAl4SNh
TDAkxyg6QeonWtFfoUMrca+aDqOMZ4HgJJNEUT5h0LsXGfZ/b65UI8sTG48R4Z0M
5ixrwVudOz+aHkXooq+UEscZucfsNOmJVERqzPAoA4uwyaAOnchud9zxJl7zYls7
I0WYk8JbfI6vJm4pD3DQsRRxoN5DcbvApliA3KdliqEueRX+AIBT2GHed8WYO9T2
8MepGZn3eOvrKYpbm071EQScR3ThaobH/5zMx4onC2LNBTj/MrXGS7tRidIZsbpI
acdHO2qirxKATFtl1jQvP/0Yg6ErbuFCIQUbJatrvDeLl2ttUPNgBEnxJTsjFUfe
zzA51ATNFxA/kWMLCBypdXdmmzvbncBkuQm7ZWqQh8geO4WFc0U=
=//DY
-----END PGP SIGNATURE-----

--8bBEDOJVaa9YlTAt--

