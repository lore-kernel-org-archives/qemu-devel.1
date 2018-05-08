Received: from eggs.gnu.org ([2001:4830:134:3::10]:60872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fFzMH-0003aE-Q5
	for qemu-devel@nongnu.org; Tue, 08 May 2018 05:56:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fFzME-0002eu-CI
	for qemu-devel@nongnu.org; Tue, 08 May 2018 05:56:33 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:43682)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fFzME-0002eF-12
	for qemu-devel@nongnu.org; Tue, 08 May 2018 05:56:30 -0400
Received: by mail-wr0-x22a.google.com with SMTP id v15-v6so31618835wrm.10
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 02:56:29 -0700 (PDT)
Date: Tue, 8 May 2018 10:56:27 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180508095627.GB19710@stefanha-x1.localdomain>
References: <20180426135755.GI29865@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Content-Disposition: inline
In-Reply-To: <20180426135755.GI29865@localhost.localdomain>
Subject: Re: [Qemu-devel] Who is running QEMU automated tests, and when?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Yash Mankad <ymankad@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 26, 2018 at 10:57:55AM -0300, Eduardo Habkost wrote:
> (Starting a new thread, for more visibility)
>=20
> (This was: Re: [Qemu-devel] [RFC PATCH] tests/device-introspect: Test
> devices with all machines, not only with "none")
>=20
> On Thu, Apr 26, 2018 at 01:54:43PM +0200, Markus Armbruster wrote:
> > Thomas Huth <thuth@redhat.com> writes:
> > > On 17.04.2018 14:12, Markus Armbruster wrote:
> > >> Thomas Huth <thuth@redhat.com> writes:
> > >>=20
> > >>> Many device introspection crashes only happen if you are using a
> > >>> certain machine, e.g.:
> > >>>
> > >>> $ ppc-softmmu/qemu-system-ppc -S -M ref405ep,accel=3Dqtest -qmp std=
io
> > >>> {"QMP": {"version": {"qemu": {"micro": 50, "minor": 11, "major": 2},
> > >>>  "package": "build-all"}, "capabilities": []}}
> > >>> { 'execute': 'qmp_capabilities' }
> > >>> {"return": {}}
> > >>> { 'execute': 'device-list-properties',
> > >>>   'arguments': {'typename': 'macio-newworld'}}
> > >>> Unexpected error in qemu_chr_fe_init() at chardev/char-fe.c:222:
> > >>> Device 'serial0' is in use
> > >>> Aborted (core dumped)
> > >>>
> > >>> To be able to catch these problems, let's extend the device-introsp=
ect
> > >>> test to check the devices on all machine types. Since this is a rat=
her
> > >>> slow operation, the test is only run in "SPEED=3Dslow" mode.
> > >>=20
> > >> If the device works with one machine type, it has a decent chance to
> > >> work with others, too.  Thus, testing each device with every machine
> > >> type is overkill.  I appreciate having overkill as an option :)
> > >>=20
> > >> What I'd like to see for a quick "make check" is testing each device
> > >> once.  That should flush out most bugs. =20
> > >
> > > That's already done with the "none" machine.
> >=20
> > I was too terse.  We test each device with -machine none for every
> > target.  Fine if that's quick enough.  If not, we might want to reduce
> > redundancy there.
> >=20
> > Actually, a worse offender in the "waste everybody's time via redunancy"
> > department could be qom-test.
> >=20
> > > Anyway, do you think my patch here is useful and has a chance of gett=
ing
> > > included? I.e. shall I re-spin this as a non-RFC patch? Or shall we
> > > rather wait for Eduardo's python-based tests to get included into the
> > > repository?
> >=20
> > I don't mind having make check SPEED=3Dslow run more extensive tests.
> > Assuming we actually run them at least once in a while, which seems
> > doubtful.
>=20
> We probably don't do that, but we really must be running a more
> extensive (and slower) test set at least once before every
> release.
>=20
> Maybe some people are running SPEED=3Dslow tests, or even more
> extensive test suites like avocado-vt once in a while, but we
> need to know who is running them, and when.
>=20
> Today, the only test set I know people really run and would
> surely block a release is "make check [SPEED=3Dquick]".
>=20
> So, for anybody that runs automated QEMU tests once in a while,
> can we know:
>=20
> * What test cases are you running?  Where can we get more
>   information about the tests you run?
> * When do you run them?  What triggers a new test run?

I manually run qemu-iotests on release candidates:

 $ (cd tests/qemu-iotests && ./check && ./check -qcow2)

The goal is to identify test failures that still need to be addressed
before the release is made.

I think Kevin Wolf and John Snow have also been running qemu-iotests to
eliminate regressions during the freeze.

Stefan

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa8XRLAAoJEJykq7OBq3PIYKcH/jzQQncuOJ4Ch3XVVzrJwiqY
QFmWwi70r+dK6hKHFRUfHOeP+oe48oxf1S/PLtk+hrfnIMnAJEmgzAJ52cS/+Fpi
1wUK0T/HbKi/i4TjaXLb1cOUTqnibTPkuusJ7zhoiedKIvUhOTOdpFy/x7smFU2i
68/uMacaCH1s/QBnqbllUuyzdUT4z972QsNz+pYcS5hWFMXlgxxQERIoN7FxYDXn
20e7Q6etT2dhgnhXA/TJ5g4HWHJMA2ML5zZTl091Cl8rejFmwHMlNIe0k71Z6TPu
sxRrzG0W/QNVfUfvFrPuJnKHD9OZ09QnSXyXTCleIYIKPLgyFTnPf0x+fClnKSg=
=5huA
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--
