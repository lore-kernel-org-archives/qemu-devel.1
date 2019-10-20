Return-Path: <SRS0=HPkn=YN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9261DCA9EA0
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 06:36:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5613920679
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 06:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="FxypJSqH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5613920679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iM4or-0005m8-Fd
	for qemu-devel@archiver.kernel.org; Sun, 20 Oct 2019 02:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49895)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iM4nu-0004sW-QM
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 02:35:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iM4nt-0004WT-9E
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 02:35:02 -0400
Received: from ozlabs.org ([203.11.71.1]:44149)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iM4nr-0004UM-WA; Sun, 20 Oct 2019 02:35:01 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46wqkl5slrz9sPT; Sun, 20 Oct 2019 17:34:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1571553295;
 bh=Y9Kinyu4YS3CXYCcjqqh3GY7//daIEzxbjexgBgq9jM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FxypJSqHYzFoGm0MFS32niQBauQUO5rDbsyKLcCtHV8wAOYfhO2rH8rWgOcIJ/S+T
 d0uhQBTH0OQada92GkSRcCln7Hu06NHFgrAwq06J+b+oQbFi0DlIANrwv3JR+jZc3M
 f/JROmWf0voCGv6NS/cwWBHgdtdbmxS3qQvYuVIg=
Date: Sun, 20 Oct 2019 17:28:42 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Marty E. Plummer" <hanetzer@startmail.com>
Subject: Re: qemu/powernv: coreboot support?
Message-ID: <20191020062842.GI1960@umbus.fritz.box>
References: <20191018172622.kz4smemh5cwesfit@proprietary-killer>
 <21ba3404-dcd3-fe06-7725-d58e249f9fd2@kaod.org>
 <20191019153108.gkupn3tnihspq7th@proprietary-killer>
 <1cbd1882-15c8-5471-cd65-1c84c2920ba8@kaod.org>
 <20191019160933.fizoc6tpu5jday4o@proprietary-killer>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lqaZmxkhekPBfBzr"
Content-Disposition: inline
In-Reply-To: <20191019160933.fizoc6tpu5jday4o@proprietary-killer>
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
Cc: Joel Stanley <joel@jms.id.au>, qemu-ppc@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--lqaZmxkhekPBfBzr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 19, 2019 at 11:09:34AM -0500, Marty E. Plummer wrote:
> On Sat, Oct 19, 2019 at 05:53:12PM +0200, C=E9dric Le Goater wrote:
> > On 19/10/2019 17:31, Marty E. Plummer wrote:
> > > On Sat, Oct 19, 2019 at 03:46:59PM +0200, C=E9dric Le Goater wrote:
> > >> On 18/10/2019 19:28, Marty E. Plummer wrote:
> > >>> Hello,
> > >>>
> > >>> First off, thank you for the work you've done on the ppc64 support,=
 it
> > >>> has been very useful. I'm currently working on a coreboot port for =
the
> > >>> talos ii line of systems (which means more ppc64 support, support
> > >>> specifically for the power9 sforza chip, and specific mainboard sup=
port.
> > >>> My plate is very full lol) and have been using qemu to debug the
> > >>> bootblock.
> > >>>
> > >>> It has been very useful for that, but I'm now at the point where I =
need
> > >>> to jump to romstage, and that's where it gets tricky. qemu parses t=
he rom
> > >>> image and looks for a ffs header, locates skiboot on it, and jumps =
straight
> > >>> to that. Not exactly ideal for debugging something not produced fro=
m op-build.
> > >>
> > >> yes. I suppose you are using my branch powernv-4.2 which adds PNOR s=
upport
> > >> and a way to boot directly from PNOR. In that case, QEMU parses the =
PNOR
> > >> file to extract the PAYLOAD partition (skiboot). skiboot also detect=
s the
> > >> flash and extract the kernel and initramfs from the PNOR.
> > >>
> > >> However, you can bypass all this internal boot process by simply pas=
sing
> > >> a -bios option and not passing a MTD device.
> > >>
> > > Doing so gives me the following error:
> > > qemu-system-ppc64: Could not load OPAL firmware 'build/coreboot.rom'
> > > (this is after I patched the 4mb size limit up)
> >=20
> > Could you make that rom available ?=20
> >=20
> Sure, I think. Not sure about how sending files works in my current mail
> client but will see. Its more or less a 'stock' (as stock as can be for
> a new coreboot target) coreboot.rom file, but I've added some logic into
> the build to fake a pnor ffs header at the end in order to trick hostboot
> bootloader into loading it.

Ok.  Note that the qemu emulated machine doesn't model the hardware
right down to the level of hostboot.  That's wy we're just loading
skiboot and jumping straight into it usually.  I guess clg's stuff to
load pnor images gets us a little closer to the hardware behaviour,
but I think it's still only a rough approximation.

> > Thanks,
> >=20
> > C.=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--lqaZmxkhekPBfBzr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2r/poACgkQbDjKyiDZ
s5JOrhAA0t7ORYZwo4AhTgHq7deWPvzmUfM6w3Ll3ESO2TCtj2ubVJmbwCLDWsW0
HUFCxq859dRc20jf+8NEFNnXkm61RjsJKJRSgwGPD3tWd+lE08lK9XgJYStRMeS5
VvAlEqpTlHaQtoFcbGz5DIeCCgQbBqzfXc1hLuaBS4ellopogi5M8M4/CH28nO3A
8b/HJS6hgT4miDYlVSLUJtwoW65MyAjUzB/Ldj8K4nGvOia95L5reeGe8EwC+T5M
zo7QNnmiEo6kha1FiU1Y0jz+XbAanL00A5vIz8DZqJU/amgAs80yTBVr+o7XE5ho
Z+npa9MU9PP3POYts6aQtP/bf3vZMiN5j9MI/9+TpFaLRVTEasQK1tiGNMbn92ni
FtqGdHFhTxm69F4IZi4kZP3ZtLTPVRMlfWxPz9N+Bg8MCKzqWAdXrw6BjOOx8jKA
OO7WtU0i2+HGh5eY1QWwIn1fakv8hkgGoL+vHi67xpomiu1ZJatSAQp5K7Vcp6e7
3M89q1lX19eYjLYEwOp+SLSoCGsMzKyOSaWUHe8shtaoXHMH4lQ3edpFeGiDkjQg
6gkiiAj8IF5B1NA58Hj83CYsQI4sr+Z9By8FWZevoVBOjITpsQEQQ+wvdxBCAnnh
AdnXNudK3Ie0P6yr3H0H1XNLboeNk0tFc22RrsQ89qZ6mtV0OIs=
=sI1C
-----END PGP SIGNATURE-----

--lqaZmxkhekPBfBzr--

