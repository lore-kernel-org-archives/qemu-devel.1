Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C0CC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 02:24:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1D3B206A2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 02:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Kx+J8cN/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1D3B206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hggYs-0005Kl-0n
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 22:24:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53986)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hggXG-000406-CU
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 22:22:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hggXE-0001g3-Hl
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 22:22:46 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:35709 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hggXC-00017U-6N; Thu, 27 Jun 2019 22:22:43 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45ZgX33Lf7z9sN6; Fri, 28 Jun 2019 12:22:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1561688547;
 bh=eWBGQay8qbxpNg6Oc5IHuiAQvx5AvUW+IA7xBlypRiM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Kx+J8cN/JTVmUQ9uPeJDpXhE7KBFjy3b2GKUANJV1iDZ/lSIi+AE+5v/5cVwhm5dK
 xj1XGFPw8U8q0YSNEHYSuXmJrGN9ZDlE1om8IBoiaW0MuP5giRjv1bfqndxl+0PPb8
 ttioXxLoabnALej4NPjFvtYDaHs0bG//xtI/Eh1U=
Date: Fri, 28 Jun 2019 12:19:02 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20190628021902.GD3340@umbus.fritz.box>
References: <20190616123751.781-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+KJYzRxRHjYqLGl5"
Content-Disposition: inline
In-Reply-To: <20190616123751.781-1-mark.cave-ayland@ilande.co.uk>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v3 00/15] target/ppc: remove
 getVSR()/putVSR() and further tidy-up
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
Cc: gkurz@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--+KJYzRxRHjYqLGl5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 16, 2019 at 01:37:36PM +0100, Mark Cave-Ayland wrote:
> With the conversion of PPC VSX registers to host endian during the 4.0 de=
velopment
> cycle, the VSX helpers getVSR() and putVSR() which were used to convert b=
etween big
> endian and host endian (and are currently just a no-op) can now be remove=
d. This
> eliminates an extra copy for each VSX source register at runtime.
>=20
> Patches 1-3 do the elimination work on a per-file basis and switch VSX re=
gister
> accesses to be via pointers rather than on copies managed using getVSR()/=
putVSR().
>=20
> After this patches 4-14 change the VSX registers to be passed to helpers =
via pointers
> rather than register number so that the decode of the vector register poi=
nters occurs
> at translation time instead of at runtime. This matches how VMX instructi=
ons are
> currently decoded.
>=20
> Finally patch 15 performs some related tidy-up around VSX_FMADD which dec=
odes the
> a or m form at translation time, allowing a single helper function to be =
used for
> both implementations.
>=20
> Greg: I've added you as CC since you managed to find a bug in my last ser=
ies. This
> one is much more mechanical, but if you are able to confirm this doesn't =
introduce
> any regressions in your test images then that would be great.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>

I've now applied the rest of this series to my ppc-for-4.1 tree.


> v3:
> - Rebase onto master
> - Add latest R-B tags from Richard
> - Fix zero init in helper_xvxsigsp() in patch 1
> - Preserve order of do_float_check_status() in helper_xsrqpi() in patch 1
> - Remove accidental write after store in VSX_STXVL() macro, and also just=
 use
>   the xt pointer directly in patch 2
>=20
> v2:
> - Rebase onto master
> - Use working copy of VSX destination registers in patches 1-3 to keep cu=
rrent
>   semantics where src =3D=3D dest and exception handling
> - Add patches 4 and 6 to split out helper functions still requiring an op=
code
>   parameter
> - Remove opcode parameter from GEN_VSX_HELPER_X3 and GEN_VSX_HELPER_X2 as=
 it
>   isn't required for the common case
> - Drop VSX_TEST_DC improvement patch since it is no longer applicable wit=
h the
>   removal of opcode from the above macros
> - Rework VSX_MADD improvement patch to use a single helper for both a and=
 m
