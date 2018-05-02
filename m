Received: from eggs.gnu.org ([2001:4830:134:3::10]:42356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fDnxL-0001pW-5l
	for qemu-devel@nongnu.org; Wed, 02 May 2018 05:21:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fDnxH-000568-W1
	for qemu-devel@nongnu.org; Wed, 02 May 2018 05:21:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45370 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1fDnxH-00055u-PH
	for qemu-devel@nongnu.org; Wed, 02 May 2018 05:21:43 -0400
Date: Wed, 2 May 2018 11:21:30 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180502112130.77b7f70a.cohuck@redhat.com>
In-Reply-To: <CAG7hfc+rXFSHE7P4dA-2YhSnW1fXmsaK4zT6n9yCf+a_ALxm1A@mail.gmail.com>
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
	<20180430103312.GH3249@redhat.com>
	<20180430132107.0a37704d.cohuck@redhat.com>
	<ac216b06-9469-addd-b5a1-3a3a89fd0782@redhat.com>
	<20180502093326.2fbec55f.cohuck@redhat.com>
	<CAG7hfcKo62hpq-qkVE8_+pR1R6uQKcG_FuNuNo1yGqGV-6oazQ@mail.gmail.com>
	<20180502075904.GF3308@redhat.com>
	<CAG7hfcKEiNfLR0xW6b2FPFAN1L4xs81ozPXZAZAs=+Wzs6Q2Vw@mail.gmail.com>
	<de11d2a4-3bd0-42e3-5bff-79c160e9c5df@redhat.com>
	<CAG7hfc+rXFSHE7P4dA-2YhSnW1fXmsaK4zT6n9yCf+a_ALxm1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] release retrospective, next release timing,
 numbering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liviu Ionescu <ilg@livius.net>
Cc: Thomas Huth <thuth@redhat.com>, "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

On Wed, 2 May 2018 02:03:14 -0700
Liviu Ionescu <ilg@livius.net> wrote:

> On 2 May 2018 at 11:13:49, Thomas Huth (thuth@redhat.com) wrote:
>=20
> > https://qemu.weilnetz.de/doc/qemu-doc.html#Deprecated-features =20
>=20
> Thank you, Thomas.
>=20
> > It took quite a while to get a consensus on that policy, so I don't
> > think that we want to sacrifice that for semver. =20
>=20
> ok, this might be a point.
>=20
> thinking twice, I'm not sure it is a real sacrifice; I think that the
> problem here is the strict definition:
>=20
> "The feature will remain functional for 2 releases prior to actual remova=
l."
>=20
> if it were:
>=20
> "The feature will remain functional for _at least_ 2 releases prior to
> actual removal.=C2=A0"
>=20
> or even better:
>=20
> "The feature will remain functional for _at least_ 2 _major_ releases
> prior to actual removal. "
>=20
>=20
> it would allow to postpone incompatible removals to relatively seldom
> major releases, add new features during more often minor releases, and
> fix bugs during regular patch releases.

Ugh, no. That would mean we have to drag around ill-conceived
interfaces for way too long.

>=20
> major releases can be scheduled every 1-2 years, for example, minor
> releases every 3-6 months, and patch releases when needed.
>=20
>=20
> from a use perspective, I don't think that updating the deprecation
> policy would be objected, so that would not be perceived as a
> sacrifice; on the contrary,=C2=A0such a mechanism would allow both a
> faster/flexible release cycle, and give the users a more educated
> guess when it is time to upgrade; both beneficial.

How on earth is that supposed to speed things up?

And really, time to upgrade is either "bugs have been fixed", "a
feature I want has been introduced", or "my distro pushed a new
package". Not a magic number.

>=20
> for the developers/maintainers... I agree that it would require some
> more discipline and responsibility.

I just don't see any benefits from that.

>=20
> not to mention that even before semver, in most versioning schemes it
> was somehow expected that while the first version number remains the
> same, compatibility is more or less preserved.

I don't like semver. For development as it is done in many projects
today, you're just doing incremental updates all the time, probably
with a stable branch on the side. Meaningful version numbers just get
us to stupid discussions about what is a bugfix, what a minor feature,
and what a major feature.

IOW, I think *any* versioning scheme that does not assign
interface/feature expectations to version numbers (beyond "a suffix
means a stable update" or something like that) is what would work for
us.
