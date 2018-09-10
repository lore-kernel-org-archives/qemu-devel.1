Received: from eggs.gnu.org ([2001:4830:134:3::10]:33671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fzDpr-000288-Lh
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 00:30:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fzDm5-0005yt-79
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 00:26:10 -0400
Date: Mon, 10 Sep 2018 14:25:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180910042551.GB24181@umbus.fritz.box>
References: <20180907073155.26200-1-david@gibson.dropbear.id.au>
	<20180907073155.26200-2-david@gibson.dropbear.id.au>
	<2ae5af64-c452-9d7d-ea81-6d9035a30697@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
Content-Disposition: inline
In-Reply-To: <2ae5af64-c452-9d7d-ea81-6d9035a30697@redhat.com>
Subject: Re: [Qemu-devel] [PULL 01/14] ppc: Remove deprecated ppcemb target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: peter.maydell@linaro.org, lvivier@redhat.com, Thomas Huth <thuth@redhat.com>, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 07, 2018 at 08:39:52AM -0500, Eric Blake wrote:
> On 09/07/2018 02:31 AM, David Gibson wrote:
> > From: Thomas Huth <thuth@redhat.com>
> >=20
> > There is no known available OS for ppc around anymore that uses page
> > sizes below 4k, so it does not make much sense that we keep wasting
> > our time on building and testing the ppcemb-softmmu target. It has
> > been deprecated since two releases, and nobody complained, so let's
> > remove this now.
> >=20
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
>=20
> > +++ b/qapi/common.json
> > @@ -146,6 +146,6 @@
> >     'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm32=
',
> >                'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
> >                'mips64el', 'mipsel', 'moxie', 'nios2', 'or1k', 'ppc',
> > -             'ppc64', 'ppcemb', 'riscv32', 'riscv64', 's390x', 'sh4',
> > +             'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
> >                'sh4eb', 'sparc', 'sparc64', 'tricore', 'unicore32',
> >                'x86_64', 'xtensa', 'xtensaeb' ] }
>=20
> Can we also get documentation that this was deleted (probably as a follow=
up,
> since I'm only now noticing this in the pull request)?  See QKeyCode in
> qapi/ui.json for an example of documenting 'altgr: dropped in 2.10'

So, it turns out Peter isn't able to process pull requests until late
september, so I guess we can fix it inline after all.  I've now done
so.

Since I won't be resending the pull request for a while, you can
review the new version at:

https://github.com/dgibson/qemu/commit/9de3048e22f73824cc1920db17f7a166ef81=
5090


--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluV8k0ACgkQbDjKyiDZ
s5JZmxAAkHUrZ93Kep5IGkpBrUWwVKfik9lbkaIeDLkpgvyyEJPEjKHmPO2Z/5hN
xJN6UcK5om9y1gHUST0kY8F/Rx3t4k/L32eH1Nub/A3kpR/wehRJ1THkb61f74VZ
uqVuYlwSsgZ2tRHeeLWquvJu4krbz70X65lE4vYzo1sZDVg4MeWs2RCmCWivn/Bd
Q00CerHr9mok+7nVQlfG2LZ/5bsDfFdKAwzYR35mUm181T/EPy3MnjMi3Qym4Cb2
H3A37fM8+UYoKOIWdNWqci/sR9LEzmiP3cNtzbqF6SXmKLrRmxjZSKlbm/OhabtB
ZNu+BpYO7hJPrh5wi3GZy7Dzu16MoZXGeC5kZm6uO7fdVzHQMld2bWH/wMLJubdx
LexKw7qOGMkmEgRiZlw7HHADbuptld+P93EohxjPiS/zqIv1OwotSen6XSsgLtqp
apacQBypei4IwImufNeYgPzNRDT9pTHbnBxZkm8NQGi2VewA44BVAxqdfs73Tchv
NLHOqzFDfHpEnSH+UplLAdaIhYLSK9pD00/ekpX3FYKI2+UBgUGyjD4VtAOkC13P
/qS5tuBQZfarQT9lXl+RoNX6tqgt9Ve6lJJLz0eM3ePDG+R0URnfiIgeucd07ekI
hjHOsKBGKHfUao3Q+CgfC+8o7YXkbuFXFhePLokd3BQpwTnbla4=
=DEGm
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--
