Return-Path: <SRS0=g5aJ=2O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECAFC2D0D2
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2019 05:37:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1D5920706
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2019 05:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Qe/72tF0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1D5920706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijcsx-0002uc-1x
	for qemu-devel@archiver.kernel.org; Tue, 24 Dec 2019 00:37:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34303)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ijcs2-0001yi-RB
 for qemu-devel@nongnu.org; Tue, 24 Dec 2019 00:36:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ijcs1-0003ZG-AO
 for qemu-devel@nongnu.org; Tue, 24 Dec 2019 00:36:38 -0500
Received: from ozlabs.org ([203.11.71.1]:37587)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ijcs0-0003Km-8R; Tue, 24 Dec 2019 00:36:37 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47hlMK6x5bz9sPh; Tue, 24 Dec 2019 16:36:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1577165789;
 bh=intfF2AeYZ+3YDeDwDLzDnNODZWxGx0IeRPoMxjrZWc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Qe/72tF06tTJd6RJDZZLvlsnRO9UZuKCLPRPY4q8HZWB44WdapKErX67hp0PT+p/S
 FH/mC725j9+bqhBEcddaLAtOk2ShRAUPqTyXgztU3/sZGAAXdNpZupJWBb4kPAGz/p
 WM+Xr1LD869PII5ROrMo3vNCAOxvozUHbqqfAVJU=
Date: Tue, 24 Dec 2019 16:10:45 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>
Subject: Re: [PATCH] target/ppc: fix memory dump endianness in QEMU monitor
Message-ID: <20191224051045.GJ38380@umbus.modem>
References: <20191219163854.8945-1-maxiwell@linux.ibm.com>
 <20191223063043.GH38380@umbus.modem>
 <20191223213530.m4thca35liyjlsln@maxibm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HcccYpVZDxQ8hzPO"
Content-Disposition: inline
In-Reply-To: <20191223213530.m4thca35liyjlsln@maxibm>
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, farosas@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--HcccYpVZDxQ8hzPO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 23, 2019 at 06:35:30PM -0300, Maxiwell S. Garcia wrote:
> On Mon, Dec 23, 2019 at 05:30:43PM +1100, David Gibson wrote:
> > On Thu, Dec 19, 2019 at 01:38:54PM -0300, Maxiwell S. Garcia wrote:
> > > The env->hflags is computed in ppc_cpu_reset(), using the MSR register
> > > as input. But at the point ppc_disas_set_info() is called the MSR_LE =
bit
> > > in env->hflags doesn't contain the same information that env->msr.
> > >=20
> > > Signed-off-by: Maxiwell S. Garcia <maxiwell@linux.ibm.com>
> > > Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
> >=20
> > I think the change is ok as far as it goes but,
> >=20
> > a) the commit message should expand on what the practical effect of
> > this is.  Looking, I think the only thing this affects is DEBUG_DISAS
> > output (i.e. very rarely) which is worth noting.
>=20
> Ok, I will do that. I got this bug using the 'x/i' command on QEMU
> monitor with a LE guest.

Ok.

> > b) AFAICT this is the *only* thing that looks for the LE bit in
> > hflags. Given that, and the fact that it would be wrong in most cases,
> > we should remove it from hflags entirely along with this change.
> >=20
>=20
> I was changing the code to remove this LE bit from hflags and I found the
> function 'helper_store_hid0_601()' in misc_helper.c, which manipulates the
> 'hflags'. The commit 056401eae6 says:
>=20
> "Implement PowerPC 601 HID0 register, needed for little-endian mode suppo=
rt.
> As a consequence, we need to merge hflags coming from MSR with other ones.
> Use little-endian mode from hflags instead of MSR during code translation=
=2E"
>=20
> So, is the 'hflags' necessary here? Can we use MSR instead of hflags to
> change the endianness in this function?

That function alters the LE bit in hflags, but doesn't read it.
*Nothing* reads it, so none of the places that alter it matter.

I strongly suspect we won't properly honour the LE bit in the 601 HID
register, but that's already the case.  I also suspect it's far from
the only way in which 601 emulation is broken.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HcccYpVZDxQ8hzPO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4BndIACgkQbDjKyiDZ
s5KYig/+Mg2CCs+oD4fiUxbsDeRK6C2WMRZPJopRVaWvn3nLzvE/FVyy99NG+k/v
hMfJZU0J8ruHKx+VLJny0GqkmU9SR0DU/+LiKseYUtpKKY2rRltVoJb5t1mk1Xzg
JaL8VJ/FJV+NkuAEQTeYXMKo7rXZBkbfFlJwED1mE+NXTOaAnzJ5fzKr8lVPNlfi
vIJ9dHqc4eqnjx+l1FwSJ+VIcDFp3zHrvSGAFXqCIXdtUG5lCKZeEqKXNfmluCsI
fIkPqzhJxv01rZ0P4SstHraAQ2UNA5/3GaHsP2J8oPXWWooEU7l9FHEEIA/Xy/2f
FFmDfIq6X892viLxljwf7RWjUN1cDyRBVvJDCM/G31wIcbRUbTCjFN2EijjlWP8p
NNXHzPzE2/mv/a96YE0H6yQdMaejnz+Qh1FlIzLQbBkJH1Db6YhyBvxKRjNbVdqa
fV+LoIwbR7tkNqtpK5WQWSjaQ8ZtE3rqX+tSZNiN5M2OdPPppuk0maKV8oxvzvJX
SXr3f17LWdbbTQL9K1m5Uvs8CFPNJMEuau1YZxnMk6IxYLntj6QSjzVQpk24Vz8n
VRGK6kHp7D20DusyC+UUqAfFbuPn9PgN0NLmibD1SpV0IdaiRY7YfXxUUPLjGa+v
+mZATgTa4VW94mcU3egZVxaIJzETahuCr4l+dApxSsnxaV8i2s0=
=40nG
-----END PGP SIGNATURE-----

--HcccYpVZDxQ8hzPO--

