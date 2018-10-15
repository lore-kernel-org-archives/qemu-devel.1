Received: from eggs.gnu.org ([2001:4830:134:3::10]:39844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gBzoN-0006FW-74
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 06:09:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gBzoL-0002Lf-SS
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 06:09:19 -0400
Date: Mon, 15 Oct 2018 11:08:58 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181015100858.GF6785@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181013050227.17022-1-ehabkost@redhat.com>
	<20181015093243.GE6785@redhat.com>
	<CAFEAcA8MQ37JVCCPGyQa20n6AuU8Sv_pC9DoDoCKdQhqekpGnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>

On Mon, Oct 15, 2018 at 11:02:03AM +0100, Peter Maydell wrote:
> On 15 October 2018 at 10:32, Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om> wrote:
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

FWIW,  I would /not/ object to the iotests directory being converted to
pure py3 only, skipping 2/3 compat, if that made it easier, since it is
not a commonly used thing by most people building QEMU.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
