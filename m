Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534D7C3524C
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 01:32:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 215B22067C
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 01:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="BiGAzkvl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 215B22067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyQb5-0007cH-BA
	for qemu-devel@archiver.kernel.org; Sun, 02 Feb 2020 20:32:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50846)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iyQaH-0006mG-Mz
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 20:31:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iyQaG-0001bZ-EB
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 20:31:29 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:37265 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1iyQaE-0001Uu-Cc
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 20:31:28 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 489qzY52Fkz9sPK; Mon,  3 Feb 2020 12:31:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1580693481;
 bh=FTP/akVgiin1BnBxvfvaO8NDaSLqJqZH5lz7E7lRaFs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BiGAzkvl9SGXBsK8OCZJKVHD1PiV7pbIXN0c1AvDEa/GgNDzYDgx/DtdHzL6H5cGd
 NuZ8xIUpDMgEm13sl2GdFMwCAGekQuSQDulcNS+I5A57lQajmg2w9sUPgqC568jGCa
 3/wEviCPC2qoyI9IE+/0g8ecnrsOTE/S5TR+l7lU=
Date: Mon, 3 Feb 2020 12:31:11 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: VW ELF loader
Message-ID: <20200203013111.GE52446@umbus.fritz.box>
References: <f881c2e7-be92-9695-6e19-2dd88cbc63c1@ozlabs.ru>
 <e3ee4b4d-1b24-2900-4304-05fa521a9b47@redhat.com>
 <94828b1d-fa7d-149e-9eb3-d001d6484489@ozlabs.ru>
 <CABgObfaG6th54YJkEPaqq=_UQhvmZiJz6X6Yb_PZJQ15AZvMTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mR8QP4gmHujQHb1c"
Content-Disposition: inline
In-Reply-To: <CABgObfaG6th54YJkEPaqq=_UQhvmZiJz6X6Yb_PZJQ15AZvMTA@mail.gmail.com>
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
Cc: Thomas Huth <thuth@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <conny@cornelia-huck.de>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--mR8QP4gmHujQHb1c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 02, 2020 at 06:38:59PM +0100, Paolo Bonzini wrote:
> Il dom 2 feb 2020, 12:51 Alexey Kardashevskiy <aik@ozlabs.ru> ha scritto:
>=20
> > > QEMU must not load GRUB from disk, that's the firmware's task.  If you
> > > want to kill SLOF, you can rewrite it, but loading the kernel GRUB fr=
om
> > > disk within QEMU is a bad idea: the next feature you'll be requested =
to
> > > implement will be network boot, and there's no way to do that in QEMU.
> >
> > What is exactly the problem with netboot? I can hook up the OF's "net" =
to
> > a backend (as I do for serial console and
> > blockdev, in boot order)
>=20
> Who provides the OpenFirmware entry point when you remove SLOF and boot
> directly into grub?

We do the same thing as we do for RTAS.  We have a tiny (20 byte) stub
for the client interface entry point which forwards client interface
calls to a hypercall which we implement in qemu.

> Or alternatively it is possible with my patchset to load petitboot (kernel
> > + intramdisk, the default way of booting
> > POWER8/9 baremetal systems) and that thing can do whole lot of things, =
we
> > can consider it as a replacement for ROMs from
> > devices (or I misunderstood what kind of netboot you meant).
> >
>=20
> Why wouldn't that have the same issue as SLOF that you describe below (I
> honestly don't understand anything of it, but that's not your fault :-)).

Because having it's own full understanding of the hardware (via its
linux kernel), petitboot doesn't have to shared data with the
hypervisor to the extent that SLOF needs to.

>=20
> Paolo
>=20
>=20
> > > You should be able to reuse quite a lot of code from both
> > > pc-bios/s390-ccw (for virtio drivers) and kvm-unit-tests (for device
> > > tree parsing).  You'd have to write the glue code for PCI hypercalls,
> > > and adapt virtio.c for virtio-pci instead of virtio-ccw.
> >
> > The reason for killing SLOF is to keep one device tree for the entire b=
oot
> > process including
> > ibm,client-architecture-support with possible (and annoying) configurat=
ion
> > reboots. Having another firware won't help
> > with that.
> >
> > Also the OF1275 client interface is the way for the client to get
> > net/block device without need to have drivers, I'd
> > like to do just this and skip the middle man (QEMU device and guest dri=
ver
> > in firmware/bootloader).
> >
> > I'll post another RFC tomorrow to give a better idea.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--mR8QP4gmHujQHb1c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl43d98ACgkQbDjKyiDZ
s5IBJxAAn4rC0ZsM1xkzMb6eaOBrOT5GMFjUSBWHVTzR+fyFBya/7Zop/UH+R4sr
Zlu8ZAt1nfsMQ+c573nA0jSqHwB7/OwoMTHStKf1MAbse59bZ25/OwsJz+i6wTCF
iGiNkNhbqk9H0KPQuxhQCGu6mjVaDni8GHyG4lgVdnT2pCShKeVxyt3iG9qlJ+dW
d59ru5LBRyCiLfkSEGOCWnHgNAxkJP4iJij9tsD8eB3Wz8wsZputTn2cnl7goXB4
N1SSdIo1tJl+UoaaBapryjcUpAwkyUNFI/idVrdQ9DDH0RQ1azvFIBnThHXluayw
V1OqM07r6ig4jGUUpRn6X8RmvwZ9s/MfyevcC/Pn1eMPpUuqyEQIMn90zTZ3P50K
pbO/KtwgXK5a2ikXFw1OThY1SeSLe0wbCAxHDgMr58Z4N81RB3IOglImItkObQYg
v2mkWl/WyTMA7v4rhW91NvTpDqHdzBGK6p3AGCxIJ2NZtWRNSVTNTRPR2GhCkZ2P
HiFwCnSU/yDGoU6WzSkDOMthfhHX2U1/vKBJ78DZlxXCaYEoFctO7JZ2fuwVGL+1
/xjVXvdJJwmVQI3OpKX+aX2AZbbLpViShI9bbeCTAvDKv2ww1ee3KAcTopcMcThQ
H+ylMwbIeq4s9ji1s9yXXwoVOGIlRduf7TZHSD30NZnzpi89EF0=
=gdTe
-----END PGP SIGNATURE-----

--mR8QP4gmHujQHb1c--

