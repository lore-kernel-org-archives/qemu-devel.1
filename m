Received: from eggs.gnu.org ([2001:4830:134:3::10]:45182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1zQH-0005bS-78
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 14:38:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1zQD-00069e-1k
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 14:38:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e1zQC-00068s-Nw
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 14:38:28 -0400
References: <1507655662-28101-1-git-send-email-peter.maydell@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7a42f603-6d05-3abc-1b18-b29e3b71f712@redhat.com>
Date: Tue, 10 Oct 2017 13:38:25 -0500
MIME-Version: 1.0
In-Reply-To: <1507655662-28101-1-git-send-email-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vs1ASIbQuDXpDPi41uwwqOJ3IHgrI8Jab"
Subject: Re: [Qemu-devel] [PATCH v3] docs/devel/loads-stores.rst: Document
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
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vs1ASIbQuDXpDPi41uwwqOJ3IHgrI8Jab
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7a42f603-6d05-3abc-1b18-b29e3b71f712@redhat.com>
Subject: Re: [PATCH v3] docs/devel/loads-stores.rst: Document our various load
 and store APIs
References: <1507655662-28101-1-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1507655662-28101-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/10/2017 12:14 PM, Peter Maydell wrote:
> QEMU has a wide selection of different functions for doing
> loads and stores; provide some overview documentation of
> what they do and how to pick which one to use.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Changes v2->v3: fixed the typos noticed by Eric;

well, most of them. :)

> dropped the note about license in favour of using the
> default gpl2+. I think this is ready to commit now.

With the remaining nits fixed,

Reviewed-by: Eric Blake <eblake@redhat.com>

> +``ld*_p and st*_p``
> +~~~~~~~~~~~~~~~~~~~

> +``endian``
> + - ``he`` : host endian
> + - ``be`` : big endian
> + - ``le`` : little endian
> +
> +(except for byte accesses, which have no endian infix).
> +
> +The ``_{endian}`` infix is omitted for target-endian accesses.
> +

Is the parenthetical paragraph necessary, given the next paragraph, and
given that you have a similar statement later on for ``{ld,st}*_phys``
without needing the parenthetical?

> +
> +``cpu_{ld,st}_*_ra``
> +~~~~~~~~~~~~~~~~~~~~
> +
> +Thes functions work like the ``cpu_{ld,st}_*`` functions except

s/Thes/These/

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--vs1ASIbQuDXpDPi41uwwqOJ3IHgrI8Jab
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlndE6EACgkQp6FrSiUn
Q2pQwQf/fiYlyKAGa9FUgzy28ZQb7FT+HSW5UdmNpaMrN8q5CvA3Zjr4EHljSvGg
XswwwHUFWxYhajDY/XlpCVejGslepobdOnBc0JmeNa8ft1fKWgP/iFSTF8BJN780
/fC4ENY0AItTpe50rkCTg8vBNmxaCqpfTmprs9IJh1qjiJATYhmDhnhmCWIOlvWr
zzVXzA2v4f8xtbPFCSO+lkF15sJg0uV5x/+mFUSSuDWdQXol2/tDqsya3OEhnAHt
HB8rbKLd1TS+4O9Gsr8gSl0Z7HFbzZ27SYfX4ARUR3UWK1WSHruqLjUSjhRKShCr
RprXanTtoxxNANxTEaCqq9w5Getohg==
=X7jj
-----END PGP SIGNATURE-----

--vs1ASIbQuDXpDPi41uwwqOJ3IHgrI8Jab--
