Received: from eggs.gnu.org ([2001:4830:134:3::10]:57512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dE7lP-0001mu-RL
	for qemu-devel@nongnu.org; Fri, 26 May 2017 01:26:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dE7lO-0008LT-TC
	for qemu-devel@nongnu.org; Fri, 26 May 2017 01:26:15 -0400
Date: Fri, 26 May 2017 15:26:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170526052606.GK12929@umbus.fritz.box>
References: <20170524121048.10067-1-lvivier@redhat.com>
	<87k2555sl2.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/rDaUNvWv5XYRSKj"
Content-Disposition: inline
In-Reply-To: <87k2555sl2.fsf@secure.mitica>
Subject: Re: [Qemu-devel] [PATCH] migration: remove register_savevm()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, rnsastry@linux.vnet.ibm.com, Bharata B Rao <bharata@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Jason Wang <jasowang@redhat.com>, Dmitry Fleytman <dmitry@daynix.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, qemu-ppc@nongnu.org, Samuel Thibault <samuel.thibault@ens-lyon.org>, sam.bobroff@au1.ibm.com, Peter Xu <peterx@redhat.com>


--/rDaUNvWv5XYRSKj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 25, 2017 at 09:00:25AM +0200, Juan Quintela wrote:
> Laurent Vivier <lvivier@redhat.com> wrote:
> D> We can replace the four remaining calls of register_savevm() by
> > calls to register_savevm_live(). So we can remove the function and
> > as we don't allocate anymore the ops pointer with g_new0()
> > we don't have to free it then.
> >
> > Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>=20
> Reviewed-by: Juan Quintela <quintela@redhat.com>
>=20
> As this is needed for Power, letting them go through their tree.

Thanks for the ack, I've put this into my ppc-for-2.10 tree.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/rDaUNvWv5XYRSKj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZJ7xsAAoJEGw4ysog2bOSd5cP/1L7EG2Wh9rieMZdxnAkf86v
XQmwQ7pVqc1drByEB4aucM3fNzd+YDruNVEZaCaIxJ/seu084D9/0jAp3iZ0bUQF
/dpPlxtjuZY4vxbcHET8rtnSy2CYIIcuDnPcIUhI+KV1F37ppGX7lM1AOrLEBfCp
iQCABkqzqgq3yNlCWlHBg2A3jI0ekjdRihjbBNTD+WZ8z3nRtJbX6Sx6ILWs4cdZ
rrtvJLqAIINAx6lgMZIB2Lk/zuqpHzqvs7peo1+kc4Lt76qx97MXJN1noBbWS7nJ
Pgf5VWP9oxIhIVJFLPbCcrRgEFOuu7aTYPFtFqPdnKA1c3jt5Fn5xwM/GUImZJ+s
MWlK3yaPvTvFieGNM2ev/bIY1E92ZLjo/ETPpfC5HLrcTQ8ZVvktwPixQkWUM/vJ
LlyHVJEF2gZ+Q/vNXSjc9tSLaGupcw2L1evUMsv8wYf0EXXhX8FaQK2iUr3RT9wT
5B9TIJPlw9jJrmzqoM+Pz2wxM375bQPtNh498wOZOz3pqFPdCGUULxvf08s+0um6
9WB1xO4UPOsuJI9yyNjSEyCTYy/lMlujdtpABc6kMPbe98vCBopqMC3m3jKBsrUS
0wOckuWYZOPFYzVdGLFBbtjlbV5UnnRbXx1X2dcZWMYBAZ8PB+z1kGLJCUIxb3OJ
JZQPkEVuT5bMoM6YBg6g
=qeXA
-----END PGP SIGNATURE-----

--/rDaUNvWv5XYRSKj--
