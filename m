Received: from eggs.gnu.org ([2001:4830:134:3::10]:35533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fFzah-0008Dm-25
	for qemu-devel@nongnu.org; Tue, 08 May 2018 06:11:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fFzad-0000fP-U0
	for qemu-devel@nongnu.org; Tue, 08 May 2018 06:11:27 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:46429)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fFzad-0000f8-Ms
	for qemu-devel@nongnu.org; Tue, 08 May 2018 06:11:23 -0400
Received: by mail-wr0-x243.google.com with SMTP id a12-v6so792691wrn.13
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 03:11:23 -0700 (PDT)
Date: Tue, 8 May 2018 11:11:21 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180508101121.GD19710@stefanha-x1.localdomain>
References: <ba020090-1877-6b9a-891d-dbfbabf25c71@ymail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fOHHtNG4YXGJ0yqR"
Content-Disposition: inline
In-Reply-To: <ba020090-1877-6b9a-891d-dbfbabf25c71@ymail.com>
Subject: Re: [Qemu-devel] Unix signal to send ACPI-shutdown to Guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Wood <andrewjameswood@ymail.com>
Cc: qemu-devel@nongnu.org


--fOHHtNG4YXGJ0yqR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 28, 2018 at 11:59:41PM +0100, Andrew Wood via Qemu-devel wrote:
> Ive been looking into the possibility of using a unix signal to send an a=
cpi
> shutdown request to a VM, and came across a posting on this l in March 1.
> See https://lists.nongnu.org/archive/html/qemu-devel/2017-03/msg04169.html
>=20
>=20
> To summarise to refresh memories=A0 there was a patch proposed using SIGI=
NT
> followed by discussion as to why SIGINT wasnt ideal because it would cause
> regressions for anyone relying on the existing handling of SIGINT, and
> various other signals were considered including HUP & USR1 & USR2 all of
> which are already used for something else.
>=20
> Is SIGPWR a suitable candidate, I have made a patch to use SIGPWR but as =
Im
> new to QEMUs internals Im not sure if there are any circumstances in which
> an alternative handler is registered for SIGPWR which might conflict?

A quick grep of the Linux kernel code suggests that SIGPWR is very
rarely raised by the kernel.  It's only sent to init on s390 and Silicon
Graphics SN systems.  QEMU could use the signal on Linux without risk of
collision.

It's worth sending a patch.  Here are the patch submission guidelines:
https://wiki.qemu.org/Contribute/SubmitAPatch

Stefan

--fOHHtNG4YXGJ0yqR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEbBAEBAgAGBQJa8XfJAAoJEJykq7OBq3PIoPUH+N1xR2abvjjX5Q6vMid8eZ9w
nWmSA0FHTN8ik/cUDmbpIuSeF/pmzSClgKj7AYD8xHqgVTuTqCZ4KjbEWyNuwJAZ
2qX/bb1u2sWq5Ska0OCfc4O6w3eXbBw+Qkf6n/28zVPNCgnIFZdWJPZUs9rawZeK
F21cSGRiKquHhsVUWy/EwN46UT5miGQ6ldGq0d0znq3FrxoVoH0mAHnb+ejjcCW8
thuZobnM/a8VoIpCdCiYm/XcCZccHU/33+c/x7/7q0M6Vr3R3NgGAyZLd7I197AN
AEztE8fNQT+a9639bwJhk3+rg+04M4ZleExKK3PKUejW0Ta9fJIUTRqY/i3TiQ==
=EDRw
-----END PGP SIGNATURE-----

--fOHHtNG4YXGJ0yqR--
