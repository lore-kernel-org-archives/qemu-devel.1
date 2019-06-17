Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4515C31E57
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 11:44:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7371920861
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 11:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="XpAMYv5I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7371920861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46270 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcq3V-0004mO-K4
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 07:44:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53644)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hcpso-0008AL-9s
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:33:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hcpsm-0003ss-OW
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:33:06 -0400
Received: from ozlabs.org ([203.11.71.1]:57101)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hcpsl-0003KS-VK; Mon, 17 Jun 2019 07:33:04 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45S8G4117vz9sND; Mon, 17 Jun 2019 21:32:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1560771164;
 bh=ntY+xd8E9iMLHdA8TSZ+Ie+RQU+E04gL8Pokm2x0+Ao=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XpAMYv5IFvsV3L1YvM9oxwop+lidBqPMckmC9nmyiuvWAm0/IjiW4LwWLeJnzYv1a
 A9pk8ibCL38PXUSYTDU+UhIsD1Df+XmVTWbTqOFsTC4j75xRAk6gEckm/R5ORYTxjs
 jAzAnQmmydQ77g7EOwrIN11T9cLNvzApukm/6p3E=
Date: Mon, 17 Jun 2019 21:12:05 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190617111205.GA5929@umbus>
References: <20190612020723.96802-1-aik@ozlabs.ru>
 <20190617102510.341d71a5@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
In-Reply-To: <20190617102510.341d71a5@bahia.lan>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH qemu REPOST] spapr/rtas: Force
 big endian compile for rtas
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
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2019 at 10:25:10AM +0200, Greg Kurz wrote:
65;5603;1c> On Wed, 12 Jun 2019 12:07:23 +1000
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>=20
> > At the moment the rtas's Makefile uses generic QEMU rules which means
> > that when QEMU is compiled on a little endian system, the spapr-rtas.bin
> > is compiled as little endian too which is incorrect as it is always
> > executed in big endian mode.
>=20
> I'm naively thinking that executing code compiled as little endian
> in big endian mode would result in an exception... Can you explain
> how/why this ever worked ?

Because basically nobody actually built the rtas blob from the
sources, they just used the pre-compiled blob, which is correctly
built BE.

That said executing LE code in BE mode won't necessarily result in an
exception - it'll just execute whatever the instructions are you get
when you byte reverse the ones you inteded, which may or may not be
valid.  It's *likely* to cause an exception fairly soon, but the
opcode space is densely populated enough that there's a good chance it
won't cause an immediate illegal instruction.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0HdYMACgkQbDjKyiDZ
s5Jv6RAAn1gG1giPOP55o7E3bRbgaUytpIpuOmqgxgOvEqoNpeKMdkJ0OzplkV2g
9oabRLFclljhm3NUDB1hYuIQ94cwnmkno1o7grrlL2B6K+dJzb5OfkIfKXkeYZKe
i1Q+eq1pKhjF7uudSmJlxc8aTvFqb6LVPd93sIFdO2SmZ1Q1vqkvCmZHIMsQAoQI
G7xxasv7Ljq5RFlwikj1sjDhyzIOk/Kaqm4o9KJjkLPXX0sl/QWVvJ4UQBaEOC2G
6b2PZrM0/rv+6Z1ScEztNf2uFb5bQIdJ3me06cmPgKO9Hu0O/MwxINaZgS8e5+Ky
hC0WUusPS6tLvVwlpdXWzmCAXXnn7kTcB5YS7JQKikLiyQi54aKQwX4FbSwJkRDw
gcqSqmCnOuj0/HIP2U7A685BMULuj68E2wZAdi8CKYV+LsX/nM1Xm2RsRkeGSsP/
hJF7V5Zvoitr3GCyOl13YxzHAJ9Uki2KYltEY/mBsDytGzR+z6q4loVJC9yHcYtA
jTFzL8ipdccR4FUT3+mvwe9voftTILuiI70tVunaxTb5pwckfY9aXjTeDQ/hwYOQ
XR62NXAFNz2SAl1u4GnFeYIfcIINHg9DCxhxYvtE4PTHvEwb4Y5EwVcAXfKWEbBJ
h7EwaOO17ShS+j0OjfhKyhjXOQYGJcuBI0SAfFZiUVriOMYQlxg=
=MHwV
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--

