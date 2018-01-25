Received: from eggs.gnu.org ([2001:4830:134:3::10]:44927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eefI2-0007so-2m
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 06:01:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eefHw-0004Ku-Cn
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 06:01:54 -0500
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:38252)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eefHw-0004KL-6S
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 06:01:48 -0500
Received: by mail-wr0-x22d.google.com with SMTP id a1so2502165wri.5
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 03:01:47 -0800 (PST)
Date: Thu, 25 Jan 2018 11:01:44 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180125110144.GD27269@stefanha-x1.localdomain>
References: <1516655269-1785-1-git-send-email-juterry@microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d9ADC0YsG2v16Js0"
Content-Disposition: inline
In-Reply-To: <1516655269-1785-1-git-send-email-juterry@microsoft.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/4] Updates based on feedback.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Justin Terry (VM)" <juterry@microsoft.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, crosthwaite.peter@gmail.com


--d9ADC0YsG2v16Js0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2018 at 01:07:45PM -0800, Justin Terry (VM) via Qemu-devel =
wrote:
> Updates based on review feedback.
>=20
> 1. Fixes style issues and properly ran the scripts/checkpatch pre submiss=
ion.
> 2. Added migration blockers for CPUID, dirty memory tracking, and XSAVE/X=
RSTOR.
> 3. Fixed some bugs around register states when using bios vs efi.
>=20
> Justin Terry (VM) (4):
>   Add the Windows Hypervisor Platform accelerator.
>   Add the WHPX vcpu API
>   Introduce the WHPX impl
>   Add the WHPX acceleration enlightenments

This could be huge for QEMU on Windows users.  Thanks for doing this!

Which guest OSes have you tested?

What are the known limitations (after all, the code is quite small and
maybe not everything is implemented yet in this patch series)?

Stefan

--d9ADC0YsG2v16Js0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaabkYAAoJEJykq7OBq3PI7zQH/15qKQ/o5XDQsLyMjTub850j
vBXz+1YIttCTAUmdRHG21Ch941Eq0OxIKuzJ+nzB1nUUoqE6A4h7+xw/8vkofnr7
bc4fHTUV/92zAfwbYhF+X1WoMq2A92O5T6ogjK8vXx3BYTdB44T8T4nO3mYNk7Pb
y92MD8nCsHvlzqld7bkVnMTh/EQLAJtk7nelXCG4NX9DD4WJlW4XhCRiv/zdT21S
z4Z+p6ujPLdt9vF+gkwCT18EQlFtlLDEO22Xk2YnzwkRMFdE2UI3dODiK7vlbuGn
jqWNYjquDzQ5DqsfKKAZmHY69f0yfXOZ835OQworQ5aQeL+ZIRcq6V1+DEJ85JY=
=3UVV
-----END PGP SIGNATURE-----

--d9ADC0YsG2v16Js0--
