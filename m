Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCDAC35242
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 04:03:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51ADB20848
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 04:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="KnZWNXr5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51ADB20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2SCp-00081r-Ix
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 23:03:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41913)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j2SC8-0007d1-04
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 23:03:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j2SC6-0005Ns-D6
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 23:03:11 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:46187 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1j2SC5-0005HU-KQ
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 23:03:10 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48JfqY0X7tz9sRl; Fri, 14 Feb 2020 15:03:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1581652985;
 bh=F87JhA3fqSyG/6tWZ0TN0e8mUO2+EusZ/DwM8f2TXbk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KnZWNXr5Px8R/iWYWwdnWpuA44TuXg9dPrPSW0L+UhqNPrLbUrQ2Nos0EYQ23g+tt
 6UcHMCaQ3FDVmVMbmcJkjQSRQurfxyfHg3S4CMehqLWUJ1jMUr7vjfvC57OM/Aw/7P
 XgDshVj5B7lfPTBfwDHhkz7FGgRsOPIC4v+754CA=
Date: Fri, 14 Feb 2020 15:02:58 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: VW ELF loader
Message-ID: <20200214040258.GP124369@umbus.fritz.box>
References: <de7e4d34-eb63-904c-3475-7feee154c72c@ozlabs.ru>
 <8420784f-b4c7-9864-8534-b94dbc5f74ff@redhat.com>
 <d63ba962-ffbb-9f27-34fb-657188e90194@ozlabs.ru>
 <CABgObfYwtrh_uy8zFmg2qDjK6iynniN6=jJ9_MKfNxXUaOkPKw@mail.gmail.com>
 <71d1cc16-f07d-481d-096b-17ee326157bb@ozlabs.ru>
 <CABgObfa4tUVBbpBtoY3JFSF8-0mRVxgGbzQokc+JrJGPagwPaQ@mail.gmail.com>
 <20200205060634.GI60221@umbus.fritz.box>
 <62d62fab-46a4-240b-037b-409ba859b93d@redhat.com>
 <20200210072802.GD22584@umbus.fritz.box>
 <29abb8fe-f094-689f-2e3d-5462692048fd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="THYEXwetZJOK3OLY"
Content-Disposition: inline
In-Reply-To: <29abb8fe-f094-689f-2e3d-5462692048fd@redhat.com>
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


--THYEXwetZJOK3OLY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2020 at 12:26:07PM +0100, Paolo Bonzini wrote:
> On 10/02/20 08:28, David Gibson wrote:
> > On Thu, Feb 06, 2020 at 09:27:01AM +0100, Paolo Bonzini wrote:
> >> On 05/02/20 07:06, David Gibson wrote:
> >>> On Tue, Feb 04, 2020 at 12:26:32AM +0100, Paolo Bonzini wrote:
> >> I'm really sorry if what I am saying is stupid; but I was thinking of a
> >> firmware entrypoint like
> >>
> >> 	if (op =3D=3D "read" || op =3D=3D "write")
> >> 		do_driver_stuff(op);
> >> 	else
> >> 		hypercall();
> >=20
> > Um... I'm not really clear on where you're imagining this going.  In
> > the OF model, device operations are done by "opening" a device tree
> > node then executing methods on it, so you can't really even get to
> > this point without a bunch of DT stuff.
>=20
> Could you delegate that part to QEMU, as in the v6 patches?  The
> firmware would record the path<->ihandle association on open and close,
> and then you can use that when GRUB does "read" and "write" to invoke
> the appropriate driver.
>=20
> >> This is not even close to pseudocode, but hopefully enough to give the
> >> idea.  Perhaps what I don't understand is why you can't start the
> >> firmware with r3 pointing to the device tree, and stash it for when you
> >> leave control to GRUB.
> >=20
> > Again, I'm not even really sure what you mean by this.  We already
> > enter SLOF with r3 pointing to a device tree.  I'm not sure what
> > stashing it would accomplish.  GRUB as it stands expects an OF style
> > entry point though, not a flat tree style entry point.
>=20
> Again, sorry if what I'm saying makes little sense.  The terminology is
> certainly off.  What I mean is:
>=20
> - read the device tree, instantiate all PCI and virtio drivers
>=20
> - keep the device tree around for use while GRUB is running
>=20
> - find and invoke GRUB
>=20
> - on the OF entry point, wrap open and close + handle the disk and
> network entry points, and pass everything else to QEMU.
>=20
> >> The TTY can use the simple
> >> getchar/putchar hypercalls,
> >=20
> > Yes... though if people attach a graphical console they might be
> > pretty surprised that they don't get anything on there.
>=20
> They wouldn't with Alexey's code either, would they?  And it would be
> yet another QEMU backend to hook into, while with firmware it would be
> lots of code to write but super-boring and something that has been done
> countless times.

That's a fair point.

> > We can possibly ignore the spapr virtual devices.  They seemed like
> > they'd be important for people transitioning from guests under
> > PowerVM, but honestly I'm not sure they've ever been used much.
> >=20
> > We do support emulated (or passthrough) PCI devices.  I don't know if
> > they're common enough that we need boot support for them.  Netboot
> > from a vfio network adaptor might be something people want.
>=20
> Can you get that with SLOF?

I think yes, if your passthrough device is one of the small number
supported by SLOF.

> > USB storage is also a fairly likely candidate, and that would add a
> > *lot* of extra complexity, since we'd need both the HCD and storage
> > drivers.
>=20
> Any reason to make it USB and not a virtio-blk device?  (On x86 these
> days you only add USB storage disks to a VM in order to get drivers to
> Windows).

Hm, yeah, maybe.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--THYEXwetZJOK3OLY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5GG/IACgkQbDjKyiDZ
s5I5exAAw2LLct9BDl3mcD3sIeq6B3oaEsiZN1oJ8zOs4io3zjSuTzy9LsQjdK3O
cWxmrczmepFdtUfjsNFWQKSUvFyMS1nHYKL/4tpGg0RFCmdFXjGbLqzTYEhao+/Y
hF8f2ewiDILP9D0tWrWUsGryhG9wkGqjCJXRl1rTMCyKeFF+M/l73f4uNxf5OQa1
PNMVdRdYKS+YHYocRLaLt13IVsKvok/leZnweJMIxRPFPqhoxyttqS1aSnTaLoFt
+GqppZTWmJyAbv9M4d2jnI3L4jyH/nLRFJl/iua72EnQmXeOJHebAC8KH4RwJC4h
bCPM0w0l70MwMPZstk+/GJvuzS6GoAnD2fmLIkJqxGkJxFrGepyg6TvooiigAyrC
/f3z13mOP8a2xoETnt/SUvzYS3TO1Jfv8zKHqO3+ZiD+j7jzFvNbRs4IATrrz9sK
GbTrjGj2ubqTf7bxT7P9cvLJTYeppkJ5CrWoMDemTFcrsJ1zx+44+DgWasgl6qBz
ItfzPnNK7WPVvDjUCZhiN+xoTkvEjLHFYRNdC937cuDEzbz2aqiX+t3cFbszPV/U
mcM52NOXEPO5wbrs+UNGSexq6d6EoOWctVH+KlwJDaYfR4C9KzupYcjfV4Z/LuI3
s6xH71Kef4aYp+b8v3natZAhApDGuYsJhOfhtt8/QtZ966HUFAM=
=MVMt
-----END PGP SIGNATURE-----

--THYEXwetZJOK3OLY--

