Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E529DC352A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 03:19:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1CBB2168B
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 03:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="lyfZ8bW0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1CBB2168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j252X-0001SK-SR
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 22:19:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59879)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j251v-00011D-Aj
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 22:19:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j251t-0002R5-CZ
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 22:19:06 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:44313)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j251r-0002HZ-IX; Wed, 12 Feb 2020 22:19:05 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48J1v648K5z9sPJ; Thu, 13 Feb 2020 14:18:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1581563938;
 bh=R0wsqkK4T4TVxGp4P3KWchDaWTAZGKfzMxsopPtLOQ4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lyfZ8bW0IyOypqTzYf/iBN8KJYNhS9MJhB6MDmnw12tExi56WENNeFCpHBYKZwKZ3
 nDXaOcIrbjzG6i+uHYxeiMuTnrHdzRH0oTOr2LWEnU7vWioXX6RBZJfqcVets3rJ5V
 q3CDkhEMMgcGPcxTJNkmDBwXvllbIEINiBfvOGHA=
Date: Thu, 13 Feb 2020 14:16:29 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Subject: Re: Restrictions of libnet (was: Re: VW ELF loader)
Message-ID: <20200213031629.GD124369@umbus.fritz.box>
References: <CABgObfYwtrh_uy8zFmg2qDjK6iynniN6=jJ9_MKfNxXUaOkPKw@mail.gmail.com>
 <71d1cc16-f07d-481d-096b-17ee326157bb@ozlabs.ru>
 <CABgObfa4tUVBbpBtoY3JFSF8-0mRVxgGbzQokc+JrJGPagwPaQ@mail.gmail.com>
 <d13eea1d-7942-47e0-6189-a66ce9639db4@redhat.com>
 <20200204095403.04d9dd29.conny@cornelia-huck.de>
 <4794cf7a-7b53-5fea-c89d-baa01d3ed0ce@redhat.com>
 <20200205053049.GF60221@umbus.fritz.box>
 <bfe9398a-7108-9bf7-8589-6d01580bbb3a@redhat.com>
 <20200210075516.GF22584@umbus.fritz.box>
 <20200210093952.GC4113@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="wLAMOaPNJ0fu1fTG"
Content-Disposition: inline
In-Reply-To: <20200210093952.GC4113@kitsune.suse.cz>
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
 Cornelia Huck <conny@cornelia-huck.de>, qemu-devel <qemu-devel@nongnu.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--wLAMOaPNJ0fu1fTG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2020 at 10:39:52AM +0100, Michal Such=E1nek wrote:
> On Mon, Feb 10, 2020 at 06:55:16PM +1100, David Gibson wrote:
> > On Wed, Feb 05, 2020 at 07:24:04AM +0100, Thomas Huth wrote:
> > > On 05/02/2020 06.30, David Gibson wrote:
> > > > On Tue, Feb 04, 2020 at 10:20:14AM +0100, Thomas Huth wrote:
> > > >> On 04/02/2020 09.54, Cornelia Huck wrote:
> > > >>> On Tue, 4 Feb 2020 07:16:46 +0100
> > > >>> Thomas Huth <thuth@redhat.com> wrote:
> > > >>>
> > > >>>> On 04/02/2020 00.26, Paolo Bonzini wrote:
> > > >>>>>
> > > >>>>>
> > > >>>>> Il mar 4 feb 2020, 00:20 Alexey Kardashevskiy <aik@ozlabs.ru
> > > >>>>> <mailto:aik@ozlabs.ru>> ha scritto:
> > > >>>>>
> > > >>>>>     Speaking seriously, what would I put into the guest?
> > > >>>>>
> > > >>>>> Only things that would be considered drivers. Ignore the partit=
ions
> > > >>>>> issue for now so that you can just pass the device tree service=
s to QEMU
> > > >>>>> with hypercalls.
> > > >>>>>
> > > >>>>>     Netboot's dhcp/tftp/ip/ipv6 client? It is going to be anoth=
er SLOF,
> > > >>>>>     smaller but adhoc with only a couple of people knowing it.
> > > >>>>>
> > > >>>>>
> > > >>>>> You can generalize and reuse the s390 code. All you have to wri=
te is the
> > > >>>>> PCI scan and virtio-pci setup. =20
> > > >>>>
> > > >>>> Well, for netbooting, the s390-ccw bios uses the libnet code fro=
m SLOF,
> > > >>>> so re-using this for a slim netboot client on ppc64 would certai=
nly be
> > > >>>> feasible (especially since there are also already virtio drivers=
 in SLOF
> > > >>>> that are written in C), but I think it is not very future proof.=
 The
