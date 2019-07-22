Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16E3C76190
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 10:57:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C445E21926
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 10:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="M1nmoEGn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C445E21926
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpW0X-0002gk-JQ
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 06:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40782)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hpW09-0001XC-0b
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 06:57:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hpW07-0007Sa-MY
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 06:57:04 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:60665)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hpW06-0007Mn-BI; Mon, 22 Jul 2019 06:57:03 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45sdpg08qqz9s8m; Mon, 22 Jul 2019 20:56:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563793019;
 bh=pqwCJALz8HxF200XIYmd6qOZCf3GbMaYvOTWhX2YkFs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=M1nmoEGngvD0zqyvPVeBp9nBe2kbK9KqIjJuiYO58lofZDPRm3oLPiAR2gEG66Rye
 6uB5WCvlUKEkML+TR+fFpXcnpyuLis3cVPGKy+uR+aUZ88VyMpQdlLntNN9DrrRu4t
 5PGHjOJtmmtbmUvbxq8wIIPCEOwEsIzLoC4azwEE=
Date: Mon, 22 Jul 2019 18:32:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Message-ID: <20190722083238.GC25073@umbus.fritz.box>
References: <20190718054218.9581-1-joel@jms.id.au>
 <20190718061628.GM8468@umbus.fritz.box>
 <215c832d-779c-1597-02af-3a3a52e19f01@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="c3bfwLpm8qysLVxt"
Content-Disposition: inline
In-Reply-To: <215c832d-779c-1597-02af-3a3a52e19f01@kaod.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH] ppc/pnv: update skiboot to v6.4
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
Cc: qemu-ppc@nongnu.org, Joel Stanley <joel@jms.id.au>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2019 at 03:03:09PM +0200, C=E9dric Le Goater wrote:
> On 18/07/2019 08:16, David Gibson wrote:
> > On Thu, Jul 18, 2019 at 03:12:17PM +0930, Joel Stanley wrote:
> >> Currently we fail to boot a qemu powernv machine with a Power9
> >> processor:
> >>
> >>  PLAT: Detected generic platform
> >>  PLAT: Detected BMC platform generic
> >>  CPU: All 1 processors called in...
> >>  CHIPTOD: Unknown TOD type !
> >>  CHIPTOD: Failed ChipTOD detection !
> >>  Aborting!
> >>
> >> With v6.4 we can boot both a Power8 and Power9 powernv machine.
> >>
> >> Built from submodule with powerpc64le-linux-gnu-gcc (Debian 8.3.0-2).
> >>
> >> Signed-off-by: Joel Stanley <joel@jms.id.au>
> > Applied to ppc-for-4.2, thanks.
> >=20
> > If you could add both POWER8 and POWER9 smoke tests to
> > boot-serial-test that would be even better.
>=20
> There is one for POWER8 and adding an extra for POWER9 results
> in a test conflict. So I came up with the patch below. Would that
> be OK ?

Ugh.  This name mangling is pretty ugly.  It would be neater to extend
the table format to have cpu explicitly and base the test names on
that, rather than special casing powernv.

But...

It occurs to me the reason we're hitting this is that for the other
systems represented here, the exact cpu model is really just a
detail.  It's not for us, because the whole system is substantially
different for the two cpus.

Which says to me that tbe POWER8 and POWER9 systems should really be
different machine types, not lumped together in "powernv" which then
has a heap of conditionals on the cpu family.  If we do that, the
problem here goes away.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--c3bfwLpm8qysLVxt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl01dKYACgkQbDjKyiDZ
s5IV1g//R5uTeYfKf9UivTqR1BUzqpnJbgBplWSE6x6OcdNlxQMQ0VheiPKLwi4q
SbQJScUw+0D4ZoGjZd2lxXO7yhzoketu+HkOZNOUD4B1jFRA04KhMzno2HigWW3h
L8tfp+D9DVqhOwCEq/GpuVIt4zioYwbuMsP56Eax3Qvrry5t191zF9KNCZg9ZH3N
TFkeTxUktTqw7fodMFT5jkl82QIJ1XcsO22/dCYQPmOOprF5w9vB/alTTf2Vl8+Z
JRWpBR+QFo4GDkuTc0EGA/8dVvvGRmwKPSExtKHCotRxXEkojlMaELEq8wYeuONk
qSRJR/TRmQXOxvGVuSkciZotKQJxKQqn4f2EI4vZ0lu9lTz3M8Wg7sSkVLhg6F/8
bgSJJrzkMgSNT2hb1iUaZXuqn3OSNN9QeYs06Bl/RSF09//eqcHwsMgndil2NaGa
r0PLAceG+F3GbTfGqbcy0ygM8nEXTjrjKhNRobbWdm5sHhIJ68fRbTG/v9mC29Dc
UwVSe+lDuV/huaGDdkhyOxR6L63b2ls2IVKMyaKHM1IbJtAcwSDJzCF7yfIRSjdA
bBnQt5L/x7ga08/5GsetkXUlCgdgjGTHQPTA1IGFd0mLUKuHpwCR4ms/1GaKuTkM
4gD2xgja9ACcRk29/xhGlRCRRuphW3B66lTGoAb1pri9DHLvUaI=
=3seM
-----END PGP SIGNATURE-----

--c3bfwLpm8qysLVxt--