>   forms as suggested by Richard
>=20
>=20
> Mark Cave-Ayland (15):
>   target/ppc: remove getVSR()/putVSR() from fpu_helper.c
>   target/ppc: remove getVSR()/putVSR() from mem_helper.c
>   target/ppc: remove getVSR()/putVSR() from int_helper.c
>   target/ppc: introduce separate VSX_CMP macro for xvcmp* instructions
>   target/ppc: introduce GEN_VSX_HELPER_X3 macro to fpu_helper.c
>   target/ppc: introduce separate generator and helper for xscvqpdp
>   target/ppc: introduce GEN_VSX_HELPER_X2 macro to fpu_helper.c
>   target/ppc: introduce GEN_VSX_HELPER_X2_AB macro to fpu_helper.c
>   target/ppc: introduce GEN_VSX_HELPER_X1 macro to fpu_helper.c
>   target/ppc: introduce GEN_VSX_HELPER_R3 macro to fpu_helper.c
>   target/ppc: introduce GEN_VSX_HELPER_R2 macro to fpu_helper.c
>   target/ppc: introduce GEN_VSX_HELPER_R2_AB macro to fpu_helper.c
>   target/ppc: decode target register in VSX_VECTOR_LOAD_STORE_LENGTH at
>     translation time
>   target/ppc: decode target register in VSX_EXTRACT_INSERT at
>     translation time
>   target/ppc: improve VSX_FMADD with new GEN_VSX_HELPER_VSX_MADD macro
>=20
>  target/ppc/fpu_helper.c             | 841 ++++++++++++++++--------------=
------
>  target/ppc/helper.h                 | 320 +++++++-------
>  target/ppc/int_helper.c             |  26 +-
>  target/ppc/internal.h               |  12 -
>  target/ppc/mem_helper.c             |  25 +-
>  target/ppc/translate/vsx-impl.inc.c | 567 ++++++++++++++++--------
>  target/ppc/translate/vsx-ops.inc.c  |  70 +--
>  7 files changed, 952 insertions(+), 909 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--+KJYzRxRHjYqLGl5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0VeRYACgkQbDjKyiDZ
s5IaMxAAlewwuUR8wPBE+1QtnQZxO0ResNITUuhmveuJeaJv6hdy7XCo6uuovdq/
S5ZfsKbdk4ejSnYXtGapgTQ5MY9Hp68qob44JbniZGaMRedrArfxvzsIIS3+h2ka
YU8GYuOmwe/XDlUFbrVbulPCB4DeXIELIuPx9QkV+obUBpuR7ZrjosLZVhtrspRj
KWkiwS7JxLfKjYCV/CYPt02qND5WcrTO8UJ/WpbXwf0jxHQvrx3DRWG9T8xqXhEA
j5zc6JFKIcK03tQzeIyYNajfFMY5n7KqU1rMZ2MP+GfMe6Eyw3hOwMi7O1PcU96t
IQZerkHJ6ef92xzfFM55cW9tFi5PtHAvyUzHKl4dUtbEZE8xM4N7ILxjp2+RVbA3
/1JkNbphKlVCeGFEwcQ1buuV+96FSKinC/YXXiziAsYRkoupdr+0ijIxVQsWcF5M
ro0LxKlBWnog0vizQT2FLPHe+eGiNozLqRzZKRn6FsWfVKl6L3wdVF4VMKq9Vxl8
eLz38yCcrS/WjG3/IjRJIJJHOTXj/XacSI3P0f3aaWsfDArqH+cHUsDju5duCwp1
Lui4/S50fCh6/hekT0PEDXibcxa9aMgd7riJ90L5bX9eEo+hGSD4pwgMXrLmj+Wx
hcnRlkJkyazaVdMtmxUfTwAdXdrDZOkMbZ4msSGmVZG9MS/aLJ4=
=j3Ez
-----END PGP SIGNATURE-----

--+KJYzRxRHjYqLGl5--