> > > >>>> libnet from SLOF only supports UDP, and no TCP. So for advanced =
boot
> > > >>>> scenarios like booting from HTTP or even HTTPS, you need somethi=
ng else
> > > >>>> (i.e. maybe grub is the better option, indeed).
> > > >>>
> > > >>> That makes me wonder what that means for s390: We're inheriting
> > > >>> libnet's limitations, but we don't have grub -- do we need to com=
e up
> > > >>> with something different? Or improve libnet?
> > > >>
> > > >> I don't think that it makes sense to re-invent the wheel yet anoth=
er
> > > >> time and write yet another TCP implementation (which is likely qui=
te a
> > > >> bit of work, too, especially if you also want to do secure HTTPS i=
n the
> > > >> end). So yes, in the long run (as soon as somebody seriously asks =
for
> > > >> HTTP booting on s390x) we need something different here.
> > > >>
> > > >> Now looking at our standard s390x bootloader zipl - this has been =
giving
> > > >> us a headache a couple of times in the past, too (from a distro po=
int of
> > > >> view since s390x is the only major platform left that does not use=
 grub,
> > > >> but also from a s390-ccw bios point of view, see e.g.
> > > >> https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg03046.htm=
l and
> > > >> related discussions).
> > > >>
> > > >> So IMHO the s390x world should move towards grub2, too. We could e=
=2Eg.
> > > >> link it initially into the s390-ccw bios bios ... and if that work=
s out
> > > >> well, later also use it as normal bootloader instead of zipl (not =
sure
> > > >> if that works in all cases, though, IIRC there were some size
> > > >> constraints and stuff like that).
> > > >=20
> > > > petitboot would be another reasonable thing to consider here.  Since
> > > > it's Linux based, you have all the drivers you have there.  It's not
> > > > quite grub, but it does at least parse the same configuration files.
> > > >=20
> > > > You do need kexec() of course, I don't know if you have that already
> > > > for s390 or not.
> > >=20
> > > AFAIK we have kexec on s390. So yes, petitboot would be another option
> > > for replacing the s390-ccw bios. But when it comes to LPARs and z/VMs=
, I
> > > don't think it's really feasible to replace the zipl bootloader there
> > > with petitboot, so in that case grub2 still sounds like the better
> > > option to me.
> >=20
> > Actually, between that and Paolo's suggestions, I thought of another
> > idea that could be helpful for both s390 and power.  Could we load
> > non-kexec() things (legacy kernels, non-Linux OSes) from Petitboot by
> > having it kexec() into a shim mini-kernel that just sets up the boot
> > environment for the other thing.
> >=20
> > What I'm imagining is that petitboot loads everything that will be
> > needed for the other OS into RAM - probably as (or part of) the
> > "initrd" image.  That means the shim doesn't need to have drivers or
> > a network stack to load that in.  It just needs to construct
> > environment and jump into the real kernel.
>=20
> How does that differ from what kexec normally does?
>=20
> It does support the kernel format that is usually booted on the
> architecture.

It's not a question of format, but of environment.

By the time a kexec() occurs there won't be any OF client interface
available, whether or not there ever was one.  So, kexec() won't be
able to exec things which expect that to be present.  That includes
grub, AIX, and (probably) FreeBSD.

Note that while it's the same image, Linux kernels for POWER for a
long time have been able to boot in one of two ways.  One expects the
flattened tree, and an already instantiated RTAS - this method is used
directly by RTAS.  The other expects an OF client interface - it
slurps the device tree out of that and produces the flattened tree,
instantiates RTAS and then jumps to the flat tree entry point.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--wLAMOaPNJ0fu1fTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5Ev4oACgkQbDjKyiDZ
s5LY/A//TDA/iKle4xaWCE1lXCEnZbmLQ/ZRGRVIESTxeS5XQajILZ+7N1BbW6Dk
psItXdW/ubNLx7UKx5IkWN3a7w3tNaTM7Fl5dauMNgcRV2BCBlSb+OjiZb85GjMP
fj83zfWtVGQYSR/FhBJ8TjKrfns2fVrXWlzcBdrKw4Gf0MefAcVnUdIVQNKxjACT
MEyxOfxgMzhI7XI9MZlqCmurSlGI3k1sp57AHTqNaO77sGGy9BQR2Zm6/1ToR8+Y
Wl05Klideoes6Ge/ne5Ann4jeqykElSEGzJfMf/LUwtw94S57PEm9+9iW/wVYBfn
HuXLqKGCWSxSpIKE19TmNOI/rgdvciA76a6KRSSrpePNa1Nzsih/0t2zVyGtHuKA
kcZTWHrEjpBCqrNfEhJ5wB3NuqWBZxqKKp0iwENp/BB7gLyEoA9aBHnUj07hJKYV
LpHYFoJL7Ba4kS7hdGIr50L+vfeDH+kNhkCJZR2RZd4rXf1IKGIkWQXs1sGMlPeZ
eZUgVOc++F/F248AdOkV7HsImfkRtt8rY/NMOfeu29bawHMg4PY7dh+VPUwsvj/U
CXsxFdNP6RoNzI6OxehcJV2smevCmEpp7lzPSJ2ayFJz2HSfmaddotzQHyZVEnQm
H0cFRo1DE/rb++WppFZKfB4be77JS4dy+cgOlF5Zhg2oWndubZM=
=RBye
-----END PGP SIGNATURE-----

--wLAMOaPNJ0fu1fTG--

