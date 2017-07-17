Received: from eggs.gnu.org ([2001:4830:134:3::10]:47383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dX4zg-000814-O5
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:19:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dX4zf-0005Ea-PV
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:19:20 -0400
Date: Mon, 17 Jul 2017 14:19:10 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170717121910.GG5301@noname.redhat.com>
References: <CAPuOgO2q9nNtoPOYuXSWDxBVVsXcWEMbMboLT4OdpXA_Dq5O=Q@mail.gmail.com>
	<7a891962-9c57-7668-e2fd-69e5e13b9078@redhat.com>
	<CAMr-obtga00C5cKS63T_5RW99hK2W1nKMDba4cnTGH8dVYrXaA@mail.gmail.com>
	<07dfafaa-884c-9b86-cf37-dbdc454d2b91@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <07dfafaa-884c-9b86-cf37-dbdc454d2b91@redhat.com>
Subject: Re: [Qemu-devel] Supporting unsafe create when backing file is not
 accessible
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Nir Soffer <nirsof@gmail.com>, Ala Hino <ahino@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-discuss@nongnu.org, Nir Soffer <nsoffer@redhat.com>, John Snow Huston <jsnow@redhat.com>


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 17.07.2017 um 13:36 hat Eric Blake geschrieben:
> On 07/14/2017 02:13 PM, Nir Soffer wrote:
> > Eric, we are more concerned about using the current qemu version.
> >=20
> > We can use the fact that providing both size and backing format,
> > qemu does not open the backing file, but this is not documented, and
> > we don't want to base oVirt code on undocumented behavior.
> >=20
> > What we would like to have is:
> > - qemu blessing for using this undocumented behaviour
>=20
> But how are you going to get that? By the time someone writes a
> documentation patch, it won't land until qemu 2.10, but by then, they
> might as well have written the -u patch instead.

In fact, soft freeze is tomorrow, so if we want to have -u in 2.10, it
would be good to have a patch ready today.

> Older versions will continue to have the older behavior, unless someone
> backports a patch to give them the newer behavior - but if someone is
> backporting -u, presumably they will also backport whatever
> introspection mechanisms you would also use against upstream qemu to
> learn if -u is present.  If the introspection mechanism is not present
> or gives the answer that -u is not present, then you can safely assume
> the old behavior (because the new behavior is only going to be present
> intentionally).  But that is STILL not something that we are going to
> explicitly document, because it makes more sense to implement the
> working feature than to document the workaround to a missing feature.

While I think adding -u today is reasonably realistic, I'm doubtful that
we can get an introspection mechanism in place today. Perhaps we can
declare it a bug fix, but I'd rather not rush something like that.

How does libvirt detect qemu-img features today? Just try and then check
the error message?

Kevin

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZbKs+AAoJEH8JsnLIjy/WCnkP/2jKpJ55AN74iwYI3g4wTPw9
EjFWRhQGehJPcowuvaNVIYeBwy98NjlhAMDz5CtNzGusHrfxhsd2P2tuA5XjT8AG
pfmMRUKWHYsXggCL/E/th/GKJp5teJLgMcnjR/e4708gWaGEdUPteWTCGTc1mHzi
kT98eHnEBXyBQn1yM7SOQmphREE1lb16rB5/hb6LpiQAR0p8/UeK2OFwzguZ88vL
UyYeIpEQ5JlgPz3wQ0hiL+6j1juKfv5OQ5FzY4H3tK16+zpBse8vw6weGRBW+4L5
jIIQlnh23DmXCXlrq3Sqeg7Y/DxgIUzZdLjrc9SgYRVC7KjFVZom2ieaOSXuJ28+
wYDWCJLrzXFI6AqGqQxGovzByvuDggkjJaZD9EB51fgRQ3k/+5Lnn1O+uwuojrUl
JVbLXkk3Cqxw9PnACfsJDnekQn1vsd06MZpFYZiSH3rbveju2YIqOUVldQOOdH+s
QNV9S2HkOyXr9qWyvst8fbTOSsqRWpv2Wof0Ioq6yEb6+YvMI2bBqLC0jGe1wsNm
Q8pMZSRT7MdrdP8/jYRbnFMjukEANjJixJh5cqIUysLarreroMPb7mt04dn2CQ1Y
OtkzCMM9JPfK+78Fe38q8CqY+HECwkZz9TVKqw0HrIUqLQgF8tLHGzgLoF2fCN6S
Qwt1YC+VHlC9j7dkiR1s
=zO4T
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
