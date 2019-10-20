Return-Path: <SRS0=HPkn=YN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC463CA9EA9
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 06:36:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76F4820679
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 06:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Pf+1K6La"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76F4820679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iM4ow-0005tI-Im
	for qemu-devel@archiver.kernel.org; Sun, 20 Oct 2019 02:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49894)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iM4nu-0004sV-Qg
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 02:35:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iM4nt-0004WY-9U
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 02:35:02 -0400
Received: from ozlabs.org ([203.11.71.1]:34473)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iM4nr-0004UP-WB; Sun, 20 Oct 2019 02:35:01 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46wqkl55V7z9sPV; Sun, 20 Oct 2019 17:34:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1571553295;
 bh=kkNexIsabgC/Bz3awk0mxnyG/2Z+xkWztekNTwRCCKA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Pf+1K6LaQFCLyF04lYDaurGmhewCJtKcb6ObUy3UM2VKcAgmoI5MmXm6roS5KaRDK
 aQOgcfWulB5JO2RRueqmeB/4+ucmyL+OkggmD1oi+gYSKoBth6rECK7AebW+jzu6ce
 bMDN36xWts9nziB1I7iwSNGEBwlhjhOKaNS0qTyg=
Date: Sun, 20 Oct 2019 17:24:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: qemu/powernv: coreboot support?
Message-ID: <20191020062416.GG1960@umbus.fritz.box>
References: <20191018172622.kz4smemh5cwesfit@proprietary-killer>
 <21ba3404-dcd3-fe06-7725-d58e249f9fd2@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5UGlQXeG3ziZS81+"
Content-Disposition: inline
In-Reply-To: <21ba3404-dcd3-fe06-7725-d58e249f9fd2@kaod.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: "Marty E. Plummer" <hanetzer@startmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--5UGlQXeG3ziZS81+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 19, 2019 at 03:46:59PM +0200, C=E9dric Le Goater wrote:
> On 18/10/2019 19:28, Marty E. Plummer wrote:
> > Hello,
> >=20
> > First off, thank you for the work you've done on the ppc64 support, it
> > has been very useful. I'm currently working on a coreboot port for the
> > talos ii line of systems (which means more ppc64 support, support
> > specifically for the power9 sforza chip, and specific mainboard support.
> > My plate is very full lol) and have been using qemu to debug the
> > bootblock.
> >=20
> > It has been very useful for that, but I'm now at the point where I need
> > to jump to romstage, and that's where it gets tricky. qemu parses the r=
om
> > image and looks for a ffs header, locates skiboot on it, and jumps stra=
ight
> > to that. Not exactly ideal for debugging something not produced from op=
-build.
>=20
> yes. I suppose you are using my branch powernv-4.2 which adds PNOR support
> and a way to boot directly from PNOR. In that case, QEMU parses the PNOR
> file to extract the PAYLOAD partition (skiboot). skiboot also detects the
> flash and extract the kernel and initramfs from the PNOR.

Ah!  Now I understand.  I hadn't looked at that branch, so I had no
idea what all this pnor stuff was about.  In mainline we just load
skiboot as a normal firmware file and jump into it.

> However, you can bypass all this internal boot process by simply passing
> a -bios option and not passing a MTD device.

Right.

> I haven't published the PNOR support and the boot from PNOR yet. Lack
> of time and because sPAPR is the priority.
>=20
> > Do you think it would be within your wheelhouse to provide a generic, n=
on-ffs
> > pnor interface for loading arbitary rom images?=20
>=20
> I should probably send the PNOR patchset now so that we can discuss on=20
> a better way to satisfy all needs. =20
>=20
> > It would be of great help if
> > you could. (This would still hopefully have the bmc support code as
> > well, as I'm still needing to support a system using one).
>=20
> We have support for Aspeed machines AST2400, AST2500 and AST2600. It=20
> is possible to interconnect them through the BT device. Or you can use
> the IPMI BT simulator of QEMU on the PowerNV machine
>=20
> Thanks,
>=20
> C.=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5UGlQXeG3ziZS81+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2r/ZAACgkQbDjKyiDZ
s5KCzw//TG9ISNK3W/4cY0wTSy+szajdezJVuzM34C7hfLxYBbLT4CI6+aZaOdTh
VuHTZkYD//b15pQ6HushHyIwIR7SRHSdqS4bzG+bQJrVUjnlsqIsf+17umb6+vEh
yg9u4kpbmUgYkb/LmrJbSqDSLiXgFbMPoi9SS6EZF+/tnSxuasirJqmOu6OGlqn3
Qf+VFbOGlWOVDlG0lyujDKwjfAnt7FVVX6Vy8XKDOqSywGtGrNnxuTABAqpD+RdY
vHicHq8nVsUqI1p1998I2XUa5InCOS1zTtj1U2n3S27h84JLTorsl2M+6/W9v3IZ
enEoS/G8JQK6JPNVOocFSCghD+OuUIm6nRoFIA3fueUxgAX/9KuNXk6KSRI7peVE
HX6ah777ucp9wczL9gde1mmn8f5mUK4bN+2HtyUYJJLXqJ6Fwslt/gjIk1TBXLBa
CqPvB8JXLN/ZOegqVXqVEEWPIGF7aWe7QWqZmxbKZGE98O+KOj8N9aMj5cStsMkf
3i/Gh/7fkTcTfa8Nx1FhkAOk4UMoAGXgG16A7LR2JV6DcmWn7mUYpVXSgstM1BKf
LHDdZ75oMjEg0bnWmmlhUcJ+jWqWvDZQGsOiepkWxdC0/05ftMPxY11LOD6kkeQ5
rtDEGLGwSCrvwElK0QExDeE76rb2xY7dTrzBbHk3F9qqPMaJn3w=
=Tv6c
-----END PGP SIGNATURE-----

--5UGlQXeG3ziZS81+--

