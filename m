Received: from eggs.gnu.org ([2001:4830:134:3::10]:39211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cE3GI-00041r-IR
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 19:05:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cE3GH-0001BU-Ag
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 19:05:34 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:59725)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1cE3GG-0001BD-LB
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 19:05:33 -0500
Date: Tue, 6 Dec 2016 10:02:33 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20161205230233.GO32366@umbus.fritz.box>
References: <CAGZKiBoidWDhW6Pp-iQVNWJEkAJjpapAoEJmxA+b7_yf4y58Cw@mail.gmail.com>
	<20161202181631.GH15373@work-vm>
	<CAGZKiBrebbEy9pfWCmN_ztmQZ5gNUZ5Ho_J-oOtyhrYSQPi91A@mail.gmail.com>
	<20161205064453.3996.48049@loki>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="96dIhm/ZjrNld+BP"
Content-Disposition: inline
In-Reply-To: <20161205064453.3996.48049@loki>
Subject: Re: [Qemu-devel] Unable to add ram object with same ID after
 addition, migration and removal at the target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Bharata B Rao <bharata.rao@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>


--96dIhm/ZjrNld+BP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 05, 2016 at 12:44:53AM -0600, Michael Roth wrote:
> Quoting Bharata B Rao (2016-12-04 21:51:32)
> > On Fri, Dec 2, 2016 at 11:46 PM, Dr. David Alan Gilbert <dgilbert@redha=
t.com>
> > wrote:
> >=20
> >     * Bharata B Rao (bharata.rao@gmail.com) wrote:
> >     > Hi,
> >     >
> >     > - Add ram object and dimm device at the source
> >     >
> >     > (qemu) object_add memory-backend-ram,id=3Dram0,size=3D128M
> >     > (qemu) device_add pc-dimm,id=3Ddimm0,memdev=3Dram0
> >     >
> >     > - Migrate the VM and remove the dimm device and ram object at the=
 target
> >     >
> >     > (qemu) device_del dimm0
> >     > (qemu) object_del ram0
> >     >
> >     > - Adding the ram object with same id now at the target fails like=
 this:
> >     >
> >     > (qemu) info memdev
> >     >
> >     > (qemu) object_add memory-backend-ram,id=3Dram0,size=3D128M
> >     > Duplicate ID 'ram0' for object
> >     >
> >     > Same behaviour is seen on x86 and Power. The problem isn't seen if
> >     > migration isn't involved (add, remove, add at the source itself).
> >=20
> >     Is this the same as the one Michael Roth posted a fix for a few days
> >     back; 'monitor: fix object_del for command-line-created objects'
> >=20
> >     https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg05479.html
> >=20
> >=20
> > Yes, this is same as above, I hadn't noticed Michael's fix.
> >=20
> > Will be good to have this fix in 2.8.
>=20
> I considered shooting for 2.8, but since it's only triggerable with HMP
> (QMP doesn't use the QemuOpts-based parsing so it doesn't hit the
> duplicate ID error, so libvirt in turn would be uneffected), and doesn't
> seem to be a regression (AFAICT it's been an issue since object_del was
> introduced), I figured it could wait till 2.9/2.8.1.
>=20
> Definitely a pain for testing though...

How complex is the fix?  If it's simple, then AIUI we can still put
real bugfixes like this into 2.8.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--96dIhm/ZjrNld+BP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYRfIJAAoJEGw4ysog2bOSFtMP/ivL+mwp0N3IMECYFs30QmxU
ABG6rztPxh7KmRzgYooDM1WWgEMgRrx8feFMkC7FAZsBV0oJyapGIgI+863sATgo
aK1N+33L8jWwj0ykJ4fFGHVo/K461zDtWyv9xPsJux1y2Fy1eSaIm6mEGBM8KQS6
tFhIcRJ0ilqWMn0hHNq6oLshkqZBJWj9xGoy8C/Vs2PO3dGwDIm3ohr1H3Dirqfs
Lw2vFGftP82EOYu+VJzQ3NgMG4/1WfP+Y7bLysOj8mEJ1CpQ4fmkAodMSvO8BA41
844ROiAo3WqpV11M3kVnASxPOvOH+uVL+dj4Fw8EJlVmcOB6UeFSJ0LVfNNP4glH
+g03l0JKg/p2OA6GjwyEJsi2bLMaKw+m8of9kPQn34eN6NBiJdyv3jesLQxAiOuw
P9YXGEOg5qzLltNIXgFsE6ezzq59h/xoXntijrcY4w6HF+5jMbIi69OrhnmCdJxK
QJQe8TRAgjhTLuwhdedV/FyLOZnhBQur0ovZMjPu0wFRj1YGjIKw4zEnGhLiQoej
Dt81Mca04aMhT6ppUcI/qYURqMUEhCzvPMjD3iRLxZZN6QxNawLUaTVsl+9GbKAn
xh9SSK5L6scfNGaDFCOvp2NYvTLg9VgkVO9vFHirDudlMWR02CQbopovxSCoplmv
JOzxehcgOMd2ZvMlbGzY
=stdW
-----END PGP SIGNATURE-----

--96dIhm/ZjrNld+BP--
