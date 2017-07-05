Received: from eggs.gnu.org ([2001:4830:134:3::10]:55381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dSf1Q-00010g-NB
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:46:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dSf1P-0004jJ-JP
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:46:52 -0400
Date: Wed, 5 Jul 2017 16:36:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170705063641.GK2180@umbus.fritz.box>
References: <20170704110126.26806-1-lvivier@redhat.com>
	<20170704110126.26806-3-lvivier@redhat.com>
	<20170704131500.3ef448c8@bahia.lan>
	<20170704114151.GG2180@umbus.fritz.box>
	<20170704150239.2e4adb64@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ONvqYzh+7ST5RsLk"
Content-Disposition: inline
In-Reply-To: <20170704150239.2e4adb64@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v4 2/2] target/ppc: move POWER9 DD1
 workaround to init_proc_POWER9()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Laurent Vivier <lvivier@redhat.com>, joserz@linux.vnet.ibm.com, qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, Suraj Singh <sursingh@redhat.com>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Sam Bobroff <sbobroff@redhat.com>


--ONvqYzh+7ST5RsLk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 04, 2017 at 03:02:39PM +0200, Greg Kurz wrote:
> On Tue, 4 Jul 2017 21:41:51 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Tue, Jul 04, 2017 at 01:15:00PM +0200, Greg Kurz wrote:
> > > On Tue,  4 Jul 2017 13:01:26 +0200
> > > Laurent Vivier <lvivier@redhat.com> wrote:
> > >  =20
> > > > Commit 5f3066d ("target/ppc: Allow workarounds for POWER9 DD1")
> > > > disables compatibility mode for POWER9 DD1 to allow to
> > > > boot on POWER9 DD1 host with KVM.
> > > >=20
> > > > As the workaround has been added in kvmppc_host_cpu_class_init(),
> > > > it applies only on CPU created with "-cpu host".
> > > > As we want to be able to use also "-cpu POWER9" on a POWER9 DD1
> > > > host, this patch moves the workaround from kvmppc_host_cpu_class_in=
it()
> > > > to init_proc_POWER9().
> > > >  =20
> > >=20
> > > As with ppc_cpu_initfn() in your previous version, init_proc_POWER9()=
 is
> > > called for every CPU instance.. ie, all CPU will adjust the @pcr_supp=
orted
> > > class attribute... =20
> >=20
> > Ah.. yeah.. I didn't notice that before.  That's definitely not right.
> >=20
> > > What about moving the workaround to ppc_POWER9_cpu_family_class_init()
> > > instead ? This would just require to expose mfpvr() in some header. =
=20
> >=20
> > Yeah, as someone else pointed out using the host PVR is also
> > definitely not right (unless you're in a function specifically
> > connected to the host cpu class).
> >=20
>=20
> I agree but the root issue is that we accept to pass -cpu POWER9 instead =
of
> -cpu host with -enable-kvm. And the host cpu class isn't involved in this
> case.

Well.. it sort of is.  I believe the way we make this work (since
Thomas' cleanup) is that when KVM is active, we alter the alias for
the host cpu's family to point to the host cpu class, instead of
whatever specific version it usually points to.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ONvqYzh+7ST5RsLk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZXIj2AAoJEGw4ysog2bOSL4IP+gPYJ5c8s6vA2LrkSzaYWqRm
PM/qU3B1XaUrwXp6JAdXMwqiLGNX2v1ZySsstP7W0su39FAm7oVPrm8mO5vL/Z9S
Eql68+uaHWkfqNJioW7KEmV0onxe4nX82bE3eXIXV2wUusqyOH5ZI9yY6DRiB+9o
Po8zOT105DLMPfeOIS5DIJws69Id/0hFnHxbWAByMC2F4QGWzJrNMjUJa3U4uokL
dfcYs981t4vw+9FcieE6YVzZCWOfjZoBbBX/uIQLheAYh677MFM68USdh5T1tQvN
lXlgs1F9oMRj+aQ37cwXFrxwoVStIQRyE1mwBKWkfJo7Xan42CdR/ZRvOaoOC9LT
9VE2c3iyo2o2MfqhDy1EollRSLCes+e2QBqMrMfrKBMnfdYqR3CkErOVC7KTxp6J
TyY+Uh4/E2h4MHWBP2Noyef9g2wwXok9bcH3WmVAYmZwgvbG+XLrkyb7DlytV7mP
+GhJieEk8rM26fN5zQArt5N/fcLktGpPhwnacTR8fV5bOdHZWx0qC0jC83/7q/pT
9OkvtaLpyPPlJgF0DMMJfcVB5oLJzgHoH9uprGkObpbTyFcsuvHLWd/2JAqCa6Ap
wu8zlYwrczMlzQMbqs3hSUfykrIPiaQcouXq5rwcsJNydh62jXGFXclcBJm0otYU
RX5UUOc2KrQCzF0MMvin
=KZqu
-----END PGP SIGNATURE-----

--ONvqYzh+7ST5RsLk--
