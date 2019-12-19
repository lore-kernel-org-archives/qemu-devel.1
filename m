Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBE8C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 05:16:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC87E2146E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 05:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="k4oeFBIs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC87E2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihoAv-0001HP-U2
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 00:16:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50143)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iho9O-00009F-8a
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 00:15:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iho9M-000300-SO
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 00:15:02 -0500
Received: from ozlabs.org ([203.11.71.1]:52071)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iho9M-0002jv-ES; Thu, 19 Dec 2019 00:15:00 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47dg6n2Z4mz9sPh; Thu, 19 Dec 2019 16:14:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576732497;
 bh=PEdzqCLmj1ylRXrUzoLhQ9R0MFzB7Jy1nWj8wfZkOfU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=k4oeFBIstRFySwVbL7Q2H2ZClO+jJVkyO4c7RH5HnIEOa05uqwrJsqQfRHtVkKVTm
 RUj4Lg2pl47GVcPWgHrwLUgfYZUXtBySaaljiyyFvqIDlXlGwrycZeqRCXmjhvLlf4
 YwtuC80Fmqvu8pCX+r4FIevrrt0ImdcoI+EmUZQg=
Date: Thu, 19 Dec 2019 16:13:57 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v5 1/5] tpm_spapr: Support TPM for ppc64 using CRQ based
 interface
Message-ID: <20191219051357.GG2321@umbus.fritz.box>
References: <20191212202430.1079725-1-stefanb@linux.vnet.ibm.com>
 <20191212202430.1079725-2-stefanb@linux.vnet.ibm.com>
 <20191213053453.GD207300@umbus.fritz.box>
 <75fd3e95-d72f-069b-22ce-f354e1c34660@linux.ibm.com>
 <20191217002954.GH6242@umbus.fritz.box>
 <1efef315-cb85-79ea-9c46-ff318e05a543@linux.ibm.com>
 <20191219015414.GC2321@umbus.fritz.box>
 <db0d3dbe-3b01-e62b-2cf0-3d0c50e3c4fb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="reI/iBAAp9kzkmX4"
Content-Disposition: inline
In-Reply-To: <db0d3dbe-3b01-e62b-2cf0-3d0c50e3c4fb@linux.ibm.com>
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
Cc: marcandre.lureau@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--reI/iBAAp9kzkmX4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2019 at 08:59:18PM -0500, Stefan Berger wrote:
> On 12/18/19 8:54 PM, David Gibson wrote:
> > On Tue, Dec 17, 2019 at 02:44:04PM -0500, Stefan Berger wrote:
> > > On 12/16/19 7:29 PM, David Gibson wrote:
> > >=20
> > >=20
> > > > Since you need to change compatible based on an internal variable,
> > > > we'd need to replace the static dt_compatible in the class with a
> > > > callback.
> > >=20
> > > Why can we not initialize it once we know the version of TPM? From the
> > > perspective of SLOF at least this seems to be building the device tre=
e fine
> > > since it sees the proper value...
> > Because it's a serious layering / isolation violation.  You're
> > modifying QOM type information from the runtime code of a specific
> > instance.  You get away with it (now) because there's only one
> > instance and the ordering of things happens to let it work, but that's
> > assuming way too much about QOM's implementation details.
> >=20
> > As a rule, once the QOM classes are set up with their class_init
> > function, they should never be modified.
>=20
>=20
> If we now add a get_dt_compatible() callback to the class that gets invok=
ed
> when dt_compatible is NULL, does this then solve the issue?

Yes, that's what I'm suggesting.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--reI/iBAAp9kzkmX4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl37BxUACgkQbDjKyiDZ
s5J7FhAAwbbNugdWDl+Fyg7ffBmIDBl02mlNjFdIMOiGVoU6tkXc/ONSRZJYJUT+
MJq1Xh/KJCLUEV4HjAsFZq9uKYfeo8dlIWD8rq663VMGuFkiR3tBPKLg1V9E2XH6
p4hBLioPAOUN73XMUXbUZoK383Glmbykx6SfEE6oYbcOQeJ7W83YVIp1Vcll0n7c
NDzRXFMhmQzXiWH20ePnWuxh1g/VOsiAK106L+/gm87G/uND0CZM88vOuOdDA4JU
f1FPskktk98MOx9Z9lWVL/m6Jmu9ok9Auyis7+M4AFvd43pb0yp2F6YTojq5wZRt
MZgDcVNGIRetT7ET8eBuchLURSjQNtteVXaeyw/lmXFPJhSuEix4eFRnA5TkYM7j
QR7tspE2TI2oW22h4q4VGGtl1vnI/SW47IC1pwnU/SAUufhdi4ir4Jdad/Rq/L1/
kGcD/IgmgCmetcwOhYGSbM00ebDb5CaPz2ecImzc9BAoAueBraQoUxcbWk/dimC+
E5xXDrA6n6Xaji/5Upvt4AvRA0FNKbCiycz3NCvkF1lsFZiGKXqViMJe0kzbM23a
NHmnIrGSYPtp173b2bGDgjqYVBKDbyNwgkG9RBtDhUuAkHpUhqN9nmC97SQI4oTM
hYcqY25sKKdYmvPlj5drwgT9xVUS1xrIxj4qtM8zxOGKgzQFPpw=
=naMA
-----END PGP SIGNATURE-----

--reI/iBAAp9kzkmX4--

