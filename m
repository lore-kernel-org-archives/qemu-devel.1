Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D441C35249
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 06:08:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED44C217BA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 06:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="WuXBURlr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED44C217BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izDrG-00036K-3W
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 01:08:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33407)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1izDqL-0002Gz-Vg
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 01:07:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1izDqJ-0001D7-JN
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 01:07:20 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:32987)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1izDqI-0000xY-T7
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 01:07:19 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48CB0y4Wxjz9sSZ; Wed,  5 Feb 2020 17:07:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1580882834;
 bh=I1loHr7gp7A1IXGdi4UinTyovz7uz5DiOdDo3CLuz0E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WuXBURlraxSZmaulf8DyDd9BXIRAMjzPdp3RbbYoL9WUtSYkhUknzeD1V55Igr/m2
 gRlbPAGJX3AuTLsN0CEAcZmd9QeQKKFdfFLx39qJOLeDIAacxWhV6qc4myxwbyv6HV
 NL1c4wG/eLoBPCSye+u4uimn9IPjjmZV3ebgnSR4=
Date: Wed, 5 Feb 2020 16:58:51 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: VW ELF loader
Message-ID: <20200205055851.GH60221@umbus.fritz.box>
References: <f881c2e7-be92-9695-6e19-2dd88cbc63c1@ozlabs.ru>
 <e3ee4b4d-1b24-2900-4304-05fa521a9b47@redhat.com>
 <20200203012842.GD52446@umbus.fritz.box>
 <ec81cca1-d5fb-3f1e-b433-3328d81a117e@redhat.com>
 <de7e4d34-eb63-904c-3475-7feee154c72c@ozlabs.ru>
 <8420784f-b4c7-9864-8534-b94dbc5f74ff@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OgApRN/oydYDdnYz"
Content-Disposition: inline
In-Reply-To: <8420784f-b4c7-9864-8534-b94dbc5f74ff@redhat.com>
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
Cc: Thomas Huth <thuth@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Cornelia Huck <conny@cornelia-huck.de>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--OgApRN/oydYDdnYz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2020 at 04:08:54PM +0100, Paolo Bonzini wrote:
> On 03/02/20 11:58, Alexey Kardashevskiy wrote:
> >>> So really, the question isn't whether we implement things in firmware
> >>> or in qemu.  It's whether we implement the firmware functionality as
> >>> guest cpu code, which needs to be coded to work with a limited
> >>> environment, built with a special toolchain, then emulated with TCG.
> >>> Or, do we just implement it in normal C code, with a full C library,
> >>> and existing device and backend abstractions inside qemu.
> >>
> >> ... which is adding almost 2000 lines of new code to the host despite
> >> the following limitations:
> >>
> >>> 4. no networking in OF CI at all;
> >>> 5. no vga;
> >>> 6. no disk partitions in CI, i.e. no commas to select a partition -
> >>> this relies on a bootloader accessing the disk as a whole;
> >=20
> > This is not going to be a lot really, especially supporting partitions -
> > the code is practically there already as I needed it to find GRUB, and
> > GRUB does the rest asking very little from the firmware to work.
>=20
> What partition formats would have to be supported?  But honestly I'm
> more worried about the networking part.
>=20
> > btw what is the common way of netbooting in x86? NIC ROM or GRUB (but
> > this would be a disk anyway)? Can we consider having a precompiled GRUB
> > image somewhere in pc-bios/ to use for netboot? Or Uboot would do (it is
> > already in pc-bios/, no?), I suppose?
>=20
> GRUB netboot support is almost never used.  There are three cases:
>=20
> - QEMU BIOS: the NIC ROM contain iPXE, which is both the driver code and
> the boot loader (which chains into GRUB).
>=20
> - Bare metal BIOS: same, but the boot loader is minimal so most of the
> time iPXE is loaded via TFTP and reuses the NIC ROM's driver code.
>=20
> - UEFI: the NIC ROM contains driver code only and the firmware does the
> rest.
>=20
> >> In other words you're not dropping SLOF, you're really dropping
> >> OpenFirmware completely.
> >=20
> > What is the exact benefit of having OpenFirmware's "interpret"?
>=20
> None, besides being able to play space invaders written in Forth.  I'm
> not against dropping most OpenFirmware capabilities, I'm against adding
> a limited (or broken depending on what you're trying to do) version that
> runs in the host.
>=20
> Yes, SLOF is big and slow.  petitboot is not petit at all either, and
> has the disadvantage that you have to find a way to run GRUB afterwards.

Well, not usually.  Petitboot parses grub configuration itself, which
means that generally from the OS / installer point of view it looks
like grub, even though it's not from the actual bootstrapping point of
view.

>  But would a similarly minimal OF implementation (no network, almost no
> interpret so no Forth, device tree built entirely in the host, etc.) be
> just as big and slow?

So, as actual OF implementations go, SLOF is already pretty minimal
(hence "Slim Line Open Firmware").  If there's no Forth, it's really
not OF any more, just something mimicing some of OF's interfaces.

But the difficulty of SLOF isn't really its bigness or slowness in any
case (the slowness is just an additional irritation).  The two big
issues are 1) that it's written in an obscure language and 2)
synchronizing its state with things that require host side
involvement.

Rewriting a minimal guest side not-OF would partly address (1) (but
there's still the logistical pain of having to build and insert it),
and wouldn't address (2) at all.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--OgApRN/oydYDdnYz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl46WZgACgkQbDjKyiDZ
s5LT2hAAioN8Mt4Z54+pH/bD/W23GZDDkoEowik1fIe2RWECcFm2Dl4iqGbf6hml
6K6FQSOJSuYvU70tRKTIG+lZPn7GW9ogk2weMuTcZejvZCU3HkUNzyoMRq2EhYLJ
nT7JmSi2gCPrF4lwRmyKS5UZHujM5dTMPUxkKpNZ9pX4yFrll8S73imxT09BpthY
wFWGPJdudiNHBNCVmIfMTZ8NjG/mSW6wBNwl7cOuqfLUVh5F/oKT4N/tltZnwSeR
5B7QBIFADomREZU8VUOPT4ehBj4/qcAzzg5/Xs2hrTB83LN4/brKvd2DLGrAMfbM
308ObuStgNM8UoGiZRLtlJ1rzLFRgSS5zJFcUeDi2bcMbSjqJq9937X6FGrsW1rT
zc627IwI/lhC9q8yhqYOt9brrxPpW0d9LqIcV5PbzNJ2jqsd35gL3yNcigknKR2o
VmD/JWihkU51z4lQwTbK4IvgYg1VbLXrdQkxEk6sbzOF8fOtIYZQrMtY2EBFFVKK
KBtCm9wDyVEvQfioWkJOEPp1JcYz3Dp8csfMvG7Iqzsw2JXnuyhD9OSCloCDLzoM
v60GQ+umuwwDJe2Cxcvl0JQDS9tG7Hv0KMdGchn0c64Ph3XGC64Bnsr2CaiGpjMd
6qAbraSjoWxEWsQVHebGmEPKj9254noqvkJA2SK3PtpguVjRp8c=
=9b7q
-----END PGP SIGNATURE-----

--OgApRN/oydYDdnYz--

