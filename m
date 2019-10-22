Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97A7CA9EB9
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 02:03:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 973212084C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 02:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="L/FHLw3q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 973212084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMjVx-0007Dz-P4
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 22:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41019)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iMjUn-0006V3-Vt
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 22:02:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iMjUm-0001gV-7b
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 22:02:01 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:44795 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iMjUk-0001ah-1R; Mon, 21 Oct 2019 22:02:00 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46xxZb3tbpz9sRX; Tue, 22 Oct 2019 13:01:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1571709703;
 bh=e2I9sBZ+x1szdJJZQMGL5t8/mew7cVag1kXy7FDhO0c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=L/FHLw3qaj3dNKQBJgydI8Qw3M+q50RH0scBAf5JOLhrUgh9BhfNKnTh29h5EpGWV
 hCisecwphHGWsNeYXYWbX1T+M7hXtKVLAN9OfNdUX61SPMfyOzcesmVD8NhSi1S5WQ
 e8WnjxEbfVGaX11zTKTLuuH8+/LCU3/F8JmXdTlU=
Date: Tue, 22 Oct 2019 12:40:32 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Marty E. Plummer" <hanetzer@startmail.com>
Subject: Re: qemu/powernv: coreboot support?
Message-ID: <20191022014032.GH6439@umbus.fritz.box>
References: <20191018172622.kz4smemh5cwesfit@proprietary-killer>
 <21ba3404-dcd3-fe06-7725-d58e249f9fd2@kaod.org>
 <20191019153108.gkupn3tnihspq7th@proprietary-killer>
 <1cbd1882-15c8-5471-cd65-1c84c2920ba8@kaod.org>
 <20191019160933.fizoc6tpu5jday4o@proprietary-killer>
 <20191020062842.GI1960@umbus.fritz.box>
 <0a7cbd9b-2c46-259d-4e0d-9084ee2875a3@kaod.org>
 <20191021053439.GA6439@umbus.fritz.box>
 <f196a1a6-fcbf-f409-e7e7-95b42135c0be@kaod.org>
 <20191022003209.6ssq2ojiv57ixeyd@proprietary-killer>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Uu2n37VG4rOBDVuR"
Content-Disposition: inline
In-Reply-To: <20191022003209.6ssq2ojiv57ixeyd@proprietary-killer>
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
Cc: Joel Stanley <joel@jms.id.au>, qemu-ppc@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Uu2n37VG4rOBDVuR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2019 at 07:32:09PM -0500, Marty E. Plummer wrote:
> On Mon, Oct 21, 2019 at 02:46:59PM +0200, C=E9dric Le Goater wrote:
> > On 21/10/2019 07:34, David Gibson wrote:
> > > On Sun, Oct 20, 2019 at 08:51:47AM +0200, C=E9dric Le Goater wrote:
> > >> On 20/10/2019 08:28, David Gibson wrote:
> > >>>
> > >>> Ok.  Note that the qemu emulated machine doesn't model the hardware
> > >>> right down to the level of hostboot.  That's wy we're just loading
> > >>> skiboot and jumping straight into it usually.  I guess clg's stuff =
to
> > >>> load pnor images gets us a little closer to the hardware behaviour,
> > >>> but I think it's still only a rough approximation.
> > >>
> On that note, is qemu-ppc64 currently capable of running LE
> firmware?

Well.. "qemu-ppc64" as such isn't capable of running either LE or
firmware, since that's the Linux userspace emulator.
qemu-system-ppc64 *is* capable of running both LE and BE firmwares though.

Your firmware will, however, need a tiny BE shim to switch the cpu
into LE mode.

> My
> coreboot port has currently reached a hitch in that part of the firmware
> headers mapping stuff out is saved in LE mode while the cpu (real or emu)
> is running in BE mode (FMAP headers are saved LE but CBFS headers are
> saved BE)
> > >> It's really tied to the OpenPOWER firmwares using the HIOMAP protocol
> > >> to discuss with the BMC and load the flash. We could loosen how QEMU=
=20
> > >> interprets the MTD device and use a property to inform QEMU that this
> > >> is an OpenPOWER  PNOR file and that skiboot and can be loaded from i=
t.
> > >> Something to discuss.
> > >=20
> > > Right.  I'm guessing one significant issue here is that to fully model
> > > the BMC, with *its* firmware and comms channels with the main host
> > > would be quite a lot of work, hence cheating a bit to bypass that.
> >=20
> > In fact, we are not cheating that much. We use the IPMI BT interface of=
=20
> > QEMU to handle the HIOMAP communication with the BMC and this model is=
=20
> > quite precise.=20
> >=20
> > The mapping of the PNOR is simply mapped on the LPC FW address space.=
=20
> > The underlying access are simplified because we don't have a LPC model
> > but we could generate all the SPI transaction using the Aspeed models.=
=20
> > I had experiments in that sense for P8.=20
> >=20
> Honestly getting the coreboot.rom into the lpc fw addr space in the same
> way you do pnor images would be a useful sim, as that's more or less how
> its going to be done on existing hardware.
> > I will sense the patches I have on the topic.
> >=20
> > C.=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Uu2n37VG4rOBDVuR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2uXg0ACgkQbDjKyiDZ
s5IZow//YBHcKKUHJgp2G/heNhJn+hnB4yZBO+xjMOOEkBsSQscxMsAfo67TSpoI
F9Ijr5lnFzjEV+nFhLZ7j2tp4qm9d9HfhzGgepfiRk/pNliRQ5ScnRLqbocQxS5i
FysRsgyRHfPtrPnfn61obfQydKMp6rLI6+XzuADgONvzv0KfCnc5bDOfDL9R5Q2C
SkOemaIZSEhEZvPg2e7uho1+n5adXKq/eHPeOFLZ8ZoncjWA+/v4qWhTi37erSMm
zVzSkuO374Zt8j7N7soAYPy6fIb0A0fqdvSbn3kp97UN7OLUH1HEs308YsDhdzdb
zGGKakb6Zt2EwrOMllQZuQQ+zcsV+kppixRq3YmjTqcx0lTc5FV82cIehXH98uZw
Xv6lEdgDufKYO0wy8tq/7Est25FdNca7CbtsLXyZk7xxVcHOQX0WMOnfbkVCoBE6
psK1ZZQzomNAF6tfnX//phhEHWx7yUDMT86aGDpbTWG5XgWd2Z5Ejy5497F5/Ad1
Cx/1LA1vyzjBc/PCEtbCnhByQfIDZK3/UggTa9GY3WHUUls7mOLzNM/0W3Wlcxi2
6TH6Gtb7/sfcjMuSJ3rNCuCHaGCwlD3czrJVXQDEsJXe+CUkgqDWdMXMlaR/cXIQ
D/N9EqotM4TUpBnZFFepV2XnSXwPvkXhHBuC4761KikowVIenNQ=
=tgzW
-----END PGP SIGNATURE-----

--Uu2n37VG4rOBDVuR--

