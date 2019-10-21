Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBDACA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 06:07:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F33A2084B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 06:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ob05M4jo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F33A2084B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMQrG-0005SB-8E
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 02:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39872)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iMQqN-000506-6H
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 02:07:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iMQqL-0005w7-Lz
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 02:07:02 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:35487 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iMQqK-0005uz-Jc; Mon, 21 Oct 2019 02:07:01 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46xR411tt6z9sP3; Mon, 21 Oct 2019 17:06:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1571638017;
 bh=mA3H37+gRrU4nXtrSVxoBqJD+aBNEundMIhbFYPf9IU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ob05M4jownZ2x4L9ir/jY+mTony7CtGTDVDK/uBJG5cDwQ+2WSgR0yTPsxyJJzx8k
 7bM3OCtwTMTPX5Hp0iT7NPF164Zf/HxkJ7xdI41eBwVaRHQh9+FQv/cGZ+1Eluejw2
 PFljSYXzunzXi8FhImBN/uQ7dRyEDtLfauqhi0V8=
Date: Mon, 21 Oct 2019 16:34:39 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: qemu/powernv: coreboot support?
Message-ID: <20191021053439.GA6439@umbus.fritz.box>
References: <20191018172622.kz4smemh5cwesfit@proprietary-killer>
 <21ba3404-dcd3-fe06-7725-d58e249f9fd2@kaod.org>
 <20191019153108.gkupn3tnihspq7th@proprietary-killer>
 <1cbd1882-15c8-5471-cd65-1c84c2920ba8@kaod.org>
 <20191019160933.fizoc6tpu5jday4o@proprietary-killer>
 <20191020062842.GI1960@umbus.fritz.box>
 <0a7cbd9b-2c46-259d-4e0d-9084ee2875a3@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <0a7cbd9b-2c46-259d-4e0d-9084ee2875a3@kaod.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: "Marty E. Plummer" <hanetzer@startmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 20, 2019 at 08:51:47AM +0200, C=E9dric Le Goater wrote:
> On 20/10/2019 08:28, David Gibson wrote:
> > On Sat, Oct 19, 2019 at 11:09:34AM -0500, Marty E. Plummer wrote:
> >> On Sat, Oct 19, 2019 at 05:53:12PM +0200, C=E9dric Le Goater wrote:
> >>> On 19/10/2019 17:31, Marty E. Plummer wrote:
> >>>> On Sat, Oct 19, 2019 at 03:46:59PM +0200, C=E9dric Le Goater wrote:
> >>>>> On 18/10/2019 19:28, Marty E. Plummer wrote:
> >>>>>> Hello,
> >>>>>>
> >>>>>> First off, thank you for the work you've done on the ppc64 support=
, it
> >>>>>> has been very useful. I'm currently working on a coreboot port for=
 the
> >>>>>> talos ii line of systems (which means more ppc64 support, support
> >>>>>> specifically for the power9 sforza chip, and specific mainboard su=
pport.
> >>>>>> My plate is very full lol) and have been using qemu to debug the
> >>>>>> bootblock.
> >>>>>>
> >>>>>> It has been very useful for that, but I'm now at the point where I=
 need
> >>>>>> to jump to romstage, and that's where it gets tricky. qemu parses =
the rom
> >>>>>> image and looks for a ffs header, locates skiboot on it, and jumps=
 straight
> >>>>>> to that. Not exactly ideal for debugging something not produced fr=
om op-build.
> >>>>>
> >>>>> yes. I suppose you are using my branch powernv-4.2 which adds PNOR =
support
> >>>>> and a way to boot directly from PNOR. In that case, QEMU parses the=
 PNOR
