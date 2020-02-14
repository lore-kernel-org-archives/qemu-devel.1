Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51971C35242
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 03:24:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FDB720661
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 03:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="nxHAkWgK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FDB720661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2RaZ-00058h-8m
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 22:24:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42413)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j2RZr-0004IR-LB
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 22:23:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j2RZp-0008Ku-V8
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 22:23:39 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:52159)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1j2RZp-0008BP-1z
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 22:23:37 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48Jdxw6n9pz9sRN; Fri, 14 Feb 2020 14:23:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1581650612;
 bh=2za93kHvPaRBlbK0I4XIvwq/W8gsIYGDOurnDc/bPuA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nxHAkWgKfShfu+yOTEyrRvlzllfvlptxDTKk3nNTfdkPcyfJs8zjE5+T3czbR64pc
 eRnIiTxnqfkcuGtO6cza7JQaEPAGir7XbJqviqwWbaVNTvv5DkajuPTXJLS/KK/Nl6
 dJ5eAlmGxUNppcN347JKXX2qlk1EIwoCTdthhz1c=
Date: Fri, 14 Feb 2020 14:23:25 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: VW ELF loader
Message-ID: <20200214032325.GN124369@umbus.fritz.box>
References: <d63ba962-ffbb-9f27-34fb-657188e90194@ozlabs.ru>
 <CABgObfYwtrh_uy8zFmg2qDjK6iynniN6=jJ9_MKfNxXUaOkPKw@mail.gmail.com>
 <71d1cc16-f07d-481d-096b-17ee326157bb@ozlabs.ru>
 <CABgObfa4tUVBbpBtoY3JFSF8-0mRVxgGbzQokc+JrJGPagwPaQ@mail.gmail.com>
 <20200205060634.GI60221@umbus.fritz.box>
 <62d62fab-46a4-240b-037b-409ba859b93d@redhat.com>
 <47e6a49d-f1c7-aaf6-b9ef-7e81773cff6e@ozlabs.ru>
 <8993c6b4-2a2c-b7e5-8342-4db480d0af9d@redhat.com>
 <20200210073008.GE22584@umbus.fritz.box>
 <c40f83a1-6dbd-7223-e825-0ab153a36aed@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NJSRbAqOy4NeGDns"
Content-Disposition: inline
In-Reply-To: <c40f83a1-6dbd-7223-e825-0ab153a36aed@redhat.com>
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
 qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <conny@cornelia-huck.de>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--NJSRbAqOy4NeGDns
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2020 at 12:25:39PM +0100, Paolo Bonzini wrote:
> On 10/02/20 08:30, David Gibson wrote:
> >> Anything you put in the host is potential attack surface.
> > Ok, it is attack surface you're concerned about.  That wasn't totally
> > clear before this point.
>=20
> Part that, part having to add backend hooks that weren't needed so far.
>=20
> >> Plus, you're not doing a different thing than anyone else and as
> >> you've found out it may be easy for block device but not for
> >> everything else.
> >
> > Uh.. was that supposed to be "we *are* doing a different thing than
> > anyone else"?
>=20
> Alexey's question was "what is exactly the benefit", so "not doing a
> different thing" is the answer (one of them).

Ah, right, I see.

> >> Every platform that QEMU supports is just using a firmware to do
> >> firmware things; it can be U-Boot, EDK-2, SLOF, SeaBIOS, qboot, with
> >> varying level of complexity.  Some are doing -kernel in QEMU rather th=
an
> >> firmware, but that's where things end.
> >
> > Well, yeah, but AIUI those platforms actually have a defined hardware
> > environment on which the firmware is running.  For PAPR we don't, we
> > *only* have a specification for the "hardware"+"firmware" environment
> > as seen by the OS together.
>=20
> PAPR is a specification for the environment as seen by the OS.  But "-M
> pseries" is already a defined hardware environment on which SLOF is
> running.

"defined" might be a bit strong.  We have on multiple occasions
required synchronized SLOF and qemu updates in order to keep
presenting the same guest environment.

> There's nothing that prevents you from defining more of that
> environment in order to run Linux (for petitboot) or your own
> pseudo-OpenFirmware driver provider inside it.

Well, sure, but we don't want that definition to introduce lots of
complexity we have to maintain on top of the existing HV and firmware
interfaces that are defined.

I realized what I said about the firmware interfaces requiring HV
privilege was a bit misleading.  For the boot time firmware
components, such as the OF client interface, that's mostly not true
(with the big and hairy exception of the
ibm,client-architecture-support feature negotiation mechanism).

It is, however, true of the runtime RTAS interfaces.  In fact it's
true to the point that, at least for most of the RTAS interfaces we
care about, it's hard to imagine an in-guest implementation doing
anything much other than repackaging the information it gets and
forwarding it to the hypervisor.  For most purposes RTAS is pretty
much an alternative hypercall mechanism.  So, I think implementing the
RTAS entirely in qemu was the right choice.

Where it gets complicated is that a number of RTAS calls need to match
IDs with stuff from the boot time firmware.  Particularly phandles of
device nodes, and some other IDs.

Which would be fine if the boot time firmware took the device tree
=66rom qemu and used it unmodified.  But.. it doesn't, quite.  In
particular it assigns its own phandles, because it uses them as an
internal index.  And worse, clients can alter the device tree, and
this is used to a small extent - grub pokes a few values in there for
use later.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NJSRbAqOy4NeGDns
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5GEqoACgkQbDjKyiDZ
s5Kk0xAAyvkeD7FXQalS8WVA7HjqxfRfm2XATpuf93q/ewgRj4er/tAm1HdosqRE
G7xCHhpBVdtVg5+9sYX38bVkrW8pf3rGPUAhVgWZRax7eXIFqxYDwxwHUPkAba3C
cH+8ubcmMemYO+M8YRp9Xc+6eOmeg7Bjcoy+8irAjNTRW4UlQlTQwLT7V0AGqdqc
GEyL/9J17e8wDEs3QuP76zxPdsSo2uR19W17oK83amYqDxtpBIjDZW6Aa5Z349s7
K4n+pHN2pZ09RTVSm29dKcG4WnGegWVW2H1B/fNFDQ602J6axzsUhbXHO8/YAK9N
ikzWgi7MGYxWoeJwfO6zwKx6sru2H5lHwUyzliTLSJS1RjwLdbxZEXWCx79GaNFb
Ezd31ob0LM/03Tapz/hBmD3NANpYFsX9K0BysVPh+wRRIImNhhGx2fJ+z6YVGKCv
okYrhQAtXxQ5/T9tFcarIqwbcfQUFegzqDzFUl8w6vTZK4DBI6s3L0V+daWcEBt3
M9k0my9+BZDE0/AtAZ6WXKIyKbnyCaUo49qtInvRrZGh9Ld4K1xmRAzyxm8FoPBH
3CV+MGuI5ceUil0RfuFwGzNFTbrAR+ni6mOO32joomj4xLJfKmk8CPP5wivsfmz6
kLEG5RmrO8hWdG6mHgKH/VK5CDljVeXgXLtD6K8bvThryjW5K7o=
=PcVG
-----END PGP SIGNATURE-----

--NJSRbAqOy4NeGDns--

