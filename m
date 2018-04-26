Received: from eggs.gnu.org ([2001:4830:134:3::10]:60739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fBhnG-00060e-K4
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 10:22:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fBhnD-00044g-G2
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 10:22:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fBhnD-00042n-93
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 10:22:39 -0400
Date: Thu, 26 Apr 2018 11:22:36 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180426142236.GJ29865@localhost.localdomain>
References: <20180426135755.GI29865@localhost.localdomain>
	<dffa77fa-11d7-5f3c-4c1e-7ed25a55fa25@redhat.com>
	<20180426141400.GM26812@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180426141400.GM26812@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Who is running QEMU automated tests, and when?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Yash Mankad <ymankad@redhat.com>, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, Markus Armbruster <armbru@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>

On Thu, Apr 26, 2018 at 03:14:00PM +0100, Daniel P. Berrang=E9 wrote:
> On Thu, Apr 26, 2018 at 04:09:55PM +0200, Thomas Huth wrote:
> > On 26.04.2018 15:57, Eduardo Habkost wrote:
> > > (Starting a new thread, for more visibility)
> > >=20
> > > (This was: Re: [Qemu-devel] [RFC PATCH] tests/device-introspect: Te=
st
> > > devices with all machines, not only with "none")
> > >=20
> > > On Thu, Apr 26, 2018 at 01:54:43PM +0200, Markus Armbruster wrote:
> > [...]
> > >> I don't mind having make check SPEED=3Dslow run more extensive tes=
ts.
> > >> Assuming we actually run them at least once in a while, which seem=
s
> > >> doubtful.
> > >=20
> > > We probably don't do that, but we really must be running a more
> > > extensive (and slower) test set at least once before every
> > > release.
> > >=20
> > > Maybe some people are running SPEED=3Dslow tests, or even more
> > > extensive test suites like avocado-vt once in a while, but we
> > > need to know who is running them, and when.
> >=20
> > At least I am running "make check SPEED=3Dslow" manually from time to
> > time, especially when we enter the hard freeze period.
>=20
> Hmm, we could get this done by travis. It has the concept of "cron jobs=
"
> for scheduling builds separately from pushes.
>=20
> So we could keep the current travis jobs unchanged, but then add an
> use of SPEED=3Dslow when TRAVIS_EVENT_TYPE =3D=3D "cron" in the travis.=
yml,
> so we can get SPEED=3Dslow run once a day. Just have to be careful whic=
h
> jobs we make slow so we don't hit the 50 minute timeout.

I expect SPEED=3Dslow tests to eventually take longer than 50
minutes, but we can try this and see what happens.

--=20
Eduardo
