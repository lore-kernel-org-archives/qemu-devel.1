Received: from eggs.gnu.org ([209.51.188.92]:49761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1grHeW-0002vR-G6
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 02:29:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1grHeS-00009v-Ak
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 02:29:46 -0500
Date: Wed, 6 Feb 2019 08:29:11 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190206072911.urbbsuzxogkzj5sf@sirius.home.kraxel.org>
References: <20190129175403.18017-1-philmd@redhat.com>
	<20190129175403.18017-10-philmd@redhat.com>
	<CAFEAcA_ejg0yPkBZ_0-mgM5zgMHKqKe3SDGX0wMZ-neYC_Oy0A@mail.gmail.com>
	<e5dd8130-e041-7774-2141-cc506dee99f7@redhat.com>
	<94f74717-0bab-ea0a-e7cc-239a1b1136bf@comstyle.com>
	<e8177680-28fc-1213-a8f7-a3b94ef92e15@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <e8177680-28fc-1213-a8f7-a3b94ef92e15@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 09/18] tests/vm/openbsd: Install Bash
 from the ports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: Brad Smith <brad@comstyle.com>, Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <fam@euphon.net>, "Michael S. Tsirkin" <mst@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>

On Tue, Feb 05, 2019 at 03:23:53PM +0100, Philippe Mathieu-Daud=E9 wrote:
> Hi Brad,
>=20
> On 2/5/19 2:57 PM, Brad Smith wrote:
> > If someone could point me in the right direction as to how the image =
is
> > created
> > I could look at coming up with something newer. I would prefer that o=
ver
> > some
> > of the workarounds I've seen to date.
>=20
> I'm not an OpenBSD user, so I'm more than happy if you can help the
> upstream community to test QEMU codebase on this OS. Testing helps us t=
o
> avoid code rot.
>=20
> What we currently use to run tests is the 'tests/vm/openbsd' script.
> The script itself doesn't document how it was built, but looking at the
> commit of his introduction fdfaa33291eb we have:

There also is a patch floating around to auto-install openbsd:
	https://patchwork.kernel.org/patch/10749459/

Not fully sure why this wasn't merged yet.  One problem is that this
patch depends on a new slirp feature (added in the 3.1 devel cycle,
needed to serve install.conf via http).  Which blocked merge during the
3.1 cycle, because depending on unreleased qemu for test builds isn't a
good idea.  But 3.1 is released, so maybe we can merge that for 4.0 now?

The openbsd installer trying to fetch install.conf not only via http but
also via tftp would also simplify things, maybe implementing that is an
option for the next openbsd release?

cheers,
  Gerd
