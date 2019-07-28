Return-Path: <SRS0=P1lm=VZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F77C76186
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jul 2019 02:00:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32C572070B
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jul 2019 02:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Jd5ePCtF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32C572070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hrYTi-0000c1-0h
	for qemu-devel@archiver.kernel.org; Sat, 27 Jul 2019 22:00:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48668)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hrYT5-00087c-LM
 for qemu-devel@nongnu.org; Sat, 27 Jul 2019 21:59:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hrYT4-0001wp-N7
 for qemu-devel@nongnu.org; Sat, 27 Jul 2019 21:59:23 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:54593 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hrYT2-0001q4-Kg; Sat, 27 Jul 2019 21:59:22 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45x5bJ0CBhz9sBF; Sun, 28 Jul 2019 11:59:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1564279148;
 bh=hlCAbvMXkOdVobC4uHWwts/2ZlaQe0gMcFkX6e/Bw/0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Jd5ePCtF2fo/ndPgmIr3Tk/VQRu5KgUEja/KgFzOwmMIZOQoiUqJKOEgpA3G+WL9b
 NwO3uA0MRI7vCyDHB/8qd7TWdkYAe3cDYhoObZCo5+MNlZ7VrD1FQ06/Jz6JhTZVMx
 Pp34IcPcYZ2GbPIq5qweKSBcEoJWktepjb2CpT0k=
Date: Sun, 28 Jul 2019 11:51:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190728015122.GA5110@umbus>
References: <156415227297.1064338.9181963275184520284.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
In-Reply-To: <156415227297.1064338.9181963275184520284.stgit@bahia.lan>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH 0/3] spapr/pci: Improve MSI tracking
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2019 at 04:44:33PM +0200, Greg Kurz wrote:
> Some recent tests with AIX guests showed that we don't tear down
> MSIs that were allocated with the "change-msi" RTAS call, when
> the guest is rebooted. This series teach PHBs to do the cleanup
> at reset time.
>=20
> This bug has always been there. Not sure it is worth the pain to
> have this fixed in 4.1.

Since we've only recently started looking at AIX as a supported guest,
and these bugs don't appear to break Linux guests, no, I don't think
it is.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl08/5gACgkQbDjKyiDZ
s5JJjhAAp0PQemTibJkfe9IOsGFUUc3F+1LeNQ7IyxxwlVjf/xk3NeRzhycXIsc4
JDccKH86ALj+Gl8f4mUGbvWl9579PVn+AWMxjs12bZrgFMyyZ/8Yoj8srYLnKvTi
a/joFeENPPhmHhFzEXbZvFblgFVFC3tnHdFMcEOxrcHZTA4AVO1WkdpVa1PmNvjJ
GEzUrLE2f9mjvMpm2m9PE1B4ZSdM+c7l2c0ZNR8XxjFFTEj7gM001zzFxgGWgech
bPcXsgngDo3NoYT6b17bYD+ouE01yH42uFp0XWM3HVkpo34xUui6TyBcAHKVRV4t
Z4r5oCsqEAfjZDKvxtcUVxOvaNyV7BGvY/TuUGmUefD2LqE1Kmsy9a8fif71Qwgp
RH89cNV/e4oP+qcrKtE/JYJQ01jiwMJ4ORPYxz5CvIYlp6E2jSIJnceEaUe7Xlf6
H5VWhNpSJFy3XSolnY3IandzbK7z7hzfcHh4tPWftR3zFkKsdQ75JDwsm5Dm+V+C
pSf2btoPyWtRMt0lVvYQ6UKJA815IvmCFftJLyY842cat/wB2fNHPBr6n5jLRz2d
UDMo0wFiJFTmxoVWoiKGev95tm5Erz81yIiZ5JwiNMdA6tziKCiXmcXSlRHT0TWU
RRwyph4BKntjFCJ7Vap3pQQ+3HfR18ImvySUWhcddpYZeKvn3CM=
=Gto9
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--

