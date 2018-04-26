Received: from eggs.gnu.org ([2001:4830:134:3::10]:59578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fBj5f-00030w-5w
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:45:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fBj5b-0006vR-VH
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:45:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38716 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1fBj5b-0006vJ-Nq
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:45:43 -0400
Date: Thu, 26 Apr 2018 17:45:39 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180426174539.020fdf55.cohuck@redhat.com>
In-Reply-To: <38a11e73-bb46-873c-b452-feed630b7325@redhat.com>
References: <20180426135755.GI29865@localhost.localdomain>
	<dffa77fa-11d7-5f3c-4c1e-7ed25a55fa25@redhat.com>
	<20180426141400.GM26812@redhat.com>
	<20180426142236.GJ29865@localhost.localdomain>
	<38a11e73-bb46-873c-b452-feed630b7325@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
To: Thomas Huth <thuth@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Daniel P. =?UTF-8?B?QmVycmFu?=
	=?UTF-8?B?Z8Op?=" <berrange@redhat.com>, Yash Mankad <ymankad@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>, =?UTF-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>

On Thu, 26 Apr 2018 16:25:40 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 26.04.2018 16:22, Eduardo Habkost wrote:
> > On Thu, Apr 26, 2018 at 03:14:00PM +0100, Daniel P. Berrang=C3=A9 wrote=
: =20
> >> On Thu, Apr 26, 2018 at 04:09:55PM +0200, Thomas Huth wrote: =20
> >>> On 26.04.2018 15:57, Eduardo Habkost wrote: =20
> >>>> (Starting a new thread, for more visibility)
> >>>>
> >>>> (This was: Re: [Qemu-devel] [RFC PATCH] tests/device-introspect: Test
> >>>> devices with all machines, not only with "none")
> >>>>
> >>>> On Thu, Apr 26, 2018 at 01:54:43PM +0200, Markus Armbruster wrote: =
=20
> >>> [...] =20
> >>>>> I don't mind having make check SPEED=3Dslow run more extensive test=
s.
> >>>>> Assuming we actually run them at least once in a while, which seems
> >>>>> doubtful. =20
> >>>>
> >>>> We probably don't do that, but we really must be running a more
> >>>> extensive (and slower) test set at least once before every
> >>>> release.
> >>>>
> >>>> Maybe some people are running SPEED=3Dslow tests, or even more
> >>>> extensive test suites like avocado-vt once in a while, but we
> >>>> need to know who is running them, and when. =20
> >>>
> >>> At least I am running "make check SPEED=3Dslow" manually from time to
> >>> time, especially when we enter the hard freeze period. =20
> >>
> >> Hmm, we could get this done by travis. It has the concept of "cron job=
s"
> >> for scheduling builds separately from pushes.
> >>
> >> So we could keep the current travis jobs unchanged, but then add an
> >> use of SPEED=3Dslow when TRAVIS_EVENT_TYPE =3D=3D "cron" in the travis=
.yml,
> >> so we can get SPEED=3Dslow run once a day. Just have to be careful whi=
ch
> >> jobs we make slow so we don't hit the 50 minute timeout. =20
> >=20
> > I expect SPEED=3Dslow tests to eventually take longer than 50
> > minutes, but we can try this and see what happens. =20
>=20
> I already had to move some of the slow tests to SPEED=3Dslow mode in the
> past due to the travis timeouts (which are hit when the machines are
> very loaded), so my guess is that SPEED=3Dslow will hardly work with trav=
is.

Do we have another automation infrastructure for that, preferably with
multiple host architectures? I usually run SPEED=3Dslow before I send a
pull request, on s390x and x86 -- unless I forget it. (I really should
script my procedure. Some time.)
