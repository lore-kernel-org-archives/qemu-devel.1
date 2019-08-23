Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C90C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 06:06:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4A8A22CEC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 06:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="VHm17G56"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4A8A22CEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i12ie-0004X5-0Q
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 02:06:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51125)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i12eQ-0000kP-3o
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 02:02:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i12eO-0004cS-Pl
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 02:02:18 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:51565 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i12eN-0004T2-Hc; Fri, 23 Aug 2019 02:02:16 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46F9lh3YP4z9sNC; Fri, 23 Aug 2019 16:02:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566540128;
 bh=C6ycLQNs0h3+jok8L6wQCBaQO4dmZLW+j/dFtNXjedc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VHm17G56s8WVORuslQtzy0wANanVydP5i32WT4k37uhNpmgwJ5xvxtROuCK2ztzx2
 GL1tcFleyCsbclsbt9I7f9Nn1KAg2NfsQ6hsVbRHD3wH7oX4Ez33mQj45L8POk0g/v
 32dSzrTF+6NrO/FrnWQIlBabK7hwJFHq4WtOfXDY=
Date: Fri, 23 Aug 2019 15:31:53 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <20190823053153.GB3027@umbus.fritz.box>
References: <20190822195918.3307-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
Content-Disposition: inline
In-Reply-To: <20190822195918.3307-1-danielhb413@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v1 1/1] spapr_pci: remove all child
 functions in function zero unplug
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


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2019 at 04:59:18PM -0300, Daniel Henrique Barboza wrote:
> There is nothing wrong with how sPAPR handles multifunction PCI
> hot unplugs. The problem is that x86 does it simpler. Instead of
> removing each non-zero function and then removing function zero,
> x86 can remove any function of the slot to trigger the hot unplug.
>=20
> Libvirt will be directly impacted by this difference, in the
> (hopefully soon) PCI Multifunction hot plug/unplug support. For
> hot plugs, both x86 and sPAPR will operate the same way: a XML
> with all desired functions to be added, then consecutive hotplugs
> of all non-zero functions first, zero last. For hot unplugs, at
> least in the current state, a XML with the devices to be removed
> must also be provided because of how sPAPR operates - x86 does
> not need it - since any function unplug will unplug the whole
> PCIe slot. This difference puts extra strain in the management
> layer, which needs to either handle both archs differently in
> the unplug scenario or choose treat x86 like sPAPR, forcing x86
> users to cope with sPAPR internals.
>=20
> This patch changes spapr_pci_unplug_request to handle the
> unplug of function zero differently. When removing function zero,
> instead of error-ing out if there are any remaining function
> DRCs which needs detaching, detach those. This has no effect in
> any existing scripts that are detaching the non-zero functions
> before function zero, and can be used by management as a shortcut
> to remove the whole PCI multifunction device without specifying
> each child function.

Makes sense to me, applied to ppc-for-4.2.

>=20
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> ---
>  hw/ppc/spapr_pci.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index deb0b0c80c..9f176f463e 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1700,11 +1700,13 @@ static void spapr_pci_unplug_request(HotplugHandl=
er *plug_handler,
>                  state =3D func_drck->dr_entity_sense(func_drc);
>                  if (state =3D=3D SPAPR_DR_ENTITY_SENSE_PRESENT
>                      && !spapr_drc_unplug_requested(func_drc)) {
> -                    error_setg(errp,
> -                               "PCI: slot %d, function %d still present.=
 "
> -                               "Must unplug all non-0 functions first.",
> -                               slotnr, i);
> -                    return;
> +                    /*
> +                     * Attempting to remove function 0 of a multifunction
> +                     * device will will cascade into removing all child
> +                     * functions, even if their unplug weren't requested
> +                     * beforehand.
> +                     */
> +                    spapr_drc_detach(func_drc);
>                  }
>              }
>          }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1fekkACgkQbDjKyiDZ
s5JjJg/+N39oi8cilNtLi45NDL7nwIedmDKUkTxP4Xve7slhKLYbbJyWvjheeOUa
l/xh05wOb+qGHYJrRIRXGNKFQL8ZJOntmnsRZZf0LqShd95HnfrUpItl7LFYociE
XbJ+2gOSJ6Bm9OKSJwGvsU/JzJpkk9P4yfBhv7iUQGgkoahojO7KEdfqeRBAepAp
+J2R9DwcdUppAfNGmGOq69UkhRbPD7F8P5hf7m2HPB2PFtc9iGwhM91vE4lGkiux
kEU5MD/bE4ZkstPfGFeXpKfaN2UoBthRNzxa5p3trm7lcbiRkyUi5gLDlrX4wfKO
w4iunnOT92GXcSEjF5BoCC2PXRpAdnxFd8J9Qc2NSTbvuriu8ObQ5j8/AD9jro6l
O5WbkBokuue+PFjlkncsVOHcbbr3DRM5z0jXW5+Xxswm+f17jfVPkXwrYdhhYHl6
evOhIMPSV6k9+mSg19gzaZLBlVr2o7MP60NCz36Xg42u9a33a7zhwCbUVTdf+mlY
pHGGCh7u9vIIGdSzCnK5PuIGWuXaGlSxpFhaaLtQRBXo0Ef3YXJ4hEgWfJODHcB7
DzrcR372wafX49hwILLSQW/GwsCC5hDRorLYCuPQ1YqjLDr6vbOFNdBakBjhveft
WCJAHj1XEYTmp2WDQ4kDw18ivjcfpEqx8OrCaPRXif++tbE8rUc=
=cMlh
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--

