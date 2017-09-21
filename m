Received: from eggs.gnu.org ([2001:4830:134:3::10]:55032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dv6yL-0003gE-LZ
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 15:17:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dv6yI-0001rS-GQ
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 15:17:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60776)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dv6yI-0001qM-4W
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 15:17:14 -0400
References: <1506014941-31076-1-git-send-email-peter.maydell@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f794478b-b73f-60d4-0c0f-0ad1c0e2f20b@redhat.com>
Date: Thu, 21 Sep 2017 14:17:10 -0500
MIME-Version: 1.0
In-Reply-To: <1506014941-31076-1-git-send-email-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LNfXr0dteXagbHWJb2eg9NufjAarHc8lk"
Subject: Re: [Qemu-devel] [PATCH v2] docs/devel/loads-stores.rst: Document
 our various load and store APIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, patches@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LNfXr0dteXagbHWJb2eg9NufjAarHc8lk
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 patches@linaro.org
Message-ID: <f794478b-b73f-60d4-0c0f-0ad1c0e2f20b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] docs/devel/loads-stores.rst: Document our
 various load and store APIs
References: <1506014941-31076-1-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1506014941-31076-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/21/2017 12:29 PM, Peter Maydell wrote:
> QEMU has a wide selection of different functions for doing
> loads and stores; provide some overview documentation of
> what they do and how to pick which one to use.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Changes v1->v2: filled in most of the gaps thanks to the
> comments on v1.
>=20
> I have left some TODO markers in where they represent
> fixes we should ideally make to the API. Since this
> is for-developers internals documentation I think it's
> OK to leave those in.
>=20
> I found I was referring back to my v1 patch and the replies
> to it quite a bit recently, so I think it would be nice to
> get it into the tree.
>=20
> The major question I have left is about the license text
> to apply to this...

> +   Copyright (c) 2017 Linaro Limited
> +   Written by Peter Maydell
> +   TODO: do we have a standard doc license? bitmaps.rst
> +   uses the FreeBSD documentation license, I notice.

The default GPLv2+ seems okay to me for something for internal use, but
of course, if you want something looser like FreeBSD docs, I'm also fine
with that (as it's not the first use in the tree).

> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Load and Store APIs
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +QEMU internally has multiple families of functions for performing
> +loads and stores. This document attempts to enumerate them all
> +and indicate when to use them. It does not provide detailed
> +documentation of each API -- for that you should look at the
> +documentation comments in the relevant header files.
> +
> +
> +``ld*_p and st_*p``

Difference in placement of * vs. _ - is it intentional?

> +
> +``cpu_{ld,st}_*``
> +~~~~~~~~~~~~~~~~~
> +
> +These functions operate on a guest virtual address. Be aware
> +that these functions may cause a guest CPU exception to be
> +taken (eg for an alignment fault or MMU fault) which will

Do we care about the formal spelling "e.g." ?

> +
> +``cpu_{ld,st}_*_ra``
> +~~~~~~~~~~~~~~~~~~~~
> +
> +Thes functions work like the ``cpu_{ld,st}_*`` functions except

s/Thes/These/

> +that they also take a ``retaddr`` argument. This extra argument
> +allows for correct unwinding of any exception that is taken,
> +and should generally be the result of GETPC() called directly
> +from the top level HELPER(foo) function (ie the return address

Again, is "i.e." better?

> +
> +``helper_*_{ld,st}*mmu``
> +~~~~~~~~~~~~~~~~~~~~~~~~
> +

> +
> +``address_space_*``
> +~~~~~~~~~~~~~~~~~~~
> +

> +
> +``{ld,st}*_phys``
> +~~~~~~~~~~~~~~~~~

> +
> +``cpu_physical_memory_*``
> +~~~~~~~~~~~~~~~~~~~~~~~~~
> +

> +``cpu_physical_memory_write_rom``
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +

> +
> +``cpu_memory_rw_debug``
> +~~~~~~~~~~~~~~~~~~~~~~~
> +

> +
> +``dma_memory_*``
> +~~~~~~~~~~~~~~~~
> +

> +``pci_dma_*`` and ``{ld,st}*_pci_dma``
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +

Lots of cool stuff in there!

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--LNfXr0dteXagbHWJb2eg9NufjAarHc8lk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnEEDYACgkQp6FrSiUn
Q2oCMwf/aStFOedoym/lBsKR0dC6xtay//IkYTvBkEBaHuWWEdRF/Dg5fcjLiw/6
/WF900Mk5A8vD/0D6P8dpGQGuohyRoxEW2FPcScV7VcD++bejIYA8oP7GIsXcpbq
/LBBzVZtUEbecs80hPcjA5zf3VNXiezq23xw4wx+pG0euPd74m69wu6y5nvEdTUX
e3xwDj/Zr0yZop6Pj5rC7VJLbS6lEzeKtnAeHbuZ+EHqrJm4LRTp2TSCmJ3qif3n
7nMf/o2pSP2j3eCHwXRm16gx9AH7+Ka8+3RyGGAH1y3GmmEbqZB7bOWNSveXZCPP
KX89mr3ug0rTd7AmF/O8Q0fhrELHXg==
=giEl
-----END PGP SIGNATURE-----

--LNfXr0dteXagbHWJb2eg9NufjAarHc8lk--