> >>>>> file to extract the PAYLOAD partition (skiboot). skiboot also detec=
ts the
> >>>>> flash and extract the kernel and initramfs from the PNOR.
> >>>>>
> >>>>> However, you can bypass all this internal boot process by simply pa=
ssing
> >>>>> a -bios option and not passing a MTD device.
> >>>>>
> >>>> Doing so gives me the following error:
> >>>> qemu-system-ppc64: Could not load OPAL firmware 'build/coreboot.rom'
> >>>> (this is after I patched the 4mb size limit up)
> >>>
> >>> Could you make that rom available ?=20
> >>>
> >> Sure, I think. Not sure about how sending files works in my current ma=
il
> >> client but will see. Its more or less a 'stock' (as stock as can be for
> >> a new coreboot target) coreboot.rom file, but I've added some logic in=
to
> >> the build to fake a pnor ffs header at the end in order to trick hostb=
oot
> >> bootloader into loading it.
> >=20
> > Ok.  Note that the qemu emulated machine doesn't model the hardware
> > right down to the level of hostboot.  That's wy we're just loading
> > skiboot and jumping straight into it usually.  I guess clg's stuff to
> > load pnor images gets us a little closer to the hardware behaviour,
> > but I think it's still only a rough approximation.
>=20
> It's really tied to the OpenPOWER firmwares using the HIOMAP protocol
> to discuss with the BMC and load the flash. We could loosen how QEMU=20
> interprets the MTD device and use a property to inform QEMU that this
> is an OpenPOWER  PNOR file and that skiboot and can be loaded from it.
> Something to discuss.

Right.  I'm guessing one significant issue here is that to fully model
the BMC, with *its* firmware and comms channels with the main host
would be quite a lot of work, hence cheating a bit to bypass that.

> I have applied this small hack to load larger -bios files :
> =20
> --- qemu-powernv-4.2.git.orig/hw/ppc/pnv.c
> +++ qemu-powernv-4.2.git/hw/ppc/pnv.c
> @@ -58,7 +58,7 @@
> =20
>  #define FW_FILE_NAME            "skiboot.lid"
>  #define FW_LOAD_ADDR            0x0
> -#define FW_MAX_SIZE             (4 * MiB)
> +#define FW_MAX_SIZE             (64 * MiB)
> =20
>  #define KERNEL_LOAD_ADDR        0x20000000
>  #define KERNEL_MAX_SIZE         (256 * MiB)
>=20
> and coreboot.rom loads and boots and loops.
>=20
>=20
> You can use -d exec,in_asm to check what's going on.
>=20
>=20
> C.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2tQ2wACgkQbDjKyiDZ
s5KdpBAAnLR+sJskFRcsT9sUGTF1Kr5L+wIvEjKTVH+XKIZk6HseJfStCESwEgK/
ux0+oI+L30jTlBI7nblziOSd91fga+m5WtmKIyvl4/4yuJzpBR3rZTmy3wp1+92X
W2uDHLJR5+LdnO5He1JKxNcI5C01HjFODGDXy14ah6ddJzuSVDgNcYbOPkkD640B
LIF8g4HwXrgJUtnweLbGmMmaegGT2Yz/umeP+nfSuSZ/mYo00ESJGTn96md+ZsLZ
V/0QZsdrdXFxDCFoFv625OypKLltHhOckA2sGvT8TW8ndYV5DV4MPoi3/FFLPMeS
KaTtNlrTRm6IG1Huo4uDSHZ4WX/5v7e/eeMy+tEYLcPVlhhrdsRDL9K55/2c7aqB
ztWGmDK/eyi0LT7hKq6qQ7Y87Ln6iYb4XqTZ0S17JAB2MpyYWSDqoWQy04MJ5sIF
9/nCrYgjIyKpSP3oBb231+/27TZ7ZCrk0VhzAF/nn7WX5ULeZcosMRx2VtJ0VNyG
GB1JyCyOGiPUHBUXwezZK4mtIqBhXUxE2wQCDSjr/Ds2liJrXuDKNl3f8rchiIEe
NTcvg0Gu1srMd1khAHYNVh/VwkELCsrCgCcFfCKwaCI1ebfpET14C29pFqC4R1W7
ic2hzibDznZIwTR1r8CWXFuZZWOGRFewdrYIeMecIry0ZtgSrYQ=
=Ip8l
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--

