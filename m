Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75909C4CEC7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 00:44:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F764206A4
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 00:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="DyF1334K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F764206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9f8J-0008CQ-DG
	for qemu-devel@archiver.kernel.org; Sun, 15 Sep 2019 20:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41659)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i9f5W-0005ZK-IH
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 20:41:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i9f5V-0005Am-4b
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 20:41:54 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:35579 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i9f5U-0005AQ-1k; Sun, 15 Sep 2019 20:41:53 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46WnVx6m7Zz9sCJ; Mon, 16 Sep 2019 10:41:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1568594505;
 bh=fVy+OTMPWlp6IxZAltLahRTiL0ZRoub5i4pPltEVuhU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DyF1334K/5kZ47WFH9Wg+QRI+vyfMtfe36fhg/l1M4ILbLH4PMtWVvnKV56p9aI2k
 GEY9Zk+jB40qQ5YZ8j6S0ooQ/JmJ+euYaR3BGR2qVtkQfFkKkzwoHg7XUWHtgkjaYd
 BhuE4bkyE5ktoyDHggsAIJbbHBzcsnPdHUPKYk4w=
Date: Mon, 16 Sep 2019 10:36:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Balamuruhan S <bala24@linux.ibm.com>
Message-ID: <20190916003639.GD2104@umbus.fritz.box>
References: <20190912093056.4516-1-bala24@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="llIrKcgUOe3dCx0c"
Content-Disposition: inline
In-Reply-To: <20190912093056.4516-1-bala24@linux.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH v3 0/4] add Homer/OCC common area emulation
 for PowerNV
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
Cc: maddy@linux.vnet.ibm.com, groug@kaod.org, qemu-devel@nongnu.org,
 anju@linux.vnet.ibm.com, qemu-ppc@nongnu.org, clg@kaod.org,
 hari@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--llIrKcgUOe3dCx0c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2019 at 03:00:51PM +0530, Balamuruhan S wrote:
> Hi All,
>=20
> This is follow-up patch that implements HOMER and OCC SRAM device
> models to emulate homer memory and occ common area access for pstate
> table, occ sensors, runtime data and slw.
>=20
> Currently skiboot disables the homer/occ code path with `QUIRK_NO_PBA`,
> this quirk have to be removed in skiboot for it to use HOMER and OCC
> SRAM device models along with a bug fix,
>=20
> https://github.com/balamuruhans/skiboot/commit/a655514d2a730e0372a2faee27=
7d1cf01f71a524
> https://github.com/balamuruhans/skiboot/commit/fd3d93d92ec66a7494346d6d24=
ced7b48264c9a0
>=20
> This version fixes a review comment from Cedric in previous version,

Applied to ppc-for-4.2, thanks.

>=20
> changes in v3:
>     * pass on PnvHomer *homer directly to core_max_array() function
>       from the caller.
>=20
> v2 patchset:
> https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg02231.html
>=20
> changes in v2:
>     * change to PnvHomer/PnvHomerClass instead of PnvHOMER/PnvHOMERClass
>       for better code readabililty.
>     * fabric link to chip to use `nr_cores` from PnvChip struct for
>       core_max_array() as we need to consider active cores in chip and not
>       whole machine.
>     * declare variable well ahead instead in for() loop syntax to make
>       all compilers happy.
>     * change to shorter variable name to `hmrc` instead of `homer_class`.
>     * remove `homer_` prefix for regs as it is not useful.
>     * have separate commit for checkpatch.pl coding style warnings.
>=20
> v1 patchset:
> https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg01610.html
>=20
> changes in v1:
>     * breaks it to have separate patch series for Homer and OCC
>       emulation.
>     * reuse PnvOCC device model to implement SRAM device.
>     * implement PnvHomer as separate device model.
>     * have core max base address as part of PnvHOMERClass.
>     * reuse PNV_CHIP_INDEX() instead of introducing new `chip_num`.
>     * define all the memory ops access address as macros.
>     * few coding style warnings given by checkpatch.pl.
>=20
> rfc patchset:
> https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg00979.html
>=20
> I request for review, comments and suggestions for the changes.
>=20
> Balamuruhan S (4):
>   hw/ppc/pnv_xscom: retrieve homer/occ base address from PBA BARs
>   hw/ppc/pnv_occ: add sram device model for occ common area
>   hw/ppc/pnv_homer: add PowerNV homer device model
>   hw/ppc/pnv: fix checkpatch.pl coding style warnings
>=20
>  hw/ppc/Makefile.objs       |   1 +
>  hw/ppc/pnv.c               |  87 ++++++++++++---
>  hw/ppc/pnv_homer.c         | 272 +++++++++++++++++++++++++++++++++++++++=
++++++
>  hw/ppc/pnv_occ.c           |  78 +++++++++++++
>  hw/ppc/pnv_xscom.c         |  34 +++++-
>  include/hw/ppc/pnv.h       |  21 ++++
>  include/hw/ppc/pnv_homer.h |  53 +++++++++
>  include/hw/ppc/pnv_occ.h   |   3 +
>  8 files changed, 528 insertions(+), 21 deletions(-)
>  create mode 100644 hw/ppc/pnv_homer.c
>  create mode 100644 include/hw/ppc/pnv_homer.h
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--llIrKcgUOe3dCx0c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1+2RUACgkQbDjKyiDZ
s5ICphAAoyFPB7NI0Mw8mdMNt3ZY0zavJfYyok6AoR59PwB6vG4RXkq98uqqY43K
PqYxKMWoLmIMBojN7aGv3bp6uKntJq+XvQmduR6dAU9ZsOyKh97amhSep1QVplni
06ZMlCb/jnhaPrULGI5hp0XfR5OmldsHj2I+Y7GWhKDv16gVXYQpTNJ4Ne2M3VDT
5/sW4GIi7V0PKYeDHccM4GC8nXA8qu8W4M9rCcDFguy8XIUpJZ/51Cv3X5wwZgPX
ueLa14XFuImFv8o4C0KirHEDhN3zfwoSFMk7ZFFv27WA9HY58FF/olZhnnEI8MBY
ROXPjrvQRkvmEWq7PlwHt2aq6byvRepkMmuBW4EBsYywMSGzvxh0xEHMsNdkl77P
n1KeBUmlY3A/Unu3nt/3PXL0a2jGZIHg91+O10V75t06Jw7L/5JoRRNRnj+fa7jQ
+4W0NQ/kgyopbOexvqJVmhRp+bFoTdqy6KeISy9KAzdx+MPUKsIrwA9GNQj7IOFJ
Ql7kuD8MiYrOdVktuyRVEV7u3CuZXugJg1K2AswDKWAOzVx9nuyWXJ30OQaQtdCF
/uzr50r8e8nI8WuBOtElOqRASIEcl12zEwJd35Vsxc/F/w6TtOtsnga9PiLx1UGF
lZBf+oWOTwoQDejnJd34yChCYCACOK2IMNQcMyCSluM75iFNQxg=
=JT/w
-----END PGP SIGNATURE-----

--llIrKcgUOe3dCx0c--

