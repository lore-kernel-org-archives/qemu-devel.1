Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518C4CA9EAB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 11:16:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CF7D20640
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 11:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="gnIuLltq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CF7D20640
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLmjB-0005Hi-69
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 07:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55216)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iLmi3-0004jQ-JG
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 07:15:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iLmi2-0007EU-2u
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 07:15:47 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:43819 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iLmi0-0007CF-US; Sat, 19 Oct 2019 07:15:46 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46wL192qDGz9sPK; Sat, 19 Oct 2019 22:15:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1571483741;
 bh=qzFcPpaHYO/S1/QFlQ3Co4sLDsEORq4lizONvLSHbKQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gnIuLltqOKQ8m2IEQtpguuKZTTC5qANaoBtsMRlrktrYE5qpgPnEYxUx5jx4wivEs
 2dcK6eULLOFPT8DVKLeogez33/W6CtkKQ8UnWKhZqV3XiYS+W1QgCcRInOFswOhYmp
 5RIgxpcAWF7D1EltvFf34TIbeI9QnVT1bVQxPQjs=
Date: Sat, 19 Oct 2019 22:15:19 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Marty E. Plummer" <hanetzer@startmail.com>
Subject: Re: qemu/powernv: coreboot support?
Message-ID: <20191019111519.GE1960@umbus.fritz.box>
References: <20191018172622.kz4smemh5cwesfit@proprietary-killer>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="10jrOL3x2xqLmOsH"
Content-Disposition: inline
In-Reply-To: <20191018172622.kz4smemh5cwesfit@proprietary-killer>
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
Cc: qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--10jrOL3x2xqLmOsH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2019 at 12:28:29PM -0500, Marty E. Plummer wrote:
> Hello,
>=20
> First off, thank you for the work you've done on the ppc64 support, it
> has been very useful. I'm currently working on a coreboot port for the
> talos ii line of systems (which means more ppc64 support, support
> specifically for the power9 sforza chip, and specific mainboard support.
> My plate is very full lol) and have been using qemu to debug the
> bootblock.

Ok.  I'm assuming that's with the powernv machine type?

> It has been very useful for that, but I'm now at the point where I need
> to jump to romstage, and that's where it gets tricky. qemu parses the rom
> image and looks for a ffs header, locates skiboot on it, and jumps straig=
ht
> to that. Not exactly ideal for debugging something not produced from
> op-build.

Um.. I'm not sure what code you're talking about.  AFAICT the pnv code
just starts the cpus at address 0x10.

> Do you think it would be within your wheelhouse to provide a generic, non=
-ffs
> pnor interface for loading arbitary rom images? It would be of great help=
 if
> you could. (This would still hopefully have the bmc support code as
> well, as I'm still needing to support a system using one).

Uh.. and I'm not really sure what you're asking for here.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--10jrOL3x2xqLmOsH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2q8EQACgkQbDjKyiDZ
s5IUvQ/+KzQzoz9pApPSiUc3/1meRgBjpIbYtFVv78R/OdHLhSRq4hgvIvqeN+Xf
tU+XJrISE8oI7CTCXZBA4xcaWVtaaXZV0DgcbvxMzTJtmjYTle4rD4FNwy24oo71
GFAZAV1SQj/8uj0J7zRyGxiPmiCUd7C03HnKJM9Ohgsjy/tINsi5nEOuXJM+tSWO
KKagslMkKXTmLFm82ZiNS5QgqUH0N9mUKYWE0vexGWRgAbIW7JDME4vk0KHOf52e
/N4PQeYo8SBbYUORhvLP9fVtY/3b4F44+KnHdR7/MmXuks17+eZ4J0AAx/XvXsMw
DbBZey16fKUUaSS7NtV0H0jH3yKMvCwKuZTN3xLoFcLPGHMHHMap9Wh8973DXvDS
GC3nENMTivitMmjG973HklDNGDWvbMR/magrfT7ANH88NPYWXFR9hjtTHBiE45IG
TmHgbwmNn/zqtPMJh3KBKet4/WviS40VE23JfHfq5k9Tb5a9zP7Q9wNH84DC1h0n
zojLZY5Ryr950rT8sClh6X757x7IC0V/EoK9fPvKaPTnZOw1Tis2nXDKgXbVojlv
CmhCXKbMprBz163Uom3TjNhU1COpCh+NUZOV/tmxFM45iBfrBgXzswbjI3AQ3Pbr
fAbjKGRNLNxqIo9Zr/rOde56YfCCVV7EWzBfHEN8ilpbrlOWV4o=
=F9zk
-----END PGP SIGNATURE-----

--10jrOL3x2xqLmOsH--

