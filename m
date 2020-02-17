Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 778DDC3B1BF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 00:32:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 365B2208C3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 00:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="TZVA7pnY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 365B2208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3UL2-0002TA-De
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 19:32:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60875)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j3UKH-0001Uj-9T
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 19:31:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j3UKF-0006O3-To
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 19:31:53 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:36771)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j3UKE-0006Iy-Vy; Sun, 16 Feb 2020 19:31:51 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48LQ0K4sZlz9sRJ; Mon, 17 Feb 2020 11:31:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1581899505;
 bh=QbcPdL8gZBf1hTlfBnOIoDXpFKPoT2GaZrkMXLZLG5M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TZVA7pnYJBQ2poRBbfUc5Qz+qyZCOONkrgDIZvTlP0LqwYBOFJIlN3PHtiZvwRROc
 hzYY9RGE092UZHAOcBugXtMBi6If2ytEq2rYMMCQGQkeOH2VAYs3MbDP+3aDwj8JrN
 uGIHHslDUaNMrau4COD+3iGS4Gi5ugcjKRh8qS4k=
Date: Mon, 17 Feb 2020 11:31:37 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v2 0/2] spapr: Fix device unplug vs CAS or migration
Message-ID: <20200217003137.GB14136@umbus.fritz.box>
References: <158169247578.3465937.4013536808417411649.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="EuxKj2iCbKjpUGkD"
Content-Disposition: inline
In-Reply-To: <158169247578.3465937.4013536808417411649.stgit@bahia.lan>
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
Cc: Laurent Vivier <lvivier@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--EuxKj2iCbKjpUGkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2020 at 04:01:16PM +0100, Greg Kurz wrote:
> While working on getting rid of CAS reboot, I realized that we currently
> don't handle device hot unplug properly in the following situations:
>=20
> 1) if the device is unplugged between boot and CAS, SLOF doesn't handle
>    the even, which is a known limitation. The device hence stays around
>    forever (specifically, until some other event is emitted and the guest
>    eventually completes the unplug or a reboot). Until we can teach SLOF
>    to correctly process the full FDT at CAS, we should trigger a CAS rebo=
ot,
>    like we already do for hotplug.
>=20
> 2) if the guest is migrated after the even was emitted but before the
>    guest could process it, the destination is unaware of the pending
>    unplug operation and doesn't remove the device when the guests
>    releases it. The 'unplug_requested' field of the DRC is actually state
>    that should be migrated.
>=20
> Changes since v1:
>    - new spapr_drc_transient() helper that covers pending plug and unplug
>      situations for both CAS and migration
>    - as a mechanical consequence, fix unplug for CAS an migration in the
>      same patch

Applied to ppc-for-5.0, thanks.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--EuxKj2iCbKjpUGkD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5J3ukACgkQbDjKyiDZ
s5KLbxAAxpC7+r0JjQksHvcA2e50TbrxuvsglGTCZ9ivXXC7GB8wkiqJFACJxQEY
w9VmW0erxPTZhaV4a14o+4FRLxfLDABkVtKBEiQwf67d0NBEOtPJ8XXrb3dLcLbp
RPUSj4KZLXUunKaQYMLo7Du0XQqm3f58zRuNUk3tZAV5NvUN4e+yzHCHFVmgLNHa
WTjRMHQnMNSgm3xSIU5DhLXBR2Pn7XfQnBu7Ldk/qRWV1B91LE01RochXgeoTJqD
c+SGUIqQ4RSvcFFNITUYyZgre5qOkHs/PSs125C5/yaHXnWaCVXzyIzmbUjP2LM9
/RPc5T/B8XKQjVMyHl479VbDdHJJL1a2Qy8iNtgUmGkAOAdf+lrB4e6ES6Ocnpuv
Y4M++O5id3Lii8PRgQWyg2vnpTQWAyu3re+H+2pGhacwQCTRRWwX1adfssiwPUg3
EJggcj1WsXVDladQVdVLX8glvP9o3euvWuKB/aYarxczAjWJbEgqNPAbbnFulM+O
Qqb2KsVShwCu4IUlnC4CvsVfaYb49MeDcHD9pzq/TOIfbDqU963anY4ofaWnOPYT
N20/bF5QLJaP69pfojxHhME5D56TM/8disacyiZgo4MpIBRDOLl75qoYg2hQ8ujm
/iQY4vfhurYUzmVUU3D/LWPNdHgrMWbB9FW7H0qKLwKgFqg3xCA=
=zAGo
-----END PGP SIGNATURE-----

--EuxKj2iCbKjpUGkD--

