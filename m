Received: from eggs.gnu.org ([2001:4830:134:3::10]:38557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ilg@livius.net>) id 1fDnfT-0004JI-Sm
	for qemu-devel@nongnu.org; Wed, 02 May 2018 05:03:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ilg@livius.net>) id 1fDnfP-0002em-Qw
	for qemu-devel@nongnu.org; Wed, 02 May 2018 05:03:19 -0400
Received: from mail-yb0-x22d.google.com ([2607:f8b0:4002:c09::22d]:42601)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ilg@livius.net>) id 1fDnfP-0002eV-LC
	for qemu-devel@nongnu.org; Wed, 02 May 2018 05:03:15 -0400
Received: by mail-yb0-x22d.google.com with SMTP id 140-v6so5016791ybc.9
	for <qemu-devel@nongnu.org>; Wed, 02 May 2018 02:03:15 -0700 (PDT)
From: Liviu Ionescu <ilg@livius.net>
In-Reply-To: <de11d2a4-3bd0-42e3-5bff-79c160e9c5df@redhat.com>
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
	<20180430103312.GH3249@redhat.com>
	<20180430132107.0a37704d.cohuck@redhat.com>
	<ac216b06-9469-addd-b5a1-3a3a89fd0782@redhat.com>
	<20180502093326.2fbec55f.cohuck@redhat.com>
	<CAG7hfcKo62hpq-qkVE8_+pR1R6uQKcG_FuNuNo1yGqGV-6oazQ@mail.gmail.com>
	<20180502075904.GF3308@redhat.com>
	<CAG7hfcKEiNfLR0xW6b2FPFAN1L4xs81ozPXZAZAs=+Wzs6Q2Vw@mail.gmail.com>
	<de11d2a4-3bd0-42e3-5bff-79c160e9c5df@redhat.com>
MIME-Version: 1.0
Date: Wed, 2 May 2018 02:03:14 -0700
Message-ID: <CAG7hfc+rXFSHE7P4dA-2YhSnW1fXmsaK4zT6n9yCf+a_ALxm1A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cohuck@redhat.com>

On 2 May 2018 at 11:13:49, Thomas Huth (thuth@redhat.com) wrote:

> https://qemu.weilnetz.de/doc/qemu-doc.html#Deprecated-features

Thank you, Thomas.

> It took quite a while to get a consensus on that policy, so I don't
> think that we want to sacrifice that for semver.

ok, this might be a point.

thinking twice, I'm not sure it is a real sacrifice; I think that the
problem here is the strict definition:

"The feature will remain functional for 2 releases prior to actual removal.=
"

if it were:

"The feature will remain functional for _at least_ 2 releases prior to
actual removal.=C2=A0"

or even better:

"The feature will remain functional for _at least_ 2 _major_ releases
prior to actual removal. "


it would allow to postpone incompatible removals to relatively seldom
major releases, add new features during more often minor releases, and
fix bugs during regular patch releases.

major releases can be scheduled every 1-2 years, for example, minor
releases every 3-6 months, and patch releases when needed.


from a use perspective, I don't think that updating the deprecation
policy would be objected, so that would not be perceived as a
sacrifice; on the contrary,=C2=A0such a mechanism would allow both a
faster/flexible release cycle, and give the users a more educated
guess when it is time to upgrade; both beneficial.

for the developers/maintainers... I agree that it would require some
more discipline and responsibility.

not to mention that even before semver, in most versioning schemes it
was somehow expected that while the first version number remains the
same, compatibility is more or less preserved.


regards,

Liviu
