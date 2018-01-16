Received: from eggs.gnu.org ([2001:4830:134:3::10]:36612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebFxR-0001Nw-Vh
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 20:22:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebFxN-0006cq-UY
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 20:22:33 -0500
Date: Tue, 16 Jan 2018 12:19:35 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180116011935.GA30352@umbus.fritz.box>
References: <1516008655-31732-1-git-send-email-thuth@redhat.com>
	<CAFEAcA8X+p=oWWBTquGjceZJVEfcD8eWDxdZnRe=jVaL7t+LEA@mail.gmail.com>
	<e83d019b-2a88-f4e4-4be8-79f93731b549@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <e83d019b-2a88-f4e4-4be8-79f93731b549@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 0/2] Clean up the ppc default
 configs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2018 at 03:42:09PM +0100, Thomas Huth wrote:
> On 15.01.2018 14:01, Peter Maydell wrote:
> > On 15 January 2018 at 09:30, Thomas Huth <thuth@redhat.com> wrote:
> >> (off-topic question: Do we still need a separate ppcemb-softmmu nowada=
ys?
> >> It seemed to be useful 10 years ago when everybody was doing KVM on
> >> embedded PPC, but these days seem to be pretty much over now, so IMHO
> >> just using ppc-softmmu for embedded should be enough nowadays? We could
> >> save quite some compilation- and "make check"-time if we could finally=
 get
> >> rid of ppcemb-softmmu again...)
> >=20
> > There are some specific differences guarded by TARGET_PPCEMB, like
> > the way it has a different TARGET_PAGE_BITS value, and some code
> > in target/ppc/kvm.c related to telling KVM about interrupts. You
> > would need to make those all be runtime decisions I assume.
>=20
> True ... but while we maybe could turn those into runtime checks, I now
> rather think it's maybe better to go the other way round: Maybe we
> should not include each and everything into ppc64-softmmu, but put the
> embedded stuff only in ppcemb-softmmu and the 32-bit stuff only in
> ppc-softmmu instead? That way we could, for example, also make the
> output of "-cpu help" and "-device help" a little bit more user friendly.=
=2E.

I tend to agree.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpdUyQACgkQbDjKyiDZ
s5JmoA//eyk9grjPfVMiVlxccGTIvLDoWlq2uq6TnT4fUiQQKSfe6Q4Ep5dlWGPD
5PN7EGi3g6eUjQ4/UJZTmjeJIzTg8oUp8RwZzvUPDeCBPDdIdU+4Gbc2awhT+pBx
gKEnMFOPNapv9YKzjKDTWZiQ4woqjl3OgHz/lBxFJAOd1Vi426CLF41lqUKwvIWs
4//tuz2+LjmLTQ7aBsAp4UYqBUUVwKWCQsh/j14BTlqwv2srhpNNpwtd0ap4EgX5
fFU49AACI6ZIHrYBwlWwzj4iTwK5v0RP9xtXBRZgfpJRfeZako6ggX4XuHJM7PAT
dL8m3q5FiNeCUUq/T7hRJxm7U7JGwJjNp+cGpFOFfbxRIRzIsKcDqcvaDu9OC6nK
n+xwllByTaMkh48y2X1Vpwd5rtOKskwXC3kLCGhCj7vkRNKGEjm09GFn29a0OTsw
kASjnTG9G+djIts9TrGIhKTr+JDiek9ioP+FZw7mNaUxRjAoI1J0t0x916uwynlk
uPovocMZU6MPLlssisSbZ2kTNh6M/1bOKSGxMKH4QgXqaWdC5qE75lC1eMuZP4hx
XFUc3yjIg8SkKeUj74nhjuQiVCC0adxlvUBqfDoQ2hx0Gt2IEfwiHPfQntZyMq9G
Av7ZiEE+9HO46yHExiFLI6mHgR3+oA6QLoIUh4gazJ8IAvVskH8=
=4LkD
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
