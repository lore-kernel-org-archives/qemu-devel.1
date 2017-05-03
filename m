Received: from eggs.gnu.org ([2001:4830:134:3::10]:48610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d5nRP-0002ej-MS
	for qemu-devel@nongnu.org; Wed, 03 May 2017 02:07:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d5nRL-0007lp-N5
	for qemu-devel@nongnu.org; Wed, 03 May 2017 02:07:11 -0400
Date: Wed, 3 May 2017 15:14:52 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170503051452.GL10741@umbus.fritz.box>
References: <201704212158.v3LLwNYl031738@linux03a.ddci.com>
	<20170426043441.GN16882@umbus.fritz.box>
	<OF2ACF2223.8C7339DB-ON86258115.000819F0-86258115.0008E549@ddci.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cy9Nn4fUvYST66Pl"
Content-Disposition: inline
In-Reply-To: <OF2ACF2223.8C7339DB-ON86258115.000819F0-86258115.0008E549@ddci.com>
Subject: Re: [Qemu-devel] Subject: [PATCH] target-ppc: Add global timer
 group A to open-pic.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alarson@ddci.com
Cc: agraf@suse.de, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--cy9Nn4fUvYST66Pl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 02, 2017 at 08:37:09PM -0500, alarson@ddci.com wrote:
> David Gibson <david@gibson.dropbear.id.au> wrote on 04/25/2017 11:34:41=
=20
> PM:
>=20
> Thanks for the review David.  I'll send an updated patch soon with all
> your comments addressed and all other s/0/NULL or false/ as
> appropriate and a better commit message.
>=20
> Just to clarify my concern; the patch causes the QEMU openpic timer to
> be hard coded at 100MHZ.  This is common, but the openpic spec has
> numerous ways the clock could be driven and the actual frequency
> depends on target board configuration.  Given that no other users are
> apparently using the QEMU openpic timer, it is probably ok, but I did
> want to point out the deficiency.

Ah, ok.  The usual way to handle this is to have the frequency as a
property on the device.  The board code which constructs the openPIC
value can then set it to the appropriate value.

Having an interim step where its hardcoded to 100 MHz is perfectly ok
though.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--cy9Nn4fUvYST66Pl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZCWdMAAoJEGw4ysog2bOSA1oQANswdaX52/f70M9nOytZiVzt
PIU1S17JT1v717OQUsKAmfEge4kXswhSguj//OUY2Oktcmc42pv+3zTjNDGum1g3
X+RVd8qV10b2Rvp/RJimubAd77jemXWSQo62bMVwoJ49sa7VHbmQOCUZ0rkIHfrl
qe3Ys+AeNqTckoO8Wx7xQsYXWXlrW4SVoRanWz6xMCfL1R+UAeWw8Fvy40D/8O5A
p0WWHPuzwKdpky1DSo7KpiZ6gsYotJsEq80X8ez2KHgXDHkKX1AjZZGfxORj53KW
m9hltiHJc4bWD3jhEWjpDYNRO+6pNLGNhLWtLqKUAEt+c5VYu9ruiW7saUYiJYWl
l7LWkBVqarmysikZcxAMBKxc4ov9/n/QUTb23C3GhWic8jy+t4fdyiFpPZKSi4c1
JdyXrg3xUx8Rwa+Hj4r++R8J/GKK2qQ/5Ih7ux/iv9CxktwVVJmRd0uE1d3Bnok6
YoZ5JtKvRZ4ipLH1E2MbGkcrsiQ3m+E+mUM1FicBwsOsCmI+DM3U8ftxyBKnDWVw
eQcxCI69eWxFE0c4nB45Hw4K9fkikht0MET6bNYGcY8Z4NfSFAYeFKvwNZhnCct8
iP5LtDheUrQyqFV/UCwygnLp2SdUQCxsIVEFYUMVgF1g0GYvGCGDukvssU5n61Ew
Jrztwq5hNI22/km6siFu
=zodl
-----END PGP SIGNATURE-----

--cy9Nn4fUvYST66Pl--
