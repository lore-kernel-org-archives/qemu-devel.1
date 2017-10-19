Received: from eggs.gnu.org ([2001:4830:134:3::10]:51697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e59r2-0004dg-Sy
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 08:23:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e59qz-00080a-Ou
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 08:23:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e59qz-00080B-GT
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 08:23:13 -0400
References: <1508170976-96869-1-git-send-email-imammedo@redhat.com>
	<20171016163636.GI11975@redhat.com>
	<20171017092702.5b82103b@nial.brq.redhat.com>
	<20171017150759.GB31897@redhat.com>
	<20171017180635.6a900616@nial.brq.redhat.com>
	<20171018153010.GL9719@redhat.com>
	<20171018202240.GD2942@localhost.localdomain>
	<20171019114954.GC13245@umbus>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <58846850-bbe2-e1c4-2235-58b3f6709ba6@redhat.com>
Date: Thu, 19 Oct 2017 14:23:04 +0200
MIME-Version: 1.0
In-Reply-To: <20171019114954.GC13245@umbus>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JnvLvQI6kSR4pmgvBoCUX44Niv2JJ33mj"
Subject: Re: [Qemu-devel] [RFC 0/6] enable numa configuration before
 machine_init() from HMP/QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Igor Mammedov <imammedo@redhat.com>, peter.maydell@linaro.org, pkrempa@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JnvLvQI6kSR4pmgvBoCUX44Niv2JJ33mj
From: Paolo Bonzini <pbonzini@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <ehabkost@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, peter.maydell@linaro.org,
 pkrempa@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org,
 armbru@redhat.com
Message-ID: <58846850-bbe2-e1c4-2235-58b3f6709ba6@redhat.com>
Subject: Re: [Qemu-devel] [RFC 0/6] enable numa configuration before
 machine_init() from HMP/QMP
References: <1508170976-96869-1-git-send-email-imammedo@redhat.com>
 <20171016163636.GI11975@redhat.com>
 <20171017092702.5b82103b@nial.brq.redhat.com>
 <20171017150759.GB31897@redhat.com>
 <20171017180635.6a900616@nial.brq.redhat.com>
 <20171018153010.GL9719@redhat.com>
 <20171018202240.GD2942@localhost.localdomain> <20171019114954.GC13245@umbus>
In-Reply-To: <20171019114954.GC13245@umbus>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 19/10/2017 13:49, David Gibson wrote:
> Note that describing socket/core/thread tuples as arch independent (or
> even machine independent) is.. debatable.  I mean it's flexible enough
> that most platforms can be fit to that scheme without too much
> straining.  But, there's no arch independent way of defining what each
> level means in terms of its properties.
>=20
> So, for example, on spapr - being paravirt - there's no real
> distinction between cores and sockets, how you divide them up is
> completely arbitrary.

Same on x86, actually.

It's _common_ that cores on the same socket share L3 cache and that a
socket spans an integer number of NUMA nodes, but it doesn't have to be
that way.

QEMU currently enforces the former (if it tells the guest at all that
there is an L3 cache), but not the latter.

Paolo


--JnvLvQI6kSR4pmgvBoCUX44Niv2JJ33mj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlnomSgACgkQv/vSX3jH
roMJDQgAhssWd+Qc28l+1oQDnRleJrOOIVAipnq1V0aJukeljuJpmpvktVgAT7GS
1R+lwsDgWK5qf7RS/9x3HY72DV9bJs+vG7dbucUwSAf64lMAr70bqRgArFTEthFN
v1Jh20ThoHqVCuxtV9usELFno4pnzKzInycCGTYLKAtx+A36wOroyzaMdNx9+tsR
WEjj4hQt30rMmIcZJFTDhhnZV2RVi83KH9RPdY9dlD2dSEER1Dl5Qmmx4O3LN5e8
5SJntIbxFeJSjn7WMwwYnDZAsiCgZzo9y+4143pNk4anrl/0H9PDLohgJu4ppaAN
hfakHq8tGi49We9yAj5gwvbmPDqw8Q==
=Wtee
-----END PGP SIGNATURE-----

--JnvLvQI6kSR4pmgvBoCUX44Niv2JJ33mj--
