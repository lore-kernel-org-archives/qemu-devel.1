Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7951FC4360C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 00:35:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C2D9207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 00:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="WjeYcSB0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C2D9207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJoKU-0000WS-Dl
	for qemu-devel@archiver.kernel.org; Sun, 13 Oct 2019 20:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60550)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iJoJV-0008Vj-JV
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 20:34:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iJoJT-0004bB-K0
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 20:34:16 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:43585)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1iJoJS-0004V6-7n
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 20:34:15 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46s01C5YVBz9sPc; Mon, 14 Oct 2019 11:34:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1571013247;
 bh=unSNat3C/H46B9BUK+HSTqVx+MJqj06rb450Ha0csKA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WjeYcSB0ztu1XijRYz1UhIBz5mxTe3iujAcHMim1zUu0UuduW2ksbJpfg38FOKD63
 VixJQU39ad8D7xHUKuT3Fqo4I+uL2S+a0yzGAaEfz8Y53x6BVwTqkDRD38JW7S6bBB
 luUqwE8zT4KabUbVlBFTBFdoA5FIiJV/9V5sEbrU=
Date: Mon, 14 Oct 2019 11:25:01 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v7 00/22] tcg/ppc: Add vector opcodes
Message-ID: <20191014002501.GL4080@umbus.fritz.box>
References: <20190930202125.21064-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NPWyolIJAVLYbHY6"
Content-Disposition: inline
In-Reply-To: <20190930202125.21064-1-richard.henderson@linaro.org>
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
Cc: mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org,
 amarkovic@wavecomp.com, hsp.cat7@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--NPWyolIJAVLYbHY6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Uh.. do you want me to merge this?  Probably best to CC me if you
do.. otherwise I'm likely to miss it.

On Mon, Sep 30, 2019 at 01:21:03PM -0700, Richard Henderson wrote:
> Changes since v6:
>   * The have_foo tests have been split so that VSX is not
>     combined with ISA revision.
>   * The power{7,8,9} patches have been split by isa extension.
>   * Force the [TABC]X bits on within the VSX instruction defines,
>     making the usage of the VSX insns clearer, since we have no
>     additional or'ing of seemingly random bits.
>=20
> Changes since v5:
>   * Disable runtime altivec detection until all of the required
>     opcodes are implemented.
>     Because dup2 was last, that really means all of the pure altivec
>     bits, so the initial patches are not bisectable in any meaningful
>     sense.  I thought about reshuffling dup2 earlier, but that created
>     too many conflicts and I was too lazy.
>   * Rearranged the patches a little bit to make sure that each
>     one actually builds, which was not the case before.
>   * Folded in the fix to tcg_out_mem_long, as discussed in the
>     followup within the v4 thread.
>=20
> Changes since v4:
>   * Patch 1, "tcg/ppc: Introduce Altivec registers", is divided into
>     ten smaller patches.
>   * The net result (code-wise) is not changed between former patch 1
>     and ten new patches.
>   * Remaining (2-7) patches from v4 are applied verbatim.
>   * This means that code-wise v5 and v4 do not differ.
>   * v5 is devised to help debugging, and to better organize the code.
>=20
> Changes since v3:
>   * Add support for bitsel, with the vsx xxsel insn.
>   * Rely on the new relocation overflow handling, so
>     we don't require 3 insns for a vector load.
>=20
> Changes since v2:
>   * Several generic tcg patches to improve dup vs dupi vs dupm.
>     In particular, if a global temp (like guest r10) is not in
>     a host register, we should duplicate from memory instead of
>     loading to an integer register, spilling to stack, loading
>     to a vector register, and then duplicating.
>   * I have more confidence that 32-bit ppc host should work
>     this time around.  No testing on that front yet, but I've
>     unified some code sequences with 64-bit ppc host.
>   * Base altivec now supports V128 only.  Moved V64 support to
>     Power7 (v2.06), which has 64-bit load/store.
>   * Dropped support for 64-bit vector multiply using Power8.
>     The expansion was too large compared to using integer regs.
>=20
> Richard Henderson (22):
>   tcg/ppc: Introduce Altivec registers
>   tcg/ppc: Introduce macro VX4()
>   tcg/ppc: Introduce macros VRT(), VRA(), VRB(), VRC()
>   tcg/ppc: Create TCGPowerISA and have_isa
>   tcg/ppc: Replace HAVE_ISA_2_06
>   tcg/ppc: Replace HAVE_ISEL macro with a variable
>   tcg/ppc: Enable tcg backend vector compilation
>   tcg/ppc: Add support for load/store/logic/comparison
>   tcg/ppc: Add support for vector maximum/minimum
>   tcg/ppc: Add support for vector add/subtract
>   tcg/ppc: Add support for vector saturated add/subtract
>   tcg/ppc: Support vector shift by immediate
>   tcg/ppc: Support vector multiply
>   tcg/ppc: Support vector dup2
>   tcg/ppc: Enable Altivec detection
>   tcg/ppc: Update vector support for VSX
>   tcg/ppc: Update vector support for v2.07 Altivec
>   tcg/ppc: Update vector support for v2.07 VSX
>   tcg/ppc: Update vector support for v2.07 FP
>   tcg/ppc: Update vector support for v3.00 Altivec
>   tcg/ppc: Update vector support for v3.00 load/store
>   tcg/ppc: Update vector support for v3.00 dup/dupi
>=20
>  tcg/ppc/tcg-target.h     |   51 +-
>  tcg/ppc/tcg-target.opc.h |   13 +
>  tcg/ppc/tcg-target.inc.c | 1118 +++++++++++++++++++++++++++++++++++---
>  3 files changed, 1101 insertions(+), 81 deletions(-)
>  create mode 100644 tcg/ppc/tcg-target.opc.h
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NPWyolIJAVLYbHY6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2jwFoACgkQbDjKyiDZ
s5IvIRAAlVKVrb89Ebnu0hUNBcgXJOSF6+upNEpFKeu2eAS1G8jaM4SfgKJ+L9ZC
zOSR+plnHkV30LMwdClpeLR04oveHPgV3d8hSZkFjFRHwOH2z74zYikG3mA+zAbl
Tm+P6oXxJFN9wPsZx+iS8+qwo+gtC0DLHq6GbUAw2YahIji0iPuGkrOs8y6gRsnr
k56Zy5ifsrA9/zPkhkFtmVuTj7lI00PosGmEPpZvNV70b6vgEUgjRq9548IXXWBX
ok+VK1Pt0gGmNkswj/vzBT77QkBkVXu8edQBW4fEGxkmI9/Epkpxbcox+SMNOgkz
BCqkkV6HJIy4FrAleZTltaqZCO6L9p8qp2Mst9X6jgazx9reRgyfg0XAKkDCDTri
hNeB7um1vW2Xz4YnQjzWxkTgVLY/HjknbV3bicrPJdpGtdnVnWgiG62o0N2AGMW2
kmM6gIGyrNCQMMKGgze1K8sMhyvkjmm0qFSxN+dUjCvvll3K1B19uA99LLlrGmBZ
nsppj0lseJjFCTb2oAoYrrzI+s7MwjtdO5ZLSzLLrweMemioiDdv2ETTmgVU2XUL
HZ1XOS5cwW6EIRF0k3izSmrIR/A6nUx8U1ZJr6lZrNhmNndwKCEDJOOw47eBSxSF
RkhduKq1IbsYtyOfDWA9glQHQbNWZMgbK9W+rGdX1bNj7uzo/Lo=
=ud8X
-----END PGP SIGNATURE-----

--NPWyolIJAVLYbHY6--

