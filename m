Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766CCC31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 06:22:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42A3E206BA
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 06:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="I4qXoCSn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42A3E206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56994 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haweg-0001pK-00
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 02:22:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35864)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hawd0-0000vi-Dx
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 02:20:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hawcy-0003mv-ML
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 02:20:58 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:41819 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hawcx-0003kM-VL; Wed, 12 Jun 2019 02:20:56 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45NxZR1Z0nz9s9y; Wed, 12 Jun 2019 16:20:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1560320447;
 bh=8yXw5IcsvUIcIj5NL7Z/+YfCJ2JYdys13Fs1nkQgZGE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=I4qXoCSn88QPCa/NmSv+7emrzG0cOWvflKHfkMQytWMVkmE0RbjIegomIcr0jFHz7
 EoLJUF9J3E1aKShYqlpLuxMszhHUK7miA0jFDeu5GNJwh5OZb3avTV1PWHNEG9k/Qr
 uxrPClLkenR3RLWLCUzeTsgHWOsA4WwPKIc05n/8=
Date: Wed, 12 Jun 2019 16:11:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <20190612061103.GC26378@umbus.fritz.box>
References: <20190606040919.110655-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="E/DnYTRukya0zdZ1"
Content-Disposition: inline
In-Reply-To: <20190606040919.110655-1-aik@ozlabs.ru>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] spapr_pci: Advertise BAR reallocation capability
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
Cc: Shawn Anastasio <shawn@anastas.io>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--E/DnYTRukya0zdZ1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2019 at 02:09:19PM +1000, Alexey Kardashevskiy wrote:
> The pseries guests do not normally allocate PCI resouces and rely on
> the system firmware doing so. Furthermore at least at some point in
> the past the pseries guests won't even be allowed to change BARs, probably
> it is still the case for phyp. So since the initial commit we have [1]
> which prevents resource reallocation.
>=20
> This is not a problem until we want specific BAR alignments, for example,
> PAGE_SIZE=3D=3D64k to make sure we can still map MMIO BARs directly. For
> the boot time devices we handle this in SLOF [2] but since QEMU's RTAS
> does not allocate BARs, the guest does this instead and does not align
> BARs even if Linux is given pci=3Dresource_alignment=3D16@pci:0:0 as
> PCI_PROBE_ONLY makes Linux ignore alignment requests.
>=20
> ARM folks added a dial to control PCI_PROBE_ONLY via the device tree [3].
> This makes use of the dial to advertise to the guest that we can handle
> BAR reassignments.
>=20
> We do not remove the flag from [1] as pseries guests are still supported
> under phyp so having that removed may cause problems.
>=20
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/arch/powerpc/platforms/pseries/setup.c?h=3Dv5.1#n773
> [2] https://git.qemu.org/?p=3DSLOF.git;a=3Dblob;f=3Dboard-qemu/slof/pci-p=
hb.fs;h=3D06729bcf77a0d4e900c527adcd9befe2a269f65d;hb=3DHEAD#l338
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3Df81c11af
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Changing a guest visible property, that could have a big effect on how
the guest behaves, without a machine version change seems... unwise.

> ---
>  hw/ppc/spapr.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 6dd8aaac3340..84d16f9edaca 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1209,6 +1209,9 @@ static void spapr_dt_chosen(SpaprMachineState *spap=
r, void *fdt)
>          _FDT(fdt_setprop_string(fdt, chosen, "stdout-path", stdout_path)=
);
>      }
> =20
> +    /* We can deal with BAR reallocation just fine, advertise it to the =
guest */
> +    _FDT(fdt_setprop_cell(fdt, chosen, "linux,pci-probe-only", 0));
> +
>      spapr_dt_ov5_platform_support(spapr, fdt, chosen);
> =20
>      g_free(stdout_path);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--E/DnYTRukya0zdZ1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0Al3cACgkQbDjKyiDZ
s5KItQ/+MLVZunztm1w6YBLWvFT781/gEjdHlYcLTTHgG/UUot0WhDScmmnlyNKk
Uv8P3jNzztiXXbpNtw2HWwQTkjiftNkxNsEJSq2/1ycxs0Y2WRCzZLDxWgaPYaih
zCeYVA9/BhwmieBHtZJ54e+cG2cldO5wVlLv9LqBZiIS91UnDdWe1tzTmMk0lPm8
62bPYm18WM6TAW/glQau0yan44M80DuWm/cmNqfnFASTcaelfRlaF+ysvf2jssK1
EsImJH9r/54TspDRpKlheEA4bZiCSQUIiq0BbluMGrL0scyAVMJwJ/YGSmO7SCDT
mRxEa2idNUCGdhxyfqxhkxo1QPVRThHCg/kcp05Gkby7MNEQmdaZ69Zt++A7OKaC
f7I4mukNptOV3YAJj2lQ/PwL64LN7B1kM+T6kHw2T2NZnVwJ4OzElrq2Kw/S3A5d
J/zh7VAHbdjy74Mxq218n4KoahZrGssNuqUB1RD2dQAX9Su6dG/gd4OBk66Hf5Ab
mJtYb8y3FeBEKEQkzlgD00Y/MXe1+LTVb/lCg0IhP+9aI81rPvq7qxlpay9g7HCE
pS+PdlxHBJucrkmi6Ne037DiSYEsUQqY7nftX7m5maa39bXp84jP/obr9LIBLJsl
aX43HXOHcQgoSsEAQ0BggY/Ty1oWvllXHI+ME1tzxOdzwRMfTkQ=
=R/VX
-----END PGP SIGNATURE-----

--E/DnYTRukya0zdZ1--

