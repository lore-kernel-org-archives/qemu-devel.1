Received: from eggs.gnu.org ([2001:4830:134:3::10]:54824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d959W-0004Ew-Cb
	for qemu-devel@nongnu.org; Fri, 12 May 2017 03:38:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d959S-0001oj-91
	for qemu-devel@nongnu.org; Fri, 12 May 2017 03:38:18 -0400
Date: Fri, 12 May 2017 17:33:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170512073313.GB15313@umbus.fritz.box>
References: <20170427072843.8089-1-david@gibson.dropbear.id.au>
	<1493908379.4214.8.camel@redhat.com>
	<20170504212237.341bf8ef@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Content-Disposition: inline
In-Reply-To: <20170504212237.341bf8ef@bahia>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCHv3 0/4] Clean up compatibility
 mode handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Andrea Bolognani <abologna@redhat.com>, clg@kaod.org, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, armbru@redhat.com


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 04, 2017 at 09:22:37PM +0200, Greg Kurz wrote:
> On Thu, 04 May 2017 16:32:59 +0200
> Andrea Bolognani <abologna@redhat.com> wrote:
>=20
> > On Thu, 2017-04-27 at 17:28 +1000, David Gibson wrote:
> > > This is a rebased and revised version of my patches revising CPU
> > > compatiblity mode handling on ppc, last posted in November.=A0=A0Since
> > > then, many of the patches have already been merged (some for 2.9, some
> > > since).=A0=A0This is what's left.
> > >=A0
> > >=A0=A0* There was conceptual confusion about what a compatibility mode
> > >=A0=A0=A0=A0means, and how it interacts with the machine type.=A0=A0Th=
is cleans
> > >=A0=A0=A0=A0that up, clarifying that a compatibility mode (as an exter=
nally set
> > >=A0=A0=A0=A0option) only makes sense on machine types that don't permi=
t the
> > >=A0=A0=A0=A0guest hypervisor privilege (i.e. 'pseries')
> > >=A0
> > >=A0=A0* It was previously the user's (or management layer's) responsib=
ility
> > >=A0=A0=A0=A0to determine compatibility of CPUs on either end for migra=
tion.
> > >=A0=A0=A0=A0This uses the compatibility modes to check that properly d=
uring an
> > >=A0=A0=A0=A0incoming migration. =20
> >=20
> > I started playing with this, mostly with libvirt integration
> > in mind of course, and quickly ran into a behavior that I
> > believe was not intentional and unfortunately managed to slip
> > into 2.9, I assume through the patches which were initially
> > part of this series (mentioned above).
> >=20
> > More specifically, when I run a guest with
> >=20
> > =A0 -M pseries-2.8 -cpu host
> >=20
> > using QEMU 2.8, the CPU in the guest is reported as
> >=20
> > =A0 POWER8E (raw), altivec supported
> >=20
> > However, when using QEMU 2.9 with the very same command line,
> > including explicitly using the pseries-2.8 machine type, I
> > get
> >=20
> > =A0 POWER8 (architected), altivec supported
> >=20
>=20
> The goal of this series is indeed to switch from raw to architected but I
> agree that it shouldn't affect existing machine types. This probably calls
> for some compat prop.

So, I have mixed feelings about this.

1. Yes, the series was intended to switch from preferring raw to
preferring architected mode.

2. No, it shouldn't have affected older machine types - I didn't think
that through.

But, having made the mistake, I'm not sure it's worth correcting.  I
don't actually expect this to break guests, and fixing it now that
it's already there will be messy, and raises the possibility of new
behavioural change between older and newer subversions of 2.9.


--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZFWU2AAoJEGw4ysog2bOSzHYP+wXLzdZdp5WVxuVo0p5D3GZ+
osBCEdFanyoWPe9hYTFqdg9EmQi1lQ4KZmF+8VBDy8Ze78ZDJNS4PCC3ikpD7S+7
NEvxUfToMgJo8NbGtG+ROlkpn0nLHcxa8SqEtioLUnfKZxEOJDaUoKmRNZScCzr5
VIuZCnZ/c+xlRjjOPh2yMpcXhnIvhxF6kmyvUgEW2MIceMoKJscfQ7JRZfqBc0ay
R80gwCGuOsCqf6LBJXirrzABPblDmM/fmkMAI3D8VrTwd5iobDoasGJBLcA5roHk
UVdG0bjee2USeIqLgURvhncKzH5hmlkSiKyFlKtNGX6Afl+1ZfRhzSJx7CBPi8DM
Ns04IfCzwHPA2s8QTkACNuGGcl9TskeJX5K6CbHTxvN95h0fJ0CfYjXXUWuZS1rX
G9cbyUd9jQyOk9XsyNor7AXP/U6QlCdSvoq9lFOODCnsDfDli5bwOOMiafi1+6Sx
xyXH7P97G5+RtQTv5zi5qGgb0ygdlDfY6zdc2F8TYMLe55w38IKb7IYAZ3NfBQ5D
PaL4OVDkmeMk/RPqaY3ksEOMpHHECRxv4hwaFHLSdPfqAczJqGu/YB89qIf5I/TV
l9Kf+8rFbKTxOH8e6bnrLDKehejXLDhdfdtZQpIlLfJBKmvJDAgJVvqZGaUsJ1RV
vVPEnARCjcQ9HcmhwzQc
=NwAx
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--
