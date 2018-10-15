Received: from eggs.gnu.org ([2001:4830:134:3::10]:41529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gBzsc-0000Hc-Fc
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 06:13:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gBzsb-00065X-LW
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 06:13:42 -0400
Date: Mon, 15 Oct 2018 12:13:09 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181015101309.GD10459@localhost.localdomain>
References: <20181013050227.17022-1-ehabkost@redhat.com>
	<20181015093243.GE6785@redhat.com>
	<CAFEAcA8MQ37JVCCPGyQa20n6AuU8Sv_pC9DoDoCKdQhqekpGnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAFEAcA8MQ37JVCCPGyQa20n6AuU8Sv_pC9DoDoCKdQhqekpGnQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC] Require Python 3 for building QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

Am 15.10.2018 um 12:02 hat Peter Maydell geschrieben:
> On 15 October 2018 at 10:32, Daniel P. Berrang=E9 <berrange@redhat.com>=
 wrote:
> > On Sat, Oct 13, 2018 at 02:02:27AM -0300, Eduardo Habkost wrote:
> >> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> >> ---
> >> I'd like to do this in QEMU 3.1.  I think it's time to drop
> >> support for old systems that have only Python 2.
> >>
> >> We still have a few scripts that are not required for building
> >> QEMU that still work only with Python 2 (iotests being the most
> >> relevant set).  Requiring Python 3 for building QEMU won't
> >> prevent people from using those scripts with Python 2 until they
> >> are finally ported.
> >
> > I think it is premature & unecessary to do this. We just got QEMU bui=
lding
> > with dual Python2/3 in 3.0 to give people leeway in the migration pat=
h to
> > a fully v3 future. The code to support building 2/3 in parallel is no=
t
> > imposing a unreasonable maint burden. Dropping py2 suport would have
> > negligible impact on the code, as there's no v3-only features we have
> > used. IOW, I don't think there's a compelling reason to rush into for=
cing
> > users onto v3.
> >
> > If we want to drop py2, we should give people a warning of such a pla=
nned
> > change, especially since some of our targetted host OS[1] don't even
> > include a py3 as standard without acquiring extra add-on repos. Devs =
in
> > a typical corporate env will not have the freedom to install such ext=
ra
> > repos on their machines.
>=20
> I agree. I also think that dropping python 2 support before we've
> even converted all our python scripts to handle python 3 is the
> wrong order to do things. People interested in moving forward with
> the transition to python-3-only should start by making sure everything
> we have works with python 3...

It's easier to port stuff to Python 3 though than making them work with
both. I think Eduardo's RFC is in part motivated by a patch from
Philippe that converted something in iotests to work with Python 3,
passed review and then turned out to break Python 2.

Having to test every iotests patch twice with different Python versions
isn't something I would like to do for extended periods of time.

Kevin
