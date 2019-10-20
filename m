Return-Path: <SRS0=HPkn=YN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEF5CA9EA9
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 06:37:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB632222C2
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 06:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ZtfKMsXw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB632222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iM4qV-0007bn-2y
	for qemu-devel@archiver.kernel.org; Sun, 20 Oct 2019 02:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49899)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iM4nv-0004sZ-4G
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 02:35:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iM4nt-0004Wl-Ph
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 02:35:03 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:47605)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iM4nt-0004UO-Df; Sun, 20 Oct 2019 02:35:01 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46wqkl4WMzz9sP6; Sun, 20 Oct 2019 17:34:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1571553295;
 bh=PdKFh3fj2/UCEiL0O7YmlZ10XECMfYJBdTYWBaiOpD4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZtfKMsXwawoWqsg+MMkaMFNrdIfhlm/HuJVGykkN0GZRjUHf+8PXrIAA7MGgRfvgi
 1NWT6FeKR5aAiXRXccYaIw5cFDgqNSgbzL+PbADllExx4BcaTLjNxOkTsmfY5ejAS+
 DC8xxr26egQziFZy3IOoDvyoNrv09+qHDcBWyB04=
Date: Sun, 20 Oct 2019 17:26:17 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Marty E. Plummer" <hanetzer@startmail.com>
Subject: Re: qemu/powernv: coreboot support?
Message-ID: <20191020062617.GH1960@umbus.fritz.box>
References: <20191018172622.kz4smemh5cwesfit@proprietary-killer>
 <21ba3404-dcd3-fe06-7725-d58e249f9fd2@kaod.org>
 <20191019153108.gkupn3tnihspq7th@proprietary-killer>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bygAmIonOAIqBxQB"
Content-Disposition: inline
In-Reply-To: <20191019153108.gkupn3tnihspq7th@proprietary-killer>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: Joel Stanley <joel@jms.id.au>, qemu-ppc@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--bygAmIonOAIqBxQB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 19, 2019 at 10:31:09AM -0500, Marty E. Plummer wrote:
> On Sat, Oct 19, 2019 at 03:46:59PM +0200, C=E9dric Le Goater wrote:
> > On 18/10/2019 19:28, Marty E. Plummer wrote:
> > > Hello,
> > >=20
> > > First off, thank you for the work you've done on the ppc64 support, it
> > > has been very useful. I'm currently working on a coreboot port for the
> > > talos ii line of systems (which means more ppc64 support, support
> > > specifically for the power9 sforza chip, and specific mainboard suppo=
rt.
> > > My plate is very full lol) and have been using qemu to debug the
> > > bootblock.
> > >=20
> > > It has been very useful for that, but I'm now at the point where I ne=
ed
> > > to jump to romstage, and that's where it gets tricky. qemu parses the=
 rom
> > > image and looks for a ffs header, locates skiboot on it, and jumps st=
raight
> > > to that. Not exactly ideal for debugging something not produced from =
op-build.
> >=20
> > yes. I suppose you are using my branch powernv-4.2 which adds PNOR supp=
ort
> > and a way to boot directly from PNOR. In that case, QEMU parses the PNOR
> > file to extract the PAYLOAD partition (skiboot). skiboot also detects t=
he
> > flash and extract the kernel and initramfs from the PNOR.
> >=20
> > However, you can bypass all this internal boot process by simply passing
> > a -bios option and not passing a MTD device.
> >=20
> Doing so gives me the following error:
> qemu-system-ppc64: Could not load OPAL firmware 'build/coreboot.rom'
> (this is after I patched the 4mb size limit up)

Hm curious.  We'd have to delve into load_image_targphys() and see why
it's failing.  Have you checked for simple causes: incorrect path, or
bad permissions to your coreboot image.

> > I haven't published the PNOR support and the boot from PNOR yet. Lack
> > of time and because sPAPR is the priority.
> >=20
> > > Do you think it would be within your wheelhouse to provide a generic,=
 non-ffs
> > > pnor interface for loading arbitary rom images?=20
> >=20
> > I should probably send the PNOR patchset now so that we can discuss on=
=20
> > a better way to satisfy all needs. =20
> >=20
> > > It would be of great help if
> > > you could. (This would still hopefully have the bmc support code as
> > > well, as I'm still needing to support a system using one).
> >=20
> > We have support for Aspeed machines AST2400, AST2500 and AST2600. It=20
> > is possible to interconnect them through the BT device. Or you can use
> > the IPMI BT simulator of QEMU on the PowerNV machine
> >=20
> > Thanks,
> >=20
> > C.=20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--bygAmIonOAIqBxQB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2r/gkACgkQbDjKyiDZ
s5KtuA/+L+uFGtUMqBsXIBywUH+q5mXNrde7IykjSr8u6W48xWIOxkiVmRUVVsqE
arsKdxl60rgDWYTPqO/NpVSHQeUzHLVf9Rssrp8ODuWxp5axh7fGtkROc0SpPhJh
02uLAVnJwPSKYs0hC39c+yyV0GIHTODCRaTYvbC/OImt26MqFRUK/tMFw9lpTPAT
jXg2pPEC0uw8lG8XoT1lTQFTsVAGn4JbPgTd8nr0UolrJYAIiyEYra59fKDJBzq2
YJLYa2L5oscklDgxm929JcznocR4n1r/4KtJR5DhQU3EFLNYrNiKMvTbO/q4xHPn
vuJO4HvNZ6AorTs5KVl+CVYIiCBVGHBgtaxoVDceo3G6PFGxtXcDZ9BeZj8SFQRG
PrhUftd9TJmSmXcFgzrA6WhDnJalnt6ARRyW17Bf5f8GV1/8ZBASZsIWYL2FfAMm
+2XNh6w/dyOfMD/RNcnk1fJwy372uD/pNXwORUf0apLcW1cam+HNB1Q8pTcdpTDv
17FjSXreyYfCXbMCBJS3aO7ngJuAnk77dJZ+BTAeXtLiSV/OzGpBlPtGAq4kKxpI
yIwUhYDZ2Jfp5JqG04nyq/4a+P/TpcPqYK/YV2gLCXItepH+Fw8QN5ks/yAbRMKV
fFUFfGpgOFP3raMANFuPRLR+V9kPehj8XQX4SgbelukVFqvIqGg=
=lRTz
-----END PGP SIGNATURE-----

--bygAmIonOAIqBxQB--

