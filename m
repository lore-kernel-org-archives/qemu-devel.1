Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3518C10DCE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 02:58:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DFD62051A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 02:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="gZ4Y6ACA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DFD62051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDfx1-0004yz-Eo
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 22:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52433)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jDfqP-000379-C7
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 22:51:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jDfqN-00041O-SC
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 22:51:08 -0400
Received: from ozlabs.org ([203.11.71.1]:54107)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jDfqN-0003Wj-2g; Sun, 15 Mar 2020 22:51:07 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48ggm5227kz9sPk; Mon, 16 Mar 2020 13:51:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584327061;
 bh=DrRKg/Sne2SaQ+FwDmVcjNTwlhH6vd1jYtTeE7l1Slg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gZ4Y6ACAn4NAMm66r1hQSjELYMhF3nddw9wZOfDsSZ72aCvE9PD6MHgJBxOCOpF05
 cM73VjXF9tq/sjM5vT5RDVRyThSQS70JOiqRzF2MK+LSCMCDB2wGSN5SBEDjAjWbhj
 JNCfbjaEL869Z5btcCdwD8zpp0Dft1M/SnLfik2E=
Date: Mon, 16 Mar 2020 13:42:04 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 1/4] spapr: Move creation of ibm,
 dynamic-reconfiguration-memory dt node
Message-ID: <20200316024204.GC2013@umbus.fritz.box>
References: <20200313040539.819138-1-david@gibson.dropbear.id.au>
 <20200313040539.819138-2-david@gibson.dropbear.id.au>
 <20200313123051.7ebe1eca@bahia.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="JWEK1jqKZ6MHAcjA"
Content-Disposition: inline
In-Reply-To: <20200313123051.7ebe1eca@bahia.home>
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
Cc: qemu-ppc@nongnu.org, philmd@redhat.com, clg@kaod.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--JWEK1jqKZ6MHAcjA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2020 at 12:30:51PM +0100, Greg Kurz wrote:
> On Fri, 13 Mar 2020 15:05:36 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > Currently this node with information about hotpluggable memory is creat=
ed
> > from spapr_dt_cas_updates().  But that's just a hangover from when we
> > created it only as a diff to the device tree at CAS time.  Now that we
> > fully rebuild the DT as CAS time, it makes more sense to create this al=
ong
> > with the rest of the memory information in the device tree.
> >=20
> > So, move it to spapr_populate_memory().  The patch is huge, but it's ne=
arly
> > all just code motion.
> >=20
>=20
> The change looks good but it may be possible to improve the diffstat,
> see some comments below.

[snip]
> > -
> > -static int spapr_rng_populate_dt(void *fdt)
>=20
> I'm not quite sure why this function needs to move...

Eh, I guess it didn't.  I'm disinclined to change it now though, so I
can get this in for tomorrows last-PR-before-soft-freeze.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--JWEK1jqKZ6MHAcjA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5u53wACgkQbDjKyiDZ
s5KAzw/6Avr/jOvbjxOlOtvnxxeuU8ZoL5KEVkwzy1f1Oo3j28ch6HSJBrK32EN+
d4y70wKx8FfWvJHc0ceIDd7fx6Xp5jg/2w5uDLdnmb7iYK9BGmamyiaiAWBuvhvf
pbJ9VaLWLAcznQomMqXY3sjCFoOSg5EW0iopqS6D8tvfnRLuua6ggogTpIOu8NRa
xrrekTs2lrvM8haoDEqkqrHUuC0r4AljiFoU9ET6eHnjbIKjWzq73ugVG/DOoLr+
2lTyOzkjcYgS3a4xEsawJcDpwHotopbz/cI1ReavkQWmQDsv1fdyFjb8J1IFLTPr
rQV0+VrIwscciMW7qyUTVPn4VqW38ABykCk5wKNd6VGvfCjPTlzGf0IXHNWEHci7
UgZMjG/XrfVPnbe6dnOCe9538rQaqvbzsJXcltzGxPIJ6TK8TyQKwK7NTAK/hoWx
ARZ9QehpG3s2WfFLw7YKC61DdNfBjE5D1/ErnEeXMG9hRCJoEHDEUcK0Citu7DjV
IgfL48DXHgS8N+uscdqUPVYoNsicC1w46n6bonUMpEwWiyoEiXklzgT0odkSJiPO
5eyAUOmYb8QL3bMt64K9YAVwInyKPYKZQQCxDKcktt3ZAHlwoAA+2xSzu6Ji6NeH
7wtab8nA2uh8CORQKTlwus1q8hTnVsKYkLmLHzGVc0k4aaAEDmM=
=qsji
-----END PGP SIGNATURE-----

--JWEK1jqKZ6MHAcjA--

