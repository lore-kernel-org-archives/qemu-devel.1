Received: from eggs.gnu.org ([2001:4830:134:3::10]:37272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dGgcn-0008DE-Dv
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 03:03:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dGgcm-0000s6-4f
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 03:03:57 -0400
Date: Fri, 2 Jun 2017 13:24:37 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170602032437.GK13397@umbus.fritz.box>
References: <20170601015218.9299-1-david@gibson.dropbear.id.au>
	<20170601015218.9299-2-david@gibson.dropbear.id.au>
	<149633261057.3207.5755197867144524820@loki>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="T4Djgzn3z2HSNnx0"
Content-Disposition: inline
In-Reply-To: <149633261057.3207.5755197867144524820@loki>
Subject: Re: [Qemu-devel] [PATCH 1/4] spapr: Move DRC RTAS calls into
 spapr_drc.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: lvivier@redhat.com, nikunj@linux.vnet.ibm.com, sursingh@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, bharata@linux.vnet.ibm.com


--T4Djgzn3z2HSNnx0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 01, 2017 at 10:56:50AM -0500, Michael Roth wrote:
> Quoting David Gibson (2017-05-31 20:52:15)
> > Currently implementations of the RTAS calls related to DRCs are in
> > spapr_rtas.c.  They belong better in spapr_drc.c - that way they're clo=
ser
> > to related code, and we'll be able to make some more things local.
> >=20
> > spapr_rtas.c was intended to contain the RTAS infrastructure and core c=
alls
> > that don't belong anywhere else, not every RTAS implementation.
> >=20
> > Code motion only.
>=20
> Technically rtas-get-sensor-state and rtas-set-indicator aren't specific
> to DRCs, but looking through the documented indicators/sensors (tables
> 40 and 42 in LoPAPR v11) it doesn't seem too likely we'll ever implement
> any others so the move seems reasonable.

True, I realised that a little after I posted.

Even if we did implement other sensors, though, the natural way to
split this would be to have the generic set-indicator function check
simply that the indicator is a DR related one, and pass the options
straight to a function in the DRC code, rather doing preliminary
looking into DRC internals as it does now.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--T4Djgzn3z2HSNnx0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZMNp1AAoJEGw4ysog2bOS498P+wUuoumhhKky/vwXZkeos3JF
3sD7M6WcoWh1KwbLLlb27/HFBFpRbU095LjWHAfwY7Tyi1zU1ktsIdw0iAPLSUeF
i/hZDJN35vU2jxrr9MT2U2Ak0vozYkhFa6OQbMMlC4miyLAdbk/8PN61lh69d9MJ
Bt1augQ5Vt67HzV+c8xrQZsNULRNOUO3xVmFfvQGUJYDjq92je17W9Ptx/AARWd9
zNrq6UGyen6Vbk03dIcSKjYkzX39tU6KIbhYYwibuUjWTrPCfI+aalb6qi/J9Tvy
WOad+4z8NEnHm1q5Wi4p8jAEwc7u85VaEDYDRHy/GOlp/G7AnPhQMnzHVVYwyv2P
jDSSyN/vAhUWGKae479510T5TXncpzrCNcHxRAyjXyqza1QpUoAVMKIRxocwuwJw
wnrsCbOLfqi+CK9tXKrnPC2+HtP/P8EcTu/w1haCvgLPgHhK+uGwzoq9elDma6Gr
V0od3xQxvOOBNlUtbYcn3LvSa5Myi1vuGcGQK0DZykYaRXkZiyz9it5ImjFKNga2
j3HtgjYpDiyM6f95m+KD035LhS3awrAO+XoX/nmr7WvwhQz6kLiXnTyLkCQ1T1+P
l3yUwjM/wtCmWEYuBgBUqbQ8X/9PChAwE8Ncx/BwXE4Ry5MW/qYkM38cz092yGUu
DJ11ipmBZ2sdujpsnxxz
=Kywt
-----END PGP SIGNATURE-----

--T4Djgzn3z2HSNnx0--
