Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAD1C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 23:56:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67B2F204FD
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 23:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="liqtTUGv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67B2F204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i37ny-0005Pg-IE
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 19:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57803)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i37mh-0004GJ-EK
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 19:55:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i37mf-0004tZ-0U
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 19:55:26 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:58643 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i37mc-0004sg-FA; Wed, 28 Aug 2019 19:55:24 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46JjKd6492z9sNk; Thu, 29 Aug 2019 09:55:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1567036517;
 bh=j4VpCu39YitrPy25JoNQnsvnpiCK8oQr8ZPmrSWfkII=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=liqtTUGvP00iacI17gO/DV2IzSgspI1VM521RXxXa9CJDnpf52Fa8yMCCzsxOsMUY
 Rw4r9kEVsFV2aaRRFpYqhDm45oziNE684yHtoltKTplyoCBKoFSiXIE1+T9KnevShc
 qg7Ju3fI/t7OZjfmusrx6vb5OaCEzv9JTw8Brfsg=
Date: Thu, 29 Aug 2019 09:28:58 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Laurent Vivier <lvivier@redhat.com>
Message-ID: <20190828232858.GA16342@umbus.fritz.box>
References: <1566401321-22419-1-git-send-email-pc@us.ibm.com>
 <20190821225601.GG20890@umbus>
 <896ff2fb-a1b5-c22b-e195-a5054fb8d354@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
In-Reply-To: <896ff2fb-a1b5-c22b-e195-a5054fb8d354@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] ppc: Fix xsmaddmdp and friends
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
Cc: qemu-ppc@nongnu.org, "Paul A. Clarke" <pc@us.ibm.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2019 at 07:32:38PM +0200, Laurent Vivier wrote:
> On 22/08/2019 00:56, David Gibson wrote:
> > On Wed, Aug 21, 2019 at 10:28:41AM -0500, Paul A. Clarke wrote:
> >> From: "Paul A. Clarke" <pc@us.ibm.com>
> >>
> >> A class of instructions of the form:
> >>   op Target,A,B
> >> which operate like:
> >>   Target =3D Target * A + B
> >> have a bit set which distinguishes them from instructions that operate=
 as:
> >>   Target =3D Target * B + A
> >>
> >> This bit is not being checked properly (using PPC_BIT macro), so all
> >> instructions in this class are operating incorrectly as the second form
> >> above.  The bit was being checked as if it were part of a 64-bit
> >> instruction opcode, rather than a proper 32-bit opcode.  Fix by using =
the
> >> macro (PPC_BIT32) which treats the opcode as a 32-bit quantity.
> >>
> >> Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
> >=20
> > Applied to ppc-for-4.2, thanks.
>=20
> David,
>=20
> could you add:
>=20
> Fixes: c9f4e4d8b632 ("target/ppc: improve VSX_FMADD with new GEN_VSX_HELP=
ER_VSX_MADD macro")
>=20
> Reviewed-by: Laurent Vivier <lvivier@redhat.com>
> Tested-by: Laurent Vivier <lvivier@redhat.com>

Done, thanks.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1nDjgACgkQbDjKyiDZ
s5K/8A//Sf3udhM0Qo2EooVJyPKZwQrZmwjTHJnTeELh1s1ICwcT22c9UNSfu3QQ
nxDmYxxBWSlpD2UcAo8GAz1DKE4sqYY21cojbn1kz6e277YkGK1NB9kAkxoIoxeq
JjPYPVLOZ3GLCHbBCDbWy4AMXVB3OE4Z13w9QjJFnpX54O84tYkXPfPdm6ByqEwa
nOcNUKY3cZNT3RF7ntf8XsMEq/CW8BL9pwA7oSff72t93emoB3aWuDjq8M6bzaJw
zL5EQphG2rAgbxJ3Y3cRoP+xaOp++pNoFEsVM+PeWJfEscTMTbcf6u29j3ALJIbs
CO38jQNAW0mVXCRsWorl4l8aUf8O9H70rvI2eykYAvoO14tuoc/r52bMmgURxQY3
I1kN/okL/1C1GB/6Uv2aVbfnmKkECVZ+3vhLLybuCsqttarMJAMIfCNDhkryejOZ
AE5zqjMjOrDL3htO3hzjlQicQwqwLVCqx+DOJEasTqmBNuJS8w0YRrzLQpIKu+YK
aXqnyuTkUKnRuyv8HO0sBKxxxjbPozRAbiC0Y8ls5Nt4Kw553p/qj85cfHrVGByU
ychy59VTnYaU/PpU9TEa3eonyPNHH0tZHDBujP19ECSEM22QjehY+9MZDqS6qc0m
gJyHxyazGJFwj/OTQjPLgXDiSPcx+WysnHn6W4Rxhvq6EijNxRU=
=EGXM
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--

