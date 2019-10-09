Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F34ECE58C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 21:56:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C88B1205F4
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 21:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="KkJ2R/SR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C88B1205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIJwX-0007gD-TG
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 17:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54564)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iIJvW-00073q-Nx
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 17:55:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iIJvV-00015r-8v
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 17:55:22 -0400
Received: from ozlabs.org ([203.11.71.1]:50809)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iIJvU-000152-89; Wed, 09 Oct 2019 17:55:21 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46pSgm49fnz9sDB; Thu, 10 Oct 2019 08:55:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570658116;
 bh=c4abjD33CyHjFhtKHBO4xE7NmTH5qOWIjvPYEVvVG5M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KkJ2R/SRWsN3FjOzeoIXfAaM3b+DXSPpgo5tzm20lZ5TicPKfX9+jldVgjwRCBT+r
 7j+vGhv2WepgXfVgJYgEshsNOgTZmVS7Vazda+A8TPiaHsyD36M8QA4Y15+FP5t74x
 BAng1XSCYWfHM+bFkE7oEj/4Nh1We/G16B14SuEY=
Date: Wed, 9 Oct 2019 23:02:11 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH 2/3] ppc: rs6000_mc: drop usage of
 memory_region_allocate_system_memory()
Message-ID: <20191009120211.GI5035@umbus.fritz.box>
References: <20191008113318.7012-1-imammedo@redhat.com>
 <20191008113318.7012-3-imammedo@redhat.com>
 <20191009012106.GB14281@umbus.fritz.box>
 <20191009131921.6423f00d@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xGGVyNQdqA79rdfn"
Content-Disposition: inline
In-Reply-To: <20191009131921.6423f00d@redhat.com>
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
Cc: deller@gmx.de, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, hpoussin@reactos.org, atar4qemu@gmail.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--xGGVyNQdqA79rdfn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2019 at 01:19:21PM +0200, Igor Mammedov wrote:
> On Wed, 9 Oct 2019 12:21:06 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Tue, Oct 08, 2019 at 07:33:17AM -0400, Igor Mammedov wrote:
> > > rs6000mc_realize() violates memory_region_allocate_system_memory() co=
ntract
> > > by calling it multiple times which could break -mem-path. Replace it =
with
> > > plain memory_region_init_ram() instead.
> > >=20
> > > Signed-off-by: Igor Mammedov <imammedo@redhat.com> =20
> >=20
> > Acked-by: David Gibson <david@gibson.dropbear.id.au>
> >=20
> > Or would you like me to merge this through my tree?
>=20
>=20
> (since it doesn't belong to a particular tree, I'd need find
> some to take in in)
>=20
> Since you volunteered :),
> please merge this series via your tree.

Uhhh.. I was offering to take this patch, not the whole series.  I'm
not real comfortable taking the others, since they don't involve ppc
code, nor are they prereqs for or motivated by any ppc change.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--xGGVyNQdqA79rdfn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2dzEEACgkQbDjKyiDZ
s5Jx8BAAwZndtxT76hI23tsB5Ax9HZe3M5miV+i5/6CZSOEbe4d9llMyKVbyWWmY
/Tw8BVHjDH2b+2Uixceji6WdzQSfG7piUDkMRs7/Qm747RmXlJV9HwX+z4xlqAiw
YGdOaQ1BgElsEB7XPjnxKryS/NBYmUOAQTV0BdRIwbTrKqu7Y/CJ4Ac2wMBRl2ND
FmcBwTFtcGr52uy2Na9aDv0XbMKUop7epppElfwg/XtiOwfjs5TvmdoiVt3sXE5P
iBLaVViB/OiREIqp+zpprfU85cN9nhKC31Q7kBKNQ8r/8bVHy6NFwoARzwknJEss
MRT2ibZ+e9mgTItLU0NtVqQWD/Ce4LXMzMugxLg6owSb5oviN9Dj6ifwIhxVoo+9
hcXRJ+igiM2jn7baLi0xxKLR8ENOmUQMVRZFMjOBGebLDZS9pV7t4XfHLkZSo2sA
mb1XovBcIiRUwN1KvyjO6iW1GWZHfoINwLfJvFb2wC+VxZUOboNORVoMbiLUCo1z
QIP5MPrlVD49lTCMz6wIOfsZTdcpqQ60heGRi+pK4hoRvCzrKi2jfTtvDH4pjSyC
0G0VYXEODjvxpt+W0ryMtlCoUzmucEYfpUwq9t3oeSwEQ6RvKprmimqUkrJiOom3
NT05hCgHCU02G95NR0aWrVeBEUM5JerPcdu7i1wYJ4mmfSepGw8=
=UI6p
-----END PGP SIGNATURE-----

--xGGVyNQdqA79rdfn--

