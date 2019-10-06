Return-Path: <SRS0=2u83=X7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50899C4740A
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Oct 2019 00:51:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14B38222C0
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Oct 2019 00:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="MSSkwTiB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14B38222C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGum6-0002yR-4d
	for qemu-devel@archiver.kernel.org; Sat, 05 Oct 2019 20:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33945)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iGulJ-0002Pq-Vz
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 20:51:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iGulH-0002q6-Gq
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 20:51:01 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:39345)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iGulG-0002hr-B4; Sat, 05 Oct 2019 20:50:59 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46m4mD5X2Cz9sPZ; Sun,  6 Oct 2019 11:50:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570323052;
 bh=Gm18ZZ7aFtdQXYAFE5wSZgp9bNprx7Sy7+lkWdM0jgw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MSSkwTiBM3M43V+PDh/2UFahjN42undb3IhAA8I4XW2mRMJB7j0QNbDroplQiDodU
 Fi/7cfjJVu8uiIwOplAS70WLnCAe/Is+QRekgCRHRDf8x4246XBacPZPg6V8O42Mv0
 a9rHdBsfcoUbQkKbiIrgDTn36xuXkaoH4ZHD+3D8=
Date: Sun, 6 Oct 2019 11:48:11 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Clarke <pc@us.ibm.com>
Subject: Re: [PATCH v2] target/ppc: Fix for optimized vsl/vsr instructions
Message-ID: <20191006004811.GG29310@umbus.fritz.box>
References: <1570196639-7025-1-git-send-email-stefan.brankovic@rt-rk.com>
 <1570196639-7025-2-git-send-email-stefan.brankovic@rt-rk.com>
 <7ab3c116-7e59-9164-2c29-e37c4b415560@us.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="CEUtFxTsmBsHRLs3"
Content-Disposition: inline
In-Reply-To: <7ab3c116-7e59-9164-2c29-e37c4b415560@us.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: richard.hendreson@linaro.org, mark.cave-ayland@ilande.co.uk,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, amarkovic@wavecomp.com,
 Stefan Brankovic <stefan.brankovic@rt-rk.com>, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--CEUtFxTsmBsHRLs3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 04, 2019 at 01:52:41PM -0500, Paul Clarke wrote:
> On 10/4/19 8:43 AM, Stefan Brankovic wrote:
> > In previous implementation, invocation of TCG shift function could requ=
est
> > shift of TCG variable by 64 bits when variable 'sh' is 0, which is not
> > supported in TCG (values can be shifted by 0 to 63 bits). This patch fi=
xes
> > this by using two separate invocation of TCG shift functions, with maxi=
mum
> > shift amount of 32.
> >=20
> > Name of variable 'shifted' is changed to 'carry' so variable naming
> > is similar to old helper implementation.
> >=20
> > Variables 'avrA' and 'avrB' are replaced with variable 'avr'.
> >=20
> > Fixes: 4e6d0920e7547e6af4bbac5ffe9adfe6ea621822
> > Reported-by: Paul Clark <pc@us.ibm.com>
>=20
> Preferred: "Paul A. Clarke" (for historical consistency)
>=20
> > Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > Suggested-by: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> > Signed-off-by: Stefan Brankovic <stefan.brankovic@rt-rk.com>
>=20
> Applying this patch on top of dce5a787c05fe1a3e54d92871cdeba2af6798e0d el=
iminated the failures that I reported in https://bugs.launchpad.net/qemu/+b=
ug/1841990 associated with vsl/vsr.
>=20
> Tested-by: Paul A. Clarke  <pc@us.ibm.com>

I've applied this to ppc-for-4.2, adjusting the Reported-by line as
suggested above.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--CEUtFxTsmBsHRLs3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2ZOckACgkQbDjKyiDZ
s5IYFw//WwMUTiPvSB32MjmLgVl9ePyWhkSTM9SA9f29A2puRJ2ea+OhmpCWnDc8
SP/1wjLw9gNyYtL+2uO2UmCZreu8fkFjYtISRyHGsShfCXyfv4qySePfQB3o49Oo
9tMYo7oK+tzZxmbrLmp/4flIwzdwGuneCLGSzhGoVpNBdVK8WFKf9LpPNWFcNjmo
hYgFjCvVpjxtb/pCaMa5G634N0OyyVIxlyWnwFN78316q12PgzVURKh0KxjaHahM
R9G0vzNyxaYFL+ck7WvKyIwlafs2g7NISHftYgVW75MM5/j2TKp87VKOb2xqbKOh
+ucZg+x35oaqFRrrjT5J9Zzn2umiSIMKSMeNgPKrzC2HbftzdjD90wszx2aC0dtd
vbKd6r83mODoAxCIBPmkvFOtMQYlJReWTXL8xX6l8EEAvPg057ApfEopI1NwNT3W
dzvr2P87LP3zYUNChpHk8wtnFVHUgPPQGbdXoGcUy8lEIhdS3P2E5Qr2aU/an5ax
Bl/a3ndH6JMEl0Sg+S+quZdoiu6fDj2c+HbLgyJ5wbOEaOt5bJI7+ad8yrO0wdiF
zUzuXUrruHDDPNp6xWS5PCzzJgIb4TaP+V2KyAFcIEqozaTq6MtJjKqHcFZTR2Q8
RjHydHWOhvEPW9NjHDkbLqY0BfmdCKujt2d3s9B6YBbkYXSIDlA=
=iG/v
-----END PGP SIGNATURE-----

--CEUtFxTsmBsHRLs3--

