Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2794C072A4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 06:12:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 811B020862
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 06:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="YwM0uM2g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 811B020862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36981 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTKUK-00012k-SG
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 02:12:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hTKTJ-0000Tk-Fy
	for qemu-devel@nongnu.org; Wed, 22 May 2019 02:11:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hTKTI-0008Py-Cu
	for qemu-devel@nongnu.org; Wed, 22 May 2019 02:11:29 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:55785 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1hTKTI-0008Og-1s
	for qemu-devel@nongnu.org; Wed, 22 May 2019 02:11:28 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 4582MK3yxwz9s5c; Wed, 22 May 2019 16:11:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1558505485;
	bh=7/UcQTl4dBYNRdYcv/t5z0QWzVhKrekjHBIbCoEyQqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YwM0uM2gUjVx7BiwgLDmvCvESfXDCGII4tljigCTEPfj5r61Vx+8JWNet0rQ8HB2n
	ygNWHcMDVJy8984ObvXMg+GmQ90ZAysYqglELZ1qj1/otg5dlEgxuMXBkolOK2XQWF
	Mj/EVo11cgupRPLkSK8XqKemTkcMooVsBm0KLhfw=
Date: Wed, 22 May 2019 16:11:21 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190522061121.GH30423@umbus.fritz.box>
References: <20190520231008.20140-1-mst@redhat.com>
	<20190424041959.4087-3-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5vjQsMS/9MbKYGLq"
Content-Disposition: inline
In-Reply-To: <20190424041959.4087-3-david@gibson.dropbear.id.au>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PULL v2 21/36] pci: Simplify pci_bus_is_root()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	Peter Xu <peterx@redhat.com>, Greg Kurz <groug@kaod.org>,
	Marcel Apfelbaum <marcel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--5vjQsMS/9MbKYGLq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2019 at 07:11:09PM -0400, Michael S. Tsirkin wrote:
> From: David Gibson <david@gibson.dropbear.id.au>
>=20
> pci_bus_is_root() currently relies on a method in the PCIBusClass.
> But it's always known if a PCI bus is a root bus when we create it, so
> using a dynamic method is overkill.
>=20
> This replaces it with an IS_ROOT bit in a new flags field, which is set on
> root buses and otherwise clear.  As a bonus this removes the special
> is_root logic from pci_expander_bridge, since it already creates its bus
> as a root bus.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> Message-Id: <20190424041959.4087-3-david@gibson.dropbear.id.au>

Michael, is there a particular reason this and the mmcfg patch went
in, but not the later patches in my PCI-E cleanup series?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5vjQsMS/9MbKYGLq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzk6AgACgkQbDjKyiDZ
s5LPxhAAjobzs8aIDG0nCUo6Crkvf5+Crymk4qUrqES75LmO8aqTM7rNdOItIpcd
tHKqFRjldwbERZ1RvTI2Tb7RI9sFYkDGG0O929NACYuyCvvuBPWr4PjyseUUOlvM
Ez9hTjNsvYTPi53n8/cLzV/2dKy/8jYMswyqrTsLFKLWyq9n13fPNKWXPKAaWgXS
faJ/X5FvFg8sZMJnN06QZMc6GnV4vGWz7qKgwOcncneyqc0cduykx275Z0iuqQty
Tlwk11lhqnsgLCOJM5fLBrWQAhHDGNVRgUtc0s+wEJtwCH9EScDx3z+3SgbwHGRD
FDiRVh0i0bkuRwSOBtMDFWeYzJJ8E7UQVlqqpoHHRNqoMOC6FPv2n1HPVfoW2+UW
sydJ64J/3thgvYLCT9h0lW+b4g7h4wyn9koVaN6AXZk/a4SjSjzjAwSCTrSofknk
lElbu31GLgawnIQC/Z31mugT/cpjb+N3I7JgavtS8joXefPhQGF7LUovm4thu14O
TJAnCLGAMeU63amLcSriwI1Ft3Y/J7yl5tghGR7K72V5CtkNfq5Z+zSMGE/7/fR6
jmvSBVSPkWXyRDm/aPhzixYWhMy7PxRzjcb7NkrCXsfcECkp46AxhG33cZCNXa2p
j9XvfpNnoalHqTMLlFuI2TWixAmnCiu3gc4IilWd2TVFes+rCwU=
=puw3
-----END PGP SIGNATURE-----

--5vjQsMS/9MbKYGLq--

