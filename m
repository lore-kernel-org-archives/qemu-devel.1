Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037A3C072B1
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 04:26:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0DA325475
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 04:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="eiKfCY2c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0DA325475
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58574 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWCdo-00047J-1t
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 00:26:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hWCc3-00032B-34
	for qemu-devel@nongnu.org; Thu, 30 May 2019 00:24:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hWCc1-0002Y1-RA
	for qemu-devel@nongnu.org; Thu, 30 May 2019 00:24:23 -0400
Received: from ozlabs.org ([203.11.71.1]:53633)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hWCc0-0002Qw-KS; Thu, 30 May 2019 00:24:21 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 45Dvbm3r1Qz9sVZ; Thu, 30 May 2019 14:24:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1559190244;
	bh=E/Nm5+Nhfn/wbp94rs9NTE1v6scXPFpR6QILwy42Xio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eiKfCY2cnM1Uz64OPfBJVyEr9vEuMhDXnjK3+9fqWZP45RojuOmkBUx+/GiBulCSp
	RUMLC9+nHYCYFvy8pSD6tJtSguzzwvTFTpZudsMqclU++QewSclAa5+dNLVZiFTA4p
	F6sxrCfSEWJub3Ddu1qAWzpaRzaTy2QOlfFwRnPk=
Date: Thu, 30 May 2019 11:51:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190530015138.GD2017@umbus.fritz.box>
References: <20190523052918.1129-1-david@gibson.dropbear.id.au>
	<20190528232250-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wULyF7TL5taEdwHz"
Content-Disposition: inline
In-Reply-To: <20190528232250-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH 1/8] spapr: Clean up device node name
 generation for PCI devices
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
Cc: qemu-devel@nongnu.org, mdroth@linux.ibm.com, qemu-ppc@nongnu.org,
	groug@kaod.org, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--wULyF7TL5taEdwHz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2019 at 11:23:54PM -0400, Michael S. Tsirkin wrote:
> On Thu, May 23, 2019 at 03:29:11PM +1000, David Gibson wrote:
> > spapr_populate_pci_child_dt() adds a 'name' property to the device tree
> > node for PCI devices.  This is never necessary for a flattened device t=
ree,
> > it is implicit in the name added when the node is constructed.  In fact
> > anything we do add to a 'name' property will be overwritten with someth=
ing
> > derived from the structural name in the guest firmware (but in fact it =
is
> > exactly the same bytes).
> >=20
> > So, remove that.  In addition, pci_get_node_name() is very simple, so f=
old
> > it into its (also simple) sole caller spapr_create_pci_child_dt().
> >=20
> > While we're there rename pci_find_device_name() to the shorter and more
> > accurate dt_name_from_class().
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>=20
> The threading is broken here btw.

I'm not entirely sure what you mean by that.  I did forget to add a
cover letter.

> I was CC'd but it's mostly PPC stuff.

Yeah, this was just for reference, since it is PCI stuff for ppc.

> I like how pci_XX functions that are not in pci.c are
> going away :)

You're welcome.

> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Thanks.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--wULyF7TL5taEdwHz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzvNyoACgkQbDjKyiDZ
s5JFrBAA5ff88GM2drbWgy8s4eHcSsIBWXU4fEOb7YC5hSlDl0G1vk6LGQdujJMi
2SBEoM6TMKnMWsyQlF5wxhhaw0q3dHCCWMF9+G87ytnBOQbBSiUIcFc87a9Prtt9
pe/Ioeh0DxDSVqP5jof7T/Ot4e8NHfsK95FYUi+SgDciFrBA0/ScnxMontSaviLi
/+pDK/Jz5qIENxqJoJQP65DvSvUasoYneNfAEcW31GmoDsKalv4ZVjWlSNTyQF9w
jk/qTeDFw0Q9QlhtXrlu44BpRthMv2kceBvPnkzS3Hn1Qj7K0pVarJjhoMlSPCkK
C6+Pg3/JwzbWcbGXYSDUX3rPm5eoTlaaCEkUSnWOsc2zUfo630pxjc8Dcc1biLYG
IwzYsoyr1AMoGD3rD3RxX9H2KXAPvqrHkS+4Zwk+Hkg49ZIQFsmUsG02JIfHdnnd
fG2H5SCSoYdHRzoYIJjQx2t4GS1w6BJUNfcwLWN8E57nT6Imca9Jw/zLWUqOm7vF
/FRr21iZn0odk+/lhrUlap+2YRw21Mh45Bskadso4wPZBJhCeBoKz1gEKewloS75
okMOD/hCcx/1Y2HMScYliUNva0QefcV82arO2H+XG1/7iU6OHrIBRE0enbznuK3S
VULeply2SfBd/pM+znjFmt4bSBOf3ay9+NOR9w96UPHMhyeUR1o=
=IXRf
-----END PGP SIGNATURE-----

--wULyF7TL5taEdwHz--

