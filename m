Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DATE_IN_PAST_24_48,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C42C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 07:30:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 547D4206BF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 07:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="J48gOQFO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 547D4206BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37009 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqugC-0002AA-90
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 03:30:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37865)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hqufc-0000dh-FN
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 03:29:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hqufX-00055S-SL
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 03:29:39 -0400
Received: from ozlabs.org ([203.11.71.1]:56973)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hqufX-0004Yo-4s; Fri, 26 Jul 2019 03:29:35 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45w11J0HRMz9sBF; Fri, 26 Jul 2019 17:29:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1564126164;
 bh=BP+uvD7HjEup36Dg4X8ruWZdRh62v1XWUKKL0W1ff0c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=J48gOQFO1Qo6NsLt06C8IQwEHxa/qqNflYFdcQRxCUhlKIi+BPRZn3quhYzFxn0kR
 zMJwPnnJL/RON6wdsVqaRTTylPzxehdZeYbZYBxuzcDQCemz1PMIqD8d0VTs7FTu3l
 IymH0xi7Y9xKXo1lEh0/fNCiZGB5zPmdVBzcz5zc=
Date: Thu, 25 Jul 2019 13:26:29 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Amol Surati <suratiamol@gmail.com>
Message-ID: <20190725032629.GA28601@umbus>
References: <20190723090138.30623-1-clg@kaod.org>
 <20190724032308.GV25073@umbus.fritz.box>
 <0b80925b-c25b-04ee-2875-cbd155497a55@kaod.org>
 <20190724085730.GX25073@umbus.fritz.box>
 <20190724145504.GA29378@arch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
In-Reply-To: <20190724145504.GA29378@arch>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] ppc/pnv: Generate phandle for
 the "interrupt-parent" property
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
Cc: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2019 at 08:25:04PM +0530, Amol Surati wrote:
> On Wed, Jul 24, 2019 at 06:57:30PM +1000, David Gibson wrote:
> > On Wed, Jul 24, 2019 at 09:11:54AM +0200, C=E9dric Le Goater wrote:
> > > On 24/07/2019 05:23, David Gibson wrote:
> > > > On Tue, Jul 23, 2019 at 11:01:38AM +0200, C=E9dric Le Goater wrote:
> > > >> Devices such as the BT or serial devices require a valid
> > > >> "interrupt-parent" phandle in the device tree and it is currently
> > > >> empty (0x0). It was not a problem until now but since OpenFirmare
> > > >> started using a recent libdft (>=3D 1.4.7), petitboot fails to boo=
t the
> > > >> system image with error :
> > > >>
> > > >>    dtc_resize: fdt_open_into returned FDT_ERR_BADMAGIC
> > > >>
> > > >> Provide a phandle for the LPC bus.
> > > >>
> > > >> Suggested-by: Greg Kurz <groug@kaod.org>
> > > >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> > > >=20
> > > > I've applied this, since it looks to be correct.
> > > >=20
> > > > But.. can you connect the dots for me in how this being missing
> > > > results in a BADMAGIC error??
> > >=20
> > > Some binary called by petitboot segfaults when trying to kexec an ima=
ge on=20
> > > a system with a bogus DT (generated by QEMU). I don't know exactly wh=
ich one=20
> > > as I only see the error message above and the segv message in dmesg
> >=20
> > Ok, I'm still not seeing how that gets you to a BADMAGIC error.
>=20
> If I may interject, as this patch is related to the qemu bug:
> https://bugs.launchpad.net/qemu/+bug/1826827.
>=20
> The error is printed by dtc_resize in kexec.c from kexec-lite
> (antonblanchard/kexec-lite).
>=20
> There are two places where dtc_resize is called -
> (1) initialize_fdt, when kexec is passed a dtb file.
> (2) fdt_from_fs, when kexec must make dtc read /proc/device-tree to form
>     a dtb.
>=20
> If initialize_fdt is called with a file which is an invalid dtb, the
> dtc_resize prints the FDT_ERR_BADMAGIC error.
>=20
> Bug# 1826827 shows that dtc is one application that does
> crash, although through the firing of an assertion, in the absence of
> the mentioned properties. (fix to avoid the crash already checked into
> dtc upstream, commit 8f69567622; to be released with dtc-v1.5.1).
>=20
> Assuming that the crashing app (it is not known here what it is) is
> supposed to create a dtb for kexec, and its crash leaves behind an
> incomplete/invalid dtb file, the initialize_fdt might receive an invalid
> dtb.

Ok, thanks.  That's what I was after.

>=20
>=20
> Another possibility for that error exists within the fdt_from_fs function,
> but that needs a version of kexec-lite at least 5 years old, which is
> unlikely to be used here I guess.
>=20
>=20
>=20
> If this patch fixes both the crash and the error "dtc_resize: ....",
> it is likely that dtc (or anything else which depends on libfdt) was the
> cause of the crash, with dtc/libfdt version being < g8f69567622.
>=20
>=20
> Thanks,
> -amol
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl05IWIACgkQbDjKyiDZ
s5JbmBAA5WIZ3dvYe9uGdTfM/666Gca/3i12NMI5TqmN9dM9U/CE+6ZTpFTidioD
s5toKUoiwX7OFJu5KKiaqpCIIlG/bdqGx7u8WDAaeSNEdNfXynsknkDNhjcZK0+t
H5bdTYtkPazUSsQij255MGyiwNJ9TuSVOc2io6dlTgKFbixC59aPxH89yWWZOrme
PLXYD5S1lQAWzFPgVbhw1tLFs+YSgt1d5tYd3vpCbpV1KXnUn2+FFEqtVrHB+3ie
5i7SZvjDLQJKPZtAtj9CbI/YX5yoRu+qcB0U/18ESHJKNhOln30p+0wq63lDO8XQ
cCVsO8Q5CKsTiBCuVPJVr8HLvqxNWfVXk3HfLabf6gZNatQFZFBnaMoNHyPDaMvW
FSmC9juA4A9z54qZ9r+nV1miC/szMjkp3+pe4luVmzPVSqS5RIKYo9npzRx0RTVZ
QXGOEcEpXSXhhEDI97U8g8Mtz8UhH5p2sffeHQsQHZTXLPN3p/nVI6UWhbSyJGrQ
YYt71mMtvXz57sAl3wRHeALphaYgZzSvRJFSI9NdDmkBDSQDZtZxGJICJSbJJbdF
rCLsp7ejbCN55gE7TpSwaW8SAfkmIMgYbxCeJpW+r1jtJGJd+0bjWoqARNd1kIkj
IPRQcFwzWWuOSoUdBSWGngig2Pfj/0JC3Ft+/xEocupb0TVWjfs=
=MHRe
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--

