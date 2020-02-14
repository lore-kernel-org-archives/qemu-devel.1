Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4DAC352A3
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 02:30:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45196217F4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 02:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ltfdz/uI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45196217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Qkl-0007Gn-4f
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 21:30:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59674)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j2Qjc-0006Qw-0H
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 21:29:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j2Qja-0002Rk-PT
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 21:29:39 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:54197)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j2Qja-0002GV-E4; Thu, 13 Feb 2020 21:29:38 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48Jclf1Qphz9sRN; Fri, 14 Feb 2020 13:29:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1581647374;
 bh=ATPubIQNceGEo/hwpRJRpnl67IYMOrbb7fAvMJTDbVA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ltfdz/uIVTSikXq0w3iZs+yeMR8Qx4To5V8FAsAKSCztCpzakuyOnOf5MSOBmNdcF
 ymv97sRD9MJBFVhNh4tj1sfFP/VD5eh7PEYp7YYlPv4LCFxfE9yz/AJvuR2/f6kk4O
 KCxVdFOGd/sZh9gdxPf+qClkF+UMIUumdHhMz8po=
Date: Fri, 14 Feb 2020 13:29:25 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 0/3] spapr: Fix device unplug vs CAS or migration
Message-ID: <20200214022925.GL124369@umbus.fritz.box>
References: <158076936422.2118610.5626450767672103134.stgit@bahia.lan>
 <20200213161055.3d1b25aa@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="m+jEI8cDoTn6Mu9E"
Content-Disposition: inline
In-Reply-To: <20200213161055.3d1b25aa@bahia.lan>
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


--m+jEI8cDoTn6Mu9E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2020 at 04:10:55PM +0100, Greg Kurz wrote:
> Ping ?
>=20
> This series fixes actual bugs. Also, I have another patch on top of
> that to cold plug (or remove) devices pending hot plug (or unplug)
> before CAS, hence removing the need for CAS reboot in these cases.
> This requires SLOF to correctly parse the FDT it gets at CAS. Patches
> have been sent for that too:
>=20
> https://git.qemu.org/?p=3DSLOF.git;a=3Dcommitdiff;h=3D689ff6f6554d94fdab8=
54bf4fc4ec85e2675e43d
> https://git.qemu.org/?p=3DSLOF.git;a=3Dcommitdiff;h=3Da093be1ebe7a4832164=
6601d94be6cf735c81e12
> https://patchwork.ozlabs.org/patch/1235817/

Yeah, sorry, I've been having a bit of trouble getting my head around
the cases here.  I've sent a comment now.

>=20
> On Mon, 03 Feb 2020 23:36:04 +0100
> Greg Kurz <groug@kaod.org> wrote:
>=20
> > While working on getting rid of CAS reboot, I realized that we currently
> > don't handle device hot unplug properly in the following situations:
> >=20
> > 1) if the device is unplugged between boot and CAS, SLOF doesn't handle
> >    the even, which is a known limitation. The device hence stays around
> >    forever (specifically, until some other event is emitted and the gue=
st
> >    eventually completes the unplug or a reboot). Until we can teach SLOF
> >    to correctly process the full FDT at CAS, we should trigger a CAS re=
boot,
> >    like we already do for hotplug.
> >=20
> > 2) if the guest is migrated after the even was emitted but before the
> >    guest could process it, the destination is unaware of the pending
> >    unplug operation and doesn't remove the device when the guests
> >    releases it. The 'unplug_requested' field of the DRC is actually sta=
te
> >    that should be migrated.
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--m+jEI8cDoTn6Mu9E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5GBgUACgkQbDjKyiDZ
s5K1ZBAAt2MMzeR5YjupsCLavuKvoWQ6Dylni9wmf4ERLFV2vuUUoYFCi+uQh3YM
HSds9iZDv42hSyRkv55d/oghlyJRKjWZiyeBfhX6PML1w6L79PpPl37HsH30Y0JG
UyWHNFFkh9kTiVIuTtKraqfa3n6csylsqR1pDVZU2XLCBqZrl4eri6Boz8MsCjdL
E8i7f9ITJPn+Zvdd9enhJutOAYyagEcOUQ/iOy1NhG9Y/pq8BBsu+Jaieqi41jyT
iNthbYzhQCniNMfUYhajBV2K8syleXzJUkWdcLuDNjRYhfosQShMfkAGPDKSHZaT
xG1jQDj+JK6myZm9Pmt/AcroCYsIWnM5mmxM8B4JIkl3tCcJRuLQQyvGRvRHmap4
ssfEiFEkZexUUZdNtMyR0i5SjzI85m87xP51fhiOS3z65TTMgKzogRugaA5WO5wt
JON4Rp7iB30d5QAJWc67BtvPxId8FF7HPJTfHadkyn2kL/hca89qpXaVBdDIORsY
3bBlZDeg/HLWFJCFP3n0OVWDUBbtrb3zW6I8QPPTuhoJ8mPu4Q3vA3F/va9qRBXB
+m8lZBr2OKljBZoRrQUIRs4dR4MuZZ219SO9pZeCr5EicmfHpKfkv6oK8g0wY+Tr
B7A8AuRwlzP9RxnyvdRC6LkkxUGDGM7raZX5oA1bLZCyvsbbX6g=
=nrnN
-----END PGP SIGNATURE-----

--m+jEI8cDoTn6Mu9E--

