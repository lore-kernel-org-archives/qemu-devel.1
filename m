Received: from eggs.gnu.org ([2001:4830:134:3::10]:38564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cJpoW-0002nR-C6
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 17:56:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cJpoT-0007wa-9k
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 17:56:48 -0500
Date: Thu, 22 Dec 2016 09:43:26 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20161221224326.GB14282@umbus.fritz.box>
References: <20161215061128.30792-1-david@gibson.dropbear.id.au>
	<1482160529.3732.2.camel@redhat.com>
	<20161219234717.GG23176@umbus.fritz.box>
	<1482225561.3732.12.camel@redhat.com>
	<20161221045245.GE13024@umbus.fritz.box>
	<1482309497.3732.30.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Content-Disposition: inline
In-Reply-To: <1482309497.3732.30.camel@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCHv3 for-2.9 0/6] HPT resizing for
 pseries guests (qemu part)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>
Cc: paulus@samba.org, sjitindarsingh@gmail.com, lvivier@redhat.com, thuth@redhat.com, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 21, 2016 at 09:38:17AM +0100, Andrea Bolognani wrote:
> On Wed, 2016-12-21 at 15:52 +1100, David Gibson wrote:
> > > > I'm not sure if we need a knob.=A0=A0I think in general enabling for
> > > > pseries-2.9 and later machine types is correct.=A0=A0The difficulty=
 is
> > > > that for HV guests, we can only enable it if the host kernel also h=
as
> > > > support.=A0=A0Explicitly setting "resize-hpt=3Denable" means qemu w=
ill not
> > > > start if the kernel doesn't support it.
> > >=A0
> > > I thought that would be the case for resize-hpt=3Drequired,
> > > not resized-hpt=3Denabled.
> >=A0
> > resize-hpt=3Denabled requires the host to support resizing, but not the
> > guest.=A0=A0resize-hpt=3Drequired requires both the host and the guest =
to
> > support resizing.
> >=A0
> > If you can think of a less ambiguous word for it, let me know.
>=20
> The name makes sense, we just need to document the host
> kernel requirement properly. The error message should of
> course mention it as well.

The error message is currently

"Hash page table resizing not available with this KVM version"

Does that cover it?

> > > Moreover, do you foresee any situation in which users
> > > might reasonably want to turn the feature off even though
> > > the entire stack (host kernel, QEMU, guest kernel)
> > > understands it?
> >=A0
> > Nothing clearly compelling.=A0=A0In the nearish term, being able to turn
> > it off to isolate possible bugs could be useful of course.=A0=A0It's al=
so
> > possible that you could have a VM where the latency of each resize
> > could be too much downtime - although in that case I doubt you'd want
> > to hotplug memory anyway.
>=20
> It seems like the use case would be fairly narrow, if it
> existed at all. Given that, I think we should avoid adding
> yet another knob to libvirt until its value can be
> unquestionably proven.

I tend to agree.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYWwWOAAoJEGw4ysog2bOS90MQALyhduEPiPtxlk1tfrTVIjcT
uicIStlzd+nCHawVaENMdrAzfMfblCweU6jalCnjQeq8+38thSqHy49oXVtf3S0B
DkYwnPOZXVIvzxTLbE7o6Cz+uMgqLjywoaubgfHqJpTVHhy5pyNqsVYeXYvk5XHP
BcZVpXJWeCm6gf/uQQ3jhqsbda3dTc9jEHZVb9Va6ocvcL8gH0vZsIqqvCG3jsNr
iKTFy33ka5/8e0nMymWrlnmDFJZJKGteHgtkQHeWO8nl3wbgZVX5JZXjmpdN5aSm
BAHVj4twt1n9Lw7ryvAnA30oA9TlRXgJNrO0QanBiskvxssBTUJxu2gi52jICpGb
gQiezafeD27q1EInqpDI78MwytMlgUmkr+UtlRnIEKzZ/fcKuyZd/46alUJ6ikZd
Kb3EpVefYIr0sglhFzeuaMkm77akN3ef3Vd94huBE9Zz+GSShx7pWu11PCGPUZTz
whIF1DaFNnqfD5dlewSy1TR4jtmEZBxW1Hfki7WQv7iEwiHKjmhSh35J/yOMld/E
EXFjyLGvAaYx4YNF0x9f6NdY/CIx5qjqslen3RiYKh2OHqrurSizHFynbdurreRl
7suvvuHQyzKSJFT/JyZKh40Dx8q1iZANx9uX2VHYaE6cMYKg0qmYtRwxPhdOGwDj
s3crfmPmNjfhQVoGnFSJ
=e6bi
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--
