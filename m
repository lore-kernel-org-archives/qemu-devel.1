Received: from eggs.gnu.org ([2001:4830:134:3::10]:44084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fivTO-0000Pe-Ni
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 01:39:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fivTK-0006xR-SJ
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 01:39:30 -0400
Date: Fri, 27 Jul 2018 15:34:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180727053409.GL3694@umbus.fritz.box>
References: <153259340275.5529.15876484471761179518.stgit@dhcp-9-109-246-16>
	<20180727031348.GD3694@umbus.fritz.box>
	<c162e499-1429-7863-4a1a-58cfbb4d3057@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="O8/n5iBOhiUtMkxf"
Content-Disposition: inline
In-Reply-To: <c162e499-1429-7863-4a1a-58cfbb4d3057@linaro.org>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2] linux-user: ppc64: don't use
 volatile register during safe_syscall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>, dgibson@redhat.com, riku.voipio@iki.fi, laurent@vivier.eu, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--O8/n5iBOhiUtMkxf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 26, 2018 at 10:20:11PM -0700, Richard Henderson wrote:
> On 07/26/2018 08:13 PM, David Gibson wrote:
> > On Thu, Jul 26, 2018 at 01:56:19PM +0530, Shivaprasad G Bhat wrote:
> >> r11 is a volatile register on PPC as per calling conventions.
> >> The safe_syscall code uses it to check if the signal_pending
> >> is set during the safe_syscall. When a syscall is interrupted
> >> on return from signal handling, the r11 might be corrupted
> >> before we retry the syscall leading to a crash. The registers
> >> r0-r13 are not to be used here as they have
> >> volatile/designated/reserved usages. Change the code to use
> >> r14 which is non-volatile and is appropriate for local use in
> >> safe_syscall.
> >>
> >> Steps to reproduce:
> >> On PPC host, issue `qemu-x86_64 /usr/bin/cc -E -`
> >> Attempt Ctrl-C, the issue is reproduced.
> >>
> >> Reference:
> >> https://refspecs.linuxfoundation.org/ELF/ppc64/PPC-elf64abi-1.9.html#R=
EG
> >>
> >> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>
> >> Tested-by: Laurent Vivier <laurent@vivier.eu>
> >> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> >=20
> > Applied to ppc-for-3.0.
>=20
> No please!  r14 is a call-saved register and needs saving before
> clobbering.

Oops, pulled out now.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--O8/n5iBOhiUtMkxf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltartAACgkQbDjKyiDZ
s5LOaw/+Jqop3jwqbZcHsQTQFqX4ysk0xhm2RMdp8BfyuLh+U6/vdBO+eMm5HQpw
ttcRf2Jts6R/T9WKGt5NMBUdiU2Pgul0NQCUkiq0wWoZG6ZStOXoHZDbBkwfVhd7
vf+rxG/HaFJ+ByFvR/8h1cFooXiE8MA3f1Wo4B4zXhOoxBwMjfEGzDj7KGoKYdQ0
LW5bd09atIfFOoKyEr+NQ+yomiDoCkYKkzMML87ni6k09uqksT+Oz0/fc/qOgGQM
VaHK4qoNPF0r3RvC+kxuS0OwbmFKL/lbrqweFe79sRA3gVjxV894i/eBWM2duCir
b4QlC6gZCziQKzHBgyhC2g/iba7jYZn4/sa0PkcFg91G/MA0ysxbBQt7pQ5iZYii
Oud2sumgJL+WRSK9VAXKzxkwcZ2n4FDU+m9S98ZwH0O1icVsNN1KHOxswvl9ICAs
aI4oruYSYsEsTEaPkIWsSn1Q3jcrraRKI7z10NMvkR22AhoaYY0q9e+jDtOCVZ4b
0r96v/t5SHm4UMsFt0LSA2f6OWPMcUR1TOPsI2fLMGVVU7UexFjsqrhXuPkVJ95O
rFzj7Yp22jDVED+Z80+bcBISmXisM1yX7ac3WKwzdqbUtJlIA9R+xsdIHUWfICDc
XeunRE5DKnUHMrfYuIQ/djiS5feaLc7XnRDpVmNT6OzZTudZqn8=
=3UlP
-----END PGP SIGNATURE-----

--O8/n5iBOhiUtMkxf--
