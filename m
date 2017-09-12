Received: from eggs.gnu.org ([2001:4830:134:3::10]:58113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1drnh2-0007F9-O4
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:05:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1drngy-0005oH-LY
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:05:44 -0400
Date: Tue, 12 Sep 2017 18:05:27 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170912180527.1f0e80b5.cohuck@redhat.com>
In-Reply-To: <4374d570-cee8-5f82-7187-dcb7bf57bf55@redhat.com>
References: <20170905151614.31303-1-cohuck@redhat.com>
	<20170905151614.31303-3-cohuck@redhat.com>
	<20170908110425.GC3283@localhost.localdomain>
	<20170908132439.3ab53d7d.cohuck@redhat.com>
	<20170908115414.GF3283@localhost.localdomain>
	<4374d570-cee8-5f82-7187-dcb7bf57bf55@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] iotests: use -ccw on s390x for 051
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, haoqf@linux.vnet.ibm.com, qemu-block@nongnu.org, david@redhat.com, agraf@suse.de, qemu-devel@nongnu.org, borntraeger@de.ibm.com, mreitz@redhat.com, =?UTF-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>

On Fri, 8 Sep 2017 17:55:29 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 08.09.2017 13:54, Kevin Wolf wrote:
> > Am 08.09.2017 um 13:24 hat Cornelia Huck geschrieben: =20
> >> On Fri, 8 Sep 2017 13:04:25 +0200
> >> Kevin Wolf <kwolf@redhat.com> wrote:
> >> =20
> >>> Am 05.09.2017 um 17:16 hat Cornelia Huck geschrieben: =20
> >>>> The default cpu model on s390x does not provide zPCI, which is
> >>>> not yet wired up on tcg. Moreover, virtio-ccw is the standard
> >>>> on s390x, so use the -ccw instead of the -pci versions of virtio
> >>>> devices on s390x.
> >>>>
> >>>> Provide an output file for s390x.
> >>>>
> >>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> >>>> ---
> >>>>  tests/qemu-iotests/051                     |   9 +-
> >>>>  tests/qemu-iotests/051.s390-ccw-virtio.out | 434 ++++++++++++++++++=
+++++++++++
> >>>>  2 files changed, 442 insertions(+), 1 deletion(-)
> >>>>  create mode 100644 tests/qemu-iotests/051.s390-ccw-virtio.out   =20
> >>>
> >>> It's already a pain to have two separate output files for 051, let's =
try
> >>> to avoid adding a third one. Even more so since I think that the split
> >>> between 051.out and 051.pc.out was already made for s390, so I'm not
> >>> sure if anyone would actually still make use of the plain 051.out
> >>> output if s390 got it's own one. =20
> >>
> >> Are there no non-pc and non-s390 machines for which this is run? =20
> >=20
> > Who knows? But I'm not aware of anyone who is interested in something
> > else and has contributed to the test cases until now. =20
>=20
> FWIW, as far as I know, Luk=C3=A1=C5=A1 is running this test also on ppc6=
4 in our
> weekly regression run. So it would be good to keep that working, please :=
-)
>=20
> >> Another approach would be to drop the -pci postfix, but I don't want to
> >> introduce more usage of aliases. =20
> >=20
> > Maybe that would indeed be the easiest way. As long as we don't intend
> > to remove the alias from qemu, there's no reason not to use it in tests=
. =20
>=20
> Maybe we should even use it in a couple of places on purpose - so we get
> some test coverage for them?

FWIW, using the the sed post-run filtering works well for 051, but it
is driving me bonkers on 067 (or maybe I should just call it a day...)

We could use the sed approach for 051 and the alias approach on 067 -
that way we would also test aliases :)

Any preferences by the iotest maintainers?

[I'd be happy if iotests worked again on s390x...]
