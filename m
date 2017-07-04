Received: from eggs.gnu.org ([2001:4830:134:3::10]:59357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dSK70-0003fe-Dl
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:27:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dSK6z-0003KW-Gy
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:27:14 -0400
Date: Tue, 4 Jul 2017 19:27:01 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170704092701.GD2180@umbus.fritz.box>
References: <20170703131455.25424-1-lvivier@redhat.com>
	<20170703131455.25424-3-lvivier@redhat.com>
	<fe1a3b5f-2811-3776-b777-4ae025bf74a1@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VV4b6MQE+OnNyhkM"
Content-Disposition: inline
In-Reply-To: <fe1a3b5f-2811-3776-b777-4ae025bf74a1@redhat.com>
Subject: Re: [Qemu-devel] [RFC v3 2/2] target/ppc: move POWER9 DD1
 workaround to ppc_cpu_initfn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, joserz@linux.vnet.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Suraj Singh <sursingh@redhat.com>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Sam Bobroff <sbobroff@redhat.com>, Greg Kurz <groug@kaod.org>


--VV4b6MQE+OnNyhkM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 04, 2017 at 10:17:18AM +0200, Thomas Huth wrote:
> On 03.07.2017 15:14, Laurent Vivier wrote:
> > Commit 5f3066d ("target/ppc: Allow workarounds for POWER9 DD1")
> > disables compatibility mode for POWER9 DD1 to allow to
> > boot on POWER9 DD1 host with KVM.
> >=20
> > As the workaround has been added in kvmppc_host_cpu_class_init(),
> > it applies only on CPU created with "-cpu host".
> > As we want to be able to use also "-cpu POWER9" on a POWER9 DD1
> > host, this patch moves the workaround from kvmppc_host_cpu_class_init()
> > to ppc_cpu_initfn().
>=20
> Would it be feasible to move it to init_proc_POWER9() instead? I think
> that would be a better location for the POWER9 workaround ... not sure
> whether it can be done there, though.

That would be neater if it works.  I've applied the patch as is for
now, but if that does work, a follow up to move the workaround would
be nice.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VV4b6MQE+OnNyhkM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZW19lAAoJEGw4ysog2bOSQFwP/1iyAFNEcc4t7GTAr/IamdYj
ITuiwWms5YskkPpFe0qQgi2+gDKGWAtJzGnM5zp52K+kEwy5UDCjlqxYyl1QArra
2Fqgr+wMPh7YZzCAP0ftmwsNjLvoTtaco/rtkWax96vC1HtI5bxT9x/eGcC6nJlX
+o/VHI8H4WrAi1chxq2gt5Lh5hVkHo+mgCe/rJ8VdkRifWdcfblmYHLhnIWAoHB7
k+Lls81jm/wtHT2XQMqh3xZJRkXzdn1jWqUkAAdGQXsYGzSy5zOX2oMgbXLvLA9K
PW4VM+QhOfDqCqtU8sjNB29zzxUit+HXI330PBVYblu9+cP5bOjK80UNA7CFa/cJ
Rw51CjT7DyCerb2DFigsSwDLh5E0B8qoyT+9pSbfSjZA/6GFnRJBcqXmxlNDnj8D
wiLI5XUZturOBwsZnPDFBFRbpk0rpQqm21zqwclfVeYhMfvLVpcsLNte73vad5hF
8/r++2T+fIbgQTh0Xk0qrkZf3Rf6VuaAZ2fv7PrHJSc4MVvcpGd6v9WP6s09c27T
D3h4zWjObc0gR9thNf96PJZLdN/Z/hDLVI3D3jLMNeL45ZTdgqpVpDAWrEzwTUgV
bUyJwI2a9nARAWU86qFuwRVUpoECkkSZCyd5UQUMylSJdeRiG8PrPlssmFOTEsvk
OHgOs7HIH8buhfBupew+
=yEM7
-----END PGP SIGNATURE-----

--VV4b6MQE+OnNyhkM--
